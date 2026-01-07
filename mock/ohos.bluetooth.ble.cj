/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import ohos.bluetooth.constant.ProfileConnectionState
import ohos.business_exception.AsyncCallback
import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public func createGattServer(): GattServer {
    return GattServer()
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
public func createGattClientDevice(deviceId: String): GattClientDevice {
    return GattClientDevice()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
public func startBleScanning(filters: Array<ScanFilter>, options!: ?ScanOptions = None): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
public func stopBleScanning(): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true, workerthread: true]
public func startAdvertising(setting: AdvertiseSetting, advData: AdvertiseData, advResponse!: ?AdvertiseData = None): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true, workerthread: true]
public func stopAdvertising(): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true, workerthread: true]
public func startAdvertising(advertisingParams: AdvertisingParams): UInt32 {
    return 0
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true, workerthread: true]
public func stopAdvertising(advertisingId: UInt32): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public func on(eventType: BluetoothBleCallbackType, callback: Callback1Argument<AdvertisingStateChangeInfo>): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public func on(eventType: BluetoothBleCallbackType, callback: Callback1Argument<Array<ScanResult>>): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public func off(eventType: BluetoothBleCallbackType, callback!: ?CallbackObject = None): Unit {
    return ()
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class GattClientDevice {
    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func connect(): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func disconnect(): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func close(): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true, workerthread: true]
    public func getDeviceName(): String {
        return String()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func getServices(callback: AsyncCallback<Array<GattService>>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func readCharacteristicValue(
        characteristic: BleCharacteristic,
        callback: AsyncCallback<BleCharacteristic>
    ): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func readDescriptorValue(descriptor: BleDescriptor, callback: AsyncCallback<BleDescriptor>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func writeCharacteristicValue(characteristic: BleCharacteristic, writeType: GattWriteType,
        callback: AsyncCallback<Unit>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func writeDescriptorValue(descriptor: BleDescriptor, callback: AsyncCallback<Unit>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func getRssiValue(callback: AsyncCallback<Int32>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func setBleMtuSize(mtu: Int32): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func setCharacteristicChangeNotification(characteristic: BleCharacteristic, enable: Bool,
        callback: AsyncCallback<Unit>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func setCharacteristicChangeIndication(characteristic: BleCharacteristic, enable: Bool,
        callback: AsyncCallback<Unit>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func on(eventType: BluetoothBleGattClientDeviceCallbackType, callback: Callback1Argument<BleCharacteristic>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func on(
        eventType: BluetoothBleGattClientDeviceCallbackType,
        callback: Callback1Argument<BleConnectionChangeState>
    ): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func on(eventType: BluetoothBleGattClientDeviceCallbackType, callback: Callback1Argument<Int32>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func off(eventType: BluetoothBleGattClientDeviceCallbackType, callback!: ?CallbackObject = None): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class GattServer {
    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func addService(service: GattService): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func removeService(serviceUUID: String): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func close(): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true, workerthread: true]
    public func notifyCharacteristicChanged(deviceId: String, notifyCharacteristic: NotifyCharacteristic): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func sendResponse(serverResponse: ServerResponse): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<CharacteristicReadRequest>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func on(eventType: BluetoothBleGattServerCallbackType,
        callback: Callback1Argument<CharacteristicWriteRequest>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<DescriptorReadRequest>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<DescriptorWriteRequest>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<BleConnectionChangeState>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func on(eventType: BluetoothBleGattServerCallbackType, callback: Callback1Argument<Int32>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func off(eventType: BluetoothBleGattServerCallbackType, callback!: ?CallbackObject = None): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class GattService {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var isPrimary: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristics: Array<BleCharacteristic>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var includeServices: Array<GattService>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        serviceUUID: String,
        isPrimary: Bool,
        characteristics: Array<BleCharacteristic>,
        includeServices!: Array<GattService> = []
    ) {
        super()
        this.serviceUUID = String()
        this.isPrimary = true
        this.characteristics = Array()
        this.includeServices = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class BleCharacteristic {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicValue: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var descriptors: Array<BleDescriptor>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var properties: GattProperties

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        serviceUUID: String,
        characteristicUUID: String,
        characteristicValue: Array<Byte>,
        descriptors: Array<BleDescriptor>,
        properties!: GattProperties = GattProperties(),
        permissions!: GattPermissions = GattPermissions(),
        characteristicValueHandle!: UInt32 = 0
    ) {
        super()
        this.serviceUUID = String()
        this.characteristicUUID = String()
        this.characteristicValue = Array()
        this.descriptors = Array()
        this.properties = GattProperties(
            write: true,
            writeNoResponse: true,
            read: true,
            notify: true,
            indicate: true,
            broadcast: true,
            authenticatedSignedWrite: true,
            extendedProperties: true
        )
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class BleDescriptor {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var descriptorUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var descriptorValue: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        serviceUUID: String,
        characteristicUUID: String,
        descriptorUUID: String,
        descriptorValue: Array<Byte>,
        descriptorHandle!: UInt32 = 0,
        permissions!: GattPermissions = GattPermissions()
    ) {
        super()
        this.serviceUUID = String()
        this.characteristicUUID = String()
        this.descriptorUUID = String()
        this.descriptorValue = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class GattProperties {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var write: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var writeNoResponse: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var read: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var notify: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var indicate: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        write!: Bool = true,
        writeNoResponse!: Bool = true,
        read!: Bool = true,
        notify!: Bool = false,
        indicate!: Bool = false,
        broadcast!: Bool = false,
        authenticatedSignedWrite!: Bool = false,
        extendedProperties!: Bool = false
    ) {
        super()
        this.write = true
        this.writeNoResponse = true
        this.read = true
        this.notify = true
        this.indicate = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class NotifyCharacteristic {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicValue: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var confirm: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        serviceUUID: String,
        characteristicUUID: String,
        characteristicValue: Array<Byte>,
        confirm: Bool
    ) {
        super()
        this.serviceUUID = String()
        this.characteristicUUID = String()
        this.characteristicValue = Array()
        this.confirm = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class ServerResponse {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var transId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var status: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var offset: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var value: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        deviceId: String,
        transId: Int32,
        status: Int32,
        offset: Int32,
        value: Array<Byte>
    ) {
        super()
        this.deviceId = String()
        this.transId = 0
        this.status = 0
        this.offset = 0
        this.value = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum GattWriteType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    Write
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    WriteNoResponse
    | ...
}

extend GattWriteType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend GattWriteType <: Equatable<GattWriteType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: GattWriteType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: GattWriteType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class CharacteristicReadRequest {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var transId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var offset: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String
    
    public init() {
        super()
        this.deviceId = String()
        this.transId = 0
        this.offset = 0
        this.characteristicUUID = String()
        this.serviceUUID = String()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class CharacteristicWriteRequest {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var transId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var offset: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var isPrepared: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var needRsp: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var value: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String
    
    public init() {
        super()
        this.deviceId = String()
        this.transId = 0
        this.offset = 0
        this.isPrepared = true
        this.needRsp = true
        this.value = Array()
        this.characteristicUUID = String()
        this.serviceUUID = String()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class DescriptorReadRequest {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var transId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var offset: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var descriptorUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String
    
    public init() {
        super()
        this.deviceId = String()
        this.transId = 0
        this.offset = 0
        this.descriptorUUID = String()
        this.characteristicUUID = String()
        this.serviceUUID = String()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class DescriptorWriteRequest {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var transId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var offset: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var isPrepared: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var needRsp: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var value: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var descriptorUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var characteristicUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String
    
    public init() {
        super()
        this.deviceId = String()
        this.transId = 0
        this.offset = 0
        this.isPrepared = true
        this.needRsp = true
        this.value = Array()
        this.descriptorUUID = String()
        this.characteristicUUID = String()
        this.serviceUUID = String()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class BleConnectionChangeState {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var state: ProfileConnectionState
    
    public init() {
        super()
        this.deviceId = String()
        this.state = ProfileConnectionState.StateDisconnected
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum BluetoothBleGattServerCallbackType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CharacteristicRead
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CharacteristicWrite
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    DescriptorRead
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    DescriptorWrite
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    ConnectionStateChange
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    ServerBleMtuChange
    | ...
}

extend BluetoothBleGattServerCallbackType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend BluetoothBleGattServerCallbackType <: Hashable {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func hashCode(): Int64 {
        return 0
    }
}

extend BluetoothBleGattServerCallbackType <: Equatable<BluetoothBleGattServerCallbackType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: BluetoothBleGattServerCallbackType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: BluetoothBleGattServerCallbackType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum BluetoothBleGattClientDeviceCallbackType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    BleCharacteristicChange
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    BleConnectionStateChange
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    ClientBleMtuChange
    | ...
}

extend BluetoothBleGattClientDeviceCallbackType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend BluetoothBleGattClientDeviceCallbackType <: Hashable {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func hashCode(): Int64 {
        return 0
    }
}

extend BluetoothBleGattClientDeviceCallbackType <: Equatable<BluetoothBleGattClientDeviceCallbackType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: BluetoothBleGattClientDeviceCallbackType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: BluetoothBleGattClientDeviceCallbackType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class GattPermissions {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var read: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var readEncrypted: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var readEncryptedMitm: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var write: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var writeEncrypted: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var writeEncryptedMitm: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var writeSigned: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var writeSignedMitm: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        read!: Bool = true,
        readEncrypted!: Bool = false,
        readEncryptedMitm!: Bool = false,
        write!: Bool = true,
        writeEncrypted!: Bool = false,
        writeEncryptedMitm!: Bool = false,
        writeSigned!: Bool = false,
        writeSignedMitm!: Bool = false
    ) {
        super()
        this.read = true
        this.readEncrypted = true
        this.readEncryptedMitm = true
        this.write = true
        this.writeEncrypted = true
        this.writeEncryptedMitm = true
        this.writeSigned = true
        this.writeSignedMitm = true
    }
}

extend GattPermissions <: Equatable<GattPermissions> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: GattPermissions): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: GattPermissions): Bool {
        return true
    }
}

extend GattPermissions {}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class ScanFilter {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var name: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUIDMask: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceSolicitationUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceSolicitationUUIDMask: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceData: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceDataMask: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var manufactureId: UInt16

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var manufactureData: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var manufactureDataMask: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        deviceId!: String = "",
        name!: String = "",
        serviceUUID!: String = "",
        serviceUUIDMask!: String = "",
        serviceSolicitationUUID!: String = "",
        serviceSolicitationUUIDMask!: String = "",
        serviceData!: Array<Byte> = [],
        serviceDataMask!: Array<Byte> = [],
        manufactureId!: UInt16 = 0,
        manufactureData!: Array<Byte> = [],
        manufactureDataMask!: Array<Byte> = []
    ) {
        super()
        this.deviceId = String()
        this.name = String()
        this.serviceUUID = String()
        this.serviceUUIDMask = String()
        this.serviceSolicitationUUID = String()
        this.serviceSolicitationUUIDMask = String()
        this.serviceData = Array()
        this.serviceDataMask = Array()
        this.manufactureId = 0
        this.manufactureData = Array()
        this.manufactureDataMask = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class ScanOptions {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var interval: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var dutyMode: ScanDuty

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var matchMode: MatchMode

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var phyType: PhyType

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        interval!: Int32 = 0,
        dutyMode!: ScanDuty = ScanModeLowPower,
        matchMode!: MatchMode = MatchModeAggressive,
        phyType!: PhyType = PhyLe1M,
        reportMode!: ScanReportMode = Normal
    ) {
        super()
        this.interval = 0
        this.dutyMode = ScanDuty.ScanModeLowPower
        this.matchMode = MatchMode.MatchModeAggressive
        this.phyType = PhyType.PhyLe1M
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class AdvertiseSetting {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var interval: UInt16

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var txPower: Int8

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var connectable: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(interval!: UInt16 = 1600, txPower!: Int8 = -7,
        connectable!: Bool = true) {
        super()
        this.interval = 0
        this.txPower = 0
        this.connectable = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class AdvertiseData {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUIDs: Array<String>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var manufactureData: Array<ManufactureData>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceData: Array<ServiceData>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var includeDeviceName: Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        serviceUUIDs: Array<String>,
        manufactureData: Array<ManufactureData>,
        serviceData: Array<ServiceData>,
        includeDeviceName!: Bool = false,
        includeTxPower!: Bool = false
    ) {
        super()
        this.serviceUUIDs = Array()
        this.manufactureData = Array()
        this.serviceData = Array()
        this.includeDeviceName = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class ManufactureData {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var manufactureId: UInt16

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var manufactureValue: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        manufactureId: UInt16,
        manufactureValue: Array<Byte>
    ) {
        super()
        this.manufactureId = 0
        this.manufactureValue = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class ServiceData {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceUUID: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var serviceValue: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        serviceUUID: String,
        serviceValue: Array<Byte>
    ) {
        super()
        this.serviceUUID = String()
        this.serviceValue = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class AdvertisingParams {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var advertisingSettings: AdvertiseSetting

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var advertisingData: AdvertiseData

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var advertisingResponse: AdvertiseData

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var duration: UInt16

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public init(
        advertisingSettings: AdvertiseSetting,
        advertisingData: AdvertiseData,
        advertisingResponse!: AdvertiseData = AdvertiseData([], [], []),
        duration!: UInt16 = 0
    ) {
        super()
        this.advertisingSettings = AdvertiseSetting(
            interval: 0,
            txPower: 0,
            connectable: true
        )
        this.advertisingData = AdvertiseData(
            Array(),
            Array(),
            Array(),
            includeDeviceName: true,
            includeTxPower: true
        )
        this.advertisingResponse = AdvertiseData(
            Array(),
            Array(),
            Array(),
            includeDeviceName: true,
            includeTxPower: true
        )
        this.duration = 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class AdvertisingStateChangeInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var advertisingId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var state: AdvertisingState
    
    public init() {
        super()
        this.advertisingId = 0
        this.state = AdvertisingState.Started
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class ScanResult {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceId: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var rssi: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var data: Array<Byte>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var deviceName: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var connectable: Bool
    
    public init() {
        super()
        this.deviceId = String()
        this.rssi = 0
        this.data = Array()
        this.deviceName = String()
        this.connectable = true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum ScanDuty {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    ScanModeLowPower
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    ScanModeBalanced
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    ScanModeLowLatency
    | ...
}

extend ScanDuty <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend ScanDuty <: Equatable<ScanDuty> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: ScanDuty): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: ScanDuty): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum MatchMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    MatchModeAggressive
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    MatchModeSticky
    | ...
}

extend MatchMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend MatchMode <: Equatable<MatchMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: MatchMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: MatchMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum AdvertisingState {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    Started
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    Enabled
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    Disabled
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    Stopped
    | ...
}

extend AdvertisingState <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend AdvertisingState <: Equatable<AdvertisingState> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: AdvertisingState): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: AdvertisingState): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum PhyType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    PhyLe1M
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    PhyLeAllSupported
    | ...
}

extend PhyType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend PhyType <: Equatable<PhyType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: PhyType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: PhyType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum BluetoothBleCallbackType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    AdvertisingStateChange
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    BleDeviceFind
    | ...
}

extend BluetoothBleCallbackType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend BluetoothBleCallbackType <: Hashable {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func hashCode(): Int64 {
        return 0
    }
}

extend BluetoothBleCallbackType <: Equatable<BluetoothBleCallbackType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: BluetoothBleCallbackType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: BluetoothBleCallbackType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum ScanReportMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    Normal
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    Batch
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    FenceSensitivityLow
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    FenceSensitivityHigh
    | ...
}

extend ScanReportMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend ScanReportMode <: Equatable<ScanReportMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: ScanReportMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: ScanReportMode): Bool {
        return true
    }
}