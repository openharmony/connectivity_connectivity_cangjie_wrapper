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

package ohos.bluetooth.ble

import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.bluetooth.{ BLUETOOTH_LOG, getErrorMsg, checkRet }
import ohos.callback_invoke.{ CallbackObject, Callback1Argument }
import ohos.ffi.{ SUCCESS_CODE , RemoteDataLite, releaseFFIData, Callback1Param}
import ohos.labels.APILevel

import std.collection.{ArrayList, HashMap}

/**
 * Manages GATT server. Before calling an Gatt server method, you must use createGattServer to create an GattServer instance.
 *
 * @relation interface GattServer
 */
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class GattServer <: RemoteDataLite {
    private let callbackMap = HashMap<String, ArrayList<CallbackObject>>()
    private let registerMap = HashMap<String, Bool>(
        [
            ("CharacteristicRead", false),
            ("CharacteristicWrite", false),
            ("DescriptorRead", false),
            ("DescriptorWrite", false),
            ("ConnectionStateChange", false),
            ("BleMtuChange", false)
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
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation addService(service: GattService): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
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
     * @throws { BusinessException} 201 - Permission denied.
     * @throws { BusinessException} 801 - Capability not supported.
     * @throws { BusinessException} 2900001 - Service stopped.
     * @throws { BusinessException} 2900003 - Bluetooth disabled.
     * @throws { BusinessException} 2900004 - Profile not supported.
     * @throws { BusinessException} 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation removeService(serviceUuid: string): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func removeService(serviceUuid: String): Unit {
        var errorCode: Int32 = 0
        unsafe {
            try (serviceUuidCString = LibC.mallocCString(serviceUuid).asResource()) {
                FfiBluetoothBleGattServerRemoveService(getID(), serviceUuidCString.value, inout errorCode)
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
     * @relation close(): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
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
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation notifyCharacteristicChanged(deviceId: string, notifyCharacteristic: NotifyCharacteristic): Promise<void>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
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
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation sendResponse(serverResponse: ServerResponse): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
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
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'characteristicRead', callback: Callback<CharacteristicReadRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onCharacteristicRead(callback: Callback1Argument<CharacteristicReadRequest>): Unit {
        commonSubscribe1Arg("CharacteristicRead", callback) {
            request: NativeCharacteristicReadRequest => request.toObject()
        }
        return
    }

    /**
     * Unsubscribe characteristicRead changed event.
     *
     * @relation off(type: 'characteristicRead', callback?: Callback<CharacteristicReadRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offCharacteristicRead(callback!: ?Callback1Argument<CharacteristicReadRequest> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe characteristicRead callback event")
        if (!callbackMap.contains("CharacteristicRead")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("CharacteristicRead", v, remove: true)
            return
        }
        callbackMap["CharacteristicRead"].clear()
        return
    }

    /**
     * Subscribe characteristic write event.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'characteristicWrite', callback: Callback<CharacteristicWriteRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onCharacteristicWrite(callback: Callback1Argument<CharacteristicWriteRequest>): Unit {
        commonSubscribe1Arg("CharacteristicWrite", callback) {
            request: NativeCharacteristicWriteRequest => request.toObject()
        }
        return
    }

    /**
     * Unsubscribe mtu changed event.
     *
     * @relation off(type: 'characteristicWrite', callback?: Callback<CharacteristicWriteRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offCharacteristicWrite(callback!: ?Callback1Argument<CharacteristicWriteRequest> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe characteristicWrite callback event")
        if (!callbackMap.contains("CharacteristicWrite")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("CharacteristicWrite", v, remove: true)
            return
        }
        callbackMap["CharacteristicWrite"].clear()
        return
    }

    /**
     * Subscribe descriptor read event.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'descriptorRead', callback: Callback<DescriptorReadRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onDescriptorRead(callback: Callback1Argument<DescriptorReadRequest>): Unit {
        commonSubscribe1Arg("DescriptorRead", callback) {
            request: NativeDescriptorReadRequest => request.toObject()
        }
        return
    }

    /**
     * Unsubscribe mtu changed event.
     *
     * @relation off(type: 'descriptorRead', callback?: Callback<DescriptorReadRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offDescriptorRead(callback!: ?Callback1Argument<DescriptorReadRequest> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe descriptorRead callback event")
        if (!callbackMap.contains("DescriptorRead")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("DescriptorRead", v, remove: true)
            return
        }
        callbackMap["DescriptorRead"].clear()
        return
    }

    /**
     * Subscribe descriptor write event.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'descriptorWrite', callback: Callback<DescriptorWriteRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onDescriptorWrite(callback: Callback1Argument<DescriptorWriteRequest>): Unit {
        commonSubscribe1Arg("DescriptorWrite", callback) {
            request: NativeDescriptorWriteRequest => request.toObject()
        }
        return
    }

    /**
     * Unsubscribe descriptorWrite changed event.
     *
     * @relation off(type: 'descriptorWrite', callback?: Callback<DescriptorWriteRequest>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offDescriptorWrite(callback!: ?Callback1Argument<DescriptorWriteRequest> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe descriptorWrite callback event")
        if (!callbackMap.contains("DescriptorWrite")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("DescriptorWrite", v, remove: true)
            return
        }
        callbackMap["DescriptorWrite"].clear()
        return
    }

    /**
     * Subscribe server connection state changed event.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'connectionStateChange', callback: Callback<BLEConnectionChangeState>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onConnectionStateChange(callback: Callback1Argument<BLEConnectionChangeState>): Unit {
        commonSubscribe1Arg("ConnectionStateChange", callback) {
            request: NativeBLEConnectionChangeState => request.toObject()
        }
        return
    }

    /**
     * Unsubscribe server connection state changed event.
     *
     * @relation off(type: 'connectionStateChange', callback?: Callback<BLEConnectionChangeState>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offConnectionStateChange(callback!: ?Callback1Argument<BLEConnectionChangeState> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe server connection state changed event.")
        if (!callbackMap.contains("ConnectionStateChange")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("ConnectionStateChange", v, remove: true)
            return
        }
        callbackMap["ConnectionStateChange"].clear()
        return
    }

    /**
     * Subscribe mtu changed event.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'BLEMtuChange', callback: Callback<number>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onBLEMtuChange(callback: Callback1Argument<Int32>): Unit {
        commonSubscribe1Arg("BleMtuChange", callback) {
            i: Int32 => i
        }
        return
    }

    /**
     * Unsubscribe mtu changed event.
     *
     * @relation off(type: 'BLEMtuChange', callback?: Callback<number>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offBLEMtuChange(callback!: ?Callback1Argument<Int32> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe mtu changed event.")
        if (!callbackMap.contains("BleMtuChange")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("BleMtuChange", v, remove: true)
            return
        }
        callbackMap["BleMtuChange"].clear()
        return
    }

    private func findCallbackObject(callbackType: String, callback: CallbackObject,
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

    private func argWrapper1<CT, T>(callbackType: String, ctor: (CT) -> T): Int64 where CT <: CType {
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

    private func register(callbackType: String, id: Int64) {
        var errorCode: Int32 = 0
        let eventTypeId: Int32 = match (callbackType) {
            case CharacteristicRead => 0
            case CharacteristicWrite => 1
            case DescriptorRead => 2
            case DescriptorWrite => 3
            case ConnectionStateChange => 4
            case ServerBleMtuChange => 5
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
        unsafe {
            FfiBluetoothBleGattServerOn(getID(), eventTypeId, id, inout errorCode)
        }
        checkRet(errorCode)
    }

    private func commonSubscribe1Arg<CT, T>(callbackType: String, callback: CallbackObject,
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
