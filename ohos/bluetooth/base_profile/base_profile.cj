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

package ohos.bluetooth.base_profile

import ohos.callback_invoke.{ Callback1Argument, CallbackObject }
import ohos.bluetooth.constant.ProfileConnectionState
import ohos.labels.APILevel

import std.deriving.Derive

/**
 * Enum for cause of disconnect.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum DisconnectCause {
    /**
     * User disconnect device.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    UserDisconnect
    | 
    /**
     * The connection needs to be initiated from the keyboard side.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectFromKeyboard
    | 
    /**
     * The connection needs to be initiated from the mouse side.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectFromMouse
    | 
    /**
     * The connection needs to be initiated from the car side.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectFromCar
    | 
    /**
     * Too many devices are currently connected.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    TooManyConnectedDevices
    | 
    /**
     * Connection failed due to an internal error.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectFailInternal
    | ...

    static func parse(cause: Int32) {
        match (cause) {
            case 0 => UserDisconnect
            case 1 => ConnectFromKeyboard
            case 2 => ConnectFromMouse
            case 3 => ConnectFromCar
            case 4 => TooManyConnectedDevices
            case 5 => ConnectFailInternal
            case _ => throw NoneValueException("Value does not exist!")
        }
    }
}

@C
protected struct NativeStateChangeParam {
    NativeStateChangeParam(
        let deviceId: CString,
        let state: Int32,
        let cause: Int32
    ) {}

    protected func toObject(): StateChangeParam {
        return StateChangeParam(
            deviceId.toString(),
            ProfileConnectionState.parse(state),
            DisconnectCause.parse(cause)
        )
    }
}

/**
 * Profile state change parameters.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class StateChangeParam {
    /**
     * The address of device.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String
    /**
     * Profile state value.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var state: ProfileConnectionState
    /**
     * Cause of disconnect.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var cause: DisconnectCause

    init(
        deviceId: String,
        state: ProfileConnectionState,
        cause: DisconnectCause
    ) {
        this.deviceId = deviceId
        this.state = state
        this.cause = cause
    }
}

/**
 * Base interface of profile.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public interface BaseProfile {
    /**
     * Get connection strategy of this profile.
     *
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
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func getConnectedDevices(): Array<String>

    /**
     * Obtains the profile connection state.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func getConnectionState(deviceId: String): ProfileConnectionState

    /**
     * Subscribe the event reported when the profile connection state changes.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func on(eventType: ProfileCallbackType, callback: Callback1Argument<StateChangeParam>): Unit

    /**
     * Unsubscribe the event reported when the profile connection state changes.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func off(eventType: ProfileCallbackType, callback: CallbackObject): Unit

    /**
     * Unsubscribe the event reported when the profile connection state changes.
     *
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { IllegalArgumentException } - Invalid parameter, Parameter verification failed.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func off(eventType: ProfileCallbackType): Unit
}

/**
 * Type of the profile connection state changes event to listen for.
 */
@Derive[ToString, Hashable, Equatable]
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ProfileCallbackType {
    /**
     * Connection State Change.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectionStateChange | ...

    protected func getValue(): Int32 {
        match (this) {
            case ConnectionStateChange => 0
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}
