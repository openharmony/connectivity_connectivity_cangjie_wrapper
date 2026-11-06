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

import ohos.ffi.CArrUI8
import ohos.ffi.{ cArr2cjArr, cjArr2CArr }
import ohos.business_exception.BusinessException
import ohos.labels.*

foreign {
    func FfiWifiIsWifiActive(ret: CPointer<Bool>): Int32

    func FfiWifiGetScanInfoList(ret: CPointer<Int32>): WifiScanInfoArr

    func FfiWifiRemoveCandidateConfig(id: Int32): Int32

    func FfiWifiConnectToCandidateConfigWithSettings(settings: CPointer<CWifiConnectSettings>): Int32

    func FfiWifiGetSignalLevel(rssi: Int32, band: Int32, ret: CPointer<UInt32>): Int32

    func FfiWifiIsConnected(ret: CPointer<Bool>): Int32

    func FfiWifiIsFeatureSupported(featureId: Int64, ret: CPointer<Bool>): Int32

    func FfiWifiGetIpInfo(ret: CPointer<CIpInfo>): Int32

    func FfiWifiGetIpv6Info(ret: CPointer<CIpv6Info>): Int32

    func FfiWifiGetCountryCode(code: CPointer<Int32>): CString

    func FfiWifiIsBandTypeSupported(bandType: Int32, ret: CPointer<Bool>): Int32

    func FfiWifiIsMeteredHotspot(ret: CPointer<Bool>): Int32

    func FfiWifiRemoveGroup(): Int32

    func FfiWifiP2pConnect(cfg: CPointer<CWifiP2PConfig>): Int32

    func FfiWifiP2pCancelConnect(): Int32

    func FfiWifiStartDiscoverDevices(): Int32

    func FfiWifiStopDiscoverDevices(): Int32

    func FfiWifiGetP2pLinkedInfo(info: CPointer<CWifiP2pLinkedInfo>): Int32

    func FfiWifiGetCurrentGroup(info: CPointer<CWifiP2pGroupInfo>): Int32

    func FfiWifiGetP2pPeerDevices(code: CPointer<Int32>): WifiP2pDeviceArr

    func FfiWifiGetP2pLocalDevice(info: CPointer<CWifiP2pDevice>): Int32

    func FfiWifiCreateGroup(cfg: CPointer<CWifiP2PConfig>): Int32

    func FfiWifiStartScan(): Int32

    func FfiWifiGetLinkedInfo(info: CPointer<CWifiLinkedInfo>): Int32

    func FfiWifiGetLinkedInfoV2(info: CPointer<CWifiLinkedInfoV2>): Int32

    func FfiWifiAddCandidateConfig(cfg: CWifiDeviceConfig, ret: CPointer<Int32>): Int32

    func FfiWifiGetCandidateConfigs(code: CPointer<Int32>): WifiDeviceConfigArr
    func FfiWifiGetCandidateConfigsV2(code: CPointer<Int32>): WifiDeviceConfigArr

    func FfiWifiWifiOn(event: CString, id: Int64): Int32

    func FfiWifiWifiOff(event: CString): Int32
}

// Optional ConnectSettings fields use -1 to indicate "unset". The defaults
// (withUserAction=false, userActionTimeout=DEFAULT_DIALOG_TIMEOUT, addNetworkToSystem=false)
// are applied on the C++ side so that they are not duplicated here.
func optionalBoolToInt32(v: ?Bool): Int32 {
    match (v) {
        case None => -1
        case Some(b) => if (b) { 1 } else { 0 }
    }
}

func optionalInt32OrUnset(v: ?Int32): Int32 {
    match (v) {
        case None => -1
        case Some(i) => i
    }
}

func safeMalloc<T>(count!: Int64 = 1): CPointer<T> where T <: CType {
    let ptr = unsafe { LibC.malloc<T>(count: count) }
    if (ptr.isNull()) {
        throw BusinessException(2501000, "Out of memory.")
    }
    ptr
}

@C
struct CWifiInfoElem {
    CWifiInfoElem(
        let eid: UInt32,
        let content: CArrUI8
    ) {}

    func free() {
        unsafe { LibC.free(content.head) }
    }
}

