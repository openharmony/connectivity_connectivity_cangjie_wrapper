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

import ohos.bluetooth.{ BLUETOOTH_LOG, checkRet, getErrorMsg, OPERATION_FAILED, CallbackController }
import ohos.business_exception.{ BusinessException, AsyncCallback, ERR_PARAMETER_ERROR }
import ohos.callback_invoke.{ CallbackObject, Callback1Argument }
import ohos.ffi.{ Callback1Param, RemoteDataLite, RetDataI32, SUCCESS_CODE, cArr2cjArr, releaseFFIData }
import ohos.labels.APILevel

import std.collection.HashMap

/**
 * Manages GATT client. Before calling an Gatt client method, you must use createGattClientDevice to create an
 * GattClientDevice instance.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class GattClientDevice <: RemoteDataLite {
    private let callbackMap = HashMap<BluetoothBleGattClientDeviceCallbackType, CallbackController>(
        [
            (BleCharacteristicChange, CallbackController()),
            (BleConnectionStateChange, CallbackController()),
            (ClientBleMtuChange, CallbackController())
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
     * The 'BLEConnectionStateChange' event is subscribed to return the connection state.
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
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
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
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
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
     * @returns { String } Returns a string representation of the name if obtained;
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true,
        workerthread: true
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
     * @param { AsyncCallback<Array<GattService>> } callback - Callback used to catch the services.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
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
     * @param { BleCharacteristic } characteristic - Indicates the characteristic to read.
     * @param { AsyncCallback<BleCharacteristic> } callback - Callback invoked to return the characteristic value read.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900011 - The operation is busy. The last operation is not completed.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { BusinessException } 2901000 - Read forbidden.
     * @throws { BusinessException } 2901003 - The connection is not established.
     * @throws { BusinessException } 2901004 - The connection is congested.
     * @throws { BusinessException } 2901005 - The connection is not encrypted.
     * @throws { BusinessException } 2901006 - The connection is not authenticated.
     * @throws { BusinessException } 2901007 - The connection is not authorized.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func readCharacteristicValue(
        characteristic: BleCharacteristic,
        callback: AsyncCallback<BleCharacteristic>
    ): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            ret: RetNativeBLECharacteristic =>
            let regiestError = ret.code
            if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None<BleCharacteristic>)
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
     * @param { BleDescriptor } descriptor - Indicates the descriptor to read.
     * @param { AsyncCallback<BleDescriptor> } callback - Callback invoked to return the descriptor read.
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
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func readDescriptorValue(descriptor: BleDescriptor, callback: AsyncCallback<BleDescriptor>): Unit {
        var errorCode: Int32 = 0
        let wrapper = {
            ret: RetNativeBLEDescriptor =>
            let regiestError = ret.code
            if (regiestError != SUCCESS_CODE) {
                let error = BusinessException(regiestError, getErrorMsg(regiestError))
                callback(error, None<BleDescriptor>)
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
     * @param { BleCharacteristic } characteristic - Indicates the characteristic to write.
     * @param { GattWriteType } writeType - Write type of the characteristic.
     * @param { AsyncCallback<Unit> } callback - Callback used to return the result.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900011 - The operation is busy. The last operation is not completed.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { BusinessException } 2901001 - Write forbidden.
     * @throws { BusinessException } 2901003 - The connection is not established.
     * @throws { BusinessException } 2901004 - The connection is congested.
     * @throws { BusinessException } 2901005 - The connection is not encrypted.
     * @throws { BusinessException } 2901006 - The connection is not authenticated.
     * @throws { BusinessException } 2901007 - The connection is not authorized.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func writeCharacteristicValue(characteristic: BleCharacteristic, writeType: GattWriteType,
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
     * @param { BleDescriptor } descriptor - Indicates the descriptor to write.
     * @param { AsyncCallback<Unit> } callback - Callback used to return the result.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900011 - The operation is busy. The last operation is not complete.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { BusinessException } 2901001 - Write forbidden.
     * @throws { BusinessException } 2901003 - The connection is not established.
     * @throws { BusinessException } 2901004 - The connection is congested.
     * @throws { BusinessException } 2901005 - The connection is not encrypted.
     * @throws { BusinessException } 2901006 - The connection is not authenticated.
     * @throws { BusinessException } 2901007 - The connection is not authorized.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func writeDescriptorValue(descriptor: BleDescriptor, callback: AsyncCallback<Unit>): Unit {
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
     * @param { AsyncCallback<Int32> } callback - Callback invoked to return the RSSI, in dBm.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900011 - The operation is busy. The last operation is not completed.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { BusinessException } 2901003 - The connection is not established.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
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
     * @param { Int32 } mtu - The maximum transmission unit.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func setBleMtuSize(mtu: Int32): Unit {
        var errorCode: Int32 = 0
        unsafe {
            FfiBluetoothBleGattClientDeviceSetBLEMtuSize(getID(), mtu, inout errorCode)
        }
        checkRet(errorCode)
    }

    /**
     * Enables or disables notification of a characteristic when value changed.
     *
     * @param { BleCharacteristic } characteristic - Indicates the characteristic to indicate.
     * @param { Bool } enable - Specifies whether to enable indication of the characteristic. The value true indicates
     * that notification is enabled, and the value false indicates that indication is disabled.
     * @param { AsyncCallback<Unit> } callback - the callback of setCharacteristicChangeNotification.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900011 - The operation is busy. The last operation is not completed.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { BusinessException } 2901003 - The connection is not established.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func setCharacteristicChangeNotification(characteristic: BleCharacteristic, enable: Bool, callback: AsyncCallback<Unit>): Unit {
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
            FfiBluetoothBleGattClientDeviceSetCharacteristicChangeNotificationV2(getID(), inputCharacteristic, enable, registerCall.getID(),
                inout errorCode)
            inputCharacteristic.free()
        }
        checkRet(errorCode)
    }

    /**
     * Enables or disables indication of a characteristic when value changed.
     *
     * @param { BleCharacteristic } characteristic - Indicates the characteristic to indicate.
     * @param { Bool } enable - Specifies whether to enable indication of the characteristic. The value true indicates
     * that indication is enabled, and the value false indicates that indication is disabled.
     * @param { AsyncCallback<Unit> } callback - the callback of setCharacteristicChangeIndication.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900011 - The operation is busy. The last operation is not completed.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { BusinessException } 2901003 - The connection is not established.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func setCharacteristicChangeIndication(characteristic: BleCharacteristic, enable: Bool, callback: AsyncCallback<Unit>): Unit {
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
            FfiBluetoothBleGattClientDeviceSetCharacteristicChangeIndicationV2(getID(), inputCharacteristic, enable, registerCall.getID(),
                inout errorCode)
            inputCharacteristic.free()
        }
        checkRet(errorCode)
    }

    /**
     * Subscribe characteristic value changed event.
     *
     * @param { BluetoothBleGattClientDeviceCallbackType } eventType - Type of the characteristic value changed event to listen for.
     * @param { Callback1Argument<BleCharacteristic> } callback - Callback used to listen for the characteristic value changed event.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    public func on(eventType: BluetoothBleGattClientDeviceCallbackType, callback: Callback1Argument<BleCharacteristic>): Unit {
        if (eventType != BleCharacteristicChange) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is BleCharacteristicChange")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
        commonSubscribe1Arg(eventType, callback) {
            characteristic: NativeBLECharacteristic => characteristic.toObject()
        }
        return
    }

    /**
     * Subscribe client connection state changed event.
     *
     * @param { BluetoothBleGattClientDeviceCallbackType } eventType - Type of the connection state changed event to listen for.
     * @param { Callback1Argument<BleConnectionChangeState> } callback - Callback used to listen for the connection state changed event.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(
        eventType: BluetoothBleGattClientDeviceCallbackType,
        callback: Callback1Argument<BleConnectionChangeState>
    ): Unit {
        if (eventType != BleConnectionStateChange) {
            throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
        }
        commonSubscribe1Arg(eventType, callback) {
            state: NativeBLEConnectionChangeState => state.toObject()
        }
        return
    }

    /**
     * Subscribe mtu changed event.
     *
     * @param { BluetoothBleGattClientDeviceCallbackType } eventType - Type of the mtu changed event to listen for.
     * @param { Callback1Argument<Int32> } callback - Callback used to listen for the mtu changed event.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: BluetoothBleGattClientDeviceCallbackType, callback: Callback1Argument<Int32>): Unit {
        if (eventType != ClientBleMtuChange) {
            throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
        }
        commonSubscribe1Arg(eventType, callback) {
            i: Int32 => i
        }
        return
    }

    /**
     * Unsubscribe gatt client device callback event.
     *
     * @param { BluetoothBleGattClientDeviceCallbackType } eventType - Type of unsubscribe event.
     * @param { ?CallbackObject } [callback] - Callback used to listen.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func off(eventType: BluetoothBleGattClientDeviceCallbackType, callback!: ?CallbackObject = None): Unit {
        BLUETOOTH_LOG.debug("unsubscribe ${eventType}")
        let controller = callbackMap[eventType]
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

    private func argWrapper1<CT, T>(controller: CallbackController, ctor: (CT) -> T): Int64 where CT <: CType {
        let wrapper = {
            ctype: CT =>
            let cjType = ctor(ctype)
            controller.invokeCallback(cjType)
        }
        let registerCall = Callback1Param<CT, Unit>(wrapper)
        registerCall.getID()
    }

    private func register(callbackType: BluetoothBleGattClientDeviceCallbackType, id: Int64) {
        var errorCode: Int32 = 0
        unsafe {
            FfiBluetoothBleGattClientDeviceOn(getID(), callbackType.getValue(), id, inout errorCode)
        }
        checkRet(errorCode)
    }

    private func commonSubscribe1Arg<CT, T>(callbackType: BluetoothBleGattClientDeviceCallbackType,
        callback: CallbackObject, ctor: (CT) -> T) where CT <: CType {
        BLUETOOTH_LOG.debug("subscribe ${callbackType}")
        let controller = callbackMap[callbackType]
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
}
