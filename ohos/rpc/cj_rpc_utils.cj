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

package ohos.rpc

import std.collection.HashMap
import ohos.business_exception.BusinessException

enum ErrorCode {
    CheckParamError
    | OsMmapError
    | OsIoctlError
    | WriteToAshmemError
    | ReadFromAshmemError
    | OnlyProxyObjectPermittedError
    | OnlyRemoteObjectPermittedError
    | CommunicationError
    | ProxyOrRemoteObjectInvalidError
    | WriteDataToMessageSequenceError
    | ReadDataFromMessageSequenceError
    | ParcelMemoryAllocError
    | OsDupError

    prop value: Int32 {
        get() {
            match (this) {
                case CheckParamError => 401
                case OsMmapError => 1900001
                case OsIoctlError => 1900002
                case WriteToAshmemError => 1900003
                case ReadFromAshmemError => 1900004
                case OnlyProxyObjectPermittedError => 1900005
                case OnlyRemoteObjectPermittedError => 1900006
                case CommunicationError => 1900007
                case ProxyOrRemoteObjectInvalidError => 1900008
                case WriteDataToMessageSequenceError => 1900009
                case ReadDataFromMessageSequenceError => 1900010
                case ParcelMemoryAllocError => 1900011
                case OsDupError => 1900013
            }
        }
    }
}

enum TypeCode {
    Int8Array
    | Uint8Array
    | Int16Array
    | Uint16Array
    | Int32Array
    | Uint32Array
    | Float32Array
    | Float64Array
    | BigInt64Array
    | BigUint64Array
    | ...

    prop value: Int32 {
        get() {
            match (this) {
                case Int8Array => 0
                case Uint8Array => 1
                case Int16Array => 2
                case Uint16Array => 3
                case Int32Array => 4
                case Uint32Array => 5
                case Float32Array => 6
                case Float64Array => 7
                case BigInt64Array => 8
                case BigUint64Array => 9
                case _ => throw BusinessException(1900009, "The type is not supported.")
            }
        }
    }
}

let ERR_CODE_MAP = HashMap<Int32, String>(
    [
        (ErrorCode.CheckParamError.value, "Parameter error."),
        (ErrorCode.OsMmapError.value, "Call mmap function failed."),
        (ErrorCode.OsIoctlError.value, "Call os ioctl function failed."),
        (ErrorCode.WriteToAshmemError.value, "Write to ashmem failed."),
        (ErrorCode.ReadFromAshmemError.value, "Read from ashmem failed."),
        (ErrorCode.OnlyProxyObjectPermittedError.value, "Only proxy object permitted."),
        (ErrorCode.OnlyRemoteObjectPermittedError.value, "Only remote object permitted."),
        (ErrorCode.CommunicationError.value, "Communication failed."),
        (ErrorCode.ProxyOrRemoteObjectInvalidError.value, "Proxy or remote object is invalid."),
        (ErrorCode.WriteDataToMessageSequenceError.value, "Write data to message sequence failed."),
        (ErrorCode.ReadDataFromMessageSequenceError.value, "Read data from message sequence failed."),
        (ErrorCode.ParcelMemoryAllocError.value, "Sequence memory alloc failed."),
        (ErrorCode.OsDupError.value, "Call os dup function failed.")
    ]
)

func checkAndThrow(errCode: Int32): Unit {
    if (errCode != 0) {
        let msg = ERR_CODE_MAP[errCode]
        throw BusinessException(errCode, msg)
    }
}
