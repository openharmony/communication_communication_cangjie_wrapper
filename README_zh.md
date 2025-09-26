# 分布式软总线仓颉封装

## 简介

在OpenHarmnoy平台上，分布式软总线仓颉封装为开发者提供了使用仓颉语言进行应用开发时所需的跨进程通信相关的能力。当前开放的分布式软总线仓颉接口仅支持standard设备。

## 系统架构

**图 1** 分布式软总线仓颉架构图

![分布式软总线仓颉架构图](figures/communication_cangjie_wrapper_architecture.png)

如架构图所示：

接口层：

- 消息序列：提供基础类型及数组、IPC对象、接口描述符和自定义序列化对象等用来通信的数据格式。
- 匿名共享内存对象：提供与匿名共享内存对象相关的方法，包括创建、关闭、映射和取消映射Ashmem、从Ashmem读取数据和写入数据、获取Ashmem大小、设置Ashmem保护。

框架层：

- 消息序列封装：仓颉消息序列的实现封装，提供消息序列能力。
- 匿名共享内存对象封装：仓颉匿名共享内存对象的实现封装，提供匿名共享内存对象能力。

架构图中的依赖部件引入说明：

- IPC/RPC组件：负责提供RPC基础功能，封装C语言接口提供给仓颉进行互操作。
- cangjie_ark_interop：负责提供仓颉注解类定义，用于对API进行标注，以及提供抛向用户的BusinessException异常类定义。
- hiviewdfx_cangjie_wrapper：负责提供日志接口，用于在关键路径处打印日志。

## 目录

分布式软总线仓颉主要代码目录结构如下：

```
foundation/communication/communication_cangjie_wrapper
├── figures                             # 存放README中的架构图
├── kit                                 # 仓颉IPC kit化接口
│   └── IPCKit
├── ohos                                # 仓颉IPC接口实现
│   └── rpc
│       ├── message_sequence.cj         # 消息序列接口
│       └── ashmem.cj                   # 匿名共享内存对象接口
└── test                                # 仓颉测试用例
    └── rpc                             # rpc测试用例
```

## 使用说明

当前分布式软总线仓颉接口提供了以下功能：

- 提供基础类型及数组、IPC对象、接口描述符和自定义序列化对象等用来通信的数据格式。
- 提供与匿名共享内存对象相关的方法，包括创建、关闭、映射和取消映射Ashmem、从Ashmem读取数据和写入数据、获取Ashmem大小、设置Ashmem保护。

RPC相关API请参见[RPC通信](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/IPCKit/cj-apis-rpc.md)，相关指导请参见[RPC开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/ipc/cj-ipc-rpc-overview.md)。

## 约束

与ArkTS提供的API能力相比，暂不支持以下功能：

- 实现IRemoteObject代理对象。
- 获取IPC上下文信息，包括获取UID和PID、获取本端和对端设备ID、检查接口调用是否在同一设备上。
- 实现远程对象。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop)

[communication_ipc](https://gitcode.com/openharmony/communication_ipc)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper)
