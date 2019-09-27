---
title: bitsadmin util and setieproxy
description: "Windows Commands topic for **bitsadmin util and setieproxy** - Set proxy settings to use when transferring files using a service account."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e9f31ba-3070-4ffd-a94c-388c8d78f688
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# bitsadmin util and setieproxy

Set proxy settings to use when transferring files using a service account.

**BITSAdmin 1.5 and earlier**: Not supported.

## Syntax

```
bitsadmin /Util /SetIEProxy <Account> <Usage>[/Conn <ConnectionName>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|Account|Specifies the type of service account whose proxy settings you want to define. Possible values are:</br>-   LOCALSYSTEM</br>-   NETWORKSERVICE</br>-   LOCALSERVICE|
|Usage|Specifies the form of proxy detection to use. Possible values are:</br>-   NO_PROXY—Do not use a proxy server.</br>-   AUTODETECT—Automatically detect the proxy settings.</br>-   MANUAL_PROXY—Use an explicit proxy list and bypass list. Specify the proxy list and bypass list immediately following the usage tag. For example, MANUAL_PROXY proxy1,proxy2 NULL.</br>    -   The proxy list is a comma-delimited list of proxy servers to use.</br>    -   The bypass list is a space-delimited list of host names or IP addresses, or both, for which transfers are not to be routed through a proxy. This can be \<local> to refer to all servers on the same LAN. Values of NULL or "" may be used for an empty proxy bypass list.</br>-   AUTOSCRIPT— Same as AUTODETECT, except it also executes a script. Specify the script URL immediately following the usage tag. For example, AUTOSCRIPT http://server/proxy.js.</br>-   RESET— Same as NO_PROXY, except it removes the manual proxy URLs (if specified) and URLs discovered using automatic detection.|
|ConnectionName|Optional—used with the **/Conn** parameter to specify the modem connection to use. If you do not specify the **/Conn** parameter, BITS uses the LAN connection. Specify the modem connection name immediately following the **/Conn** parameter.|

## Remarks

Each successive call using this switch replaces the previously specified usage but not the parameters of the previously defined usage. For example, if you specify NO_PROXY, AUTODETECT, and MANUAL_PROXY on separate calls, BITS uses the last supplied usage but keeps the parameters from the previously defined usage.

> [!IMPORTANT]
> You must run this command from an elevated command prompt for it to complete successfully.

## Examples

The following example sets the proxy usage for the NETWORK SERVICE account.

```
C:\>bitsadmin /Util /SetIEProxy localsystem AUTODETECT
```

Here are more examples.

```
bitsadmin /util /setieproxy localsystem MANUAL_PROXY proxy1,proxy2,proxy3 NULL
bitsadmin /util /setieproxy localsystem MANUAL_PROXY proxy1:80 ""
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)