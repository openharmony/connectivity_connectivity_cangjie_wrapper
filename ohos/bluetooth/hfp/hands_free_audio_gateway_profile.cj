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

package ohos.bluetooth.hfp

import std.collection.ArrayList
import ohos.business_exception.{ BusinessException, ERR_PARAMETER_ERROR }
import ohos.callback_invoke.{ CallbackObject, Callback1Argument }
import ohos.bluetooth.{checkRet, BLUETOOTH_LOG, getErrorMsg}
import ohos.bluetooth.base_profile.{NativeStateChangeParam, StateChangeParam, BaseProfile, ProfileCallbackType}
import ohos.bluetooth.constant.ProfileConnectionState
import ohos.ffi.{cArr2cjArr, CArrString, Callback1Param}
import ohos.labels.APILevel

foreign {
    func FfiBluetoothHfpGetConnectedDevices(errCode: CPointer<Int32>): CArrString

    func FfiBluetoothHfpGetConnectionState(deviceId: CString, errCode: CPointer<Int32>): Int32

    func FfiBluetoothHfpOn(callbackType: Int32, id: Int64, errCode: CPointer<Int32>): Unit
}

/**
 * create the instance of hfp profile.
 *
 * @returns { HandsFreeAudioGatewayProfile } Returns the instance of profile.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public func createHfpAgProfile(): HandsFreeAudioGatewayProfile {
    return HandsFreeAudioGatewayProfile()
}

/**
 * Manager hfp source profile.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.Bluetooth.Core"
]
public class HandsFreeAudioGatewayProfile <: BaseProfile {
    private var registerState = false
    private let callbackList = ArrayList<CallbackObject>()

    protected init() {}

    private func argWrapper1<CT, T>(ctor: (CT) -> T): Int64 where CT <: CType {
        let wrapper = {
            ctype: CT =>
            let cjType = ctor(ctype)
            for (caller in callbackList) {
                (caller as Callback1Argument<T>)?.invoke(None, cjType)
            }
        }
        let registerCall = Callback1Param<CT, Unit>(wrapper)
        registerCall.getID()
    }

    /**
     * Obtains the connected devices list of profile.
     *
     * @returns { Array<String> } Returns the address of connected devices list.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getConnectedDevices(): Array<String> {
        var errorCode: Int32 = 0
        var devices = Array<String>()
        unsafe {
            let cDevices = FfiBluetoothHfpGetConnectedDevices(inout errorCode)
            devices = cArr2cjArr<CString, String>(cDevices.size, cDevices.head) {str: CString => str.toString()}
            cDevices.free()
        }
        checkRet(errorCode)
        return devices
    }

    /**
     * Obtains the profile connection state.
     *
     * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
     * @returns { ProfileConnectionState } Returns the connection state.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     * @throws { BusinessException } 2900001 - Service stopped.
     * @throws { BusinessException } 2900003 - Bluetooth disabled.
     * @throws { BusinessException } 2900004 - Profile not supported.
     * @throws { BusinessException } 2900099 - Operation failed.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func getConnectionState(deviceId: String): ProfileConnectionState {
        var errorCode: Int32 = 0
        var state = StateDisconnected
        unsafe {
            try (cDeviceId = LibC.mallocCString(deviceId).asResource()) {
                state = ProfileConnectionState.parse(FfiBluetoothHfpGetConnectionState(cDeviceId.value, inout errorCode))
            }
        }
        checkRet(errorCode)
        return state
    }

    /**
     * Subscribe the event reported when the profile connection state changes .
     *
     * @param { ProfileCallbackType } type - Type of the profile connection state changes event to listen for.
     * @param { Callback1Argument<StateChangeParam> } callback - Callback used to listen for event.
     * @throws { BusinessException } 201 - Permission denied.
     * @throws { BusinessException } 801 - Capability not supported.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func on(eventType: ProfileCallbackType, callback: Callback1Argument<StateChangeParam>): Unit {
        BLUETOOTH_LOG.debug("subscribe connectionStateChange")
        if (!registerState) {
            var errorCode: Int32 = 0
            let id = argWrapper1({param: NativeStateChangeParam => param.toObject()})
            unsafe {
                FfiBluetoothHfpOn(eventType.getValue(), id, inout errorCode)
            }
            checkRet(errorCode)
            registerState = true
        } else {
            for (idx in 0..callbackList.size) {
                if (refEq(callback, callbackList[idx])) {
                    BLUETOOTH_LOG.info("The connectionStateChange callback is registered, no need to re-registered")
                    return
                }
            }
        }
        callbackList.add(callback)
        return
    }

    /**
     * Unsubscribe the event reported when the profile connection state changes .
     *
     * @param { ProfileCallbackType } type - Type of the profile connection state changes event to listen for.
     * @param { CallbackObject } callback - Callback used to listen for event.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func off(eventType: ProfileCallbackType, callback: CallbackObject): Unit {
        BLUETOOTH_LOG.debug("unsubscribe ${eventType} connectionStateChange")
        for (idx in 0..callbackList.size) {
            if (refEq(callback, callbackList[idx])) {
                callbackList.remove(at: idx)
            }
        }
        return
    }

    /**
     * Unsubscribe the event reported when the profile connection state changes .
     *
     * @param { ProfileCallbackType } type - Type of the profile connection state changes event to listen for.
     */
    @!APILevel[
        since: "22",
        permission: "ohos.ACCESS_BLUETOOTH",
        syscap: "SystemCapability.Communication.Bluetooth.Core"
    ]
    public func off(eventType: ProfileCallbackType): Unit {
        if (eventType != ConnectionStateChange) {
            BLUETOOTH_LOG.error("Invalid name ${eventType}, valid name is CONNECTIONSTATECHANGE")
            throw BusinessException(ERR_PARAMETER_ERROR, getErrorMsg(ERR_PARAMETER_ERROR))
        }
        BLUETOOTH_LOG.debug("unsubscribe connectionStateChange")
        callbackList.clear()
        return
    }
}
