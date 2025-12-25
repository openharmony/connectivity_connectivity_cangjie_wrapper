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

package ohos.bluetooth.connection

import std.collection.{ArrayList, HashMap}
import ohos.business_exception.BusinessException
import ohos.callback_invoke.{CallbackObject, Callback1Argument}
import ohos.bluetooth.{BLUETOOTH_LOG, OPERATION_FAILED, getErrorMsg}
import ohos.ffi.{CArrString, Callback1Param, SUCCESS_CODE}
import ohos.labels.APILevel
import std.deriving.Derive

@Derive[ToString, Hashable, Equatable]
enum BluetoothConnectionCallbackType {
    BlueToothDeviceFind
    | ...

    func getValue(): Int32 {
        match (this) {
            case BlueToothDeviceFind => 1i32
            case _ => throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
        }
    }
}

private let CALLBACK_MAP = HashMap<BluetoothConnectionCallbackType, ArrayList<CallbackObject>>()
private let REGISTER_MAP = HashMap<BluetoothConnectionCallbackType, Bool>(
    [
        (BlueToothDeviceFind, false)
    ]
)

private func register(callbackType: BluetoothConnectionCallbackType, id: Int64) {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConOn(callbackType.getValue(), id, inout errorCode)
    }
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, getErrorMsg(errorCode))
    }
}

private func argWrapper1<CT, T>(callbackType: BluetoothConnectionCallbackType, ctor: (CT) -> T): Int64 where CT <: CType {
    let wrapper = {
        ctype: CT =>
        let cjType = ctor(ctype)
        let callbackList = CALLBACK_MAP.get(callbackType) ?? ArrayList<CallbackObject>()
        for (caller in callbackList) {
            (caller as Callback1Argument<T>)?.invoke(None, cjType)
        }
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
}

private func findCallbackObject(callbackType: BluetoothConnectionCallbackType, callback: CallbackObject,
    remove!: Bool = false): Int64 {
    let callbackList = CALLBACK_MAP.get(callbackType) ?? return -1
    for (idx in 0..callbackList.size) {
        if (refEq(callback, callbackList[idx])) {
            if (remove) {
                callbackList.remove(at: idx)
            }
            return idx
        }
    }
    return -1
}

private func commonSubscribe1Arg<CT, T>(callbackType: BluetoothConnectionCallbackType, callback: CallbackObject,
    ctor: (CT) -> T) where CT <: CType {
    BLUETOOTH_LOG.debug("subscribe ${callbackType}")
    if (!REGISTER_MAP[callbackType]) {
        register(callbackType, argWrapper1<CT, T>(callbackType, ctor))
        REGISTER_MAP[callbackType] = true
    } else {
        if (findCallbackObject(callbackType, callback) >= 0) {
            BLUETOOTH_LOG.info("The ${callbackType} callback is registered, no need to re-registered")
            return
        }
    }
    CALLBACK_MAP.addIfAbsent(callbackType, ArrayList<CallbackObject>())
    CALLBACK_MAP[callbackType].add(callback)
}

protected unsafe func cArrString2ArrString(cArr: CArrString): Array<String> {
    let ptr = cArr.head
    if (ptr.isNull()) {
        return Array<String>()
    }
    let size = cArr.size
    let ret = Array<String>(
        size,
        {
            i =>
            let cString = ptr.read(i)
            let str = cString.toString()
            str
        }
    )
    return ret
}

/**
 * Subscribe the event reported when a remote Bluetooth device is discovered.
 *
 * @param { Callback1Argument<Array<String>> } callback - Callback used to listen for the discovering event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func onBluetoothDeviceFind(callback: Callback1Argument<Array<String>>): Unit {
    unsafe {
        commonSubscribe1Arg(BlueToothDeviceFind, callback) {
            devices: CArrString => cArrString2ArrString(devices)
        }
    }
    return
}

/**
 * Unsubscribe the event reported when a remote Bluetooth device is discovered.
 *
 * @param { ?Callback1Argument<Array<String>> } [ callback ] - Callback used to listen for the discovering event.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func offBluetoothDeviceFind(callback!: ?Callback1Argument<Array<String>> = None): Unit {
    BLUETOOTH_LOG.debug("unsubscribe BlueToothDeviceFind")
    if (!CALLBACK_MAP.contains(BlueToothDeviceFind)) {
        return
    }
    if (let Some(v) <- callback) {
        findCallbackObject(BlueToothDeviceFind, v, remove: true)
        return
    }
    CALLBACK_MAP[BlueToothDeviceFind].clear()
    return
}
