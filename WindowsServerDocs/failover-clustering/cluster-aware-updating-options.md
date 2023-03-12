---
ms.assetid: 2f4b6641-0ec2-4b1c-85fb-a1f1d16685c8
title: Cluster-Aware Updating advanced options and updating run profiles
ms.topic: article
ms.prod: windows-server-threshold
manager: dongill
ms.author: jgerend
author: JasonGerend
ms.date: 08/06/2018
description: How to configure advanced options and updating run profiles for Cluster-Aware Updating (CAU)
---
# Cluster-Aware Updating advanced options and updating run profiles

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012.

This topic describes Updating Run options that can be configured for a [Cluster-Aware Updating](cluster-aware-updating.md) (CAU) Updating Run. These advanced options can be configured when you use either the CAU UI or the CAU Windows PowerShell cmdlets to apply updates or to configure self-updating options.

Most configuration settings can be saved as an XML file called an Updating Run Profile and reused for later Updating Runs. The default values for the Updating Run options that are provided by CAU can also be used in many cluster environments.

For information about additional options that you can specify for each Updating Run and about Updating Run Profiles, see the following sections later in this topic:

Options that you specify when you request an Updating Run
Use Updating Run Profiles
Options that can be set in an Updating Run Profile

The following table lists options that you can set in a CAU Updating Run Profile. 

> [!NOTE] 
> To set the PreUpdateScript or PostUpdateScript option, ensure that Windows PowerShell and .NET Framework 4.6 or 4.5 are installed and that PowerShell remoting is enabled on each node in the cluster. For more information, see Configure the nodes for remote management in [Requirements and Best Practices for Cluster-Aware Updating](cluster-aware-updating-requirements.md).


|Option|Default value|Details|  
|------------|-------------------|-------------|  
|**StopAfter**|Unlimited time|Time in minutes after which the Updating Run will be stopped if it has not completed. **Note:**  If you specify a pre-update or a post-update PowerShell script, the entire process of running scripts and performing updates must be complete within the **StopAfter** time limit.|  
|**WarnAfter**|By default, no warning appears|Time in minutes after which a warning will appear if the Updating Run (including a pre-update script and a post-update script, if they are configured) has not completed.|  
|**MaxRetriesPerNode**|3|Maximum number of times that the update process (including a pre-update script and a post-update script, if they are configured) will be retried per node. The maximum is 64.|  
|**MaxFailedNodes**|For most clusters, an integer that is approximately one-third of the number of cluster nodes|Maximum number of nodes on which updating can fail, either because the nodes fail or the Cluster service stops running. If one more node fails, the Updating Run is stopped.<br /><br /> The valid range of values is 0 to 1 less than the number of cluster nodes.|  
|**RequireAllNodesOnline**|None|Specifies that all nodes must be online and reachable before updating begins.|  
|**RebootTimeoutMinutes**|15|Time in minutes that CAU will allow for restarting a node (if a restart is necessary) and starting all auto-start services. If the restart process doesn't complete within this time, the Updating Run on that node is marked as failed.|  
|**PreUpdateScript**|None|The path and file name for a PowerShell script to run on each node before updating begins, and before the node is put into maintenance mode. The file name extension must be **.ps1**, and the total length of the path plus file name must not exceed 260 characters. As a best practice, the script should be located on a disk in cluster storage, or at a highly available network file share, to ensure that it is always accessible to all of the cluster nodes. If the script is located on a network file share, ensure that you configure the file share for Read permission for the Everyone group, and restrict write access to prevent tampering with the files by unauthorized users.<br /><br /> If you specify a pre-update script, be sure that settings such as the time limits (for example, **StopAfter**) are configured to allow the script to run successfully. These limits span the entire process of running scripts and installing updates, not just the process of installing updates.|  
|**PostUpdateScript**|None|The path and file name for a PowerShell script to run after updating completes (after the node leaves maintenance mode). The file name extension must be **.ps1** and the total length of the path plus file name must not exceed 260 characters. As a best practice, the script should be located on a disk in cluster storage, or at a highly available network file share, to ensure that it is always accessible to all of the cluster nodes. If the script is located on a network file share, ensure that you configure the file share for Read permission for the Everyone group, and restrict write access to prevent tampering with the files by unauthorized users.<br /><br /> If you specify a post-update script, be sure that settings such as the time limits (for example, **StopAfter**) are configured to allow the script to run successfully. These limits span the entire process of running scripts and installing updates, not just the process of installing updates.|  
|**ConfigurationName**|This setting only has an effect if you run scripts.<br /><br /> If you specify a pre-update script or a post-update script, but you do not specify a **ConfigurationName**, the default session configuration for PowerShell (Microsoft.PowerShell) is used.|Specifies the PowerShell session configuration that defines the session in which scripts (specified by **PreUpdateScript** and **PostUpdateScript**) are run, and can limit the commands that can be run.|  
|**CauPluginName**|**Microsoft.WindowsUpdatePlugin**|Plug-in that you configure Cluster-Aware Updating to use to preview updates or perform an Updating Run. For more information, see [How Cluster-Aware Updating plug-ins work](cluster-aware-updating-plug-ins.md).|  
|**CauPluginArguments**|None|A set of *name=value* pairs (arguments) for the updating plug-in to use, for example:<br /><br /> **Domain=Domain.local**<br /><br /> These *name=value* pairs must be meaningful to the plug-in that you specify in **CauPluginName**.<br /><br /> To specify an argument using the CAU UI, type the *name*, press the Tab key, and then type the corresponding *value*. Press the Tab key again to provide the next argument. Each *name* and *value* are automatically separated with an equal (=) sign. Multiple pairs are automatically separated with semicolons.<br /><br /> For the default **Microsoft.WindowsUpdatePlugin** plug-in, no arguments are needed. However, you can specify an optional argument, for example to specify a standard Windows Update Agent query string to filter the set of updates that are applied by the plug-in. For a *name*, use **QueryString**, and for a *value*, enclose the full query in quotation marks.<br /><br /> For more information, see [How Cluster-Aware Updating plug-ins work](cluster-aware-updating-plug-ins.md).|  
  
