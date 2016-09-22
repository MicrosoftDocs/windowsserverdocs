---
title: Cluster-Aware Updating Overview
ms.topic: article
manager:
ms.author:
author:
ms.date:
ms.prod:
---
# Cluster-Aware Updating Overview
This topic provides an overview of Cluster\-Aware Updating \(CAU\), a feature that automates the software updating process on clustered servers while maintaining availability.  
  
## <a name="BKMK_OVER"></a>Feature description  
CAU is an automated feature that enables you to update clustered servers with little or no loss in availability during the update process. During an Updating Run, CAU transparently performs the following tasks:  
  
-   Puts each node of the cluster into node maintenance mode  
  
-   Moves the clustered roles off the node  
  
-   Installs the updates and any dependent updates  
  
-   Performs a restart if necessary  
  
-   Brings the node out of maintenance mode  
  
-   Restores the clustered roles on the node  
  
-   Moves to update the next node  
  
For many clustered roles in the cluster, the automatic update process triggers a planned failover. This can cause a transient service interruption for connected clients. However, in the case of continuously available workloads, such as Hyper\-V with live migration or file server with SMB Transparent Failover, CAU can coordinate cluster updates with no impact to the service availability.  
  
> [!NOTE]  
> The CAU feature is only compatible with [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] failover clusters and the clustered roles that are supported on those versions.  
  
## <a name="BKMK_APP"></a>Practical applications  
  
-   CAU reduces service outages in clustered services, reduces the need for manual updating workarounds, and makes the end\-to\-end cluster updating process more reliable for the administrator. When the CAU feature is used in conjunction with continuously available cluster workloads, such as continuously available file servers \(file server workload with SMB Transparent Failover\) or Hyper\-V, the cluster updates can be performed with zero impact to service availability for clients.  
  
-   CAU facilitates the adoption of consistent IT processes across the enterprise. Updating Run Profiles can be created for different classes of failover clusters and then managed centrally on a file share to ensure that CAU deployments throughout the IT organization apply updates consistently, even if the clusters are managed by different lines\-of\-business or administrators.  
  
-   CAU can schedule Updating Runs on regular daily, weekly, or monthly intervals to help coordinate cluster updates with other IT management processes.  
  
-   CAU provides an extensible architecture to update the cluster software inventory in a cluster\-aware fashion. This can be used by publishers to coordinate the installation of software updates that are not published to Windows Update or Microsoft Update or that are not available from Microsoft, for example, updates for non\-Microsoft device drivers.  
  
-   CAU self\-updating mode enables a "cluster in a box" appliance \(a set of clustered physical machines, typically packaged in one chassis\) to update itself. Typically, such appliances are deployed in branch offices with minimal local IT support to manage the clusters. Self\-updating mode offers great value in these deployment scenarios.  
  
## Important functionality  
The following is a description of important CAU functionality:  
  
-   A user interface \(UI\) and a set of [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets that you can use to preview, apply, monitor, and report on the updates  
  
-   An end\-to\-end automation of the cluster\-updating operation \(an Updating Run\), orchestrated by one or more Update Coordinator computers  
  
-   A default plug\-in that integrates with the existing Windows Update Agent \(WUA\) and Windows Server Update Services \(WSUS\) infrastructure in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] to apply important Microsoft updates  
  
-   A second plug\-in that can be used to apply Microsoft hotfixes, and that can be customized to apply non\-Microsoft updates  
  
-   Updating Run Profiles that you configure with settings for Updating Run options, such as the maximum number of times that the update will be retried per node. Updating Run Profiles enable you to rapidly reuse the same settings across Updating Runs and easily share the update settings with other failover clusters.  
  
-   An extensible architecture that supports new plug\-in development to coordinate other node\-updating tools across the cluster, such as custom software installers, BIOS updating tools, and network adapter or host bus adapter \(HBA\) updating tools.  
  
CAU can coordinate the complete cluster updating operation in two modes:  
  
