---
title: ksetup:delrealmflags
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 22053041-1eb4-47f5-bed9-3d5681bcde7d
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# ksetup:delrealmflags

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

removes realm flags from the specified realm.  for examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
ksetup /delrealmflags <RealmName> [sendaddress] [tcpsupported] [delegate] [ncsupported] [rc4]
```
### Parameters
|Parameter|Description|
|-------|--------|
|<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and is listed as the default realm when **ksetup** is run.|
## remarks
The realm flags specify additional features of a Kerberos realm that is not based on the Windows Server operating system. Computers that are running Windows Server 2003,  Windows Server 2008 , or  Windows Server 2008 R2  can use a Kerberos server to administer authentication instead of using a domain that is running a Windows Server operating system, and these systems participate in a Kerberos realm. This entry establishes the features of the realm. The following table describes each.
|Value|Realm flag|Description|
|-----|-------|--------|
|0xF|All|All realm flags are set.|
|0x00|None|No realm flags are set, and no additional features are enabled.|
|0x01|Sendaddress|The IP address will be included within the ticket-granting-tickets.|
|0x02|TcpSupported|Both the Transmission Control Protocol (TCP) and the User Datagram Protocol (UDP) are supported in this realm.|
|0x04|delegate|Everyone in this realm is trusted for delegation.|
|0x08|NcSupported|This realm supports name canonicalization, which allows for DNS and Realm naming standards.|
|0x80|RC4|This realm supports RC4 encryption to enable cross-realm trust, which allows for the use of TLS.|
Realm flags are stored in the registry in **HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Domains\\***RealmName*. This entry does not exist in the registry by default. You can use the [ksetup:addrealmflags](ksetup-addrealmflags.md) command to populate the registry.
You can see what realm flags are available and set by viewing the output of **ksetup** or **ksetup /dumpstate**.
## <a name="BKMK_Examples"></a>Examples
list the available realm flags for the realm CONTOSO:
```
ksetup /listrealmflags
```
remove two flags that are currently in the set:
```
ksetup /delrealmflags CONTOSO ncsupported delegate
```
Run the **ksetup** command to verify that the realm flag is set by viewing the output and looking for **Realm flags =**.
## additional references
-   [ksetup:listrealmflags](ksetup-listrealmflags.md)
-   [ksetup:setrealmflags](ksetup-setrealmflags.md)
-   [ksetup:addrealmflags](ksetup-addrealmflags.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
