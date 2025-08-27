# 分布式软总线仓颉接口

## 简介

分布式软总线仓颉接口是在 OpenHarmony 上基于分布式软总线子系统能力之上封装的仓颉API。分布式软总线子系统旨在为OpenHarmony系统提供的通信相关的能力，包括：进程间通信RPC（Remote Procedure Call）等通信能力。

进程间通信：提供不区分设备内或设备间的进程间通信能力。

## 系统架构

**图 1**  分布式软总线仓颉架构图

![](figures/communication_cangjie_wrapper_architecture.png)

## 目录

分布式软总线仓颉主要代码目录结构如下：

```
foundation/communication/communication_cangjie_wrapper
├── ohos             # 仓颉IPC接口实现
├── kit              # 仓颉kit化代码
├── figures          # 存放readme中的架构图
```

## 约束

- 组网限制：必须确保设备在同一个局域网中。
- 单个设备上跨进程通信时，传输的数据量最大约为1MB，过大的数据量请使用匿名共享内存。
- 不支持把跨设备的Proxy对象传递回该Proxy对象所指向的Stub对象所在的设备。
- 当前开放的分布式软总线仓颉接口仅支持standard设备。

## 使用说明

当前分布式软总线仓颉接口提供了以下功能：

- 服务端，客户端发送请求。

与ArkTS相比，暂不支持以下功能：

- 服务端处理请求。

RPC相关API请参见[ohos.rpc（RPC通信）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/IPCKit/cj-apis-rpc.md)，相关指导请参见[RPC开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/ipc/cj-ipc-rpc-overview.md)。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[communication\_ipc](https://gitee.com/openharmony/communication_ipc/blob/master/README.md)
