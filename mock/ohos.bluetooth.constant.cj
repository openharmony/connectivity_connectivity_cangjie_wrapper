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

package ohos.bluetooth.constant

import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public enum ProfileConnectionState {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    StateDisconnected
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    StateConnecting
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    StateConnected
    | @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    StateDisconnecting
    | ...
}

extend ProfileConnectionState <: ToString {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public func toString(): String {
        return String()
    }
}

extend ProfileConnectionState <: Equatable<ProfileConnectionState> {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func ==(other: ProfileConnectionState): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
    public operator func !=(other: ProfileConnectionState): Bool {
        return true
    }
}