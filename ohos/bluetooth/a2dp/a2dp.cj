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

package ohos.bluetooth.a2dp

import ohos.bluetooth.CallbackController
import ohos.bluetooth.{getErrorMsg, BLUETOOTH_LOG, OPERATION_FAILED}
import ohos.bluetooth.base_profile.{NativeStateChangeParam, StateChangeParam, BaseProfile, ProfileCallbackType}
import ohos.bluetooth.constant.ProfileConnectionState
import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.callback_invoke.{ CallbackObject, Callback1Argument }
import ohos.ffi.{Callback1Param, SUCCESS_CODE, cArr2cjArr}
import ohos.labels.{APILevel, Hide}

import std.deriving.Derive

/**
 * create the instance of a2dp profile.
 *
 * @returns { A2dpSourceProfile } Returns the instance of profile.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func createA2dpSrcProfile(): A2dpSourceProfile {
    return A2dpSourceProfile()
}

/**
 * Manager a2dp source profile.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class A2dpSourceProfile <: BaseProfile {
    private let controller = CallbackController()

    protected init() {}

    private func argWrapper1<CT, T>(ctor: (CT) -> T): Int64 where CT <: CType {
        let wrapper = {
            ctype: CT =>
            let cjType = ctor(ctype)
            controller.invokeCallback(cjType)
        }
        let registerCall = Callback1Param<CT, Unit>(wrapper)
        registerCall.getID()
    }

    /**
     * Obtains the playing state of device.
     *
     * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @returns { PlayingState } Returns the playing state.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
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
     * @returns { Array<String> } Returns the address of connected devices list.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
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
     * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @returns { ProfileConnectionState } Returns the profile connection state.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
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
     * @param { ProfileCallbackType } eventType - The type of event to subscribe.
     * @param { Callback1Argument<StateChangeParam> } callback - The callback function to be called when the event occurs.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: ProfileCallbackType, callback: Callback1Argument<StateChangeParam>): Unit {
        BLUETOOTH_LOG.debug("subscribe connectionStateChange")
        if (!controller.isEnabled()) {
            var errorCode: Int32 = 0
            let id = argWrapper1({param: NativeStateChangeParam => param.toObject()})
            unsafe {
                FfiBluetoothA2dpOn(eventType.getValue(), id, inout errorCode)
            }
            if (errorCode != SUCCESS_CODE) {
                throw BusinessException(errorCode, getErrorMsg(errorCode))
            }
            controller.enableController()
        } else {
            if (controller.hasCallback(callback)) {
                BLUETOOTH_LOG.info("The connectionStateChange callback is registered, no need to re-registered")
                return
            }
        }
        controller.addCallback(callback)
        return
    }

    /**
     * Unsubscribe the event reported when the profile connection state changes.
     *
     * @param { ProfileCallbackType } eventType - The type of event to unsubscribe.
     * @param { CallbackObject } callback - The callback function to be removed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func off(eventType: ProfileCallbackType, callback: CallbackObject): Unit {
        if (eventType != ConnectionStateChange) {
            throw BusinessException(401, "Parameter error.")
        }
        BLUETOOTH_LOG.debug("unsubscribe ${eventType} connectionStateChange")
        if (!controller.isEnabled()) {
            return
        }
        controller.removeCallback(callback)
        return
    }

    /**
     * Unsubscribe the event reported when the profile connection state changes.
     *
     * @param { ProfileCallbackType } eventType - The type of event to unsubscribe.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func off(eventType: ProfileCallbackType): Unit {
        if (eventType != ConnectionStateChange) {
            throw BusinessException(401, "Parameter error.")
        }
        BLUETOOTH_LOG.debug("unsubscribe connectionStateChange")
        controller.removeAllCallback()
        return
    }
}

/**
 * The enum of a2dp playing state.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum PlayingState {
    /**
     * Not playing.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateNotPlaying
    |
    /**
     * Playing.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StatePlaying
    | ...

    /**
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    static func parse(v: Int32): PlayingState {
        match (v) {
            case 0x0000 => StateNotPlaying
            case 0x0001 => StatePlaying
            case _ => throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
        }
    }
}

/**
 * Describes the codec information.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class CodecInfo {
    /**
     * codec type
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecType: CodecType

    /**
     * codec bits per sample.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecBitsPerSample: CodecBitsPerSample

    /**
     * codec channel mode.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecChannelMode: CodecChannelMode

    /**
     * codec sample rate.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var codecSampleRate: CodecSampleRate

    @!Hide[isChecked: true]
    internal var codecBitRate: CodecBitRate = CodecBitRate.CodecBitRateAbr

    @!Hide[isChecked: true]
    internal var codecFrameLength: CodecFrameLength = CodecFrameLength.CodecFrameLength10ms

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
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecType {
    /**
     * invalid codec type.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeInvalid
    |
    /**
     * SBC - Sub-band coding.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeSbc
    |
    /**
     * AAC -Advanced Audio Coding.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeAac
    |
    /**
     * L2HC.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecTypeL2hc
    |
    @!Hide[isChecked: true]
    CodecTypeL2hcst
    |
    @!Hide[isChecked: true]
    CodecTypeLdac
    | ...
}

/**
 * Describes the codec channel mode.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecChannelMode {
    /**
     * Codec channel mode none.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecChannelModeNone
    |
    /**
     * Codec channel mode MONO.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecChannelModeMono
    |
    /**
     * Codec channel mode STEREO.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecChannelModeStereo
    | ...
}

/**
 * Describes the codec bits per sample.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecBitsPerSample {
    /**
     * Codec bits per sample none.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSampleNone
    |
    /**
     * Codec 16 bits per sample.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSample16
    |
    /**
     * Codec 24 bits per sample.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSample24
    |
    /**
     * Codec 32 bits per sample.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecBitsPerSample32
    | ...
}

/**
 * Describes the codec sample rate.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum CodecSampleRate {
    /**
     * Codec sample rate none.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRateNone
    |
    /**
     * Codec sample rate 44.1kHz.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate44100
    |
    /**
     * Codec sample rate 48kHz.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate48000
    |
    /**
     * Codec sample rate 88.2kHz.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate88200
    |
    /**
     * Codec sample rate 96kHz.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate96000
    |
    /**
     * Codec sample rate 176.4kHz.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate176400
    |
    /**
     * Codec sample rate 192kHz.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    CodecSampleRate192000
    | ...
}

@!Hide[isChecked: true]
enum CodecBitRate {
    @!Hide[isChecked: true]
    CodecBitRate96000
    |

    @!Hide[isChecked: true]
    CodecBitRate128000
    |
    
    @!Hide[isChecked: true]
    CodecBitRate192000
    |
    
    @!Hide[isChecked: true]
    CodecBitRate256000
    |
    
    @!Hide[isChecked: true]
    CodecBitRate320000
    |
    
    @!Hide[isChecked: true]
    CodecBitRate480000
    |
    
    @!Hide[isChecked: true]
    CodecBitRate640000
    |
    
    @!Hide[isChecked: true]
    CodecBitRate960000
    |
    
    @!Hide[isChecked: true]
    CodecBitRateAbr
    |
    
    @!Hide[isChecked: true]
    CodecBitRate1500000
    |
    
    @!Hide[isChecked: true]
    CodecBitRate2300000
    | ...
}

@!Hide[isChecked: true]
enum CodecFrameLength {
    @!Hide[isChecked: true]
    CodecFrameLength5ms
    |
    
    @!Hide[isChecked: true]
    CodecFrameLength10ms
    | ...
}