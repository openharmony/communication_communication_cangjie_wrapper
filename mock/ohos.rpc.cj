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

package ohos.rpc

import ohos.labels.*

@!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
public class Ashmem {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public static const PROT_EXEC: UInt32 = 4

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public static const PROT_NONE: UInt32 = 0

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public static const PROT_READ: UInt32 = 1

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public static const PROT_WRITE: UInt32 = 2

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public static func create(name: String, size: Int32): Ashmem {
        return Ashmem()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public static func create(ashmem: Ashmem): Ashmem {
        return Ashmem()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func closeAshmem(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func unmapAshmem(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getAshmemSize(): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func mapTypedAshmem(mapType: UInt32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func mapReadWriteAshmem(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func mapReadonlyAshmem(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func setProtectionType(protectionType: UInt32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeDataToAshmem(buf: Array<Byte>, size: Int64, offset: Int64): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readDataFromAshmem(size: Int64, offset: Int64): Array<Byte> {
        return Array()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
public class MessageSequence {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public static func create(): MessageSequence {
        return MessageSequence()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func reclaim(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeInterfaceToken(token: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readInterfaceToken(): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getSize(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getCapacity(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func setSize(size: UInt32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func setCapacity(size: UInt32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getWritableBytes(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getReadableBytes(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getReadPosition(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getWritePosition(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func rewindWrite(pos: UInt32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func rewindRead(pos: UInt32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeNoException(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readException(): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeByte(val: Int8): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeShort(val: Int16): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeInt(val: Int32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeLong(val: Int64): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeFloat(val: Float32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeDouble(val: Float64): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeBoolean(val: Bool): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeChar(val: UInt8): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeString(val: String): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeParcelable<T>(val: T): Unit where T <: Parcelable {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeByteArray(byteArray: Array<Int8>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeShortArray(shortArray: Array<Int16>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeIntArray(intArray: Array<Int32>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeLongArray(longArray: Array<Int64>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeFloatArray(floatArray: Array<Float32>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeDoubleArray(doubleArray: Array<Float64>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeBooleanArray(booleanArray: Array<Bool>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeCharArray(charArray: Array<UInt8>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeStringArray(stringArray: Array<String>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeParcelableArray<T>(parcelableArray: Array<T>): Unit where T <: Parcelable {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readByte(): Int8 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readShort(): Int16 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readInt(): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readLong(): Int64 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readFloat(): Float32 {
        return 0.0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readDouble(): Float64 {
        return 0.0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readBoolean(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readChar(): UInt8 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readString(): String {
        return String()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readParcelable<T>(dataIn: T): Unit where T <: Parcelable {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readByteArray(): Array<Int8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readShortArray(): Array<Int16> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readIntArray(): Array<Int32> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readLongArray(): Array<Int64> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readFloatArray(): Array<Float32> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readDoubleArray(): Array<Float64> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readBooleanArray(): Array<Bool> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readCharArray(): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readStringArray(): Array<String> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readParcelableArray<T>(parcelableArray: Array<T>): Unit where T <: Parcelable {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public static func closeFileDescriptor(fd: Int32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public static func dupFileDescriptor(fd: Int32): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func containFileDescriptors(): Bool {
        return true
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeFileDescriptor(fd: Int32): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readFileDescriptor(): Int32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeAshmem(ashmem: Ashmem): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readAshmem(): Ashmem {
        return Ashmem()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    public func getRawDataCapacity(): UInt32 {
        return 0
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeRawDataBuffer(rawData: Array<Byte>, size: Int64): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readRawDataBuffer(size: Int64): Array<Byte> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeUInt8Array(buf: Array<UInt8>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeUInt16Array(buf: Array<UInt16>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeUInt32Array(buf: Array<UInt32>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func writeUInt64Array(buf: Array<UInt64>): Unit {
        return ()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readUInt8Array(): Array<UInt8> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readUInt16Array(): Array<UInt16> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readUInt32Array(): Array<UInt32> {
        return Array()
    }

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core", throwexception: true]
    public func readUInt64Array(): Array<UInt64> {
        return Array()
    }
    
    public init() {
        super()
    }
}

@!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
public interface Parcelable {
    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    func marshalling(dataOut: MessageSequence): Bool

    @!APILevel[since: "22", syscap: "SystemCapability.Communication.IPC.Core"]
    func unmarshalling(dataIn: MessageSequence): Bool
}