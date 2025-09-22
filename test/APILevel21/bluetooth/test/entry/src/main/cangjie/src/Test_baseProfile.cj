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

internal import BasicServicesKit.*
internal import ohos.base.*
internal import std.collection.*
import ConnectivityKit.*
import AbilityKit.*
import std.unittest.testmacro.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.callback_invoke.*
import ohos.business_exception.*

@Test
class Test_baseProfile {
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
    func test_auto_enum_DisconnectCause() {
        let arr1: Array<DisconnectCause> = [
            UserDisconnect,
            ConnectFromKeyboard,
            ConnectFromMouse,
            ConnectFromCar,
            TooManyConnectedDevices,
            ConnectFailInternal
        ]
        let arrStr: Array<String> = [
            "DisconnectCause.UserDisconnect",
            "DisconnectCause.ConnectFromKeyboard",
            "DisconnectCause.ConnectFromMouse",
            "DisconnectCause.ConnectFromCar",
            "DisconnectCause.TooManyConnectedDevices",
            "DisconnectCause.ConnectFailInternal"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_BaseProfile_getConnectedDevices() {
        try {
            let a2dpSrc = createA2dpSrcProfile()
            let retArray = a2dpSrc.getConnectedDevices()
            @Expect(retArray.size >= 0)
        } catch (e: BusinessException) {
            loggerInfo("test_BaseProfile_getConnectedDevices error ${e}")
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_BaseProfile_getConnectionState() {
        try {
            let a2dpSrc = createA2dpSrcProfile()
            let retState = a2dpSrc.getConnectionState("0A:1B:2C:3D:4D:5F")
            loggerInfo("test_BaseProfile_getConnectedDevices retState ${retState}")
        } catch (e: BusinessException) {
            // param invalid
            @Expect(e.code == 2900099 || e.code == 201)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_BaseProfile_getConnectionState_error_param() {
        try {
            let a2dpSrc = createA2dpSrcProfile()
            // 参数格式无效，报错 401, 应为0-9，A-F，a-f
            let retState = a2dpSrc.getConnectionState("XX:XX:XX:XX:XX:XX")
        } catch (e: BusinessException) {
            // errorcode: 401, message: Parameter error. Parameter verification failed.
            @Expect(e.code, 401)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_BaseProfile_on_CONNECTION_STATE_CHANGE() {
        try {
            let a2dpSrc = createA2dpSrcProfile()
            let callBackType = ProfileCallbackType.ConnectionStateChange
            let callBack = BaseProfileConnectionStateChangeCallback()
            a2dpSrc.on(callBackType, callBack)
            a2dpSrc.off(callBackType)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_BaseProfile_off() {
        try {
            let a2dpSrc = createA2dpSrcProfile()
            let callBackType = ProfileCallbackType.ConnectionStateChange
            let callBack = BaseProfileConnectionStateChangeCallback()
            a2dpSrc.on(callBackType, callBack)
            a2dpSrc.off(callBackType, callBack)
        } catch (e: BusinessException) {
            @Expect(false)
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_BaseProfile_getPlayingState_param_error() {
        try {
            let a2dpSrc = createA2dpSrcProfile()
            // 参数格式无效，报错 401, 应为0-9，A-F，a-f
            let retState = a2dpSrc.getPlayingState("XX:XX:XX:XX:XX:XX")
        } catch (e: BusinessException) {
            @Expect(true)
        }
    }
}

class BaseProfileConnectionStateChangeCallback <: Callback1Argument<StateChangeParam> {
    public func invoke(err: ?BusinessException, arg: StateChangeParam): Unit {
        let connectionState = arg.state.toString()
        loggerInfo("BaseProfileConnectionStateChangeCallback")
    }
}