@C
struct CWifiScanInfo {
    CWifiScanInfo(
        let ssid: CString, // the maximum length is 32
        let bssid: CString, // the length is 6
        let bssidType: Int32,
        let capabilities: CString,
        let securityType: Int32,
        let rssi: Int32, // Received signal strength indicator
        let band: Int32, // Frequency band, 1: 2.4G, 2: 5G
        let frequency: Int32,
        let channelWidth: Int32,
        let centerFrequency0: Int32,
        let centerFrequency1: Int32,
        let infoElems: CPointer<CWifiInfoElem>,
        let elemsSize: Int64,
        let timestamp: Int64,
        let supportedWifiCategory: Int32,
        let isHiLinkNetwork: Bool
    ) {}

    func free() {
        unsafe {
            LibC.free(ssid)
            LibC.free(bssid)
            LibC.free(capabilities)
            if (infoElems.isNotNull()) {
                for (i in 0..elemsSize) {
                    infoElems.read(i).free()
                }
            }
            LibC.free(infoElems)
        }
    }
}

@C
struct WifiScanInfoArr {
    WifiScanInfoArr(
        let head: CPointer<CWifiScanInfo>,
        let size: Int64
    ) {}

    unsafe func free() {
        if (head.isNotNull()) {
            for (i in 0..size) {
                head.read(i).free()
            }
        }
        LibC.free(head)
    }
}

@C
struct CWifiDeviceConfig {
    var securityType: Int32 = 0
    var bssidType: Int32 = 0
    var isHiddenSsid: Bool = false
    var bssid: CString = CString(CPointer<UInt8>())
    var ssid: CString = CString(CPointer<UInt8>())
    var preSharedKey: CString = CString(CPointer<UInt8>())
    var eapConfig: CWifiEapConfig = CWifiEapConfig()
    var wapiConfig: CWifiWapiConfig = CWifiWapiConfig()

    init(cfg: WifiDeviceConfig) {
        this.securityType = wifiSecurityTypeValue(cfg.securityType)
        // Default matches NAPI (RANDOM_DEVICE_ADDRESS). taihe leaves the native
        // default (REAL_DEVICE_ADDRESS); ArkTS itself is inconsistent here.
        this.bssidType = (cfg.bssidType ?? DeviceAddressType.RandomDeviceAddress).getValue()
        this.isHiddenSsid = cfg.isHiddenSsid ?? false
        try {
            this.ssid = unsafe { LibC.mallocCString(cfg.ssid) }
            this.preSharedKey = unsafe { LibC.mallocCString(cfg.preSharedKey) }
            match (cfg.bssid) {
                case Some(v) => this.bssid = unsafe { LibC.mallocCString(v) }
                case None => ()
            }
            match (cfg.eapConfig) {
                case Some(v) => this.eapConfig = CWifiEapConfig(v)
                case None => ()
            }
            match (cfg.wapiConfig) {
                case Some(v) => this.wapiConfig = CWifiWapiConfig(v)
                case None => ()
            }
        } catch (e: Exception) {
            unsafe {
                LibC.free(bssid)
                LibC.free(ssid)
                LibC.free(preSharedKey)
                eapConfig.free()
                wapiConfig.free()
            }
            throw e
        }
    }

    func free() {
        unsafe {
            LibC.free(bssid)
            LibC.free(ssid)
            LibC.free(preSharedKey)
            if (!eapConfig.isNone) {
                eapConfig.free()
            }
            if (!wapiConfig.isNone) {
                wapiConfig.free()
            }
        }
    }

    func toWifiDeviceConfig(): WifiDeviceConfig {
        let bssidValue: ?String = if (bssid.isNull()) {
            None
        } else {
            Some(bssid.toString())
        }
        let cfg = WifiDeviceConfig(
            ssid.toString(),
            preSharedKey.toString(),
            WifiSecurityType.parse(securityType),
            bssid: bssidValue,
            bssidType: Some(DeviceAddressType.parse(bssidType)),
            isHiddenSsid: isHiddenSsid
        )
        if (!eapConfig.isNone) {
            cfg.eapConfig = Some(eapConfig.toWifiEapConfig())
        }
        if (!wapiConfig.isNone) {
            cfg.wapiConfig = Some(wapiConfig.toWifiWapiConfig())
        }
        cfg
    }
}

@C
struct WifiDeviceConfigArr {
    WifiDeviceConfigArr(
        let head: CPointer<CWifiDeviceConfig>,
        let size: Int64
    ) {}

    unsafe func free() {
        if (head.isNotNull()) {
            for (i in 0..size) {
                head.read(i).free()
            }
        }
        LibC.free(head)
    }
}

