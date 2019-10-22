---
title: Run Best Practices Analyzer Scans and Manage Scan Results_1
description: "Server Manager"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-server-manager
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 232f1c80-88ef-4a39-8014-14be788c2766
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# Run Best Practices Analyzer Scans and Manage Scan Results

>Applies To: Windows Server 2016

In Windows management, *best practices* are guidelines that are considered the ideal way, under typical circumstances, to configure a server as defined by experts. For example, it is considered a best practice for most server applications to keep open only those ports required for the applications to communicate with other networked computers, and block unused ports. Although best practice violations, even crucial ones, are not necessarily problematic, they indicate server configurations that can result in poor performance, poor reliability, unexpected conflicts, increased security risks, or other potential problems.

Best Practices Analyzer (BPA) is a server management tool that is available in Windows Server 2012 R2,  Windows Server 2012, and  Windows Server 2008 R2. BPA can help administrators reduce best practice violations by scanning roles that are installed on managed servers that are running  Windows Server 2012  or  Windows Server 2008 R2, and reporting best practice violations to the administrator.

You can run Best Practices Analyzer (BPA) scans either from Server Manager, by using the BPA GUI, or by using cmdlets in Windows PowerShell. starting with  Windows Server 2012, you can scan one role or multiple roles at one time, on multiple servers, whether you use the Best Practices Analyzer tile in the Server Manager console or Windows PowerShell cmdlets to run scans. You can also instruct BPA to exclude or ignore scan results that you do not want to see.

This topic contains the following sections.

