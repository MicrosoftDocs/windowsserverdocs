---
ms.assetid: d44d4430-41e2-483a-9685-92610cdef32a
title: How Cluster-Aware Updating plug-ins work
ms.topic: article
ms.prod: windows-server-threshold
manager: dongill
ms.author: jgerend
author: JasonGerend
ms.date: 04/28/2017
ms.technology: storage-failover-clustering
description: How to use plug-ins to coordinate updates when using Cluster-Aware Updating in Windows Server to install updates on a cluster.
---
# How Cluster-Aware Updating plug-ins work

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

[Cluster-Aware Updating](cluster-aware-updating.md) (CAU) uses plug-ins to coordinate the installation of updates across nodes in a failover cluster. This topic provides information about using the built\-in CAU plug\-ins or other plug\-ins that you install for CAU.

## <a name="BKMK_INSTALL"></a>Install a plug\-in  
A plug\-in other than the default plug\-ins that are installed with CAU \(**Microsoft.WindowsUpdatePlugin** and **Microsoft.HotfixPlugin**\) must be installed separately. If CAU is used in self\-updating mode, the plug\-in must be installed on all cluster nodes. If CAU is used in remote\-updating mode, the plug\-in must be installed on the remote Update Coordinator computer. A plug\-in that you install may have additional installation requirements on each node.  
  
