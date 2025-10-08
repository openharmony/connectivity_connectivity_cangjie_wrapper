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

import ohos.ffi.*
import ohos.labels.*

/**
 * Describes the scanned Wi-Fi information.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiScanInfo {
    /**
     * Wi-Fi SSID: the maximum length is 32 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let ssid: String

    /**
     * Wi-Fi bssid(MAC): the length is 6
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let bssid: String

    /**
     * Wi-Fi bssid type
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let bssidType: DeviceAddressType

    /**
     * Hotspot capability
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let capabilities: String

    /**
     * Security type: reference definition of WifiSecurityType
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let securityType: WifiSecurityType

    /**
     * Received signal strength indicator (RSSI)
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let rssi: Int32

    /**
     * Frequency band, 1: 2.4G, 2: 5G
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let band: Int32

    /**
     * Frequency
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let frequency: Int32

    /**
     * Channel width
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let channelWidth: Int32

    /**
     * Center frequency 0.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let centerFrequency0: Int32

    /**
     * Center frequency 1.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let centerFrequency1: Int32

    /**
     * Information elements.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let infoElems: Array<WifiInfoElem>

    /**
     * Time stamp
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let timestamp: Int64

    /**
     * Supported wifi category
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let supportedWifiCategory: WifiCategory

    /**
     * Whether the Wi-Fi hotspot is HiLink network.
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public let isHiLinkNetwork: Bool

    init(ssid: String, bssid: String, bssidType: DeviceAddressType, capabilities: String,
        securityType: WifiSecurityType, rssi: Int32, band: Int32, frequency: Int32,
        channelWidth: Int32, centerFrequency0: Int32, centerFrequency1: Int32,
        infoElems: Array<WifiInfoElem>, timestamp: Int64, supportedWifiCategory: WifiCategory,
        isHiLinkNetwork: Bool) {
        this.ssid = ssid
        this.bssid = bssid
        this.bssidType = bssidType
        this.capabilities = capabilities
        this.securityType = securityType
        this.rssi = rssi
        this.band = band
        this.frequency = frequency
        this.channelWidth = channelWidth
        this.centerFrequency0 = centerFrequency0
        this.centerFrequency1 = centerFrequency1
        this.infoElems = infoElems
        this.timestamp = timestamp
        this.supportedWifiCategory = supportedWifiCategory
        this.isHiLinkNetwork = isHiLinkNetwork
    }

    init(info: CWifiScanInfo) {
        this.supportedWifiCategory = WifiCategory.parse(info.supportedWifiCategory)
        this.securityType = WifiSecurityType.parse(info.securityType)
        this.bssidType = DeviceAddressType.parse(info.bssidType)
        this.isHiLinkNetwork = info.isHiLinkNetwork
        this.timestamp = info.timestamp
        this.rssi = info.rssi
        this.band = info.band
        this.frequency = info.frequency
        this.channelWidth = info.channelWidth
        this.centerFrequency0 = info.centerFrequency0
        this.centerFrequency1 = info.centerFrequency1
        this.infoElems = unsafe {
            cArr2cjArr<CWifiInfoElem, WifiInfoElem>(info.elemsSize, info.infoElems) {
                elem => WifiInfoElem(elem)
            }
        }
        this.ssid = info.ssid.toString()
        this.bssid = info.bssid.toString()
        this.capabilities = info.capabilities.toString()
    }
}
