---
title: secedit configure
description: Reference article for the secedit configure command, which allows you to configure the current system settings using security settings stored in a database.
ms.topic: reference
ms.assetid: a92e68ca-003c-4219-8655-0e7734f5fab3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# secedit /configure

Allows you to configure the current system settings using security settings stored in a database.

## Syntax

```
secedit /configure /db <database file name> [/cfg <configuration file name>] [/overwrite] [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| /db | Required. Specifies the path and file name of the database containing the stored configuration. If the file name specifies a database that hasn't had a security template (as represented by the configuration file) associated with it, the `/cfg <configuration file name>` option must also be specified. |
| /cfg | Specifies the path and file name for the security template that will be imported into the database for analysis. This option is only valid when used with the `/db <database file name>` parameter. If this parameter isn't also specified, the analysis is performed against any configuration already stored in the database. |
| /overwrite | Specifies whether the security template in the **/cfg** parameter should overwrite any template or composite template that is stored in the database, instead of appending the results to the stored template. This option is only valid when the `/cfg <configuration file name>` parameter is also used. If this parameter isn't also specified, the template in the **/cfg** parameter is appended to the stored template. |
| /areas | Specifies the security areas to be applied to the system. If this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:<ul><li>**securitypolicy:** Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.</li><li>  **group_mgmt:** Restricted group settings for any groups specified in the security template.</li><li>**user_rights:** User logon rights and granting of privileges.</li><li>**regkeys:** Security on local registry keys.</li><li>**filestore:** Security on local file storage.</li><li>**services:** Security for all defined services.</li></ul> |
| /log | Specifies the path and file name of the log file to be used in the process. If you don't specify a file location, the default log file, `<systemroot>\Documents and Settings\<UserAccount>\My Documents\Security\Logs\<databasename>.log` is used. |
| /quiet | Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (MMC). |

## Examples

To perform the analysis for the security parameters on the security database, *SecDbContoso.sdb*, and then direct the output to the file *SecAnalysisContosoFY11*, including prompts to verify the command ran correctly, type:

```
secedit /analyze /db C:\Security\FY11\SecDbContoso.sdb /log C:\Security\FY11\SecAnalysisContosoFY11.log
```

To incorporate changes required by the analysis process on the *SecContoso.inf* file, and then to direct the output to the existing file, *SecAnalysisContosoFY11*, without prompting, type:

```
secedit /configure /db C:\Security\FY11\SecDbContoso.sdb /cfg SecContoso.inf /overwrite /log C:\Security\FY11\SecAnalysisContosoFY11.xml /quiet
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [secedit /analyze](secedit-analyze.md)

- [secedit /export](secedit-export.md)

- [secedit /generaterollback](secedit-generaterollback.md)

- [secedit /import](secedit-import.md)

- [secedit /validate](secedit-validate.md)