To install a plug\-in, follow the instructions from the plug\-in publisher. To manually register a plug\-in with CAU, run the [Register-CauPlugin](https://technet.microsoft.com/itpro/powershell/windows/cluster-aware-updating/register-cauplugin) cmdlet on each computer where the plug\-in is installed.  
  
## Specify a plug\-in and plug\-in arguments  
  
### Specify a CAU plug\-in

In the CAU UI, you select a plug\-in from a drop\-down list of available plug\-ins when you use CAU to perform the following actions:  
  
-   Apply updates to the cluster  
  
-   Preview updates for the cluster  
  
-   Configure cluster self\-updating options  
  
By default, CAU selects the plug\-in **Microsoft.WindowsUpdatePlugin**. However, you can specify any plug\-in that is installed and registered with CAU.

> [!TIP]  
> In the CAU UI, you can only specify a single plug\-in for CAU to use to preview or to apply updates during an Updating Run. By using the CAU PowerShell cmdlets, you can specify one or more plug\-ins. If you need to install multiple types of updates on the cluster, it is usually more efficient to specify multiple plug\-ins in one Updating Run, rather than using a separate Updating Run for each plug\-in. For example, fewer node restarts will typically occur.

By using the CAU PowerShell cmdlets that are listed in the following table, you can specify one or more plug\-ins for an Updating Run or scan by passing the **–CauPluginName** parameter. You can specify multiple plug\-in names by separating them with commas. If you specify multiple plug\-ins, you can also control how the plug\-ins influence each other during an Updating Run by specifying the **\-RunPluginsSerially**, **\-StopOnPluginFailure**, and **–SeparateReboots** parameters. For more information about using multiple plug\-ins, use the links provided to the cmdlet documentation in the following table.  
  
|Cmdlet|Description|  
|----------|---------------|  
|[Add-CauClusterRole](https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating/add-cauclusterrole)|Adds the CAU clustered role that provides the self\-updating functionality to the specified cluster.|  
|[Invoke-CauRun](https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating/invoke-caurun)|Performs a scan of cluster nodes for applicable updates and installs those updates through an Updating Run on the specified cluster.|  
|[Invoke-CauScan](https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating/invoke-causcan)|Performs a scan of cluster nodes for applicable updates and returns a list of the initial set of updates that would be applied to each node in the specified cluster.|  
|[Set-CauClusterRole](https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating/set-cauclusterrole)|Sets configuration properties for the CAU clustered role on the specified cluster.|  
  
If you do not specify a CAU plug\-in parameter by using these cmdlets, the default is the plug\-in **Microsoft.WindowsUpdatePlugin**.  
  
### Specify CAU plug\-in arguments  
When you configure the Updating Run options, you can specify one or more *name\=value* pairs \(arguments\) for the selected plug\-in to use. For example, in the CAU UI, you can specify multiple arguments as follows:  
  
**Name1\=Value1;Name2\=Value2;Name3\=Value3**  
  
These *name\=value* pairs must be meaningful to the plug\-in that you specify. For some plug\-ins the arguments are optional.  
  
The syntax of the CAU plug\-in arguments follows these general rules:  
  
-   Multiple *name\=value* pairs are separated by semicolons.  
  
-   A value that contains spaces is surrounded by quotation marks, for example: **Name1\="Value with Spaces"**.  
  
-   The exact syntax of *value* depends on the plug\-in.  
  
To specify plug\-in arguments by using the CAU PowerShell cmdlets that support the **–CauPluginParameters** parameter, pass a parameter of the form:  
  
**\-CauPluginArguments @{Name1\=Value1;Name2\=Value2;Name3\=Value3}**  
  
You can also use a predefined PowerShell hash table. To specify plug\-in arguments for more than one plug\-in, pass multiple hash tables of arguments, separated with commas. Pass the plug\-in arguments in the plug\-in order that is specified in **CauPluginName**.  
  
### Specify optional plug\-in arguments  
The plug\-ins that CAU installs \(**Microsoft.WindowsUpdatePlugin** and **Microsoft.HotfixPlugin**\) provide additional options that you can select. In the CAU UI, these appear on an **Additional Options** page after you configure Updating Run options for the plug\-in. If you are using the CAU PowerShell cmdlets, these options are configured as optional plug\-in arguments. For more information, see [Use the Microsoft.WindowsUpdatePlugin](#BKMK_WUP) and [Use the Microsoft.HotfixPlugin](#BKMK_HFP) later in this topic.  
  
## Manage plug\-ins using Windows PowerShell cmdlets  
  
|Cmdlet|Description|  
|----------|---------------|  
|[Get-CauPlugin](https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating/get-cauplugin)|Retrieves information about one or more software updating plug\-ins that are registered on the local computer.|  
|[Register-CauPlugin]((https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating/register-cauplugin))|Registers a CAU software updating plug\-in on the local computer.|  
|[Unregister-CauPlugin](https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating/unregister-cauplugin)|Removes a software updating plug\-in from the list of plug\-ins that can be used by CAU. **Note:** The plug\-ins that are installed with CAU \(**Microsoft.WindowsUpdatePlugin** and the **Microsoft.HotfixPlugin**\) cannot be unregistered.|  
  
## <a name="BKMK_WUP"></a>Using the Microsoft.WindowsUpdatePlugin  

The default plug\-in for CAU, **Microsoft.WindowsUpdatePlugin**, performs the following actions:
- Communicates with the Windows Update Agent on each failover cluster node to apply updates that are needed for the Microsoft products that are running on each node.
- Installs cluster updates directly from Windows Update or Microsoft Update, or from an on\-premises Windows Server Update Services \(WSUS\) server.
- Installs only selected, general distribution release \(GDR\) updates. By default, the plug\-in applies only important software updates. No configuration is required. The default configuration downloads and installs important GDR updates on each node. 

> [!NOTE]
> To apply updates other than the important software updates that are selected by default \(for example, driver updates\), you can configure an optional plug\-in parameter. For more information, see [Configure the Windows Update Agent query string](#BKMK_QUERY).

### Requirements

- The failover cluster and remote Update Coordinator computer \(if used\) must meet the requirements for CAU and the configuration that is required for remote management listed in [Requirements and Best Practices for CAU](cluster-aware-updating-requirements.md).
- Review [Recommendations for applying Microsoft updates](cluster-aware-updating-requirements.md#BKMK_BP_WUA), and then make any necessary changes to your Microsoft Update configuration for the failover cluster nodes.
- For best results, we recommend that you run the CAU Best Practices Analyzer \(BPA\) to ensure that the cluster and update environment are configured properly to apply updates by using CAU. For more information, see [Test CAU updating readiness](cluster-aware-updating-requirements.md#BKMK_BPA).

> [!NOTE]
> Updates that require the acceptance of Microsoft license terms or require user interaction are excluded, and they must be installed manually.

### Additional options

Optionally, you can specify the following plug\-in arguments to augment or restrict the set of updates that are applied by the plug\-in:
- To configure the plug\-in to apply recommended updates in addition to important updates on each node, in the CAU UI, on the **Additional Options** page, select the **Give me recommended updates the same way that I receive important updates** check box.
<br>Alternatively, configure the **'IncludeRecommendedUpdates'\='True'** plug\-in argument.
- To configure the plug\-in to filter the types of GDR updates that are applied to each cluster node, specify a Windows Update Agent query string using a **QueryString** plug\-in argument. For more information, see [Configure the Windows Update Agent query string](#BKMK_QUERY).

### <a name="BKMK_QUERY"></a>Configure the Windows Update Agent query string  
You can configure a plug\-in argument for the default plug\-in, **Microsoft.WindowsUpdatePlugin**, that consists of a Windows Update Agent \(WUA\) query string. This instruction uses the WUA API to identify one or more groups of Microsoft updates to apply to each node, based on specific selection criteria. You can combine multiple criteria by using a logical AND or a logical OR. The WUA query string is specified in a plug\-in argument as follows:  
  
**QueryString\="Criterion1\=Value1 and\/or Criterion2\=Value2 and\/or…"**  
  
For example, **Microsoft.WindowsUpdatePlugin** automatically selects important updates by using a default **QueryString** argument that is constructed using the **IsInstalled**, **Type**, **IsHidden**, and **IsAssigned** criteria:  
  
**QueryString\="IsInstalled\=0 and Type\='Software' and IsHidden\=0 and IsAssigned\=1"**  
  
If you specify a **QueryString** argument, it is used in place of the default **QueryString** that is configured for the plug\-in.  
  
#### Example 1
  
To configure a **QueryString** argument that installs a specific update as identified by ID *f6ce46c1\-971c\-43f9\-a2aa\-783df125f003*:  
  
**QueryString\="UpdateID\='f6ce46c1\-971c\-43f9\-a2aa\-783df125f003' and IsInstalled\=0"**  
  
> [!NOTE]  
> The preceding example is valid for applying updates by using the Cluster\-Aware Updating Wizard. If you want to install a specific update by configuring self\-updating options with the CAU UI or by using the **Add\-CauClusterRole** or **Set\-CauClusterRole**PowerShell cmdlet, you must format the UpdateID value with two single\-quote characters:  
>   
> **QueryString\="UpdateID\=''f6ce46c1\-971c\-43f9\-a2aa\-783df125f003'' and IsInstalled\=0"**  
  
#### Example 2
  
To configure a **QueryString** argument that installs only drivers:  
  
**QueryString\="IsInstalled\=0 and Type\='Driver' and IsHidden\=0"**  
  
For more information about query strings for the default plug\-in, **Microsoft.WindowsUpdatePlugin**, the search criteria \(such as **IsInstalled**\), and the syntax that you can include in the query strings, see the section about search criteria in the [Windows Update Agent (WUA) API Reference](https://go.microsoft.com/fwlink/p/?LinkId=223304).  
  
## <a name="BKMK_HFP"></a>Use the Microsoft.HotfixPlugin  
The plug\-in **Microsoft.HotfixPlugin** can be used to apply Microsoft limited distribution release \(LDR\) updates \(also called hotfixes, and formerly called QFEs\) that you download independently to address specific Microsoft software issues. The plug-in installs updates from a root folder on an SMB file share and can also be customized to apply non\-Microsoft driver, firmware, and BIOS updates.

> [!NOTE]
> Hotfixes are sometimes available for download from Microsoft in Knowledge Base articles, but they are also provided to customers on an as\-needed basis.

### Requirements

- The failover cluster and remote Update Coordinator computer \(if used\) must meet the requirements for CAU and the configuration that is required for remote management listed in [Requirements and Best Practices for CAU](cluster-aware-updating-requirements.md).
- Review [Recommendations for using the Microsoft.HotfixPlugin](cluster-aware-updating-requirements.md#BKMK_BP_HF).
- For best results, we recommend that you run the CAU Best Practices Analyzer \(BPA\) model to ensure that the cluster and update environment are configured properly to apply updates by using CAU. For more information, see [Test CAU updating readiness](cluster-aware-updating-requirements.md#BKMK_BPA).
- Obtain the updates from the publisher, and copy them or extract them to a Server Message Block \(SMB\) file share \(hotfix root folder\) that supports at least SMB 2.0 and that is accessible by all of the cluster nodes and the remote Update Coordinator computer \(if CAU is used in remote\-updating mode\). For more information, see [Configure a hotfix root folder structure](#BKMK_HF_ROOT) later in this topic. 

    > [!NOTE]
    > By default, this plug\-in only installs hotfixes with the following file name extensions: .msu, .msi, and .msp.

- Copy the DefaultHotfixConfig.xml file \(which is provided in the **%systemroot%\\System32\\WindowsPowerShell\\v1.0\\Modules\\ClusterAwareUpdating** folder on a computer where the CAU tools are installed\) to the hotfix root folder that you created and under which you extracted the hotfixes. For example, copy the configuration file to *\\\\MyFileServer\\Hotfixes\\Root\\*. 

    > [!NOTE]
    > To install most hotfixes provided by Microsoft and other updates, the default hotfix configuration file can be used without modification. If your scenario requires it, you can customize the configuration file as an advanced task. The configuration file can include custom rules, for example, to handle hotfix files that have specific extensions, or to define behaviors for specific exit conditions. For more information, see [Customize the hotfix configuration file](#BKMK_CONFIG_FILE) later in this topic.

### Configuration

Configure the following settings. For more information, see the links to sections later in this topic.
- The path to the shared hotfix root folder that contains the updates to apply and that contains the hotfix configuration file. You can type this path in the CAU UI or configure the **HotfixRootFolderPath\=\<Path>** PowerShell plug\-in argument. 

   > [!NOTE]
   > You can specify the hotfix root folder as a local folder path or as a UNC path of the form *\\\\ServerName\\Share\\RootFolderName*. A domain\-based or standalone DFS Namespace path can be used. However, the plug\-in features that check access permissions in the hotfix configuration file are incompatible with a DFS Namespace path, so if you configure one, you must disable the check for access permissions by using the CAU UI or by configuring the **DisableAclChecks\='True'** plug\-in argument.
- Settings on the server that hosts the hotfix root folder to check for appropriate permissions to access the folder and ensure the integrity of the data accessed from the SMB shared folder \(SMB signing or SMB Encryption\). For more information, see [Restrict access to the hotfix root folder](#BKMK_ACL).

### Additional options

- Optionally, configure the plug\-in so that SMB Encryption is enforced when accessing data from the hotfix file share. In the CAU UI, on the **Additional Options** page, select the **Require SMB Encryption in accessing the hotfix root folder** option, or configure the **RequireSMBEncryption\='True'** PowerShell plug\-in argument. 
  > [!IMPORTANT]
  > You must perform additional configuration steps on the SMB server to enable SMB data integrity with SMB signing or SMB Encryption. For more information, see Step 4 in [Restrict access to the hotfix root folder](#BKMK_ACL). If you select the option to enforce the use of SMB Encryption, and the hotfix root folder is not configured for access by using SMB Encryption, the Updating Run will fail.
- Optionally, disable the default checks for sufficient permissions for the hotfix root folder and the hotfix configuration file. In the CAU UI, select **Disable check for administrator access to the hotfix root folder and configuration file**, or configure the **DisableAclChecks\='True'** plug\-in argument.
- Optionally, configure the **HotfixInstallerTimeoutMinutes\=<Integer>** argument to specify how long the hotfix plug\-in waits for the hotfix installer process to return. \(The default is 30 minutes.\) For example, to specify a timeout period of two hours, set **HotfixInstallerTimeoutMinutes\=120**.
- Optionally, configure the **HotfixConfigFileName \= <name>** plug\-in argument to specify a name for the hotfix configuration file that is located in the hotfix root folder. If not specified, the default name DefaultHotfixConfig.xml is used.
  
### <a name="BKMK_HF_ROOT"></a>Configure a hotfix root folder structure

For the hotfix plug\-in to work, hotfixes must be stored in a well\-defined structure in an SMB file share \(hotfix root folder\), and you must configure the hotfix plug\-in with the path to the hotfix root folder by using the CAU UI or the CAU PowerShell cmdlets. This path is passed to the plug\-in as the **HotfixRootFolderPath** argument. You can choose one of several structures for the hotfix root folder, according to your updating needs, as shown in the following examples. Files or folders that do not adhere to the structure are ignored.  
  
#### Example 1 - Folder structure used to apply hotfixes to all cluster nodes
  
To specify that hotfixes apply to all cluster nodes, copy them to a folder named **CAUHotfix\_All** under the hotfix root folder. In this example, the **HotfixRootFolderPath** plug\-in argument is set to *\\\\MyFileServer\\Hotfixes\\Root\\*. The **CAUHotfix\_All** folder contains three updates with the extensions .msu, .msi, and .msp that will be applied to all cluster nodes. The update file names are only for illustration purposes.  
  
> [!NOTE]  
> In this and the following examples, the hotfix configuration file with its default name DefaultHotfixConfig.xml is shown in its required location in the hotfix root folder.  
  
```
\\MyFileServer\Hotfixes\Root\   
   DefaultHotfixConfig.xml  
   CAUHotfix_All\   
      Update1.msu   
      Update2.msi   
      Update3.msp  
      ...  
```  
  
#### Example 2 - Folder structure used to apply certain updates only to a specific node
  
To specify hotfixes that apply only to a specific node, use a subfolder under the hotfix root folder with the name of the node. Use the NetBIOS name of the cluster node, for example, *ContosoNode1*. Then, move the updates that apply only to this node to this subfolder. In the following example, the **HotfixRootFolderPath** plug\-in argument is set to *\\\\MyFileServer\\Hotfixes\\Root\\*. Updates in the **CAUHotfix\_All** folder will be applied to all cluster nodes, and *Node1\_Specific\_Update.msu* will be applied only to *ContosoNode1*.  
  
```
\\MyFileServer\Hotfixes\Root\   
   DefaultHotfixConfig.xml  
   CAUHotfix_All\   
      Update1.msu   
      Update2.msi   
      Update3.msp  
      ...  
   ContosoNode1\   
      Node1_Specific_Update.msu   
      ...  
```  
  
#### Example 3 - Folder structure used to apply updates other than .msu, .msi, and .msp files
  
By default, **Microsoft.HotfixPlugin** only applies updates with the .msu, .msi, or .msp extension. However, certain updates might have different extensions and require different installation commands. For example, you might need to apply a firmware update with the extension .exe to a node in a cluster. You can configure the hotfix root folder with a subfolder that indicates a specific, non\-default update type should be installed. You must also configure a corresponding folder installation rule that specifies the installation command in the `<FolderRules>` element in the hotfix configuration XML file.  
  
In the following example, the **HotfixRootFolderPath** plug\-in argument is set to *\\\\MyFileServer\\Hotfixes\\Root\\*. Several updates will be applied to all cluster nodes, and a firmware update *SpecialHotfix1.exe* will be applied to *ContosoNode1* by using *FolderRule1*. For information about configuring *FolderRule1* in the hotfix configuration file, see [Customize the hotfix configuration file](#BKMK_CONFIG_FILE) later in this topic.  
  
```
\\MyFileServer\Hotfixes\Root\   
   DefaultHotfixConfig.xml  
   CAUHotfix_All\   
      Update1.msu   
      Update2.msi   
      Update3.msp  
      ...  
  
   ContosoNode1\   
      FolderRule1\  
          SpecialHotfix1.exe  
      ...  
```

### <a name="BKMK_CONFIG_FILE"></a>Customize the hotfix configuration file  
The hotfix configuration file controls how **Microsoft.HotfixPlugin** installs specific hotfix file types in a failover cluster. The XML schema for the configuration file is defined in HotfixConfigSchema.xsd, which is located in the following folder on a computer where the CAU tools are installed:  
  
**%systemroot%\\System32\\WindowsPowerShell\\v1.0\\Modules\\ClusterAwareUpdating folder**  
  
To customize the hotfix configuration file, copy the sample configuration file DefaultHotfixConfig.xml from this location to the hotfix root folder and make appropriate modifications for your scenario.  
  
> [!IMPORTANT]  
> To apply most hotfixes provided by Microsoft and other updates, the default hotfix configuration file can be used without modification. Customization of the hotfix configuration file is a task only in advanced usage scenarios.  
  
By default, the hotfix configuration XML file defines installation rules and exit conditions for the following two categories of hotfixes:  
  
-   Hotfix files with extensions that the plug\-in can install by default \(.msu, .msi, and .msp files\).  
  
    These are defined as `<ExtensionRules>` elements in the `<DefaultRules>` element. There is one `<Extension>` element for each of the default supported file types. The general XML structure is as follows:  
  
    ```xml  
    <DefaultRules>  
        <ExtensionRules>  
          <Extension name="MSI">  
            <!-- Template and ExitConditions elements for installation of .msi files follow -->  
             ...  
          </Extension>  
          <Extension name="MSU">  
            <!-- Template and ExitConditions elements for installation of .msu files follow -->  
             ...  
          </Extension>  
          <Extension name="MSP">  
            <!-- Template and ExitConditions elements for installation of .msp files follow -->  
             ...  
          </Extension>  
             ...  
       </ExtensionRules>  
    </DefaultRules>  
    ```  
  
    If you need to apply certain update types to all cluster nodes in your environment, you can define additional `<Extension>` elements.  
  
-   Hotfix or other update files that are not .msi, .msu, or .msp files, for example, non\-Microsoft drivers, firmware, and BIOS updates.  
  
    Each non\-default file type is configured as a `<Folder>` element in the `<FolderRules>` element. The name attribute of the `<Folder>` element must be identical to the name of a folder in the hotfix root folder that will contain updates of the corresponding type. The folder can be in the **CAUHotfix\_All** folder or in a node\-specific folder. For example, if *FolderRule1* is configured in the hotfix root folder, configure the following element in the XML file to define an installation template and exit conditions for the updates in that folder:  
  
    ```xml  
    <FolderRules>  
          <Folder name="FolderRule1">  
            <!-- Template and ExitConditions elements for installation of updates in FolderRule1 follow -->  
             ...  
          </Folder>  
          ...  
    </FolderRules>  
    ```  
  
The following tables describe the `<Template>` attributes and the possible `<ExitConditions>` subelements.  
  
|`<Template>` attribute|Description|  
|--------------------------|---------------|  
|`path`|The full path to the installation program for the file type that is defined in the `<Extension name>` attribute.<br /><br />To specify the path to an update file in the hotfix root folder structure, use `$update$`.|  
|`parameters`|A string of required and optional parameters for the program that is specified in `path`.<br /><br />To specify a parameter that is the path to an update file in the hotfix root folder structure, use `$update$`.|  
  
|`<ExitConditions>` subelement|Description|  
|---------------------------------|---------------|  
|`<Success>`|Defines one or more exit codes that indicate the specified update succeeded. This is a required subelement.|  
|`<Success_RebootRequired>`|Optionally defines one or more exit codes that indicate the specified update succeeded and the node must restart. <br>**Note:** Optionally, the `<Folder>` element can contain the `alwaysReboot` attribute. If this attribute is set, it indicates that if a hotfix installed by this rule returns one of the exit codes that is defined in `<Success>`, it is interpreted as a `<Success_RebootRequired>` exit condition.|  
|`<Fail_RebootRequired>`|Optionally defines one or more exit codes that indicate the specified update failed and the node must restart.|  
|`<AlreadyInstalled>`|Optionally defines one or more exit codes that indicate the specified update was not applied because it is already installed.|  
|`<NotApplicable>`|Optionally defines one or more exit codes that indicate the specified update was not applied because it does not apply to the cluster node.|  
  
> [!IMPORTANT]  
> Any exit code that is not explicitly defined in `<ExitConditions>` is interpreted as the update failed, and the node does not restart.  
  
### <a name="BKMK_ACL"></a>Restrict access to the hotfix root folder  
You must perform several steps to configure the SMB file server and file share to help secure the hotfix root folder files and hofix configuration file for access only in the context of **Microsoft.HotfixPlugin**. These steps enable several features that help prevent possible tampering with the hotfix files in a way that might compromise the failover cluster.  
  
The general steps are as follows:  
  
1.  Identify the user account that is used for Updating Runs by using the plug\-in  
  
2.  Configure this user account in the necessary groups on an SMB file server  
  
3.  Configure permissions to access the hotfix root folder  
  
4.  Configure settings for SMB data integrity  
  
5.  Enable a Windows Firewall rule on the SMB server  
  
#### Step 1. Identify the user account that is used for Updating Runs by using the hotfix plug\-in
  
The account that is used in CAU to check security settings while performing an Updating Run using **Microsoft.HotfixPlugin** depends on whether CAU is used in remote\-updating mode or self\-updating mode, as follows:  
  
-   **Remote\-updating mode** The account that has administrative privileges on the cluster to preview and apply updates.  
  
-   **Self\-updating mode** The name of the virtual computer object that is configured in Active Directory for the CAU clustered role. This is either the name of a prestaged virtual computer object in Active Directory for the CAU clustered role or the name that is generated by CAU for the clustered role. To obtain the name if it is generated by CAU, run the **Get\-CauClusterRole** CAU PowerShell cmdlet. In the output, **ResourceGroupName** is the name of the generated virtual computer object account.  
  
#### Step 2. Configure this user account in the necessary groups on an SMB file server
  
> [!IMPORTANT]  
> You must add the account that is used for Updating Runs as a local administrator account on the SMB server. If this is not permitted because of the security policies in your organization, configure this account with the necessary permissions on the SMB server by using the following procedure.  
  
##### To configure a user account on the SMB server  
  
1.  Add the account that is used for Updating Runs to the Distributed COM Users group and to one of the following groups: Power User, Server Operation, or Print Operator.  
  
2.  To enable the necessary WMI permissions for the account, start the WMI Management Console on the SMB server. Start PowerShell and then type the following command:  
  
    ```  
    wmimgmt.msc  
    ```  
  
3.  In the console tree, right\-click **WMI Control \(Local\)**, and then click **Properties**.  
  
4.  Click **Security**, and then expand **Root**.  
  
5.  Click **CIMV2**, and then click **Security**.  
  
6.  Add the account that is used for Updating Runs to the **Group or user names** list.  
  
7.  Grant the **Execute Methods** and **Remote Enable** permissions to the account that is used for Updating Runs.  
  
#### Step 3. Configure permissions to access the hotfix root folder
  
By default, when you attempt to apply updates, the hotfix plug\-in checks the configuration of the NTFS file system permissions for access to the hotfix root folder. If the folder access permissions are not configured properly, an Updating Run using the hotfix plug\-in might fail.  
  
If you use the default configuration of the hotfix plug\-in, ensure that the folder access permissions meet the following requirements.  
  
-   The Users group has Read permission.  
  
-   If the plug\-in will apply updates with the .exe extension, the Users group has Execute permission.  
  
-   Only certain security principals are permitted \(but are not required\) to have Write or Modify permission. The allowed principals are the local Administrators group, SYSTEM, CREATOR OWNER, and TrustedInstaller. Other accounts or groups are not permitted to have Write or Modify permission on the hotfix root folder.  
  
Optionally, you can disable the preceding checks that the plug\-in performs by default. You can do this in one of two ways:  
  
-   If you are using the CAU PowerShell cmdlets, configure the **DisableAclChecks\='True'** argument in the **CauPluginArguments** parameter for the hotfix plug\-in.  
  
-   If you are using the CAU UI, select the **Disable check for administrator access to the hotfix root folder and configuration file** option on the **Additional Update Options** page of the wizard that is used to configure Updating Run options.  
  
However, as a best practice in many environments, we recommend that you use the default configuration to enforce these checks.  
  
#### Step 4. Configure settings for SMB data integrity
  
To check for data integrity in the connections between the cluster nodes and the SMB file share, the hotfix plug\-in requires that you enable settings on the SMB file share for SMB signing or SMB Encryption. SMB Encryption, which provides enhanced security and better performance in many environments, is supported starting in Windows Server 2012. You can enable either or both of these settings, as follows:  
  
-   To enable SMB signing, see the procedure in the [article 887429](https://support.microsoft.com/kb/887429) in the Microsoft Knowledge Base.  
  
-   To enable SMB Encryption for the SMB shared folder, run the following PowerShell cmdlet on the SMB server:  
  
    ```PowerShell  
    Set-SmbShare <ShareName> -EncryptData $true  
    ```  
  
    Where <*ShareName*> is the name of the SMB shared folder.  
  
Optionally, to enforce the use of SMB Encryption in the connections to the SMB server, select the **Require SMB Encryption in accessing the hotfix root folder** option in the CAU UI, or configure the **RequireSMBEncryption\='True'** plug\-in argument by using the CAU PowerShell cmdlets.  
  
> [!IMPORTANT]  
> If you select the option to enforce the use of SMB Encryption, and the hotfix root folder is not configured for connections that use SMB Encryption, the Updating Run will fail.  
  
#### Step 5. Enable a Windows Firewall rule on the SMB server
  
You must enable the **File Server Remote Management \(SMB\-in\)** rule in Windows Firewall on the SMB file server. This is enabled by default in Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012.  
  
## See also  
  
-   [Cluster-Aware Updating Overview](cluster-aware-updating.md)
  
-   [Cluster-Aware Updating Windows PowerShell Cmdlets](https://docs.microsoft.com/en-us/powershell/module/clusterawareupdating)  
  
-   [Cluster-Aware Updating Plug-in Reference](https://msdn.microsoft.com/library/hh418084.aspx)  
  
