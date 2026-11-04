/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 */

// The Cangjie API is in Beta. For details on its capabilities and limitations, please refer to the README file.

package ohos.wifi_manager

import ohos.business_exception.BusinessException

func wifiSecurityTypeValue(v: WifiSecurityType): Int32 {
    match (v) {
        case WifiSecTypeInvalid => 0
        case WifiSecTypeOpen => 1
        case WifiSecTypeWep => 2
        case WifiSecTypePsk => 3
        case WifiSecTypeSae => 4
        case WifiSecTypeEap => 5
        case WifiSecTypeEapSuiteB => 6
        case WifiSecTypeOwe => 7
        case WifiSecTypeWapiCert => 8
        case WifiSecTypeWapiPsk => 9
        case _ => 0
    }
}

func eapMethodValue(v: EapMethod): Int32 {
    match (v) {
        case EapNone => 0
        case EapPeap => 1
        case EapTls => 2
        case EapTtls => 3
        case EapPwd => 4
        case EapSim => 5
        case EapAka => 6
        case EapAkaPrime => 7
        case EapUnauthTls => 8
        case _ => throw BusinessException(2501007, "Parameter validation failed.")
    }
}

func phase2MethodValue(v: Phase2Method): Int32 {
    match (v) {
        case Phase2None => 0
        case Phase2Pap => 1
        case Phase2Mschap => 2
        case Phase2Mschapv2 => 3
        case Phase2Gtc => 4
        case Phase2Sim => 5
        case Phase2Aka => 6
        case Phase2AkaPrime => 7
        case _ => throw BusinessException(2501007, "Parameter validation failed.")
    }
}

func wapiPskTypeValue(v: WapiPskType): Int32 {
    match (v) {
        case WapiPskAscii => 0
        case WapiPskHex => 1
        case _ => throw BusinessException(2501007, "Parameter validation failed.")
    }
}

func wifiBandTypeValue(v: WifiBandType): Int32 {
    match (v) {
        case WifiBandNone => 0
        case WifiBand2g => 1
        case WifiBand5g => 2
        case WifiBand6g => 3
        case WifiBand60g => 4
        case _ => throw BusinessException(2501007, "Parameter validation failed.")
    }
}

