---
ms.assetid: 6416d125-bcaf-433d-971a-2f0283bca2c2
title: Cluster-Aware Updating - Frequently Asked Questions
ms.topic: article
ms.prod: windows-server-threshold
manager: dongill
ms.author: jgerend
author: JasonGerend
ms.date: 04/28/2017
description: Answers to frequently asked questions about Cluster-Aware Updating in Windows Server.
---
# Cluster-Aware Updating: Frequently Asked Questions

> Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

[Cluster-Aware Updating](cluster-aware-updating.md) \(CAU\) is a feature that coordinates software updates on all servers in a failover cluster in a way that doesn't impact the service availability any more than a planned failover of a cluster node. For some applications with continuous availability features \(such as Hyper\-V with live migration, or an SMB 3.x file server with SMB Transparent Failover\), CAU can coordinate automated cluster updating with no impact on service availability.

## Does CAU support updating Storage Spaces Direct clusters?  
Yes. CAU supports updating [Storage Spaces Direct](../storage/storage-spaces/storage-spaces-direct-overview.md) clusters regardless of the deployment type: hyper-converged or converged. Specifically, CAU orchestration ensures that suspending each cluster node waits for the underlying clustered storage space to be healthy.

## Does CAU work with Windows Server 2008 R2 or Windows 7?  
No. CAU coordinates the cluster updating operation only from computers running Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10, Windows 8.1, or Windows 8. The failover cluster being updated must run Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012.
  
## Is CAU limited to specific clustered applications?  
No. CAU is agnostic to the type of the clustered application. CAU is an external cluster\-updating solution that is layered on top of clustering APIs and PowerShell cmdlets. As such, CAU can coordinate updating for any clustered application that is configured in a Windows Server failover cluster.  
  
> [!NOTE]  
> Currently, the following clustered workloads are tested and certified for CAU: SMB, Hyper\-V, DFS Replication, DFS Namespaces, iSCSI, and NFS.  
  
## Does CAU support updates from Microsoft Update and Windows Update?  
Yes. By default, CAU is configured with a plug\-in that uses the Windows Update Agent \(WUA\) utility APIs on the cluster nodes. The WUA infrastructure can be configured to point to Microsoft Update and Windows Update or to Windows Server Update Services \(WSUS\) as its source of updates.  
  
## Does CAU support WSUS updates?  
Yes. By default, CAU is configured with a plug\-in that uses the Windows Update Agent \(WUA\) utility APIs on the cluster nodes. The WUA infrastructure can be configured to point to Microsoft Update and Windows Update or to a local Windows Server Update Services \(WSUS\) server as its source of updates.  
  
## Can CAU apply limited distribution release updates?  
Yes. Limited distribution release \(LDR\) updates, also called hotfixes, are not published through Microsoft Update or Windows Update, so they cannot be downloaded by the Windows Update Agent \(WUA\) plug\-in that CAU uses by default.  
  
However, CAU includes a second plug\-in that you can select to apply hotfix updates. This hotfix plug\-in can also be customized to apply non\-Microsoft driver, firmware, and BIOS updates.  
  
## Can I use CAU to apply cumulative updates?  
Yes. If the cumulative updates are general distribution release updates or LDR updates, CAU can apply them.  
  
## Can I schedule updates?  
Yes. CAU supports the following updating modes, both of which allow updates to be scheduled:  
  
**Self\-updating** Enables the cluster to update itself according to a defined profile and a regular schedule, such as during a monthly maintenance window. You can also start a Self\-Updating Run on demand at any time. To enable self\-updating mode, you must add the CAU clustered role to the cluster. The CAU self\-updating feature performs like any other clustered workload, and it can work seamlessly with the planned and unplanned failovers of an update coordinator computer.  
  
