---
title: secedit:generaterollback
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 385a6799-51a7-4fe3-bd73-10c7998b6680
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# secedit:generaterollback



Allows you to generate a rollback template for a specified configuration template. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
Secedit /generaterollback /db <database file name> /cfg <configuration file name> /rbk <rollback template file name> [log <log file name>] [/quiet]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|db|Required.</br>Specifies the path and file name of a database that contains the stored configuration against which the analysis will be performed.</br>If file name specifies a database that has not had a security template (as represented by the configuration file) associated with it, the `/cfg \<configuration file name>` command-line option must also be specified.|
|cfg|Required.</br>Specifies the path and file name for the security template that will be imported into the database for analysis.</br>This /cfg option is only valid when used with the `/db \<database file name>` parameter. If this is not specified, the analysis is performed against any configuration already stored in the database.|
|rbk|Required.</br>Specifies a security template into which the rollback information is written. Security templates are created using the Security Templates snap-in. Rollback files can be created with this command.|
|log|Optional.</br>Specifies the path and file name of the log file for the process.|
|quiet|Optional.</br>Suppresses screen and log output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (MMC).|

## Remarks

If the path for the log file is not provided, the default log file, (*systemroot*\Users \*UserAccount<em>\My Documents\Security\Logs\*DatabaseName</em>.log) is used.

Beginning with Windows Server 2008, `Secedit /refreshpolicy` has been replaced with `gpupdate`. For information on how to refresh security settings, see [Gpupdate](gpupdate.md).

The successful running of this command will state "The task has completed successfully." and logs only the mismatches between the stated security template and security policy configuration. It lists these mismatches in the scesrv.log.

If an existing rollback template is specified, this command will overwrite it. You can create a new rollback template with this command. No additional parameters are needed for either condition.

## <a name="BKMK_Examples"></a>Examples

After creating the security template using the Security Configuration and Analysis snap-in, SecTmplContoso.inf, create the rollback configuration file to save the original settings. Write out the action to the FY11 log file.
```
Secedit /generaterollback /db C:\Security\FY11\SecDbContoso.sdb /cfg sectmplcontoso.inf /rbk sectmplcontosoRBK.inf /log C:\Security\FY11\SecAnalysisContosoFY11.log
```

#### Additional references

-   [Secedit](secedit.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)