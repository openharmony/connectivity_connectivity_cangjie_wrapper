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
import ohos.bluetooth.constant.ProfileConnectionState
import ohos.business_exception.BusinessException
import ohos.ffi.{ CArrUI8, cArr2cjArr, cjArr2CArr}
import ohos.labels.{APILevel, Hide}

import std.deriving.Derive

@C
struct NativeGattService {
    NativeGattService(
        let serviceUUID: CString,
        let isPrimary: Bool,
        let characteristics: CArrBLECharacteristic,
        let includeServices: CArrGattService
    ) {}

    func toObject(): GattService {
        GattService(
            // Universally Unique Identifier translation does not throw exception.
            serviceUUID.toString(),
            isPrimary,
            unsafe {
                cArr2cjArr<NativeBLECharacteristic, BleCharacteristic>(characteristics.size, characteristics.head) {
                    v: NativeBLECharacteristic => v.toObject()
                }
            },
            includeServices: unsafe {
                cArr2cjArr<NativeGattService, GattService>(includeServices.size, includeServices.head) {
                    v: NativeGattService => v.toObject()
                }
            }
        )
    }

    unsafe func free(): Unit {
        LibC.free(serviceUUID)
        characteristics.free()
        includeServices.free()
    }
}

@C
struct CArrBLECharacteristic {
    CArrBLECharacteristic(
        let head: CPointer<NativeBLECharacteristic>,
        let size: Int64
    ) {}

    unsafe func free() {
        if (head.isNull()) {
            return
        }
        for (i in 0..this.size) {
            head.read(i).free()
        }
        LibC.free<NativeBLECharacteristic>(head)
    }
}

@C
struct CArrGattService {
    CArrGattService(
        let head: CPointer<NativeGattService>,
        let size: Int64
    ) {}

    unsafe func free() {
        if (head.isNull()) {
            return
        }
        for (i in 0..this.size) {
            head.read(i).free()
        }
        LibC.free<NativeGattService>(head)
    }
}

/**
 * Describes the Gatt service.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class GattService {
    /**
     * The UUID of a GattService instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String
    /**
     * Indicates whether the GattService instance is primary or secondary.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var isPrimary: Bool
    /**
     * The BleCharacteristic list belongs to this GattService instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristics: Array<BleCharacteristic>
    /**
     * The list of GATT services contained in the service.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var includeServices: Array<GattService>

    /**
     * GattService constructor.
     *
     * @param { String } serviceUUID - The UUID of a GattService instance.
     * @param { Bool } isPrimary - Indicates whether the GattService instance is primary or secondary.
     * @param { Array<BleCharacteristic> } characteristics - The BleCharacteristic list belongs to this GattService instance
     * @param { Array<GattService> } includeServices - The list of GATT services contained in the service.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        serviceUUID: String,
        isPrimary: Bool,
        characteristics: Array<BleCharacteristic>,
        includeServices!: Array<GattService> = []
    ) {
        this.serviceUUID = serviceUUID
        this.isPrimary = isPrimary
        this.characteristics = characteristics
        this.includeServices = includeServices
    }

    /**
     * @throws { BusinessException } 2900010 - Resources have reached the upper limit.
     */
    unsafe func toNative(): NativeGattService {
        var cServiceUUID: CString = CString(CPointer())
        var cCharacteristics: CArrBLECharacteristic = CArrBLECharacteristic(CPointer(), 0)
        var cIncludeServices: CArrGattService = CArrGattService(CPointer(), 0)
        try {
            cServiceUUID = LibC.mallocCString(serviceUUID)
            cCharacteristics = CArrBLECharacteristic(
                cjArr2CArr<BleCharacteristic, NativeBLECharacteristic>(characteristics,
                    {v: BleCharacteristic => v.toNative()}), characteristics.size)
            cIncludeServices = CArrGattService(
                cjArr2CArr<GattService, NativeGattService>(includeServices, {v: GattService => v.toNative()}),
                includeServices.size)
            NativeGattService(
                cServiceUUID,
                isPrimary,
                cCharacteristics,
                cIncludeServices
            )
        } catch (e: Exception) {
            LibC.free(cServiceUUID)
            cCharacteristics.free()
            cIncludeServices.free()
            throw BusinessException(2900010, getErrorMsg(2900010))
        }
    }
}

