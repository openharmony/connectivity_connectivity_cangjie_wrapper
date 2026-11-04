/*
 * Copyright (c) 2025-2026 Huawei Device Co., Ltd.
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

import ohos.labels.*

/**
 * Wi-Fi device configuration information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiDeviceConfig {
    private let wifiDeviceConfigImpl: WifiDeviceConfigImpl = WifiDeviceConfigImpl()

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
        wifiDeviceConfigImpl.bssidType = bssidType
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
            return wifiDeviceConfigImpl.ssid
        }
        set(value) {
            wifiDeviceConfigImpl.ssid = value
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
            return wifiDeviceConfigImpl.bssid
        }
        set(value) {
            wifiDeviceConfigImpl.bssid = value
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
            return wifiDeviceConfigImpl.bssidType
        }
        set(value) {
            wifiDeviceConfigImpl.bssidType = value
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
            return wifiDeviceConfigImpl.preSharedKey
        }
        set(value) {
            wifiDeviceConfigImpl.preSharedKey = value
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
            return wifiDeviceConfigImpl.isHiddenSsid
        }
        set(value) {
            wifiDeviceConfigImpl.isHiddenSsid = value
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
            return wifiDeviceConfigImpl.securityType
        }
        set(value) {
            wifiDeviceConfigImpl.securityType = value
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
            return wifiDeviceConfigImpl.eapConfig
        }
        set(value) {
            wifiDeviceConfigImpl.eapConfig = value
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
            return wifiDeviceConfigImpl.wapiConfig
        }
        set(value) {
            wifiDeviceConfigImpl.wapiConfig = value
        }
    }

}

class WifiDeviceConfigImpl {
    var ssid: String = ""
    var bssid: ?String = None
    var preSharedKey: String = ""
    var isHiddenSsid: ?Bool = None
    var securityType: WifiSecurityType = WifiSecurityType.WifiSecTypeInvalid
    var eapConfig: ?WifiEapConfig = None
    var wapiConfig: ?WifiWapiConfig = None
    // Internal-only storage for the constructor's bssidType argument: cj.d does
    // not expose a public property for it, but the native FFI needs the value.
    var bssidType: ?DeviceAddressType = None
}
