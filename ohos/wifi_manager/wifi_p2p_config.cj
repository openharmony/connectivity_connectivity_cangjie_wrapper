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

import ohos.labels.APILevel

/**
 * P2P config.
 */
@!APILevel[
    22,
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2PConfig {
    /**
     * Device mac address
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var deviceAddress: String

    /**
     * Group network ID. When creating a group, -1 indicates creates a temporary group,
     * -2: indicates creates a persistent group
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var netId: Int32

    /**
     * The passphrase of this {@code WifiP2pConfig} instance 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var passphrase: String

    /**
     * Group name 
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var groupName: String

    /**
     * Group owner band
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var goBand: GroupOwnerBand

    /**
     * Device mac address type
     */
    @!APILevel[
        22,
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var deviceAddressType: DeviceAddressType

    /**
     * WifiP2PConfig constructor
     */
    @!APILevel[
        22,
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
        this.deviceAddress = deviceAddress
        this.netId = netId
        this.passphrase = passphrase
        this.groupName = groupName
        this.goBand = goBand
        this.deviceAddressType = deviceAddressType
    }
}
