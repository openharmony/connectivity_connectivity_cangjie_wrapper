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
package ohos_app_cangjie_entry

internal import kit.BasicServicesKit.*
internal import ohos.base.*
internal import std.collection.*
import kit.ConnectivityKit.*
import kit.AbilityKit.*
import std.unittest.testmacro.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.callback_invoke.*
import ohos.business_exception.*

let gattServer = createGattServer()

@Test
class Test_ble {
    protected func beforeAll() {
        ["ohos.permission.ACCESS_BLUETOOTH"] |>
            forEach<Permissions> {
            permissionName: Permissions =>
            getRequiredPermissions([permissionName])
            try {
                sleepFor(1.second)
                click(at: Screen.getTheOnlyUiComponentWhoseTextEqualsTo("允许").centerPoint)
            } catch (e: Exception) {}
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_GattWriteType() {
        let arr1: Array<GattWriteType> = [
            Write,
            WriteNoResponse
        ]
        let arrStr: Array<String> = [
            "GattWriteType.Write",
            "GattWriteType.WriteNoResponse"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_BluetoothBleGattServerCallbackType() {
        let arr1: Array<BluetoothBleGattServerCallbackType> = [
            CharacteristicRead,
            CharacteristicWrite,
            DescriptorRead,
            DescriptorWrite,
            ConnectionStateChange,
            ServerBleMtuChange
        ]
        let arrStr: Array<String> = [
            "BluetoothBleGattServerCallbackType.CharacteristicRead",
            "BluetoothBleGattServerCallbackType.CharacteristicWrite",
            "BluetoothBleGattServerCallbackType.DescriptorRead",
            "BluetoothBleGattServerCallbackType.DescriptorWrite",
            "BluetoothBleGattServerCallbackType.ConnectionStateChange",
            "BluetoothBleGattServerCallbackType.ServerBleMtuChange"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
            var hash = arr1[i].hashCode()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_BluetoothBleGattClientDeviceCallbackType() {
        let arr1: Array<BluetoothBleGattClientDeviceCallbackType> = [
            BleCharacteristicChange,
            BleConnectionStateChange,
            ClientBleMtuChange
        ]
        let arrStr: Array<String> = [
            "BluetoothBleGattClientDeviceCallbackType.BleCharacteristicChange",
            "BluetoothBleGattClientDeviceCallbackType.BleConnectionStateChange",
            "BluetoothBleGattClientDeviceCallbackType.ClientBleMtuChange"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
            var hash = arr1[i].hashCode()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_ScanDuty() {
        let arr1: Array<ScanDuty> = [
            ScanModeLowPower,
            ScanModeBalanced,
            ScanModeLowLatency
        ]
        let arrStr: Array<String> = [
            "ScanDuty.ScanModeLowPower",
            "ScanDuty.ScanModeBalanced",
            "ScanDuty.ScanModeLowLatency"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_MatchMode() {
        let arr1: Array<MatchMode> = [
            MatchModeAggressive,
            MatchModeSticky
        ]
        let arrStr: Array<String> = [
            "MatchMode.MatchModeAggressive",
            "MatchMode.MatchModeSticky"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_AdvertisingState() {
        let arr1: Array<AdvertisingState> = [
            Started,
            Enabled,
            Disabled,
            Stopped
        ]
        let arrStr: Array<String> = [
            "AdvertisingState.Started",
            "AdvertisingState.Enabled",
            "AdvertisingState.Disabled",
            "AdvertisingState.Stopped"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_PhyType() {
        let arr1: Array<PhyType> = [
            PhyLe1M,
            PhyLeAllSupported
        ]
        let arrStr: Array<String> = [
            "PhyType.PhyLe1M",
            "PhyType.PhyLeAllSupported"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_BluetoothBleCallbackType() {
        let arr1: Array<BluetoothBleCallbackType> = [
            BluetoothBleCallbackType.AdvertisingStateChange,
            BleDeviceFind
        ]
        let arrStr: Array<String> = [
            "BluetoothBleCallbackType.AdvertisingStateChange",
            "BluetoothBleCallbackType.BleDeviceFind"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
            var hash = arr1[i].hashCode()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GattService() {
        let serviceUUID = "114514"
        let isPrimary = true
        let characteristics: Array<BLECharacteristic> = []
        let includeServices: Array<GattService> = []
        var gattService: GattService = GattService(serviceUUID, isPrimary, characteristics, includeServices: includeServices)
        gattService.serviceUUID = "12"
        gattService.isPrimary = false
        gattService.characteristics = characteristics
        gattService.includeServices = includeServices
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_BLECharacteristic() {
        let serviceUUID: String = "11"
        let characteristicUUID: String = "11"
        let characteristicValue: Array<Byte> = []
        let descriptors: Array<BLEDescriptor> = []
        let properties: GattProperties = GattProperties()
        let bleCharacteristic = BLECharacteristic(serviceUUID, characteristicUUID, characteristicValue, descriptors, properties: properties, permissions: GattPermissions(), characteristicValueHandle: 0)
        bleCharacteristic.serviceUUID = serviceUUID
        bleCharacteristic.characteristicUUID = characteristicUUID
        bleCharacteristic.characteristicValue = characteristicValue
        bleCharacteristic.descriptors = descriptors
        bleCharacteristic.properties = properties
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_BLEDescriptor() {
        let serviceUUID = "11"
        let characteristicUUID = "11"
        let descriptorUUID = "11"
        let descriptorValue: Array<Byte> = []
        let bleDescriptor = BLEDescriptor(serviceUUID, characteristicUUID, descriptorUUID, descriptorValue)
        bleDescriptor.serviceUUID = serviceUUID
        bleDescriptor.characteristicUUID = characteristicUUID
        bleDescriptor.descriptorUUID = descriptorUUID
        bleDescriptor.descriptorValue = descriptorValue
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_NotifyCharacteristic() {
        let serviceUUID = "11"
        let characteristicUUID = "11"
        let characteristicValue: Array<Byte> = []
        let confirm = true
        let notifyCharacteristic = NotifyCharacteristic(serviceUUID, characteristicUUID, characteristicValue, confirm)
        notifyCharacteristic.serviceUUID = "12"
        notifyCharacteristic.characteristicUUID = "12"
        notifyCharacteristic.characteristicValue = []
        notifyCharacteristic.confirm = false
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_ScanFilter() {
        let deviceId = "11"
        let name = "test"
        let serviceUUID = "11"
        let serviceUUIDMask = "11"
        let serviceSolicitationUUID = "11"
        let serviceSolicitationUUIDMask = "11"
        let serviceData: Array<Byte> = []
        let serviceDataMask: Array<Byte> = []
        let manufactureId = 1u16
        let manufactureData: Array<Byte> = []
        let manufactureDataMask: Array<Byte> = []

        let scanFilter = ScanFilter()

        scanFilter.deviceId = deviceId
        scanFilter.name = name
        scanFilter.serviceUUID = serviceUUID
        scanFilter.serviceUUIDMask = serviceUUIDMask
        scanFilter.serviceSolicitationUUID = serviceSolicitationUUID
        scanFilter.serviceSolicitationUUIDMask = serviceSolicitationUUIDMask
        scanFilter.serviceData = serviceData
        scanFilter.serviceDataMask = serviceDataMask
        scanFilter.manufactureId = manufactureId
        scanFilter.manufactureData = manufactureData
        scanFilter.manufactureDataMask = manufactureDataMask
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_ScanOptions() {
        let interval = 0i32
        let dutyMode = ScanModeLowPower
        let matchMode = MatchModeAggressive
        let phyType = PhyLe1M
        let scanOptions: ScanOptions = ScanOptions(interval: interval, dutyMode: dutyMode, matchMode: matchMode, phyType: phyType, reportMode: ScanReportMode.Normal)
        scanOptions.interval = 1i32
        scanOptions.dutyMode = ScanModeLowPower
        scanOptions.matchMode = MatchModeAggressive
        scanOptions.phyType = PhyLe1M
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_AdvertiseSetting() {
        let interval = 1600u16
        let txPower = -7i8
        let connectable = true
        let advertiseSetting: AdvertiseSetting = AdvertiseSetting(interval: interval, txPower: txPower, connectable: connectable)
        advertiseSetting.interval = 1601u16
        advertiseSetting.txPower = -6i8
        advertiseSetting.connectable = false
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_AdvertiseData() {
        let serviceUUIDs: Array<String> = []
        let manufactureData: Array<ManufactureData> = []
        let serviceData: Array<ServiceData> = []
        let includeDeviceName: Bool = false
        let advertiseData: AdvertiseData = AdvertiseData(
            serviceUUIDs, manufactureData, serviceData, includeDeviceName: includeDeviceName)
        advertiseData.serviceUUIDs = []
        advertiseData.manufactureData = []
        advertiseData.serviceData = []
        advertiseData.includeDeviceName = true
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_ManufactureData() {
        let manufactureId: UInt16 = 1u16
        let manufactureValue: Array<Byte> = []
        let manufactureData: ManufactureData = ManufactureData(manufactureId, manufactureValue)
        manufactureData.manufactureId = 0u16
        manufactureData.manufactureValue = []
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_ServiceData() {
        let serviceUUID: String = "11"
        let serviceValue: Array<Byte> = []
        let serviceData: ServiceData = ServiceData(serviceUUID, serviceValue)
        serviceData.serviceUUID = "12"
        serviceData.serviceValue = []
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_AdvertisingParams() {
        let interval = 1600u16
        let txPower = -7i8
        let connectable = true
        let advertiseSetting: AdvertiseSetting = AdvertiseSetting(interval: interval, txPower: txPower, connectable: connectable)
        let advertisingData: AdvertiseData = AdvertiseData([], [], [])
        let advertisingResponse: AdvertiseData = AdvertiseData([], [], [])

        let advertisingParams: AdvertisingParams = AdvertisingParams(advertiseSetting, advertisingData, advertisingResponse: advertisingResponse, duration: 0)
        advertisingParams.advertisingSettings = advertiseSetting
        advertisingParams.advertisingData = advertisingData
        advertisingParams.advertisingResponse = advertisingResponse
    }

    // AdvertisingStateChangeInfo

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GattProperties() {
        let gattProperties: GattProperties = GattProperties()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_ServerResponse() {
        let deviceId = "0A:1B:2C:3D:4D:5F"
        let transId = 1i32
        let status = 1i32
        let offset = 1i32
        let value: Array<Byte> = [11, 45, 14]
        let serverResponse: ServerResponse = ServerResponse(deviceId, transId, status, offset, value)
        var getdeviceId = serverResponse.deviceId
        var gettransId = serverResponse.transId
        var getstatus = serverResponse.status
        var getoffset = serverResponse.offset
        var getvalue = serverResponse.value
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GattServer_On_BLE_MTU_CHANGE() {
        let gattServer: GattServer = createGattServer()
        let callBackType: BluetoothBleGattServerCallbackType = BluetoothBleGattServerCallbackType.ServerBleMtuChange
        let callBack = BLEMtuChangeCallback()
        gattServer.on(callBackType, callBack)
        gattServer.off(callBackType)
        try {
            gattServer.close()
        } catch (e: BusinessException) {
            // 201, message: Permission verification failed. The application does not have the permission required to call the API
            loggerInfo("gattServer.close error ${e}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_createGattServer() {
        try {
            let gattServer: GattServer = createGattServer()
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_createGattClientDevice() {
        try {
            // 参数是对端设备地址，地址无效，报错 401
            let device: GattClientDevice = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        } catch (e: BusinessException) {
            loggerInfo("test_createGattClientDevice error ${e}")
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_createGattClientDevice_param_format_error() {
        try {
            // 参数是对端设备地址，地址格式校验失败，报错401，有效的格式应为0-9，A-F，a-f
            let device: GattClientDevice = createGattClientDevice("XX:XX:XX:XX:XX:XX")
        } catch (e: Exception) {
            loggerInfo("test_createGattClientDevice error ${e}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_startBLEScan() {
        try {
            var scanFilter = ScanFilter()
            let scanOptions = ScanOptions(interval: 0, dutyMode: ScanDuty.ScanModeLowPower, matchMode: MatchMode.MatchModeAggressive, phyType: PhyType.PhyLe1M, reportMode: ScanReportMode.Normal)
            startBLEScan([scanFilter], options: scanOptions)
        } catch (e: Exception) {
            loggerInfo("test_startBLEScan error ${e}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_stopBLEScan() {
        try {
            stopBLEScan()
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_startAdvertising() {
        try {
            let advertisingSettings = AdvertiseSetting(interval: 32, txPower: 0, connectable: true)
            let manufactureDataUnit = ManufactureData(
                4567u16,
                [1, 2, 3, 4]
            )
            let serviceDataUnit = ServiceData(
                "00001888-0000-1000-8000-00805f9b34fb",
                [5, 6, 7, 8]
            )
            let advertisingData = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit],
                includeDeviceName: true
            )
            let advertisingResponse = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit]
            )
            startAdvertising(advertisingSettings, advertisingData, advResponse: advertisingResponse)
        } catch (e: BusinessException) {
            // error code: 2902054
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_stopAdvertising() {
        try {
            let advertisingSettings = AdvertiseSetting(interval: 32, txPower: 0, connectable: true)
            let manufactureDataUnit = ManufactureData(
                4567u16,
                [1, 2, 3, 4]
            )
            let serviceDataUnit = ServiceData(
                "00001888-0000-1000-8000-00805f9b34fb",
                [5, 6, 7, 8]
            )
            let advertisingData = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit],
                includeDeviceName: true
            )
            let advertisingResponse = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit]
            )
            stopAdvertising()
        } catch (e: BusinessException) {
            // error code: 2902054
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_startAdvertising_AdvertisingParams() {
        try {
            let advertisingSettings = AdvertiseSetting(interval: 32, txPower: 0, connectable: true)
            let manufactureDataUnit = ManufactureData(
                4567u16,
                [1, 2, 3, 4]
            )
            let serviceDataUnit = ServiceData(
                "00001888-0000-1000-8000-00805f9b34fb",
                [5, 6, 7, 8]
            )
            let advertisingData = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit],
                includeDeviceName: true
            )
            let advertisingResponse = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit]
            )
            let advertisingParams = AdvertisingParams(
                advertisingSettings,
                advertisingData,
                advertisingResponse: advertisingResponse,
                duration: 300
            )
            let advHandle = startAdvertising(advertisingParams)
        } catch (e: BusinessException) {
            loggerInfo("test_startAdvertising_AdvertisingParams error ${e}")
            // error code: 2902054
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_stopAdvertising_UInt32() {
        try {
            let advertisingSettings = AdvertiseSetting(interval: 32, txPower: 0, connectable: true)
            let manufactureDataUnit = ManufactureData(
                4567u16,
                [1, 2, 3, 4]
            )
            let serviceDataUnit = ServiceData(
                "00001888-0000-1000-8000-00805f9b34fb",
                [5, 6, 7, 8]
            )
            let advertisingData = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit],
                includeDeviceName: true
            )
            let advertisingResponse = AdvertiseData(
                ["00001888-0000-1000-8000-00805f9b34fb"],
                [manufactureDataUnit],
                [serviceDataUnit]
            )
            let advertisingParams = AdvertisingParams(
                advertisingSettings,
                advertisingData,
                advertisingResponse: advertisingResponse,
                duration: 300
            )
            var advHandle: UInt32 = 0xFF

            advHandle = startAdvertising(advertisingParams)
            stopAdvertising(advHandle)
        } catch (e: BusinessException) {
            loggerInfo("test_stopAdvertising_UInt32 error ${e}")
            // error code: 2902054
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testStopAdvertisingWithInvalidId() {
        try {
            // Invalid id
            stopAdvertising(UInt32(99))
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_BluetoothBleCallbackType_Callback1Argument_AdvertisingStateChangeInfo() {
        try {
            let advertisingStateChange = AdvertisingStateChange()
            on(BluetoothBleCallbackType.AdvertisingStateChange, advertisingStateChange)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_BluetoothBleCallbackType_Callback1Argument_Array_ScanResult() {
        try {
            let bleDeviceFindCallback = BLEDeviceFindCallback()
            on(BleDeviceFind, bleDeviceFindCallback)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_off_BluetoothBleCallbackType_CallbackObject() {
        try {
            let bleDeviceFindCallback = BLEDeviceFindCallback()
            on(BleDeviceFind, bleDeviceFindCallback)
            off(BleDeviceFind, callback: bleDeviceFindCallback)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_connect() {
        try {
            let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
            gattClient.connect()
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_disconnect() {
        try {
            let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
            gattClient.connect()
            gattClient.disconnect()
            gattClient.close()
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getDeviceName() {
        try {
            let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
            let deviceName = gattClient.getDeviceName()
        } catch (e: BusinessException) {
            loggerInfo("getDeviceName error ${e}")
            // 创建client的参数无效，获取不到DeviceName
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getServices() {
        try {
            var resCallback:  AsyncCallback<Array<GattService>> = {
                errorCode: Option<BusinessException>, data: Option<Array<GattService>> => match (errorCode) {
                    case Some(e) => loggerError("CallBack  error: errcode is ${e.code}")
                    case _ =>
                        match (data) {
                            case Some(value) =>
                                loggerInfo("CallBack getServices size: ${value.size}")
                            case _ => loggerInfo("CallBack error: data is null")
                        }
                }
            }
            let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
            let services = gattClient.getServices(resCallback)
        } catch (e: BusinessException) {
            loggerInfo("getServices error ${e}")
            // 创建client的参数无效，获取不到Services
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readCharacteristicValue() {
        try {
            let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
            let descBuffer: Array<Byte> = [31, 32]
            let descriptor = BLEDescriptor(
                "00001810-0000-1000-8000-00805F9B34FB",
                "00001820-0000-1000-8000-00805F9B34FB",
                "00002902-0000-1000-8000-00805F9B34FB",
                Array<Byte>(2, repeat: 0)
            )
            // 创建characteristics
            let descriptors: Array<BLEDescriptor> = [descriptor]
            let charBuffer: Array<Byte> = [21, 22]
            let properties = GattProperties()

            let characteristic: BLECharacteristic = BLECharacteristic(
                "00001810-0000-1000-8000-00805F9B34FB",
                "00001820-0000-1000-8000-00805F9B34FB",
                charBuffer,
                descriptors,
                properties: properties, permissions: GattPermissions(), characteristicValueHandle: 0
            )

            gattClient.readCharacteristicValue(characteristic) {
                error: ?BusinessException, outData: ?BLECharacteristic =>
                if (let Some(e) <- error) {
                    throw e
                }
                if (let Some(c) <- outData) {
                    loggerInfo( "read characteristic value uuid is ${c.characteristicUUID}")
                    let message = StringBuilder("logCharacteristic value: ")
                    for (i in 0..c.characteristicValue.size) {
                        message.append(c.characteristicValue[i])
                    }
                    loggerInfo( message.toString())
                }
            }
        } catch (e: BusinessException) {
            loggerInfo("readCharacteristicValue error ${e}")
            // 创建client的参数无效，readCharacteristicValue报错
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readDescriptorValue() {
        try {
            let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")

            let descBuffer: Array<Byte> = [31, 32]
            let descriptor = BLEDescriptor(
                "00001810-0000-1000-8000-00805F9B34FB",
                "00001820-0000-1000-8000-00805F9B34FB",
                "00002903-0000-1000-8000-00805F9B34FB",
                Array<Byte>(2, repeat: 0)
            )

            gattClient.readDescriptorValue(descriptor) {
                error: ?BusinessException, outDescriptor: ?BLEDescriptor =>
                if (let Some(e) <- error) {
                    throw e
                }
                if (let Some(d) <- outDescriptor) {
                    loggerInfo( "read descriptor value uuid is ${d.descriptorUUID}")
                    let message = StringBuilder("logDescriptor value: ")
                    for (i in 0..d.descriptorValue.size) {
                        message.append(d.descriptorValue[i])
                    }
                    loggerInfo( message.toString())
                }
            }
        } catch (e: BusinessException) {
            loggerInfo("readDescriptorValue error ${e}")
            // 创建client的参数无效，readDescriptorValue 报错
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeCharacteristicValue() {
        try {
            let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")

            let descBuffer: Array<Byte> = [31, 32]
            let descriptor = BLEDescriptor(
                "00001810-0000-1000-8000-00805F9B34FB",
                "00001820-0000-1000-8000-00805F9B34FB",
                "00002902-0000-1000-8000-00805F9B34FB",
                Array<Byte>(2, repeat: 0)
            )

            let descriptors: Array<BLEDescriptor> = [descriptor]
            let charBuffer: Array<Byte> = [21, 22]
            let properties = GattProperties()

            let characteristic: BLECharacteristic = BLECharacteristic(
                "00001810-0000-1000-8000-00805F9B34FB",
                "00001820-0000-1000-8000-00805F9B34FB",
                charBuffer,
                descriptors,
                properties: properties, permissions: GattPermissions(), characteristicValueHandle: 0
            )

            gattClient.writeCharacteristicValue(characteristic, GattWriteType.Write) {
                error: ?BusinessException, u: ?Unit => if (let Some(e) <- error) {
                    throw e
                }
            }
        } catch (e: BusinessException) {
            loggerInfo("writeCharacteristicValue error ${e}")
            // 创建client的参数无效，writeCharacteristicValue 报错
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_BluetoothBleGattServerCallbackType_Callback1Argument_CharacteristicReadRequest() {
        try {
            let characteristicReadCallback = CharacteristicReadCallback()
            gattServer.on(CharacteristicRead, characteristicReadCallback)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_BluetoothBleGattServerCallbackType_Callback1Argument_CharacteristicWriteRequest() {
        try {
            let characteristicWriteCallback = CharacteristicWriteCallback()
            gattServer.on(CharacteristicWrite, characteristicWriteCallback)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_BluetoothBleGattServerCallbackType_Callback1Argument_DescriptorReadRequest() {
        try {
            let descriptorReadCallback = DescriptorReadCallback()
            gattServer.on(DescriptorRead, descriptorReadCallback)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_BluetoothBleGattServerCallbackType_Callback1Argument_DescriptorWriteRequest() {
        try {
            let descriptorWriteCallback = DescriptorWriteCallback()
            gattServer.on(DescriptorWrite, descriptorWriteCallback)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_BluetoothBleGattServerCallbackType_Callback1Argument_BLEConnectionChangeState() {
        try {
            let stateChangeCallback = StateChangeCallback()
            gattServer.on(BluetoothBleGattServerCallbackType.ConnectionStateChange, stateChangeCallback)
            gattServer.off(BluetoothBleGattServerCallbackType.ConnectionStateChange)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeDescriptorValue() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        let descBuffer: Array<Byte> = [31, 32]
        let descriptor = BLEDescriptor(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            "00002903-0000-1000-8000-00805F9B34FB",
            Array<Byte>(2, repeat: 0)
        )
        let descriptors: BLEDescriptor = descriptor
        let charBuffer: Array<Byte> = [1, 2]
        let properties = GattProperties()

        try {
            gattClient.writeDescriptorValue(descriptors) {
                error: ?BusinessException, u: ?Unit => if (let Some(e) <- error) {
                    throw e
                }
            }
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getRssiValue() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        try {
            gattClient.getRssiValue {
                error: ?BusinessException, rssi: ?Int32 =>
                if (let Some(e) <- error) {
                    throw e
                }
                loggerInfo( "the rssi value is " + rssi.getOrThrow().toString())
            }
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_setBLEMtuSize() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        try {
            gattClient.setBLEMtuSize(100)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_setCharacteristicChangeNotification() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")

        // 创建descriptors
        let descBuffer: Array<Byte> = [31, 32]
        let descriptor = BLEDescriptor(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            "00002902-0000-1000-8000-00805F9B34FB",
            Array<Byte>(2, repeat: 0)
        )
        // 创建characteristics
        let descriptors: Array<BLEDescriptor> = [descriptor]
        let charBuffer: Array<Byte> = [21, 22]
        let properties = GattProperties()

        let characteristic: BLECharacteristic = BLECharacteristic(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            charBuffer,
            descriptors,
            properties: properties, permissions: GattPermissions(), characteristicValueHandle: 0
        )

        try {
            var resCallback:  AsyncCallback<Unit> = {
                errorCode: Option<BusinessException>, data: Option<Unit> => match (errorCode) {
                    case Some(e) => loggerError("CallBack error: errcode is ${e.code}")
                    case _ => loggerInfo("CallBack ok")
                }
            }
            gattClient.setCharacteristicChangeNotification(characteristic, false, resCallback)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_setCharacteristicChangeIndication() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")

        // 创建descriptors
        let descBuffer: Array<Byte> = [31, 32]
        let descriptor = BLEDescriptor(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            "00002902-0000-1000-8000-00805F9B34FB",
            Array<Byte>(2, repeat: 0)
        )
        // 创建characteristics
        let descriptors: Array<BLEDescriptor> = [descriptor]
        let charBuffer: Array<Byte> = [21, 22]
        let properties = GattProperties()

        let characteristic: BLECharacteristic = BLECharacteristic(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            charBuffer,
            descriptors,
            properties: properties, permissions: GattPermissions(), characteristicValueHandle: 0
        )
        var resCallback:  AsyncCallback<Unit> = {
            errorCode: Option<BusinessException>, data: Option<Unit> => match (errorCode) {
                case Some(e) => loggerError("CallBack error: errcode is ${e.code}")
                case _ => loggerInfo("CallBack ok")
            }
        }

        try {
            gattClient.setCharacteristicChangeIndication(characteristic, false, resCallback)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_BluetoothBleGattClientBLECharacteristic_on() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        let bleCharacteristicChangeCallback = BLECharacteristicChangeCallback()
        try {
            gattClient.on(BleCharacteristicChange, bleCharacteristicChangeCallback)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_BluetoothBleGattClientBLEConnectionChangeState_on() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        let device = "0A:1B:2C:3D:4D:5F"
        var connectState = StateDisconnected
        let bleConnectionStateChangeCallback = BLEConnectionStateChangeCallback()
        try {
            gattClient.on(BleConnectionStateChange, bleConnectionStateChangeCallback)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_BluetoothBleGattClientInt32_on() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        let bleMtuChangeCallback = BLEMtuChangeCallback()
        try {
            gattClient.on(BluetoothBleGattClientDeviceCallbackType.ClientBleMtuChange, bleMtuChangeCallback)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_BluetoothBleGattClient_off() {
        let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
        let device = "0A:1B:2C:3D:4D:5F"
        var connectState = StateDisconnected
        let bleConnectionStateChangeCallback = BLEConnectionStateChangeCallback()
        try {
            gattClient.on(BleConnectionStateChange, bleConnectionStateChangeCallback)
            gattClient.off(BleConnectionStateChange, callback: bleConnectionStateChangeCallback)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_addService() {
        let descBuffer: Array<Byte> = [31, 32]
        let descriptors0 = BLEDescriptor(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            "00002902-0000-1000-8000-00805F9B34FB",
            Array<Byte>(2, repeat: 0)
        )
        let descriptors1 = BLEDescriptor(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            "00002903-0000-1000-8000-00805F9B34FB",
            descBuffer
        )

        // 创建characteristics
        let descriptors: Array<BLEDescriptor> = [descriptors0, descriptors1]
        let charBuffer: Array<Byte> = [21, 22]
        let properties = GattProperties()

        let characteristic: BLECharacteristic = BLECharacteristic(
            "00001810-0000-1000-8000-00805F9B34FB",
            "00001820-0000-1000-8000-00805F9B34FB",
            charBuffer,
            descriptors,
            properties: properties, permissions: GattPermissions(), characteristicValueHandle: 0
        )

        let characteristics: Array<BLECharacteristic> = [characteristic]
        let gattService: GattService = GattService(
            "00001810-0000-1000-8000-00805F9B34FB",
            true,
            characteristics,
            includeServices: Array<GattService>()
        )

        try {
            //构造gattServer
            let gattServer = createGattServer()
            gattServer.addService(gattService)
        } catch (e: BusinessException) {
            loggerError("add Service error because ${e}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_removeService() {
        let gattServer = createGattServer()
        try {
            gattServer.removeService("00001810-0000-1000-8000-00805F9B34FB")
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_notifyCharacteristicChanged() {
        let gattServer = createGattServer()
        try {
            let charBuffer: Array<Byte> = [21, 22]
            let notifyCharacteristic = NotifyCharacteristic(
                "00001810-0000-1000-8000-00805F9B34FB",
                "00001820-0000-1000-8000-00805F9B34FB",
                charBuffer,
                false
            )
            gattServer.notifyCharacteristicChanged("0A:1B:2C:3D:4D:5F", notifyCharacteristic)
        } catch (e: Exception) {}
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_sendResponse() {
        let gattServer = createGattServer()
        try {
            let rspBuffer = Array<Byte>()
            let serverResponse: ServerResponse = ServerResponse(
                "0A:1B:2C:3D:4D:5F'", 0, 0, 0,
                rspBuffer
            )
            gattServer.sendResponse(serverResponse)
        } catch (e: BusinessException) {
            loggerInfo( "errCode: ${e.code}, errMessage: ${e.message}")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_ScanReportMode() {
        let enumArray: Array<ScanReportMode> = [
            ScanReportMode.Normal,
            ScanReportMode.Batch,
            ScanReportMode.FenceSensitivityLow,
            ScanReportMode.FenceSensitivityHigh
        ]
        let strArray: Array<String> = [
            "ScanReportMode.Normal",
            "ScanReportMode.Batch",
            "ScanReportMode.FenceSensitivityLow",
            "ScanReportMode.FenceSensitivityHigh"
        ]
        for (i in 0..enumArray.size) {
            @Expect(enumArray[i] == enumArray[i])
            @Expect(enumArray[i].toString() == strArray[i])
            @Expect(enumArray[i] != enumArray[(i + 1) % enumArray.size])
        }
    }

}

class BLEMtuChangeCallback <: Callback1Argument<Int32> {
    public func invoke(err: ?BusinessException, mtu: Int32): Unit {
        var res = mtu
        loggerInfo("BLEMtuChangeCallback.")
    }
}

class BLECharacteristicChangeCallback <: Callback1Argument<BLECharacteristic> {
    public func invoke(err: ?BusinessException, characteristic: BLECharacteristic): Unit {
        loggerInfo( "characteristic ${characteristic.serviceUUID} has change")
    }
}

class BLEConnectionStateChangeCallback <: Callback1Argument<BLEConnectionChangeState> {
    let gattClient = createGattClientDevice("0A:1B:2C:3D:4D:5F")
    let device = "0A:1B:2C:3D:4D:5F"
    var connectState = StateDisconnected
    public func invoke(err: ?BusinessException, stateInfo: BLEConnectionChangeState): Unit {
        loggerInfo( "onGattServerStateChange: device=" + stateInfo.deviceId + ", state=" + stateInfo.state.toString())
        if (stateInfo.deviceId == device) {
            connectState = stateInfo.state
        }
    }
}

class AdvertisingStateChange <: Callback1Argument<AdvertisingStateChangeInfo> {
    public func invoke(err: ?BusinessException, info: AdvertisingStateChangeInfo): Unit {
        loggerInfo( "the advertising state is ${info.state}")
    }
}

class BLEDeviceFindCallback <: Callback1Argument<Array<ScanResult>> {
    public func invoke(err: ?BusinessException, devices: Array<ScanResult>): Unit {
        for (device in devices) {
            loggerInfo( "device has find, deviceID is ${device.deviceId}, name is ${device.deviceName}")
        }
    }
}

class CharacteristicReadCallback <: Callback1Argument<CharacteristicReadRequest> {
    public func invoke(err: ?BusinessException, charReq: CharacteristicReadRequest): Unit {
        let deviceId: String = charReq.deviceId
        let transId: Int32 = charReq.transId
        let offset: Int32 = charReq.offset
        loggerInfo( "receive characteristicRead")
        let rspBuffer: Array<Byte> = [21, 22]
        let serverResponse: ServerResponse = ServerResponse(
            deviceId,
            transId,
            0,
            offset,
            rspBuffer
        )
        try {
            gattServer.sendResponse(serverResponse)
        } catch (e: BusinessException) {
            loggerError("gattServer send response fail because ${e}")
        }
    }
}

class CharacteristicWriteCallback <: Callback1Argument<CharacteristicWriteRequest> {
    public func invoke(err: ?BusinessException, charReq: CharacteristicWriteRequest): Unit {
        let deviceId: String = charReq.deviceId
        let transId: Int32 = charReq.transId
        let offset: Int32 = charReq.offset
        loggerInfo( "receive characteristicWrite")

        loggerInfo( "receive characteristicWrite: needRsp=" + charReq
            .needRsp
            .toString())
        if (!charReq.needRsp) {
            return
        }
        let rspBuffer = Array<Byte>()
        let serverResponse: ServerResponse = ServerResponse(
            deviceId,
            transId,
            0,
            offset,
            rspBuffer
        )
        try {
            gattServer.sendResponse(serverResponse)
        } catch (e: BusinessException) {
            loggerError("gattServer send response fail because ${e}")
        }
    }
}

class DescriptorReadCallback <: Callback1Argument<DescriptorReadRequest> {
    public func invoke(err: ?BusinessException, desReq: DescriptorReadRequest): Unit {
        let deviceId: String = desReq.deviceId
        let transId: Int32 = desReq.transId
        let offset: Int32 = desReq.offset
        loggerInfo( "receive descriptorRead")
        let rspBuffer: Array<Byte> = [31, 32]
        let serverResponse: ServerResponse = ServerResponse(
            deviceId,
            transId,
            0,
            offset,
            rspBuffer
        )
        try {
            gattServer.sendResponse(serverResponse)
        } catch (e: BusinessException) {
            loggerError("gattServer send response fail because ${e}")
        }
    }
}

class DescriptorWriteCallback <: Callback1Argument<DescriptorWriteRequest> {
    public func invoke(err: ?BusinessException, desReq: DescriptorWriteRequest): Unit {
        let deviceId: String = desReq.deviceId
        let transId: Int32 = desReq.transId
        let offset: Int32 = desReq.offset
        loggerInfo( "receive descriptorWrite")
        loggerInfo( "receive descriptorWrite: needRsp=" + desReq.needRsp.toString())
        if (!desReq.needRsp) {
            return
        }
        let rspBuffer = Array<Byte>()
        let serverResponse: ServerResponse = ServerResponse(
            deviceId,
            transId,
            0,
            offset,
            rspBuffer
        )
        try {
            gattServer.sendResponse(serverResponse)
        } catch (e: BusinessException) {
            loggerError("gattServer send response fail because ${e}")
        }
    }
}

class StateChangeCallback <: Callback1Argument<BLEConnectionChangeState> {
    public func invoke(err: ?BusinessException, state: BLEConnectionChangeState): Unit {
        loggerInfo( "onGattServerStateChange: device=" + state.deviceId + ", state=" + state.state.toString())
    }
}