# 基础通信仓颉接口

## 简介

基础通信仓颉接口是在OpenHarmony上基于基础通信子系统能力之上封装的仓颉API。基础通信子系统旨在为OpenHarmony系统提供的通信相关的能力，包括：WLAN服务能力、蓝牙服务能力等通信能力。当前开放的基础通信仓颉接口仅支持standard设备。

蓝牙服务：为应用提供传统蓝牙以及低功耗蓝牙相关功能和服务。

WLAN服务：无线局域网（Wireless Local Area Networks，WLAN），是通过无线电、红外光信号或者其他技术发送和接收数据的局域网，用户可以通过WLAN实现结点之间无物理连接的网络通讯。常用于用户携带可移动终端的办公、公众环境中。

## 系统架构

**图 1**  基础通信仓颉架构图

![](figures/connectivity_cangjie_wrapper_architecture.png)

如架构图所示：

- 低功耗蓝牙封装：一种能够在低功耗情况下进行通信的蓝牙技术。
- 蓝牙Profile封装：一种基于蓝牙的通用文件传输协议，允许设备之间进行文件传输，如a2dp，hfp等。
- 蓝牙常量：蓝牙相关的公共常量定义。
- WLAN基础功能封装：提供P2P功能，一种点对点连接技术，可以在两台 STA 之间直接建立 TCP/IP 链接。
- 仓颉基础通信FFI接口：负责定义被Cangjie语言调用的C语言互操作接口，调用基础通信服务能力。
- 仓颉互操作：封装C语言互操作公共接口，并提供仓颉标签类实现用于对仓颉API进行标注，以及提供抛向用户的BusinessException异常类定义。
- 蓝牙通信服务：调用底层蓝牙驱动，提供接入与使用蓝牙的相关C语言接口，包括BLE设备gatt相关的操作，以及BLE广播、扫描等功能。
- WLAN服务：调用底层Wi-Fi驱动，提供WLAN的相关功能C语言接口，包括WLAN基础功能，WLAN消息通知，WLAN P2P模式等功能。
- 仓颉DFX：负责提供日志接口，用于在关键路径处打印日志。

## 目录

基础通信仓颉主要代码目录结构如下：

```
foundation/communication/connectivity_cangjie_wrapper
├── figures                          # README中的架构图存放目录
├── kit                              # kit化接口代码
│   └── ConnectivityKit              # 仓颉ConnectivityKit代码目录
├── ohos                             # 仓颉基础通信接口代码
│   ├── bluetooth                    # 仓颉蓝牙接口存放目录
│   │   ├── a2dp                     # a2dp Profile相关接口
│   │   ├── base_profile             # 蓝牙基础Profile接口
│   │   ├── ble                      # 低功耗蓝牙相关接口
│   │   ├── connection               # 蓝牙连接相关接口
│   │   ├── constant                 # 蓝牙常量定义
│   │   ├── error_message.cj         # 蓝牙错误信息定义
│   │   └── hfp                      # hfp Profile相关接口
│   └── wifi_manager                 # 仓颉wifi接口存放目录
└── test                             # 测试代码  
    ├── bluetooth                    # 蓝牙UT测试
    │   └── test                     # 蓝牙测试工程
    └── wifi_manager                 # WiFiUT测试
        └── test                     # WiFi测试工程
```

## 使用说明

### 蓝牙接口

蓝牙相关接口，目前提供BLE相关的能力，以及各类设备Profile相关的能力。

-   BLE（低功耗蓝牙）

BLE是Bluetooth Low Energy的缩写，意为"低功耗蓝牙"。它是一种能够在低功耗情况下进行通信的蓝牙技术，与传统蓝牙相比，BLE的功耗更低，适用于需要长时间运行的低功耗设备，如智能手表、健康监测设备、智能家居等。

详情请参见: [ble API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-ble.md)。

-   A2DP（高级音频分发配置文件）

A2DP是Advanced Audio Distribution Profile的缩写，即高级音频分发配置文件。它是一种蓝牙协议，允许无线传输高品质音频流，例如音乐或语音通话，同时支持双向通信，因此可以用于耳机、扬声器、汽车音响等设备。

详情请参见: [a2dp API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-a2dp.md)。

与ArkTS提供的API能力相比暂未提供蓝牙socket模块相关功能。

-   HFP（Hands-Free Profile）是蓝牙免提协议，允许蓝牙设备控制对端蓝牙设备的通话，例如蓝牙耳机控制手机通话的接听、挂断、拒接、语音拨号等。

详情请参见: [hfp API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-hfp.md)。


相关指导请参见: [蓝牙服务开发概述](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/connectivity/bluetooth/cj-bluetooth-overview.md)

### Wifi接口

WLAN相关接口为用户提供WLAN基础功能、P2P（peer-to-peer）功能和WLAN消息通知的相应服务，让应用可以通过WLAN和其他设备互联互通。

#### P2P模式

P2P模式即为Wi-Fi Direct，Wi-Fi Direct 是一种点对点连接技术，它可以在两台 STA 之间直接建立 TCP/IP 链接，并不需要AP的参与。其中一台STA会起到传统意义上的AP的作用，称为Group Owner(GO)，另外一台station则称为Group Client(GC)，像连接AP一样连接到GO。

详情请参见: [wifi API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-wifi_manager.md)。

与ArkTS提供的API能力相比暂未提供STA模式、AP模式相关功能。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[communication_bluetooth](https://gitcode.com/openharmony/communication_bluetooth/blob/master/README_zh.md)

[communication_wifi](https://gitcode.com/openharmony/communication_wifi/blob/master/README_zh.md)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/README_zh.md)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper/blob/master/README_zh.md)