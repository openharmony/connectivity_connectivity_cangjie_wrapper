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

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.wifi_manager

import ohos.business_exception.BusinessException
import ohos.business_exception.AsyncCallback
import ohos.callback_invoke.{ Callback1Argument, CallbackObject }
import ohos.ffi.{SUCCESS_CODE, cArr2cjArr, Callback1Param}
import ohos.hilog.HilogChannel
import ohos.labels.APILevel

import std.collection.{HashMap, ArrayList}
import std.deriving.Derive

let LOGGER = HilogChannel(0, 0xD001560, "CJ-wifi")

/**
 * Query the Wi-Fi status
 *
 * @returns { Bool } Returns true if the Wi-Fi is active, returns false otherwise.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2501000 - Operation failed.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
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
 * Scan Wi-Fi hotspot.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.SET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func startScan(): Unit {
    let code = unsafe { FfiWifiStartScan() }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
        throw BusinessException(err[0], "startScan failed: ${err[1]}")
    }
}

/**
 * Obtain the scanned station list. If does't have the permission of ohos.permission.GET_WIFI_PEERS_MAC,
 * return random bssid.
 *
 * @returns { Array<WifiScanInfo> } Returns information about scanned Wi-Fi hotspot if any.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2501000 - Operation failed.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
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
 *
 * @param { WifiP2pConfig } config - Indicates the configuration for connecting to a specific group.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
]
public func p2pConnect(config: WifiP2pConfig): Unit {
    var ct = CWifiP2PConfig(config)
    let code = unsafe { FfiWifiP2pConnect(inout ct) }
    ct.free()
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "p2pConnect failed: ${err[1]}")
    }
}

/**
 * Stop an ongoing p2p connection that is being established.
 *
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
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
 *
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
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
 *
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 * @throws {BusinessException} 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
]
public func stopDiscoverDevices(): Unit {
    let code = unsafe { FfiWifiStopDiscoverDevices() }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "stopDiscoverDevices failed: ${err[1]}")
    }
}

private let CALLBACK_MAP = HashMap<WifiCallbackType, ArrayList<CallbackObject>>()
private let REGISTER_MAP = HashMap<WifiCallbackType, Bool>(
    [
        (WifiScanStateChange, false)
    ]
)

// return index of the object in array
private func findCallbackObject(callbackType: WifiCallbackType, callback: CallbackObject, remove!: Bool = false): Int64 {
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

/*
 * @throws { BusinessException } 1000 - Operation failed.
*/
private func on(callbackType: WifiCallbackType, id: Int64) {
    try (cstr = unsafe { LibC.mallocCString(callbackType.getValue()) }.asResource()) {
        let code: Int32 = unsafe { FfiWifiWifiOn(cstr.value, id) }
        if (code != SUCCESS_CODE) {
            let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
            throw BusinessException(err[0], "on ${callbackType} failed: ${err[1]}")
        }
    }
}

