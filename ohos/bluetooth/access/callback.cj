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

package ohos.bluetooth.access

import std.collection.{ArrayList, HashMap}
import ohos.bluetooth.{BLUETOOTH_LOG, OPERATION_FAILED, getErrorMsg}
import ohos.business_exception.BusinessException
import ohos.ffi.{Callback1Param, SUCCESS_CODE}
import ohos.callback_invoke.{CallbackObject, Callback1Argument}
import ohos.labels.APILevel
import std.deriving.Derive

const REGISTER_STATE_CHANGE_TYPE = 0i32
let BLUETOOTH_STATE_MAP = HashMap<Int32, BluetoothState>(
    [
        (0, StateOff),
        (1, StateTurningOn),
        (2, StateOn),
        (3, StateTurningOff),
        (4, StateBleTurningOff),
        (5, StateBleOn),
        (6, StateBleTurningOn)
    ]
)

/**
 * The enum of bluetooth state.
 */
@Derive[ToString, Equatable]
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public enum BluetoothState {
    /**
     * Indicates the local Bluetooth is off
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateOff
    |
    /**
     * Indicates the local Bluetooth is turning on
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateTurningOn
    |
    /**
     * Indicates the local Bluetooth is on, and ready for use
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateOn
    |
    /**
     * Indicates the local Bluetooth is turning off
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateTurningOff
    |
    /**
     * Indicates the local Bluetooth is turning LE mode on
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleTurningOn
    |
    /**
     * Indicates the local Bluetooth is in LE only mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleOn
    |
    /**
     * Indicates the local Bluetooth is turning off LE only mode
     */
    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    StateBleTurningOff
    | ...

    static func parse(state: Int32): BluetoothState {
        BLUETOOTH_STATE_MAP.get(state) ?? throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
    }
}

private var registerState = false
private let CALLBACK_LIST = ArrayList<CallbackObject>()

private func argWrapper1<CT, T>(ctor: (CT) -> T): Int64 where CT <: CType {
    let wrapper = {
        ctype: CT =>
        let cjType = ctor(ctype)
        for (caller in CALLBACK_LIST) {
            (caller as Callback1Argument<T>)?.invoke(None, cjType)
        }
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
}

/**
 * Subscribe the event reported when the Bluetooth state changes.
 *
 * @param { Callback1Argument<BluetoothState> } callback - Callback used to listen for the Bluetooth state event.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func onStateChange(callback: Callback1Argument<BluetoothState>): Unit {
    BLUETOOTH_LOG.debug("subscribe StateChange callback")
    if (!registerState) {
        var errorCode: Int32 = 0
        let id = argWrapper1({state: Int32 => BluetoothState.parse(state)})
        unsafe {
            FfiBluetoothAccOn(REGISTER_STATE_CHANGE_TYPE, id, inout errorCode)
        }
        if (errorCode != SUCCESS_CODE) {
            throw BusinessException(errorCode, getErrorMsg(errorCode))
        }
        registerState = true
    } else {
        for (idx in 0..CALLBACK_LIST.size) {
            if (refEq(callback, CALLBACK_LIST[idx])) {
                BLUETOOTH_LOG.info("The stateChange callback is registered, no need to re-registered")
                return
            }
        }
    }
    CALLBACK_LIST.add(callback)
    return
}

/**
 * Unsubscribe the event reported when the Bluetooth state changes.
 *
 * @param { ?Callback1Argument<BluetoothState> } [ callback ] - Callback used to listen for the Bluetooth state event.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "24",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func offStateChange(callback!: ?Callback1Argument<BluetoothState> = None): Unit {
    BLUETOOTH_LOG.debug("unsubscribe StateChange stateChange")
    if (let Some(v) <- callback) {
        for (idx in 0..CALLBACK_LIST.size) {
            if (refEq(v, CALLBACK_LIST[idx])) {
                CALLBACK_LIST.remove(at: idx)
            }
        }
    }
    CALLBACK_LIST.clear()
    return
}
