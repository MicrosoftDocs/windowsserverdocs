---
title: ksetup:delhosttorealmmap
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3faee482-a96c-4614-86fd-aaa446643ec4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# ksetup:delhosttorealmmap

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

removes a service principal name (SPN) mapping between the stated host and the realm. For examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
ksetup /delhosttorealmmap <hostname> <RealmName>
```
### Parameters
|Parameter|Description|
|-------|--------|
|<hostname>|The host name is the computer name, and it can be stated as the computer's fully qualified domain name.|
|<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM.|
## remarks
When a host to realm (or multiple hosts to realm) mapping exists, this command removes that mapping.
The mapping is recorded in the registry in **HKEY_LOCAL_MACHINE\SYSTEM\CurrentContolSet\Lsa\Kerberos\HostToRealm**. You should verify the mapping in the registry after using this command.
## <a name="BKMK_Examples"></a>Examples
Altering the configuration of the realm CONTOSO, delete the mapping of the host computer IPops897 to the realm:
```
ksetup /delhosttorealmmap IPops897 CONTOSO
```
After running this command, you can verify in the registry that the mapping is as intended.
## additional references
-   [ksetup:addhosttorealmmap](ksetup-addhosttorealmmap.md)
-   [ksetup](ksetup.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
