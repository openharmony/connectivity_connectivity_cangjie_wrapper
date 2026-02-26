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

package ohos.bluetooth.connection

import ohos.callback_invoke.{Callback1Argument, CallbackObject}
import ohos.labels.APILevel

@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func getRemoteDeviceName(deviceId: String): String {
    return String()
}

@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func startBluetoothDiscovery(): Unit {
    return ()
}

@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func stopBluetoothDiscovery(): Unit {
    return ()
}

@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func onBluetoothDeviceFind(callback: Callback1Argument<Array<String>>): Unit {
    return ()
}

@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func offBluetoothDeviceFind(callback!: ?Callback1Argument<Array<String>> = None): Unit {
    return ()
}