@C
struct RetNativeBLECharacteristic {
    RetNativeBLECharacteristic(
        let code: Int32,
        let data: NativeBLECharacteristic
    ) {}
}

@C
struct NativeBLECharacteristic {
    let serviceUUID: CString
    let characteristicUUID: CString
    let characteristicValue: CArrUI8
    let descriptors: CArrBLEDescriptor
    let properties: NativeGattProperties
    NativeBLECharacteristic(
        serviceUUID: CString,
        characteristicUUID: CString,
        characteristicValue: CArrUI8,
        descriptors: CArrBLEDescriptor,
        properties: NativeGattProperties
    ) {
        this.serviceUUID = serviceUUID
        this.characteristicUUID = characteristicUUID
        this.characteristicValue = characteristicValue
        this.descriptors = descriptors
        this.properties = properties
    }

    init() {
        this.serviceUUID = CString(CPointer())
        this.characteristicUUID = CString(CPointer())
        this.characteristicValue = CArrUI8(CPointer(), 0)
        this.descriptors = CArrBLEDescriptor(CPointer(), 0)
        this.properties = NativeGattProperties()
    }

    func toObject(): BleCharacteristic {
        BleCharacteristic(
            // Universally Unique Identifier translation does not throw exception.
            serviceUUID.toString(),
            characteristicUUID.toString(),
            unsafe { cArr2cjArr<UInt8, Byte>(characteristicValue.size, characteristicValue.head) {i => i} },
            unsafe {
                cArr2cjArr<NativeBLEDescriptor, BleDescriptor>(descriptors.size, descriptors.head) {
                    v: NativeBLEDescriptor => v.toObject()
                }
            },
            properties: properties.toObject()
        )
    }

    unsafe func free(): Unit {
        LibC.free(serviceUUID)
        LibC.free(characteristicUUID)
        LibC.free<UInt8>(characteristicValue.head)
        descriptors.free()
        // Members of NativeGattProperties do not need to be released.
    }
}

@C
struct CArrBLEDescriptor {
    CArrBLEDescriptor(
        let head: CPointer<NativeBLEDescriptor>,
        let size: Int64
    ) {}

    unsafe func free() {
        if (head.isNull()) {
            return
        }
        for (i in 0..this.size) {
            head.read(i).free()
        }
        LibC.free<NativeBLEDescriptor>(head)
    }
}

/**
 * Describes the Gatt characteristic.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class BleCharacteristic {
    /**
     * The UUID of the GattService instance to which the characteristic belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String
    /**
     * The UUID of a BleCharacteristic instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicUUID: String
    /**
     * The value of a BleCharacteristic instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicValue: Array<Byte>
    /**
     * The list of BleDescriptor contained in the characteristic.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var descriptors: Array<BleDescriptor>
    /**
     * The properties of a BleCharacteristic instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var properties: GattProperties

    var characteristicValueHandle: UInt32

    var permissions: GattPermissions

    /**
     * BleCharacteristic constructor.
     *
     * @param { String } serviceUUID - The UUID of the GattService instance to which the characteristic belongs
     * @param { String } characteristicUUID - The UUID of a BleCharacteristic instance
     * @param { Array<Byte> } characteristicValue - The value of a BleCharacteristic instance
     * @param { Array<BleDescriptor> } descriptors - The list of BleDescriptor contained in the characteristic
     * @param { GattProperties } properties - The properties of a BleCharacteristic instance
     * @param { GattPermissions } permissions - The permissions of a BleCharacteristic instance.
     * The default value is Readable and Writable.
     * @param { UInt32 } characteristicValueHandle - The characteristic value handle of a BleCharacteristic instance
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        serviceUUID: String,
        characteristicUUID: String,
        characteristicValue: Array<Byte>,
        descriptors: Array<BleDescriptor>,
        properties!: GattProperties = GattProperties(),
        permissions!: GattPermissions = GattPermissions(),
        characteristicValueHandle!: UInt32 = 0
    ) {
        this.serviceUUID = serviceUUID
        this.characteristicUUID = characteristicUUID
        this.characteristicValue = characteristicValue
        this.descriptors = descriptors
        this.properties = properties
        if (permissions != GattPermissions() || characteristicValueHandle != 0) {
            throw BusinessException(OPERATION_FAILED, "The feature is temporarily not supported.")
        }
        this.permissions = permissions
        this.characteristicValueHandle = characteristicValueHandle
    }

    /**
     * @throws { BusinessException } 2900010 - Resources have reached the upper limit.
     */
    unsafe func toNative(): NativeBLECharacteristic {
        var cServiceUUID: CString = CString(CPointer())
        var cCharacteristicUUID: CString = CString(CPointer())
        var cCharacteristicValue: CArrUI8 = CArrUI8(CPointer(), 0)
        var cDescriptors: CArrBLEDescriptor = CArrBLEDescriptor(CPointer(), 0)
        var cProperties: NativeGattProperties = NativeGattProperties()
        try {
            cServiceUUID = LibC.mallocCString(serviceUUID)
            cCharacteristicUUID = LibC.mallocCString(characteristicUUID)
            cCharacteristicValue = CArrUI8(cjArr2CArr<Byte, UInt8>(characteristicValue, {i => i}),
                characteristicValue.size)
            cDescriptors = CArrBLEDescriptor(
                cjArr2CArr<BleDescriptor, NativeBLEDescriptor>(descriptors, {v: BleDescriptor => v.toNative()}),
                descriptors.size)
            cProperties = properties.toNative()
            NativeBLECharacteristic(
                cServiceUUID,
                cCharacteristicUUID,
                cCharacteristicValue,
                cDescriptors,
                cProperties
            )
        } catch (e: Exception) {
            LibC.free(cServiceUUID)
            LibC.free(cCharacteristicUUID)
            cCharacteristicValue.free()
            cDescriptors.free()
            throw BusinessException(2900010, getErrorMsg(2900010))
        }
    }
}

