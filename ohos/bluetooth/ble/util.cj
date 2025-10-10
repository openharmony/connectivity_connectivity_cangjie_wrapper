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

import ohos.labels.*
import ohos.ffi.*

import std.collection.HashMap
import std.deriving.Derive

const BLE_ADV_DEFAULT_INTERVAL: UInt16 = 1600
const BLE_ADV_TX_POWER_MEDIUM_VALUE: Int8 = -7

/**
 * Describes the criteria for filtering scanning results can be set.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class ScanFilter {
    /**
     * The address of a BLE peripheral device
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String

    /**
     * The name of a BLE peripheral device
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var name: String

    /**
     * The service UUID of a BLE peripheral device
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUuid: String

    /**
     * Service UUID mask.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUuidMask: String

    /**
     * Service solicitation UUID.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceSolicitationUuid: String

    /**
     * Service solicitation UUID mask.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceSolicitationUuidMask: String

    /**
     * Service data.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceData: Array<Byte>

    /**
     * Service data mask.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceDataMask: Array<Byte>

    /**
     * Manufacture id.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var manufactureId: UInt16

    /**
     * Manufacture data.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var manufactureData: Array<Byte>

    /**
     * Manufacture data mask.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var manufactureDataMask: Array<Byte>

    /**
     * ScanFilter constructor.
     */    
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        deviceId!: String = "",
        name!: String = "",
        serviceUuid!: String = "",
        serviceUuidMask!: String = "",
        serviceSolicitationUuid!: String = "",
        serviceSolicitationUuidMask!: String = "",
        serviceData!: Array<Byte> = [],
        serviceDataMask!: Array<Byte> = [],
        manufactureId!: UInt16 = 0,
        manufactureData!: Array<Byte> = [],
        manufactureDataMask!: Array<Byte> = []
    ) {
        this.deviceId = deviceId
        this.name = name
        this.serviceUuid = serviceUuid
        this.serviceUuidMask = serviceUuidMask
        this.serviceSolicitationUuid = serviceSolicitationUuid
        this.serviceSolicitationUuidMask = serviceSolicitationUuidMask
        this.serviceData = serviceData
        this.serviceDataMask = serviceDataMask
        this.manufactureId = manufactureId
        this.manufactureData = manufactureData
        this.manufactureDataMask = manufactureDataMask
    }

    func toNative(): NativeScanFilter {
        unsafe {
            var cDeviceId = CString(CPointer<UInt8>())
            var cName = CString(CPointer<UInt8>())
            var cServiceUuid = CString(CPointer<UInt8>())
            var cServiceUuidMask = CString(CPointer<UInt8>())
            var cServiceSolicitationUuid = CString(CPointer<UInt8>())
            var cServiceSolicitationUuidMask = CString(CPointer<UInt8>())
            var cServiceData = CArrUI8(CPointer<UInt8>(), 0)
            var cServiceDataMask = CArrUI8(CPointer<UInt8>(), 0)
            var cManufactureData = CArrUI8(CPointer<UInt8>(), 0)
            var cManufactureDataMask = CArrUI8(CPointer<UInt8>(), 0)
            try {
                cDeviceId = LibC.mallocCString(deviceId)
                cName = LibC.mallocCString(name)
                cServiceUuid = LibC.mallocCString(serviceUuid)
                cServiceUuidMask = LibC.mallocCString(serviceUuidMask)
                cServiceSolicitationUuid = LibC.mallocCString(serviceSolicitationUuid)
                cServiceSolicitationUuidMask = LibC.mallocCString(serviceSolicitationUuidMask)
                cServiceData = CArrUI8(cjArr2CArr<UInt8, UInt8>(serviceData, {i => i}), serviceData.size)
                cServiceDataMask = CArrUI8(cjArr2CArr<UInt8, UInt8>(serviceDataMask, {i => i}), serviceDataMask.size)
                cManufactureData = CArrUI8(cjArr2CArr<UInt8, UInt8>(manufactureData, {i => i}), manufactureData.size)
                cManufactureDataMask = CArrUI8(cjArr2CArr<UInt8, UInt8>(manufactureDataMask, {i => i}), manufactureDataMask.size)

                return NativeScanFilter(
                    cDeviceId,
                    cName,
                    cServiceUuid,
                    cServiceUuidMask,
                    cServiceSolicitationUuid,
                    cServiceSolicitationUuidMask,
                    cServiceData,
                    cServiceDataMask,
                    manufactureId,
                    cManufactureData,
                    cManufactureDataMask
                )
            } catch (e: Exception) {
                LibC.free(cDeviceId)
                LibC.free(cName)
                LibC.free(cServiceUuid)
                LibC.free(cServiceUuidMask)
                LibC.free(cServiceSolicitationUuid)
                LibC.free(cServiceSolicitationUuidMask)
                LibC.free<UInt8>(cServiceData.head)
                LibC.free<UInt8>(cServiceDataMask.head)
                LibC.free<UInt8>(cManufactureData.head)
                throw e
            }
        }
    }
}

