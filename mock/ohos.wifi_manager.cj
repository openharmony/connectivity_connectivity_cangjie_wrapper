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

package ohos.wifi_manager

import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
public enum DeviceAddressType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    RandomDeviceAddress
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    RealDeviceAddress
    | ...
}

extend DeviceAddressType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    public func toString(): String {
        return String()
    }
}

extend DeviceAddressType <: Equatable<DeviceAddressType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    public operator func ==(other: DeviceAddressType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    public operator func !=(other: DeviceAddressType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
public enum WifiSecurityType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeInvalid
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeOpen
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeWep
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypePsk
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeSae
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeEap
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeEapSuiteB
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeOwe
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeWapiCert
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    WifiSecTypeWapiPsk
    | ...
}

extend WifiSecurityType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    public func toString(): String {
        return String()
    }
}

extend WifiSecurityType <: Equatable<WifiSecurityType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    public operator func ==(other: WifiSecurityType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.Core"]
    public operator func !=(other: WifiSecurityType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
public enum WifiCategory {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    Default
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    Wifi6
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    Wifi6Plus
    | ...
}

extend WifiCategory <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public func toString(): String {
        return String()
    }
}

extend WifiCategory <: Equatable<WifiCategory> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public operator func ==(other: WifiCategory): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public operator func !=(other: WifiCategory): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
public enum GroupOwnerBand {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    GoBandAuto
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    GoBand2GHz
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    GoBand5GHz
    | ...
}

extend GroupOwnerBand <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public func toString(): String {
        return String()
    }
}

extend GroupOwnerBand <: Equatable<GroupOwnerBand> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public operator func ==(other: GroupOwnerBand): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public operator func !=(other: GroupOwnerBand): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA", throwexception: true]
public func isWifiActive(): Bool {
    return true
}

@!APILevel[since: "22", permission: "ohos.permission.GET_WIFI_INFO", syscap: "SystemCapability.Communication.WiFi.STA", throwexception: true]
public func getScanInfoList(): Array<WifiScanInfo> {
    return Array()
}

@!APILevel[since: "22", permission: "ohos.permission.GET_WIFI_INFO", syscap: "SystemCapability.Communication.WiFi.P2P", throwexception: true]
public func p2pConnect(config: WifiP2pConfig): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.GET_WIFI_INFO", syscap: "SystemCapability.Communication.WiFi.P2P", throwexception: true]
public func p2pCancelConnect(): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.GET_WIFI_INFO", syscap: "SystemCapability.Communication.WiFi.P2P", throwexception: true]
public func startDiscoverDevices(): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.GET_WIFI_INFO", syscap: "SystemCapability.Communication.WiFi.P2P", throwexception: true]
public func stopDiscoverDevices(): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.GET_WIFI_INFO", syscap: "SystemCapability.Communication.WiFi.STA", throwexception: true]
public func on(eventType: WifiCallbackType, callback: Callback1Argument<Int32>): Unit {
    return ()
}

@!APILevel[since: "22", permission: "ohos.permission.GET_WIFI_INFO", syscap: "SystemCapability.Communication.WiFi.STA", throwexception: true]
public func off(eventType: WifiCallbackType, callback!: ?CallbackObject = None): Unit {
    return ()
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
public enum WifiCallbackType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    WifiScanStateChange | ...
}

extend WifiCallbackType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public func toString(): String {
        return String()
    }
}

extend WifiCallbackType <: Equatable<WifiCallbackType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public operator func ==(other: WifiCallbackType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public operator func !=(other: WifiCallbackType): Bool {
        return true
    }
}

extend WifiCallbackType <: Hashable {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public func hashCode(): Int64 {
        return 0
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
public class WifiInfoElement {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var eid: UInt32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var content: Array<UInt8>
    
    public init() {
        super()
        this.eid = 0
        this.content = Array()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
public class WifiP2pConfig {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public var deviceAddress: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public var netId: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public var passphrase: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public var groupName: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public var goBand: GroupOwnerBand

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public var deviceAddressType: DeviceAddressType

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.P2P"]
    public init(
        deviceAddress: String,
        netId: Int32,
        passphrase: String,
        groupName: String,
        goBand: GroupOwnerBand,
        deviceAddressType!: DeviceAddressType = RandomDeviceAddress
    ) {
        super()
        this.deviceAddress = String()
        this.netId = 0
        this.passphrase = String()
        this.groupName = String()
        this.goBand = GroupOwnerBand.GoBandAuto
        this.deviceAddressType = DeviceAddressType.RandomDeviceAddress
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
public class WifiScanInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var ssid: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var bssid: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var bssidType: DeviceAddressType

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var capabilities: String

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var securityType: WifiSecurityType

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var rssi: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var band: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var frequency: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var channelWidth: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var centerFrequency0: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var centerFrequency1: Int32

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var infoElems: Array<WifiInfoElement>

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var timestamp: Int64

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var supportedWifiCategory: WifiCategory

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.WiFi.STA"]
    public var isHiLinkNetwork: Bool
    
    public init() {
        super()
        this.ssid = String()
        this.bssid = String()
        this.bssidType = DeviceAddressType.RandomDeviceAddress
        this.capabilities = String()
        this.securityType = WifiSecurityType.WifiSecTypeInvalid
        this.rssi = 0
        this.band = 0
        this.frequency = 0
        this.channelWidth = 0
        this.centerFrequency0 = 0
        this.centerFrequency1 = 0
        this.infoElems = Array()
        this.timestamp = 0
        this.supportedWifiCategory = WifiCategory.Default
        this.isHiLinkNetwork = true
    }
}