@C
struct RetNativeBLEDescriptor {
    RetNativeBLEDescriptor(
        let code: Int32,
        let data: NativeBLEDescriptor
    ) {}
}

@C
struct NativeBLEDescriptor {
    NativeBLEDescriptor(
        let serviceUUID: CString,
        let characteristicUUID: CString,
        let descriptorUUID: CString,
        let descriptorValue: CArrUI8
    ) {}

    func toObject(): BleDescriptor {
        BleDescriptor(
            // Universally Unique Identifier translation does not throw exception.
            serviceUUID.toString(),
            characteristicUUID.toString(),
            descriptorUUID.toString(),
            unsafe { cArr2cjArr<UInt8, Byte>(descriptorValue.size, descriptorValue.head) {i => i} }
        )
    }

    unsafe func free(): Unit {
        LibC.free(serviceUUID)
        LibC.free(characteristicUUID)
        LibC.free(descriptorUUID)
        LibC.free<UInt8>(descriptorValue.head)
    }
}

/**
 * Describes the Gatt descriptor.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class BleDescriptor {
    /**
     * The UUID of the GattService instance to which the descriptor belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String
    /**
     * The UUID of the BleCharacteristic instance to which the descriptor belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicUUID: String
    /**
     * The UUID of the BleDescriptor instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var descriptorUUID: String
    /**
     * The value of the BleDescriptor instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var descriptorValue: Array<Byte>

    var descriptorHandle: UInt32
    var permissions: GattPermissions

    /**
     * BleDescriptor constructor.
     *
     * @param { String } serviceUUID - The UUID of the GattService instance to which the descriptor belongs
     * @param { String } characteristicUUID - The UUID of the GattService instance to which the descriptor belongs
     * @param { String } descriptorUUID - The UUID of the BleDescriptor instance
     * @param { Array<Byte> } descriptorValue - The value of the BleDescriptor instance
     * @param { UInt32 } descriptorHandle - The descriptor handle of a BleDescriptor instance
     * @param { GattPermissions } permissions - The permissions of a BleDescriptor instance. The default value is Readable and Writable.
     * The default value is Readable and Writable.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        serviceUUID: String,
        characteristicUUID: String,
        descriptorUUID: String,
        descriptorValue: Array<Byte>,
        descriptorHandle!: UInt32 = 0,
        permissions!: GattPermissions = GattPermissions()
    ) {
        this.serviceUUID = serviceUUID
        this.characteristicUUID = characteristicUUID
        this.descriptorUUID = descriptorUUID
        this.descriptorValue = descriptorValue
        if (descriptorHandle!= 0 || permissions != GattPermissions()) {
            throw BusinessException(OPERATION_FAILED, "The feature is temporarily not supported.")
        }
        this.descriptorHandle = descriptorHandle
        this.permissions = permissions
    }

    /**
     * @throws { BusinessException } 2900010 - Resources have reached the upper limit.
     */
    unsafe func toNative(): NativeBLEDescriptor {
        var nativeServiceUUID: CString = CString(CPointer())
        var nativeCharacteristicUUID: CString = CString(CPointer())
        var nativeDescriptorUUID: CString = CString(CPointer())

        try {
            nativeServiceUUID = LibC.mallocCString(serviceUUID)
            nativeCharacteristicUUID = LibC.mallocCString(characteristicUUID)
            nativeDescriptorUUID = LibC.mallocCString(descriptorUUID)
        } catch (e: Exception) {
            LibC.free(nativeServiceUUID)
            LibC.free(nativeCharacteristicUUID)
            throw BusinessException(2900010, getErrorMsg(2900010))
        }
        NativeBLEDescriptor(
            nativeServiceUUID,
            nativeCharacteristicUUID,
            nativeDescriptorUUID,
            CArrUI8(cjArr2CArr<Byte, UInt8>(descriptorValue, {i => i}), descriptorValue.size)
        )
    }
}

