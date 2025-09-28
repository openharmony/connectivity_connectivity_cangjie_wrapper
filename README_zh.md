# 基础通信仓颉封装

## 简介

基础通信仓颉封装为OpenHarmony应用开发者提供使用蓝牙服务、WLAN服务能力的仓颉API实现。当前开放的基础通信仓颉接口仅支持standard设备。

蓝牙服务：为应用提供传统蓝牙以及低功耗蓝牙相关功能和服务。

WLAN服务：无线局域网（Wireless Local Area Networks，WLAN），是通过无线电、红外光信号或者其他技术发送和接收数据的局域网，用户可以通过WLAN实现结点之间无物理连接的网络通讯。常用于用户携带可移动终端的办公、公众环境中。

## 系统架构

**图 1**  基础通信仓颉架构图

![](figures/connectivity_cangjie_wrapper_architecture.png)

如架构图所示：

接口层说明：

- 低功耗蓝牙接口：提供了基于低功耗蓝牙（Bluetooth Low Energy，BLE）技术的蓝牙能力，支持发起BLE扫描、发送BLE广播报文、以及基于通用属性协议（Generic Attribute Profile，GATT）的连接和传输数据的仓颉公开接口声明。
- 蓝牙baseProfile接口：蓝牙Profile一种基于蓝牙的通用文件传输协议，提供了不同的蓝牙技术协议的基础公共方法的仓颉公开接口声明。
- 蓝牙a2dp接口：提供基于增强音频分发协议（Advanced Audio Distribution Profile，A2DP）的蓝牙媒体音频能力，支持获取媒体播放状态和连接状态的仓颉公开接口声明。
- 蓝牙hfp接口：提供基于免提协议（Hands-Free Profile， HFP）的蓝牙通话音频能力的仓颉公开接口声明。
- 蓝牙常量接口：提供了蓝牙各Profile、设备类型相关的常量定义的仓颉公开接口声明。
- WLAN基础功能接口：提供了P2P（peer-to-peer，可以在两台 STA 之间直接建立 TCP/IP 链接）功能的仓颉公开接口声明。

框架层说明：

- 低功耗蓝牙封装：低功耗蓝牙是一种能够在低功耗情况下进行通信的蓝牙技术。该封装层是基于蓝牙组件对低功耗蓝牙功能进行仓颉封装实现。
- 蓝牙baseProfile封装：提供了不同的蓝牙技术协议的抽象封装。
- 蓝牙a2dp封装：实现了基于a2dp协议的播放状态和连接状态查询。
- 蓝牙hfp封装：实现了基于hfp协议的蓝牙通话音频能力。
- 蓝牙常量：定义了蓝牙相关的公共常量。
- WLAN基础功能封装：提供P2P功能，一种点对点连接技术。该封装层是基于WLAN组件对WLAN基础功能进行仓颉封装实现。

仓颉基础通信服务依赖部件引入说明：

- 蓝牙组件：调用底层蓝牙驱动，提供包括BLE设备gatt相关的操作，以及BLE广播、扫描等蓝牙相关native功能实现。
- WLAN组件：调用底层Wi-Fi驱动，提供包括WLAN基础功能，WLAN消息通知，WLAN P2P模式等native功能实现。
- cangjie_ark_interop：封装C语言互操作公共接口，并提供仓颉标签类实现用于对仓颉API进行标注，以及提供抛向用户的BusinessException异常类定义。
- hiviewdfx_cangjie_wrapper：提供可被基础通信仓颉接口调用在关键路径处打印日志能力的仓颉接口。

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
│   │   ├── constant                 # 蓝牙常量定义
│   │   ├── error_message.cj         # 蓝牙错误信息定义
│   │   └── hfp                      # hfp Profile相关接口
│   └── wifi_manager                 # 仓颉wifi接口存放目录
└── test                             # 测试代码  
    ├── bluetooth                    # 蓝牙UT测试
    └── wifi_manager                 # WiFiUT测试
