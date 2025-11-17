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

import ohos.labels.APILevel


/**
 * During inter-process communication, objects of the class are written to the MessageSequence and
 * they are recovered from the MessageSequence.
 */
@!APILevel[
    since: "22",
    syscap: "SystemCapability.Communication.IPC.Core"
]
public interface Parcelable {
    /**
     * Marshal this Parcelable object into a MessageSequence.
     * @param { MessageSequence } dataOut - Indicates the MessageSequence object to which the Parcelable
     *                            object will be marshalled.
     * @returns { Bool } Return True if the marshalling is successful; return False otherwise.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    func marshalling(dataOut: MessageSequence): Bool

    /**
     * Unmarshal this Parcelable object from a MessageSequence.
     * @param { MessageSequence } dataIn - Indicates the MessageSequence object into
     *                            which the Parcelable object has been marshalled.
     * @returns { Bool } Return True if the unmarshalling is successful; return False otherwise.
     */
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Communication.IPC.Core"
    ]
    func unmarshalling(dataIn: MessageSequence): Bool
}

