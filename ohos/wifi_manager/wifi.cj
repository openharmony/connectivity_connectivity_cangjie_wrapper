/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package ohos.wifi_manager

import ohos.business_exception.BusinessException
import ohos.callback_invoke.{ Callback1Argument, CallbackObject }
import ohos.ffi.*
import ohos.hilog.*
import ohos.labels.APILevel

import std.collection.{HashMap, ArrayList}
import std.deriving.Derive

let LOGGER = HilogChannel(0, 0xD001560, "CJ-wifi")

/**
 * Query the Wi-Fi status
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2501000 - Operation failed.
 * @relation function isWifiActive(): boolean
 */
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public func isWifiActive(): Bool {
    var ret = false
    let code = unsafe { FfiWifiIsWifiActive(inout ret) }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
        throw BusinessException(err[0], "isWifiActive failed: ${err[1]}")
    }
    ret
}

/**
 * Obtain the scanned station list. If does't have the permission of ohos.permission.GET_WIFI_PEERS_MAC, return random bssid.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2501000 - Operation failed.
 * @relation function getScanInfoList(): Array<WifiScanInfo>
 */
@!APILevel[
    21,
    permission: "ohos.permission.GET_WIFI_INFO",
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public func getScanInfoList(): Array<WifiScanInfo> {
    var code = 0i32
    var arr: Array<WifiScanInfo> = Array<WifiScanInfo>()
    unsafe {
        let ret = FfiWifiGetScanInfoList(inout code)
        if (code != SUCCESS_CODE) {
            ret.free()
            let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
            throw BusinessException(err[0], "getScanInfoList failed: ${err[1]}")
        }
        try {
            arr = cArr2cjArr<CWifiScanInfo, WifiScanInfo>(ret.size, ret.head) {
                ct => WifiScanInfo(ct)
            }
        } finally {
            ret.free()
        }
    }
    arr
}

/**
 * Initiate a P2P connection to a device with the specified configuration.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 * @relation function p2pConnect(config: WifiP2PConfig): void
 */
@!APILevel[
    21,
    permission: "ohos.permission.GET_WIFI_INFO",
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public func p2pConnect(config: WifiP2PConfig): Unit {
    let ct = CWifiP2PConfig(config)
    let code = unsafe { FfiWifiP2pConnect(ct) }
    ct.free()
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "p2pConnect failed: ${err[1]}")
    }
}

/**
 * Stop an ongoing p2p connection that is being established.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 * @relation function p2pCancelConnect(): void
 */
@!APILevel[
    21,
    permission: "ohos.permission.GET_WIFI_INFO",
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public func p2pCancelConnect(): Unit {
    let code = unsafe { FfiWifiP2pCancelConnect() }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "p2pCancelConnect failed: ${err[1]}")
    }
}

/**
 * Start discover Wi-Fi P2P devices.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 * @relation function startDiscoverDevices(): void
 */
@!APILevel[
    21,
    permission: "ohos.permission.GET_WIFI_INFO",
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public func startDiscoverDevices(): Unit {
    let code = unsafe { FfiWifiStartDiscoverDevices() }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "startDiscoverDevices failed: ${err[1]}")
    }
}

/**
 * Stop discover Wi-Fi P2P devices.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 * @relation function stopDiscoverDevices(): void
 */
@!APILevel[
    21,
    permission: "ohos.permission.GET_WIFI_INFO",
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public func stopDiscoverDevices(): Unit {
    let code = unsafe { FfiWifiStopDiscoverDevices() }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "stopDiscoverDevices failed: ${err[1]}")
    }
}

private let CALLBACK_MAP = HashMap<String, ArrayList<CallbackObject>>()
private let REGISTER_MAP = HashMap<String, Bool>(
    [
        ("wifiStateChange", false)
    ]
)

// return index of the object in array
private func findCallbackObject(callbackType: String, callback: CallbackObject, remove!: Bool = false): Int64 {
    let callbackList = CALLBACK_MAP.get(callbackType) ?? return -1
    for (idx in 0..callbackList.size) {
        if (refEq(callback, callbackList[idx])) {
            if (remove) {
                callbackList.remove(at: idx)
            }
            return idx
        }
    }
    return -1
}

private func on(callbackType: String, id: Int64) {
    let code: Int32
    try (cstr = unsafe { LibC.mallocCString(callbackType) }.asResource()) {
        code = unsafe { FfiWifiWifiOn(cstr.value, id) }
        if (code != SUCCESS_CODE) {
            let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
            throw BusinessException(err[0], "on ${callbackType} failed: ${err[1]}")
        }
    }
}

private func argWrapper1<CT, T>(callbackType: String, ctor: (CT) -> T): Int64 where CT <: CType {
    let wrapper = {
        ctype: CT =>
        let cjType = ctor(ctype)
        let callbackList = CALLBACK_MAP.get(callbackType) ?? ArrayList<CallbackObject>()
        for (caller in callbackList) {
            (caller as Callback1Argument<T>)?.invoke(None, cjType)
        }
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
}

private func commonSubscribe1Arg<CT, T>(callbackType: String, callback: CallbackObject, ctor: (CT) -> T) where CT <: CType {
    LOGGER.debug("subscribe ${callbackType}")
    if (!REGISTER_MAP[callbackType]) {
        on(callbackType, argWrapper1<CT, T>(callbackType, ctor))
        REGISTER_MAP[callbackType] = true
    } else {
        if (findCallbackObject(callbackType, callback) >= 0) {
            LOGGER.info("[Wifi] The callback object already exists.")
            return
        }
    }
    CALLBACK_MAP.addIfAbsent(callbackType, ArrayList<CallbackObject>())
    CALLBACK_MAP[callbackType].add(callback)
}

// no need to call FfiWifiWifiOff because there is no unregister api in ndk
private func commonUnSubscribe<T>(callbackType: String, callback!: ?T = None): Unit where T <: CallbackObject {
    LOGGER.debug("unsubscribe ${callbackType}")
    match (callback) {
        case Some(v) => findCallbackObject(callbackType, v, remove: true)
        case None => CALLBACK_MAP.get(callbackType)?.clear()
    }
}

/**
 * Subscribe Wi-Fi scan status change events.
 *
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @relation function on(type: 'wifiScanStateChange', callback: Callback<number>): void
 */
@!APILevel[
    21,
    permission: "ohos.GET_WIFI_INFO",
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public func onWifiScanStateChange(callback: Callback1Argument<Int32>): Unit {
    commonSubscribe1Arg("wifiStateChange", callback) {i: Int32 => i}
}

/**
 * Unsubscribe Wi-Fi related events.
 *
 * All callback functions will be deregistered If there is no specific callback parameter.
 * @relation function off(type: 'wifiScanStateChange', callback?: Callback<number>): void
 */
@!APILevel[
    21,
    permission: "ohos.GET_WIFI_INFO",
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public func offWifiScanStateChange(callback!: ?Callback1Argument<Int32> = None): Unit {
    commonUnSubscribe("wifiStateChange", callback: callback)
}
