---
title: secedit:configure
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a92e68ca-003c-4219-8655-0e7734f5fab3
---
# secedit:configure
Allows you to configure the current system settings using security settings stored in a database. for examples of how this command can be used, see [Examples](seceditconfigure.md#BKMK_Examples).

## Syntax

```
secedit /configure /db <database file name> [/cfg <configuration file name>] [/overwrite] [/areas SECURITYPOLICY | GROUP_MGMT | USER_RIGHTS | regKEYS | FILESTORE | SERVICES] [/log <log file name>] [/quiet]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|db|Required.<br /><br />Specifies the path and file name of a database that contains the stored configuration.<br /><br />if file name specifies a database that has not had a security template \(as represented by the configuration file\) associated with it, the `/cfg <configuration file name>` command\-line option must also be specified.|
|cfg|Optional.<br /><br />Specifies the path and file name for the security template that will be imported into the database for analysis.<br /><br />This \/cfg option is only valid when used with the `/db <database file name>` parameter. if this is not specified, the analysis is performed against any configuration already stored in the database.|
|overwrite|Optional.<br /><br />Specifies whether the security template in the \/cfg parameter should overwrite any template or composite template that is stored in the database instead of appending the results to the stored template.<br /><br />This command\-line option is only valid when the `/cfg <configuration file name>` parameter is also used. if this is not specified, the template in the \/cfg parameter is appended to the stored template.|
|areas|Optional.<br /><br />Specifies the security areas to be applied to the system. if this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:<br /><br />-   SecurityPolicy<br />    Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.<br />-   Group\_Mgmt<br />    Restricted group settings for any groups specified in the security template.<br />-   User\_Rights<br />    User logon rights and granting of privileges.<br />-   regKeys<br />    Security on local registry keys.<br />-   FileStore<br />    Security on local file storage.<br />-   Services<br />    Security for all defined services.|
|log|Optional.<br /><br />Specifies the path and file name of the log file for the process.|
|quiet|Optional.<br /><br />Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap\-in to the Microsoft management Console \(mmc\).|

## remarks
if the path for the log file is not provided, the default log file, \(*systemroot*\\Users \\*UserAccount*\\My Documents\\Security\\Logs\\*DatabaseName*.log\) is used.

Beginning with Windows Server 2008, `secedit /refreshpolicy` has been replaced with `gpupdate`. for information on how to refresh security settings, see [gpupdate]().

## <a name="BKMK_Examples"></a>Examples
Perform the analysis for the security parameters on the security database, SecdbContoso.sdb, you created using the Security Configuration and Analysis snap\-in. direct the output to the file SecAnalysisContosoFY11 with prompting so you can verify the command ran correctly.

```
secedit /analyze /db C:\Security\FY11\SecdbContoso.sdb /log C:\Security\FY11\SecAnalysisContosoFY11.log
```

Let’s say that the analysis revealed some inadequacies so the security template, SecContoso.inf, was modified. Run the command again to incorporate the changes, directing the output to the existing file SecAnalysisContosoFY11 with no prompting.

```
secedit /configure /db C:\Security\FY11\SecdbContoso.sdb /cfg SecContoso.inf /overwrite /log C:\Security\FY11\SecAnalysisContosoFY11.xml /quiet
```

## additional references

-   [secedit](secedit.md)

-   [secedit:analyze](seceditanalyze.md)

-   [Command-Line Syntax Key](../../commandline-syntax-key.md)


