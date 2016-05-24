---
title: Advanced Options and Updating Run Profiles for CAU_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: aa3d1e90-1626-4aea-8ec3-25f79507870a
author: kumudd
---
# Advanced Options and Updating Run Profiles for CAU_1
This topic describes Updating Run options that can be configured for a CAU Updating Run. These advanced options can be configured when you use either the CAU UI or the CAU [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets to apply updates or to configure self\-updating options.  
  
Most configuration settings can be saved as an XML file called an Updating Run Profile and reused for later Updating Runs. The default values for the Updating Run options that are provided by CAU can also be used in many cluster environments.  
  
For information about additional options that you can specify for each Updating Run and about Updating Run Profiles, see the following sections later in this topic:  
  
-   [Options that you specify when you request an Updating Run](#BKMK_runtime)  
  
-   [Use Updating Run Profiles](#BKMK_profile)  
  
## Options that can be set in an Updating Run Profile  
The following table lists options that you can set in a CAU Updating Run Profile.  
  
> [!IMPORTANT]  
> To set the **PreUpdateScript** or **PostUpdateScript** option, ensure that [!INCLUDE[wps_2](../Token/wps_2_md.md)] 3.0 or 4.0 and .NET Framework 4.5 are installed and that [!INCLUDE[wps_2](../Token/wps_2_md.md)] remoting is enabled on each node in the cluster. For more information, see [Configure nodes for remote management](../Topic/Requirements-and-Best-Practices-for-Cluster-Aware-Updating.md#BKMK_NODE_CONFIG) in [Requirements and Best Practices for Cluster-Aware Updating](../Topic/Requirements-and-Best-Practices-for-Cluster-Aware-Updating.md).  
  
|Option|Default value|Details|  
|----------|-----------------|-----------|  
|**StopAfter**|Unlimited time|Time in minutes after which the Updating Run will be stopped if it has not completed. **Note:** If you specify a pre\-update or a post\-update [!INCLUDE[wps_2](../Token/wps_2_md.md)] script, the entire process of running scripts and performing updates must be complete within the **StopAfter** time limit.|  
|**WarnAfter**|By default, no warning appears|Time in minutes after which a warning will appear if the Updating Run \(including a pre\-update script and a post\-update script, if they are configured\) has not completed.|  
|**MaxRetriesPerNode**|3|Maximum number of times that the update process \(including a pre\-update script and a post\-update script, if they are configured\) will be retried per node. The maximum is 64.|  
|**MaxFailedNodes**|For most clusters, an integer that is approximately one\-third of the number of cluster nodes|Maximum number of nodes on which updating can fail, either because the nodes fail or the Cluster service stops running. If one more node fails, the Updating Run is stopped.<br /><br />The valid range of values is 0 to 1 less than the number of cluster nodes.|  
|**RequireAllNodesOnline**|None|Specifies that all nodes must be online and reachable before updating begins.|  
|**RebootTimeoutMinutes**|15|Time in minutes that CAU will allow for restarting a node \(if a restart is necessary\) and starting all auto\-start services. If the restart process does not complete within this time, the Updating Run on that node is marked as failed.|  
|**PreUpdateScript**|None|The path and file name for a [!INCLUDE[wps_2](../Token/wps_2_md.md)] script to run on each node before updating begins, and before the node is put into maintenance mode. The file name extension must be **.ps1**, and the total length of the path plus file name must not exceed 260 characters. As a best practice, the script should be located on a disk in cluster storage, or at a highly available network file share, to ensure that it is always accessible to all of the cluster nodes. If the script is located on a network file share, ensure that you configure the file share for Read permission for the Everyone group, and restrict write access to prevent tampering with the files by unauthorized users.<br /><br />If you specify a pre\-update script, be sure that settings such as the time limits \(for example, **StopAfter**\) are configured to allow the script to run successfully. These limits span the entire process of running scripts and installing updates, not just the process of installing updates.|  
|**PostUpdateScript**|None|The path and file name for a [!INCLUDE[wps_2](../Token/wps_2_md.md)] script to run after updating completes \(after the node leaves maintenance mode\). The file name extension must be **.ps1** and the total length of the path plus file name must not exceed 260 characters. As a best practice, the script should be located on a disk in cluster storage, or at a highly available network file share, to ensure that it is always accessible to all of the cluster nodes. If the script is located on a network file share, ensure that you configure the file share for Read permission for the Everyone group, and restrict write access to prevent tampering with the files by unauthorized users.<br /><br />If you specify a post\-update script, be sure that settings such as the time limits \(for example, **StopAfter**\) are configured to allow the script to run successfully. These limits span the entire process of running scripts and installing updates, not just the process of installing updates.|  
|**ConfigurationName**|This setting only has an effect if you run scripts.<br /><br />If you specify a pre\-update script or a post\-update script, but you do not specify a **ConfigurationName**, the default session configuration for [!INCLUDE[wps_2](../Token/wps_2_md.md)] \(Microsoft.PowerShell\) is used.|Specifies the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session configuration that defines the session in which scripts \(specified by **PreUpdateScript** and **PostUpdateScript**\) are run, and can limit the commands that can be run.|  
|**CauPluginName**|**Microsoft.WindowsUpdatePlugin**|Plug\-in that you configure Cluster\-Aware Updating to use to preview updates or perform an Updating Run. For more information, see [How Plug\-ins Work](assetId:///847b571b-12b3-473c-953f-75a5a1f51333).|  
|**CauPluginArguments**|None|A set of *name\=value* pairs \(arguments\) for the updating plug\-in to use, for example:<br /><br />**Domain\=Domain.local**<br /><br />These *name\=value* pairs must be meaningful to the plug\-in that you specify in **CauPluginName**.<br /><br />To specify an argument using the CAU UI, type the *name*, press the Tab key, and then type the corresponding *value*. Press the Tab key again to provide the next argument. Each *name* and *value* are automatically separated with an equal \(\=\) sign. Multiple pairs are automatically separated with semicolons.<br /><br />For the default **Microsoft.WindowsUpdatePlugin** plug\-in, no arguments are needed. However, you can specify an optional argument, for example to specify a standard Windows Update Agent query string to filter the set of updates that are applied by the plug\-in. For a *name*, use **QueryString**, and for a *value*, enclose the full query in quotation marks.<br /><br />For more information, see [How Plug\-ins Work](assetId:///847b571b-12b3-473c-953f-75a5a1f51333).|  
  
## <a name="BKMK_runtime"></a>Options that you specify when you request an Updating Run  
The following table lists options \(other than those in an Updating Run Profile\) that you can specify when you request an Updating Run. For information about options that you can set in an Updating Run Profile, see the preceding table.  
  
|Option|Default value|Details|  
|----------|-----------------|-----------|  
|**ClusterName**|None **Note:** This option must be set only when the CAU UI is not run on a failover cluster node, or you want to reference a failover cluster different from where the CAU UI is run.|NetBIOS name of the cluster on which to perform the Updating Run.|  
|**Credential**|Current account credentials|Administrative credentials for the target cluster on which the Updating Run will be performed. You may already have the necessary credentials if you start the CAU UI \(or open a [!INCLUDE[wps_2](../Token/wps_2_md.md)] session, if you are using the CAU [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets\) from an account that has administrator rights and permissions on the cluster.|  
|**NodeOrder**|By default, CAU starts with the node that owns the smallest number of clustered roles, then progresses to the node that has the second smallest number, and so on.|Names of the cluster nodes in the order that they should be updated \(if possible\).|  
  
## <a name="BKMK_profile"></a>Use Updating Run Profiles  
Each Updating Run can be associated with a specific Updating Run Profile. The default Updating Run Profile is stored in the %windir%\\cluster folder. If you are using the CAU UI in remote\-updating mode, you can specify an Updating Run Profile at the time that you apply updates, or you can use the default Updating Run profile. If you are using CAU in self\-updating mode, you can import the settings from a specified Updating Run Profile when you configure the self\-updating options. In both cases, you can override the displayed values for the Updating Run options according to your needs. If you want, you can save the Updating Run options as an Updating Run Profile with the same file name or a different file name. The next time that you apply updates or configure self\-updating options, CAU automatically selects the Updating Run Profile that was previously selected.  
  
An existing Updating Run Profile can also be modified, or a new Updating Run Profile can be created, by selecting **Create or modify Updating Run Profile** in the CAU UI.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
You can import the settings from an Updating Run Profile when you run the **Invoke\-CauRun**, **Add\-CauClusterRole**, or **Set\-CauClusterRole** cmdlet.  
  
The following example performs a scan and a full Updating Run on the cluster named *CONTOSO\-FC1*, using the Updating Run options that are specified in *C:\\Windows\\Cluster\\DefaultParameters.xml*. Default values are used for the remaining cmdlet parameters.  
  
```powershell  
$MyRunProfile = Import-Clixml C:\Windows\Cluster\DefaultParameters.xml  
Invoke-CauRun –ClusterName CONTOSO-FC1 @MyRunProfile   
```  
  
By using an Updating Run Profile, you can update a failover cluster in a repeatable fashion with consistent settings for exception management, time bounds, and other operational parameters. Because these settings are typically specific to a class of failover clusters—such as “All Microsoft SQL Server clusters”, or “My business\-critical clusters”—you might want to name each Updating Run Profile according to the class of Failover Clusters it will be used with. In addition, you might want to manage the Updating Run Profile on a file share that is accessible to all of the failover clusters of a specific class in your IT organization.  
  
> [!NOTE]  
> -   An Updating Run Profile does not store cluster\-specific information such as administrative credentials. If you are using CAU in self\-updating mode, the Updating Run Profile also does not store the self\-updating schedule information. This makes it possible to share an Updating Run Profile across all failover clusters in a specified class.  
> -   If you configure self\-updating options using an Updating Run Profile and later modify the profile with different values for the Updating Run options, the self\-updating configuration does not change automatically. To apply the new Updating Run settings, you must configure the self\-updating options again.  
  
## See also  
  
-   [CAU Overview](assetId:///a8e6dfbb-9d98-4130-86ac-9f6f00241e02)  
  
-   [Cluster\-Aware Updating Cmdlets in Windows PowerShell \[cmdlet stub\]](assetId:///16e9bb53-ae89-4d69-9a6b-fb8201bbf189)  
  
