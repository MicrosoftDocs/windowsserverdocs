---
title: secedit:export
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 49a8b241-aa8c-45b7-844d-67a29fab708e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# secedit:export



Exports security settings stored in a database configured with security templates. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
Secedit /export /db <database file name> [/mergedpolicy] /cfg <configuration file name> [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|db|Required.</br>Specifies the path and file name of a database that contains the stored configuration against which the analysis will be performed.</br>If file name specifies a database that has not had a security template (as represented by the configuration file) associated with it, the `/cfg \<configuration file name>` command-line option must also be specified.|
|mergedpolicy|Optional.</br>Merges and exports domain and local policy security settings.|
|cfg|Required.</br>Specifies the path and file name for the security template that will be imported into the database for analysis.</br>This /cfg option is only valid when used with the `/db \<database file name>` parameter. If this is not specified, the analysis is performed against any configuration already stored in the database.|
|areas|Optional.</br>Specifies the security areas to be applied to the system. If this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:</br>-   SecurityPolicy</br>    Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.</br>-   Group_Mgmt</br>    Restricted group settings for any groups specified in the security template.</br>-   User_Rights</br>    User logon rights and granting of privileges.</br>-   RegKeys</br>    Security on local registry keys.</br>-   FileStore</br>    Security on local file storage.</br>-   Services</br>    Security for all defined services.|
|log|Optional.</br>Specifies the path and file name of the log file for the process.|
|quiet|Optional.</br>Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (MMC).|

## Remarks

You can use this command to backup your security policies on a local computer in addition to importing the settings to another computer.

If the path for the log file is not provided, the default log file, (*systemroot*\Documents and Settings\*UserAccount<em>\My Documents\Security\Logs\*DatabaseName</em>.log) is used.

In Windows Server 2008, `Secedit /refreshpolicy` has been replaced with `gpupdate`. For information on how to refresh security settings, see [Gpupdate](gpupdate.md).

## <a name="BKMK_Examples"></a>Examples

Export the security database and the domain security policies to an inf file and then import that file to a different database in order to replicate the security policy settings on another computer.
```
Secedit /export /db C:\Security\FY11\SecDbContoso.sdb /mergedpolicy /cfg SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY11.log /quiet
```
Import that file to a different database on another computer.
```
Secedit /import /db C:\Security\FY12\SecDbContoso.sdb /cfg SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY12.log /quiet
```

#### Additional references

-   [Secedit:import](secedit-import.md)
-   [Secedit](secedit.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)