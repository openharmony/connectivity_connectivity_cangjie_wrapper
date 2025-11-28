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

import ohos.bluetooth.{ BLUETOOTH_LOG, OPERATION_FAILED, checkRet, getErrorMsg, CallbackController }
import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.callback_invoke.{ Callback1Argument, CallbackObject }
import ohos.ffi.{ Callback1Param, SUCCESS_CODE, safeMalloc, cArr2cjArr }
import ohos.labels.APILevel

import std.collection.HashMap

/**
 * create a Gatt server instance.
 *
 * @returns { GattServer } Returns a Gatt server instance GattServer.
 */
@!APILevel[
    since: "22",
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
 * @returns { GattClientDevice } Returns a Gatt client device instance GattClientDevice.
 * @throws { BusinessException } 801 - Capability not supported.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
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
 * @param { Array<ScanFilter> } filters - Indicates the list of filters used to filter out specified devices.
 * If you do not want to use filter, set this parameter to empty array.
 * @param { ?ScanOptions } [options] - Indicates the parameters for scanning and if the user does not assign a value,
 * the default value will be used.
 * interval set to 0, dutyMode set to SCAN_MODE_LOW_POWER
 * and matchMode set to MATCH_MODE_AGGRESSIVE.
 * and phyType set to PHY_LE_ALL_SUPPORTED.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func startBleScanning(filters: Array<ScanFilter>, options!: ?ScanOptions = None): Unit {
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
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func stopBleScanning(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothBleStopBleScan(inout errorCode)
    }
    checkRet(errorCode)
}

/**
 * Starts BLE advertising.
 *
 * @param { AdvertiseSetting } setting - Indicates the settings for BLE advertising.
 * @param { AdvertiseData } advData - Indicates the advertising data.
 * @param { ?AdvertiseData } [advResponse] - Indicates the scan response associated with the advertising data.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900010 - The numeber of advertising resources reaches the upper limit.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { BusinessException } 2902054 - The length of the advertising data exceeds the upper limit.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true,
    workerthread: true
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
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true,
    workerthread: true
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
 * The API returns a advertising ID. The ID can be used to completely stop the advertising corresponding to the ID,
 * invoke the API stopAdvertising with ID.
 *
 * @param { AdvertisingParams } advertisingParams - Indicates the param for BLE advertising.
 * @returns { UInt32 }the callback of advertise ID.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900010 - The numeber of advertising resources reaches the upper limit.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { BusinessException } 2902054 - The length of the advertising data exceeds the upper limit.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true,
    workerthread: true
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
 * @param { UInt32 } advertisingId - Indicates the ID for this BLE advertising.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 * @throws { BusinessException } 2902055 - Invalid advertising id.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true,
    workerthread: true
]
public func stopAdvertising(advertisingId: UInt32): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothBleStopAdvertisingWithId(advertisingId, inout errorCode)
    }
    checkRet(errorCode)
}

private let GLOBAL_CALLBACK_MAP = HashMap<BluetoothBleCallbackType, CallbackController>(
    [(AdvertisingStateChange, CallbackController()), (BleDeviceFind, CallbackController())])

private func register(callbackType: BluetoothBleCallbackType, id: Int64) {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothBleOn(callbackType.getValue(), id, inout errorCode)
    }
    checkRet(errorCode)
}

private func argWrapper1<CT, T>(controller: CallbackController, ctor: (CT) -> T): Int64 where CT <: CType {
    let wrapper = {
        ctype: CT =>
        let cjType = ctor(ctype)
        controller.invokeCallback(cjType)
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
}

private func commonSubscribe1Arg<CT, T>(callbackType: BluetoothBleCallbackType, callback: CallbackObject,
    ctor: (CT) -> T) where CT <: CType {
    BLUETOOTH_LOG.debug("subscribe ${callbackType}")
    let controller = GLOBAL_CALLBACK_MAP[callbackType]
    if (!controller.isEnabled()) {
        register(callbackType, argWrapper1<CT, T>(controller, ctor))
        controller.enableController()
    } else {
        if (controller.hasCallback(callback)) {
            BLUETOOTH_LOG.info("The ${callbackType} callback is registered, no need to re-registered")
            return
        }
    }
    controller.addCallback(callback)
}

/**
 * Subscribing to advertising state change event.
 *
 * @param { BluetoothBleCallbackType } eventType - Type of the advertising state to listen for.
 * @param { Callback1Argument<AdvertisingStateChangeInfo> } callback - Callback used to listen for the advertising state.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func on(eventType: BluetoothBleCallbackType, callback: Callback1Argument<AdvertisingStateChangeInfo>): Unit {
    if (eventType != AdvertisingStateChange) {
        throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
    }

    commonSubscribe1Arg(eventType, callback) {
        info: CAdvertisingStateChangeInfo => info.toObject()
    }
    return
}

/**
 * Subscribe BLE scan result.
 *
 * @param { BluetoothBleCallbackType } eventType - Type of the scan result event to listen for.
 * @param { Callback1Argument<Array<ScanResult>> } callback - Callback used to listen for the scan result event.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func on(eventType: BluetoothBleCallbackType, callback: Callback1Argument<Array<ScanResult>>): Unit {
    if (eventType != BleDeviceFind) {
        BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is BleDeviceFind")
        throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
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
 *
 * @param { BluetoothBleCallbackType } eventType - Type of unsubscribe event.
 * @param { ?CallbackObject } [callback] - Callback used to listen.
 */
@!APILevel[
    since: "22",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func off(eventType: BluetoothBleCallbackType, callback!: ?CallbackObject = None): Unit {
    BLUETOOTH_LOG.debug("unsubscribe stateChange")
    let controller = GLOBAL_CALLBACK_MAP[eventType]
    if (!controller.isEnabled()) {
        return
    }
    if (let Some(v) <- callback) {
        controller.removeCallback(v)
        return
    }
    controller.removeAllCallback()
    return
}
