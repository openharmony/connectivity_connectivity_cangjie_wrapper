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

package ohos.bluetooth.ble

import ohos.bluetooth.{ BLUETOOTH_LOG, OPERATION_FAILED, checkRet, getErrorMsg }
import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.callback_invoke.{ Callback1Argument, CallbackObject }
import ohos.ffi.{ Callback1Param, SUCCESS_CODE, safeMalloc, cArr2cjArr }
import ohos.labels.APILevel

import std.collection.{ArrayList, HashMap}

/**
 * create a Gatt server instance.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func createGattServer(): GattServer {
    var errorCode: Int32 = 0
    let id = unsafe { FfiBluetoothBleCreateGattServer(inout errorCode) }
    checkRet(errorCode)
    return GattServer(id)
}

/**
 * create a Gatt client device instance.
 *
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func createGattClientDevice(deviceId: String): GattClientDevice {
    var id = 0
    var errorCode: Int32 = 0
    unsafe {
        try (cDeviceId = LibC.mallocCString(deviceId).asResource()) {
            id = FfiBluetoothBleCreateGattClientDevice(cDeviceId.value, inout errorCode)
            checkRet(errorCode)
        }
    }
    return GattClientDevice(id)
}

/**
 * Starts scanning for specified BLE devices with filters.
 *
 * @param { ?ScanOptions } options - Indicates the parameters for scanning and if the user does not assign a value,
 * the default value will be used.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func startBLEScan(filters: Array<ScanFilter>, options!: ?ScanOptions = None): Unit {
    var errorCode: Int32 = 0
    unsafe {
        let filtersSize = filters.size
        let arr = if (filtersSize == 0) {
            CPointer<NativeScanFilter>()
        } else {
            safeMalloc<NativeScanFilter>(count: filtersSize)
        }
        for (i in 0..filtersSize) {
            arr.write(i, filters[i].toNative())
        }
        let cFilters = CArrNativeScanFilter(arr, filtersSize)

        var cOptions = CPointer<NativeScanOptions>()
        if (let Some(v) <- options) {
            cOptions = safeMalloc<NativeScanOptions>(count: 1)
            cOptions.write(v.toNative())
        }
        FfiBluetoothBleStartBleScan(cFilters, cOptions, inout errorCode)
        cFilters.free()
        LibC.free(cOptions)
    }
    checkRet(errorCode)
}

/**
 * Stops BLE scanning.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func stopBLEScan(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothBleStopBleScan(inout errorCode)
    }
    checkRet(errorCode)
}

/**
 * Starts BLE advertising.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900010 - The numeber of advertising resources reaches the upper limit.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { BusinessException } 2902054 - The length of the advertising data exceeds the upper limit.
 * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func startAdvertising(setting: AdvertiseSetting, advData: AdvertiseData, advResponse!: ?AdvertiseData = None): Unit {
    var errorCode: Int32 = 0
    let cSetting: NativeAdvertiseSetting = setting.toNative()
    let cAdvData: NativeAdvertiseData = advData.toNative()
    var cAdvResponse: CPointer<NativeAdvertiseData> = CPointer<NativeAdvertiseData>()
    unsafe {
        if (let Some(v) <- advResponse) {
            cAdvResponse = safeMalloc<NativeAdvertiseData>(count: 1)
            cAdvResponse.write(v.toNative())
        }

        FfiBluetoothBleStartAdvertising(cSetting, cAdvData, cAdvResponse, inout errorCode)

        cAdvData.free()
        if (cAdvResponse.isNotNull()) {
            cAdvResponse.read().free()
        }
        LibC.free(cAdvResponse)
    }
    checkRet(errorCode)
}

/**
 * Stops BLE advertising.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { BusinessException } 2902055 - Invalid advertising id.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func stopAdvertising(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothBleStopAdvertising(inout errorCode)
    }
    checkRet(errorCode)
}

/**
 * Starts BLE advertising.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900010 - The numeber of advertising resources reaches the upper limit.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { BusinessException } 2902054 - The length of the advertising data exceeds the upper limit.
 * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func startAdvertising(advertisingParams: AdvertisingParams): UInt32 {
    var errorCode: Int32 = 0
    let id: Int32
    unsafe {
        let cAdvertisingParams: NativeAdvertisingParams = advertisingParams.toNative()
        id = FfiBluetoothBleStartAdvertisingWithId(cAdvertisingParams, inout errorCode)
        cAdvertisingParams.free()
    }
    checkRet(errorCode)
    if (id < 0) {
        throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
    }
    // for usability
    return UInt32(id)
}

/**
 * Stops BLE advertising.
 * Completely stop the advertising corresponding to the ID.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { BusinessException } 2902055 - Invalid advertising id.
 * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func stopAdvertising(advertisingId: UInt32): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothBleStopAdvertisingWithId(advertisingId, inout errorCode)
    }
    checkRet(errorCode)
}

private let GLOBAL_CALLBACK_MAP = HashMap<BluetoothBleCallbackType, ArrayList<CallbackObject>>()
private let GLOBAL_REGISTER_MAP = HashMap<BluetoothBleCallbackType, Bool>(
    [(AdvertisingStateChange, false), (BleDeviceFind, false)])

private func findCallbackObject(callbackType: BluetoothBleCallbackType, callback: CallbackObject, remove!: Bool = false): Int64 {
    let callbackList = GLOBAL_CALLBACK_MAP.get(callbackType) ?? return -1
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

private func register(callbackType: BluetoothBleCallbackType, id: Int64) {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothBleOn(callbackType.getValue(), id, inout errorCode)
    }
    checkRet(errorCode)
}

private func argWrapper1<CT, T>(callbackType: BluetoothBleCallbackType, ctor: (CT) -> T): Int64 where CT <: CType {
    let wrapper = {
        ctype: CT =>
        let cjType = ctor(ctype)
        let callbackList = GLOBAL_CALLBACK_MAP.get(callbackType) ?? ArrayList<CallbackObject>()
        for (caller in callbackList) {
            (caller as Callback1Argument<T>)?.invoke(None, cjType)
        }
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
}

private func commonSubscribe1Arg<CT, T>(callbackType: BluetoothBleCallbackType, callback: CallbackObject,
    ctor: (CT) -> T) where CT <: CType {
    BLUETOOTH_LOG.debug("subscribe ${callbackType}")
    if (!GLOBAL_REGISTER_MAP[callbackType]) {
        register(callbackType, argWrapper1<CT, T>(callbackType, ctor))
        GLOBAL_REGISTER_MAP[callbackType] = true
    } else {
        if (findCallbackObject(callbackType, callback) >= 0) {
            BLUETOOTH_LOG.info("The ${callbackType} callback is registered, no need to re-registered")
            return
        }
    }
    GLOBAL_CALLBACK_MAP.addIfAbsent(callbackType, ArrayList<CallbackObject>())
    GLOBAL_CALLBACK_MAP[callbackType].add(callback)
}

/**
 * Subscribing to advertising state change event.
 *
 * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func on(eventType: BluetoothBleCallbackType, callback: Callback1Argument<AdvertisingStateChangeInfo>): Unit {
    if (eventType != AdvertisingStateChange) {
        throw IllegalArgumentException("Invalid name ${eventType}, valid name is AdvertisingStateChange")
    }

    commonSubscribe1Arg(eventType, callback) {
        info: CAdvertisingStateChangeInfo => info.toObject()
    }
    return
}

/**
 * Subscribe BLE scan result.
 *
 * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func on(eventType: BluetoothBleCallbackType, callback: Callback1Argument<Array<ScanResult>>): Unit {
    if (eventType != BleDeviceFind) {
        BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is BleDeviceFind")
        throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
    }

    commonSubscribe1Arg(eventType, callback) {
        result: CArrScanResult => unsafe {
            cArr2cjArr<NativeScanResult, ScanResult>(result.size, result.head) {
                r: NativeScanResult => r.toObject()
            }
        }
    }
    return
}

/**
 * Unsubscribe from callback event.
 */
@!APILevel[
    22,
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func off(eventType: BluetoothBleCallbackType, callback!: ?CallbackObject = None): Unit {
    BLUETOOTH_LOG.debug("unsubscribe stateChange")
    if (!GLOBAL_CALLBACK_MAP.contains(eventType)) {
        return
    }
    if (let Some(v) <- callback) {
        findCallbackObject(eventType, v, remove: true)
        return
    }
    GLOBAL_CALLBACK_MAP[eventType].clear()
    return
}
