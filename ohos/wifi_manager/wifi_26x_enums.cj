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

import ohos.labels.*
import std.deriving.Derive
import ohos.business_exception.BusinessException

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum EapMethod {
    /**
     * EAP NONE.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapNone
    |
    /**
     * EAP PEAP.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapPeap
    |
    /**
     * EAP TLS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapTls
    |
    /**
     * EAP TTLS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapTtls
    |
    /**
     * EAP PWD.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapPwd
    |
    /**
     * EAP SIM.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapSim
    |
    /**
     * EAP AKA.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapAka
    |
    /**
     * EAP AKA PRIME.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapAkaPrime
    |
    /**
     * EAP UNAUTH TLS.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    EapUnauthTls
    |
    ...

    static func parse(val: Int32): EapMethod {
        match (val) {
            case 0 => EapNone
            case 1 => EapPeap
            case 2 => EapTls
            case 3 => EapTtls
            case 4 => EapPwd
            case 5 => EapSim
            case 6 => EapAka
            case 7 => EapAkaPrime
            case 8 => EapUnauthTls
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum Phase2Method {
    /**
     * Phase2 NONE.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2None
    |
    /**
     * Phase2 PAP.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Pap
    |
    /**
     * Phase2 MSCHAP.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Mschap
    |
    /**
     * Phase2 MSCHAPV2.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Mschapv2
    |
    /**
     * Phase2 GTC.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Gtc
    |
    /**
     * Phase2 SIM.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Sim
    |
    /**
     * Phase2 AKA.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2Aka
    |
    /**
     * Phase2 AKA+.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    Phase2AkaPrime
    |
    ...

    static func parse(val: Int32): Phase2Method {
        match (val) {
            case 0 => Phase2None
            case 1 => Phase2Pap
            case 2 => Phase2Mschap
            case 3 => Phase2Mschapv2
            case 4 => Phase2Gtc
            case 5 => Phase2Sim
            case 6 => Phase2Aka
            case 7 => Phase2AkaPrime
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.Core"
]
public enum WapiPskType {
    /**
     * ASCII character type of WAPI pre-shared key.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WapiPskAscii
    |
    /**
     * HEX character type of WAPI pre-shared key.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.Core"
    ]
    WapiPskHex
    |
    ...

    static func parse(val: Int32): WapiPskType {
        match (val) {
            case 0 => WapiPskAscii
            case 1 => WapiPskHex
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public enum WifiBandType {
    /**
     * Default.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBandNone
    |
    /**
     * Band 2.4G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand2g
    |
    /**
     * Band 5G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand5g
    |
    /**
     * Band 6G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand6g
    |
    /**
     * Band 60G.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    WifiBand60g
    |
    ...

    static func parse(val: Int32): WifiBandType {
        match (val) {
            case 0 => WifiBandNone
            case 1 => WifiBand2g
            case 2 => WifiBand5g
            case 3 => WifiBand6g
            case 4 => WifiBand60g
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public enum P2pConnectState {
    /**
     * p2p is disconnected.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Disconnected
    |
    /**
     * p2p is connected.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Connected
    |
    ...

    static func parse(val: Int32): P2pConnectState {
        match (val) {
            case 0 => Disconnected
            case 1 => Connected
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}

@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.P2P"
]
public enum P2pDeviceStatus {
    /**
     * Indicate p2p device is connected.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Connected
    |
    /**
     * Indicate p2p device is invited.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Invited
    |
    /**
     * Indicate p2p device is failed.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Failed
    |
    /**
     * Indicate p2p device is available.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Available
    |
    /**
     * Indicate p2p device is unavailable.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.P2P"
    ]
    Unavailable
    |
    ...

    static func parse(val: Int32): P2pDeviceStatus {
        match (val) {
            case 0 => Connected
            case 1 => Invited
            case 2 => Failed
            case 3 => Available
            case 4 => Unavailable
            case _ => throw BusinessException(2501007, "Parameter validation failed.")
        }
    }
}
