---
title: scwcmd configure
description: Reference article for the scwcmd configure command, which applies a Security Configuration Wizard (SCW)-generated security policy to a computer.
ms.topic: reference
ms.assetid: 6528b9dc-3d82-4228-b734-ed717458d74c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# scwcmd configure

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2012 R2 and Windows Server 2012

Applies a Security Configuration Wizard (SCW)-generated security policy to a computer. This command-line tool also accepts a list of computer names as input.

## Syntax

```
scwcmd configure [[[/m:<computername> | /ou:<OuName>] /p:<policy>] | /i:<computerlist>] [/u:<username>] [/pw:<password>] [/t:<threads>]
```

### Parameters

| Parameter | Description |
|--|--|
| /m:`<computername>` | Specifies the NetBIOS name, DNS name, or IP address of the computer to configure. If the **/m** parameter is specified, then the **/p** parameter must also be specified. |
| /ou:`<OuName>` | Specifies the fully qualified domain name (FQDN) of an organizational unit (OU) in Active Directory Domain Services. If the **/ou** parameter is specified, then the **/p** parameter must also be specified. All computers in the OU will be configured against the given policy. |
| /p:`<policy>` | Specifies the path and file name of the .xml policy file to be used to perform the configuration. |
| /i:`<computerlist>` | Specifies the path and file name of an .xml file that contains a list of computers along with their expected policy files. All computers in the .xml file will be analyzed against their corresponding policy files. A sample .xml file is `%windir%\security\SampleMachineList.xml`. |
| /u:`<username>` | Specifies an alternate user credential to use when performing the configuration on a remote computer. The default is the logged on user. |
| /pw:`<password>` | Specifies an alternate user credential to use when performing the configuration on a remote computer. The default is the password of the logged on user. |
| /t:`<threads>` | Specifies the number of simultaneous outstanding configuration operations that should be maintained during the analysis. The value range is 1-1000, with a default value of 40. |
| /l | Causes the analysis process to be logged. One log file will be generated for each computer being analyzed. The log files will be stored in the same directory as the result files. Use the **/o** option to specify the directory for the result files. |
| /e | Log an event to the Application Event log if a mismatch is found. |
| /? | Displays help at the command prompt. |

## Examples

To configure a security policy against the file *webpolicy.xml*, type:

```
scwcmd configure /p:webpolicy.xml
```

To configure a security policy for the computer at *172.16.0.0* against the file *webpolicy.xml* by using the credentials of the *webadmin* account, type:

```
scwcmd configure /m:172.16.0.0 /p:webpolicy.xml /u:webadmin
```

To configure a security policy  on all computers on the list *campusmachines.xml* with a *maximum of 100 threads*, type:

```
scwcmd configure /i:campusmachines.xml /t:100
```

To configure a security policy for the *WebServers OU* against the file *webpolicy.xml* by using the *DomainAdmin* credentials, type:

```
scwcmd configure /ou:OU=WebServers,DC=Marketing,DC=ABCCompany,DC=com /p:webpolicy.xml /u:DomainAdmin
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [scwcmd analyze command](scwcmd-analyze.md)

- [scwcmd register command](scwcmd-register.md)

- [scwcmd rollback command](scwcmd-rollback.md)

- [scwcmd transform command](scwcmd-transform.md)

- [scwcmd view command](scwcmd-view.md)
