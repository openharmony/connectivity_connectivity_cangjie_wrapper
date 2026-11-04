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
 * Wi-Fi IPv6 information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class Ipv6Info {
    internal init() {}
    private let ipv6InfoImpl: Ipv6InfoImpl = Ipv6InfoImpl()

    /**
     * The link IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop linkIpv6Address: String {
        get() {
            return ipv6InfoImpl.linkIpv6Address
        }
        set(value) {
            ipv6InfoImpl.linkIpv6Address = value
        }
    }

    /**
     * The global IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop globalIpv6Address: String {
        get() {
            return ipv6InfoImpl.globalIpv6Address
        }
        set(value) {
            ipv6InfoImpl.globalIpv6Address = value
        }
    }

    /**
     * The rand Global IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop randomGlobalIpv6Address: String {
        get() {
            return ipv6InfoImpl.randomGlobalIpv6Address
        }
        set(value) {
            ipv6InfoImpl.randomGlobalIpv6Address = value
        }
    }

    /**
     * The unique IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop uniqueIpv6Address: ?String {
        get() {
            return ipv6InfoImpl.uniqueIpv6Address
        }
        set(value) {
            ipv6InfoImpl.uniqueIpv6Address = value
        }
    }

    /**
     * The rand unique IPv6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop randomUniqueIpv6Address: ?String {
        get() {
            return ipv6InfoImpl.randomUniqueIpv6Address
        }
        set(value) {
            ipv6InfoImpl.randomUniqueIpv6Address = value
        }
    }

    /**
     * The gateway of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop gateway: String {
        get() {
            return ipv6InfoImpl.gateway
        }
        set(value) {
            ipv6InfoImpl.gateway = value
        }
    }

    /**
     * The network mask of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop netmask: String {
        get() {
            return ipv6InfoImpl.netmask
        }
        set(value) {
            ipv6InfoImpl.netmask = value
        }
    }

    /**
     * The primary DNS server IPV6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop primaryDNS: String {
        get() {
            return ipv6InfoImpl.primaryDNS
        }
        set(value) {
            ipv6InfoImpl.primaryDNS = value
        }
    }

    /**
     * The secondary DNS server IPV6 address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop secondDNS: String {
        get() {
            return ipv6InfoImpl.secondDNS
        }
        set(value) {
            ipv6InfoImpl.secondDNS = value
        }
    }
}

class Ipv6InfoImpl {
    var linkIpv6Address: String = ""
    var globalIpv6Address: String = ""
    var randomGlobalIpv6Address: String = ""
    var uniqueIpv6Address: ?String = None
    var randomUniqueIpv6Address: ?String = None
    var gateway: String = ""
    var netmask: String = ""
    var primaryDNS: String = ""
    var secondDNS: String = ""
}
