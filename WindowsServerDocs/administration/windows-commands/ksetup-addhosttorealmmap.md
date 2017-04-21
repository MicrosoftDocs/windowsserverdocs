---
title: ksetup:addhosttorealmmap
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 237742d5-fa68-466c-b97e-636f489248ea
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# ksetup:addhosttorealmmap

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

adds a service principal name (SPN) mapping between the stated host and the realm. For examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
ksetup /addhosttorealmmap <hostname> <RealmName>
```
### Parameters
|Parameter|Description|
|-------|--------|
|<hostname>|The host name is the computer name, and it can be stated as the computer's fully qualified domain name.|
|<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM.|
## remarks
This command allows you to map a host or multiple hosts that are sharing the same DNS suffix to the realm.
The mapping is recorded in the registry in **HKEY_LOCAL_MACHINE\SYSTEM\CurrentContolSet\Lsa\Kerberos\HostToRealm**.
## <a name="BKMK_Examples"></a>Examples
As part of configuring the realm CONTOSO, map the host computer IPops897 to the realm:
```
ksetup /addhosttorealmmap IPops897 CONTOSO
```
verify in the registry that the mapping is as intended.
## additional references
-   [ksetup:delhosttorealmmap](ksetup-delhosttorealmmap.md)
-   [ksetup](ksetup.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
