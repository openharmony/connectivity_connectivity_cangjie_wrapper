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
 * P2P device information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pDevice {
    private let wifiP2pDeviceImpl: WifiP2pDeviceImpl = WifiP2pDeviceImpl()

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
            return wifiP2pDeviceImpl.deviceName
        }
        set(value) {
            wifiP2pDeviceImpl.deviceName = value
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
            return wifiP2pDeviceImpl.deviceAddress
        }
        set(value) {
            wifiP2pDeviceImpl.deviceAddress = value
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
            return wifiP2pDeviceImpl.deviceAddressType
        }
        set(value) {
            wifiP2pDeviceImpl.deviceAddressType = value
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
            return wifiP2pDeviceImpl.primaryDeviceType
        }
        set(value) {
            wifiP2pDeviceImpl.primaryDeviceType = value
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
            return wifiP2pDeviceImpl.deviceStatus
        }
        set(value) {
            wifiP2pDeviceImpl.deviceStatus = value
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
            return wifiP2pDeviceImpl.groupCapabilities
        }
        set(value) {
            wifiP2pDeviceImpl.groupCapabilities = value
        }
    }
}

class WifiP2pDeviceImpl {
    var deviceName: String = ""
    var deviceAddress: String = ""
    var deviceAddressType: ?DeviceAddressType = None
    var primaryDeviceType: String = ""
    var deviceStatus: P2pDeviceStatus = P2pDeviceStatus.Available
    var groupCapabilities: Int32 = 0
}