@C
struct NativeGattProperties {
    let write: Bool
    let writeNoResponse: Bool
    let read: Bool
    let notify: Bool
    let indicate: Bool

    NativeGattProperties(
        write: Bool,
        writeNoResponse: Bool,
        read: Bool,
        notify: Bool,
        indicate: Bool
    ) {
        this.write = write
        this.writeNoResponse = writeNoResponse
        this.read = read
        this.notify = notify
        this.indicate = indicate
    }

    init() {
        this.write = true
        this.writeNoResponse = true
        this.read = true
        this.notify = false
        this.indicate = false
    }

    func toObject(): GattProperties {
        GattProperties(
            write: this.write,
            writeNoResponse: this.writeNoResponse,
            read: this.read,
            notify: this.notify,
            indicate: this.indicate
        )
    }
}

/**
 * Describes the properties of a gatt characteristic.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class GattProperties {
    /**
     * Support write property of the characteristic.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var write: Bool
    /**
     * Support write no response property of the characteristic.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var writeNoResponse: Bool
    /**
     * Support read property of the characteristic.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var read: Bool
    /**
     * Support notify property of the characteristic.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var notify: Bool
    /**
     * Support indicate property of the characteristic.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var indicate: Bool

    var broadcast: Bool
    var authenticatedSignedWrite: Bool
    var extendedProperties: Bool

    /**
     * GattProperties constructor.
     *
     * @param { Bool } write - Support write property of the characteristic.
     * @param { Bool } writeNoResponse - Support write no response property of the characteristic.
     * @param { Bool } read - Support read property of the characteristic.
     * @param { Bool } notify - Support notify property of the characteristic.
     * @param { Bool } indicate - Support indicate property of the characteristic.
     * @param { Bool } broadcast - Support broadcast property of the characteristic.
     * @param { Bool } authenticatedSignedWrite - Support authenticated signed write property of the characteristic.
     * @param { Bool } extendedProperties - Support extended properties property of the characteristic.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
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
        this.write = write
        this.writeNoResponse = writeNoResponse
        this.read = read
        this.notify = notify
        this.indicate = indicate
        if (broadcast != false || authenticatedSignedWrite != false || extendedProperties != false) {
            throw BusinessException(OPERATION_FAILED, "The feature is temporarily not supported.")
        }
        this.broadcast = broadcast
        this.authenticatedSignedWrite = authenticatedSignedWrite
        this.extendedProperties = extendedProperties
    }

    unsafe func toNative(): NativeGattProperties {
        NativeGattProperties(
            write,
            writeNoResponse,
            read,
            notify,
            indicate
        )
    }
}

@C
struct NativeNotifyCharacteristic {
    NativeNotifyCharacteristic(
        let serviceUUID: CString,
        let characteristicUUID: CString,
        let characteristicValue: CArrUI8,
        let confirm: Bool
    ) {}

    unsafe func free(): Unit {
        LibC.free(serviceUUID)
        LibC.free(characteristicUUID)
        LibC.free<UInt8>(characteristicValue.head)
    }
}

/**
 * Describes the value of the indication or notification sent by the Gatt server.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class NotifyCharacteristic {
    /**
     * The UUID of the GattService instance to which the characteristic belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String
    /**
     * The UUID of a NotifyCharacteristic instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicUUID: String
    /**
     * The value of a NotifyCharacteristic instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicValue: Array<Byte>
    /**
     * Specifies whether to request confirmation from the BLE peripheral device (indication) or
     * send a notification. Value true indicates the former and false indicates the latter.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var confirm: Bool

    /**
     * NotifyCharacteristic constructor.
     *
     * @param { String } serviceUUID - The UUID of the GattService instance to which the characteristic belongs
     * @param { String } characteristicUUID - The UUID of a NotifyCharacteristic instance
     * @param { Array<Byte> } characteristicValue - The value of a NotifyCharacteristic instance
     * @param { Bool } confirm - Specifies whether to request confirmation from the BLE peripheral device (indication) or
     * send a notification. Value true indicates the former and false
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        serviceUUID: String,
        characteristicUUID: String,
        characteristicValue: Array<Byte>,
        confirm: Bool
    ) {
        this.serviceUUID = serviceUUID
        this.characteristicUUID = characteristicUUID
        this.characteristicValue = characteristicValue
        this.confirm = confirm
    }

    /**
     * @throws { BusinessException } 2900010 - Resources have reached the upper limit.
     */
    unsafe func toNative(): NativeNotifyCharacteristic {
        var cServiceUUID: CString = CString(CPointer())
        var cCharacteristicUUID: CString = CString(CPointer())
        var cCharacteristicValue: CArrUI8 = CArrUI8(CPointer(), 0)
        try {
            cServiceUUID = LibC.mallocCString(serviceUUID)
            cCharacteristicUUID = LibC.mallocCString(characteristicUUID)
            cCharacteristicValue = CArrUI8(cjArr2CArr<Byte, UInt8>(characteristicValue, {i => i}),
                characteristicValue.size)
            NativeNotifyCharacteristic(
                cServiceUUID,
                cCharacteristicUUID,
                cCharacteristicValue,
                confirm
            )
        } catch (e: Exception) {
            LibC.free(cServiceUUID)
            LibC.free(cCharacteristicUUID)
            cCharacteristicValue.free()
            throw BusinessException(2900010, getErrorMsg(2900010))
        }
    }
}

