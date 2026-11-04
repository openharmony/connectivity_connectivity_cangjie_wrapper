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
 * Wi-Fi EAP config.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class WifiEapConfig {
    private let wifiEapConfigImpl: WifiEapConfigImpl = WifiEapConfigImpl()

    /**
     * Creates WifiEapConfig information.
     *
     * @param { EapMethod } eapMethod - EAP authentication method.
     * @param { Phase2Method } phase2Method - Phase 2 authentication method.
     * @param { String } identity - The identity.
     * @param { String } anonymousIdentity - Anonymous identity.
     * @param { String } password - Password.
     * @param { String } caCertAlias - CA certificate alias.
     * @param { String } caPath - CA certificate path.
     * @param { String } clientCertAlias - Client certificate alias.
     * @param { UInt8Array } certEntry - Content of user's certificate.
     * @param { String } certPassword - Password of user's certificate.
     * @param { String } altSubjectMatch - Alternate subject match.
     * @param { String } domainSuffixMatch - Domain suffix match.
     * @param { String } realm - Realm for Passpoint credential.
     * @param { String } plmn - Public Land Mobile Network of the provider of Passpoint credential.
     * @param { Int32 } eapSubId - Sub ID of the SIM card.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public init(
        eapMethod: EapMethod,
        phase2Method: Phase2Method,
        identity: String,
        anonymousIdentity: String,
        password: String,
        caCertAlias: String,
        caPath: String,
        clientCertAlias: String,
        certEntry: Array<UInt8>,
        certPassword: String,
        altSubjectMatch: String,
        domainSuffixMatch: String,
        realm: String,
        plmn: String,
        eapSubId: Int32
    ) {
        this.eapMethod = eapMethod
        this.phase2Method = phase2Method
        this.identity = identity
        this.anonymousIdentity = anonymousIdentity
        this.password = password
        this.caCertAlias = caCertAlias
        this.caPath = caPath
        this.clientCertAlias = clientCertAlias
        this.certEntry = certEntry
        this.certPassword = certPassword
        this.altSubjectMatch = altSubjectMatch
        this.domainSuffixMatch = domainSuffixMatch
        this.realm = realm
        this.plmn = plmn
        this.eapSubId = eapSubId
    }

    /**
     * EAP authentication method.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop eapMethod: EapMethod {
        get() {
            return wifiEapConfigImpl.eapMethod
        }
        set(value) {
            wifiEapConfigImpl.eapMethod = value
        }
    }

    /**
     * Phase 2 authentication method.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop phase2Method: Phase2Method {
        get() {
            return wifiEapConfigImpl.phase2Method
        }
        set(value) {
            wifiEapConfigImpl.phase2Method = value
        }
    }

    /**
     * The identity.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop identity: String {
        get() {
            return wifiEapConfigImpl.identity
        }
        set(value) {
            wifiEapConfigImpl.identity = value
        }
    }

    /**
     * Anonymous identity.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop anonymousIdentity: String {
        get() {
            return wifiEapConfigImpl.anonymousIdentity
        }
        set(value) {
            wifiEapConfigImpl.anonymousIdentity = value
        }
    }

    /**
     * Password.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop password: String {
        get() {
            return wifiEapConfigImpl.password
        }
        set(value) {
            wifiEapConfigImpl.password = value
        }
    }

    /**
     * CA certificate alias.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop caCertAlias: String {
        get() {
            return wifiEapConfigImpl.caCertAlias
        }
        set(value) {
            wifiEapConfigImpl.caCertAlias = value
        }
    }

    /**
     * CA certificate path.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop caPath: String {
        get() {
            return wifiEapConfigImpl.caPath
        }
        set(value) {
            wifiEapConfigImpl.caPath = value
        }
    }

    /**
     * Client certificate alias.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop clientCertAlias: String {
        get() {
            return wifiEapConfigImpl.clientCertAlias
        }
        set(value) {
            wifiEapConfigImpl.clientCertAlias = value
        }
    }

    /**
     * Content of user's certificate.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop certEntry: Array<UInt8> {
        get() {
            return wifiEapConfigImpl.certEntry
        }
        set(value) {
            wifiEapConfigImpl.certEntry = value
        }
    }

    /**
     * Password of user's certificate.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop certPassword: String {
        get() {
            return wifiEapConfigImpl.certPassword
        }
        set(value) {
            wifiEapConfigImpl.certPassword = value
        }
    }

    /**
     * Alternate subject match.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop altSubjectMatch: String {
        get() {
            return wifiEapConfigImpl.altSubjectMatch
        }
        set(value) {
            wifiEapConfigImpl.altSubjectMatch = value
        }
    }

    /**
     * Domain suffix match.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop domainSuffixMatch: String {
        get() {
            return wifiEapConfigImpl.domainSuffixMatch
        }
        set(value) {
            wifiEapConfigImpl.domainSuffixMatch = value
        }
    }

    /**
     * Realm for Passpoint credential.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop realm: String {
        get() {
            return wifiEapConfigImpl.realm
        }
        set(value) {
            wifiEapConfigImpl.realm = value
        }
    }

    /**
     * Public Land Mobile Network of the provider of Passpoint credential.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop plmn: String {
        get() {
            return wifiEapConfigImpl.plmn
        }
        set(value) {
            wifiEapConfigImpl.plmn = value
        }
    }

    /**
     * Sub ID of the SIM card.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop eapSubId: Int32 {
        get() {
            return wifiEapConfigImpl.eapSubId
        }
        set(value) {
            wifiEapConfigImpl.eapSubId = value
        }
    }
}

class WifiEapConfigImpl {
    var eapMethod: EapMethod = EapMethod.EapNone
    var phase2Method: Phase2Method = Phase2Method.Phase2None
    var identity: String = ""
    var anonymousIdentity: String = ""
    var password: String = ""
    var caCertAlias: String = ""
    var caPath: String = ""
    var clientCertAlias: String = ""
    var certEntry: Array<UInt8> = []
    var certPassword: String = ""
    var altSubjectMatch: String = ""
    var domainSuffixMatch: String = ""
    var realm: String = ""
    var plmn: String = ""
    var eapSubId: Int32 = 0
}
