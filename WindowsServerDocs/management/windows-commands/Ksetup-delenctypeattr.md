---
title: Ksetup:delenctypeattr
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fc25ef3-e271-4229-a712-72c507df55aaauthor: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Ksetup:delenctypeattr
Removes the encryption type attribute for the domain. For examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
ksetup /delenctypeattr <DomainName> 
```
### Parameters
|Parameter|Description|
|-------------|---------------|
|<DomainName>|Name of the domain to which you want to establish a connection. Use the fully qualified domain name or a simple form of the name, such as corp.contoso.com or contoso.|
## Remarks
To view the encryption type for the Kerberos ticket-granting ticket (TGT) and the session key, run the **klist** command and view the output.
A status message is displayed upon successful or failed completion.
To set the domain that you want to connect to and use, run the **ksetup /domain <DomainName>** command.
## <a name="BKMK_Examples"></a>Examples
Determine the current encryption types that are set on this computer:
```
klist
```
Set the domain to mit.contoso.com:
```
ksetup /domain mit.contoso.com
```
Verify what the encryption type attribute is for the domain:
```
ksetup /getenctypeattr mit.contoso.com
```
Remove the set encryption type attribute for the domain mit.contoso.com:
```
ksetup /delenctypeattr mit.contoso.com
```
## Additional references
-   [Klist](Klist.md)
-   [Ksetup:domain](Ksetup-domain.md)
-   [Ksetup:addenctypeattr](Ksetup-addenctypeattr.md)
-   [Ksetup:setenctypeattr](Ksetup-setenctypeattr.md)
-   [Ksetup:delenctypeattr](Ksetup-delenctypeattr.md)
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
