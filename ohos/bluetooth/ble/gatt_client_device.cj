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

import ohos.bluetooth.{ BLUETOOTH_LOG, checkRet, getErrorMsg }
import ohos.business_exception.{ BusinessException, AsyncCallback, ERR_PARAMETER_ERROR }
import ohos.callback_invoke.{ CallbackObject, Callback1Argument }
import ohos.ffi.{ Callback1Param, RemoteDataLite, RetDataI32, SUCCESS_CODE, cArr2cjArr, releaseFFIData }
import ohos.labels.APILevel

import std.collection.{ArrayList, HashMap}

/**
 * Manages GATT client. Before calling an Gatt client method, you must use createGattClientDevice to create an GattClientDevice instance.
 *
 * @relation interface GattClientDevice
 */
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class GattClientDevice <: RemoteDataLite {
    private let callbackMap = HashMap<String, ArrayList<CallbackObject>>()
    private let registerMap = HashMap<String, Bool>(
        [
            ("BleCharacteristicChange", false),
            ("BleConnectionStateChange", false),
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
     * Connects to a BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @relation connect(): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func connect(): Unit {
        var errorCode: Int32 = 0
        unsafe {
            FfiBluetoothBleGattClientDeviceConnect(getID(), inout errorCode)
        }
        checkRet(errorCode)
    }

    /**
     * Disconnects from or stops an ongoing connection to a BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @relation disconnect(): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func disconnect(): Unit {
        var errorCode: Int32 = 0
        unsafe {
            FfiBluetoothBleGattClientDeviceDisconnect(getID(), inout errorCode)
        }
        checkRet(errorCode)
    }

    /**
     * Disables a BLE peripheral device.
     * This method unregisters the device and clears the registered callbacks and handles.
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
            FfiBluetoothBleGattClientDeviceClose(getID(), inout errorCode)
        }
        checkRet(errorCode)
    }

    /**
     * Obtains the name of BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation getDeviceName(): Promise<string>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getDeviceName(): String {
        var errorCode: Int32 = 0
        var outName: String = ""
        unsafe {
            let name = FfiBluetoothBleGattClientDeviceGetDeviceName(getID(), inout errorCode)
            // may be invalid UTF8 and may be parsed abnormally.
            try {
                outName = name.toString()
            } finally {
                LibC.free(name)
            }
        }
        checkRet(errorCode)
        return outName
    }

    /**
     * Starts discovering services.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation getServices(): Promise<Array<GattService>>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getServices(callback: AsyncCallback<Array<GattService>>): Unit {
        spawn {
            var errorCode: Int32 = 0
            let outServices: Array<GattService>
            unsafe {
                let nativeServices: CArrGattService = FfiBluetoothBleGattClientDeviceGetServices(getID(), inout errorCode)
                outServices = cArr2cjArr<NativeGattService, GattService>(nativeServices.size, nativeServices.head) {
                    v: NativeGattService => v.toObject()
                }
                nativeServices.free()
            }
            if (errorCode != SUCCESS_CODE) {
                let error = BusinessException(errorCode, getErrorMsg(errorCode))
                callback(error, None)
            } else {
                callback(None, outServices)
            }
        }
        return
    }

    /**
     * Reads the characteristic of a BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2901000 - Read forbidden.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation readCharacteristicValue(characteristic: BLECharacteristic): Promise<BLECharacteristic>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func readCharacteristicValue(
        characteristic: BLECharacteristic,
        callback: AsyncCallback<BLECharacteristic>
    ): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            ret: RetNativeBLECharacteristic =>
            let regiestError = ret.code
            if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None<BLECharacteristic>)
            } else {
                callback(None<BusinessException>, ret.data.toObject())
            }
        }
        let registerCall = Callback1Param<RetNativeBLECharacteristic, Unit>(wrapper)
        unsafe {
            let inputCharacteristic = characteristic.toNative()
            FfiBluetoothBleGattClientDeviceReadCharacteristicValue(getID(), inputCharacteristic, registerCall.getID(),
                inout errorCode)
            inputCharacteristic.free()
        }
        checkRet(errorCode)
    }

    /**
     * Reads the descriptor of a BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900011 - The operation is busy. The last operation is not complete.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { BusinessException } 2901000 - Read forbidden.
     * @throws { BusinessException } 2901003 - The connection is not established.
     * @throws { BusinessException } 2901004 - The connection is congested.
     * @throws { BusinessException } 2901005 - The connection is not encrypted.
     * @throws { BusinessException } 2901006 - The connection is not authenticated.
     * @throws { BusinessException } 2901007 - The connection is not authorized.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation readDescriptorValue(descriptor: BLEDescriptor): Promise<BLEDescriptor>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func readDescriptorValue(descriptor: BLEDescriptor, callback: AsyncCallback<BLEDescriptor>): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            ret: RetNativeBLEDescriptor =>
            let regiestError = ret.code
            if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None<BLEDescriptor>)
            } else {
                callback(None<BusinessException>, ret.data.toObject())
            }
        }
        let registerCall = Callback1Param<RetNativeBLEDescriptor, Unit>(wrapper)
        unsafe {
            let inputDescriptor = descriptor.toNative()
            FfiBluetoothBleGattClientDeviceReadDescriptorValue(getID(), inputDescriptor, registerCall.getID(),
                inout errorCode)
            inputDescriptor.free()
        }
        checkRet(errorCode)
    }

    /**
     * Writes the characteristic of a BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2901001 - Write forbidden.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation writeCharacteristicValue(characteristic: BLECharacteristic, writeType: GattWriteType): Promise<void>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func writeCharacteristicValue(characteristic: BLECharacteristic, writeType: GattWriteType,
        callback: AsyncCallback<Unit>): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            regiestError: Int32 => if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None)
            } else {
                callback(None, ())
            }
        }
        let registerCall = Callback1Param<Int32, Unit>(wrapper)
        unsafe {
            let inputCharacteristic: NativeBLECharacteristic = characteristic.toNative()
            FfiBluetoothBleGattClientDeviceWriteCharacteristicValue(getID(), inputCharacteristic, writeType.getValue(),
                registerCall.getID(), inout errorCode)
            inputCharacteristic.free()
        }
        checkRet(errorCode)
    }

    /**
     * Writes the descriptor of a BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2901001 - Write forbidden.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation writeDescriptorValue(descriptor: BLEDescriptor): Promise<void>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func writeDescriptorValue(descriptor: BLEDescriptor, callback: AsyncCallback<Unit>): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            regiestError: Int32 => if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None)
            } else {
                callback(None, ())
            }
        }
        let registerCall = Callback1Param<Int32, Unit>(wrapper)
        unsafe {
            let inputDescriptor: NativeBLEDescriptor = descriptor.toNative()
            FfiBluetoothBleGattClientDeviceWriteDescriptorValue(getID(), inputDescriptor, registerCall.getID(),
                inout errorCode)
            inputDescriptor.free()
        }
        checkRet(errorCode)
    }

    /**
     * Get the RSSI value of this BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation getRssiValue(): Promise<number>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getRssiValue(callback: AsyncCallback<Int32>): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            retRssi: RetDataI32 => if (retRssi.code != SUCCESS_CODE) {
                let error = BusinessException(retRssi.code, getErrorMsg(retRssi.code))
                callback(error, None<Int32>)
            } else {
                callback(None<BusinessException>, retRssi.data)
            }
        }
        let registerCall = Callback1Param<RetDataI32, Unit>(wrapper)
        unsafe { FfiBluetoothBleGattClientDeviceGetRssiValue(getID(), registerCall.getID(), inout errorCode) }
        checkRet(errorCode)
    }

    /**
     * Set the mtu size of a BLE peripheral device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation setBLEMtuSize(mtu: number): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func setBLEMtuSize(mtu: Int32): Unit {
        var errorCode: Int32 = 0
        unsafe {
            FfiBluetoothBleGattClientDeviceSetBLEMtuSize(getID(), mtu, inout errorCode)
        }
        checkRet(errorCode)
    }

    /**
     * Enables or disables indication of a characteristic when value changed.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation setCharacteristicChangeNotification(characteristic: BLECharacteristic, enable: boolean): Promise<void>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func setCharacteristicChangeNotification(characteristic: BLECharacteristic, enable: Bool, callback: AsyncCallback<Unit>): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            regiestError: Int32 => if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None)
            } else {
                callback(None, ())
            }
        }
        let registerCall = Callback1Param<Int32, Unit>(wrapper)
        unsafe {
            let inputCharacteristic: NativeBLECharacteristic = characteristic.toNative()
            FfiBluetoothBleGattClientDeviceSetCharacteristicChangeNotification(getID(), inputCharacteristic, enable,
                inout errorCode)
            inputCharacteristic.free()
        }
        checkRet(errorCode)
    }

    /**
     * Enables or disables indication of a characteristic when value changed.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation setCharacteristicChangeIndication(characteristic: BLECharacteristic, enable: boolean): Promise<void>
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func setCharacteristicChangeIndication(characteristic: BLECharacteristic, enable: Bool, callback: AsyncCallback<Unit>): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            regiestError: Int32 => if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None)
            } else {
                callback(None, ())
            }
        }
        let registerCall = Callback1Param<Int32, Unit>(wrapper)
        unsafe {
            let inputCharacteristic: NativeBLECharacteristic = characteristic.toNative()
            FfiBluetoothBleGattClientDeviceSetCharacteristicChangeIndication(getID(), inputCharacteristic, enable,
                inout errorCode)
            inputCharacteristic.free()
        }
        checkRet(errorCode)
    }

    /**
     * Subscribe characteristic value changed event.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'BLECharacteristicChange', callback: Callback<BLECharacteristic>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onBLECharacteristicChange(callback: Callback1Argument<BLECharacteristic>): Unit {
        commonSubscribe1Arg("BleCharacteristicChange", callback) {
            characteristic: NativeBLECharacteristic => characteristic.toObject()
        }
        return
    }

    /**
     * Unsubscribe characteristic value changed event.
     *
     * @relation off(type: 'BLECharacteristicChange', callback?: Callback<BLECharacteristic>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offBLECharacteristicChange(callback!: ?Callback1Argument<BLECharacteristic> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe characteristic value changed event.")
        if (!callbackMap.contains("BLECharacteristicChange")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("BLECharacteristicChange", v, remove: true)
            return
        }
        callbackMap["BLECharacteristicChange"].clear()
        return
    }

    /**
     * Subscribe client connection state changed event.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @relation on(type: 'BLEConnectionStateChange', callback: Callback<BLEConnectionChangeState>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onBLEConnectionStateChange(callback: Callback1Argument<BLEConnectionChangeState>): Unit {
        commonSubscribe1Arg("BleConnectionStateChange", callback) {
            state: NativeBLEConnectionChangeState => state.toObject()
        }
        return
    }

    /**
     * Unsubscribe client connection state changed event.
     *
     * @relation off(type: 'BLEConnectionStateChange', callback?: Callback<BLEConnectionChangeState>): void
     */
    @!APILevel[
        21,
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offBLEConnectionStateChange(callback!: ?Callback1Argument<BLEConnectionChangeState> = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe client connection state changed event.")
        if (!callbackMap.contains("BLEConnectionStateChange")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("BLEConnectionStateChange", v, remove: true)
            return
        }
        callbackMap["BLEConnectionStateChange"].clear()
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
        if (!callbackMap.contains("BLEMtuChange")) {
            return
        }
        if (let Some(v) <- callback) {
            findCallbackObject("BLEMtuChange", v, remove: true)
            return
        }
        callbackMap["BLEMtuChange"].clear()
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
            case "BleCharacteristicChange" => 0
            case "BleConnectionStateChange" => 1
            case "ClientBleMtuChange" => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
        unsafe {
            FfiBluetoothBleGattClientDeviceOn(getID(), eventTypeId, id, inout errorCode)
        }
        checkRet(errorCode)
    }

    private func commonSubscribe1Arg<CT, T>(callbackType: String,
        callback: CallbackObject, ctor: (CT) -> T) where CT <: CType {
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
