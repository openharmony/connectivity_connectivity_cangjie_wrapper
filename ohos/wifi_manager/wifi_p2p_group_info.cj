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
 * P2P group information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pGroupInfo {
    internal init() {}
    private let wifiP2pGroupInfoImpl: WifiP2pGroupInfoImpl = WifiP2pGroupInfoImpl()

    /**
     * Indicates whether it is group owner.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop isP2pGo: Bool {
        get() {
            return wifiP2pGroupInfoImpl.isP2pGo
        }
        set(value) {
            wifiP2pGroupInfoImpl.isP2pGo = value
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
            return wifiP2pGroupInfoImpl.ownerInfo
        }
        set(value) {
            wifiP2pGroupInfoImpl.ownerInfo = value
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
            return wifiP2pGroupInfoImpl.passphrase
        }
        set(value) {
            wifiP2pGroupInfoImpl.passphrase = value
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
            return wifiP2pGroupInfoImpl.interfaceName
        }
        set(value) {
            wifiP2pGroupInfoImpl.interfaceName = value
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
            return wifiP2pGroupInfoImpl.groupName
        }
        set(value) {
            wifiP2pGroupInfoImpl.groupName = value
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
            return wifiP2pGroupInfoImpl.networkId
        }
        set(value) {
            wifiP2pGroupInfoImpl.networkId = value
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
            return wifiP2pGroupInfoImpl.frequency
        }
        set(value) {
            wifiP2pGroupInfoImpl.frequency = value
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
            return wifiP2pGroupInfoImpl.clientDevices
        }
        set(value) {
            wifiP2pGroupInfoImpl.clientDevices = value
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
            return wifiP2pGroupInfoImpl.goIpAddress
        }
        set(value) {
            wifiP2pGroupInfoImpl.goIpAddress = value
        }
    }
}

class WifiP2pGroupInfoImpl {
    var isP2pGo: Bool = false
    var ownerInfo: WifiP2pDevice = WifiP2pDevice("", "", "", P2pDeviceStatus.Available, 0)
    var passphrase: String = ""
    var interfaceName: String = ""
    var groupName: String = ""
    var networkId: Int32 = 0
    var frequency: Int32 = 0
    var clientDevices: Array<WifiP2pDevice> = []
    var goIpAddress: String = ""
}