```

## 使用说明

### 蓝牙接口

蓝牙相关接口，目前提供BLE相关的能力，以及各类设备Profile相关的能力。

-   BLE（低功耗蓝牙）

BLE是Bluetooth Low Energy的缩写，意为"低功耗蓝牙"。它是一种能够在低功耗情况下进行通信的蓝牙技术，与传统蓝牙相比，BLE的功耗更低，适用于需要长时间运行的低功耗设备，如智能手表、健康监测设备、智能家居等。

详情请参见: [ble API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-ble.md)。

-   A2DP（高级音频分发配置文件）

A2DP即为高级音频分发配置文件。它是一种蓝牙协议，允许无线传输高品质音频流，例如音乐或语音通话，同时支持双向通信，因此可以用于耳机、扬声器、汽车音响等设备。

详情请参见: [a2dp API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-a2dp.md)。

-   HFP即为蓝牙免提协议，允许蓝牙设备控制对端蓝牙设备的通话，例如蓝牙耳机控制手机通话的接听、挂断、拒接、语音拨号等。

详情请参见: [hfp API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-hfp.md)。


相关指导请参见: [蓝牙服务开发概述](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/connectivity/bluetooth/cj-bluetooth-overview.md)

### Wifi接口

WLAN相关接口为用户提供P2P功能

P2P模式即为Wi-Fi Direct，Wi-Fi Direct 是一种点对点连接技术，它可以在两台 STA 之间直接建立 TCP/IP 链接，并不需要AP的参与。其中一台STA会起到传统意义上的AP的作用，称为Group Owner(GO)，另外一台station则称为Group Client(GC)，像连接AP一样连接到GO。

详情请参见: [wifi API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-wifi_manager.md)。

相关指导请参见: [WLAN开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_zh_cn/connectivity/wifi/cj-wifi-development-guide.md)

## 约束

与ArkTS提供的API能力相比，暂不支持以下功能：

- [NFC(Near Field Communication)](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/connectivity/nfc/nfc-hce-guide.md)。
- [管理安全单元（SecureElement，简称SE）](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/connectivity/nfc/nfc-se-access-guide.md)

蓝牙服务中暂不支持
- [蓝牙socket](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/reference/apis-connectivity-kit/js-apis-bluetooth-socket.md)：一种蓝牙套接字功能，可实现设备间连接和数据传输。
- [蓝牙hid](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/reference/apis-connectivity-kit/js-apis-bluetooth-hid.md)：基于人机接口协议（Human Interface Device Profile，HID）技术的蓝牙人机交互能力，支持获取连接状态。
- [蓝牙pan](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/reference/apis-connectivity-kit/js-apis-bluetooth-pan.md)：基于蓝牙个人局域网协议（Personal Area Networking，PAN）的蓝牙共享网络能力。
- [蓝牙pbap](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/reference/apis-connectivity-kit/js-apis-bluetooth-pbap.md)：基于电话簿访问协议（Phone Book Access Profile，PBAP）的蓝牙电话簿访问能力。
- [蓝牙map](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/reference/apis-connectivity-kit/js-apis-bluetooth-map.md)：基于消息访问协议（Message Access Profile，MAP）的蓝牙消息访问能力。

Wifi服务中暂不支持
- [STA模式、AP模式](https://gitcode.com/openharmony/docs/blob/master/zh-cn/application-dev/connectivity/wlan/sta-development-guide.md)相关功能：Wi-Fi STA模式（Station Mode，站点模式）是无线设备作为客户端接入无线局域网（WLAN）的工作模式。在该模式下，设备（如手机、电脑、平板等）通过连接到接入点（AP，Access Point）或无线路由器，实现对网络的访问。

## 参与贡献

欢迎广大开发者贡献代码、文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[communication_bluetooth](https://gitcode.com/openharmony/communication_bluetooth/blob/master/README_zh.md)

[communication_wifi](https://gitcode.com/openharmony/communication_wifi/blob/master/README_zh.md)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/README_zh.md)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper/blob/master/README_zh.md)