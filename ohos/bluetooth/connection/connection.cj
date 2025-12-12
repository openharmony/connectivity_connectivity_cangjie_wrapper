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

import ohos.business_exception.BusinessException
import ohos.bluetooth.getErrorMsg
import ohos.ffi.SUCCESS_CODE
import ohos.labels.APILevel

/**
 * Obtains the name of a peer Bluetooth device.
 *
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @returns { String } Returns the device name in character string format.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func getRemoteDeviceName(deviceId: String): String {
    var errorCode: Int32 = 0
    var str = ""
    unsafe {
        try (id = LibC.mallocCString(deviceId).asResource()) {
            let cValue = FfiBluetoothConGetRemoteDeviceName(id.value, inout errorCode)
            if (errorCode != SUCCESS_CODE) {
                LibC.free(cValue)
                throw BusinessException(errorCode, getErrorMsg(errorCode))
            }
            // may be invalid UTF8 and may be parsed abnormally
            try {
                str = cValue.toString()
            } finally {
                LibC.free(cValue)
            }
        }
    }
    return str
}

/**
 * Starts scanning Bluetooth devices.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func startBluetoothDiscovery(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConStartBluetoothDiscovery(inout errorCode)
    }
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, getErrorMsg(errorCode))
    }
}

/**
 * Stops Bluetooth device scanning.
 *
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "24",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func stopBluetoothDiscovery(): Unit {
    var errorCode: Int32 = 0
    unsafe {
        FfiBluetoothConStopBluetoothDiscovery(inout errorCode)
    }
    if (errorCode != SUCCESS_CODE) {
        throw BusinessException(errorCode, getErrorMsg(errorCode))
    }
}