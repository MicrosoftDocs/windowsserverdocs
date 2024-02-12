---
title: scwcmd analyze
description: Reference article for the scwcmd analyze command, which determines whether a computer is in compliance with a policy.
ms.topic: reference
ms.assetid: 0259271b-be5b-48d7-a51d-8b9b6786efb4
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# scwcmd analyze

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2012 R2 and Windows Server 2012

Determines whether a computer is in compliance with a policy. Results are returned in an .xml file.

This command also accepts a list of computer names as input. To view the results in your browser, use **scwcmd view** and specify `%windir%\security\msscw\TransformFiles\scwanalysis.xsl` as the .xsl transform.

## Syntax

```
scwcmd analyze [[[/m:<computername> | /ou:<OuName>] /p:<policy>] | /i:<computerlist>] [/o:<resultdir>] [/u:<username>] [/pw:<password>] [/t:<threads>] [/l] [/e]
```

### Parameters

| Parameter | Description |
|--|--|
| /m:`<computername>` | Specifies the NetBIOS name, DNS name, or IP address of the computer to analyze. If the **/m** parameter is specified, then the **/p** parameter must also be specified. |
| /ou:`<OuName>` | Specifies the fully qualified domain name (FQDN) of an organizational unit (OU) in Active Directory Domain Services. If the **/ou** parameter is specified, then the **/p** parameter must also be specified. All computers in the OU will be analyzed against the given policy. |
| /p:`<policy>` | Specifies the path and file name of the .xml policy file to be used to perform the analysis. |
| /i:`<computerlist>` | Specifies the path and file name of an .xml file that contains a list of computers along with their expected policy files. All computers in the .xml file will be analyzed against their corresponding policy files. A sample .xml file is `%windir%\security\SampleMachineList.xml`. |
| /o:`<resultdir>` | Specifies the path and directory where the analysis result files should be saved. The default is the current directory. |
| /u:`<username>` | Specifies an alternate user credential to use when performing the analysis on a remote computer. The default is the logged on user. |
| /pw:`<password>` | Specifies an alternate user credential to use when performing the analysis on a remote computer. The default is the password of the logged on user. |
| /t:`<threads>` | Specifies the number of simultaneous outstanding analysis operations that should be maintained during the analysis. The value range is 1-1000, with a default value of 40. |
| /l | Causes the analysis process to be logged. One log file will be generated for each computer being analyzed. The log files will be stored in the same directory as the result files. Use the **/o** option to specify the directory for the result files. |
| /e | Log an event to the Application Event log if a mismatch is found. |
| /? | Displays help at the command prompt. |

## Examples

To analyze a security policy against the file *webpolicy.xml*, type:

```
scwcmd analyze /p:webpolicy.xml
```

To analyze a security policy on the computer named *webserver* against the file *webpolicy.xml* by using the credentials of the *webadmin* account, type:

```
scwcmd analyze /m:webserver /p:webpolicy.xml /u:webadmin
```

To analyze a security policy against the file *webpolicy.xml*, with a *maximum of 100 threads*, and output the results to a file named results in the *resultserver* share, type:

```
scwcmd analyze /i:webpolicy.xml /t:100 /o:\\resultserver\results
```

To analyze a security policy for the *WebServers OU* against the file *webpolicy.xml* by using the *DomainAdmin* credentials, type:

```
scwcmd analyze /ou:OU=WebServers,DC=Marketing,DC=ABCCompany,DC=com /p:webpolicy.xml /u:DomainAdmin
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [scwcmd configure command](scwcmd-configure.md)

- [scwcmd register command](scwcmd-register.md)

- [scwcmd rollback command](scwcmd-rollback.md)

- [scwcmd transform command](scwcmd-transform.md)

- [scwcmd view command](scwcmd-view.md)
