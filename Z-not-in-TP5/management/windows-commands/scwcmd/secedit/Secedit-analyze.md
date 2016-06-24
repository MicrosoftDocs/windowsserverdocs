---
title: Secedit:analyze
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3430cf9d-1411-48b1-b5a9-2e47701dc87f
---
# Secedit:analyze
Allows you to analyze current systems settings against baseline settings that are stored in a database. For examples of how this command can be used, see [Examples](Secedit-analyze.md#BKMK_Examples).

## Syntax

```
Secedit /analyze /db <database file name> [/cfg <configuration file name>] [/overwrite] [/log <log file name>] [/quiet}]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|db|Required.<br /><br />Specifies the path and file name of a database that contains the stored configuration against which the analysis will be performed.<br /><br />If file name specifies a database that has not had a security template (as represented by the configuration file) associated with it, the `/cfg <configuration file name>` command-line option must also be specified.|
|cfg|Optional.<br /><br />Specifies the path and file name for the security template that will be imported into the database for analysis.<br /><br />This /cfg option is only valid when used with the `/db <database file name>` parameter. If this is not specified, the analysis is performed against any configuration already stored in the database.|
|overwrite|Optional.<br /><br />Specifies whether the security template in the /cfg parameter should overwrite any template or composite template that is stored in the database instead of appending the results to the stored template.<br /><br />This command-line option is only valid when the `/cfg <configuration file name>` parameter is also used. If this is not specified, the template in the /cfg parameter is appended to the stored template.|
|log|Optional.<br /><br />Specifies the path and file name of the log file to be used in the process.|
|quiet|Optional.<br /><br />Suppresses screen output. You can still view analysis results by using the Security Configuration and Analysis snap-in to the Microsoft Management Console (MMC).|

## Remarks
The analysis results are stored in a separate area of the database and can be viewed in the Security Configuration and Analysis snap-in to the MMC.

If the path for the log file is not provided, the default log file, (*systemroot*\Documents and Settings\\*UserAccount*\My Documents\Security\Logs\\*DatabaseName*.log) is used.

In Windows Server 2008, `Secedit /refreshpolicy` has been replaced with `gpupdate`. For information on how to refresh security settings, see [Gpupdate](Gpupdate.md).

## <a name="BKMK_Examples"></a>Examples
Perform the analysis for the security parameters on the security database, SecDbContoso.sdb, you created using the Security Configuration and Analysis snap-in. Direct the output to the file SecAnalysisContosoFY11 with prompting so you can verify the command ran correctly.

```
Secedit /analyze /db C:\Security\FY11\SecDbContoso.sdb /log C:\Security\FY11\SecAnalysisContosoFY11.log
```

Let’s say that the analysis revealed some inadequacies so the security template, SecContoso.inf, was modified. Run the command again to incorporate the changes, directing the output to the existing file SecAnalysisContosoFY11 with no prompting.

```
Secedit /analyze /db C:\Security\FY11\SecDbContoso.sdb /cfg SecContoso.inf /overwrite /log C:\Security\FY11\SecAnalysisContosoFY11.xml /quiet
```

## Additional references

-   [Secedit](Secedit.md)

-   [Command-Line Syntax Key](../../Command-Line-Syntax-Key.md)


