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
 * Wi-Fi connection information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiLinkedInfo {
    internal init() {}
    private let wifiLinkedInfoImpl: WifiLinkedInfoImpl = WifiLinkedInfoImpl()

    /**
     * The SSID of the Wi-Fi hotspot.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop ssid: String {
        get() {
            return wifiLinkedInfoImpl.ssid
        }
        set(value) {
            wifiLinkedInfoImpl.ssid = value
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
            return wifiLinkedInfoImpl.bssid
        }
        set(value) {
            wifiLinkedInfoImpl.bssid = value
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
            return wifiLinkedInfoImpl.rssi
        }
        set(value) {
            wifiLinkedInfoImpl.rssi = value
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
            return wifiLinkedInfoImpl.band
        }
        set(value) {
            wifiLinkedInfoImpl.band = value
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
            return wifiLinkedInfoImpl.frequency
        }
        set(value) {
            wifiLinkedInfoImpl.frequency = value
        }
    }
}

class WifiLinkedInfoImpl {
    var ssid: String = ""
    var bssid: String = ""
    var rssi: Int32 = 0
    var band: Int32 = 0
    var frequency: Int32 = 0
}