@C
struct NativeServerResponse {
    NativeServerResponse(
        let deviceId: CString,
        let transId: Int32,
        let status: Int32,
        let offset: Int32,
        let value: CArrUI8
    ) {}

    unsafe func free(): Unit {
        LibC.free(deviceId)
        LibC.free<UInt8>(value.head)
    }
}

/**
 * Describes the parameters of a response send by the server to a specified read or write request.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class ServerResponse {
    /**
     * Indicates the address of the client to which to send the response.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * The Id of the write request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var transId: Int32
    /**
     * Indicates the status of the read or write request, set this parameter to '0' in normal cases.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var status: Int32
    /**
     * Indicates the byte offset of the start position for reading or writing operation.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var offset: Int32
    /**
     * Indicates the value to be sent.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var value: Array<Byte>

    /**
     * ServerResponse constructor.
     *
     * @param { String } deviceId - Indicates the address of the client to which to send the response
     * @param { Int32 } transId  - The Id of the write request
     * @param { Int32 } status - Indicates the status of the read or write request, set this parameter to '0' in normal cases
     * @param { Int32 } offset - Indicates the byte offset of the start position for reading or writing operation
     * @param { Array<Byte> } value - Indicates the value to be sent
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        deviceId: String,
        transId: Int32,
        status: Int32,
        offset: Int32,
        value: Array<Byte>
    ) {
        this.deviceId = deviceId
        this.transId = transId
        this.status = status
        this.offset = offset
        this.value = value
    }

    /**
     * @throws { BusinessException } 2900010 - Resources have reached the upper limit.
     */
    unsafe func toNative(): NativeServerResponse {
        var cDeviceId = CString(CPointer())
        var cValue = CArrUI8(CPointer(), 0)
        try {
            cDeviceId = LibC.mallocCString(deviceId)
            cValue = CArrUI8(cjArr2CArr<Byte, UInt8>(value, {i => i}), value.size)
            NativeServerResponse(
                cDeviceId,
                transId,
                status,
                offset,
                cValue
            )
        } catch (e: Exception) {
            LibC.free(cDeviceId)
            cValue.free()
            throw BusinessException(2900010, getErrorMsg(2900010))
        }
    }
}