private func argWrapper1<CT, T>(callbackType: WifiCallbackType, ctor: (CT) -> T): Int64 where CT <: CType {
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

private func commonSubscribe1Arg<CT, T>(callbackType: WifiCallbackType, callback: CallbackObject, ctor: (CT) -> T) where CT <: CType {
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
private func commonUnSubscribe<T>(callbackType: WifiCallbackType, callback!: ?T = None): Unit where T <: CallbackObject {
    LOGGER.debug("unsubscribe ${callbackType}")
    match (callback) {
        case Some(v) => findCallbackObject(callbackType, v, remove: true)
        case None => CALLBACK_MAP.get(callbackType)?.clear()
    }
}

/**
 * Subscribe Wi-Fi scan status change events.
 *
 * @param { WifiCallbackType } eventType - Indicates the Wi-Fi event type.
 * @param { Callback1Argument<Int32> } callback - Indicates the callback to receive Wi-Fi scan status change events.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func on(eventType: WifiCallbackType, callback: Callback1Argument<Int32>): Unit {
    commonSubscribe1Arg(eventType, callback) {i: Int32 => i}
}

/**
 * Unsubscribe Wi-Fi related events.
 * All callback functions will be deregistered If there is no specific callback parameter.
 *
 * @param { WifiCallbackType } eventType - Indicates the Wi-Fi event type.
 * @param { ?CallbackObject } [callback] - Indicates the callback to unsubscribe. 
 *                                       If not specified, all callbacks will be removed.
 * @throws {BusinessException} 201 - Permission denied.
 * @throws {BusinessException} 801 - Capability not supported.
 * @throws {BusinessException} 2801000 - Operation failed.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func off(eventType: WifiCallbackType, callback!: ?CallbackObject = None): Unit {
    commonUnSubscribe(eventType, callback: callback)
}

/**
 * Add a specified candidate hotspot configuration and returns the networkId.
 * This method adds one configuration at a time. After this configuration is added,
 *     your device will determine whether to connect to the hotspot.
 * The app must be in the foreground.
 *
 * @param { WifiDeviceConfig } config - candidate config.
 * @returns { Unit } Returns {@code networkId} if the configuration is added; returns {@code -1} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.SET_WIFI_INFO",
    throwexception: true
]
public func addCandidateConfig(config: WifiDeviceConfig, callback: AsyncCallback<Int32>): Unit {
    spawn {
        var error: ?BusinessException = None
        var value: ?Int32 = None
        try {
            let ct = CWifiDeviceConfig(config)
            try {
                var ret = 0i32
                let code = unsafe { FfiWifiAddCandidateConfig(ct, inout ret) }
                if (code != SUCCESS_CODE) {
                    let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
                    error = BusinessException(err[0], "addCandidateConfig failed: ${err[1]}")
                } else {
                    value = ret
                }
            } finally {
                ct.free()
            }
        } catch (e: BusinessException) {
            error = e
        } catch (e: Exception) {
            error = BusinessException(2501000, "Operation failed.")
        }
        match (error) {
            case Some(e) => callback(e, None)
            case None => callback(None, value)
        }
    }
}

/**
 * Remove a specified candidate hotspot configuration, only the configuration which is added by ourself is allowed
 * to be removed.
 * The app must be in the foreground.
 *
 * @param { Int32 } networkId - Network ID which will be removed.
 * @param { AsyncCallback<Unit> } callback - Indicates call back of removeCandidateConfig.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 * @throws { BusinessException } 2501001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.SET_WIFI_INFO",
    throwexception: true
]
public func removeCandidateConfig(networkId: Int32, callback: AsyncCallback<Unit>): Unit {
    spawn {
        var error: ?BusinessException = None
        try {
            let code = unsafe { FfiWifiRemoveCandidateConfig(networkId) }
            if (code != SUCCESS_CODE) {
                let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
                error = BusinessException(err[0], "removeCandidateConfig failed: ${err[1]}")
            }
        } catch (e: BusinessException) {
            error = e
        } catch (e: Exception) {
            error = BusinessException(2501000, "Operation failed.")
        }
        match (error) {
            case Some(e) => callback(e, None)
            case None => callback(None, ())
        }
    }
}

/**
 * Obtain the list of all existed candidate Wi-Fi configurations which added by ourself.
 * You can obtain only the Wi-Fi configurations you created on your own application.
 *
 * @returns { Array<WifiDeviceConfig> } Returns the list of all existed Wi-Fi configurations you created on your application.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getCandidateConfigs(): Array<WifiDeviceConfig> {
    var code = 0i32
    var arr: Array<WifiDeviceConfig> = Array<WifiDeviceConfig>()
    unsafe {
        let ret = FfiWifiGetCandidateConfigsV2(inout code)
        if (code != SUCCESS_CODE) {
            ret.free()
            let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
            throw BusinessException(err[0], "getCandidateConfigs failed: ${err[1]}")
        }
        try {
            arr = cArr2cjArr<CWifiDeviceConfig, WifiDeviceConfig>(ret.size, ret.head) {
                cfg => cfg.toWifiDeviceConfig()
            }
        } finally {
            ret.free()
        }
    }
    arr
}

/**
 * Connect to the specified candidate hotspot using connect settings.
 *
 * @param { ConnectSettings } settings - Indicates the connection settings.
 * @param { AsyncCallback<Unit> } callback - Indicates callback of connectToCandidateConfig.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 * @throws { BusinessException } 2501001 - Wi-Fi STA disabled.
 * @throws { BusinessException } 2501005 - The user does not respond.
 * @throws { BusinessException } 2501006 - The user refused the action.
 * @throws { BusinessException } 2501007 - Parameter validation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.SET_WIFI_INFO",
    throwexception: true
]
public func connectToCandidateConfig(settings: ConnectSettings, callback: AsyncCallback<Unit>): Unit {
    spawn {
        var error: ?BusinessException = None
        // Reject an explicit out-of-range user action timeout with 401 (invalid
        // parameter), matching ArkTS, instead of treating it as "unset".
        var invalidTimeout = false
        match (settings.userActionTimeout) {
            case Some(t) => invalidTimeout = t <= 0 || t > MAX_DIALOG_TIMEOUT
            case None => ()
        }
        if (invalidTimeout) {
            error = BusinessException(401, "Parameter error.")
        } else {
            try {
                var ct = CWifiConnectSettings(settings)
                let code = unsafe { FfiWifiConnectToCandidateConfigWithSettings(inout ct) }
                if (code != SUCCESS_CODE) {
                    let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
                    error = BusinessException(err[0], "connectToCandidateConfig failed: ${err[1]}")
                }
            } catch (e: BusinessException) {
                error = e
            } catch (e: Exception) {
                error = BusinessException(2501000, "Operation failed.")
            }
        }
        match (error) {
            case Some(e) => callback(e, None)
            case None => callback(None, ())
        }
    }
}

/**
 * Calculate the Wi-Fi signal level based on the Wi-Fi RSSI and frequency band.
 *
 * @param { Int32 } rssi - Indicates the Wi-Fi RSSI.
 * @param { Int32 } band - Indicates the Wi-Fi frequency band.
 * @returns { UInt32 } Returns Wi-Fi signal level ranging from 0 to 4.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getSignalLevel(rssi: Int32, band: Int32): UInt32 {
    var ret = 0u32
    let code = unsafe { FfiWifiGetSignalLevel(rssi, band, inout ret) }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
        throw BusinessException(err[0], "getSignalLevel failed: ${err[1]}")
    }
    ret
}

/**
 * Obtain connection information about the Wi-Fi connection.
 * If the app does not have the ohos.permission.GET_WIFI_PEERS_MAC permission, a random bssid is returned.
 *
 * @returns { WifiLinkedInfo } Returns the Wi-Fi linked information.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 * @throws { BusinessException } 2501001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getLinkedInfoSync(): WifiLinkedInfo {
    let ptr = safeMalloc<CWifiLinkedInfo>()
    var info = WifiLinkedInfo()
    try {
        let code = unsafe { FfiWifiGetLinkedInfo(ptr) }
        if (code != SUCCESS_CODE) {
            let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
            throw BusinessException(err[0], "getLinkedInfoSync failed: ${err[1]}")
        }
        let ret = unsafe { ptr.read() }
        try {
            info = ret.toWifiLinkedInfo()
        } finally {
            ret.free()
        }
    } finally {
        unsafe { LibC.free(ptr) }
    }
    info
}

/**
 * Check whether the Wi-Fi connection has been set up.
 *
 * @returns { Bool } Returns {@code true} if a Wi-Fi connection has been set up, returns {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func isConnected(): Bool {
    var ret = false
    let code = unsafe { FfiWifiIsConnected(inout ret) }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
        throw BusinessException(err[0], "isConnected failed: ${err[1]}")
    }
    ret
}

/**
 * Check whether the device supports a specified feature.
 *
 * @param { Int64 } featureId Indicates the ID of the feature.
 * @returns { Bool } Returns {@code true} if this device supports the specified feature, returns {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2401000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.Core",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func isFeatureSupported(featureId: Int64): Bool {
    var ret = false
    let code = unsafe { FfiWifiIsFeatureSupported(featureId, inout ret) }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_CORE)
        throw BusinessException(err[0], "isFeatureSupported failed: ${err[1]}")
    }
    ret
}

/**
 * Obtain the IPv4 information of the Wi-Fi connection.
 * The IP information includes the host IP address, gateway address, and DNS information.
 *
 * @returns { IpInfo } Returns the IP information of the Wi-Fi connection.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getIpInfo(): IpInfo {
    let ptr = safeMalloc<CIpInfo>()
    var info = IpInfo()
    try {
        let code = unsafe { FfiWifiGetIpInfo(ptr) }
        if (code != SUCCESS_CODE) {
            let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
            throw BusinessException(err[0], "getIpInfo failed: ${err[1]}")
        }
        info = unsafe { ptr.read().toIpInfo() }
    } finally {
        unsafe { LibC.free(ptr) }
    }
    info
}

/**
 * Obtain the IPv6 information of the Wi-Fi connection.
 * The IPv6 information includes the host IP address, gateway address, and DNS information.
 *
 * @returns { Ipv6Info } Returns the IPv6 information of the Wi-Fi connection.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getIpv6Info(): Ipv6Info {
    let ptr = safeMalloc<CIpv6Info>()
    var info = Ipv6Info()
    try {
        let code = unsafe { FfiWifiGetIpv6Info(ptr) }
        if (code != SUCCESS_CODE) {
            let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
            throw BusinessException(err[0], "getIpv6Info failed: ${err[1]}")
        }
        let ret = unsafe { ptr.read() }
        try {
            info = ret.toIpv6Info()
        } finally {
            ret.free()
        }
    } finally {
        unsafe { LibC.free(ptr) }
    }
    info
}

/**
 * Obtain the country code of the device.
 *
 * @returns { String } Returns the country code of this device.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2401000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.Core",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getCountryCode(): String {
    var code = 0i32
    let cstr = unsafe { FfiWifiGetCountryCode(inout code) }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_CORE)
        throw BusinessException(err[0], "getCountryCode failed: ${err[1]}")
    }
    try {
        cstr.toString()
    } finally {
        unsafe { LibC.free(cstr) }
    }
}

/**
 * Check whether the current device supports the specified band.
 *
 * @param { WifiBandType } bandType - Indicates the band type.
 * @returns { Bool } Returns {@code true} if the specified band is supported, returns {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func isBandTypeSupported(bandType: WifiBandType): Bool {
    var ret = false
    let code = unsafe { FfiWifiIsBandTypeSupported(wifiBandTypeValue(bandType), inout ret) }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_STA)
        throw BusinessException(err[0], "isBandTypeSupported failed: ${err[1]}")
    }
    ret
}

/**
 * Obtain information about the P2P connection.
 *
 * @param { AsyncCallback<WifiP2pLinkedInfo> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getP2pLinkedInfo(callback: AsyncCallback<WifiP2pLinkedInfo>): Unit {
    spawn {
        var error: ?BusinessException = None
        var value: ?WifiP2pLinkedInfo = None
        try {
            let ptr = safeMalloc<CWifiP2pLinkedInfo>()
            try {
                let code = unsafe { FfiWifiGetP2pLinkedInfo(ptr) }
                if (code != SUCCESS_CODE) {
                    let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
                    error = BusinessException(err[0], "getP2pLinkedInfo failed: ${err[1]}")
                } else {
                    let ret = unsafe { ptr.read() }
                    try {
                        value = ret.toWifiP2pLinkedInfo()
                    } finally {
                        ret.free()
                    }
                }
            } finally {
                unsafe { LibC.free(ptr) }
            }
        } catch (e: BusinessException) {
            error = toP2pBusinessException(e)
        } catch (e: Exception) {
            error = BusinessException(2801000, "Operation failed.")
        }
        match (error) {
            case Some(e) => callback(e, None)
            case None => callback(None, value)
        }
    }
}

/**
 * Obtain information about the current p2p group.
 *
 * @param { AsyncCallback<WifiP2pGroupInfo> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getCurrentGroup(callback: AsyncCallback<WifiP2pGroupInfo>): Unit {
    spawn {
        var error: ?BusinessException = None
        var value: ?WifiP2pGroupInfo = None
        try {
            let ptr = safeMalloc<CWifiP2pGroupInfo>()
            try {
                let code = unsafe { FfiWifiGetCurrentGroup(ptr) }
                if (code != SUCCESS_CODE) {
                    let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
                    error = BusinessException(err[0], "getCurrentGroup failed: ${err[1]}")
                } else {
                    let ret = unsafe { ptr.read() }
                    try {
                        value = ret.toWifiP2pGroupInfo()
                    } finally {
                        ret.free()
                    }
                }
            } finally {
                unsafe { LibC.free(ptr) }
            }
        } catch (e: BusinessException) {
            error = toP2pBusinessException(e)
        } catch (e: Exception) {
            error = BusinessException(2801000, "Operation failed.")
        }
        match (error) {
            case Some(e) => callback(e, None)
            case None => callback(None, value)
        }
    }
}

/**
 * Obtain the information about the found devices.
 *
 * @param { AsyncCallback<Array<WifiP2pDevice>> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getP2pPeerDevices(callback: AsyncCallback<Array<WifiP2pDevice>>): Unit {
    spawn {
        var error: ?BusinessException = None
        var value: ?Array<WifiP2pDevice> = None
        try {
            var code = 0i32
            let ret = unsafe { FfiWifiGetP2pPeerDevices(inout code) }
            if (code != SUCCESS_CODE) {
                let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
                error = BusinessException(err[0], "getP2pPeerDevices failed: ${err[1]}")
            } else {
                value = ret.toCjArrAndFree()
            }
        } catch (e: BusinessException) {
            error = toP2pBusinessException(e)
        } catch (e: Exception) {
            error = BusinessException(2801000, "Operation failed.")
        }
        match (error) {
            case Some(e) => callback(e, None)
            case None => callback(None, value)
        }
    }
}

/**
 * Obtain the information about own device information.
 * DeviceAddress in the returned WifiP2pDevice will be set "00:00:00:00:00:00",
 * if ohos.permission.GET_WIFI_LOCAL_MAC is not granted.
 *
 * @param { AsyncCallback<WifiP2pDevice> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getP2pLocalDevice(callback: AsyncCallback<WifiP2pDevice>): Unit {
    spawn {
        var error: ?BusinessException = None
        var value: ?WifiP2pDevice = None
        try {
            let ptr = safeMalloc<CWifiP2pDevice>()
            try {
                let code = unsafe { FfiWifiGetP2pLocalDevice(ptr) }
                if (code != SUCCESS_CODE) {
                    let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
                    error = BusinessException(err[0], "getP2pLocalDevice failed: ${err[1]}")
                } else {
                    let ret = unsafe { ptr.read() }
                    try {
                        value = ret.toWifiP2pDevice()
                    } finally {
                        ret.free()
                    }
                }
            } finally {
                unsafe { LibC.free(ptr) }
            }
        } catch (e: BusinessException) {
            error = toP2pBusinessException(e)
        } catch (e: Exception) {
            error = BusinessException(2801000, "Operation failed.")
        }
        match (error) {
            case Some(e) => callback(e, None)
            case None => callback(None, value)
        }
    }
}

/**
 * Create a P2P group.
 *
 * @param { WifiP2pConfig } config - Indicates the configuration for a group.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func createGroup(config: WifiP2pConfig): Unit {
    var ct = CWifiP2PConfig(config)
    let code = unsafe { FfiWifiCreateGroup(inout ct) }
    ct.free()
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "createGroup failed: ${err[1]}")
    }
}

/**
 * Remove a P2P group.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func removeGroup(): Unit {
    let code = unsafe { FfiWifiRemoveGroup() }
    if (code != SUCCESS_CODE) {
        let err = getCodeAndMsg(code, SYSCAP_WIFI_P2P)
        throw BusinessException(err[0], "removeGroup failed: ${err[1]}")
    }
}

/**
 * WiFi registration event type.
 */
@Derive[ToString, Equatable, Hashable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum WifiCallbackType {
    /**
     * Wi-Fi scan status change event type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiScanStateChange
    |
    ...

    func getValue(): String {
        match(this) {
            case WifiScanStateChange => "wifiScanStateChange"
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}
