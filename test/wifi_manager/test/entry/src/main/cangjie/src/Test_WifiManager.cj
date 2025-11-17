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

package ohos_app_cangjie_entry

internal import std.sync.*
import std.unittest.testmacro.*
import kit.ConnectivityKit.*
import std.collection.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import kit.PerformanceAnalysisKit.Hilog
import ohos.ability_access_ctrl.Permissions
import ohos.callback_invoke.*
import ohos.business_exception.*

func loggerInfo(str: String) {
    Hilog.info(0, "CangjieTest", str)
}

@Test
public class Test_WifiManager {
    @BeforeAll
    func initPermission() {
        ["ohos.permission.GET_WIFI_INFO", "ohos.permission.SET_WIFI_INFO"] |>
            forEach<Permissions> {
            permissionName: Permissions =>
            getRequiredPermissions([permissionName])
            sleep(Duration.second * 1i64)
            try {
                click(at: Screen.getTheOnlyUiComponentWhoseTextEqualsTo("允许").centerPoint)
                sleep(Duration.second * 1i64)
            } catch (e: Exception) {
                loggerInfo("Permissions have been granted")
            }
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testWifiConnectivity() {
        if (isWifiActive()) {
            let wifis = getScanInfoList()
        } else {
            loggerInfo("wifi is not enabled, quit info test")
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func testp2p() {
        loggerInfo("start discover devices")
        spawn {
            startDiscoverDevices()
            sleep(Duration.second * 2)
            stopDiscoverDevices()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_toString(): Unit {
        @Expect(WifiSecurityType.WifiSecTypeInvalid.toString(), "WifiSecurityType.WifiSecTypeInvalid")
        @Expect(WifiSecurityType.WifiSecTypeOpen.toString(), "WifiSecurityType.WifiSecTypeOpen")
        @Expect(WifiSecurityType.WifiSecTypeWep.toString(), "WifiSecurityType.WifiSecTypeWep")
        @Expect(WifiSecurityType.WifiSecTypePsk.toString(), "WifiSecurityType.WifiSecTypePsk")
        @Expect(WifiSecurityType.WifiSecTypeSae.toString(), "WifiSecurityType.WifiSecTypeSae")
        @Expect(WifiSecurityType.WifiSecTypeEap.toString(), "WifiSecurityType.WifiSecTypeEap")
        @Expect(WifiSecurityType.WifiSecTypeEapSuiteB.toString(), "WifiSecurityType.WifiSecTypeEapSuiteB")
        @Expect(WifiSecurityType.WifiSecTypeOwe.toString(), "WifiSecurityType.WifiSecTypeOwe")
        @Expect(WifiSecurityType.WifiSecTypeWapiCert.toString(), "WifiSecurityType.WifiSecTypeWapiCert")
        @Expect(WifiSecurityType.WifiSecTypeWapiPsk.toString(), "WifiSecurityType.WifiSecTypeWapiPsk")
        @Expect(WifiCategory.Wifi6Plus.toString(), "WifiCategory.Wifi6Plus")
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_wifi(): Unit {
        let scanInfo = getScanInfoList()
        p2pCancelConnect()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_p2pconnect(): Unit {
        try {
            let config = WifiP2pConfig("00:11:22:33:44:55", 2, "", "", GroupOwnerBand.GoBandAuto)
            p2pConnect(config)
        } catch (e: Exception) {
            loggerInfo("test_p2pconnect error: ${e}")
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_on_off() {
        try {
            on(WifiCallbackType.WifiScanStateChange, WifiStateChangeCallback())
            sleep(Duration.second)
            off(WifiCallbackType.WifiScanStateChange)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_WifiSecurityType() {
        let wifiSecurityTypeArr: Array<WifiSecurityType> = [WifiSecurityType.WifiSecTypeInvalid, WifiSecurityType.WifiSecTypeOpen, WifiSecurityType.WifiSecTypeWep, WifiSecurityType.WifiSecTypePsk, WifiSecurityType.WifiSecTypeSae, WifiSecurityType.WifiSecTypeEap, WifiSecurityType.WifiSecTypeEapSuiteB, WifiSecurityType.WifiSecTypeOwe, WifiSecurityType.WifiSecTypeWapiCert, WifiSecurityType.WifiSecTypeWapiPsk]
        let wifiSecurityTypeArr2: Array<WifiSecurityType> = [WifiSecurityType.WifiSecTypeInvalid, WifiSecurityType.WifiSecTypeOpen, WifiSecurityType.WifiSecTypeWep, WifiSecurityType.WifiSecTypePsk, WifiSecurityType.WifiSecTypeSae, WifiSecurityType.WifiSecTypeEap, WifiSecurityType.WifiSecTypeEapSuiteB, WifiSecurityType.WifiSecTypeOwe, WifiSecurityType.WifiSecTypeWapiCert, WifiSecurityType.WifiSecTypeWapiPsk]
        let strArr: Array<String> = [
            "WifiSecurityType.WifiSecTypeInvalid",
            "WifiSecurityType.WifiSecTypeOpen",
            "WifiSecurityType.WifiSecTypeWep",
            "WifiSecurityType.WifiSecTypePsk",
            "WifiSecurityType.WifiSecTypeSae",
            "WifiSecurityType.WifiSecTypeEap",
            "WifiSecurityType.WifiSecTypeEapSuiteB",
            "WifiSecurityType.WifiSecTypeOwe",
            "WifiSecurityType.WifiSecTypeWapiCert",
            "WifiSecurityType.WifiSecTypeWapiPsk"
            ]
        for (i in 0..wifiSecurityTypeArr.size) {
            @Expect(wifiSecurityTypeArr[i] == wifiSecurityTypeArr2[i])
            @Expect(wifiSecurityTypeArr[i].toString() == strArr[i])
            if (i + 1 < wifiSecurityTypeArr.size) {
                @Expect(wifiSecurityTypeArr[i] != wifiSecurityTypeArr[i + 1])
            } else {
                @Expect(wifiSecurityTypeArr[i] != wifiSecurityTypeArr[0])
            }
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_GroupOwnerBand() {
        let groupOwnerBandArr: Array<GroupOwnerBand> = [GoBandAuto, GoBand2GHz, GoBand5GHz]
        let groupOwnerBandArr2: Array<GroupOwnerBand> = [GoBandAuto, GoBand2GHz, GoBand5GHz]
        let strArr: Array<String> = ["GroupOwnerBand.GoBandAuto", "GroupOwnerBand.GoBand2GHz", "GroupOwnerBand.GoBand5GHz"]
        for (i in 0..groupOwnerBandArr.size) {
            @Expect(groupOwnerBandArr[i] == groupOwnerBandArr2[i])
            @Expect(groupOwnerBandArr[i] != groupOwnerBandArr[(i + 1) % groupOwnerBandArr.size])
            @Expect(groupOwnerBandArr[i].toString() == strArr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_WifiCategory() {
        let arr1: Array<WifiCategory> = [Default, Wifi6, Wifi6Plus]
        let arr2: Array<WifiCategory> = [Default, Wifi6, Wifi6Plus]
        let strArr: Array<String> = ["WifiCategory.Default", "WifiCategory.Wifi6", "WifiCategory.Wifi6Plus"]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr2[i])
            @Expect(arr1[i] != arr2[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == strArr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func Test_DeviceAddressType() {
        let arr1: Array<DeviceAddressType> = [RandomDeviceAddress, RealDeviceAddress]
        let arr2: Array<DeviceAddressType> = [RandomDeviceAddress, RealDeviceAddress]
        let strArr: Array<String> = ["DeviceAddressType.RandomDeviceAddress", "DeviceAddressType.RealDeviceAddress"]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr2[i])
            @Expect(arr1[i] != arr2[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == strArr[i])
        }
    }
}

class WifiStateChangeCallback <: Callback1Argument<Int32> {
    public func invoke(err: ?BusinessException, arg: Int32): Unit {
        loggerInfo("wifi call back arg: ${arg}")
    }
}
