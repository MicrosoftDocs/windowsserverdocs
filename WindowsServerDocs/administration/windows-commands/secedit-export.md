---
title: secedit export
description: Reference article for the secedit export, which exports security settings stored in a database configured with security templates.
ms.topic: reference
ms.assetid: 49a8b241-aa8c-45b7-844d-67a29fab708e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# secedit /export

Exports security settings stored in a database configured with security templates. You can use this command to backup your security policies on a local computer, in addition to importing the settings to another computer.

## Syntax

```
secedit /export /db <database file name> [/mergedpolicy] /cfg <configuration file name> [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| /db | Required. Specifies the path and file name of the database containing the stored configuration against which the export is performed. If the file name specifies a database that hasn't had a security template (as represented by the configuration file) associated with it, the `/cfg <configuration file name>` option must also be specified. |
| /mergedpolicy | Merges and exports domain and local policy security settings. |
| /cfg | Required. Specifies the path and file name for the security template that will be imported into the database for analysis. This option is only valid when used with the `/db <database file name>` parameter. If this parameter isn't also specified, the analysis is performed against any configuration already stored in the database. |
| /areas | Specifies the security areas to be applied to the system. If this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:<ul><li>**securitypolicy:** Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.</li><li>  **group_mgmt:** Restricted group settings for any groups specified in the security template.</li><li>**user_rights:** User logon rights and granting of privileges.</li><li>**regkeys:** Security on local registry keys.</li><li>**filestore:** Security on local file storage.</li><li>**services:** Security for all defined services.</li></ul> |
| /log | Specifies the path and file name of the log file to be used in the process. If you don't specify a file location, the default log file, `<systemroot>\Documents and Settings\<UserAccount>\My Documents\Security\Logs\<databasename>.log` is used. |
| /quiet | Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (MMC). |

## Examples

To export the security database and the domain security policies to an inf file, and then import that file to a different database in order to replicate the security policy settings on another computer, type:

```
secedit /export /db C:\Security\FY11\SecDbContoso.sdb /mergedpolicy /cfg SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY11.log /quiet
```

To import your example file to a different database on another computer, type:

```
secedit /import /db C:\Security\FY12\SecDbContoso.sdb /cfg SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY12.log /quiet
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [secedit /analyze](secedit-analyze.md)

- [secedit /configure](secedit-configure.md)

- [secedit /generaterollback](secedit-generaterollback.md)

- [secedit /import](secedit-import.md)

- [secedit /validate](secedit-validate.md)