-   [find BPA](#BKMK_find)

-   [How BPA works](#BKMK_how)

-   [Performing Best Practices Analyzer scans on roles](#BKMK_BPAscan)

-   [Manage scan results](#BKMK_manage)

## <a name="BKMK_find"></a>find BPA
You can find the Best Practices Analyzer tile on role and server group pages of Server Manager in  Windows Server 2012 R2  and  Windows Server 2012, or you can open a Windows PowerShell session with elevated user rights to run Best Practices Analyzer cmdlets.

## <a name="BKMK_how"></a>How BPA works
BPA works by measuring a role's compliance with best practice rules in eight different categories of effectiveness, trustworthiness, and reliability. Results of measurements can be any of the three severity levels described in the following table.

|Severity level|Description|
|---------|--------|
|Error|Error results are returned when a role does not satisfy the conditions of a best practice rule, and functionality problems can be expected.|
|Information|Information results are returned when a role satisfies the conditions of a best practice rule.|
|Warning|Warning results are returned if the results of noncompliance can cause problems if changes are not made. The application might be compliant as operating currently, but may not satisfy the conditions of a rule if changes are not made to its configuration or policy settings. For example, a scan of Remote Desktop Services might show a warning result if a license server is unavailable to the role, because even if no remote connections are active at the time of the scan, not having the license server prevents new remote connections from obtaining valid client access licenses.|

### Rule categories
The following table describes the best practice rules categories against which roles are measured during a Best Practices Analyzer scan.

|Category Name|Description|
|---------|--------|
|Security|Security rules are applied to measure a role's relative risk for exposure to threats such as unauthorized or malicious users, or loss or theft of confidential or proprietary data.|
|Performance|Performance rules are applied to measure a role's ability to process requests and perform its prescribed duties in the enterprise within expected periods of time given the role's workload.|
|Configuration|Configuration rules are applied to identify role settings that might require modification for the role to perform optimally. Configuration rules can help prevent conflicts in settings that can result in error messages or prevent the role from performing its prescribed duties in an enterprise.|
|Policy|Policy rules are applied to identify Group Policy or Windows registry settings that might require modification for a role to operate optimally and securely.|
|Operation|Operation rules are applied to identify possible failures of a role to perform prescribed tasks in the enterprise.|
|Predeployment|Predeployment rules are applied before an installed role is deployed in the enterprise. They let administrators evaluate, before the role is used in production, whether best practices were satisfied.|
|Postdeployment|Postdeployment rules are applied after all required services have started for a role, and after the role is running in the enterprise.|
|Prerequisites|Prerequisite rules explain configuration settings, policy settings, and features that are required for a role before BPA can apply specific rules from other categories. A prerequisite in scan results indicates that an incorrect setting, a missing program, an incorrectly enabled or disabled policy, a registry key setting, or other configuration has prevented BPA from applying one or more rules during a scan. A prerequisite result does not imply compliance or noncompliance. It means that a rule could not be applied, and is not therefore part of the scan results.|

## <a name="BKMK_BPAscan"></a>Performing Best Practices Analyzer scans on roles
You can perform BPA scans on roles by using either the BPA GUI in Server Manager, or by using Windows PowerShell cmdlets.

In  Windows Server 2012 R2  and  Windows Server 2012 , some roles prompt you to specify additional parameters, such as the names of specific servers or shares that are running parts of the role, or the IDs of submodels, before starting a BPA scan. For BPA scans on models that require you to specify additional parameters, use the BPA cmdlets; the BPA GUI cannot accept additional parameters such as submodel IDs. For example, the submodel ID **FSRM** represents the File Services BPA submodel for File Server Resource Manager, a role service of File and Storage Services. To run a scan only on the File Server Resource Manager role service, run a BPA scan by using Windows PowerShell cmdlets, and add the parameter `SubmodelId` to your cmdlet.

Although you cannot pass additional parameters to a scan that you start in the BPA GUI, the BPA tile in Server Manager displays results for the most recent BPA scan, regardless of how the scan was started.

-   [Scanning roles by using the BPA GUI](#BKMK_GUIscan)

-   [Scanning roles by using Windows PowerShell cmdlets](#BKMK_PSscan)

### <a name="BKMK_GUIscan"></a>Scanning roles by using the BPA GUI
Follow these steps to scan one or more roles in the BPA GUI.

##### To scan roles by using the BPA GUI

1.  Do one of the following to open Server Manager if it is not already open.

    -   On the Windows taskbar, click the Server Manager button.

    -   On the **start** screen, click the Server Manager tile.

2.  In the navigation pane, open a role or group page.

    Running BPA scans from a role or group page scans all roles that are installed on servers in that group.

3.  On the **Tasks** menu of the **Best Practices Analyzer** tile, click **start BPA Scan**.

4.  Depending on the number of rules that are evaluated for the role or group you selected, the BPA scan can require a few minutes to finish.

### <a name="BKMK_PSscan"></a>Scanning roles by using Windows PowerShell cmdlets
Use the following procedures to scan one or more roles by using Windows PowerShell cmdlets.

> [!NOTE]
> The procedures in this section do not show all BPA cmdlets and parameters. For more information about BPA operations in Windows PowerShell, in your Windows PowerShell session, enter **Get-help***BPACmdlet***-full**, where *BPACmdlet* can be one of the following values. You can also find BPA cmdlet help topics on the [Windows Server TechCenter](https://go.microsoft.com/fwlink/p/?LinkId=240177).

-   **Get-BPAmodel**

-   **Invoke-BPAmodel**

-   **Get-BPAResult**

-   **Set-BPAResult**

#### <a name="BKMK_singlerole"></a>To scan a single role by using Windows PowerShell cmdlets

1.  Do one of the following to run Windows PowerShell with elevated user rights.

    -   To run Windows PowerShell as an administrator from the **start** screen, right-click the **Windows PowerShell** tile in the **Apps** results, and then on the app bar, click **Run as administrator**.

    -   To run Windows PowerShell as an administrator from the desktop, right-click the **Windows PowerShell** shortcut in the taskbar, and then click **Run as Administrator**.

2.  starting in Windows PowerShell 3.0, cmdlet modules are automatically imported into your Windows PowerShell session the first time a cmdlet from the module is used. There is no need to import or load the BPA cmdlet module.

3.  find the model IDs of all roles for which BPA scans can be performed by entering the **Get-Bpamodel** cmdlet, as shown in the following example.

    `Get-Bpamodel`

4.  In the results of step 3, locate the model IDs of the roles on which you want to run a BPA scan.

5.  Enter one of the following commands to start the BPA scan for a specific role. For multiple roles, separate model IDs with commas.

    `Invoke-BPAmodel -modelId <modelID_from_Step3>`

    `Invoke-BPAmodel <modelID_from_Step3>`

    **Example:**`Invoke-BPAmodel -modelId Microsoft/Windows/DNSServer,Microsoft/Windows/FileServices`

    > [!NOTE]
    > The model ID includes the entire path that is shown in the **Id** column; for example, **Microsoft/Windows/Hyper-V**.

    You can also start a scan on a specific role from the results of step 3 by piping the results of the `Get-BPAmodel` cmdlet into the `Invoke-BPAmodel` cmdlet as shown in the following example.

    `Get-BPAmodel <model_ID> | Invoke-BPAmodel`

    Running this cmdlet without specifying a model ID pipes all models that are returned by the `Get-BPAmodel` cmdlet into the `Invoke-BPAmodel` cmdlet, starting scans on all models that are available on servers that have been added to the Server Manager server pool.

#### <a name="BKMK_allroles"></a>To scan all roles by using Windows PowerShell cmdlets

1.  Open a Windows PowerShell session with elevated user rights, if one is not already open. See the preceding procedure for instructions.

2.  Pipe all roles for which BPA scans can be performed into the `Invoke-BPAmodel` cmdlet to start scans.

    `Get-BPAmodel | Invoke-BPAmodel`

3.  When the scan is complete, Windows PowerShell returns results similar to the following, for each role that was scanned.

    ```
    modelId                 :  Microsoft/Windows/FileServices
    SubmodelId              :
    Success                 :  True
    Scantime                :  1/01/2012  12:18:40 PM
    ScantimeUtcOffset       :  -08:00:00
    detail                  :  {server_name1, server_name2}

    ```

## <a name="BKMK_manage"></a>Manage scan results
After a BPA scan is completed in the GUI, you can view scan results in the BPA tile. When you select a result in the tile, a preview pane in the tile displays result properties, including an indication of whether the role is compliant with the associated best practice. If a result is not compliant, and you want to know how to resolve the problems described in the result properties, hyperlinks in error and warning result properties open detailed resolution help topics on the Windows Server TechCenter.

> [!NOTE]
> BPA scan results are not automatically saved or archived. Running a new scan on a model or submodel overwrites the results of the last scan. To save BPA scan results for archiving, printing, or sending to others, see [To view BPA results from Windows PowerShell sessions in different formats](#BKMK_formats) in this section.

### Exclude and include BPA results
if you do not need to see some BPA results, such as results that occur frequently in your BPA scans but require no resolution, you can exclude the results, by using either the BPA GUI or BPA cmdlets in Windows PowerShell. Results can be included again at any time.

> [!NOTE]
> When you exclude results, they are also excluded from view on managed servers. Other administrators cannot see excluded results on managed servers. To exclude results from view in a local Server Manager console only, create a custom query instead of using the **Exclude Result** command.

#### <a name="BKMK_exclude"></a>Exclude scan results
The **Exclude** setting is persistent; results that you exclude remain excluded in future scans of the same model on the same computer, unless they are included again.

You can exclude scan results by using the `Set-BPAResult` cmdlet with the `Exclude` parameter. As in the Best Practices Analyzer tile in Server Manager, you can exclude individual result objects, or you can also exclude a set of results whose fields (category, title, and severity, for example) are equal to or contain specified values. For example, you can exclude all **Performance** results from a set of scan results for a model.

> [!NOTE]
> You must run at least one BPA scan on a model before you can use procedures in this section.

###### To exclude scan results by using the GUI

1.  Open a role or server group page in Server Manager.

2.  In the Best Practices Analyzer tile for the role or server group, right-click a result in the list, and then click **Exclude Result**.

    The result is no longer displayed in the list of results.

3.  To view excluded results in the GUI, run the built-in **Excluded results** query. Click **Saved Search Queries**, and then click **Excluded results**.

    After running the **Excluded results** query, note that the tile subheading text, a description of the results that are displayed in the list, changes to **Excluded results**. Only excluded results are displayed in the list.

###### To exclude scan results by using Windows PowerShell cmdlets

1.  Open a Windows PowerShell session with elevated user rights.

2.  Exclude specific results from a model scan by running the following command.

    `Get-BPAResult -modelId <model ID> | Where { $_.<Field Name> -eq "Value"} | Set-BPAResult -Exclude $true`

    The preceding command retrieves BPA scan result items for the model ID that is represented by *model ID*.

    The second section of the command filters the results of the `Get-BPAResult` cmdlet to retrieve only those scan results for which the value for a result field, represented by *Field Name*, matches the text in quotation marks.

    The final section of the command, following the second pipe character, excludes the results that are filtered by the previous section of the cmdlet.

    **Example:**`Get-BPAResult -Microsoft/Windows/FileServices | Where { $_.Severity -eq "Information"} | Set-BPAResult -Exclude $true`

#### Include scan results
When you want to view scan results that were excluded, you can include those scan results. The **Include** setting is persistent; included results remain included in future scans of the same model on the same computer.

##### <a name="BKMK_gui"></a>To include scan results by using the GUI

1.  Open a role or server group page in Server Manager.

2.  In the Best Practices Analyzer tile for the role or server group, right-click an excluded result in the **Excluded results** query list, and then click **Include Result**.

    The result is no longer displayed in the list of excluded results. Clear the query by clicking **Clear All** to view the included result in the list of all included results.

##### <a name="BKMK_cmdlets"></a>To include scan results by using Windows PowerShell cmdlets

1.  Open a Windows PowerShell session with elevated user rights.

2.  Include specific results from a model scan by typing the following command, and then pressing **Enter**.

    `Get-BPAResult -modelId <model Id> | Where { $_.<Field Name> -eq "Value" } | Set-BPAResult -Exclude $false`

    The preceding command retrieves BPA scan result items for the model represented by *model Id*.

    The second part of the command, after the first pipe character ( **|** ) filters the results of the **Get-BPAResult** cmdlet to retrieve only those scan results for which the value of the result field, represented by *Field Name*, matches the text in quotation marks.

    The final part of the command, after the second pipe character, includes results that are filtered by the second part of the cmdlet, by setting the value of the **-Exclude** parameter to **false**.

    **Example:**`Get-BPAResult -Microsoft/Windows/FileServices | Where { $_.Severity -eq "Information"} | Set-BPAResult -Exclude $false`

### View and export BPA scan results in Windows PowerShell
To view and manage scan results by using Windows PowerShell cmdlets, see the following procedures. Before you can use any of the following procedures, run at least one BPA scan on at least one model or submodel.

#### <a name="BKMK_recentPS"></a>To view results of the most recent scan of a role by using Windows PowerShell

1.  Open a Windows PowerShell session with elevated user rights.

2.  Get the results of the most recent scan for a specified model ID. type the following, in which the model is represented by *model ID*, and then press **Enter**. You can get results for multiple model IDs by separating the model IDs with commas.

    `Get-BPAResult <model ID>`

    **Example:** `Get-BPAResult Microsoft/Windows/DNSServer,Microsoft/Windows/FileServices`

    if you scanned a submodel of a model, such as a role service, get the results for only that submodel by including the submodel ID in the cmdlet.

    **Example:** `Get-BPAResult Microsoft/Windows/FileServices -SubmodelID FSRM`

#### <a name="BKMK_formats"></a>To view or save BPA results from Windows PowerShell sessions in different formats

-   In Windows PowerShell, each BPA result resembles the following.

    ```
    ResultNumber     :  14
    ResultId         :  1557706192
    modelId          :  Microsoft/Windows/FileServices
    SubmodelId       :  FSRM
    RuleId           :  16
    computerName     :  server_name1, server_name2
    Context          :  FileServices
    Source           :  server_name1
    Severity         :  Information
    Category         :  Configuration
    Title            :  Access Denied remediation requires remote management be enabled on this server
    Problem          :
    Impact           :
    Resolution       :
    compliance       :  The File Server Best Practices Analyzer scan has determined that you are in compliance with this best practice.
    help             :
    Excluded         :  False

    ```

    Do one of the following.

    -   To format BPA results in a table, run the following cmdlet, adding the result properties that you want to see from the preceding example.

        `Get-BPAResult model ID | format-Table -Property <property1,property2,property3...>`

        **Example:**`Get-BPAResult Microsoft/Windows/FileServices | format-Table -Property modelId,SubmodelId,computerName,Source,Severity,Category,Title,Problem,Impact,Resolution,compliance,help`

    -   To format BPA results in a GUI-based grid viewer, with a text-string filter, and column headings that can be clicked to sort results, run the following cmdlet.

        `Get-BPAResult <model ID> | OGV`

    -   To export BPA results to an HTML file that can be archived or sent to email recipients, run the following cmdlet, where *path* represents the path and file name to which you want to save the HTML results.

        `Get-BPAResult <model ID> | convertTo-Html | Set-Content <path>`

        **Example:**`Get-BPAResult Microsoft/Windows/FileServices | convertTo-Html | Set-Content C:\BPAResults\FileServices.htm`

    -   To export BPA results to a comma-separated values (CSV) text file, run the following cmdlet, where *path* represents the path and text file name to which you want to save the CSV results. CSV results can be imported into Microsoft Excel, or other programs that display data in spreadsheets or grids.

        `Get-BPAResult <model ID> | Export-CSV <path>`

        **Example:**`Get-BPAResult Microsoft/Windows/FileServices | Export-CSV C:\BPAResults\FileServices.txt`

## See Also
[Best Practices Analyzer resolution content on the Windows Server TechCenter](https://go.microsoft.com/fwlink/p/?LinkId=241597)
[Filter, sort, and query Data in Server Manager Tiles](filter-sort-and-query-data-in-server-manager-tiles.md)
[Manage Multiple, remote Servers with Server Manager](manage-multiple-remote-servers-with-server-manager.md)
