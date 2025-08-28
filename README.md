# connectivity_cangjie_wrapper

## Introduction

The communication_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the Distributed Connectivity Subsystem. The Connectivity subsystem provides the following communication capabilities for OpenHarmony:

- WLAN: basic WLAN functions, peer-to-peer (P2P) connection, and WLAN notification, enabling your application to communicate with other devices through a WLAN.

- Bluetooth: classic Bluetooth and Bluetooth Low Energy (BLE).

## System Architecture

**Figure 1**

![](figures/connectivity_cangjie_wrapper_architecture_en.png)

## Directory Structure

The DSoftBus directory structure is as follows:

```
foundation/communication/connectivity_cangjie_wrapper
├── figures             # architecture pictures
├── kit                 # Cangjie kit code
│   └── ConnectivityKit # Cangjie ConnectivityKit code implementation
└── ohos                # Cangjie DSoftBus code
    ├── bluetooth       # Cangjie bluetooth code implementation
    └── wifi_manager    # Cangjie wifi code implementation
```

## Constraints

The basic communication Cangjie interface is only available for standard devices.

## Usage

### bluetooth api

Bluetooth-related api, which currently provide BLE-related capabilities, including BLE device gatt-related operations, as well as BLE broadcasting, scanning and other functions.

-   BLE（Bluetooth Low Energy）

Bluetooth Low Energy (BLE) is a wireless, low-power Bluetooth technology. Compared with Classic Bluetooth, BLE allows for lower power consumption and is applicable to devices with long standby time, such as smart watches, healthcare devices, smart home devices.

For details, please refer to [ohos.bluetooth.ble API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-bluetooth-ble.md)。

-   A2DP（Advanced Audio Distribution Profile）

Advanced Audio Distribution Profile (A2DP) allows high-quality multimedia audio (such as music and voice) to be streamed between devices over a Bluetooth connection. It supports bidirectional communication and can be used in devices such as headsets, speakers, and car audio devices.

For details, please refer to [ohos.bluetooth.a2dp API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/ConnectivityKit/cj-apis-bluetooth-a2dp.md)。

Compared with ArkTs API, Bluetooth connection module-related functions are not yet provided.

For relevant guidance, please refer to [Overview of Bluetooth Service Development](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/connectivity/bluetooth/cj-bluetooth-overview.md)

### Wifi api

WLAN-related api provide users with WLAN basic functions, peer-to-peer (P2P) functions, and corresponding services such as WLAN message notifications, so that applications can be interconnected with other devices through WLAN.

-   P2P mode

The P2P mode is also called Wi-Fi Direct, which allows two devices to establish a direct Wi-Fi connection without an intermediary wireless access point (AP). It can set up a TCP/IP connection between two STAs without an AP. Of the two STAs, one is called the group owner (GO), which serves as a traditional AP; the other is called a group client (GC), which connects to the GO like an AP.

For details, see [ohos.wifi_manager API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-wifi_manager.md)。

Compared with ArkTs, STA mode and AP mode are not available.

## Repositories Involved

[communication\_bluetooth](https://gitee.com/openharmony/communication_bluetooth/blob/master/README.md)

[communication\_wifi](https://gitee.com/openharmony/communication_wifi/blob/master/README.md)

## Code Contribution

Participate in the community: [Cangjie Community](https://gitcode.com/Cangjie)

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).