@C
struct CWifiEapConfig {
    var eapMethod: Int32 = 0
    var phase2Method: Int32 = 0
    var identity: CString = CString(CPointer<UInt8>())
    var anonymousIdentity: CString = CString(CPointer<UInt8>())
    var password: CString
    var caCertAlias: CString = CString(CPointer<UInt8>())
    var caPath: CString = CString(CPointer<UInt8>())
    var clientCertAlias: CString = CString(CPointer<UInt8>())
    var certEntry: CArrUI8 = CArrUI8(CPointer<UInt8>(), 0)
    var certPassword: CString = CString(CPointer<UInt8>())
    var altSubjectMatch: CString = CString(CPointer<UInt8>())
    var domainSuffixMatch: CString = CString(CPointer<UInt8>())
    var realm: CString = CString(CPointer<UInt8>())
    var plmn: CString = CString(CPointer<UInt8>())
    var eapSubId: Int32 = 0
    var isNone: Bool = true

    init() {
        this.password = CString(CPointer<UInt8>())
    }

    init(cfg: WifiEapConfig) {
        this.password = CString(CPointer<UInt8>())
        this.eapMethod = eapMethodValue(cfg.eapMethod)
        this.phase2Method = phase2MethodValue(cfg.phase2Method)
        this.eapSubId = cfg.eapSubId
        this.isNone = false
        try {
            this.identity = unsafe { LibC.mallocCString(cfg.identity) }
            this.anonymousIdentity = unsafe { LibC.mallocCString(cfg.anonymousIdentity) }
            this.password = unsafe { LibC.mallocCString(cfg.password) }
            this.caCertAlias = unsafe { LibC.mallocCString(cfg.caCertAlias) }
            this.caPath = unsafe { LibC.mallocCString(cfg.caPath) }
            this.clientCertAlias = unsafe { LibC.mallocCString(cfg.clientCertAlias) }
            this.certEntry = unsafe { CArrUI8(cjArr2CArr<UInt8, UInt8>(cfg.certEntry) {i => i}, cfg.certEntry.size) }
            this.certPassword = unsafe { LibC.mallocCString(cfg.certPassword) }
            this.altSubjectMatch = unsafe { LibC.mallocCString(cfg.altSubjectMatch) }
            this.domainSuffixMatch = unsafe { LibC.mallocCString(cfg.domainSuffixMatch) }
            this.realm = unsafe { LibC.mallocCString(cfg.realm) }
            this.plmn = unsafe { LibC.mallocCString(cfg.plmn) }
        } catch (e: Exception) {
            unsafe {
                LibC.free(identity)
                LibC.free(anonymousIdentity)
                LibC.free(password)
                LibC.free(caCertAlias)
                LibC.free(caPath)
                LibC.free(clientCertAlias)
                LibC.free(certPassword)
                LibC.free(altSubjectMatch)
                LibC.free(domainSuffixMatch)
                LibC.free(realm)
                LibC.free(plmn)
                LibC.free(certEntry.head)
            }
            throw e
        }
    }

    func free() {
        unsafe {
            LibC.free(identity)
            LibC.free(anonymousIdentity)
            LibC.free(password)
            LibC.free(caCertAlias)
            LibC.free(caPath)
            LibC.free(clientCertAlias)
            LibC.free(certPassword)
            LibC.free(altSubjectMatch)
            LibC.free(domainSuffixMatch)
            LibC.free(realm)
            LibC.free(plmn)
            LibC.free(certEntry.head)
        }
    }

    func toWifiEapConfig(): WifiEapConfig {
        WifiEapConfig(
            EapMethod.parse(eapMethod),
            Phase2Method.parse(phase2Method),
            identity.toString(),
            anonymousIdentity.toString(),
            password.toString(),
            caCertAlias.toString(),
            caPath.toString(),
            clientCertAlias.toString(),
            unsafe {
                cArr2cjArr<UInt8, UInt8>(certEntry.size, certEntry.head) {
                    i => i
                }
            },
            certPassword.toString(),
            altSubjectMatch.toString(),
            domainSuffixMatch.toString(),
            realm.toString(),
            plmn.toString(),
            eapSubId
        )
    }
}

@C
struct CWifiWapiConfig {
    var wapiPskType: Int32 = 0
    var wapiAsCert: CString = CString(CPointer<UInt8>())
    var wapiUserCert: CString = CString(CPointer<UInt8>())
    var isNone: Bool = true

    init() {}

