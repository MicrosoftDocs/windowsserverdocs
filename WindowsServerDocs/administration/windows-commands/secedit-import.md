---
title: secedit import
description: Reference article for the secedit import command, which imports security settings (.inf file), previously exported from the database configured with security templates.
ms.topic: reference
ms.assetid: 1dd59d4c-9d48-444a-871b-b957eb682597
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# secedit /import

Imports security settings (.inf file), previously exported from the database configured with security templates.

> [!IMPORTANT]
> Before you import an .inf file to another computer, you must run the `secedit /generaterollback` command on the database on which the import will be performed.
>
> You must also run the `secedit /validate` command on the import file to verify its integrity.

## Syntax

```
secedit /import /db <database file name> /cfg <configuration file name> [/overwrite] [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| /db | Required. Specifies the path and file name of the database containing the stored configuration against which the import is performed. If the file name specifies a database that hasn't had a security template (as represented by the configuration file) associated with it, the `/cfg <configuration file name>` option must also be specified. |
| /overwrite | Specifies whether the security template in the **/cfg** parameter should overwrite any template or composite template that is stored in the database, instead of appending the results to the stored template. This option is only valid when the `/cfg <configuration file name>` parameter is also used. If this parameter isn't also specified, the template in the **/cfg** parameter is appended to the stored template. |
| /cfg | Required. Specifies the path and file name for the security template that will be imported into the database for analysis. This option is only valid when used with the `/db <database file name>` parameter. If this parameter isn't also specified, the analysis is performed against any configuration already stored in the database. |
| /areas | Specifies the security areas to be applied to the system. If this parameter is not specified, all security settings defined in the database are applied to the system. To configure multiple areas, separate each area by a space. The following security areas are supported:<ul><li>**securitypolicy:** Local policy and domain policy for the system, including account policies, audit policies, security options, and so on.</li><li>  **group_mgmt:** Restricted group settings for any groups specified in the security template.</li><li>**user_rights:** User logon rights and granting of privileges.</li><li>**regkeys:** Security on local registry keys.</li><li>**filestore:** Security on local file storage.</li><li>**services:** Security for all defined services.</li></ul> |
| /log | Specifies the path and file name of the log file to be used in the process. If you don't specify a file location, the default log file, `<systemroot>\Documents and Settings\<UserAccount>\My Documents\Security\Logs\<databasename>.log` is used. |
| /quiet | Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (MMC). |

## Examples

To export the security database and the domain security policies to an .inf file, and then to import that file to a different database to replicate the policy settings on another computer, type:

```
secedit /export /db C:\Security\FY11\SecDbContoso.sdb /mergedpolicy /cfg NetworkShare\Policies\SecContoso.inf /log C:\Security\FY11\SecAnalysisContosoFY11.log /quiet
```

To import just the security policies portion of the file to a different database on another computer, type:

```
secedit /import /db C:\Security\FY12\SecDbContoso.sdb /cfg NetworkShare\Policies\SecContoso.inf /areas securitypolicy /log C:\Security\FY11\SecAnalysisContosoFY12.log /quiet
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [secedit /analyze](secedit-analyze.md)

- [secedit /configure](secedit-configure.md)

- [secedit /export](secedit-export.md)

- [secedit /generaterollback](secedit-generaterollback.md)

- [secedit /validate](secedit-validate.md)