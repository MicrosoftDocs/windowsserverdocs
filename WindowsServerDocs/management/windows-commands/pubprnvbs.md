---
title: pubprnvbs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0bc7f7e3-84e1-4359-b477-7b1a1a0bd639
---
# pubprnvbs
Publishes a printer to the active directory Domain Services.

for examples of how this command can be used, see [Examples](#BKMK_examples).

## Syntax

```
cscript pubprnvbs {<ServerName> | <UNCprinterpath>} 
"LDAP://CN=<Container>,DC=<Container>"
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<ServerName>|Specifies the name of the Windows server that hosts the printer that you want to publish. if you do not specify a computer, the local computer is used.|
|<UNCprinterpath>|The Universal Naming Convention \(UNC\) path to the shared printer that you want to publish.|
|"LDAP:\/\/CN\=<Container>,DC\=<Container>"|Specifies the path to the container in active directory Domain Services where you want to publish the printer.|
|\/?|Displays help at the command prompt.|

## remarks

-   The **pubprnvbs** command is a Visual Basic script located in the %WINdir%\\System32\\printing\_Admin\_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the pubprnvbs file, or change directories to the appropriate folder. for example:

    ```
    cscript %WINdir%\System32\printing_Admin_Scripts\en-US\pubprnvbs
    ```

-   if the information that you supply contains spaces, use quotation marks around the text \(for example, `"computer Name"`\).

## <a name="BKMK_examples"></a>Examples
To publish all printers on the \\\\Server1 computer to the MyContainer container in the MyDomain.company.Com domain, type:

```
cscript Ppubprnvbs Server1 "LDAP://CN=MyContainer,DC=MyDomain,DC=company,DC=Com"
```

To publish the Laserprinter1 printer on the \\\\Server1 server to the MyContainer container in the MyDomain.company.Com domain, type:

```
cscript Ppubprnvbs \\Server1\Laserprinter1 "LDAP://CN=MyContainer,DC=MyDomain,DC=company,DC=Com"
```

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[print Command Reference](commands-by-server-role/print-command-reference.md)


