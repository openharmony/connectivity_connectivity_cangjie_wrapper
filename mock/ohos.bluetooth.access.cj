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

package ohos.bluetooth.access

import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.labels.APILevel

@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func enableBluetooth(): Unit {
    return ()
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func getState(): BluetoothState {
    return StateOff
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum BluetoothState {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateOff
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateTurningOn
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateOn
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateTurningOff
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleTurningOn
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleOn
    |
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleTurningOff
    | ...
}

extend BluetoothState <: ToString {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func toString(): String {
        return String()
    }
}

extend BluetoothState <: Equatable<BluetoothState> {
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func ==(other: BluetoothState): Bool {
        return true
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public operator func !=(other: BluetoothState): Bool {
        return true
    }
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func onStateChange(callback: Callback1Argument<BluetoothState>): Unit {
    return ()
}

@!APILevel[
    since: "24",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func offStateChange(callback!: ?Callback1Argument<BluetoothState> = None): Unit {
    return ()
}
