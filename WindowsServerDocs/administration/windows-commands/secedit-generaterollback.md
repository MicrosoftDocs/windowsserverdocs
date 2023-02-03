---
title: secedit generaterollback
description: Reference article for the secedit generaterollback command, which allows you to generate a rollback template for a specified configuration template.
ms.topic: reference
ms.assetid: 385a6799-51a7-4fe3-bd73-10c7998b6680
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# secedit /generaterollback

Allows you to generate a rollback template for a specified configuration template. If an existing rollback template exists, running this command again will overwrite the existing information.

Successfully running this command logs the mismatches between the specified security template the security policy configuration into the scesrv.log file.

## Syntax

```
secedit /generaterollback /db <database file name> /cfg <configuration file name> /rbk <rollback template file name> [/log <log file name>] [/quiet]
```

### Parameters

| Parameter | Description |
|--|--|
| /db | Required. Specifies the path and file name of the database containing the stored configuration against which the analysis is performed. If the file name specifies a database that hasn't had a security template (as represented by the configuration file) associated with it, the `/cfg <configuration file name>` option must also be specified. |
| /cfg | Required. Specifies the path and file name for the security template that will be imported into the database for analysis. This option is only valid when used with the `/db <database file name>` parameter. If this parameter isn't also specified, the analysis is performed against any configuration already stored in the database. |
| /rbk | Required. Specifies a security template into which the rollback information is written. Security templates are created using the Security Templates snap-in. Rollback files can be created with this command. |
| /log | Specifies the path and file name of the log file to be used in the process. If you don't specify a file location, the default log file, `<systemroot>\Documents and Settings\<UserAccount>\My Documents\Security\Logs\<databasename>.log` is used. |
| /quiet | Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (MMC). |

## Examples

To create the rollback configuration file, for the previously created *SecTmplContoso.inf* file, while saving the original settings, and then write out the action to the *SecAnalysisContosoFY11* log file, type:

```
secedit /generaterollback /db C:\Security\FY11\SecDbContoso.sdb /cfg sectmplcontoso.inf /rbk sectmplcontosoRBK.inf /log C:\Security\FY11\SecAnalysisContosoFY11.log
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [secedit /analyze](secedit-analyze.md)

- [secedit /configure](secedit-configure.md)

- [secedit /export](secedit-export.md)

- [secedit /import](secedit-import.md)

- [secedit /validate](secedit-validate.md)