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
import ohos.business_exception.{ AsyncCallback, BusinessException }
import std.deriving.Derive

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.Core"
]
public enum DeviceAddressType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    RandomDeviceAddress
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    RealDeviceAddress
    | ...
}

extend DeviceAddressType <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend DeviceAddressType <: Equatable<DeviceAddressType> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    public operator func ==(other: DeviceAddressType): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    public operator func !=(other: DeviceAddressType): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.Core"
]
public enum WifiSecurityType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeInvalid
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeOpen
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeWep
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypePsk
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeSae
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeEap
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeEapSuiteB
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeOwe
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeWapiCert
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeWapiPsk
    | ...
}

extend WifiSecurityType <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend WifiSecurityType <: Equatable<WifiSecurityType> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    public operator func ==(other: WifiSecurityType): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    public operator func !=(other: WifiSecurityType): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum WifiCategory {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Default
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Wifi6
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Wifi6Plus
    | ...
}

extend WifiCategory <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public func toString(): String {
        return String()
    }
}

extend WifiCategory <: Equatable<WifiCategory> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public operator func ==(other: WifiCategory): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public operator func !=(other: WifiCategory): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public enum GroupOwnerBand {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    GoBandAuto
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    GoBand2GHz
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    GoBand5GHz
    | ...
}

extend GroupOwnerBand <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public func toString(): String {
        return String()
    }
}

extend GroupOwnerBand <: Equatable<GroupOwnerBand> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public operator func ==(other: GroupOwnerBand): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public operator func !=(other: GroupOwnerBand): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func isWifiActive(): Bool {
    return true
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func getScanInfoList(): Array<WifiScanInfo> {
    return Array()
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
]
public func p2pConnect(config: WifiP2pConfig): Unit {
    return ()
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
]
public func p2pCancelConnect(): Unit {
    return ()
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
]
public func startDiscoverDevices(): Unit {
    return ()
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    throwexception: true
]
public func stopDiscoverDevices(): Unit {
    return ()
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func on(eventType: WifiCallbackType, callback: Callback1Argument<Int32>): Unit {
    return ()
}

@!APILevel[
    since: "22",
    permission: "ohos.permission.GET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func off(eventType: WifiCallbackType, callback!: ?CallbackObject = None): Unit {
    return ()
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum WifiCallbackType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiScanStateChange | ...
}

extend WifiCallbackType <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public func toString(): String {
        return String()
    }
}

extend WifiCallbackType <: Equatable<WifiCallbackType> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public operator func ==(other: WifiCallbackType): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public operator func !=(other: WifiCallbackType): Bool {
        return true
    }
}

