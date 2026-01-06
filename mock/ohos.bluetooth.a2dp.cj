/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

package ohos.bluetooth.a2dp

import ohos.bluetooth.base_profile.{BaseProfile, StateChangeParam, ProfileCallbackType}
import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.bluetooth.constant.ProfileConnectionState
import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public func createA2dpSrcProfile(): A2dpSourceProfile {
    return A2dpSourceProfile()
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class A2dpSourceProfile <: BaseProfile {
    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func getPlayingState(deviceId: String): PlayingState {
        return PlayingState.StateNotPlaying
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func getConnectedDevices(): Array<String> {
        return Array()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core", throwexception: true]
    public func getConnectionState(deviceId: String): ProfileConnectionState {
        return ProfileConnectionState.StateDisconnected
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func on(eventType: ProfileCallbackType, callback: Callback1Argument<StateChangeParam>): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func off(eventType: ProfileCallbackType, callback: CallbackObject): Unit {
        return ()
    }

    @!APILevel[since: "22", permission: "ohos.permission.ACCESS_BLUETOOTH", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func off(eventType: ProfileCallbackType): Unit {
        return ()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum PlayingState {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    StateNotPlaying
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    StatePlaying
    | ...
}

extend PlayingState <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend PlayingState <: Equatable<PlayingState> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: PlayingState): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: PlayingState): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class CodecInfo {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var codecType: CodecType

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var codecBitsPerSample: CodecBitsPerSample

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var codecChannelMode: CodecChannelMode

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public var codecSampleRate: CodecSampleRate
    
    public init() {
        super()
        this.codecType = CodecType.CodecTypeInvalid
        this.codecBitsPerSample = CodecBitsPerSample.CodecBitsPerSampleNone
        this.codecChannelMode = CodecChannelMode.CodecChannelModeNone
        this.codecSampleRate = CodecSampleRate.CodecSampleRateNone
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum CodecType {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecTypeInvalid
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecTypeSbc
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecTypeAac
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecTypeL2hc
    | ...
}

extend CodecType <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend CodecType <: Equatable<CodecType> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: CodecType): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: CodecType): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum CodecChannelMode {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecChannelModeNone
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecChannelModeMono
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecChannelModeStereo
    | ...
}

extend CodecChannelMode <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend CodecChannelMode <: Equatable<CodecChannelMode> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: CodecChannelMode): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: CodecChannelMode): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum CodecBitsPerSample {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecBitsPerSampleNone
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecBitsPerSample16
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecBitsPerSample24
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecBitsPerSample32
    | ...
}

extend CodecBitsPerSample <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend CodecBitsPerSample <: Equatable<CodecBitsPerSample> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: CodecBitsPerSample): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: CodecBitsPerSample): Bool {
        return true
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum CodecSampleRate {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecSampleRateNone
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecSampleRate44100
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecSampleRate48000
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecSampleRate88200
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecSampleRate96000
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecSampleRate176400
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    CodecSampleRate192000
    | ...
}

extend CodecSampleRate <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend CodecSampleRate <: Equatable<CodecSampleRate> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: CodecSampleRate): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: CodecSampleRate): Bool {
        return true
    }
}