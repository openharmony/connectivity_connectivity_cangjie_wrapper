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

import ohos.business_exception.{BusinessException, getUniversalErrorMsg}
import ohos.ffi.SUCCESS_CODE
import ohos.hilog.HilogChannel

import std.collection.HashMap

protected let BLUETOOTH_LOG = HilogChannel(0, 0xD000101, "CJ-Bluetooth")

protected const SERVICE_STOPPED:Int32 = 2900001
protected const BLUETOOTH_DISABLED:Int32 = 2900003
protected const PROFILE_NOT_SUPPORTED:Int32 = 2900004
protected const DEVICE_NOT_CONNECTED:Int32 = 2900005
protected const THE_MAXIMUM_NUMBER_OF_CONNECTIONS_HAS_BEEN_REACHED:Int32 = 2900006
protected const THE_VALUE_OF_PROXY_IS_A_NULL_POINTER:Int32 = 2900008
protected const OUT_OF_HARDWARE_RESOURCES:Int32 = 2900009
protected const RESOURCES_HAVE_REACHED_THE_UPPER_LIMIT:Int32 = 2900010
protected const OPERATION_IS_BUSY:Int32 = 2900011
protected const USER_DOES_NOT_RESPOND:Int32 = 2900013
protected const USER_REFUSE_THE_ACTION:Int32 = 2900014
protected const OPERATION_FAILED:Int32 = 2900099
protected const IPC_FAILED:Int32 = 2900100
protected const READ_FORBIDDEN:Int32 = 2901000
protected const WRITE_FORBIDDEN:Int32 = 2901001
protected const CONNECTION_IS_NOT_ESTABLISHED:Int32 = 2901003
protected const CONNECTION_IS_CONGESTION:Int32 = 2901004
protected const CONNECTION_IS_NOT_ENCRYPTED:Int32 = 2901005
protected const CONNECTION_IS_NOT_AUTHENTICATED:Int32 = 2901006
protected const CONNECTION_IS_NOT_AUTHORIZED:Int32 = 2901007
protected const IO_ERROR:Int32 = 2901054
protected const BLE_SCAN_IS_ALREADY_STARTED:Int32 = 2902050
protected const ADVERTISING_DATA_EXCEEDS_THE_UPPER_LIMIT:Int32 = 2902054
protected const INVALID_ADVERTISING_ID:Int32 = 2902055

let ERROR_CODE_MAP = HashMap<Int32, String>(
    [
        (SERVICE_STOPPED, "Service stopped."),
        (BLUETOOTH_DISABLED, "Bluetooth disabled."),
        (PROFILE_NOT_SUPPORTED, "Profile not supported."),
        (DEVICE_NOT_CONNECTED, "Device not connected."),
        (THE_MAXIMUM_NUMBER_OF_CONNECTIONS_HAS_BEEN_REACHED, "The maximum number of connections has been reached."),
        (THE_VALUE_OF_PROXY_IS_A_NULL_POINTER, "The value of proxy is a null pointer."),
        (OUT_OF_HARDWARE_RESOURCES, "Fails to start scan as it is out of hardware resources."),
        (RESOURCES_HAVE_REACHED_THE_UPPER_LIMIT, "Resources have reached the upper limit."),
        (OPERATION_IS_BUSY, "The operation is busy. The last operation is not complete."),
        (USER_DOES_NOT_RESPOND, "The user does not respond."),
        (USER_REFUSE_THE_ACTION, "User refuse the action."),
        (OPERATION_FAILED, "Operation failed."),
        (IPC_FAILED, "IPC failed."),
        (READ_FORBIDDEN, "Read forbidden."),
        (WRITE_FORBIDDEN, "Write forbidden."),
        (CONNECTION_IS_NOT_ESTABLISHED, "The connection is not established."),
        (CONNECTION_IS_CONGESTION, "The connection is congested."),
        (CONNECTION_IS_NOT_ENCRYPTED, "The connection is not encrypted."),
        (CONNECTION_IS_NOT_AUTHENTICATED, "The connection is not authenticated."),
        (CONNECTION_IS_NOT_AUTHORIZED, "The connection is not authorized."),
        (IO_ERROR, "IO error."),
        (BLE_SCAN_IS_ALREADY_STARTED, "Failed to start scan as Ble scan is already started by the app."),
        (ADVERTISING_DATA_EXCEEDS_THE_UPPER_LIMIT, "The length of the advertising data exceeds the upper limit."),
        (INVALID_ADVERTISING_ID, "Invalid advertising id.")
    ]
)

protected func getErrorMsg(code: Int32): String {
    if (let Some(v) <- getUniversalErrorMsg(code)) {
        return v
    } else if (ERROR_CODE_MAP.contains(code)) {
        return ERROR_CODE_MAP[code]
    } else {
        return "Inner error code ${code}"
    }
}


protected func checkRet(errorCode: Int32): Unit {
    const INVALID_PARAMETER: Int32 = 401
    if (errorCode == INVALID_PARAMETER) {
        throw BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED))
    }
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, getErrorMsg(errorCode))
    }
}
