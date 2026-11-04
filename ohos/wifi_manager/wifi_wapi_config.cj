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
 * Wi-Fi WAPI config.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiWapiConfig {
    private let wifiWapiConfigImpl: WifiWapiConfigImpl = WifiWapiConfigImpl()

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
            return wifiWapiConfigImpl.wapiPskType
        }
        set(value) {
            wifiWapiConfigImpl.wapiPskType = value
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
            return wifiWapiConfigImpl.wapiAsCert
        }
        set(value) {
            wifiWapiConfigImpl.wapiAsCert = value
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
            return wifiWapiConfigImpl.wapiUserCert
        }
        set(value) {
            wifiWapiConfigImpl.wapiUserCert = value
        }
    }
}

class WifiWapiConfigImpl {
    var wapiPskType: WapiPskType = WapiPskType.WapiPskAscii
    var wapiAsCert: String = ""
    var wapiUserCert: String = ""
}
