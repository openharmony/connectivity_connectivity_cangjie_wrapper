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

package ohos.bluetooth.hfp

import ohos.bluetooth.base_profile.{BaseProfile, StateChangeParam, ProfileCallbackType}
import ohos.bluetooth.constant.ProfileConnectionState
import ohos.callback_invoke.{CallbackObject, Callback1Argument}
import ohos.labels.APILevel

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public func createHfpAgProfile(): HandsFreeAudioGatewayProfile {
    return HandsFreeAudioGatewayProfile()
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.Bluetooth.Core"]
public class HandsFreeAudioGatewayProfile <: BaseProfile {
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