    init(cfg: WifiWapiConfig) {
        this.wapiPskType = wapiPskTypeValue(cfg.wapiPskType)
        this.isNone = false
        this.wapiAsCert = unsafe { LibC.mallocCString(cfg.wapiAsCert) }
        try {
            this.wapiUserCert = unsafe { LibC.mallocCString(cfg.wapiUserCert) }
        } catch (e: Exception) {
            unsafe { LibC.free(wapiAsCert) }
            throw e
        }
    }

    func free() {
        unsafe {
            LibC.free(wapiAsCert)
            LibC.free(wapiUserCert)
        }
    }

    func toWifiWapiConfig(): WifiWapiConfig {
        WifiWapiConfig(WapiPskType.parse(wapiPskType), wapiAsCert.toString(), wapiUserCert.toString())
    }
}

@C
struct CIpInfo {
    CIpInfo(
        let ipAddress: UInt32,
        let gateway: UInt32,
        let netmask: UInt32,
        let primaryDns: UInt32,
        let secondDns: UInt32,
        let serverIp: UInt32,
        let leaseDuration: UInt32
    ) {}

    func toIpInfo(): IpInfo {
        let info = IpInfo()
        info.ipAddress = ipAddress
        info.gateway = gateway
        info.netmask = netmask
        info.primaryDns = primaryDns
        info.secondDns = secondDns
        info.serverIp = serverIp
        info.leaseDuration = leaseDuration
        info
    }
}

@C
struct CIpv6Info {
    CIpv6Info(
        let linkIpv6Address: CString,
        let globalIpv6Address: CString,
        let randomGlobalIpv6Address: CString,
        let uniqueIpv6Address: CString,
        let randomUniqueIpv6Address: CString,
        let gateway: CString,
        let netmask: CString,
        let primaryDNS: CString,
        let secondDNS: CString
    ) {}

    func free() {
        unsafe {
            LibC.free(linkIpv6Address)
            LibC.free(globalIpv6Address)
            LibC.free(randomGlobalIpv6Address)
            LibC.free(uniqueIpv6Address)
            LibC.free(randomUniqueIpv6Address)
            LibC.free(gateway)
            LibC.free(netmask)
            LibC.free(primaryDNS)
            LibC.free(secondDNS)
        }
    }

    func toIpv6Info(): Ipv6Info {
        let unique: ?String = if (uniqueIpv6Address.isNull()) {
            None
        } else {
            Some(uniqueIpv6Address.toString())
        }
        let randomUnique: ?String = if (randomUniqueIpv6Address.isNull()) {
            None
        } else {
            Some(randomUniqueIpv6Address.toString())
        }
        let info = Ipv6Info()
        info.linkIpv6Address = linkIpv6Address.toString()
        info.globalIpv6Address = globalIpv6Address.toString()
        info.randomGlobalIpv6Address = randomGlobalIpv6Address.toString()
        info.gateway = gateway.toString()
        info.netmask = netmask.toString()
        info.primaryDNS = primaryDNS.toString()
        info.secondDNS = secondDNS.toString()
        info.uniqueIpv6Address = unique
        info.randomUniqueIpv6Address = randomUnique
        info
    }
}

@C
struct CWifiP2pLinkedInfo {
    CWifiP2pLinkedInfo(
        let connectState: Int32,
        let isGroupOwner: Bool,
        let groupOwnerAddr: CString
    ) {}

    func free() {
        unsafe { LibC.free(groupOwnerAddr) }
    }

    func toWifiP2pLinkedInfo(): WifiP2pLinkedInfo {
        let info = WifiP2pLinkedInfo()
        info.connectState = P2pConnectState.parse(connectState)
        info.isGroupOwner = isGroupOwner
        info.groupOwnerAddr = groupOwnerAddr.toString()
        info
    }
}

@C
struct CWifiP2pGroupInfo {
    CWifiP2pGroupInfo(
        let isP2pGo: Bool,
        let ownerInfo: CWifiP2pDevice,
        let passphrase: CString,
        let interfaceName: CString,
        let groupName: CString,
        let networkId: Int32,
        let frequency: Int32,
        let clientDevices: CPointer<CWifiP2pDevice>,
        let clientSize: Int64,
        let goIpAddress: CString
    ) {}

    func free() {
        unsafe {
            ownerInfo.free()
            LibC.free(passphrase)
            LibC.free(interfaceName)
            LibC.free(groupName)
            LibC.free(goIpAddress)
            if (clientDevices.isNotNull()) {
                for (i in 0..clientSize) {
                    clientDevices.read(i).free()
                }
            }
            LibC.free(clientDevices)
        }
    }

