---
title: Cluster-Aware Updating overview
ms.topic: article
ms.prod: windows-server-threshold
ms.topic: article
ms.manager: dongill
author: JasonGerend
ms.author: jgerend
ms.technology: storage-failover-clustering
ms.date: 08/06/2018
description: Cluster-Aware Updating (CAU) automates software update installation on clusters running Windows Server.
ms.assetid: 3c2993b4-aa81-452b-a5c3-3724ad95d892
---
# Cluster-Aware Updating overview

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic provides an overview of Cluster\-Aware Updating \(CAU\), a feature that automates the software updating process on clustered servers while maintaining availability.

> [!NOTE]
> When updating [Storage Spaces Direct](../storage/storage-spaces/storage-spaces-direct-overview.md) clusters, we recommend using Cluster-Aware Updating.
  
## <a name="BKMK_OVER"></a>Feature description  
Cluster-Aware Updating is an automated feature that enables you to update servers in a [failover cluster](failover-clustering-overview.md) with little or no loss in availability during the update process. During an Updating Run, Cluster-Aware Updating transparently performs the following tasks:  

1. Puts each node of the cluster into node maintenance mode.
2. Moves the clustered roles off the node.
3. Installs the updates and any dependent updates.
4. Performs a restart if necessary.
5. Brings the node out of maintenance mode.
6. Restores the clustered roles on the node.
7. Moves to update the next node.

For many clustered roles in the cluster, the automatic update process triggers a planned failover. This can cause a transient service interruption for connected clients. However, in the case of continuously available workloads, such as Hyper\-V with live migration or file server with SMB Transparent Failover, Cluster-Aware Updating can coordinate cluster updates with no impact to the service availability.    
  
## Practical applications  
  
-   CAU reduces service outages in clustered services, reduces the need for manual updating workarounds, and makes the end\-to\-end cluster updating process more reliable for the administrator. When the CAU feature is used in conjunction with continuously available cluster workloads, such as continuously available file servers \(file server workload with SMB Transparent Failover\) or Hyper\-V, the cluster updates can be performed with zero impact to service availability for clients.  
  
-   CAU facilitates the adoption of consistent IT processes across the enterprise. Updating Run Profiles can be created for different classes of failover clusters and then managed centrally on a file share to ensure that CAU deployments throughout the IT organization apply updates consistently, even if the clusters are managed by different lines\-of\-business or administrators.  
  
-   CAU can schedule Updating Runs on regular daily, weekly, or monthly intervals to help coordinate cluster updates with other IT management processes.  
  
-   CAU provides an extensible architecture to update the cluster software inventory in a cluster\-aware fashion. This can be used by publishers to coordinate the installation of software updates that are not published to Windows Update or Microsoft Update or that are not available from Microsoft, for example, updates for non\-Microsoft device drivers.  
  
-   CAU self\-updating mode enables a "cluster in a box" appliance \(a set of clustered physical machines, typically packaged in one chassis\) to update itself. Typically, such appliances are deployed in branch offices with minimal local IT support to manage the clusters. Self\-updating mode offers great value in these deployment scenarios.  
  
## Important functionality  
The following is a description of important Cluster-Aware Updating functionality:  
  
-   A user interface \(UI\) - the Cluster Aware Updating window - and a set of cmdlets that you can use to preview, apply, monitor, and report on the updates  
  
-   An end\-to\-end automation of the cluster\-updating operation \(an Updating Run\), orchestrated by one or more Update Coordinator computers  
  
-   A default plug\-in that integrates with the existing Windows Update Agent \(WUA\) and Windows Server Update Services \(WSUS\) infrastructure in Windows Server to apply important Microsoft updates  
  
-   A second plug\-in that can be used to apply Microsoft hotfixes, and that can be customized to apply non\-Microsoft updates  
  
-   Updating Run Profiles that you configure with settings for Updating Run options, such as the maximum number of times that the update will be retried per node. Updating Run Profiles enable you to rapidly reuse the same settings across Updating Runs and easily share the update settings with other failover clusters.  
  
-   An extensible architecture that supports new plug\-in development to coordinate other node\-updating tools across the cluster, such as custom software installers, BIOS updating tools, and network adapter or host bus adapter \(HBA\) updating tools.  
  
Cluster-Aware Updating can coordinate the complete cluster updating operation in two modes:  
  
-   **Self\-updating mode** For this mode, the CAU clustered role is configured as a workload on the failover cluster that is to be updated, and an associated update schedule is defined. The cluster updates itself at scheduled times by using a default or custom Updating Run profile. During the Updating Run, the CAU Update Coordinator process starts on the node that currently owns the CAU clustered role, and the process sequentially performs updates on each cluster node. To update the current cluster node, the CAU clustered role fails over to another cluster node, and a new Update Coordinator process on that node assumes control of the Updating Run. In self\-updating mode, CAU can update the failover cluster by using a fully automated, end\-to\-end updating process. An administrator can also trigger updates on\-demand in this mode, or simply use the remote\-updating approach if desired. In self\-updating mode, an administrator can get summary information about an Updating Run in progress by connecting to the cluster and running the **Get\-CauRun** Windows PowerShell cmdlet.  
  
