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

import std.collection.HashMap
import ohos.business_exception.BusinessException
import ohos.callback_invoke.{CallbackObject, Callback1Argument, CallbackList}
import ohos.bluetooth.{BLUETOOTH_LOG, OPERATION_FAILED, getErrorMsg, checkRet}
import ohos.ffi.{CArrString, Callback1Param}
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

private let GLOBAL_CALLBACK_MAP = HashMap<BluetoothConnectionCallbackType, CallbackList>(
    [(BlueToothDeviceFind, CallbackList())])

private func register(callbackType: BluetoothConnectionCallbackType, id: Int64) {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConOn(callbackType.getValue(), id, inout errorCode)
    }
    checkRet(errorCode)
}

private func commonSubscribe1Arg<CT, T>(callbackType: BluetoothConnectionCallbackType, callback: CallbackObject,
    ctor: (CT) -> T) where CT <: CType {
    BLUETOOTH_LOG.debug("subscribe ${callbackType}")
    let callbackList = GLOBAL_CALLBACK_MAP[callbackType]
    callbackList.addCallback(
        callback,
        onInitialize: { =>
            register(callbackType, argWrapper1<CT, T>(callbackList, ctor))
        },
        onFailed: { =>
            BLUETOOTH_LOG.warn("The ${callbackType} callback is registered, no need to re-registered.")
        }
    )
}

private func argWrapper1<CT, T>(callbackList: CallbackList, ctor: (CT) -> T): Int64 where CT <: CType {
    let wrapper = {
        ctype: CT =>
        let cjType = ctor(ctype)
        callbackList.invokeCallback(cjType)
    }
    let registerCall = Callback1Param<CT, Unit>(wrapper)
    registerCall.getID()
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
    BLUETOOTH_LOG.debug("subscribe BluetoothDeviceFind callback")
    commonSubscribe1Arg<CArrString, Array<String>>(BlueToothDeviceFind, callback) {
        devices: CArrString => unsafe { cArrString2ArrString(devices) }
    }
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
    BLUETOOTH_LOG.debug("unsubscribe BluetoothDeviceFind")
    let callbackList = GLOBAL_CALLBACK_MAP[BlueToothDeviceFind]
    if (let Some(v) <- callback) {
        callbackList.removeCallback(
            v,
            onFailed: {
                => BLUETOOTH_LOG.warn("The BlueToothDeviceFind callback has not been registered.")
            }
        )
        return
    }
    callbackList.removeAllCallback()
    return
}