##  <a name="BKMK_runtime"></a> Options that you specify when you request an Updating Run  
 The following table lists options (other than those in an Updating Run Profile) that you can specify when you request an Updating Run. For information about options that you can set in an Updating Run Profile, see the preceding table.  
  
|Option|Default value|Details|  
|------------|-------------------|-------------|  
|**ClusterName**|None <br>**Note:**  This option must be set only when the CAU UI is not run on a failover cluster node, or you want to reference a failover cluster different from where the CAU UI is run.|NetBIOS name of the cluster on which to perform the Updating Run.|  
|**Credential**|Current account credentials|Administrative credentials for the target cluster on which the Updating Run will be performed. You may already have the necessary credentials if you start the CAU UI (or open a PowerShell session, if you're using the CAU PowerShell cmdlets) from an account that has administrator rights and permissions on the cluster.|  
|**NodeOrder**|By default, CAU starts with the node that owns the smallest number of clustered roles, then progresses to the node that has the second smallest number, and so on.|Names of the cluster nodes in the order that they should be updated (if possible).|  
  
##  <a name="BKMK_profile"></a> Use Updating Run Profiles  
 Each Updating Run can be associated with a specific Updating Run Profile. The default Updating Run Profile is stored in the *%windir%\cluster* folder. If you're using the CAU UI in remote-updating mode, you can specify an Updating Run Profile at the time that you apply updates, or you can use the default Updating Run profile. If you're using CAU in self-updating mode, you can import the settings from a specified Updating Run Profile when you configure the self-updating options. In both cases, you can override the displayed values for the Updating Run options according to your needs. If you want, you can save the Updating Run options as an Updating Run Profile with the same file name or a different file name. The next time that you apply updates or configure self-updating options, CAU automatically selects the Updating Run Profile that was previously selected.  
  
 You can modify an existing Updating Run Profile or create a new one by selecting **Create or modify Updating Run Profile** in the CAU UI.

Here are some important notes about using Updating Run Profiles:

* An Updating Run Profile doesn't store cluster-specific information such as administrative credentials. If you're using CAU in self-updating mode, the Updating Run Profile also doesn't store the self-updating schedule information. This makes it possible to share an Updating Run Profile across all failover clusters in a specified class.
* If you configure self-updating options using an Updating Run Profile and later modify the profile with different values for the Updating Run options, the self-updating configuration doesn't change automatically. To apply the new Updating Run settings, you must configure the self-updating options again.
* The Run Profile Editor unfortunately doesn't support file paths that include spaces, such as *C:\Program Files*. As a workaround, store your pre and post update scripts in a path that doesn't include spaces, or use PowerShell exclusively to manage Run Profiles, putting quotes around the path when running **Invoke-CauRun**.

### Windows PowerShell equivalent commands
  
 You can import the settings from an Updating Run Profile when you run the **Invoke-CauRun**, **Add-CauClusterRole**, or **Set-CauClusterRole** cmdlet.  
  
 The following example performs a scan and a full Updating Run on the cluster named *CONTOSO-FC1*, using the Updating Run options that are specified in *C:\Windows\Cluster\DefaultParameters.xml*. Default values are used for the remaining cmdlet parameters.  
  
```powershell  
$MyRunProfile = Import-Clixml C:\Windows\Cluster\DefaultParameters.xml  
Invoke-CauRun –ClusterName CONTOSO-FC1 @MyRunProfile   
```  
  
 By using an Updating Run Profile, you can update a failover cluster in a repeatable fashion with consistent settings for exception management, time bounds, and other operational parameters. Because these settings are typically specific to a class of failover clusters—such as “All Microsoft SQL Server clusters”, or “My business-critical clusters”—you might want to name each Updating Run Profile according to the class of Failover Clusters it will be used with. In addition, you might want to manage the Updating Run Profile on a file share that is accessible to all of the failover clusters of a specific class in your IT organization.  
  
  
  
## See also

-   [Cluster-Aware Updating](cluster-aware-updating.md)
  
-   [Cluster-Aware Updating Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/clusterawareupdating/?view=win10-ps)