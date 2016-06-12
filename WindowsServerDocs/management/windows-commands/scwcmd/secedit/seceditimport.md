---
title: secedit:import
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1dd59d4c-9d48-444a-871b-b957eb682597
---
# secedit:import
imports security settings stored in an inf file previously exported from the database configured with security templates. for examples of how this command can be used, see [Examples](seceditimport.md#BKMK_Examples).

## Syntax

```
secedit /import /db <database file name> /cfg <configuration file name> [/overwrite] [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|db|Required.<br /><br />Specifies the path and file name of a database that contains the stored configuration into which the import will be performed.<br /><br />if file name specifies a database that has not had a security template \(as represented by the configuration file\) associated with it, the `/cfg <configuration file name>` command\-line option must also be specified.|
|overwrite|Optional.<br /><br />Specifies whether the security template in the \/cfg parameter should overwrite any template or composite template that is stored in the database instead of appending the results to the stored template.<br /><br />This command\-line option is only valid when the `/cfg <configuration file name>` parameter is also used. if this is not specified, the template in the \/cfg parameter is appended to the stored template.|
|cfg|Required.<br /><br />Specifies the path and file name for the security template that will be imported into the database for analysis.<br /><br />This \/cfg option is only valid when used with the `/db <database file name>` parameter. if this is not specified, the analysis is performed against any configuration already stored in the database.|
|overwrite|Optional.<br /><br />Specifies whether the security template in the \/cfg parameter should overwrite any template or composite template that is stored in the database instead of appending the results to the stored template.<br /><br />This command\-line option is only valid when the `/cfg <configuration file name>` parameter is also used. if this is not specified, the template in the \/cfg parameter is appended to the stored template.|
|areas|Optional.<br /><br />Specifies the security areas to be applied to the system. if this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:<br /><br />-   SecurityPolicy<br />    Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.<br />-   Group\_Mgmt<br />    Restricted group settings for any groups specified in the security template.<br />-   User\_Rights<br />    User logon rights and granting of privileges.<br />-   regKeys<br />    Security on local registry keys.<br />-   FileStore<br />    Security on local file storage.<br />-   Services<br />    Security for all defined services.|
|log|Optional.<br /><br />Specifies the path and file name of the log file for the process.|
|quiet|Optional.<br /><br />Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap\-in to the Microsoft management Console \(mmc\).|

## remarks
Before importing an .inf file onto another computer, run the command secedit \/generaterollback on the database on which the import will be performed and secedit \/validate on the import file to verify its integrity.

if the path for the log file is not provided, the default log file, \(*systemroot*\\Documents and Settings\\*UserAccount*\\My Documents\\Security\\Logs\\*DatabaseName*.log\) is used.

In Windows Server 2008, `secedit /refreshpolicy` has been replaced with `gpupdate`. for information on how to refresh security settings, see [gpupdate]().

## <a name="BKMK_Examples"></a>Examples
Export the security database and the domain security policies to an inf file and then import that file to a different database in order to replicate the security policy settings on another computer.

```
secedit /export /db C:\Security\FY11\SecdbContoso.sdb /mergedpolicy /cfg NetworkShare\Policies\SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY11.log /quiet
```

import just the security policies portion of the file to a different database on another computer.

```
secedit /import /db C:\Security\FY12\SecdbContoso.sdb /cfg NetworkShare\Policies\SecContoso.inf /areas securitypolicy /log C:\Security\FY11\SecAnalysisContosoFY12.log /quiet
```

## additional references

-   [secedit:export](seceditexport.md)

-   [secedit:generaterollback](seceditgeneraterollback.md)

-   [secedit:validate](seceditvalidate.md)

-   [secedit](secedit.md)

-   [Command-Line Syntax Key](../../commandline-syntax-key.md)


