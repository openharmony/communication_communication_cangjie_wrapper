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

/**
 * Created on 2025/3/17
 */
package ohos_app_cangjie_entry

import std.unittest.testmacro.*
import ohos.business_exception.*
import std.unittest.*
import std.unittest.common.*
import IPCKit.*
import std.collection.ArrayList
import CoreFileKit.*
import PerformanceAnalysisKit.Hilog

@Test
class Test_rpc {
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readShortArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Int16> = [11, 12, 13]
        data.writeShortArray(arr)
        let newArr: Array<Int16> = data.readShortArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readIntArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Int32> = [100, 111, 112]
        data.writeIntArray(arr)
        let newArr: Array<Int32> = data.readIntArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readLongArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Int64> = [100, 111, 112]
        data.writeLongArray(arr)
        let newArr: Array<Int64> = data.readLongArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readFloatArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Float32> = [1.2, 1.3, 1.4]
        data.writeFloatArray(arr)
        let newArr: Array<Float32> = data.readFloatArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readDoubleArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Float64> = [1.2, 1.3, 1.4]
        data.writeDoubleArray(arr)
        let newArr: Array<Float64> = data.readDoubleArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readBooleanArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Bool> = [false, false, true]
        data.writeBooleanArray(arr)
        let newArr: Array<Bool> = data.readBooleanArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readCharArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<UInt8> = [97, 98, 88]
        data.writeCharArray(arr)
        let newArr: Array<UInt8> = data.readCharArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readStringArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<String> = ["仓颉", "cangjie", "ce试"]
        data.writeStringArray(arr)
        let newArr: Array<String> = data.readStringArray()
        @Expect(arr, newArr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readAshmem(): Unit {
        let data: MessageSequence = MessageSequence.create()
        let ashmem: Ashmem = Ashmem.create("ashmem", 1024i32)
        let buf: Array<Byte> = Array<Byte>(1024, repeat: 7)
        try {
            data.writeAshmem(ashmem)
            ashmem.writeDataToAshmem(buf, 1024, 0)
        } catch(e: BusinessException) {
            @Expect(e.code, 1900003)

        }
        data.reclaim()
        ashmem.closeAshmem()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeInterfaceToken_Exception(): Unit {
        let data = MessageSequence.create()
        let token = "a" * 40960
        try {
            data.writeInterfaceToken(token)
            @Assert(false)
        } catch (e: Exception) {
            // param error
            @Expect(true)
        } finally {
            data.reclaim()
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_InterfaceToken(): Unit {
        let data = MessageSequence.create()
        let str = "aaa"
        data.writeInterfaceToken(str)
        let interfaceToken = data.readInterfaceToken()
        @Expect(interfaceToken, str)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GetSize(): Unit {
        let data = MessageSequence.create()
        var result = data.getSize()
        @Expect(result, 0)
        let expectNum: UInt32 = 16
        data.writeString('Hello World')
        data.setSize(expectNum)
        result = data.getSize()
        @Expect(result, expectNum)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GetCapacity(): Unit {
        let data = MessageSequence.create()
        var result = data.getCapacity()
        @Expect(result, 0)
        let expectNum: UInt32 = 100
        data.setCapacity(expectNum)
        result = data.getCapacity()
        @Expect(result, expectNum)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getWritableBytes(): Unit {
        let data = MessageSequence.create()
        var result = data.getWritableBytes()
        @Expect(result, 0)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getReadableBytes(): Unit {
        let data = MessageSequence.create()
        var result = data.getReadableBytes()
        @Expect(result, 0)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getReadPosition(): Unit {
        let data = MessageSequence.create()
        var result = data.getReadPosition()
        @Expect(result, 0)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getWritePosition(): Unit {
        let data = MessageSequence.create()
        data.writeInt(10)
        var result = data.getWritePosition()
        @Expect(result, 4)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_rewindWrite(): Unit {
        let data = MessageSequence.create()
        data.writeInt(4)
        data.rewindWrite(0)
        data.writeInt(5)
        let number = data.readInt()
        @Expect(number, 5)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_rewindRead(): Unit {
        let data = MessageSequence.create()
        data.writeInt(12)
        data.writeString("sequence")
        let number1 = data.readInt()
        @Expect(number1, 12)
        data.rewindRead(0)
        let number2 = data.readInt()
        @Expect(number2, 12)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeNoException(): Unit {
        let data = MessageSequence.create()
        data.writeNoException()
        data.readException()
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeByte(): Unit {
        let data = MessageSequence.create()
        data.writeByte(2)
        data.writeByte(3)
        let ret = data.readByte()
        @Expect(ret, 2)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeShort(): Unit {
        let data = MessageSequence.create()
        data.writeShort(8)
        let ret = data.readShort()
        @Expect(ret, 8)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeInt(): Unit {
        let data = MessageSequence.create()
        data.writeInt(12)
        data.writeString("sequence")
        let number1 = data.readInt()
        @Expect(number1, 12)
        data.rewindRead(0)
        let number2 = data.readInt()
        @Expect(number2, 12)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeLong(): Unit {
        let data = MessageSequence.create()
        data.writeLong(10000)
        let ret = data.readLong()
        @Expect(ret, 10000)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeFloat(): Unit {
        let data = MessageSequence.create()
        data.writeFloat(1.2)
        let ret = data.readFloat()
        @Expect(ret, 1.2)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeDouble(): Unit {
        let data = MessageSequence.create()
        data.writeDouble(10.2)
        let ret = data.readDouble()
        @Expect(ret, 10.2)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeBoolean(): Unit {
        let data = MessageSequence.create()
        data.writeBoolean(false)
        let ret = data.readBoolean()
        @Expect(ret, false)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeChar(): Unit {
        let data = MessageSequence.create()
        data.writeChar(97)
        let ret = data.readChar()
        @Expect(ret, 97)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeString(): Unit {
        let data = MessageSequence.create()
        data.writeString("abc")
        let ret = data.readString()
        @Expect(ret, "abc")
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_writeByteArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Int8> = [1, 2, 3, 4, 5]
        data.writeByteArray(arr)
        let ret = data.readByteArray()
        @Expect(ret, arr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readByte(): Unit {
        let data = MessageSequence.create()
        data.writeByte(2)
        data.writeByte(3)
        let ret = data.readByte()
        @Expect(ret, 2)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readShort(): Unit {
        let data = MessageSequence.create()
        data.writeShort(8)
        let ret = data.readShort()
        @Expect(ret, 8)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readInt(): Unit {
        let data = MessageSequence.create()
        data.writeShort(10)
        let ret = data.readInt()
        @Expect(ret, 10)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readLong(): Unit {
        let data = MessageSequence.create()
        data.writeLong(10000)
        let ret = data.readLong()
        @Expect(ret, 10000)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readFloat(): Unit {
        let data = MessageSequence.create()
        data.writeFloat(1.2)
        let ret = data.readFloat()
        @Expect(ret, 1.2)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readDouble(): Unit {
        let data = MessageSequence.create()
        data.writeDouble(10.2)
        let ret = data.readDouble()
        @Expect(ret, 10.2)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readBoolean(): Unit {
        let data = MessageSequence.create()
        data.writeBoolean(false)
        let ret = data.readBoolean()
        @Expect(ret, false)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readChar(): Unit {
        let data = MessageSequence.create()
        data.writeChar(97)
        let ret = data.readChar()
        @Expect(ret, 97)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readString(): Unit {
        let data = MessageSequence.create()
        data.writeString("abc")
        let ret = data.readString()
        @Expect(ret, "abc")
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_readByteArray(): Unit {
        let data = MessageSequence.create()
        let arr: Array<Int8> = [1, 2, 3, 4, 5]
        data.writeByteArray(arr)
        let ret = data.readByteArray()
        @Expect(ret, arr)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_File(): Unit {
        let filePath = "/data/storage/el2/base/test_rpc.txt"
        let file = FileIo.open(
            filePath,
            mode: (OpenMode.CREATE | OpenMode.READ_WRITE)
        )
        let data = MessageSequence.create()
        let result1 = data.containFileDescriptors()
        @Expect(result1, false)
        data.writeFileDescriptor(file.fd)
        let result2 = data.containFileDescriptors()
        @Expect(result2, true)
        let fd = data.readFileDescriptor()
        // @Expect(fd, file.fd + 2)
        MessageSequence.dupFileDescriptor(fd)
        MessageSequence.closeFileDescriptor(fd)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_getRawDataCapacity(): Unit {
        let data = MessageSequence.create()
        let result = data.getRawDataCapacity()
        let expectNum: UInt32 = 134217728
        @Expect(result, expectNum)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_ArrayBuffer(): Unit {
        let data = MessageSequence.create()
        let arr2: Array<UInt8> = [0, 255]
        data.writeUInt8Array(arr2)
        let arr4: Array<UInt16> = [0, 65535]
        data.writeUInt16Array(arr4)
        let arr6: Array<UInt32> = [0, 4294967295]
        data.writeUInt32Array(arr6)
        let arr8: Array<UInt64> = [0, 18446744073709551615]
        data.writeUInt64Array(arr8)
        let arr9: Array<Float32> = [-3.4, 3.4]
        data.writeFloatArray(arr9)
        let uint8Arr = data.readUInt8Array()
        @Expect(uint8Arr, arr2)
        let uint16Arr = data.readUInt16Array()
        @Expect(uint16Arr, arr4)
        let uint32Arr = data.readUInt32Array()
        @Expect(uint32Arr, arr6)
        let uint64Arr = data.readUInt64Array()
        @Expect(uint64Arr, arr8)
        let floatArr = data.readFloatArray()
        @Expect(floatArr, arr9)
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_parcelable(): Unit {
        let parcelable = MyParcelable(1, "aaa")
        let data = MessageSequence.create()
        data.writeParcelable(parcelable)
        let ret = MyParcelable(1, "aaa")
        data.readParcelable(ret)
        @Expect(ret.num, 1)
        @Expect(ret.str, "aaa")
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_parcelable_array(): Unit {
        let parcelable = MyParcelable(1, "aaa")
        let parcelable2 = MyParcelable(2, "bbb")
        let parcelable3 = MyParcelable(3, "ccc")
        let data = MessageSequence.create()
        data.writeParcelableArray(parcelable, parcelable2, parcelable3)
        let ret: Array<Parcelable> = [MyParcelable(0, ""), MyParcelable(0, ""), MyParcelable(0, "")]
        data.readParcelableArray(ret)
        @Expect((ret[0] as MyParcelable).getOrThrow().num, 1)
        @Expect((ret[0] as MyParcelable).getOrThrow().str, "aaa")
        @Expect((ret[1] as MyParcelable).getOrThrow().num, 2)
        @Expect((ret[1] as MyParcelable).getOrThrow().str, "bbb")
        @Expect((ret[2] as MyParcelable).getOrThrow().num, 3)
        @Expect((ret[2] as MyParcelable).getOrThrow().str, "ccc")
        data.reclaim()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_write_read_RawDataBuffer(): Unit {
        let size = 64 * 1024
        let buffer = Array<Byte>(size, repeat: 1)
        let sequence = MessageSequence.create()
        sequence.writeRawDataBuffer(buffer, size)
        let result = sequence.readRawDataBuffer(size)
        @Expect(buffer, result)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_Ashmem_read_write(): Unit {
        let data: MessageSequence = MessageSequence.create()
        let ashmem: Ashmem = Ashmem.create("ashmem", 1024i32)
        let buf: Array<Byte> = Array<Byte>(1024, repeat: 7)
        try {
            ashmem.setProtectionType(Ashmem.PROT_WRITE)
            ashmem.mapReadWriteAshmem()
            data.writeAshmem(ashmem)
        } catch(e: BusinessException) {
            @Expect(false)
        }
        try {
            ashmem.writeDataToAshmem(buf, 1024, 0)
        } catch(e: BusinessException) {
            // writeDataToAshmem error
            @Expect(e.code, 1900003)
        }
        try {
            let res = ashmem.readDataFromAshmem(1024, 0)
        } catch(e: BusinessException) {
            Hilog.error(0, "CangjieTest", "readDataFromAshmem error ${e}")
            @Expect(e.code, 1900004)
        }
        try {
            ashmem.mapTypedAshmem(Ashmem.PROT_READ | Ashmem.PROT_WRITE)
            ashmem.mapReadonlyAshmem()
            let ash = data.readAshmem()
            let ashSize = ash.getAshmemSize()
            @Expect(ashSize, 1024)
        } catch(e: BusinessException) {
            Hilog.error(0, "CangjieTest", "readAshmem error ${e}")
            @Expect(false)

        }
        ashmem.unmapAshmem()
        data.reclaim()
        ashmem.closeAshmem()
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_AshmemCreate(): Unit {
        try {
            let ashmem1: Ashmem = Ashmem.create("ashmem", 1024i32)
            let ashmem2: Ashmem = Ashmem.create(ashmem1)
            ashmem1.closeAshmem()
            ashmem2.closeAshmem()
        } catch(e: Exception) {
            Hilog.error(0, "CangjieTest", "AshmemCreate error ${e}")
            @Expect(false)

        }
    }
}

class MyParcelable <: Parcelable {
    var num: Int32 = 0
    var str: String = ''
    init(num: Int32, str: String) {
        this.num = num
        this.str = str
    }
    public func marshalling(messageSequence: MessageSequence): Bool {
        messageSequence.writeInt(this.num)
        messageSequence.writeString(this.str)
        return true
    }
    public func unmarshalling(messageSequence: MessageSequence): Bool {
        this.num = messageSequence.readInt()
        this.str = messageSequence.readString()
        return true
    }
}