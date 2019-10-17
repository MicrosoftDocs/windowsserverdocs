---
title: Scwcmd configure
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6528b9dc-3d82-4228-b734-ed717458d74c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Scwcmd: configure

> Applies To: Windows Server 2012 R2, Windows Server 2012

Applies a Security Configuration Wizard (SCW)-generated security policy to a computer. This command-line tool also accepts a list of computer names as input.

## Syntax

```
scwcmd configure [[[/m:<ComputerName> | /ou:<OuName>] /p:<Policy>] | /i:<ComputerList>] [/u:<UserName>] [/pw:<Password>] [/t:<Threads>]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|/m:\<ComputerName>|Specifies the NetBIOS name, DNS name, or IP address of the computer to configure. If the **/m** parameter is specified, then the **/p** parameter must also be specified.|
|/ou:\<OuName>|Specifies the fully qualified domain name (FQDN) of an organizational unit (OU) in Active Directory Domain Services. If the **/ou** parameter is specified, then the **/p** parameter must also be specified. All computers in the OU will be analyzed according to the given policy.|
|/p:\<Policy>|Specifies the path and file name of the .xml policy file to be used to perform the configuration.|
|/i:\<ComputerList>|Specifies the path and file name of an .xml file that contains a list of computers along with their expected policy files. All computers in the .xml file will be configured according to their corresponding policy files. A sample .xml file is %windir%\security\SampleMachineList.xml.|
|/u:\<UserName>|Specifies an alternate user credential to use when configuring a remote computer. The default is the logged on user.|
|/pw:\<Password>|Specifies an alternate user credential to use when configuring a remote computer. The default is the password of the logged on user.|
|/t:\<Threads>|Specifies the number of simultaneous outstanding configuration operations that should be maintained during the configuration process (DefaultValue=40, MinValue=1, MaxValue=1000).|
|/?|Displays help at the command prompt.|

## Remarks

Scwcmd.exe is only available on computers running Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003.

## <a name="BKMK_Examples"></a>Examples

To configure a security policy against the file webpolicy.xml, type:
```
scwcmd configure /p:webpolicy.xml
```
To configure a security policy for the computer at 172.16.0.0 against the file webpolicy.xml by using the webadmin account credentials, type:
```
scwcmd configure /m:172.16.0.0 /p:webpolicy.xml /u:webadmin
```
To configure a security policy on all computers on the list campusmachines.xml with a maximum of 100 threads, type:
```
scwcmd configure /i:campusmachines.xml /t:100
```
To configure a security policy on all computers in the WebServers OU against the file webpolicy.xml by using the credentials of the DomainAdmin account, type:
```
scwcmd configure /ou:OU=WebServers,DC=Marketing,DC=ABCCompany,DC=com /p:webpolicy.xml /u:DomainAdmin
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)