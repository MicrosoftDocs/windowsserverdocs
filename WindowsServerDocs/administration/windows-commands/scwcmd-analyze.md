---
title: Scwcmd analyze
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0259271b-be5b-48d7-a51d-8b9b6786efb4
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# Scwcmd: analyze

> Applies To: Windows Server 2012 R2, Windows Server 2012

Determines whether a computer is in compliance with a policy. Results are returned in an .xml file. Also accepts a list of computer names as input. To view the results in your browser, use **scwcmd view** and specify **%windir%\security\msscw\TransformFiles\scwanalysis.xsl** as the .xsl transform. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
scwcmd analyze [[[/m:<ComputerName> | /ou:<Ou>] /p:<Policy>] | /i:<ComputerList>] [/o:
<ResultDir>] [/u:<UserName>] [/pw:<Password>] [/t:<Threads>] [/l] [/e]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|/m:\<ComputerName>|Specifies the NetBIOS name, DNS name, or IP address of the computer to analyze. If the **/m** parameter is specified, then the **/p** parameter must also be specified.|
|/ou:\<OuName>|Specifies the fully qualified domain name (FQDN) of an organizational unit (OU) in Active Directory Domain Services. If the **/ou** parameter is specified, then the **/p** parameter must also be specified. All computers in the OU will be analyzed against the given policy.|
|/p:\<Policy>|Specifies the path and file name of the .xml policy file to be used to perform the analysis.|
|/i:\<ComputerList>|Specifies the path and file name of an .xml file that contains a list of computers along with their expected policy files. All computers in the .xml file will be analyzed against their corresponding policy files. A sample .xml file is %windir%\security\SampleMachineList.xml.|
|/o:\<ResultDir>|Specifies the path and directory where the analysis result files should be saved. The default is the current directory.|
|/u:\<UserName>|Specifies an alternate user credential to use when performing the analysis on a remote computer. The default is the logged on user.|
|/pw:\<Password>|Specifies an alternate user credential to use when performing the analysis on a remote computer. The default is the password of the logged on user.|
|/t:\<Threads>|Specifies the number of simultaneous outstanding analysis operations that should be maintained during the analysis (DefaultValue=40, MinValue=1, MaxValue=1000).|
|/l|Causes the analysis process to be logged. One log file will be generated for each computer being analyzed. The log files will be stored in the same directory as the result files. Use the **/o** option to specify the directory for the result files.|
|/e|Log an event to the Application Event log if a mismatch is found.|
|/?|Displays help at the command prompt.|

## Remarks

Scwcmd.exe is only available on computers running Windows Server 2008 R2, Windows Server 2008, or Windows Server 2003.

## <a name="BKMK_Examples"></a>Examples

To analyze a security policy against the file webpolicy.xml, type:
```
scwcmd analyze /p:webpolicy.xml

```
To analyze a security policy on the computer named webserver against the file webpolicy.xml by using the credentials of the webadmin account, type:
```
scwcmd analyze /m:webserver /p:webpolicy.xml /u:webadmin

```
To analyze a security policy against the file webpolicy.xml, with a maximum of 100 threads, and output the results to a file named results in the resultserver share, type:
```
scwcmd analyze /i:webpolicy.xml /t:100 /o:\\resultserver\results

```
To analyze a security policy for the WebServers OU against the file webpolicy.xml by using the DomainAdmin credentials, type:
```
scwcmd analyze /ou:OU=WebServers,DC=Marketing,DC=ABCCompany,DC=com /p:webpolicy.xml /u:DomainAdmin
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)