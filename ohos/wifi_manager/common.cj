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

package ohos.wifi_manager

import ohos.labels.{APILevel, Hide}
import std.deriving.Derive
import ohos.business_exception.BusinessException

const EVENT_STA_POWER_STATE_CHANGE = "wifiStateChange"
const EVENT_STA_CONN_STATE_CHANGE = "wifiConnectionChange"
const EVENT_STA_RSSI_STATE_CHANGE = "wifiRssiChange"
const EVENT_STA_SCAN_STATE_CHANGE = "wifiScanStateChange"
const EVENT_HOTSPOT_STATE_CHANGE = "hotspotStateChange"
const EVENT_P2P_STATE_CHANGE = "p2pStateChange"
const EVENT_P2P_PERSISTENT_GROUP_CHANGE = "p2pPersistentGroupChange"
const EVENT_P2P_DEVICE_STATE_CHANGE = "p2pDeviceChange"
const EVENT_P2P_PEER_DEVICE_CHANGE = "p2pPeerDeviceChange"
const EVENT_P2P_CONN_STATE_CHANGE = "p2pConnectionChange"
const EVENT_P2P_DISCOVERY_CHANGE = "p2pDiscoveryChange"

// syscap code
const SYSCAP_WIFI_CORE = 2400000i32
const SYSCAP_WIFI_STA = 2500000i32
const SYSCAP_WIFI_P2P = 2800000i32

/**
 * Wi-Fi device address( mac / bssid ) type.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.Core"
]
public enum DeviceAddressType {
    /**
     * random device address
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    RandomDeviceAddress
    |
    /**
     * real device address
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    RealDeviceAddress
    | ...

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    func getValue(): Int32 {
        match (this) {
            case RandomDeviceAddress => 0
            case RealDeviceAddress => 1
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    static func parse(val: Int32): DeviceAddressType {
        match (val) {
            case 0 => RandomDeviceAddress
            case 1 => RealDeviceAddress
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }

    static func tryParse(val: Int32): ?DeviceAddressType {
        match (val) {
            case 0 => RandomDeviceAddress
            case 1 => RealDeviceAddress
            case _ => None
        }
    }
}

/**
 * Describes the wifi security type.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.Core"
]
public enum WifiSecurityType {
    /**
     * Invalid security type
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeInvalid
    |
    /**
     * Open security type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeOpen
    |
    /**
     * Wired Equivalent Privacy (WEP)
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeWep
    |
    /**
     * Pre-shared key (PSK)
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypePsk
    |
    /**
     * Simultaneous Authentication of Equals (SAE)
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeSae
    |
    /**
     * EAP authentication.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeEap
    |
    /**
     * SUITE_B_192 192 bit level.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeEapSuiteB
    |
    /**
     * Opportunistic Wireless Encryption.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeOwe
    |
    /**
     * WAPI certificate to be specified.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeWapiCert
    |
    /**
     * WAPI pre-shared key to be specified.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WifiSecTypeWapiPsk
    | ...

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    func getValue(): Int32 {
        match (this) {
            case WifiSecTypeInvalid => 0
            case WifiSecTypeOpen => 1
            case WifiSecTypeWep => 2
            case WifiSecTypePsk => 3
            case WifiSecTypeSae => 4
            case WifiSecTypeEap => 5
            case WifiSecTypeEapSuiteB => 6
            case WifiSecTypeOwe => 7
            case WifiSecTypeWapiCert => 8
            case WifiSecTypeWapiPsk => 9
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    static func parse(val: Int32): WifiSecurityType {
        match (val) {
            case 0 => WifiSecTypeInvalid
            case 1 => WifiSecTypeOpen
            case 2 => WifiSecTypeWep
            case 3 => WifiSecTypePsk
            case 4 => WifiSecTypeSae
            case 5 => WifiSecTypeEap
            case 6 => WifiSecTypeEapSuiteB
            case 7 => WifiSecTypeOwe
            case 8 => WifiSecTypeWapiCert
            case 9 => WifiSecTypeWapiPsk
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}

/**
 * Wi-Fi Category.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum WifiCategory {
    /**
     * Default.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Default
    |
    /**
     * Wifi6.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Wifi6
    |
    /**
     * Wifi6+.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Wifi6Plus
    |
    @!Hide[isChecked: true]
    Wifi7
    |
    @!Hide[isChecked: true]
    Wifi7Plus
    | ...

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    func getValue(): Int32 {
        match (this) {
            case Default => 1
            case Wifi6 => 2
            case Wifi6Plus => 3
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    static func parse(val: Int32): WifiCategory {
        if (val <= 0) {
            throw BusinessException(2501007, "Parameter validation failed.")
        }
        match (val) {
            case 1 => Default
            case 2 => Wifi6
            case 3 => Wifi6Plus
            case _ => Wifi6Plus
        }
    }
}

/**
 * P2P group owner band.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public enum GroupOwnerBand {
    /**
     * default band.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    GoBandAuto
    |
    /**
     * 2.4G band.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    GoBand2GHz
    |
    /**
     * 5G band.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    GoBand5GHz
    | ...

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    func getValue(): Int32 {
        match (this) {
            case GoBandAuto => 0
            case GoBand2GHz => 1
            case GoBand5GHz => 2
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }

    /**
     * @throws { BusinessException } 2501007 - Parameter validation failed.
     */
    static func parse(val: Int32): GroupOwnerBand {
        match (val) {
            case 0 => GoBandAuto
            case 1 => GoBand2GHz
            case 2 => GoBand5GHz
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}
