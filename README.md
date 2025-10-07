# connectivity_cangjie_wrapper(beta feature)

## Introduction

The connectivity_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony for application developers to use Bluetooth services and WLAN service capabilities. The currently open basic communication Cangjie interface only supports standard devices.

Bluetooth services: Provide traditional Bluetooth and low-energy Bluetooth related functions and services for applications.

WLAN services: Wireless Local Area Network (Wireless Local Area Networks, WLAN) is a local area network that sends and receives data through radio, infrared light signals or other technologies. Users can realize network communication between nodes without physical connection through WLAN. Commonly used in office and public environments where users carry mobile terminals.

## System Architecture

**Figure 1**

![](figures/connectivity_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram:

Interface layer description:

- Low-Power Bluetooth Interface: Cangjie public interfaces based on low-power Bluetooth encapsulation exposed to developers.
- Bluetooth Profile Interface: Cangjie public interfaces based on Bluetooth Profile encapsulation exposed to developers.
- Bluetooth Constant Interface: Cangjie public interfaces based on Bluetooth constants exposed to developers.
- Basic WLAN Functionality Interface: Cangjie public interfaces based on WLAN basic functionality encapsulation exposed to developers.

Framework layer description:

- Low-Power Bluetooth Wrapper: Bluetooth Low Energy is a Bluetooth technology that can communicate in low power consumption situations. This encapsulation layer is a Cangjie encapsulation implementation of low-power Bluetooth functionality based on the Bluetooth component.
- Bluetooth Profile Wrapper: Bluetooth Profile is a universal file transfer protocol based on Bluetooth that allows file transfer between devices, such as a2dp, hfp, etc. This encapsulation layer is a Cangjie encapsulation implementation of Bluetooth Profile functionality based on the Bluetooth component.
- Bluetooth Constants: Defines public constants related to Bluetooth.
- Basic WLAN Functionality Wrapper: Provides P2P (peer-to-peer) functionality, a point-to-point connection technology that can directly establish a TCP/IP link between two STAs. This encapsulation layer is a Cangjie encapsulation implementation of WLAN basic functionality based on the WLAN component.

Cangjie Basic Communication Service Dependencies:

- Bluetooth Component: Calls the underlying Bluetooth driver to provide relevant functions for accessing and using Bluetooth that can be called by the basic communication Cangjie interface, including BLE device gatt-related operations, as well as BLE broadcasting, scanning and other functions.
- WLAN Component: Calls the underlying Wi-Fi driver to provide WLAN-related functional C language interfaces that can be called by the basic communication Cangjie interface, including WLAN basic functions, WLAN message notifications, WLAN P2P mode and other functions.
- cangjie_ark_interop: Encapsulates public interfaces for C language interoperation, and provides Cangjie tag class implementation for annotating Cangjie APIs, as well as providing BusinessException exception class definitions thrown to users.
- hiviewdfx_cangjie_wrapper: Responsible for providing log interfaces, providing Cangjie interfaces that can be called by the basic communication Cangjie interface to print logs at critical paths.

## Directory Structure

The connectivity cangjie wrapper directory structure is as follows:

```
foundation/communication/connectivity_cangjie_wrapper
├── figures                          # architecture pictures
├── kit                              # kit code
│   └── ConnectivityKit              # Cangjie ConnectivityKit code implementation
├── ohos                             # Cangjie connectivity code
│   ├── bluetooth                    # Cangjie bluetooth code implementation
│   │   ├── a2dp                     # a2dp Profile interfaces
│   │   ├── base_profile             # Bluetooth base profile interfaces
│   │   ├── ble                      # Bluetooth Low Energy interfaces
│   │   ├── connection               # Bluetooth connection interfaces
│   │   ├── constant                 # Bluetooth constant definitions
│   │   ├── error_message.cj         # Bluetooth error message definitions
│   │   └── hfp                      # hfp Profile interfaces
│   └── wifi_manager                 # Cangjie wifi code implementation
└── test                             # Test code
    ├── bluetooth                    # Bluetooth UT tests
    │   └── test                     # Bluetooth test project
    └── wifi_manager                 # WiFi UT tests
        └── test                     # WiFi test project
```

## Usage

### bluetooth api

Bluetooth-related interfaces currently provide BLE-related capabilities, as well as various device Profile-related capabilities.

-   BLE（Bluetooth Low Energy）

Bluetooth Low Energy (BLE) is a wireless, low-power Bluetooth technology. Compared with Classic Bluetooth, BLE allows for lower power consumption and is applicable to devices with long standby time, such as smart watches, healthcare devices, smart home devices.

For details, please refer to [ble API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-bluetooth-ble.md)。

-   A2DP（Advanced Audio Distribution Profile）

Advanced Audio Distribution Profile (A2DP) allows high-quality multimedia audio (such as music and voice) to be streamed between devices over a Bluetooth connection. It supports bidirectional communication and can be used in devices such as headsets, speakers, and car audio devices.

For details, please refer to [a2dp API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-bluetooth-a2dp.md)。

-   HFP (Hands-Free Profile) is a Bluetooth hands-free protocol that allows Bluetooth devices to control the calls of the peer Bluetooth device, such as Bluetooth headsets controlling the answering, hanging up, rejecting, and voice dialing of mobile phone calls.

For details, please refer to [hfp API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-bluetooth-hfp.md)。

For relevant guidance, please refer to [Overview of Bluetooth Service Development](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/connectivity/bluetooth/cj-bluetooth-overview.md)

### Wifi api

WLAN-related api provide users with P2P functions

The P2P mode is also called Wi-Fi Direct, which allows two devices to establish a direct Wi-Fi connection without an intermediary wireless access point (AP). It can set up a TCP/IP connection between two STAs without an AP. Of the two STAs, one is called the group owner (GO), which serves as a traditional AP. the other is called a group client (GC), which connects to the GO like an AP.

For details, see [wifi API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-wifi_manager.md)。

For relevant guidance, please refer to [WLAN Development Guide](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/connectivity/wifi/cj-wifi-development-guide.md)

## Constraints

Compared with the API capabilities provided by ArkTS, the following functions are not supported:

- Bluetooth services do not yet provide Bluetooth socket, hid, pan, pbap, map Profile related functions.
- Wifi services do not yet provide STA mode and AP mode related functions.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[communication_bluetooth](https://gitcode.com/openharmony/communication_bluetooth/blob/master/README.md)

[communication_wifi](https://gitcode.com/openharmony/communication_wifi/blob/master/README.md)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/README.md)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper/blob/master/README.md)