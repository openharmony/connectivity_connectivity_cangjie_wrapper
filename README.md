# connectivity_cangjie_wrapper

## Introduction

The connectivity_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the capabilities of the Distributed Connectivity Subsystem. The Connectivity subsystem provides the following communication capabilities for OpenHarmony, The basic communication Cangjie interface is only available for standard devices.

Bluetooth services: Provide traditional Bluetooth and low-energy Bluetooth related functions and services for applications.

WLAN services: Wireless Local Area Network (Wireless Local Area Networks, WLAN) is a local area network that sends and receives data through radio, infrared light signals or other technologies. Users can realize network communication between nodes without physical connection through WLAN. Commonly used in office and public environments where users carry mobile terminals.

## System Architecture

**Figure 1**

![](figures/connectivity_cangjie_wrapper_architecture_en.png)

As shown in the architecture diagram:

- Low-Power Bluetooth Wrapper: A Bluetooth technology that can communicate in low power consumption situations.
- Bluetooth Profile Wrapper: A universal file transfer protocol based on Bluetooth that allows file transfer between devices, such as a2dp, hfp, etc.
- Bluetooth Constants: Public constant definitions related to Bluetooth.
- Basic WLAN Functionality Wrapper: Provides P2P functionality, a point-to-point connection technology that can directly establish a TCP/IP link between two STAs.
- Cangjie Basic Communication FFI Interface: Responsible for defining the C language interoperation interface called by the Cangjie language to call basic communication service capabilities.
- Cangjie ark interop: Encapsulates public interfaces for C language interoperation, and provides Cangjie tag class implementation for annotating Cangjie APIs, as well as providing BusinessException exception class definitions thrown to users.
- Bluetooth Communication Services: Calls the underlying Bluetooth driver to provide relevant C language interfaces for accessing and using Bluetooth, including BLE device gatt-related operations, as well as BLE broadcasting, scanning and other functions.
- WLAN Services: Calls the underlying Wi-Fi driver to provide WLAN-related functional C language interfaces, including WLAN basic functions, WLAN message notifications, WLAN P2P mode and other functions.
- Cangjie DFX: Responsible for providing log interfaces for printing logs at critical paths.

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

Compared with the API capabilities provided by ArkTS, Bluetooth socket module-related functions are not yet provided.

-   HFP (Hands-Free Profile) is a Bluetooth hands-free protocol that allows Bluetooth devices to control the calls of the peer Bluetooth device, such as Bluetooth headsets controlling the answering, hanging up, rejecting, and voice dialing of mobile phone calls.

For details, please refer to [hfp API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-bluetooth-hfp.md)。

For relevant guidance, please refer to [Overview of Bluetooth Service Development](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/Dev_Guide/source_en/connectivity/bluetooth/cj-bluetooth-overview.md)

### Wifi api

WLAN-related api provide users with WLAN basic functions, peer-to-peer (P2P) functions, and corresponding services such as WLAN message notifications, so that applications can be interconnected with other devices through WLAN.

#### P2P mode

The P2P mode is also called Wi-Fi Direct, which allows two devices to establish a direct Wi-Fi connection without an intermediary wireless access point (AP). It can set up a TCP/IP connection between two STAs without an AP. Of the two STAs, one is called the group owner (GO), which serves as a traditional AP. the other is called a group client (GC), which connects to the GO like an AP.

For details, see [wifi API](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_en/apis/ConnectivityKit/cj-apis-wifi_manager.md)。

Compared with the API capabilities provided by ArkTS, STA mode and AP mode are not available.

## Code Contribution

Developers are welcome to contribute code, documentation, etc. For specific contribution processes and methods, please refer to [Code Contribution](https://gitcode.com/openharmony/docs/blob/master/en/contribute/code-contribution.md).

## Repositories Involved

[communication_bluetooth](https://gitcode.com/openharmony/communication_bluetooth/blob/master/README.md)

[communication_wifi](https://gitcode.com/openharmony/communication_wifi/blob/master/README.md)

[arkcompiler_cangjie_ark_interop](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/README.md)

[hiviewdfx_hiviewdfx_cangjie_wrapper](https://gitcode.com/openharmony-sig/hiviewdfx_hiviewdfx_cangjie_wrapper/blob/master/README.md)