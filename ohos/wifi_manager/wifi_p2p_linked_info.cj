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
 * P2P linked information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public class WifiP2pLinkedInfo {
    internal init() {}
    private let wifiP2pLinkedInfoImpl: WifiP2pLinkedInfoImpl = WifiP2pLinkedInfoImpl()

    /**
     * Connection status.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    public mut prop connectState: P2pConnectState {
        get() {
            return wifiP2pLinkedInfoImpl.connectState
        }
        set(value) {
            wifiP2pLinkedInfoImpl.connectState = value
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
            return wifiP2pLinkedInfoImpl.isGroupOwner
        }
        set(value) {
            wifiP2pLinkedInfoImpl.isGroupOwner = value
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
            return wifiP2pLinkedInfoImpl.groupOwnerAddr
        }
        set(value) {
            wifiP2pLinkedInfoImpl.groupOwnerAddr = value
        }
    }
}

class WifiP2pLinkedInfoImpl {
    var connectState: P2pConnectState = P2pConnectState.Disconnected
    var isGroupOwner: Bool = false
    var groupOwnerAddr: String = ""
}
