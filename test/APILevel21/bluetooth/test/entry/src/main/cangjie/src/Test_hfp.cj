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

internal import kit.BasicServicesKit.*
internal import ohos.base.*
internal import std.collection.*
import kit.ConnectivityKit.*
import kit.AbilityKit.*
import std.unittest.testmacro.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.callback_invoke.*
import ohos.business_exception.*

@Test
class Test_hfp {
    protected func beforeAll() {
        ["ohos.permission.ACCESS_BLUETOOTH"] |>
            forEach<Permissions> {
            permissionName: Permissions =>
            getRequiredPermissions([permissionName])
            try {
                sleepFor(1.second)
                click(at: Screen.getTheOnlyUiComponentWhoseTextEqualsTo("允许").centerPoint)
            } catch (e: Exception) {}
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hfp_getConnectedDevices() {
        try {
            let hdfProfile = createHfpAgProfile()
            let retArray = hdfProfile.getConnectedDevices()
            @Expect(retArray.size >= 0)
        } catch (e: Exception) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hfp_getConnectionState_param_invalid() {
        try {
            let hdfProfile = createHfpAgProfile()
            let ret = hdfProfile.getConnectionState("11:22:33:AA:BB:FF")
        } catch (e: BusinessException) {
            loggerInfo("getConnectionState error ${e}")
            // 参数是无效的设备id, 报错 errorcode: 2900099, message: Operation failed
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hfp_getConnectionState_param_format_invalid() {
        try {
            let hdfProfile = createHfpAgProfile()
            // 有效的参数格式： 0-9，A-F, a-f
            let ret = hdfProfile.getConnectionState("XX:XX:XX:AA:BB:FF")
        } catch (e: IllegalArgumentException) {
            loggerInfo("getConnectionState error ${e}")
            // 参数格式无效，报错 Invalid parameter.
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hfp_on_off() {
        let changeCallBack = StateChangeCallbackHfp()
        let hdfProfile = createHfpAgProfile()
        try {
            hdfProfile.on(ProfileCallbackType.ConnectionStateChange, changeCallBack)
            sleepFor(Duration.second)
            hdfProfile.off(ProfileCallbackType.ConnectionStateChange)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_hfp_on_off_with_callback() {
        let changeCallBack = StateChangeCallbackHfp()
        let hdfProfile = createHfpAgProfile()
        try {
            hdfProfile.on(ProfileCallbackType.ConnectionStateChange, changeCallBack)
            sleepFor(Duration.second)
            hdfProfile.off(ProfileCallbackType.ConnectionStateChange, changeCallBack)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }
}

class StateChangeCallbackHfp <: Callback1Argument<StateChangeParam> {
    public func invoke(err: ?BusinessException, arg: StateChangeParam): Unit {
        let connectionState = arg.state.toString()
        loggerInfo("HFP profile connection state has change to ${connectionState}")
    }
}