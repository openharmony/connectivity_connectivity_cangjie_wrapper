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

import std.deriving.Derive
import ohos.labels.APILevel

/**
 * A byte buffer, equivalent to the ArkTS ArrayBuffer.
 */
public type ArrayBuffer = Array<Byte>

/**
 * Describes the spp parameters.
 */
@!APILevel[
    since: "26.2.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class SppOptions {
    /**
     * Indicates the UUID in the SDP record.
     */
    @!APILevel[
        since: "26.2.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var uuid: String

    /**
     * Indicates secure channel or not.
     */
    @!APILevel[
        since: "26.2.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var secure: Bool

    /**
     * Indicates the SPP link type.
     */
    @!APILevel[
        since: "26.2.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public var sppType: SppType

    /**
     * Creates SPP socket options.
     *
     * @param { String } uuid - Indicates the UUID in the SDP record.
     * @param { Bool } secure - Indicates secure channel or not.
     * @param { SppType } sppType - Indicates the SPP link type.
     */
    @!APILevel[
        since: "26.2.0",
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
    since: "26.2.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum SppType {
    /**
     * RFCOMM.
     */
    @!APILevel[
        since: "26.2.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    SppRfcomm
    |
    /**
     * L2CAP of the BR type.
     */
    @!APILevel[
        since: "26.2.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    SppL2cap
    |
    /**
     * L2CAP of the BLE type.
     */
    @!APILevel[
        since: "26.2.0",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    SppL2capBle
    | ...

    /**
     * Converts the SppType to the value of the native socket type.
     *
     * @returns { Int32 } Returns the native socket type value.
     */
    func getValue(): Int32 {
        match (this) {
            case SppRfcomm => 0
            case SppL2cap => 1
            case SppL2capBle => 2
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}

/**
 * The enum of the Bluetooth socket callback type.
 */
@Derive[ToString, Equatable]
enum BluetoothSocketCallbackType {
    /**
     * Type of the spp read event to listen for.
     */
    SppRead
    | ...

    /**
     * Converts the BluetoothSocketCallbackType to the name known by the native layer.
     *
     * @returns { String } Returns the native callback type name.
     */
    func getValue(): String {
        match (this) {
            case SppRead => "sppRead"
            case _ => throw IllegalArgumentException("The type is not supported.")
        }
    }
}
