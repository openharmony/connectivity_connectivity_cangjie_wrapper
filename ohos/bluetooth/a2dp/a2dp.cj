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

package ohos.bluetooth.a2dp

import ohos.bluetooth.*
import ohos.bluetooth.base_profile.*
import ohos.bluetooth.constant.*
import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.callback_invoke.{ CallbackObject, Callback1Argument }
import ohos.ffi.*
import ohos.labels.*

import std.collection.{ArrayList, HashMap}
import std.deriving.*

/**
 * create the instance of a2dp profile.
 *
 * @relation function createA2dpSrcProfile(): A2dpSourceProfile
 */
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func createA2dpSrcProfile(): A2dpSourceProfile {
    return A2dpSourceProfile()
}

/**
 * Manager a2dp source profile.
 *
 * @relation interface A2dpSourceProfile extends BaseProfile
 */
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class A2dpSourceProfile <: BaseProfile {
    private var registerState = false
    private let callbackList = ArrayList<CallbackObject>()

    protected init() {}

    private func argWrapper1<CT, T>(ctor: (CT) -> T): Int64 where CT <: CType {
        let wrapper = {
            ctype: CT =>
            let cjType = ctor(ctype)
            for (caller in callbackList) {
                (caller as Callback1Argument<T>)?.invoke(None, cjType)
            }
        }
        let registerCall = Callback1Param<CT, Unit>(wrapper)
        registerCall.getID()
    }

    /**
     * Obtains the playing state of device.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation getPlayingState(deviceId: string): PlayingState
     */
    @!APILevel[
        21,
        permission: "ohos.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getPlayingState(deviceId: String): PlayingState {
        var errorCode: Int32 = 0
        var state = StateNotPlaying
        unsafe {
            try (cDeviceId = LibC.mallocCString(deviceId).asResource()) {
                state = PlayingState.parse(FfiBluetoothA2dpGetPlayingState(cDeviceId.value, inout errorCode))
            }
        }
        if (errorCode != SUCCESS_CODE) {
            throw BusinessException(errorCode, getErrorMsg(errorCode))
        }
        return state
    }

    /**
     * Obtains the connected devices list of profile.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @relation getConnectedDevices(): Array<string>
     */
    @!APILevel[
        21,
        permission: "ohos.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getConnectedDevices(): Array<String> {
        var errorCode: Int32 = 0
        var devices = Array<String>()
        unsafe {
            let cDevices = FfiBluetoothA2dpGetConnectedDevices(inout errorCode)
            // MAC address translation does not throw exception.
            devices = cArr2cjArr<CString, String>(cDevices.size, cDevices.head) {str: CString => str.toString()}
            cDevices.free()
        }
        if (errorCode != SUCCESS_CODE) {
            throw BusinessException(errorCode, getErrorMsg(errorCode))
        }
        return devices
    }

    /**
     * Obtains the profile connection state.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @relation getConnectionState(deviceId: string): ProfileConnectionState
     */
    @!APILevel[
        21,
        permission: "ohos.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getConnectionState(deviceId: String): ProfileConnectionState {
        var errorCode: Int32 = 0
        var state = StateDisconnected
        unsafe {
            try (cDeviceId = LibC.mallocCString(deviceId).asResource()) {
                state = ProfileConnectionState.parse(
                    FfiBluetoothA2dpGetConnectionState(cDeviceId.value, inout errorCode))
            }
        }
        if (errorCode != SUCCESS_CODE) {
            throw BusinessException(errorCode, getErrorMsg(errorCode))
        }
        return state
    }

    /**
     * Subscribe the event reported when the profile connection state changes.
     *
     * @relation on(type: 'connectionStateChange', callback: Callback<StateChangeParam>): void
     */
    @!APILevel[
        21,
        permission: "ohos.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func onConnectionStateChange(callback: Callback1Argument<StateChangeParam>): Unit {
        BLUETOOTH_LOG.debug("subscribe connectionStateChange")
        if (!registerState) {
            var errorCode: Int32 = 0
            let id = argWrapper1({param: NativeStateChangeParam => param.toObject()})
            let eventTypeId: Int32 = 0
            unsafe {
                FfiBluetoothA2dpOn(eventTypeId, id, inout errorCode)
            }
            if (errorCode != SUCCESS_CODE) {
                throw BusinessException(errorCode, getErrorMsg(errorCode))
            }
            registerState = true
        } else {
            for (idx in 0..callbackList.size) {
                if (refEq(callback, callbackList[idx])) {
                    BLUETOOTH_LOG.info("The connectionStateChange callback is registered, no need to re-registered")
                    return
                }
            }
        }
        callbackList.add(callback)
        return
    }

    /**
     * Unsubscribe the event reported when the profile connection state changes.
     *
     * @relation off(type: 'connectionStateChange', callback?: Callback<StateChangeParam>): void
     */
    @!APILevel[
        21,
        permission: "ohos.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offConnectionStateChange(callback: Callback1Argument<StateChangeParam>): Unit {
        BLUETOOTH_LOG.debug("unsubscribe connectionStateChange callback event")
        for (idx in 0..callbackList.size) {
            if (refEq(callback, callbackList[idx])) {
                callbackList.remove(at: idx)
            }
        }
        return
    }

    /**
     * Unsubscribe the event reported when the profile connection state changes.
     *
     * @relation off(type: 'connectionStateChange', callback?: Callback<StateChangeParam>): void
     */
    @!APILevel[
        21,
        permission: "ohos.ACCESS_BLUETOOTH",
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func offConnectionStateChange(): Unit {
        BLUETOOTH_LOG.debug("unsubscribe connectionStateChange callback event")
        callbackList.clear()
        return
    }
}

/**
 * The enum of a2dp playing state.
 *
 * @relation enum PlayingState
 */
@Derive[ToString, Equatable]
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum PlayingState {
    /**
     * Not playing.
     *
     * @relation STATE_NOT_PLAYING
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateNotPlaying
    |
    /**
     * Playing.
     *
     * @relation STATE_PLAYING
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StatePlaying
    | ...

    static func parse(v: Int32): PlayingState {
        match (v) {
            case 0x0000 => StateNotPlaying
            case 0x0001 => StatePlaying
            case _ => throw NoneValueException("Value does not exist!")
        }
    }
}

/**
 * Describes the codec information.
 *
 * @relation interface CodecInfo
 */
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class CodecInfo {
    /**
     * codec type
     *
     * @relation codecType: CodecType
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecType: CodecType

    /**
     * codec bits per sample.
     *
     * @relation codecBitsPerSample: CodecBitsPerSample
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecBitsPerSample: CodecBitsPerSample

    /**
     * codec channel mode.
     *
     * @relation codecChannelMode: CodecChannelMode
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecChannelMode: CodecChannelMode

    /**
     * codec sample rate.
     *
     * @relation codecSampleRate: CodecSampleRate
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecSampleRate: CodecSampleRate

    init(
        codecType!: CodecType = CodecTypeSbc,
        codecBitsPerSample!: CodecBitsPerSample = CodecBitsPerSampleNone,
        codecChannelMode!: CodecChannelMode = CodecChannelModeNone,
        codecSampleRate!: CodecSampleRate = CodecSampleRateNone
    ) {
        this.codecType = codecType
        this.codecBitsPerSample = codecBitsPerSample
        this.codecChannelMode = codecChannelMode
        this.codecSampleRate = codecSampleRate
    }
}

/**
 * Describes the codec type.
 *
 * @relation enum CodecType
 */
@Derive[ToString, Equatable]
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecType {
    /**
     * invalid codec type.
     *
     * @relation CODEC_TYPE_INVALID = -1
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeInvalid
    |
    /**
     * SBC - Sub-band coding.
     *
     * @relation CODEC_TYPE_SBC = 0
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeSbc
    |
    /**
     * AAC -Advanced Audio Coding.
     *
     * @relation CODEC_TYPE_AAC = 1
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeAac
    |
    /**
     * L2HC.
     *
     * @relation CODEC_TYPE_L2HC = 2
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeL2hc
    | ...
}

/**
 * Describes the codec channel mode.
 *
 * @relation enum CodecChannelMode
 */
@Derive[ToString, Equatable]
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecChannelMode {
    /**
     * Codec channel mode none.
     *
     * @relation CODEC_CHANNEL_MODE_NONE = 0
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecChannelModeNone
    |
    /**
     * Codec channel mode MONO.
     *
     * @relation CODEC_CHANNEL_MODE_MONO = 1
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecChannelModeMono
    |
    /**
     * Codec channel mode STEREO.
     *
     * @relation CODEC_CHANNEL_MODE_STEREO = 2
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecChannelModeStereo
    | ...
}

/**
 * Describes the codec bits per sample.
 *
 * @relation enum CodecBitsPerSample
 */
@Derive[ToString, Equatable]
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecBitsPerSample {
    /**
     * Codec bits per sample none.
     *
     * @relation CODEC_BITS_PER_SAMPLE_NONE = 0
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSampleNone
    |
    /**
     * Codec 16 bits per sample.
     *
     * @relation CODEC_BITS_PER_SAMPLE_16 = 1
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSample16
    |
    /**
     * Codec 24 bits per sample.
     *
     * @relation CODEC_BITS_PER_SAMPLE_24 = 2
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSample24
    |
    /**
     * Codec 32 bits per sample.
     *
     * @relation CODEC_BITS_PER_SAMPLE_32 = 3
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSample32
    | ...
}

/**
 * Describes the codec sample rate.
 *
 * @relation enum CodecSampleRate
 */
@Derive[ToString, Equatable]
@!APILevel[
    21,
    stagemodelonly: true,
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecSampleRate {
    /**
     * Codec sample rate none.
     *
     * @relation CODEC_SAMPLE_RATE_NONE = 0
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRateNone
    |
    /**
     * Codec sample rate 44.1k.
     *
     * @relation CODEC_SAMPLE_RATE_44100 = 1
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate44100
    |
    /**
     * Codec sample rate 48k.
     *
     * @relation CODEC_SAMPLE_RATE_48000 = 2
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate48000
    |
    /**
     * Codec sample rate 88.2k.
     *
     * @relation CODEC_SAMPLE_RATE_88200 = 3
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate88200
    |
    /**
     * Codec sample rate 96k.
     *
     * @relation CODEC_SAMPLE_RATE_96000 = 4
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate96000
    |
    /**
     * Codec sample rate 176.4k.
     *
     * @relation CODEC_SAMPLE_RATE_176400 = 5
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate176400
    |
    /**
     * Codec sample rate 192k.
     *
     * @relation CODEC_SAMPLE_RATE_192000 = 6
     */
    @!APILevel[
        21,
        stagemodelonly: true,
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate192000
    | ...
}