/**
 * The enum of gatt characteristic write type
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum GattWriteType {
    /**
     * Write characteristic with response.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Write
    | 
    /**
     * Write characteristic without response.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    WriteNoResponse
    | ...

    func getValue(): Int32 {
        match (this) {
            case Write => 0
            case WriteNoResponse => 1
            case _ => throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
        }
    }
}

@C
struct NativeCharacteristicReadRequest {
    NativeCharacteristicReadRequest(
        let deviceId: CString,
        let transId: Int32,
        let offset: Int32,
        let characteristicUUID: CString,
        let serviceUUID: CString
    ) {}

    func toObject(): CharacteristicReadRequest {
        CharacteristicReadRequest(
            // MAC address translation does not throw exception.
            deviceId.toString(),
            transId,
            offset,
            // Universally Unique Identifier translation does not throw exception.
            characteristicUUID.toString(),
            serviceUUID.toString()
        )
    }
}

/**
 * Describes the parameters of the Gatt client's characteristic read request.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class CharacteristicReadRequest {
    /**
     * Indicates the address of the client that initiates the read request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * The Id of the read request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var transId: Int32
    /**
     * Indicates the byte offset of the start position for reading characteristic value
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var offset: Int32
    /**
     * The UUID of a CharacteristicReadRequest instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicUUID: String
    /**
     * The UUID of the service to which the characteristic belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String

    init(
        deviceId: String,
        transId: Int32,
        offset: Int32,
        characteristicUUID: String,
        serviceUUID: String
    ) {
        this.deviceId = deviceId
        this.transId = transId
        this.offset = offset
        this.characteristicUUID = characteristicUUID
        this.serviceUUID = serviceUUID
    }
}

@C
struct NativeCharacteristicWriteRequest {
    NativeCharacteristicWriteRequest(
        let deviceId: CString,
        let transId: Int32,
        let offset: Int32,
        let isPrepared: Bool,
        let needRsp: Bool,
        let value: CArrUI8,
        let characteristicUUID: CString,
        let serviceUUID: CString
    ) {}

    func toObject(): CharacteristicWriteRequest {
        CharacteristicWriteRequest(
            // MAC address translation does not throw exception.
            deviceId.toString(),
            transId,
            offset,
            isPrepared,
            needRsp,
            unsafe { cArr2cjArr<UInt8, Byte>(value.size, value.head) {i => i} },
            // Universally Unique Identifier translation does not throw exception.
            characteristicUUID.toString(),
            serviceUUID.toString()
        )
    }
}

/**
 * Describes the parameters of the of the Gatt client's characteristic write request.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class CharacteristicWriteRequest {
    /**
     * Indicates the address of the client that initiates the write request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * The Id of the write request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var transId: Int32
    /**
     * Indicates the byte offset of the start position for writing characteristic value.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var offset: Int32
    /**
     * Whether this request should be pending for later operation.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var isPrepared: Bool
    /**
     * Whether the remote client need a response.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var needRsp: Bool
    /**
     * Indicates the value to be written.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var value: Array<Byte>
    /**
     * The UUID of a CharacteristicWriteRequest instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicUUID: String
    /**
     * The UUID of the service to which the characteristic belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String

    init(
        deviceId: String,
        transId: Int32,
        offset: Int32,
        isPrepared: Bool,
        needRsp: Bool,
        value: Array<Byte>,
        characteristicUUID: String,
        serviceUUID: String
    ) {
        this.deviceId = deviceId
        this.transId = transId
        this.offset = offset
        this.isPrepared = isPrepared
        this.needRsp = needRsp
        this.value = value
        this.characteristicUUID = characteristicUUID
        this.serviceUUID = serviceUUID
    }
}

@C
struct NativeDescriptorReadRequest {
    NativeDescriptorReadRequest(
        let deviceId: CString,
        let transId: Int32,
        let offset: Int32,
        let descriptorUUID: CString,
        let characteristicUUID: CString,
        let serviceUUID: CString
    ) {}

    func toObject(): DescriptorReadRequest {
        DescriptorReadRequest(
            // MAC address translation does not throw exception.
            deviceId.toString(),
            transId,
            offset,
            // Universally Unique Identifier translation does not throw exception.
            descriptorUUID.toString(),
            characteristicUUID.toString(),
            serviceUUID.toString()
        )
    }
}

/**
 * Describes the parameters of the Gatt client's descriptor read request.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class DescriptorReadRequest {
    /**
     * Indicates the address of the client that initiates the read request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * The Id of the read request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var transId: Int32
    /**
     * Indicates the byte offset of the start position for reading characteristic value.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var offset: Int32
    /**
     * The UUID of a DescriptorReadRequest instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var descriptorUUID: String
    /**
     * The UUID of the characteristic to which the descriptor belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicUUID: String
    /**
     * The UUID of the service to which the descriptor belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String

    init(
        deviceId: String,
        transId: Int32,
        offset: Int32,
        descriptorUUID: String,
        characteristicUUID: String,
        serviceUUID: String
    ) {
        this.deviceId = deviceId
        this.transId = transId
        this.offset = offset
        this.descriptorUUID = descriptorUUID
        this.characteristicUUID = characteristicUUID
        this.serviceUUID = serviceUUID
    }
}

@C
struct NativeDescriptorWriteRequest {
    NativeDescriptorWriteRequest(
        let deviceId: CString,
        let transId: Int32,
        let offset: Int32,
        let isPrepared: Bool,
        let needRsp: Bool,
        let value: CArrUI8,
        let descriptorUUID: CString,
        let characteristicUUID: CString,
        let serviceUUID: CString
    ) {}

    func toObject(): DescriptorWriteRequest {
        DescriptorWriteRequest(
            // MAC address translation does not throw exception.
            deviceId.toString(),
            transId,
            offset,
            isPrepared,
            needRsp,
            unsafe { cArr2cjArr<UInt8, Byte>(value.size, value.head) {i => i} },
            // Universally Unique Identifier translation does not throw exception.
            descriptorUUID.toString(),
            characteristicUUID.toString(),
            serviceUUID.toString()
        )
    }
}

/**
 * Describes the parameters of the Gatt client's characteristic write request.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class DescriptorWriteRequest {
    /**
     * Indicates the address of the client that initiates the write request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * The Id of the write request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var transId: Int32
    /**
     * Indicates the byte offset of the start position for writing characteristic value.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var offset: Int32
    /**
     * Whether this request should be pending for later operation.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var isPrepared: Bool
    /**
     * Whether the remote client need a response.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var needRsp: Bool
    /**
     * Indicates the value to be written.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var value: Array<Byte>
    /**
     * The UUID of a DescriptorWriteRequest instance.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var descriptorUUID: String
    /**
     * The UUID of the characteristic to which the descriptor belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var characteristicUUID: String
    /**
     * The UUID of the service to which the descriptor belongs.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUUID: String

    init(
        deviceId: String,
        transId: Int32,
        offset: Int32,
        isPrepared: Bool,
        needRsp: Bool,
        value: Array<Byte>,
        descriptorUUID: String,
        characteristicUUID: String,
        serviceUUID: String
    ) {
        this.deviceId = deviceId
        this.transId = transId
        this.offset = offset
        this.isPrepared = isPrepared
        this.needRsp = needRsp
        this.value = value
        this.descriptorUUID = descriptorUUID
        this.characteristicUUID = characteristicUUID
        this.serviceUUID = serviceUUID
    }
}

@C
struct NativeBLEConnectionChangeState {
    NativeBLEConnectionChangeState(
        let deviceId: CString,
        let state: Int32
    ) {}

    func toObject(): BleConnectionChangeState {
        BleConnectionChangeState(
            // MAC address translation does not throw exception.
            deviceId.toString(),
            ProfileConnectionState.parse(state)
        )
    }
}

/**
 * Describes the Gatt profile connection state.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class BleConnectionChangeState {
    /**
     * Indicates the peer device address.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * Connection state of the Gatt profile.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var state: ProfileConnectionState

    @!Hide
    internal var reason: Option<GattDisconnectReason> = None

    init(
        deviceId: String,
        state: ProfileConnectionState
    ) {
        this.deviceId = deviceId
        this.state = state
    }
}

/**
 * Bluetooth Ble GattServer CallbackType.
 */