@C
struct NativeScanFilter {
    NativeScanFilter(
        let deviceId: CString,
        let name: CString,
        let serviceUuid: CString,
        let serviceUuidMask: CString,
        let serviceSolicitationUuid: CString,
        let serviceSolicitationUuidMask: CString,
        let serviceData: CArrUI8,
        let serviceDataMask: CArrUI8,
        let manufactureId: UInt16,
        let manufactureData: CArrUI8,
        let manufactureDataMask: CArrUI8
    ) {}

    unsafe func free() {
        LibC.free(deviceId)
        LibC.free(name)
        LibC.free(serviceUuid)
        LibC.free(serviceUuidMask)
        LibC.free(serviceSolicitationUuid)
        LibC.free(serviceSolicitationUuidMask)
        LibC.free<UInt8>(serviceData.head)
        LibC.free<UInt8>(serviceDataMask.head)
        LibC.free<UInt8>(manufactureData.head)
        LibC.free<UInt8>(manufactureDataMask.head)
    }
}

@C
struct CArrNativeScanFilter {
    CArrNativeScanFilter(
        let head: CPointer<NativeScanFilter>,
        let size: Int64
    ) {}

    unsafe func free() {
        if (head.isNull()) {
            return
        }
        for (i in 0..this.size) {
            head.read(i).free()
        }
        LibC.free<NativeScanFilter>(head)
    }
}

@C
struct NativeScanOptions {
    NativeScanOptions(
        let interval: Int32,
        let dutyMode: Int32,
        let matchMode: Int32,
        let phyType: Int32
    ) {}
}

/**
 * Describes the parameters for scan.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class ScanOptions {
    /**
     * Time of delay for reporting the scan result
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var interval: Int32

    /**
     * Bluetooth LE scan mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var dutyMode: ScanDuty

    /**
     * Match mode for Bluetooth LE scan filters hardware match
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var matchMode: MatchMode

    /**
     * Physical Layer used during scan.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var phyType: PhyType

    var reportMode: ScanReportMode

    /**
     * ScanOptions constructor.
     */    
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        interval!: Int32 = 0,
        dutyMode!: ScanDuty = ScanModeLowPower,
        matchMode!: MatchMode = MatchModeAggressive,
        phyType!: PhyType = PhyLe1M,
        reportMode!: ScanReportMode = Normal
    ) {
        this.interval = interval
        this.dutyMode = dutyMode
        this.matchMode = matchMode
        this.phyType = phyType
        if (reportMode != Normal) {
            throw IllegalArgumentException("the feature is temporarily not supported.")
        }
        this.reportMode = reportMode
    }

    func toNative(): NativeScanOptions {
        NativeScanOptions(
            interval,
            dutyMode.getValue(),
            matchMode.getValue(),
            phyType.getValue()
        )
    }
}

@C
struct NativeAdvertiseSetting {
    NativeAdvertiseSetting(
        let interval: UInt16,
        let txPower: Int8,
        let connectable: Bool
    ) {}
}

