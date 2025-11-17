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
    since: "22",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pConfig {
    /**
     * Device mac address
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var deviceAddress: String

    /**
     * Device mac address type
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var deviceAddressType: DeviceAddressType

    /**
     * Group network ID. When creating a group, -1 indicates creates a temporary group,
     * -2: indicates creates a persistent group
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var netId: Int32

    /**
     * The passphrase of this WifiP2pConfig instance 
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var passphrase: String

    /**
     * Group name 
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var groupName: String

    /**
     * Group owner band
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public var goBand: GroupOwnerBand

    /**
     * WifiP2pConfig constructor
     *
     * @param { String } deviceAddress - Device mac address
     * @param { Int32 } netId - Group network ID. When creating a group, -1 indicates creates a temporary group,
     * -2: indicates creates a persistent group
     * @param { String } passphrase - The passphrase of this WifiP2pConfig instance 
     * @param { String } groupName - Group name 
     * @param { GroupOwnerBand } goBand - Group owner band
     * @param { DeviceAddressType } deviceAddressType - Device mac address type
     */
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
        this.deviceAddress = deviceAddress
        this.netId = netId
        this.passphrase = passphrase
        this.groupName = groupName
        this.goBand = goBand
        this.deviceAddressType = deviceAddressType
    }
}
