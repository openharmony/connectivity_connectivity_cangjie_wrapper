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
class Test_a2dp {
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_PlayingState() {
        let arr1: Array<PlayingState> = [
            StateNotPlaying,
            StatePlaying
        ]
        let arrStr: Array<String> = [
            "PlayingState.StateNotPlaying",
            "PlayingState.StatePlaying"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_CodecType() {
        let arr1: Array<CodecType> = [
            CodecTypeInvalid,
            CodecTypeSbc,
            CodecTypeAac,
            CodecTypeL2hc
        ]
        let arrStr: Array<String> = [
            "CodecType.CodecTypeInvalid",
            "CodecType.CodecTypeSbc",
            "CodecType.CodecTypeAac",
            "CodecType.CodecTypeL2hc"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_CodecChannelMode() {
        let arr1: Array<CodecChannelMode> = [
            CodecChannelModeNone,
            CodecChannelModeMono,
            CodecChannelModeStereo
        ]
        let arrStr: Array<String> = [
            "CodecChannelMode.CodecChannelModeNone",
            "CodecChannelMode.CodecChannelModeMono",
            "CodecChannelMode.CodecChannelModeStereo"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_CodecBitsPerSample() {
        let arr1: Array<CodecBitsPerSample> = [
            CodecBitsPerSampleNone,
            CodecBitsPerSample16,
            CodecBitsPerSample24,
            CodecBitsPerSample32
        ]
        let arrStr: Array<String> = [
            "CodecBitsPerSample.CodecBitsPerSampleNone",
            "CodecBitsPerSample.CodecBitsPerSample16",
            "CodecBitsPerSample.CodecBitsPerSample24",
            "CodecBitsPerSample.CodecBitsPerSample32"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_auto_enum_CodecSampleRate() {
        let arr1: Array<CodecSampleRate> = [
            CodecSampleRateNone,
            CodecSampleRate44100,
            CodecSampleRate48000,
            CodecSampleRate88200,
            CodecSampleRate96000,
            CodecSampleRate176400,
            CodecSampleRate192000
        ]
        let arrStr: Array<String> = [
            "CodecSampleRate.CodecSampleRateNone",
            "CodecSampleRate.CodecSampleRate44100",
            "CodecSampleRate.CodecSampleRate48000",
            "CodecSampleRate.CodecSampleRate88200",
            "CodecSampleRate.CodecSampleRate96000",
            "CodecSampleRate.CodecSampleRate176400",
            "CodecSampleRate.CodecSampleRate192000"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }
}