@Derive[ToString, Hashable, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum BluetoothBleGattServerCallbackType {
    /**
     * Characteristic read request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CharacteristicRead
    | 
    /**
     * Characteristic write request.
     *
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CharacteristicWrite
    | 
    /**
     * Descriptor read request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    DescriptorRead
    | 
    /**
     * Descriptor write request.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    DescriptorWrite
    | 
    /**
     * Connection state changed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectionStateChange
    | 
    /**
     * Server ble mtu changed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ServerBleMtuChange
    | ...

    func getValue(): Int32 {
        match (this) {
            case CharacteristicRead => 0
            case CharacteristicWrite => 1
            case DescriptorRead => 2
            case DescriptorWrite => 3
            case ConnectionStateChange => 4
            case ServerBleMtuChange => 5
            case _ => throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
        }
    }
}

/**
 * Bluetooth Ble GattClientDevice CallbackType.
 */
@Derive[ToString, Hashable, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum BluetoothBleGattClientDeviceCallbackType {
    /**
     * BLE characteristic changed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    BleCharacteristicChange
    | 
    /**
     * BLE connection state changed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    BleConnectionStateChange
    | 
    /**
     * Client ble mtu changed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ClientBleMtuChange
    | ...

    func getValue(): Int32 {
        match (this) {
            case BleCharacteristicChange => 0
            case BleConnectionStateChange => 1
            case ClientBleMtuChange => 2
            case _ => throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
        }
    }
}

/**
 * Describes the permission of a att attribute item.
 */
@Derive[Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class GattPermissions {
    /**
     * The attribute field has the read permission.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var read: Bool

    /**
     * The attribute field has the encrypted read permission.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var readEncrypted: Bool

    /**
     * The attribute field has the read permission for encryption authentication.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var readEncryptedMitm: Bool

    /**
     * The attribute field has the write permission.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var write: Bool

    /**
     * The attribute field has the encrypted write permission.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var writeEncrypted: Bool

    /**
     * The attribute field has the write permission for encryption authentication.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var writeEncryptedMitm: Bool

    /**
     * The attribute field has the signed write permission.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var writeSigned: Bool

    /**
     * The attribute field has the write permission for signature authentication.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var writeSignedMitm: Bool

    /**
     * GattPermissions constructor.
     *
     * @param { Bool } read -  The attribute field has the read permission.
     * @param { Bool } readEncrypted - The attribute field has the encrypted read permission.
     * @param { Bool } readEncryptedMitm - The attribute field has the read permission for encryption authentication.
     * @param { Bool } write - The attribute field has the write permission.
     * @param { Bool } writeEncrypted - The attribute field has the encrypted write permission.
     * @param { Bool } writeEncryptedMitm - The attribute field has the write permission for encryption authentication.
     * @param { Bool } writeSigned - The attribute field has the signed write permission.
     * @param { Bool } writeSignedMitm - The attribute field has the write permission for signature authentication.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init (
        read!: Bool = true,
        readEncrypted!: Bool = false,
        readEncryptedMitm!: Bool = false,
        write!: Bool = true,
        writeEncrypted!: Bool = false,
        writeEncryptedMitm!: Bool = false,
        writeSigned!: Bool = false,
        writeSignedMitm!: Bool = false
    ) {
        this.read = read
        this.readEncrypted = readEncrypted
        this.readEncryptedMitm = readEncryptedMitm
        this.write = write
        this.writeEncrypted = writeEncrypted
        this.writeEncryptedMitm = writeEncryptedMitm
        this.writeSigned = writeSigned
        this.writeSignedMitm = writeSignedMitm
    }
}

@!Hide
enum GattDisconnectReason {
    @!Hide
    CONN_TIMEOUT
    |
    @!Hide
    CONN_TERMINATE_PEER_USER
    |
    @!Hide
    CONN_TERMINATE_LOCAL_HOST
    |
    @!Hide
    CONN_UNKNOWN
    | ...
}