**Remote\-updating** Enables you to start an Updating Run at any time from a computer running Windows or Windows Server. You can start an Updating run through the Cluster-Aware Updating window or by using the **Invoke\-CauRun** PowerShell cmdlet. Remote\-updating is the default updating mode for CAU. You can use Task Scheduler to run the [Invoke-CauRun](https://technet.microsoft.com/itpro/powershell/windows/cluster-aware-updating/invoke-caurun) cmdlet on a desired schedule from a remote computer that is not one of the cluster nodes.  
  
## Can I schedule updates to apply during a backup?  
Yes. CAU doesn't impose any constraints in this regard. However, performing software updates on a server \(with the associated potential restarts\) while a server backup is in progress is not an IT best practice. Be aware that CAU relies only on clustering APIs to determine resource failovers and failbacks; thus, CAU is unaware of the server backup status.  
  
## Can CAU work with System Center Configuration Manager?  
CAU is a tool that coordinates software updates on a cluster node, and Configuration Manager also performs server software updates. It's important to configure these tools so that they don't have overlapping coverage of the same servers in any datacenter deployment, including using different Windows Server Update Services servers. This ensures that the objective behind using CAU is not inadvertently defeated, because Configuration Manager\-driven updating doesn't incorporate cluster awareness.  
  
## Do I need administrative credentials to run CAU?  
Yes. For running the CAU tools, CAU needs administrative credentials on the local server, or it needs the **Impersonate a Client after Authentication** user right on the local server or the client computer on which it is running. However, to coordinate software updates on the cluster nodes, CAU requires cluster administrative credentials on every node. Although the CAU UI can start without the credentials, it prompts for the cluster administrative credentials when it connects to a cluster instance to preview or apply updates.  
  
## Can I script CAU?  
Yes. CAU comes with PowerShell cmdlets that offer a rich set of scripting options. These are the same cmdlets that the CAU UI calls to perform CAU actions.  

## What happens to active clustered roles?

Clustered roles \(formerly called applications and services\) that are active on a node, fail over to other nodes before software updating can commence. CAU orchestrates these failovers by using the maintenance mode, which pauses and drains the node of all active clustered roles. When the software updates are complete, CAU resumes the node and the clustered roles fail back to the updated node. This ensures that the distribution of clustered roles relative to nodes stays the same across the CAU Updating Runs of a cluster.  
  
## How does CAU select target nodes for clustered roles?

CAU relies on clustering APIs to coordinate the failovers. The clustering API implementation selects the target nodes by relying on internal metrics and intelligent placement heuristics \(such as workload levels\) across the target nodes.  
  
## Does CAU load balance the clustered roles?

CAU doesn't load balance the clustered nodes, but it attempts to preserve the distribution of clustered roles. When CAU finishes updating a cluster node, it attempts to fail back previously hosted clustered roles to that node. CAU relies on clustering APIs to fail back the resources to the beginning of the pause process. Thus in the absence of unplanned failovers and preferred owner settings, the distribution of clustered roles should remain unchanged.  
  
## How does CAU select the order of nodes to update?  
By default, CAU selects the order of nodes to update based on the level of activity. The nodes that are hosting the fewest clustered roles are updated first. However, an administrator can specify a particular order for updating the nodes by specifying a parameter for the Updating Run in the CAU UI or by using the PowerShell cmdlets.  
  
## What happens if a cluster node is offline?

The administrator who initiates an Updating Run can specify the acceptable threshold for the number of nodes that can be offline. Therefore, an Updating Run can proceed on a cluster even if all the cluster nodes are not online.  
  
## Can I use CAU to update only a single node?  
No. CAU is a cluster\-scoped updating tool, so it only allows you to select clusters to update. If you want to update a single node, you can use existing server updating tools independently of CAU.  
  
## Can CAU report updates that are initiated from outside CAU?  
No. CAU can only report Updating Runs that are initiated from within CAU. However, when a subsequent CAU Updating Run is launched, updates that were installed through non\-CAU methods are appropriately considered to determine the additional updates that might be applicable to each cluster node.  
  
## Can CAU support my unique IT process needs?  
Yes. CAU offers the following dimensions of flexibility to suit enterprise customers' unique IT process needs:  
  
**Scripts** An Updating Run can specify a pre\-update PowerShell script and a post\-update PowerShell script. The pre\-update script runs on each cluster node before the node is paused. The post\-update script runs on each cluster node after the node updates are installed.  
  
> [!NOTE]  
> .NET Framework 4.6 or 4.5 and PowerShell must be installed on each cluster node on which you want to run the pre\-update and post\-update scripts. You must also enable PowerShell remoting on the cluster nodes. For detailed system requirements, see [Requirements and Best Practices for Cluster-Aware Updating](cluster-aware-updating-requirements.md).  
  
**Advanced Updating Run options** The administrator can additionally specify from a large set of advanced Updating Run options such as the maximum number of times that the update process is retried on each node. These options can be specified using either the CAU UI or the CAU PowerShell cmdlets. These custom settings can be saved in an Updating Run Profile and reused for later Updating Runs.  
  
**Public plug\-in architecture** CAU includes features to Register, Unregister, and Select plug\-ins. CAU ships with two default plug\-ins: one coordinates the Windows Update Agent \(WUA\) APIs on each cluster node; the second applies hotfixes that are manually copied to a file share that is accessible to the cluster nodes. If an enterprise has unique needs that cannot be met with these two plug\-ins, the enterprise can build a new CAU plug\-in according to the public API specification. For more information, see [Cluster\-Aware Updating Plug\-in Reference](https://msdn.microsoft.com/library/hh418084(VS.85).aspx).  
  
For information about configuring and customizing CAU plug\-ins to support different updating scenarios, see [How Plug\-ins Work](assetId:///847b571b-12b3-473c-953f-75a5a1f51333).  
  
## How can I export the CAU preview and update results?  
CAU offers export options through the command\-line interface and through the UI.  
  
**Command\-line interface options:**  
  
-   Preview results by using the PowerShell cmdlet **Invoke\-CauScan | ConvertTo\-Xml**. Output: XML  
  
-   Report results by using the PowerShell cmdlet **Invoke\-CauRun | ConvertTo\-Xml**. Output: XML  
  
-   Report results by using the PowerShell cmdlet **Get\-CauReport | Export\-CauReport**. Output: HTML, CSV  
  
**UI options:**  
  
-   Copy the report results from the **Preview updates** screen. Output: CSV  
  
-   Copy the report results from the **Generate report** screen. Output: CSV  
  
-   Export the report results from the **Generate report** screen. Output: HTML  
  
## How do I install CAU?  
A CAU installation is seamlessly integrated into the Failover Clustering feature. CAU is installed as follows:  
  
-   When Failover Clustering is installed on a cluster node, the CAU Windows Management Instrumentation \(WMI\) provider is automatically installed.  
  
-   When the Failover Clustering Tools feature is installed on a server or client computer, the Cluster-Aware Updating UI and PowerShell cmdlets are automatically installed.
  
## Does CAU need components running on the cluster nodes that are being updated?  
CAU doesn't need a service running on the cluster nodes. However, CAU needs a software component \(the WMI provider\) installed on the cluster nodes. This component is installed with the Failover Clustering feature.  
  
To enable self\-updating mode, the CAU clustered role must also be added to the cluster.  
  
## What is the difference between using CAU and VMM?  
  
-   System Center Virtual Machine Manager \(VMM\) is focused on updating only Hyper\-V clusters, whereas CAU can update any type of supported failover cluster, including Hyper\-V clusters.  
  
-   VMM requires additional licensing, whereas CAU is licensed for all Windows Server. The CAU features, tools, and UI are installed with Failover Clustering components.  
  
-   If you already own a System Center license, you can continue to use VMM to update Hyper\-V clusters because it offers an integrated management and software updating experience.  
  
-   CAU is supported only on clusters that are running Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012. VMM also supports Hyper\-V clusters on computers running Windows Server 2008 R2 and Windows Server 2008.  
  
## Can I use remote\-updating on a cluster that is configured for self\-updating?  
Yes. A failover cluster in a self\-updating configuration can be updated through remote\-updating on\-demand, just as you can force a Windows Update scan at any time on your computer, even if Windows Update is configured to install updates automatically. However, you need to make sure that an Updating Run is not already in progress.  
  
## Can I reuse my cluster update settings across clusters?  
Yes. CAU supports a number of Updating Run options that determine how the Updating Run behaves when it updates the cluster. These options can be saved as an Updating Run Profile, and they can be reused across any cluster. We recommend that you save and reuse your settings across failover clusters that have similar updating needs. For example, you might create a "Business\-Critical SQL Server Cluster Updating Run Profile" for all Microsoft SQL Server clusters that support business\-critical services.  
  
## Where is the CAU plug\-in specification?  
  
-   [Cluster\-Aware Updating Plug\-in Reference](https://msdn.microsoft.com/library/hh418084(VS.85).aspx)  
  
-   [Cluster Aware Updating plug\-in sample](https://code.msdn.microsoft.com/windowsdesktop/Cluster-Aware-Updating-6a8854c9)  
  
## See also  
  
-   [Cluster\-Aware Updating Overview](cluster-aware-updating.md)  
  
