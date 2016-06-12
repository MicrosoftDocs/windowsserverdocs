---
title: secedit:export
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 49a8b241-aa8c-45b7-844d-67a29fab708e
---
# secedit:export
Exports security settings stored in a database configured with security templates. for examples of how this command can be used, see [Examples](seceditexport.md#BKMK_Examples).

## Syntax

```
secedit /export /db <database file name> [/mergedpolicy] /cfg <configuration file name> [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|db|Required.<br /><br />Specifies the path and file name of a database that contains the stored configuration against which the analysis will be performed.<br /><br />if file name specifies a database that has not had a security template \(as represented by the configuration file\) associated with it, the `/cfg <configuration file name>` command\-line option must also be specified.|
|mergedpolicy|Optional.<br /><br />Merges and exports domain and local policy security settings.|
|cfg|Required.<br /><br />Specifies the path and file name for the security template that will be imported into the database for analysis.<br /><br />This \/cfg option is only valid when used with the `/db <database file name>` parameter. if this is not specified, the analysis is performed against any configuration already stored in the database.|
|areas|Optional.<br /><br />Specifies the security areas to be applied to the system. if this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:<br /><br />-   SecurityPolicy<br />    Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.<br />-   Group\_Mgmt<br />    Restricted group settings for any groups specified in the security template.<br />-   User\_Rights<br />    User logon rights and granting of privileges.<br />-   regKeys<br />    Security on local registry keys.<br />-   FileStore<br />    Security on local file storage.<br />-   Services<br />    Security for all defined services.|
|log|Optional.<br /><br />Specifies the path and file name of the log file for the process.|
|quiet|Optional.<br /><br />Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap\-in to the Microsoft management Console \(mmc\).|

## remarks
You can use this command to backup your security policies on a local computer in addition to importing the settings to another computer.

if the path for the log file is not provided, the default log file, \(*systemroot*\\Documents and Settings\\*UserAccount*\\My Documents\\Security\\Logs\\*DatabaseName*.log\) is used.

In Windows Server 2008, `secedit /refreshpolicy` has been replaced with `gpupdate`. for information on how to refresh security settings, see [gpupdate]().

## <a name="BKMK_Examples"></a>Examples
Export the security database and the domain security policies to an inf file and then import that file to a different database in order to replicate the security policy settings on another computer.

```
secedit /export /db C:\Security\FY11\SecdbContoso.sdb /mergedpolicy /cfg SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY11.log /quiet
```

import that file to a different database on another computer.

```
secedit /import /db C:\Security\FY12\SecdbContoso.sdb /cfg SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY12.log /quiet
```

## additional references

-   [secedit:import](seceditimport.md)

-   [secedit](secedit.md)

-   [Command-Line Syntax Key](../../commandline-syntax-key.md)