extend WifiCallbackType <: Hashable {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public func hashCode(): Int64 {
        return 0
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiInfoElement {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var eid: UInt32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var content: Array<UInt8>
    
    internal init() {
        super()
        this.eid = 0
        this.content = Array()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pConfig {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var deviceAddress: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var netId: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var passphrase: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var groupName: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var goBand: GroupOwnerBand

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var deviceAddressType: DeviceAddressType

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
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

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiScanInfo {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var ssid: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var bssid: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var bssidType: DeviceAddressType

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var capabilities: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var securityType: WifiSecurityType

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var rssi: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var band: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var frequency: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var channelWidth: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var centerFrequency0: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var centerFrequency1: Int32

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var infoElems: Array<WifiInfoElement>

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var timestamp: Int64

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var supportedWifiCategory: WifiCategory

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public var isHiLinkNetwork: Bool
    
    internal init() {
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

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum EapMethod {
    /**
     * EAP NONE.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapNone
    |
    /**
     * EAP PEAP.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapPeap
    |
    /**
     * EAP TLS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapTls
    |
    /**
     * EAP TTLS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapTtls
    |
    /**
     * EAP PWD.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapPwd
    |
    /**
     * EAP SIM.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapSim
    |
    /**
     * EAP AKA.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapAka
    |
    /**
     * EAP AKA PRIME.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapAkaPrime
    |
    /**
     * EAP UNAUTH TLS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapUnauthTls
    |
    ...

}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum Phase2Method {
    /**
     * Phase2 NONE.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2None
    |
    /**
     * Phase2 PAP.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Pap
    |
    /**
     * Phase2 MSCHAP.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Mschap
    |
    /**
     * Phase2 MSCHAPV2.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Mschapv2
    |
    /**
     * Phase2 GTC.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Gtc
    |
    /**
     * Phase2 SIM.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Sim
    |
    /**
     * Phase2 AKA.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Aka
    |
    /**
     * Phase2 AKA+.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2AkaPrime
    |
    ...

}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.Core"
]
public enum WapiPskType {
    /**
     * ASCII character type of WAPI pre-shared key.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WapiPskAscii
    |
    /**
     * HEX character type of WAPI pre-shared key.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WapiPskHex
    |
    ...

}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum WifiBandType {
    /**
     * Default.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBandNone
    |
    /**
     * Band 2.4G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand2g
    |
    /**
     * Band 5G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand5g
    |
    /**
     * Band 6G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand6g
    |
    /**
     * Band 60G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand60g
    |
    ...

}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public enum P2pConnectState {
    /**
     * p2p is disconnected.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Disconnected
    |
    /**
     * p2p is connected.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Connected
    |
    ...

}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public enum P2pDeviceStatus {
    /**
     * Indicate p2p device is connected.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Connected
    |
    /**
     * Indicate p2p device is invited.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Invited
    |
    /**
     * Indicate p2p device is failed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Failed
    |
    /**
     * Indicate p2p device is available.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Available
    |
    /**
     * Indicate p2p device is unavailable.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Unavailable
    |
    ...

}

/**
 * Scan Wi-Fi hotspot.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.SET_WIFI_INFO",
    syscap: "SystemCapability.Communication.WiFi.STA",
    throwexception: true
]
public func startScan(): Unit {
    return ()
}

/**
 * Add a specified candidate hotspot configuration and returns the networkId.
 * This method adds one configuration at a time. After this configuration is added,
 *     your device will determine whether to connect to the hotspot.
 * The app must be in the foreground.
 *
 * @param { WifiDeviceConfig } config - candidate config.
 * @returns { Unit } Returns {@code networkId} if the configuration is added; returns {@code -1} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.SET_WIFI_INFO",
    throwexception: true
]
public func addCandidateConfig(config: WifiDeviceConfig, callback: AsyncCallback<Int32>): Unit {
    return ()
}

/**
 * Remove a specified candidate hotspot configuration, only the configuration which is added by ourself is allowed
 * to be removed.
 * The app must be in the foreground.
 *
 * @param { Int32 } networkId - Network ID which will be removed.
 * @param { AsyncCallback<Unit> } callback - Indicates call back of removeCandidateConfig.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 * @throws { BusinessException } 2501001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.SET_WIFI_INFO",
    throwexception: true
]
public func removeCandidateConfig(networkId: Int32, callback: AsyncCallback<Unit>): Unit {
    return ()
}

/**
 * Obtain the list of all existed candidate Wi-Fi configurations which added by ourself.
 * You can obtain only the Wi-Fi configurations you created on your own application.
 *
 * @returns { Array<WifiDeviceConfig> } Returns the list of all existed Wi-Fi configurations you created on your application.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getCandidateConfigs(): Array<WifiDeviceConfig> {
    return Array<WifiDeviceConfig>()
}

/**
 * Connect to the specified candidate hotspot using connect settings.
 *
 * @param { ConnectSettings } settings - Indicates the connection settings.
 * @param { AsyncCallback<Unit> } callback - Indicates callback of connectToCandidateConfig.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 * @throws { BusinessException } 2501001 - Wi-Fi STA disabled.
 * @throws { BusinessException } 2501005 - The user does not respond.
 * @throws { BusinessException } 2501006 - The user refused the action.
 * @throws { BusinessException } 2501007 - Parameter validation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.SET_WIFI_INFO",
    throwexception: true
]
public func connectToCandidateConfig(settings: ConnectSettings, callback: AsyncCallback<Unit>): Unit {
    return ()
}

/**
 * Calculate the Wi-Fi signal level based on the Wi-Fi RSSI and frequency band.
 *
 * @param { Int32 } rssi - Indicates the Wi-Fi RSSI.
 * @param { Int32 } band - Indicates the Wi-Fi frequency band.
 * @returns { UInt32 } Returns Wi-Fi signal level ranging from 0 to 4.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getSignalLevel(rssi: Int32, band: Int32): UInt32 {
    return 0u32
}

/**
 * Obtain connection information about the Wi-Fi connection.
 * If the app does not have the ohos.permission.GET_WIFI_PEERS_MAC permission, a random bssid is returned.
 *
 * @returns { WifiLinkedInfo } Returns the Wi-Fi linked information.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 * @throws { BusinessException } 2501001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getLinkedInfoSync(): WifiLinkedInfo {
    return WifiLinkedInfo()
}

/**
 * Check whether the Wi-Fi connection has been set up.
 *
 * @returns { Bool } Returns {@code true} if a Wi-Fi connection has been set up, returns {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func isConnected(): Bool {
    return true
}

/**
 * Check whether the device supports a specified feature.
 *
 * @param { Int64 } featureId Indicates the ID of the feature.
 * @returns { Bool } Returns {@code true} if this device supports the specified feature, returns {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2401000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.Core",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func isFeatureSupported(featureId: Int64): Bool {
    return true
}

/**
 * Obtain the IPv4 information of the Wi-Fi connection.
 * The IP information includes the host IP address, gateway address, and DNS information.
 *
 * @returns { IpInfo } Returns the IP information of the Wi-Fi connection.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getIpInfo(): IpInfo {
    return IpInfo()
}

/**
 * Obtain the IPv6 information of the Wi-Fi connection.
 * The IPv6 information includes the host IP address, gateway address, and DNS information.
 *
 * @returns { Ipv6Info } Returns the IPv6 information of the Wi-Fi connection.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getIpv6Info(): Ipv6Info {
    return Ipv6Info()
}

/**
 * Obtain the country code of the device.
 *
 * @returns { String } Returns the country code of this device.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2401000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.Core",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getCountryCode(): String {
    return ""
}

/**
 * Check whether the current device supports the specified band.
 *
 * @param { WifiBandType } bandType - Indicates the band type.
 * @returns { Bool } Returns {@code true} if the specified band is supported, returns {@code false} otherwise.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2501000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func isBandTypeSupported(bandType: WifiBandType): Bool {
    return true
}

/**
 * Obtain information about the P2P connection.
 *
 * @param { AsyncCallback<WifiP2pLinkedInfo> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getP2pLinkedInfo(callback: AsyncCallback<WifiP2pLinkedInfo>): Unit {
    return ()
}

/**
 * Obtain information about the current p2p group.
 *
 * @param { AsyncCallback<WifiP2pGroupInfo> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getCurrentGroup(callback: AsyncCallback<WifiP2pGroupInfo>): Unit {
    return ()
}

/**
 * Obtain the information about the found devices.
 *
 * @param { AsyncCallback<Array<WifiP2pDevice>> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getP2pPeerDevices(callback: AsyncCallback<Array<WifiP2pDevice>>): Unit {
    return ()
}

/**
 * Obtain the information about own device information.
 * DeviceAddress in the returned WifiP2pDevice will be set "00:00:00:00:00:00",
 * if ohos.permission.GET_WIFI_LOCAL_MAC is not granted.
 *
 * @param { AsyncCallback<WifiP2pDevice> } callback - Indicates callback of function.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func getP2pLocalDevice(callback: AsyncCallback<WifiP2pDevice>): Unit {
    return ()
}

/**
 * Create a P2P group.
 *
 * @param { WifiP2pConfig } config - Indicates the configuration for a group.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func createGroup(config: WifiP2pConfig): Unit {
    return ()
}

/**
 * Remove a P2P group.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2801000 - Operation failed.
 * @throws { BusinessException } 2801001 - Wi-Fi STA disabled.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P",
    permission: "ohos.permission.GET_WIFI_INFO",
    throwexception: true
]
public func removeGroup(): Unit {
    return ()
}

/**
 * Wi-Fi IP information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class IpInfo {
    internal init() {}

    /**
     * The IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop ipAddress: UInt32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The gateway of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop gateway: UInt32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The network mask of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop netmask: UInt32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The primary DNS server IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop primaryDns: UInt32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The secondary DNS server IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop secondDns: UInt32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The DHCP server IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop serverIp: UInt32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The IP address lease duration of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop leaseDuration: UInt32 {
        get() {
            return 0
        }
        set(_) {
        }
    }
}

/**
 * Wi-Fi IPv6 information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class Ipv6Info {
    internal init() {}

    /**
     * The link IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop linkIpv6Address: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The global IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop globalIpv6Address: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The rand Global IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop randomGlobalIpv6Address: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The unique IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop uniqueIpv6Address: ?String {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * The rand unique IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop randomUniqueIpv6Address: ?String {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * The gateway of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop gateway: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The network mask of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop netmask: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The primary DNS server IPV6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop primaryDNS: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The secondary DNS server IPV6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop secondDNS: String {
        get() {
            return ""
        }
        set(_) {
        }
    }
}

/**
 * P2P linked information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pLinkedInfo {
    internal init() {}

    /**
     * Connection status.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop connectState: P2pConnectState {
        get() {
            return P2pConnectState.Disconnected
        }
        set(_) {
        }
    }

    /**
     * Indicates whether it is group owner.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop isGroupOwner: Bool {
        get() {
            return false
        }
        set(_) {
        }
    }

    /**
     * Group owner address.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop groupOwnerAddr: String {
        get() {
            return ""
        }
        set(_) {
        }
    }
}

/**
 * P2P device information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pDevice {
    /**
     * Creates WifiP2pDevice information.
     *
     * @param { String } deviceName - Device name.
     * @param { String } deviceAddress - Device mac address.
     * @param { String } primaryDeviceType - Primary device type.
     * @param { P2pDeviceStatus } deviceStatus - Device status.
     * @param { Int32 } groupCapabilities - Device group capabilities.
     * @param { ?DeviceAddressType } [deviceAddressType] - Device mac address type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public init(
        deviceName: String,
        deviceAddress: String,
        primaryDeviceType: String,
        deviceStatus: P2pDeviceStatus,
        groupCapabilities: Int32,
        deviceAddressType!: ?DeviceAddressType = None
    ) {
        this.deviceName = deviceName
        this.deviceAddress = deviceAddress
        this.primaryDeviceType = primaryDeviceType
        this.deviceStatus = deviceStatus
        this.groupCapabilities = groupCapabilities
        this.deviceAddressType = deviceAddressType
    }

    /**
     * Device name.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop deviceName: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Device mac address.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop deviceAddress: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Device mac address type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop deviceAddressType: ?DeviceAddressType {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * Primary device type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop primaryDeviceType: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Device status.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop deviceStatus: P2pDeviceStatus {
        get() {
            return P2pDeviceStatus.Available
        }
        set(_) {
        }
    }

    /**
     * Device group capabilities.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop groupCapabilities: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }
}

/**
 * Wi-Fi connection information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiLinkedInfo {
    internal init() {}

    /**
     * The SSID of the Wi-Fi hotspot.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop ssid: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The BSSID of the Wi-Fi hotspot.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop bssid: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * The RSSI(dBm) of a Wi-Fi access point.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop rssi: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The frequency band of a Wi-Fi access point.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop band: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * The frequency of a Wi-Fi access point.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop frequency: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }
}

/**
 * Wi-Fi EAP config.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiEapConfig {
    /**
     * Creates WifiEapConfig information.
     *
     * @param { EapMethod } eapMethod - EAP authentication method.
     * @param { Phase2Method } phase2Method - Phase 2 authentication method.
     * @param { String } identity - The identity.
     * @param { String } anonymousIdentity - Anonymous identity.
     * @param { String } password - Password.
     * @param { String } caCertAlias - CA certificate alias.
     * @param { String } caPath - CA certificate path.
     * @param { String } clientCertAlias - Client certificate alias.
     * @param { UInt8Array } certEntry - Content of user's certificate.
     * @param { String } certPassword - Password of user's certificate.
     * @param { String } altSubjectMatch - Alternate subject match.
     * @param { String } domainSuffixMatch - Domain suffix match.
     * @param { String } realm - Realm for Passpoint credential.
     * @param { String } plmn - Public Land Mobile Network of the provider of Passpoint credential.
     * @param { Int32 } eapSubId - Sub ID of the SIM card.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public init(
        eapMethod: EapMethod,
        phase2Method: Phase2Method,
        identity: String,
        anonymousIdentity: String,
        password: String,
        caCertAlias: String,
        caPath: String,
        clientCertAlias: String,
        certEntry: Array<UInt8>,
        certPassword: String,
        altSubjectMatch: String,
        domainSuffixMatch: String,
        realm: String,
        plmn: String,
        eapSubId: Int32
    ) {
        this.eapMethod = eapMethod
        this.phase2Method = phase2Method
        this.identity = identity
        this.anonymousIdentity = anonymousIdentity
        this.password = password
        this.caCertAlias = caCertAlias
        this.caPath = caPath
        this.clientCertAlias = clientCertAlias
        this.certEntry = certEntry
        this.certPassword = certPassword
        this.altSubjectMatch = altSubjectMatch
        this.domainSuffixMatch = domainSuffixMatch
        this.realm = realm
        this.plmn = plmn
        this.eapSubId = eapSubId
    }

    /**
     * EAP authentication method.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop eapMethod: EapMethod {
        get() {
            return EapMethod.EapNone
        }
        set(_) {
        }
    }

    /**
     * Phase 2 authentication method.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop phase2Method: Phase2Method {
        get() {
            return Phase2Method.Phase2None
        }
        set(_) {
        }
    }

    /**
     * The identity.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop identity: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Anonymous identity.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop anonymousIdentity: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Password.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop password: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * CA certificate alias.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop caCertAlias: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * CA certificate path.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop caPath: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Client certificate alias.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop clientCertAlias: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Content of user's certificate.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop certEntry: Array<UInt8> {
        get() {
            return []
        }
        set(_) {
        }
    }

    /**
     * Password of user's certificate.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop certPassword: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Alternate subject match.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop altSubjectMatch: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Domain suffix match.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop domainSuffixMatch: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Realm for Passpoint credential.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop realm: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Public Land Mobile Network of the provider of Passpoint credential.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop plmn: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Sub ID of the SIM card.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop eapSubId: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }
}

/**
 * Wi-Fi device configuration information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiDeviceConfig {
    /**
     * Creates WifiDeviceConfig information.
     *
     * @param { String } ssid - Wi-Fi SSID: the maximum length is 32.
     * @param { String } preSharedKey - Wi-Fi key: maximum length is 64.
     * @param { WifiSecurityType } securityType - Security type: reference definition of WifiSecurityType
     * @param { ?String } [bssid] - Wi-Fi bssid(MAC): the length is 6.
     * @param { ?DeviceAddressType } [bssidType] - Wi-Fi bssid type.
     * @param { ?Bool } [isHiddenSsid] - Hide SSID or not, false(default): not hide
     * @param { ?WifiEapConfig } [eapConfig] - EAP config info.
     * @param { ?WifiWapiConfig } [wapiConfig] - WAPI config info.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public init(
        ssid: String,
        preSharedKey: String,
        securityType: WifiSecurityType,
        bssid!: ?String = None,
        bssidType!: ?DeviceAddressType = None,
        isHiddenSsid!: ?Bool = None,
        eapConfig!: ?WifiEapConfig = None,
        wapiConfig!: ?WifiWapiConfig = None
    ) {
        this.ssid = ssid
        this.preSharedKey = preSharedKey
        this.securityType = securityType
        this.bssid = bssid
        this.bssidType = bssidType
        this.isHiddenSsid = isHiddenSsid
        this.eapConfig = eapConfig
        this.wapiConfig = wapiConfig
    }

    /**
     * Wi-Fi SSID: the maximum length is 32.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop ssid: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Wi-Fi bssid(MAC): the length is 6.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop bssid: ?String {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * Wi-Fi bssid type.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop bssidType: ?DeviceAddressType {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * Wi-Fi key: maximum length is 64.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop preSharedKey: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Hide SSID or not, false(default): not hide
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop isHiddenSsid: ?Bool {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * Security type: reference definition of WifiSecurityType
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop securityType: WifiSecurityType {
        get() {
            return WifiSecurityType.WifiSecTypeInvalid
        }
        set(_) {
        }
    }

    /**
     * EAP config info.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop eapConfig: ?WifiEapConfig {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * WAPI config info.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop wapiConfig: ?WifiWapiConfig {
        get() {
            return None
        }
        set(_) {
        }
    }
}

/**
 * P2P group information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pGroupInfo {
    internal init() {}

    /**
     * Indicates whether it is group owner.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop isP2pGo: Bool {
        get() {
            return false
        }
        set(_) {
        }
    }

    /**
     * Group owner information.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop ownerInfo: WifiP2pDevice {
        get() {
            return WifiP2pDevice("", "", "", P2pDeviceStatus.Available, 0)
        }
        set(_) {
        }
    }

    /**
     * The group passphrase.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop passphrase: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Interface name.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop interfaceName: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Group name.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop groupName: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * Network ID.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop networkId: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * Frequency.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop frequency: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * Client list.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop clientDevices: Array<WifiP2pDevice> {
        get() {
            return []
        }
        set(_) {
        }
    }

    /**
     * Group owner IP address.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop goIpAddress: String {
        get() {
            return ""
        }
        set(_) {
        }
    }
}

/**
 * Wi-Fi WAPI config.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiWapiConfig {
    /**
     * Creates WifiWapiConfig information.
     *
     * @param { WapiPskType } wapiPskType - WAPI pre-shared key type.
     * @param { String } wapiAsCert - WAPI AS certification.
     * @param { String } wapiUserCert - WAPI user certification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public init(
        wapiPskType: WapiPskType,
        wapiAsCert: String,
        wapiUserCert: String
    ) {
        this.wapiPskType = wapiPskType
        this.wapiAsCert = wapiAsCert
        this.wapiUserCert = wapiUserCert
    }

    /**
     * WAPI user certification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop wapiPskType: WapiPskType {
        get() {
            return WapiPskType.WapiPskAscii
        }
        set(_) {
        }
    }

    /**
     * WAPI AS certification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop wapiAsCert: String {
        get() {
            return ""
        }
        set(_) {
        }
    }

    /**
     * WAPI user certification.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop wapiUserCert: String {
        get() {
            return ""
        }
        set(_) {
        }
    }
}

/**
 * Connection settings of the candidate hotspot.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class ConnectSettings {
    /**
     * Creates ConnectSettings information.
     *
     * @param { Int32 } networkId - The ID (uniquely identifies) of a Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public init(
        networkId: Int32
    ) {
        this.networkId = networkId
    }

    /**
     * The ID (uniquely identifies) of a Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop networkId: Int32 {
        get() {
            return 0
        }
        set(_) {
        }
    }

    /**
     * Returned with user action, default value is false.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop withUserAction: ?Bool {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * User action timeout threshold (unit is seconds).
     * The maximum value cannot exceed 30, and the default value is 10.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop userActionTimeout: ?Int32 {
        get() {
            return None
        }
        set(_) {
        }
    }

    /**
     * Whether to add the network to the system for connection.
     * The default value is false. If set to true, the network will be added to the system
     *     before connection and cannot be retrieved again.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop addNetworkToSystem: ?Bool {
        get() {
            return None
        }
        set(_) {
        }
    }
}
