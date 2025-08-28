# communication_cangjie_wrapper

## Introduction

The communication_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the Distributed Softbus Subsystem. The DSoftBus subsystem provides the following communication capabilities for OpenHarmony:

- Remote procedure call (RPC): communications between processes on a device or across devices.

## System Architecture

**Figure 1** Diagram of the Cangjie architecture of distributed soft bus

![](figures/commounication_cangjie_wrapper_architecture_en.png)

## Directory Structure

The DSoftBus directory structure is as follows:

```
foundation/communication/communication_cangjie_wrapper
├── ohos             # Cangjie DSoftBus code
├── kit              # Cangjie kit code
├── figures          # architecture pictures
```

## Constraints

- The devices must be in the same LAN.
- When communicating across processes on a single device, the maximum amount of data transferred is about 1 MB.
- It is not supported to pass a cross-device proxy object back to the device where the stub object is located.
- The currently open distributed soft bus Cangjie interface only supports standard devices.

## Usage

The current distributed soft bus Cangjie interface provides the following functions:

- The server sends the request, and the client sends the request.

Compared with ArkTS, the following functions are not supported at the moment:

- The server side processes the request.

See Camera APIs[ohos.rpc (RPC Communication)](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/IPCKit/cj-apis-rpc.md).For guidance, please refer to[RPC Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/ipc/cj-ipc-rpc-overview.md).

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[communication\_ipc](https://gitee.com/openharmony/communication_ipc)
