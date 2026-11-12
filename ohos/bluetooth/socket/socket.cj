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

import ohos.bluetooth.{ checkRet, getErrorMsg, OPERATION_FAILED }
import ohos.business_exception.{ AsyncCallback, BusinessException }
import ohos.ffi.{ CArrUI8, SUCCESS_CODE }
import ohos.labels.APILevel

foreign {
    func FfiBluetoothSocketSppListen(name: CString, options: CSppOption, errCode: CPointer<Int32>): Int32

    func FfiBluetoothSocketSppAccept(serverSocket: Int32, errCode: CPointer<Int32>): Int32

    func FfiBluetoothSocketSppConnect(deviceId: CString, options: CSppOption, errCode: CPointer<Int32>): Int32

    func FfiBluetoothSocketGetDeviceId(clientSocket: Int32, errCode: CPointer<Int32>): CString

    func FfiBluetoothSocketSppCloseServerSocket(socket: Int32, errCode: CPointer<Int32>): Unit

    func FfiBluetoothSocketSppCloseClientSocket(socket: Int32, errCode: CPointer<Int32>): Unit

    func FfiBluetoothSocketSppWrite(clientSocket: Int32, data: CArrUI8, errCode: CPointer<Int32>): Unit

    func FfiBluetoothSocketSppRead(clientSocket: Int32, size: CPointer<Int64>, errCode: CPointer<Int32>): CPointer<UInt8>

    func FfiBluetoothSocketSppFreeReadData(data: CPointer<UInt8>): Unit
}

/**
 * The native spp options, whose layout must be the same as the native CSppOption.
 */
@C
struct CSppOption {
    let uuid: CString
    let secure: Bool
    let sppType: Int32

    /**
     * Creates the native spp options from the Cangjie values.
     *
     * @param { String } uuid - Indicates the UUID in the SDP record.
     * @param { Bool } secure - Indicates secure channel or not.
     * @param { SppType } sppType - Indicates the SPP link type.
     */
    init(uuid: String, secure: Bool, sppType: SppType) {
        this.uuid = unsafe { LibC.mallocCString(uuid) }
        this.secure = secure
        this.sppType = sppType.getValue()
    }

    func free(): Unit {
        unsafe { LibC.free(uuid) }
    }
}

