# communication_cangjie_wrapper

## Introduction

The distributed soft bus subsystem is designed to provide communication-related capabilities for the OpenHarmony system. The currently open distributed soft bus Cangjie interface only supports standard devices.

## System Architecture

**Figure 1** Diagram of the Cangjie architecture of distributed soft bus

![Diagram of the Cangjie architecture of distributed soft bus](figures/commounication_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram:

Interface:

- MessageSequence: Provides the data format used for communication.
- Ashmem: Provides methods related to anonymous shared memory objects.

Framework:

- MessageSequence wrapper: Implementation encapsulation of Cangjie MessageSequence, providing MessageSequence capabilities.
- Ashmem wrapper: Implementation encapsulation of Cangjie Ashmem, providing Ashmem capabilities.

- Explanation of Dependencies in the Architecture Diagram:

- communication_ipc: Responsible for providing basic RPC functions, and encapsulating the C Language interface to provide Cangjie for interoperability.
- cangjie_ark_interop: Responsible for providing Cangjie APILevel class definitions, which are used to annotate APIs, as well as providing the definition of BusinessException class that is thrown to users.
- hiviewdfx_cangjie_wrapper: Responsible for providing logging interfaces, which are used to print logs at key points in the execution path.

## Directory Structure

The DSoftBus directory structure is as follows:

```
foundation/communication/communication_cangjie_wrapper
├── figures                             # architecture pictures
├── kit                                 # Cangjie IPC Kit interface
│   └── IPCKit
├── ohos                                # Cangjie IPC code
│   └── rpc
│       ├── message_sequence.cj         # The interface for MessageSequence
│       └── ashmem.cj                   # The interface for Ashmem
└── test                                # Cangjie test cases
    └── rpc                             # rpc test cases
```

## Usage

The current distributed soft bus Cangjie interface provides the following functions:

- Provides basic types and data formats for communication, such as arrays, IPC objects, interface descriptors, and custom serialization objects.
- Provides methods related to anonymous shared memory objects, including creating, closing, mapping, and unmapping Ashmem, reading and writing data from Ashmem, getting Ashmem size, and setting Ashmem protection.

See Camera APIs[RPC Communication](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/IPCKit/cj-apis-rpc.md).For guidance, please refer to[RPC Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/ipc/cj-ipc-rpc-overview.md).

## Constraints

Compared with ArkTS, the following functions are not supported at the moment:

- Implement IRemoteObject proxy objects.
- Obtain IPC context information, including obtaining UID and PID, obtaining local and peer device IDs, and checking whether interface calls are on the same device.
- Implement remote objects.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[communication_ipc](https://gitcode.com/openharmony/communication_ipc)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)
