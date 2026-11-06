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
 * Connection settings of the candidate hotspot.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class ConnectSettings {
    private let connectSettingsImpl: ConnectSettingsImpl = ConnectSettingsImpl()

    /**
     * Creates ConnectSettings information.
     *
     * @param { Int32 } networkId - The ID (uniquely identifies) of a Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public init(
        networkId: Int32
    ) {
        this.networkId = networkId
    }

    /**
     * The ID (uniquely identifies) of a Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop networkId: Int32 {
        get() {
            return connectSettingsImpl.networkId
        }
        set(value) {
            connectSettingsImpl.networkId = value
        }
    }

    /**
     * Returned with user action, default value is false.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop withUserAction: ?Bool {
        get() {
            return connectSettingsImpl.withUserAction
        }
        set(value) {
            connectSettingsImpl.withUserAction = value
        }
    }

    /**
     * User action timeout threshold (unit is seconds).
     * The maximum value cannot exceed 30, and the default value is 10.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop userActionTimeout: ?Int32 {
        get() {
            return connectSettingsImpl.userActionTimeout
        }
        set(value) {
            connectSettingsImpl.userActionTimeout = value
        }
    }

    /**
     * Whether to add the network to the system for connection.
     * The default value is false. If set to true, the network will be added to the system
     *     before connection and cannot be retrieved again.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop addNetworkToSystem: ?Bool {
        get() {
            return connectSettingsImpl.addNetworkToSystem
        }
        set(value) {
            connectSettingsImpl.addNetworkToSystem = value
        }
    }
}

class ConnectSettingsImpl {
    var networkId: Int32 = 0
    var withUserAction: ?Bool = None
    var userActionTimeout: ?Int32 = None
    var addNetworkToSystem: ?Bool = None
}