/**
 * Creates a Bluetooth server listening socket.
 *
 * @param { String } name - Indicates the service name.
 * @param { SppOptions } options - Indicates the listen parameters.
 * @param { AsyncCallback<Int32> } callback - Callback used to return a server socket ID.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900004 - Profile not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppListen(name: String, options: SppOptions, callback: AsyncCallback<Int32>): Unit {
    let uuid = options.uuid
    let secure = options.secure
    let sppType = options.sppType
    spawn {
        listenAndCallback(name, uuid, secure, sppType, callback)
    }
    return
}

func listenAndCallback(name: String, uuid: String, secure: Bool, sppType: SppType,
                       callback: AsyncCallback<Int32>): Unit {
    let result = try {
        listenRaw(name, uuid, secure, sppType)
    } catch (e: Exception) {
        callback(BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED)), None<Int32>)
        return
    }
    let (fd, errorCode) = result
    if (errorCode != SUCCESS_CODE) {
        callback(BusinessException(errorCode, getErrorMsg(errorCode)), None<Int32>)
    } else {
        callback(None<BusinessException>, fd)
    }
}

func listenRaw(name: String, uuid: String, secure: Bool, sppType: SppType): (Int32, Int32) {
    let cName = unsafe { LibC.mallocCString(name) }
    var errorCode: Int32 = 0
    try {
        let cOptions = CSppOption(uuid, secure, sppType)
        let fd = unsafe { FfiBluetoothSocketSppListen(cName, cOptions, inout errorCode) }
        cOptions.free()
        return (fd, errorCode)
    } finally {
        unsafe { LibC.free(cName) }
    }
}

/**
 * Waits for a remote device to connect.
 *
 * @param { Int32 } serverSocket - Indicates the server socket ID, returned by **sppListen**.
 * @param { AsyncCallback<Int32> } callback - Callback used to return a client socket ID.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900004 - Profile not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppAccept(serverSocket: Int32, callback: AsyncCallback<Int32>): Unit {
    spawn {
        var errorCode: Int32 = 0
        let fd = unsafe { FfiBluetoothSocketSppAccept(serverSocket, inout errorCode) }
        if (errorCode != SUCCESS_CODE) {
            callback(BusinessException(errorCode, getErrorMsg(errorCode)), None<Int32>)
        } else {
            callback(None<BusinessException>, fd)
        }
    }
    return
}

/**
 * Connects to a remote device over the socket.
 *
 * @param { String } deviceId - Indicates device ID. For example, "11:22:33:AA:BB:FF".
 * @param { SppOptions } options - Indicates the connect parameters **SppOptions**.
 * @param { AsyncCallback<Int32> } callback - Callback used to return a client socket ID.
 * @throws { BusinessException } 201 - Permission denied.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900003 - Bluetooth disabled.
 * @throws { BusinessException } 2900004 - Profile not supported.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    permission: "ohos.permission.ACCESS_BLUETOOTH",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppConnect(deviceId: String, options: SppOptions, callback: AsyncCallback<Int32>): Unit {
    let uuid = options.uuid
    let secure = options.secure
    let sppType = options.sppType
    spawn {
        connectAndCallback(deviceId, uuid, secure, sppType, callback)
    }
    return
}

func connectAndCallback(deviceId: String, uuid: String, secure: Bool, sppType: SppType,
                        callback: AsyncCallback<Int32>): Unit {
    let result = try {
        connectRaw(deviceId, uuid, secure, sppType)
    } catch (e: Exception) {
        callback(BusinessException(OPERATION_FAILED, getErrorMsg(OPERATION_FAILED)), None<Int32>)
        return
    }
    let (fd, errorCode) = result
    if (errorCode != SUCCESS_CODE) {
        callback(BusinessException(errorCode, getErrorMsg(errorCode)), None<Int32>)
    } else {
        callback(None<BusinessException>, fd)
    }
}

func connectRaw(deviceId: String, uuid: String, secure: Bool, sppType: SppType): (Int32, Int32) {
    let cDeviceId = unsafe { LibC.mallocCString(deviceId) }
    try {
        return connectWithOptions(cDeviceId, uuid, secure, sppType)
    } finally {
        unsafe { LibC.free(cDeviceId) }
    }
}

func connectWithOptions(cDeviceId: CString, uuid: String, secure: Bool, sppType: SppType): (Int32, Int32) {
    var errorCode: Int32 = 0
    let cOptions = CSppOption(uuid, secure, sppType)
    let fd = unsafe { FfiBluetoothSocketSppConnect(cDeviceId, cOptions, inout errorCode) }
    cOptions.free()
    return (fd, errorCode)
}

/**
 * Obtain the device id in the client socket.
 *
 * @param { Int32 } clientSocket - Indicates client socket.
 * @returns { String } Returns the connected device id.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func getDeviceId(clientSocket: Int32): String {
    var errorCode: Int32 = 0
    let cDeviceId = unsafe { FfiBluetoothSocketGetDeviceId(clientSocket, inout errorCode) }
    try {
        if (errorCode == 401) {
            throw BusinessException(401, "Parameter error.")
        }
        checkRet(errorCode)
        return cDeviceId.toString()
    } finally {
        unsafe { LibC.free(cDeviceId) }
    }
}

/**
 * Disables an spp server socket and releases related resources.
 *
 * @param { Int32 } socket - Indicates the server socket ID, returned by **sppListen**.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppCloseServerSocket(socket: Int32): Unit {
    var errorCode: Int32 = 0
    unsafe { FfiBluetoothSocketSppCloseServerSocket(socket, inout errorCode) }
    checkRet(errorCode)
}

/**
 * Disables an spp client socket and releases related resources.
 *
 * @param { Int32 } socket - Indicates the client socket ID, returned by **sppAccept** or **sppConnect**.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2900001 - Service stopped.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppCloseClientSocket(socket: Int32): Unit {
    var errorCode: Int32 = 0
    unsafe { FfiBluetoothSocketSppCloseClientSocket(socket, inout errorCode) }
    checkRet(errorCode)
}

/**
 * Write data through the socket.
 *
 * @param { Int32 } clientSocket - Indicates the client socket ID, returned by **sppAccept** or **sppConnect**.
 * @param { ArrayBuffer } data - Indicates the data to write.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2901054 - IO error.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppWrite(clientSocket: Int32, data: ArrayBuffer): Unit {
    var errorCode: Int32 = 0
    unsafe {
        let raw = acquireArrayRawData(data)
        FfiBluetoothSocketSppWrite(clientSocket, CArrUI8(raw.pointer, data.size), inout errorCode)
        releaseArrayRawData(raw)
    }
    checkRet(errorCode)
}

/**
 * Asynchronous interface for reading data from the socket.
 *
 * Only one read can be pending for a client socket; a second call while a read is pending
 * fails with **401**. A read that fails on the native side fails with **2901054**.
 *
 * @param { Int32 } clientSocket - Indicates the client socket ID, returned by **sppAccept** or **sppConnect**.
 * @param { AsyncCallback<ArrayBuffer> } callback - Callback used to return the spp read data.
 * @throws { BusinessException } 401 - Parameter error. Parameter verification failed.
 * @throws { BusinessException } 801 - Capability not supported.
 * @throws { BusinessException } 2901054 - IO error.
 * @throws { BusinessException } 2900099 - Operation failed.
 */
@!APILevel[
    since: "26.1.0",
    syscap: "SystemCapability.Communication.Bluetooth.Core",
    throwexception: true
]
public func sppReadAsync(clientSocket: Int32, callback: AsyncCallback<ArrayBuffer>): Unit {
    spawn {
        var size: Int64 = 0
        var errorCode: Int32 = 0
        let data = unsafe { FfiBluetoothSocketSppRead(clientSocket, inout size, inout errorCode) }
        if (errorCode != SUCCESS_CODE) {
            callback(BusinessException(errorCode, getErrorMsg(errorCode)), None<ArrayBuffer>)
            return
        }
        let bytes = Array<Byte>(size, { i => unsafe { data.read(i) } })
        unsafe {
            FfiBluetoothSocketSppFreeReadData(data)
        }
        callback(None<BusinessException>, bytes)
    }
    return
}
