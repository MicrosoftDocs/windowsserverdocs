---
title: secedit:import
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1dd59d4c-9d48-444a-871b-b957eb682597
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# secedit:import

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

imports security settings stored in an inf file previously exported from the database configured with security templates. For examples of how this command can be used, see [Examples](secedit-import.md#BKMK_Examples).
## Syntax
```
secedit /import /db <database file name> /cfg <configuration file name> [/overwrite] [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]
```
### Parameters
|Parameter|Description|
|-------|--------|
|db|Required.<br /><br />Specifies the path and file name of a database that contains the stored configuration into which the import will be performed.<br /><br />if file name specifies a database that has not had a security template (as represented by the configuration file) associated with it, the `/cfg <configuration file name>` command-line option must also be specified.|
|overwrite|Optional.<br /><br />Specifies whether the security template in the /cfg parameter should overwrite any template or composite template that is stored in the database instead of appending the results to the stored template.<br /><br />This command-line option is only valid when the `/cfg <configuration file name>` parameter is also used. If this is not specified, the template in the /cfg parameter is appended to the stored template.|
|cfg|Required.<br /><br />Specifies the path and file name for the security template that will be imported into the database for analysis.<br /><br />This /cfg option is only valid when used with the `/db <database file name>` parameter. If this is not specified, the analysis is performed against any configuration already stored in the database.|
|overwrite|Optional.<br /><br />Specifies whether the security template in the /cfg parameter should overwrite any template or composite template that is stored in the database instead of appending the results to the stored template.<br /><br />This command-line option is only valid when the `/cfg <configuration file name>` parameter is also used. If this is not specified, the template in the /cfg parameter is appended to the stored template.|
|areas|Optional.<br /><br />Specifies the security areas to be applied to the system. If this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:<br /><br />-   SecurityPolicy<br />    Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.<br />-   Group_Mgmt<br />    Restricted group settings for any groups specified in the security template.<br />-   User_Rights<br />    User logon rights and granting of privileges.<br />-   regKeys<br />    Security on local registry keys.<br />-   FileStore<br />    Security on local file storage.<br />-   Services<br />    Security for all defined services.|
|log|Optional.<br /><br />Specifies the path and file name of the log file for the process.|
|quiet|Optional.<br /><br />Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (mmc).|
## remarks
Before importing an .inf file onto another computer, run the command secedit /generaterollback on the database on which the import will be performed and secedit /validate on the import file to verify its integrity.
if the path for the log file is not provided, the default log file, (*systemroot*\Documents and Settings\\*UserAccount*\My Documents\Security\Logs\\*DatabaseName*.log) is used.
In Windows Server 2008, `secedit /refreshpolicy` has been replaced with `gpupdate`. For information on how to refresh security settings, see [gpupdate](gpupdate.md).
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
-   [secedit:export](secedit-export.md)
-   [secedit:generaterollback](secedit-generaterollback.md)
-   [secedit:validate](secedit-validate.md)
-   [secedit](secedit.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)
