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

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.bluetooth.socket

import ohos.business_exception.AsyncCallback
import ohos.labels.APILevel

import std.deriving.Derive

/**
 * A byte buffer, equivalent to the ArkTS ArrayBuffer.
 */
public type ArrayBuffer = Array<Byte>

/**
 * Describes the spp parameters.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class SppOptions {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var uuid: String

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var secure: Bool

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var sppType: SppType

    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public init(uuid: String, secure: Bool, sppType: SppType) {
        this.uuid = uuid
        this.secure = secure
        this.sppType = sppType
    }
}

/**
 * The enum of SPP type.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum SppType {
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    SppRfcomm
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    SppL2cap
    |
    @!APILevel[
        since: "26.1.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    SppL2capBle
    | ...
}

/**
 * Creates a Bluetooth server listening socket.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppListen(name: String, options: SppOptions, callback: AsyncCallback<Int32>): Unit {
    return ()
}

/**
 * Waits for a remote device to connect.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppAccept(serverSocket: Int32, callback: AsyncCallback<Int32>): Unit {
    return ()
}

/**
 * Connects to a remote device over the socket.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppConnect(deviceId: String, options: SppOptions, callback: AsyncCallback<Int32>): Unit {
    return ()
}

/**
 * Obtain the device id in the client socket.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func getDeviceId(clientSocket: Int32): String {
    return ""
}

/**
 * Disables an spp server socket and releases related resources.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppCloseServerSocket(socket: Int32): Unit {
    return ()
}

/**
 * Disables an spp client socket and releases related resources.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppCloseClientSocket(socket: Int32): Unit {
    return ()
}

/**
 * Write data through the socket.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppWrite(clientSocket: Int32, data: ArrayBuffer): Unit {
    return ()
}

/**
 * Asynchronous interface for reading data from the socket.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppReadAsync(clientSocket: Int32, callback: AsyncCallback<ArrayBuffer>): Unit {
    return ()
}