    func toWifiP2pGroupInfo(): WifiP2pGroupInfo {
        let info = WifiP2pGroupInfo()
        info.isP2pGo = isP2pGo
        info.ownerInfo = ownerInfo.toWifiP2pDevice()
        info.passphrase = passphrase.toString()
        info.interfaceName = interfaceName.toString()
        info.groupName = groupName.toString()
        info.networkId = networkId
        info.frequency = frequency
        info.clientDevices = unsafe {
            cArr2cjArr<CWifiP2pDevice, WifiP2pDevice>(clientSize, clientDevices) {
                c => c.toWifiP2pDevice()
            }
        }
        info.goIpAddress = goIpAddress.toString()
        info
    }
}

@C
struct CWifiP2pDevice {
    CWifiP2pDevice(
        let deviceName: CString,
        let deviceAddress: CString,
        let primaryDeviceType: CString,
        let deviceStatus: Int32,
        let groupCapabilities: Int32,
        let deviceAddressType: Int32
    ) {}

    func free() {
        unsafe {
            LibC.free(deviceName)
            LibC.free(deviceAddress)
            LibC.free(primaryDeviceType)
        }
    }

    func toWifiP2pDevice(): WifiP2pDevice {
        WifiP2pDevice(
            deviceName.toString(),
            deviceAddress.toString(),
            primaryDeviceType.toString(),
            P2pDeviceStatus.parse(deviceStatus),
            groupCapabilities,
            deviceAddressType: Some(DeviceAddressType.parse(deviceAddressType))
        )
    }
}

@C
struct WifiP2pDeviceArr {
    WifiP2pDeviceArr(
        let head: CPointer<CWifiP2pDevice>,
        let size: Int64
    ) {}

    func toCjArrAndFree(): Array<WifiP2pDevice> {
        var arr: Array<WifiP2pDevice> = Array<WifiP2pDevice>()
        // ffi return information may be invalid UTF8 and may be parsed abnormally.
        try {
            arr = unsafe {
                cArr2cjArr<CWifiP2pDevice, WifiP2pDevice>(size, head) {
                    ct => WifiP2pDevice(ct.deviceName.toString(), ct.deviceAddress.toString(), ct.primaryDeviceType.toString(), P2pDeviceStatus.parse(ct.deviceStatus), ct.groupCapabilities, deviceAddressType: Some(DeviceAddressType.parse(ct.deviceAddressType)))
                }
            }
        } finally {
            if (head.isNotNull()) {
                for (i in 0..size) {
                    unsafe { head.read(i).free() }
                }
            }
            unsafe { LibC.free(head) }
        }
        arr
    }
}

@C
struct CWifiConnectSettings {
    CWifiConnectSettings(
        let networkId: Int32,
        let withUserAction: Int32,
        let userActionTimeout: Int32,
        let addNetworkToSystem: Int32
    ) {}

    init(cfg: ConnectSettings) {
        this.networkId = cfg.networkId
        this.withUserAction = optionalBoolToInt32(cfg.withUserAction)
        this.userActionTimeout = optionalInt32OrUnset(cfg.userActionTimeout)
        this.addNetworkToSystem = optionalBoolToInt32(cfg.addNetworkToSystem)
    }
}

@C
struct CWifiP2PConfig {
    var deviceAddress: CString = CString(CPointer<UInt8>())
    var passphrase: CString = CString(CPointer<UInt8>())
    var groupName: CString = CString(CPointer<UInt8>())
    let netId: Int32
    let goBand: Int32
    let deviceAddressType: Int32

    /**
     * @throws { BusinessException } 2501000 - Operation failed.
     */
    init(cfg: WifiP2pConfig) {
        this.netId = cfg.netId
        this.goBand = cfg.goBand.getValue()
        this.deviceAddressType = cfg.deviceAddressType.getValue()
        try {
            this.deviceAddress = unsafe { LibC.mallocCString(cfg.deviceAddress) }
            this.passphrase = unsafe { LibC.mallocCString(cfg.passphrase) }
            this.groupName = unsafe { LibC.mallocCString(cfg.groupName) }
        } catch (e: Exception) {
            unsafe {
                LibC.free(deviceAddress)
                LibC.free(passphrase)
                LibC.free(groupName)
            }
            throw BusinessException(2501000, "Operation failed.")
        }
    }

    func free() {
        unsafe {
            LibC.free(deviceAddress)
            LibC.free(passphrase)
            LibC.free(groupName)
        }
    }
}

