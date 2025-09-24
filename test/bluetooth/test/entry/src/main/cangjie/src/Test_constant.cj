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
import std.unittest.testmacro.*
import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*

@Test
class Test_constant {
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_ProfileConnectionState() {
        let arr1: Array<ProfileConnectionState> = [
            StateDisconnected,
            StateConnecting,
            StateConnected,
            StateDisconnecting
        ]
        let arrStr: Array<String> = [
            "ProfileConnectionState.StateDisconnected",
            "ProfileConnectionState.StateConnecting",
            "ProfileConnectionState.StateConnected",
            "ProfileConnectionState.StateDisconnecting"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }
}