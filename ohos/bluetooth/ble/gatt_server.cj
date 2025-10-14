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

import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.bluetooth.{ BLUETOOTH_LOG, getErrorMsg, checkRet }
import ohos.callback_invoke.{ CallbackObject, Callback1Argument }
import ohos.ffi.{ SUCCESS_CODE , RemoteDataLite, releaseFFIData, Callback1Param}
import ohos.labels.APILevel

import std.collection.{ArrayList, HashMap}

/**
 * Manages GATT server. Before calling an Gatt server method, you must use createGattServer to create an GattServer
 * instance.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class GattServer <: RemoteDataLite {
    private let callbackMap = HashMap<BluetoothBleGattServerCallbackType, ArrayList<CallbackObject>>()
    private let registerMap = HashMap<BluetoothBleGattServerCallbackType, Bool>(
        [
            (CharacteristicRead, false),
            (CharacteristicWrite, false),
            (DescriptorRead, false),
            (DescriptorWrite, false),
            (ConnectionStateChange, false),
            (ServerBleMtuChange, false)
        ]
    )

    init(instanceId: Int64) {
        super(instanceId)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Adds a specified service to be hosted.
     * The added service and its characteristics are provided by the local device.
     *
     * @param { GattService } service - Indicates the service to add.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func addService(service: GattService): Unit {
        var errorCode: Int32 = 0
        unsafe {
            let cGattService: NativeGattService = service.toNative()
            FfiBluetoothBleGattServerAddService(getID(), cGattService, inout errorCode)
            cGattService.free()
        }
        checkRet(errorCode)
    }

    /**
     * Removes a specified service from the list of GATT services provided by this device.
     *
     * @param { String } serviceUuid - Indicates the UUID of the service to remove.
     * @throws { BusinessException} 201 - Permission denied.
     * @throws { BusinessException} 801 - Capability not supported.
     * @throws { BusinessException} 2900001 - Service stopped.
     * @throws { BusinessException} 2900003 - Bluetooth disabled.
     * @throws { BusinessException} 2900004 - Profile not supported.
     * @throws { BusinessException} 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func removeService(serviceUUID: String): Unit {
        var errorCode: Int32 = 0
        unsafe {
            try (serviceUUIDCString = LibC.mallocCString(serviceUUID).asResource()) {
                FfiBluetoothBleGattServerRemoveService(getID(), serviceUUIDCString.value, inout errorCode)
            }
        }
        checkRet(errorCode)
    }

    /**
     * Closes this GattServer object and unregisters its callbacks.
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
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func close(): Unit {
        var errorCode: Int32 = 0
        unsafe {
            FfiBluetoothBleGattServerClose(getID(), inout errorCode)
        }
        checkRet(errorCode)
    }

    /**
     * Sends a notification of a change in a specified local characteristic with a asynchronous callback.
     * This method should be called for every BLE peripheral device that has requested notifications.
     *
     * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @param { NotifyCharacteristic } notifyCharacteristic - Indicates the local characteristic that has changed.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func notifyCharacteristicChanged(deviceId: String, notifyCharacteristic: NotifyCharacteristic): Unit {
        var errorCode: Int32 = 0
        unsafe {
            try (deviceIdCString = LibC.mallocCString(deviceId).asResource()) {
                let cNotifyCharacteristic = notifyCharacteristic.toNative()
                FfiBluetoothBleGattServerNotifyCharacteristicChanged(getID(), deviceIdCString.value,
                    cNotifyCharacteristic, inout errorCode)
                cNotifyCharacteristic.free()
            }
        }
        checkRet(errorCode)
    }

    /**
     * Sends a response to a specified read or write request to a given BLE peripheral device.
     *
     * @param { ServerResponse } serverResponse - Indicates the response parameters {@link ServerResponse}.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func sendResponse(serverResponse: ServerResponse): Unit {
        var errorCode: Int32 = 0
        unsafe {
            let cServerResponse: NativeServerResponse = serverResponse.toNative()
            FfiBluetoothBleGattServerSendResponse(getID(), cServerResponse, inout errorCode)
            cServerResponse.free()
        }
        checkRet(errorCode)
    }

    /**
     * Subscribe characteristic read event.
     *
     * @param { BluetoothBleGattServerCallbackType } eventType - Type of the characteristic read event to listen for.
     * @param { Callback1Argument<CharacteristicReadRequest> } callback - Callback used to listen for the characteristic read event.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<CharacteristicReadRequest>): Unit {
        if (eventType != CharacteristicRead) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is CharacteristicRead")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }

        commonSubscribe1Arg(eventType, callback) {
            request: NativeCharacteristicReadRequest => request.toObject()
        }
        return
    }

    /**
     * Subscribe characteristic write event.
     *
     * @param { BluetoothBleGattServerCallbackType } eventType - Type of the characteristic write event to listen for.
     * @param { Callback1Argument<CharacteristicWriteRequest> } callback - Callback used to listen for the characteristic write event.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<CharacteristicWriteRequest>): Unit {
        if (eventType != CharacteristicWrite) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is CharacteristicWrite")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
        commonSubscribe1Arg(eventType, callback) {
            request: NativeCharacteristicWriteRequest => request.toObject()
        }
        return
    }

    /**
     * Subscribe descriptor read event.
     *
     * @param { BluetoothBleGattServerCallbackType } eventType - Type of the descriptor read event to listen for.
     * @param { Callback1Argument<DescriptorReadRequest> } callback - Callback used to listen for the descriptor read event.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<DescriptorReadRequest>): Unit {
        if (eventType != DescriptorRead) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is DescriptorRead")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
        commonSubscribe1Arg(eventType, callback) {
            request: NativeDescriptorReadRequest => request.toObject()
        }
        return
    }

    /**
     * Subscribe descriptor write event.
     *
     * @param { BluetoothBleGattServerCallbackType } eventType - Type of the descriptor write event to listen for.
     * @param { Callback1Argument<DescriptorWriteRequest> } callback - Callback used to listen for the descriptor write event.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<DescriptorWriteRequest>): Unit {
        if (eventType != DescriptorWrite) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is DescriptorWrite")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
        commonSubscribe1Arg(eventType, callback) {
            request: NativeDescriptorWriteRequest => request.toObject()
        }
        return
    }

    /**
     * Subscribe server connection state changed event.
     *
     * @param { BluetoothBleGattServerCallbackType } eventType - Type of the connection state changed event to listen for.
     * @param { Callback1Argument<BLEConnectionChangeState> } callback - Callback used to listen for the connection state changed event.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<BLEConnectionChangeState>): Unit {
        if (eventType != ConnectionStateChange) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is ConnectionStateChange")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
        commonSubscribe1Arg(eventType, callback) {
            request: NativeBLEConnectionChangeState => request.toObject()
        }
        return
    }

    /**
     * Subscribe mtu changed event.
     *
     * @param { BluetoothBleGattServerCallbackType } eventType - Type of the mtu changed event to listen for.
     * @param { Callback<Int32> } callback - Callback used to listen for the mtu changed event.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<Int32>): Unit {
        if (eventType != ServerBleMtuChange) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is ServerBleMtuChange")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
        commonSubscribe1Arg(eventType, callback) {
            i: Int32 => i
        }
        return
    }

    /**
     * Unsubscribe mtu changed event.
     *
     * @param { BluetoothBleGattServerCallbackType } eventType - Type of unsubscribe event.
     * @param { ?CallbackObject } callback - Callback used to listen.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func off(eventType: BluetoothBleGattServerCallbackType, callback!: ?CallbackObject = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe ${eventType}")
        if (!callbackMap.contains(eventType)) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject(eventType, v, remove: true)
            return
        }
        callbackMap[eventType].clear()
        return
    }

    private func findCallbackObject(callbackType: BluetoothBleGattServerCallbackType, callback: CallbackObject,
        remove!: Bool = false): Int64 {
        let callbackList = callbackMap.get(callbackType) ?? return -1
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

    private func argWrapper1<CT, T>(callbackType: BluetoothBleGattServerCallbackType, ctor: (CT) -> T): Int64 where CT <: CType {
        let wrapper = {
            ctype: CT =>
            let cjType = ctor(ctype)
            let callbackList = callbackMap.get(callbackType) ?? ArrayList<CallbackObject>()
            for (caller in callbackList) {
                (caller as Callback1Argument<T>)?.invoke(None, cjType)
            }
        }
        let registerCall = Callback1Param<CT, Unit>(wrapper)
        registerCall.getID()
    }

    private func register(callbackType: BluetoothBleGattServerCallbackType, id: Int64) {
        var errorCode: Int32 = 0
        unsafe {
            FfiBluetoothBleGattServerOn(getID(), callbackType.getValue(), id, inout errorCode)
        }
        checkRet(errorCode)
    }

    private func commonSubscribe1Arg<CT, T>(callbackType: BluetoothBleGattServerCallbackType, callback: CallbackObject,
        ctor: (CT) -> T) where CT <: CType {
        BLUETOOTH_LOG.debug("subscribe ${callbackType}")
        if (!registerMap[callbackType]) {
            register(callbackType, argWrapper1<CT, T>(callbackType, ctor))
            registerMap[callbackType] = true
        } else {
            if (findCallbackObject(callbackType, callback) >= 0) {
                BLUETOOTH_LOG.info("The ${callbackType} callback is registered, no need to re-registered")
                return
            }
        }
        callbackMap.addIfAbsent(callbackType, ArrayList<CallbackObject>())
        callbackMap[callbackType].add(callback)
    }
}