@C
struct CWifiLinkedInfo {
    CWifiLinkedInfo(
        let ssid: CString,
        let bssid: CString,
        let rssi: Int32,
        let band: Int32,
        let linkSpeed: Int32,
        let rxLinkSpeed: Int32,
        let maxSupportedTxLinkSpeed: Int32,
        let maxSupportedRxLinkSpeed: Int32,
        let frequency: Int32,
        let isHidden: Bool,
        let isRestricted: Bool,
        let macType: Int32, // Type of macAddress: 0 - real mac, 1 - random mac.
        let macAddress: CString,
        let ipAddress: UInt32,
        let connState: Int32,
        let channelWidth: Int32,
        let wifiStandard: Int32,
        let supportedWifiCategory: Int32,
        let isHiLinkNetwork: Bool
    ) {}

    func toWifiLinkedInfo(): WifiLinkedInfo {
        let info = WifiLinkedInfo()
        info.ssid = ssid.toString()
        info.bssid = bssid.toString()
        info.rssi = rssi
        info.band = band
        info.frequency = frequency
        info
    }

    func free() {
        unsafe {
            LibC.free(ssid)
            LibC.free(bssid)
            LibC.free(macAddress)
        }
    }
}

@C
struct CWifiLinkedInfoV2 {
    CWifiLinkedInfoV2(
        let ssid: CString,
        let bssid: CString,
        let rssi: Int32,
        let band: Int32,
        let linkSpeed: Int32,
        let rxLinkSpeed: Int32,
        let maxSupportedTxLinkSpeed: Int32,
        let maxSupportedRxLinkSpeed: Int32,
        let frequency: Int32,
        let isHidden: Bool,
        let isRestricted: Bool,
        let macType: Int32, // Type of macAddress: 0 - real mac, 1 - random mac.
        let macAddress: CString,
        let ipAddress: UInt32,
        let connState: Int32,
        let channelWidth: Int32,
        let wifiStandard: Int32,
        let supportedWifiCategory: Int32,
        let isHiLinkNetwork: Bool,
        let wifiLinkType: Int32,
        let wifiTxRxValid: Bool
    ) {}

    func free() {
        unsafe {
            LibC.free(ssid)
            LibC.free(bssid)
            LibC.free(macAddress)
        }
    }

    func toWifiLinkedInfo(): WifiLinkedInfo {
        let info = WifiLinkedInfo()
        info.ssid = ssid.toString()
        info.bssid = bssid.toString()
        info.rssi = rssi
        info.band = band
        info.frequency = frequency
        info
    }
}

/**
 * Wi-Fi IP information.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.WiFi.STA"
]
public class IpInfo {
    internal init() {}
    private let ipInfoImpl: IpInfoImpl = IpInfoImpl()

    /**
     * The IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop ipAddress: UInt32 {
        get() {
            return ipInfoImpl.ipAddress
        }
        set(value) {
            ipInfoImpl.ipAddress = value
        }
    }

    /**
     * The gateway of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop gateway: UInt32 {
        get() {
            return ipInfoImpl.gateway
        }
        set(value) {
            ipInfoImpl.gateway = value
        }
    }

    /**
     * The network mask of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop netmask: UInt32 {
        get() {
            return ipInfoImpl.netmask
        }
        set(value) {
            ipInfoImpl.netmask = value
        }
    }

    /**
     * The primary DNS server IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop primaryDns: UInt32 {
        get() {
            return ipInfoImpl.primaryDns
        }
        set(value) {
            ipInfoImpl.primaryDns = value
        }
    }

    /**
     * The secondary DNS server IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop secondDns: UInt32 {
        get() {
            return ipInfoImpl.secondDns
        }
        set(value) {
            ipInfoImpl.secondDns = value
        }
    }

    /**
     * The DHCP server IP address of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop serverIp: UInt32 {
        get() {
            return ipInfoImpl.serverIp
        }
        set(value) {
            ipInfoImpl.serverIp = value
        }
    }

    /**
     * The IP address lease duration of the Wi-Fi connection.
     */
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.WiFi.STA"
    ]
    public mut prop leaseDuration: UInt32 {
        get() {
            return ipInfoImpl.leaseDuration
        }
        set(value) {
            ipInfoImpl.leaseDuration = value
        }
    }
}

class IpInfoImpl {
    var ipAddress: UInt32 = 0
    var gateway: UInt32 = 0
    var netmask: UInt32 = 0
    var primaryDns: UInt32 = 0
    var secondDns: UInt32 = 0
    var serverIp: UInt32 = 0
    var leaseDuration: UInt32 = 0
}
