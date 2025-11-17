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

import ohos.ffi.{RemoteDataLite, releaseFFIData}
import ohos.business_exception.BusinessException
import std.collection.ArrayList
import ohos.labels.APILevel

const BYTE_SIZE_16: UIntNative = 2
const BYTE_SIZE_32: UIntNative = 4
const BYTE_SIZE_64: UIntNative = 8

/**
 * A data object used for remote procedure call (RPC).
 * During RPC, the sender can use the write methods provided by MessageSequence to
 * write the to-be-sent data into a MessageSequence object in a specific format, and the receiver can use the
 * read methods provided by MessageSequence to read data of the specific format from
 * the MessageSequence object.
 *
 * The default capacity of a MessageSequence instance is 200KB. If you want more or less,
 * use setCapacity(int) to change it.
 * 
 * Note: Only data of the following data types can be written into or read from a MessageSequence:
 * Int8, Int8Array, Int16, Int16Array, Int32, Int32Array, Int64, Int64Array, Float32, Float32Array, Float64,
 * Float64Array, Bool, BoolArray, UInt8, UInt8Array, String, StringArray,
 * Parcelable, and ParcelableArray.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.IPC.Core"
]
public class MessageSequence <: RemoteDataLite {
    init(id: Int64) {
        super(id)
    }

    ~init() {
        releaseFFIData(myDataId)
    }

    /**
     * Creates an empty MessageSequence object.
     * @returns { MessageSequence } Return the object created.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public static func create(): MessageSequence {
        let id: Int64 = unsafe { FfiRpcMessageSequenceImplCreate() }
        if (id < 0) {
            throw BusinessException(1900011, "[MessageSequence] create: Failed to create the instance!")
        }
        return MessageSequence(id)
    }

    /**
     * Reclaim the MessageSequence object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func reclaim(): Unit {
        releaseFFIData(myDataId)
    }

    /**
     * Writes an interface token into the MessageSequence object.
     * @param { String } token - Interface descriptor to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeInterfaceToken(token: String): Unit {
        try (ctoken = unsafe { LibC.mallocCString(token).asResource() }) {
            var errCode: Int32 = 0
            unsafe { FfiRpcMessageSequenceImplWriteInterfaceToken(getID(), ctoken.value, inout errCode) }
            checkAndThrow(errCode)
        }
    }

    /**
     * Reads an interface token from the MessageSequence object.
     * @returns { String } Return a String value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readInterfaceToken(): String {
        var errCode: Int32 = 0
        let returnStr: CString = unsafe { FfiRpcMessageSequenceImplReadInterfaceToken(getID(), inout errCode) }
        try {
            checkAndThrow(errCode)
            return returnStr.toString()
        } finally {
            unsafe { LibC.free(returnStr) }
        }
    }

    /**
     * Obtains the size of data (in bytes) contained in the MessageSequence object.
     * @returns { UInt32 } Return the size of data contained in the MessageSequence object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func getSize(): UInt32 {
        var errCode: Int32 = 0
        let returnNum: UInt32 = unsafe { FfiRpcMessageSequenceImplGetSize(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Obtains the storage capacity (in bytes) of the MessageSequence object.
     * @returns { UInt32 } Return the storage capacity of the MessageSequence object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func getCapacity(): UInt32 {
        var errCode: Int32 = 0
        let returnNum: UInt32 = unsafe { FfiRpcMessageSequenceImplGetCapacity(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Sets the size of data (in bytes) contained in the MessageSequence object.
     * False is returned if the data size set in this method is greater
     * than the storage capacity of the MessageSequence.
     * @param { UInt32 } size - Indicates the data size of the MessageSequence object.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func setSize(size: UInt32): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplSetSize(getID(), size, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Sets the storage capacity (in bytes) of the MessageSequence object.
     * False is returned if the capacity set in this method is less than
     * the size of data contained in the MessageSequence.
     * @param { UInt32 } size - Indicates the storage capacity of the MessageSequence object.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     * @throws { BusinessException } 1900011 - Memory allocation failed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func setCapacity(size: UInt32): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplSetCapacity(getID(), size, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Obtains the writable data space (in bytes) in the MessageSequence object.
     * Writable data space = Storage capacity of the MessageSequence – Size of data contained in
     * the MessageSequence.
     * @returns { UInt32 } Return the writable data space of the MessageSequence object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func getWritableBytes(): UInt32 {
        var errCode: Int32 = 0
        let returnNum: UInt32 = unsafe { FfiRpcMessageSequenceImplGetWritableBytes(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Obtains the readable data space (in bytes) in the MessageSequence object.
     * Readable data space = Size of data contained in the MessageSequence – Size of data that has been read.
     * @returns { UInt32 } Return the readable data space of the MessageSequence object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func getReadableBytes(): UInt32 {
        var errCode: Int32 = 0
        let returnNum: UInt32 = unsafe { FfiRpcMessageSequenceImplGetReadableBytes(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Obtains the current read position in the MessageSequence object.
     * @returns { UInt32 } Return the current read position in the MessageSequence object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func getReadPosition(): UInt32 {
        var errCode: Int32 = 0
        let returnNum: UInt32 = unsafe { FfiRpcMessageSequenceImplGetReadPosition(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Obtains the current write position in the MessageSequence object.
     * @returns { UInt32 } Return the current write position in the MessageSequence object.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func getWritePosition(): UInt32 {
        var errCode: Int32 = 0
        let returnNum: UInt32 = unsafe { FfiRpcMessageSequenceImplGetWritePosition(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Changes the current write position in the MessageSequence object.
     * Generally, you are advised not to change the current write position. If you must
     * change it, change it to an accurate position. Otherwise, the data to be read may be incorrect.
     * @param { UInt32 } pos - Indicates the target position to start data writing.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func rewindWrite(pos: UInt32): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplRewindWrite(getID(), pos, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Changes the current read position in the MessageSequence object.
     * Generally, you are advised not to change the current read position. If you must
     * change it, change it to an accurate position. Otherwise, the read data may be incorrect.
     * @param { UInt32 } pos - Indicates the target position to start data reading.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func rewindRead(pos: UInt32): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplRewindRead(getID(), pos, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes information to this MessageSequence object indicating that no exception occurred.
     * After handling requests, you should call this method before writing any data to reply
     * MessageSequence.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeNoException(): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteNoException(getID(), inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Reads the exception information from this MessageSequence object.
     * If exception was thrown in server side, it will be thrown here.
     * This method should be called before reading any data from reply MessageSequence
     * if writeNoException was invoked in server side.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readException(): Unit {
        var errCode: Int32 = 0
        let errMsg: CString = unsafe { FfiRpcMessageSequenceImplReadException(getID(), inout errCode) }
        if (errCode != 0) {
            try {
                let msg = errMsg.toString()
                throw BusinessException(errCode, msg)
            } finally {
                unsafe { LibC.free(errMsg) }
            }
        }
    }

    /**
     * Writes a Int8 value into the MessageSequence object.
     * @param { Int8 } val - Indicates the Int8 value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeByte(val: Int8): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteByte(getID(), val, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a Int16 value into the MessageSequence object.
     * @param { Int16 } val - Indicates the Int16 value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeShort(val: Int16): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteShort(getID(), val, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes an Int32 value into the MessageSequence object.
     * @param { Int32 } val - Indicates the Int32 value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeInt(val: Int32): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteInt(getID(), val, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a Int64 value into the MessageSequence object.
     * @param { Int64 } val - Indicates the Int64 value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeLong(val: Int64): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteLong(getID(), val, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a Float32 value into the MessageSequence object.
     * @param { Float32 } val - Indicates the Float32 value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeFloat(val: Float32): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteFloat(getID(), val, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a Float64 value into the MessageSequence object.
     * @param { Float64 } val - Indicates the Float64 value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeDouble(val: Float64): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteDouble(getID(), val, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a Bool value into the MessageSequence object.
     * @param { Bool } val - Indicates the Bool value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeBoolean(val: Bool): Unit {
        let value: Int8 = if (val) {
            1
        } else {
            0
        }
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteBoolean(getID(), value, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a UInt8 value into the MessageSequence object.
     * @param { UInt8 } val - Indicates the UInt8 value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeChar(val: UInt8): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteChar(getID(), val, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a String value into the MessageSequence object.
     * @param { String } val - Indicates the String value to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeString(val: String): Unit {
        let value: CString = unsafe { LibC.mallocCString(val) }
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteString(getID(), value, inout errCode) }
        unsafe { LibC.free(value) }
        checkAndThrow(errCode)
    }

    /**
     * Writes a Int8 array into the MessageSequence object.
     * @param { Array<Int8> } byteArray - Indicates the Int8 array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeByteArray(byteArray: Array<Int8>): Unit {
        let value: ByteArray = ByteArray(byteArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteByteArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a Int16 array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<Int16> } shortArray - Indicates the Int16 array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeShortArray(shortArray: Array<Int16>): Unit {
        let value: ShortArray = ShortArray(shortArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteShortArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a Int32 array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<Int32> } intArray - Indicates the Int32 array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeIntArray(intArray: Array<Int32>): Unit {
        let value: CIntArray = CIntArray(intArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteIntArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a Int64 array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<Int64> } longArray - Indicates the Int64 array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeLongArray(longArray: Array<Int64>): Unit {
        let value: LongArray = LongArray(longArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteLongArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a Float32 array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<Float32> } floatArray - Indicates the Float32 array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeFloatArray(floatArray: Array<Float32>): Unit {
        let value: FloatArray = FloatArray(floatArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteFloatArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a Float64 array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<Float64> } doubleArray - Indicates the Float64 array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeDoubleArray(doubleArray: Array<Float64>): Unit {
        let value: DoubleArray = DoubleArray(doubleArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteDoubleArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a Bool array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<Bool> } booleanArray - Indicates the Bool array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeBooleanArray(booleanArray: Array<Bool>): Unit {
        let byteArr = Array<Int8>(
            booleanArray.size,
            {
                i => if (booleanArray[i]) {
                    1
                } else {
                    0
                }
            }
        )
        let value: ByteArray = ByteArray(byteArr)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteBooleanArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a UInt8 array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<UInt8> } charArray - Indicates the UInt8 array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeCharArray(charArray: Array<UInt8>): Unit {
        let value: CharArray = CharArray(charArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteCharArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Writes a String array into the MessageSequence object.
     * Ensure that the data type and size comply with the interface definition.
     * Otherwise,data may be truncated.
     * @param { Array<String> } stringArray - Indicates the String array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeStringArray(stringArray: Array<String>): Unit {
        let value: CStringArray = CStringArray(stringArray)
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteStringArray(getID(), value, inout errCode) }
        value.free()
        checkAndThrow(errCode)
    }

    /**
     * Reads a Int8 value from the MessageSequence object.
     * @returns { Int8 } Return a Int8 value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readByte(): Int8 {
        var errCode: Int32 = 0
        let returnNum: Int8 = unsafe { FfiRpcMessageSequenceImplReadByte(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Reads a Int16 value from the MessageSequence object.
     * @returns { Int16 } Return a Int16 value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readShort(): Int16 {
        var errCode: Int32 = 0
        let returnNum: Int16 = unsafe { FfiRpcMessageSequenceImplReadShort(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Reads an Int32 value from the MessageSequence object.
     * @returns { Int32 } Return an Int32 value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readInt(): Int32 {
        var errCode: Int32 = 0
        let returnNum: Int32 = unsafe { FfiRpcMessageSequenceImplReadInt(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Reads a Int64 value from the MessageSequence object.
     * @returns { Int64 } Return a Int64 value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readLong(): Int64 {
        var errCode: Int32 = 0
        let returnNum: Int64 = unsafe { FfiRpcMessageSequenceImplReadLong(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Reads a Float32 value from the MessageSequence object.
     * @returns { Float32 } Return a Float32 value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readFloat(): Float32 {
        var errCode: Int32 = 0
        let returnNum: Float32 = unsafe { FfiRpcMessageSequenceImplReadFloat(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Reads a Float64 value from the MessageSequence object.
     * @returns { Float64 } Return a Float64 value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readDouble(): Float64 {
        var errCode: Int32 = 0
        let returnNum: Float64 = unsafe { FfiRpcMessageSequenceImplReadDouble(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Reads a Bool value from the MessageSequence object.
     * @returns { Bool } Return a Bool value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readBoolean(): Bool {
        var errCode: Int32 = 0
        let returnNum: Int8 = unsafe { FfiRpcMessageSequenceImplReadBoolean(getID(), inout errCode) }
        checkAndThrow(errCode)
        return if (returnNum == 1) {
            true
        } else {
            false
        }
    }

    /**
     * Reads a UInt8 value from the MessageSequence object.
     * @returns { UInt8 } Return a UInt8 value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readChar(): UInt8 {
        var errCode: Int32 = 0
        let returnNum: UInt8 = unsafe { FfiRpcMessageSequenceImplReadChar(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnNum
    }

    /**
     * Reads a String value from the MessageSequence object.
     * @returns { String } Return a String value.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readString(): String {
        var errCode: Int32 = 0
        let returnStr: CString = unsafe { FfiRpcMessageSequenceImplReadString(getID(), inout errCode) }
        try {
            checkAndThrow(errCode)
            return returnStr.toString()
        } finally {
            unsafe { LibC.free(returnStr) }
        }
    }

    /**
     * Reads a Int8 array from the MessageSequence object.
     * @returns { Array<Int8> } Return a Int8 array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readByteArray(): Array<Int8> {
        var errCode: Int32 = 0
        let returnArr: ByteArray = unsafe { FfiRpcMessageSequenceImplReadByteArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<Int8> = returnArr.toArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads a Int16 array from the MessageSequence object.
     * @returns { Array<Int16> } Return a Int16 array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readShortArray(): Array<Int16> {
        var errCode: Int32 = 0
        let returnArr: ShortArray = unsafe { FfiRpcMessageSequenceImplReadShortArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<Int16> = returnArr.toArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads an Int32 array from the MessageSequence object.
     * @returns { Array<Int32> } Return an Int32 array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readIntArray(): Array<Int32> {
        var errCode: Int32 = 0
        let returnArr: CIntArray = unsafe { FfiRpcMessageSequenceImplReadIntArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<Int32> = returnArr.toArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads a Int64 array from the MessageSequence object.
     * @returns { Array<Int64> } Return a Int64 array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readLongArray(): Array<Int64> {
        var errCode: Int32 = 0
        let returnArr: LongArray = unsafe { FfiRpcMessageSequenceImplReadLongArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<Int64> = returnArr.toArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads a Float32 array from the MessageSequence object.
     * @returns { Array<Float32> } Return a Float32 array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readFloatArray(): Array<Float32> {
        var errCode: Int32 = 0
        let returnArr: FloatArray = unsafe { FfiRpcMessageSequenceImplReadFloatArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<Float32> = returnArr.toArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads a Float64 array from the MessageSequence object.
     * @returns { Array<Float64> } Return a Float64 array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readDoubleArray(): Array<Float64> {
        var errCode: Int32 = 0
        let returnArr: DoubleArray = unsafe { FfiRpcMessageSequenceImplReadDoubleArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<Float64> = returnArr.toArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads a Bool array from the MessageSequence object.
     * @returns { Array<Bool> } Return a Bool array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readBooleanArray(): Array<Bool> {
        var errCode: Int32 = 0
        let returnArr: ByteArray = unsafe { FfiRpcMessageSequenceImplReadBooleanArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<Bool> = returnArr.toBoolArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads a UInt8 array from the MessageSequence object.
     * @returns { Array<UInt8> } Return a UInt8 array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readCharArray(): Array<UInt8> {
        var errCode: Int32 = 0
        let returnArr: CharArray = unsafe { FfiRpcMessageSequenceImplReadCharArray(getID(), inout errCode) }
        checkAndThrow(errCode)
        let arr: Array<UInt8> = returnArr.toArray()
        returnArr.free()
        return arr
    }

    /**
     * Reads a String array from the MessageSequence object.
     * @returns { Array<String> } Return a String array.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readStringArray(): Array<String> {
        var errCode: Int32 = 0
        let returnArr: CStringArray = unsafe { FfiRpcMessageSequenceImplReadStringArray(getID(), inout errCode) }
        try {
            checkAndThrow(errCode)
            return returnArr.toArray()
        } finally {
            returnArr.free()
        }
    }

    /**
     * Closes the specified file descriptor.
     * @param { Int32 } fd - File descriptor to be closed.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public static func closeFileDescriptor(fd: Int32): Unit {
        unsafe { FfiRpcMessageSequenceImplCloseFileDescriptor(fd) }
    }

    /**
     * Duplicates the specified file descriptor.
     * @param { Int32 } fd - File descriptor to be duplicated.
     * @returns { Int32 } Return a duplicated file descriptor.
     * @throws { BusinessException } 1900013 - Failed to call dup.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public static func dupFileDescriptor(fd: Int32): Int32 {
        let dupFd = unsafe { FfiRpcMessageSequenceImplDupFileDescriptor(fd) }
        if (dupFd < 0) {
            throw BusinessException(ErrorCode.OsDupError.value, ERR_CODE_MAP[ErrorCode.OsDupError.value])
        }
        return dupFd
    }

    /**
     * Checks whether this MessageSequence object contains a file descriptor.
     * @returns { Bool } Return True if the MessageSequence object contains a file descriptor;
     *                      return False otherwise.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func containFileDescriptors(): Bool {
        var errCode: Int32 = 0
        let returnBool: Bool = unsafe { FfiRpcMessageSequenceImplContainFileDescriptors(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnBool
    }

    /**
     * Writes a file descriptor to this MessageSequence object.
     * @param { Int32 } fd - File descriptor to wrote.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeFileDescriptor(fd: Int32): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteFileDescriptor(getID(), fd, inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Reads a file descriptor from this MessageSequence object.
     * @returns { Int32 } Return a file descriptor obtained.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readFileDescriptor(): Int32 {
        var errCode: Int32 = 0
        let returnInt: Int32 = unsafe { FfiRpcMessageSequenceImplReadFileDescriptor(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnInt
    }

    /**
     * Writes an anonymous shared memory object to this MessageSequence object.
     * @param { Ashmem } ashmem - Anonymous shared memory object to wrote.
     * @throws { BusinessException } 1900003 - Failed to write data to the shared memory.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeAshmem(ashmem: Ashmem): Unit {
        var errCode: Int32 = 0
        unsafe { FfiRpcMessageSequenceImplWriteAshmem(getID(), ashmem.getID(), inout errCode) }
        checkAndThrow(errCode)
    }

    /**
     * Reads the anonymous shared memory object from this MessageSequence object.
     * @returns { Ashmem } Return the anonymous share object obtained.
     * @throws { BusinessException } 1900004 - Failed to read data from the shared memory.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readAshmem(): Ashmem {
        var errCode: Int32 = 0
        let ashmem: Int64 = unsafe { FfiRpcMessageSequenceImplReadAshmem(getID(), inout errCode) }
        checkAndThrow(errCode)
        return Ashmem(ashmem)
    }

    /**
     * Obtains the maximum amount of raw data that can be sent in a time.
     * @returns { UInt32 } 128 MB.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    public func getRawDataCapacity(): UInt32 {
        var errCode: Int32 = 0
        let returnInt: UInt32 = unsafe { FfiRpcMessageSequenceImplGetRawDataCapacity(getID(), inout errCode) }
        checkAndThrow(errCode)
        return returnInt
    }

    /**
     * Writes the data in an Array<UInt8> object into this MessageSequence object.
     * @param { Array<UInt8> } buf - Data to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeUInt8Array(buf: Array<UInt8>): Unit {
        if (buf.size == 0) {
            throw BusinessException(ErrorCode.WriteDataToMessageSequenceError.value,
                "MessageSequence writeUInt8Array:  Write data to message sequence failed.")
        }
        let cp = unsafe { acquireArrayRawData(buf) }
        var errCode = 0i32
        unsafe {
            FfiRpcMessageSequenceImplWriteArrayBuffer(getID(), Uint8Array.value, CPointer<Unit>(cp.pointer),
                UIntNative(buf.size), inout errCode)
        }
        unsafe { releaseArrayRawData(cp) }
        checkAndThrow(errCode)
    }

    /**
     * Writes the data in an Array<UInt16> object into this MessageSequence object.
     * @param { Array<UInt16> } buf - Data to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeUInt16Array(buf: Array<UInt16>): Unit {
        if (buf.size == 0) {
            throw BusinessException(ErrorCode.WriteDataToMessageSequenceError.value,
                "MessageSequence writeUInt16Array:  Write data to message sequence failed.")
        }
        let cp = unsafe { acquireArrayRawData(buf) }
        var errCode = 0i32
        unsafe {
            FfiRpcMessageSequenceImplWriteArrayBuffer(getID(), Uint16Array.value, CPointer<Unit>(cp.pointer),
                UIntNative(buf.size) * BYTE_SIZE_16, inout errCode)
        }
        unsafe { releaseArrayRawData(cp) }
        checkAndThrow(errCode)
    }

    /**
     * Writes the data in an Array<UInt32> object into this MessageSequence object.
     * @param { Array<UInt32> } buf - Data to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeUInt32Array(buf: Array<UInt32>): Unit {
        if (buf.size == 0) {
            throw BusinessException(ErrorCode.WriteDataToMessageSequenceError.value,
                "MessageSequence writeUInt32Array:  Write data to message sequence failed.")
        }
        let cp = unsafe { acquireArrayRawData(buf) }
        var errCode = 0i32
        unsafe {
            FfiRpcMessageSequenceImplWriteArrayBuffer(getID(), Uint32Array.value, CPointer<Unit>(cp.pointer),
                UIntNative(buf.size) * BYTE_SIZE_32, inout errCode)
        }
        unsafe { releaseArrayRawData(cp) }
        checkAndThrow(errCode)
    }

    /**
     * Writes the data in an Array<UInt64> object into this MessageSequence object.
     * @param { Array<UInt64> } buf - Data to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeUInt64Array(buf: Array<UInt64>): Unit {
        if (buf.size == 0) {
            throw BusinessException(ErrorCode.WriteDataToMessageSequenceError.value,
                "MessageSequence writeUInt64Array:  Write data to message sequence failed.")
        }
        let cp = unsafe { acquireArrayRawData(buf) }
        var errCode = 0i32
        unsafe {
            FfiRpcMessageSequenceImplWriteArrayBuffer(getID(), BigUint64Array.value, CPointer<Unit>(cp.pointer),
                UIntNative(buf.size) * BYTE_SIZE_64, inout errCode)
        }
        unsafe { releaseArrayRawData(cp) }
        checkAndThrow(errCode)
    }

    /**
     * Reads raw data from this MessageSequence object.
     * @returns { Array<UInt8> } Returns the Array<UInt8> obtained.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readUInt8Array(): Array<UInt8> {
        var errCode: Int32 = 0
        let buf: CharArray = unsafe { FfiRpcMessageSequenceImplReadUInt8ArrayBuffer(getID(), inout errCode) }
        checkAndThrow(errCode)
        let result = buf.toArray()
        buf.free()
        return result
    }

    /**
     * Reads raw data from this MessageSequence object.
     * @returns { Array<UInt16> } Returns the Array<UInt16> obtained.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readUInt16Array(): Array<UInt16> {
        var errCode: Int32 = 0
        let buf: UInt16Array = unsafe { FfiRpcMessageSequenceImplReadUInt16ArrayBuffer(getID(), inout errCode) }
        checkAndThrow(errCode)
        let result = buf.toArray()
        buf.free()
        return result
    }

    /**
     * Reads raw data from this MessageSequence object.
     * @returns { Array<UInt32> } Returns the Array<UInt32> obtained.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readUInt32Array(): Array<UInt32> {
        var errCode: Int32 = 0
        let buf: UInt32Array = unsafe { FfiRpcMessageSequenceImplReadUInt32ArrayBuffer(getID(), inout errCode) }
        checkAndThrow(errCode)
        let result = buf.toArray()
        buf.free()
        return result
    }

    /**
     * Reads raw data from this MessageSequence object.
     * @returns { Array<UInt64> } Returns the Array<UInt64> obtained.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readUInt64Array(): Array<UInt64> {
        var errCode: Int32 = 0
        let buf: UInt64Array = unsafe { FfiRpcMessageSequenceImplReadUInt64ArrayBuffer(getID(), inout errCode) }
        checkAndThrow(errCode)
        let result = buf.toArray()
        buf.free()
        return result
    }

    /**
     * Writes a Parcelable object into the MessageSequence object.
     * @param { T } val - Indicates the Parcelable object to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeParcelable<T>(val: T): Unit where T <: Parcelable {
        let pos = getWritePosition()
        writeInt(1)
        try {
            val.marshalling(this)
        } catch (e: BusinessException) {
            rewindWrite(pos)
            checkAndThrow(ErrorCode.WriteDataToMessageSequenceError.value)
        }
    }

    /**
     * Reads a Parcelable object from the MessageSequence instance.
     * @param { T } dataIn - Indicates the Parcelable object that needs to perform
     *                       the unmarshalling operation using the MessageSequence.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     * @throws { BusinessException } 1900012 - Failed to call the JS callback function.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readParcelable<T>(dataIn: T): Unit where T <: Parcelable {
        let len = readInt()
        if (len > 0) {
            dataIn.unmarshalling(this)
            return
        }
        checkAndThrow(ErrorCode.ReadDataFromMessageSequenceError.value)
    }

    /**
     * Writes a Parcelable object array into the MessageSequence object.
     * @param { Array<T> } parcelableArray - Indicates the Parcelable object array to write.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeParcelableArray<T>(parcelableArray: Array<T>): Unit where T <: Parcelable {
        let pos = getWritePosition()
        let result = unsafe { FfiRpcMessageSequenceImplWriteUint32(getID(), UInt32(parcelableArray.size)) }
        if (!result) {
            checkAndThrow(ErrorCode.WriteDataToMessageSequenceError.value)
        }
        for (i in 0..parcelableArray.size) {
            try {
                writeInt(1)
                parcelableArray[i].marshalling(this)
            } catch (e: BusinessException) {
                rewindWrite(pos)
                checkAndThrow(ErrorCode.WriteDataToMessageSequenceError.value)
            }
        }
    }

    /**
     * Reads the specified Parcelable array from this MessageSequence object.
     * @param { Array<T> } parcelableArray - Parcelable array to read.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     * @throws { BusinessException } 1900012 - Failed to call the JS callback function.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readParcelableArray<T>(parcelableArray: Array<T>): Unit where T <: Parcelable {
        let arrayLength = readInt()
        if (Int64(arrayLength) != parcelableArray.size) {
            throw BusinessException(ErrorCode.CheckParamError.value, "Parameter error.")
        }
        for (i in 0..parcelableArray.size) {
            let len = readInt()
            if (len > 0) {
                parcelableArray[i].unmarshalling(this)
            }
        }
    }

    /**
     * Writes raw data to this MessageSequence object.
     * @param { Array<Byte> } rawData - Raw data to wrote.
     * @param { Int64 } size - Size of the raw data, in bytes.
     * @throws { BusinessException } 1900009 - Failed to write data to the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func writeRawDataBuffer(rawData: Array<Byte>, size: Int64): Unit {
        if (size <= 0 || size > rawData.size) {
            throw BusinessException(ErrorCode.CheckParamError.value, "Parameter error.")
        }
        unsafe {
            let cp = acquireArrayRawData(rawData)
            var errCode = 0i32
            FfiRpcMessageSequenceImplWriteRawDataBuffer(getID(), cp.pointer, size, inout errCode)
            releaseArrayRawData(cp)
            checkAndThrow(errCode)
        }
    }

    /**
     * Reads raw data from this MessageSequence object.
     * @param { Int64 } size - Size of the raw data to read.
     * @returns { Array<Byte> } Return the raw data obtained, in bytes.
     * @throws { BusinessException } 1900010 - Failed to read data from the message sequence.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core",
        throwexception: true
    ]
    public func readRawDataBuffer(size: Int64): Array<Byte> {
        if (size <= 0) {
            throw BusinessException(ErrorCode.CheckParamError.value, "Parameter error.")
        }
        unsafe {
            var errCode: Int32 = 0
            let data = FfiRpcMessageSequenceImplReadRawDataBuffer(getID(), size, inout errCode)
            checkAndThrow(errCode)
            let arr = Array<Byte>(size, {i => data.read(i)})
            LibC.free(data)
            return arr
        }
    }
}
