# 基础通信仓颉接口

## 简介

基础通信仓颉接口是在 OpenHarmony 上基于基础通信子系统能力之上封装的仓颉API。基础通信子系统旨在为OpenHarmony系统提供的通信相关的能力，包括：WLAN服务能力、蓝牙服务能力、软总线等通信能力。

蓝牙服务：为应用提供传统蓝牙以及低功耗蓝牙相关功能和服务。

WLAN服务：无线局域网（Wireless Local Area Networks，WLAN），是通过无线电、红外光信号或者其他技术发送和接收数据的局域网，用户可以通过WLAN实现结点之间无物理连接的网络通讯。常用于用户携带可移动终端的办公、公众环境中。

## 系统架构

**图 1**  基础通信仓颉架构图

![](figures/connectivity_cangjie_wrapper_architecture.png)

## 目录

基础通信仓颉主要代码目录结构如下：

```
foundation/communication/connectivity_cangjie_wrapper
├── figures             # 存放README中的架构图
├── kit                 # 仓颉kit化代码
│   └── ConnectivityKit # 仓颉ConnectivityKit实现
└── ohos                # 仓颉基础通信接口实现
    ├── bluetooth       # 仓颉蓝牙接口实现
    └── wifi_manager    # 仓颉wifi接口实现
```

## 约束

当前开放的基础通信仓颉接口仅支持standard设备。

## 使用说明

### 蓝牙接口

蓝牙相关接口，目前提供BLE相关的能力，包括BLE设备gatt相关的操作，以及BLE广播、扫描等功能。

-   BLE（低功耗蓝牙）

BLE是Bluetooth Low Energy的缩写，意为“低功耗蓝牙”。它是一种能够在低功耗情况下进行通信的蓝牙技术，与传统蓝牙相比，BLE的功耗更低，适用于需要长时间运行的低功耗设备，如智能手表、健康监测设备、智能家居等。

详情请参见 [ohos.bluetooth.ble API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-ble.md)。

-   A2DP（高级音频分发配置文件）

A2DP是Advanced Audio Distribution Profile的缩写，即高级音频分发配置文件。它是一种蓝牙协议，允许无线传输高品质音频流，例如音乐或语音通话，同时支持双向通信，因此可以用于耳机、扬声器、汽车音响等设备。

与ArkTs相比暂未提供蓝牙连接模块相关功能。

### Wifi接口

WLAN相关接口为用户提供WLAN基础功能、P2P（peer-to-peer）功能和WLAN消息通知的相应服务，让应用可以通过WLAN和其他设备互联互通。

-   P2P模式

P2P模式即为Wi-Fi Direct；Wi-Fi Direct 是一种点对点连接技术，它可以在两台 STA 之间直接建立 TCP/IP 链接，并不需要AP的参与；其中一台STA会起到传统意义上的AP的作用，称为Group Owner(GO)，另外一台station则称为Group Client(GC)，像连接AP一样连接到GO。

详情请参见 [ohos.wifi_manager API参考](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-wifi_manager.md)。

与ArkTs相比暂未提供STA模式、AP模式相关功能。

## 相关仓

[communication\_bluetooth](https://gitee.com/openharmony/communication_bluetooth/blob/master/README_zh.md)

[communication\_wifi](https://gitee.com/openharmony/communication_wifi/blob/master/README_zh.md)
