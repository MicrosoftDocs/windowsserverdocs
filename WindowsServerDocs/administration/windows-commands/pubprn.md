---
title: pubprn
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0bc7f7e3-84e1-4359-b477-7b1a1a0bd639
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# pubprn

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Publishes a printer to the active directory Domain Services.

## Syntax
```
cscript pubprn {<ServerName> | <UNCprinterpath>} 
"LDAP://CN=<Container>,DC=<Container>"
```

## Parameters
|Parameter|Description|
|-------|--------|
|\<ServerName>|Specifies the name of the Windows server that hosts the printer that you want to publish. If you do not specify a computer, the local computer is used.|
|\<UNCprinterpath>|The Universal Naming Convention (UNC) path to the shared printer that you want to publish.|
|"LDAP://CN=<Container>,DC=<Container>"|Specifies the path to the container in active directory Domain Services where you want to publish the printer.|
|/?|Displays help at the command prompt.|

## Remarks
-   The **pubprn** command is a Visual Basic script located in the %WINdir%\System32\printing_Admin_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the pubprn file, or change directories to the appropriate folder. For example:
    ```
    cscript %WINdir%\System32\printing_Admin_Scripts\en-US\pubprn
    ```
-   if the information that you supply contains spaces, use quotation marks around the text (for example, `"computer Name"`).

## <a name="BKMK_examples"></a>Examples
To publish all printers on the \\\Server1 computer to the MyContainer container in the MyDomain.company.Com domain, type:
```
cscript Ppubprn Server1 "LDAP://CN=MyContainer,DC=MyDomain,DC=company,DC=Com"
```
To publish the Laserprinter1 printer on the \\\Server1 server to the MyContainer container in the MyDomain.company.Com domain, type:
```
cscript Ppubprn \\Server1\Laserprinter1 "LDAP://CN=MyContainer,DC=MyDomain,DC=company,DC=Com"
```

#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
[print Command Reference](print-command-reference.md)
