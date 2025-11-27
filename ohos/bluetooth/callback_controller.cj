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

package ohos.bluetooth

import ohos.callback_invoke.{ Callback1Argument, CallbackObject }

import std.collection.ArrayList
import std.sync.Mutex

protected class CallbackController {
    var list: ?ArrayList<CallbackObject> = None
    var listMut: Mutex = Mutex()

    protected func enableController(): Unit {
        list = ArrayList<CallbackObject>()
    }

    protected func isEnabled(): Bool {
        list.isSome()
    }

    protected func addCallback(callback: CallbackObject): Unit {
        synchronized(listMut) {
            list?.add(callback)
        }
    }

    protected func removeCallback(callback: CallbackObject): Int64 {
        let callbackList = list ?? ArrayList<CallbackObject>()
        synchronized(listMut) {
            for (idx in 0..callbackList.size) {
                if (refEq(callback, callbackList[idx])) {
                    callbackList.remove(at: idx)
                    return idx
                }
            }
        }
        return -1
    }

    protected func hasCallback(callback: CallbackObject): Bool {
        let callbackList = list ?? ArrayList<CallbackObject>()
        synchronized(listMut) {
            for (idx in 0..callbackList.size) {
                if (refEq(callback, callbackList[idx])) {
                    return true
                }
            }
        }
        return false
    }

    protected func removeAllCallback(): Unit {
        synchronized(listMut) {
            list?.clear()
        }
    }

    protected func invokeCallback<T>(cjType: T): Unit {
        if (let Some(callbackList) <- list) {
            synchronized(listMut) {
                for (caller in callbackList) {
                    (caller as Callback1Argument<T>)?.invoke(None, cjType)
                }
            }
        }
    }
}