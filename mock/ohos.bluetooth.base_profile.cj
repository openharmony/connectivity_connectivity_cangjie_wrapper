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

package ohos.bluetooth.base_profile

import ohos.bluetooth.constant.ProfileConnectionState
import ohos.callback_invoke.{CallbackObject, Callback1Argument}
import ohos.labels.APILevel

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum DisconnectCause {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    UserDisconnect
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectShouldFromKeyboard
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectShouldFromMouse
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectShouldFromCar
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    TooManyConnectedDevices
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectInternalFail
    | ...
}

extend DisconnectCause <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend DisconnectCause <: Equatable<DisconnectCause> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func ==(other: DisconnectCause): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func !=(other: DisconnectCause): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class StateChangeParam {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var deviceId: String

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var state: ProfileConnectionState

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var cause: DisconnectCause
    
    public init() {
        super()
        this.deviceId = String()
        this.state = ProfileConnectionState.StateDisconnected
        this.cause = DisconnectCause.UserDisconnect
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public interface BaseProfile {
    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    func getConnectedDevices(): Array<String>

    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core",
        throwexception: true
    ]
    func getConnectionState(deviceId: String): ProfileConnectionState

    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func on(eventType: ProfileCallbackType, callback: Callback1Argument<StateChangeParam>): Unit

    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func off(eventType: ProfileCallbackType, callback: CallbackObject): Unit

    @!APILevel[
        since: "22",
        permission: "ohos.permission.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    func off(eventType: ProfileCallbackType): Unit
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum ProfileCallbackType {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    ConnectionStateChange | ...
}

extend ProfileCallbackType <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        return String()
    }
}