-   **Remote\-updating mode** For this mode, a remote computer, which is called an Update Coordinator, is configured with the CAU tools. The Update Coordinator is not a member of the cluster that is updated during the Updating Run. From the remote computer, the administrator triggers an on\-demand Updating Run by using a default or custom Updating Run profile. Remote\-updating mode is useful for monitoring real\-time progress during the Updating Run, and for clusters that are running on Server Core installations.  
  
## Hardware and software requirements  

CAU can be used on all editions of Windows Server, including Server Core installations. For detailed requirements information, see [Cluster-Aware Updating requirements and best practices](cluster-aware-updating-requirements.md).

### Installing Cluster-Aware Updating
To use CAU, install the Failover Clustering feature in Windows Server and create a failover cluster. The components that support CAU functionality are automatically installed on each cluster node.

To install the Failover Clustering feature, you can use the following tools:
- Add Roles and Features Wizard in Server Manager
- [Install-WindowsFeature](https://docs.microsoft.com/powershell/module/servermanager/Install-WindowsFeature?view=winserver2012r2-ps&viewFallbackFrom=win10-ps) Windows PowerShell cmdlet
- Deployment Image Servicing and Management (DISM) command-line tool

For more information, see [Install the Failover Clustering feature](create-failover-cluster.md#install-the-failover-clustering-feature).

You must also install the Failover Clustering Tools, which are part of the Remote Server Administration Tools and are installed by default when you install the Failover Clustering feature in Server Manager. The Failover Clustering tools include the Cluster-Aware Updating user interface and PowerShell cmdlets. 

You must install the Failover Clustering Tools as follows to support the different CAU updating modes:

- To use CAU in self\-updating mode, install the Failover Clustering Tools on each cluster node.   
  
- To enable remote\-updating mode, install the  Failover Clustering Tools on a computer that has network connectivity to the failover cluster.  
  
> [!NOTE]  
> -   You can't use the Failover Clustering Tools on Windows Server 2012 to manage Cluster-Aware Updating on a newer version of Windows Server. 
> -   To use CAU only in remote\-updating mode, installation of the Failover Clustering Tools on the cluster nodes is not required. However, certain CAU features will not be available. For more information, see [Requirements and Best Practices for Cluster\-Aware Updating](cluster-aware-updating-requirements.md).  
> -   Unless you are using CAU only in self\-updating mode, the computer on which the CAU tools are installed and that coordinates the updates cannot be a member of the failover cluster.  
  
### Enabling self-updating mode
To enable the self-updating mode, you must add the Cluster-Aware Updating clustered role to the failover cluster. To do so, use one of the following methods:
- In Server Manager, select **Tools** > **Cluster-Aware Updating**, then in the Cluster-Aware Updating window, select **Configure cluster self-updating options**. 
- In a PowerShell session, run the [Add-CauClusterRole](https://docs.microsoft.com/powershell/module/clusterawareupdating/Add-CauClusterRole?view=win10-ps) cmdlet.  
  
To uninstall CAU, uninstall the Failover Clustering feature or Failover Clustering Tools by using Server Manager, the [Uninstall-WindowsFeature](https://docs.microsoft.com/powershell/module/servermanager/Uninstall-WindowsFeature?view=win10-ps) cmdlet, or the DISM command\-line tools.  
  
### Additional requirements and best practices  

To ensure that CAU can update the cluster nodes successfully, and for additional guidance for configuring your failover cluster environment to use CAU, you can run the CAU Best Practices Analyzer.  
  
For detailed requirements and best practices for using CAU, and information about running the CAU Best Practices Analyzer, see [Requirements and Best Practices for Cluster\-Aware Updating](cluster-aware-updating-requirements.md).  
  
### Starting Cluster-Aware Updating  
  
##### To start Cluster-Aware Updating from Server Manager  
  
1.  Start Server Manager.  
  
2.  Do one of the following:  
  
    -   On the **Tools** menu, click **Cluster\-Aware Updating**.  
  
    -   If one or more cluster nodes, or the cluster, is added to Server Manager, on the **All Servers** page, right\-click the name of a node \(or the name of the cluster\), and then click **Update Cluster**.  
  
## See also  
The following links provide more information about using Cluster-Aware Updating.  
  
-   [Requirements and Best Practices for Cluster\-Aware Updating](cluster-aware-updating.md)  
  
-   [Cluster\-Aware Updating: Frequently Asked Questions](cluster-aware-updating-faq.md)  
  
-   [Advanced Options and Updating Run Profiles for CAU](cluster-aware-updating-options.md)  
  
-   [How CAU Plug\-ins Work](cluster-aware-updating-plug-ins.md)  
  
-   [Cluster\-Aware Updating Cmdlets in Windows PowerShell](https://docs.microsoft.com/powershell/module/clusterawareupdating/?view=win10-ps&viewFallbackFrom=winserverr2-ps)  
  
-   [Cluster\-Aware Updating Plug\-in Reference](https://docs.microsoft.com/previous-versions/windows/desktop/mscs/cluster-aware-update-plug-in-interfaces-and-classes)  
  