/**
 * Describes the settings for BLE advertising.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class AdvertiseSetting {
    /**
     * Minimum slot value for the advertising interval, which is 32 (20 ms)
     * Maximum slot value for the advertising interval, which is 16777215} (10485.759375s)
     * Default slot value for the advertising interval, which is 1600 (1s)
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var interval: UInt16

    /**
     * Minimum transmission power level for advertising, which is -127
     * Maximum transmission power level for advertising, which is 1
     * Default transmission power level for advertising, which is -7
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var txPower: Int8

    /**
     * Indicates whether the BLE is connectable, default is true
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var connectable: Bool
    
    /**
     * AdvertiseSetting constructor.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(interval!: UInt16 = BLE_ADV_DEFAULT_INTERVAL, txPower!: Int8 = BLE_ADV_TX_POWER_MEDIUM_VALUE, connectable!: Bool = true) {
        this.interval = interval
        this.txPower = txPower
        this.connectable = connectable
    }

    func toNative(): NativeAdvertiseSetting {
        NativeAdvertiseSetting(
            interval,
            txPower,
            connectable
        )
    }
}

@C
struct CArrNativeManufactureData {
    CArrNativeManufactureData(
        let head: CPointer<NativeManufactureData>,
        let size: Int64
    ) {}

    unsafe func free() {
        for (i in 0..size) {
            head.read(i).free()
        }
        LibC.free<NativeManufactureData>(head)
    }
}

@C
struct CArrNativeServiceData {
    CArrNativeServiceData(
        let head: CPointer<NativeServiceData>,
        let size: Int64
    ) {}

    unsafe func free() {
        for (i in 0..size) {
            head.read(i).free()
        }
        LibC.free<NativeServiceData>(head)
    }
}

@C
struct NativeAdvertiseData {
    let serviceUuids: CArrString
    let manufactureData: CArrNativeManufactureData
    let serviceData: CArrNativeServiceData
    let includeDeviceName: Bool
    NativeAdvertiseData(
        serviceUuids: CArrString,
        manufactureData: CArrNativeManufactureData,
        serviceData: CArrNativeServiceData,
        includeDeviceName: Bool
    ) {
        this.serviceUuids = serviceUuids
        this.manufactureData = manufactureData
        this.serviceData = serviceData
        this.includeDeviceName = includeDeviceName
    }

    init() {
        this.serviceUuids = CArrString(CPointer(), 0)
        this.manufactureData = CArrNativeManufactureData(CPointer(), 0)
        this.serviceData = CArrNativeServiceData(CPointer(), 0)
        this.includeDeviceName = false
    }

    unsafe func free() {
        serviceUuids.free()
        manufactureData.free()
        serviceData.free()
    }
}

/**
 * Describes the advertising data.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class AdvertiseData {
    /**
     * The specified service UUID list to this advertisement
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUuids: Array<String>
    /**
     * The specified manufacturer data list to this advertisement
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var manufactureData: Array<ManufactureData>
    /**
     * The specified service data list to this advertisement
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceData: Array<ServiceData>
    /**
     * Indicates whether the device name will be included in the advertisement packet.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var includeDeviceName: Bool

    var includeTxPower: Bool

    /**
     * AdvertiseData constructor.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        serviceUuids: Array<String>,
        manufactureData: Array<ManufactureData>,
        serviceData: Array<ServiceData>,
        includeDeviceName!: Bool = false,
        includeTxPower!: Bool = false
    ) {
        this.serviceUuids = serviceUuids
        this.manufactureData = manufactureData
        this.serviceData = serviceData
        this.includeDeviceName = includeDeviceName
        if (includeTxPower != false) {
            throw IllegalArgumentException("the feature is temporarily not supported.")
        }
        this.includeTxPower = includeTxPower
    }

    func toNative(): NativeAdvertiseData {
        var cServiceUuids: CArrString = CArrString(CPointer(), 0)
        var cManufactureData: CArrNativeManufactureData = CArrNativeManufactureData(CPointer(), 0)
        var cServiceData: CArrNativeServiceData = CArrNativeServiceData(CPointer(), 0)
        unsafe {
            try {
                cServiceUuids = CArrString(cjArr2CArr<String, CString>(serviceUuids, {i => LibC.mallocCString(i)}),
                    serviceUuids.size)
                cManufactureData = CArrNativeManufactureData(
                    cjArr2CArr<ManufactureData, NativeManufactureData>(manufactureData, {i => i.toNative()}),
                    manufactureData.size)
                cServiceData = CArrNativeServiceData(
                    cjArr2CArr<ServiceData, NativeServiceData>(serviceData, {i => i.toNative()}), serviceData.size)
                return NativeAdvertiseData(
                    cServiceUuids,
                    cManufactureData,
                    cServiceData,
                    includeDeviceName
                )
            } catch (e: Exception) {
                cServiceUuids.free()
                cManufactureData.free()
                cServiceData.free()
                throw e
            }
        }
    }
}

@C
struct NativeManufactureData {
    NativeManufactureData(
        let manufactureId: UInt16,
        let manufactureValue: CArrUI8
    ) {}

    unsafe func free() {
        LibC.free<UInt8>(manufactureValue.head)
    }
}

/**
 * Describes the manufacturer data.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class ManufactureData {
    /**
     * Indicates the manufacturer ID assigned by Bluetooth SIG
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var manufactureId: UInt16
    /**
     * Indicates the manufacturer data to add
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var manufactureValue: Array<Byte>

    /**
     * ManufactureData constructor.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        manufactureId: UInt16,
        manufactureValue: Array<Byte>
    ) {
        this.manufactureId = manufactureId
        this.manufactureValue = manufactureValue
    }

    func toNative(): NativeManufactureData {
        unsafe {
            NativeManufactureData(
                manufactureId,
                CArrUI8(cjArr2CArr<UInt8, UInt8>(manufactureValue, {i => i}), manufactureValue.size)
            )
        }
    }
}

@C
struct NativeServiceData {
    NativeServiceData(
        let serviceUuid: CString,
        let serviceValue: CArrUI8
    ) {}

    unsafe func free() {
        LibC.free(serviceUuid)
        LibC.free<UInt8>(serviceValue.head)
    }
}

/**
 * Describes the service data.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class ServiceData {
    /**
     * Indicates the UUID of the service data to add
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceUuid: String
    /**
     * Indicates the service data to add
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var serviceValue: Array<Byte>

    /**
     * ServiceData constructor
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        serviceUuid: String,
        serviceValue: Array<Byte>
    ) {
        this.serviceUuid = serviceUuid
        this.serviceValue = serviceValue
    }

    func toNative(): NativeServiceData {
        var cUuid: CString = CString(CPointer())
        var cValue: CArrUI8 = CArrUI8(CPointer(), 0)
        unsafe {
            try {
                cUuid = LibC.mallocCString(serviceUuid)
                cValue = CArrUI8(cjArr2CArr<UInt8, UInt8>(serviceValue, {i => i}), serviceValue.size)
                return NativeServiceData(cUuid, cValue)
            } catch (e: Exception) {
                LibC.free(cUuid)
                cValue.free()
                throw e
            }
        }
    }
}

@C
struct NativeAdvertisingParams {
    NativeAdvertisingParams(
        let advertisingSettings: NativeAdvertiseSetting,
        let advertisingData: NativeAdvertiseData,
        let advertisingResponse: NativeAdvertiseData,
        let duration: UInt16
    ) {}

    unsafe func free() {
        advertisingData.free()
        advertisingResponse.free()
    }
}

/**
 * Describes the advertising parameters.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class AdvertisingParams {
    /**
     * Indicates the advertising settings.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var advertisingSettings: AdvertiseSetting
    /**
     * Indicates the advertising data.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var advertisingData: AdvertiseData
    /**
     * Indicates the advertising response.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var advertisingResponse: AdvertiseData
    /**
     * Indicates the duration for advertising continuously.
     * The duration, in 10ms unit. Valid range is from 1 (10ms) to 65535 (655,350 ms).
     * If this parameter is not specified or is set to 0, advertisement is continuously sent.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var duration: UInt16

    /**
     * AdvertisingParams constructor.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(
        advertisingSettings: AdvertiseSetting,
        advertisingData: AdvertiseData,
        advertisingResponse!: AdvertiseData = AdvertiseData([], [], []),
        duration!: UInt16 = 0
    ) {
        this.advertisingSettings = advertisingSettings
        this.advertisingData = advertisingData
        this.advertisingResponse = advertisingResponse
        this.duration = duration
    }

    func toNative(): NativeAdvertisingParams {
        var cAdvertisingData: NativeAdvertiseData = advertisingData.toNative()
        var cAdvertisingResponse: NativeAdvertiseData = advertisingResponse.toNative()
        unsafe {
            try {
                cAdvertisingData = advertisingData.toNative()
                cAdvertisingResponse = advertisingResponse.toNative()
                NativeAdvertisingParams(
                    advertisingSettings.toNative(),
                    cAdvertisingData,
                    cAdvertisingResponse,
                    duration
                )
            } catch (e: Exception) {
                cAdvertisingData.free()
                cAdvertisingResponse.free()
                throw e
            }
        }
    }
}

@C
struct CAdvertisingStateChangeInfo {
    CAdvertisingStateChangeInfo(
        let advertisingId: Int32,
        let state: Int32
    ) {}

    func toObject() {
        AdvertisingStateChangeInfo(advertisingId, AdvertisingState.parse(state))
    }
}

/**
 * Advertising state change information.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class AdvertisingStateChangeInfo {
    /**
     * Indicates the ID of current advertising.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var advertisingId: Int32
    /**
     * Indicates the advertising state.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var state: AdvertisingState

    init(advertisingId: Int32, state: AdvertisingState) {
        this.advertisingId = advertisingId
        this.state = state
    }
}

@C
struct NativeScanResult {
    NativeScanResult(
        var deviceId: CString,
        var rssi: Int32,
        var data: CArrUI8,
        var deviceName: CString,
        var connectable: Bool
    ) {}

    func toObject(): ScanResult {
        unsafe {
            ScanResult(
                deviceId.toString(),
                rssi,
                cArr2cjArr<UInt8, Byte>(data.size, data.head, {i => i}),
                deviceName.toString(),
                connectable
            )
        }
    }
}

/**
 * Describes the contents of the scan results.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class ScanResult {
    /**
     * Address of the scanned device
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * RSSI of the remote device
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var rssi: Int32
    /**
     * The raw data of broadcast packet
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var data: Array<Byte>
    /**
     * The local name of the BLE device
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceName: String
    /**
     * Connectable of the remote device
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var connectable: Bool

    init(
        deviceId: String,
        rssi: Int32,
        data: Array<Byte>,
        deviceName: String,
        connectable: Bool
    ) {
        this.deviceId = deviceId
        this.rssi = rssi
        this.data = data
        this.deviceName = deviceName
        this.connectable = connectable
    }
}

/**
 * The enum of scan duty.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ScanDuty {
    /**
     * low power mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeLowPower
    | 
    /**
     * balanced power mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeBalanced
    | 
    /**
     * Scan using highest duty cycle
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ScanModeLowLatency
    | ...

    /**
     * @throws IllegalArgumentException - Value conversion failed.
     */
    func getValue(): Int32 {
        match (this) {
            case ScanModeLowPower => 0
            case ScanModeBalanced => 1
            case ScanModeLowLatency => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * The enum of BLE match mode.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum MatchMode {
    /**
     * aggressive mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MatchModeAggressive
    | 
    /**
     * sticky mode
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    MatchModeSticky
    | ...

    /**
     * @throws IllegalArgumentException - Value conversion failed.
     */
    func getValue(): Int32 {
        match (this) {
            case MatchModeAggressive => 1
            case MatchModeSticky => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

let ADVERTISING_STATE_MAP = HashMap<Int32, AdvertisingState>(
    [
        (1, Started),
        (2, Enabled),
        (3, Disabled),
        (4, Stopped)
    ]
)

/**
 * The enum of BLE advertising state.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum AdvertisingState {
    /**
     * advertising started.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Started
    | 
    /**
     * advertising temporarily enabled.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Enabled
    | 
    /**
     * advertising temporarily disabled.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Disabled
    | 
    /**
     * advertising stopped.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Stopped
    | ...


    /**
     * @throws NoneValueException - Value conversion failed.
     */
    static func parse(state: Int32) {
        ADVERTISING_STATE_MAP.get(state) ?? throw NoneValueException("Unknown state value")
    }
}

/**
 * Phy type used during scan.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum PhyType {
    /**
     * Use 1M phy for scanning.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhyLe1M
    | 
    /**
     * Use all supported Phys for scanning.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    PhyLeAllSupported
    | ...

    /**
     * @throws IllegalArgumentException - Value conversion failed.
     */
    func getValue(): Int32 {
        match (this) {
            case PhyLe1M => 1
            case PhyLeAllSupported => 255
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * Bluetooth Ble CallbackType
 */
@Derive[ToString, Hashable, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum BluetoothBleCallbackType {
    /**
     * Advertising State Change
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    AdvertisingStateChange
    | 
    /**
     * Ble Device Find
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    BleDeviceFind
    | ...

    /**
     * @throws IllegalArgumentException - Value conversion failed.
     */
    func getValue(): Int32 {
        match (this) {
            case AdvertisingStateChange => 0
            case BleDeviceFind => 1
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

@C
struct CArrScanResult {
    CArrScanResult(
        let head: CPointer<NativeScanResult>,
        let size: Int64
    ) {}
}

/**
 * Report mode used during scan.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ScanReportMode {
    /**
     * In normal mode, the advertisement packet is reported immediately after being scanned.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Normal
    |
    /**
     * Enables the batch mode in which advertisement packets are sent after the interval specified by {@link
     * ScanOptions#interval}.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    Batch
    |
    /**
     * In low sensitivity fence mode, the advertisement packets are reported only when they are received for
     * the first time and lost for the last time. The reception sensitivity is low.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    FenceSensitivityLow
    |
    /**
     * In high sensitivity fence mode, the advertisement packets are reported only when they are received for
     * the first time and lost for the last time. The reception sensitivity is high.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    FenceSensitivityHigh
    | ...
}