-   **Self\-updating mode** For this mode, the CAU clustered role is configured as a workload on the failover cluster that is to be updated, and an associated update schedule is defined. The cluster updates itself at scheduled times by using a default or custom Updating Run profile. During the Updating Run, the CAU Update Coordinator process starts on the node that currently owns the CAU clustered role, and the process sequentially performs updates on each cluster node. To update the current cluster node, the CAU clustered role fails over to another cluster node, and a new Update Coordinator process on that node assumes control of the Updating Run. In self\-updating mode, CAU can update the failover cluster by using a fully automated, end\-to\-end updating process. An administrator can also trigger updates on\-demand in this mode, or simply use the remote\-updating approach if desired. In self\-updating mode, an administrator can get summary information about an Updating Run in progress by connecting to the cluster and running the **Get\-CauRun** Windows PowerShell cmdlet.  
  
-   **Remote\-updating mode** For this mode, a remote computer, which is called an Update Coordinator, is configured with the CAU tools. The Update Coordinator is not a member of the cluster that is updated during the Updating Run. From the remote computer, the administrator triggers an on\-demand Updating Run by using a default or custom Updating Run profile. Remote\-updating mode is useful for monitoring real\-time progress during the Updating Run, and for clusters that are running on Server Core installations.  
  
## <a name="BKMK_SOFT"></a>Hardware and software requirements  
To use CAU in self\-updating mode, the Failover Clustering Tools must be installed on each cluster node.  
  
To enable remote\-updating mode for a [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] failover cluster, you must install the Failover Clustering Tools from the RSAT on a local or a remote computer that is running [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)] and that has network connectivity to the failover cluster.  
  
> [!NOTE]  
> -   You must use the Failover Clustering Tools from the [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] RSAT to remotely manage updates for a [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] failover cluster. You can also use the [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] RSAT to remotely manage updates on a [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] failover cluster.  
> -   To use CAU only in remote\-updating mode, installation of the Failover Clustering Tools on the cluster nodes is not required. However, certain CAU features will not be available. For more information, see [Requirements and Best Practices for Cluster\-Aware Updating](http://go.microsoft.com/fwlink/p/?LinkId=234906).  
> -   Unless you are using CAU only in self\-updating mode, the computer on which the CAU tools are installed and that coordinates the updates cannot be a member of the failover cluster.  
  
To enable self\-updating mode, the CAU clustered role must also be added to the failover cluster. To do this by using the CAU UI, under **Cluster Actions**, use the **Configure Self\-Updating Options** action. Alternatively, run the [Add\-CauClusterRole](http://technet.microsoft.com/library/hh847235.aspx)[!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlet.  
  
To uninstall CAU, uninstall the Failover Clustering feature or Failover Clustering Tools by using Server Manager, [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets, or the DISM command\-line tools.  
  
### Additional requirements and best practices  
To ensure that CAU can update the cluster nodes successfully, and for additional guidance for configuring your failover cluster environment to use CAU, you can run the CAU Best Practices Analyzer.  
  
For detailed requirements and best practices for using CAU, and information about running the CAU Best Practices Analyzer, see [Requirements and Best Practices for Cluster\-Aware Updating](http://go.microsoft.com/fwlink/p/?LinkId=234906).  
  
### Starting CAU  
  
##### To start the CAU UI from Server Manager  
  
1.  Start Server Manager.  
  
2.  Do one of the following:  
  
    -   On the **Tools** menu, click **Cluster\-Aware Updating**.  
  
    -   If one or more cluster nodes, or the cluster, is added to Server Manager, on the **All Servers** page, right\-click the name of a node \(or the name of the cluster\), and then click **Update Cluster**.  
  
## <a name="BKMK_LINKS"></a>See also  
The following links provide more information about using CAU.  
  
-   [Requirements and Best Practices for Cluster\-Aware Updating](http://go.microsoft.com/fwlink/p/?LinkId=234906)  
  
-   [Cluster\-Aware Updating: Frequently Asked Questions](http://technet.microsoft.com/library/hh831367.aspx)  
  
-   [Advanced Options and Updating Run Profiles for CAU](http://go.microsoft.com/fwlink/p/?LinkId=234907)  
  
-   [How CAU Plug\-ins Work](http://go.microsoft.com/fwlink/p/?LinkId=235333)  
  
-   [Cluster\-Aware Updating Cmdlets in Windows PowerShell](http://go.microsoft.com/fwlink/p/?LinkId=237675)  
  
-   [Cluster\-Aware Updating Plug\-in Reference](http://msdn.microsoft.com/library/hh418084.aspx)  
  

