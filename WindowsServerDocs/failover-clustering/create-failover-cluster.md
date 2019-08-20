---
title: Create a failover cluster
description: How to create a failover cluster for Windows Server 2012 R2, Windows Server 2012, Windows Server 2016, and Windows Server 2019.
ms.prod: windows-server-threshold 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage-failover-clustering 
ms.date: 06/06/2019
ms.localizationpriority: medium
---
# Create a failover cluster

>Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012

This topic shows how to create a failover cluster by using either the Failover Cluster Manager snap-in or Windows PowerShell. The topic covers a typical deployment, where computer objects for the cluster and its associated clustered roles are created in Active Directory Domain Services (AD DS). If you're deploying a Storage Spaces Direct cluster, instead see [Deploy Storage Spaces Direct](../storage/storage-spaces/deploy-storage-spaces-direct.md).

You can also deploy an Active Directory-detached cluster. This deployment method enables you to create a failover cluster without permissions to create computer objects in AD DS or the need to request that computer objects are prestaged in AD DS. This option is only available through Windows PowerShell, and is only recommended for specific scenarios. For more information, see [Deploy an Active Directory-Detached Cluster](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

#### Checklist: Create a failover cluster

| Status | Task | Reference |
| ---    | ---  | ---       |
| ☐    | Verify the prerequisites | [Verify the prerequisites](#verify-the-prerequisites) |
| ☐    | Install the Failover Clustering feature on every server that you want to add as a cluster node | [Install the Failover Clustering feature](#install-the-failover-clustering-feature) |
| ☐    | Run the Cluster Validation Wizard to validate the configuration | [Validate the configuration](#validate-the-configuration) |
| ☐ | Run the Create Cluster Wizard to create the failover cluster | [Create the failover cluster](#create-the-failover-cluster) |
| ☐ | Create clustered roles to host cluster workloads | [Create clustered roles](#create-clustered-roles) |

## Verify the prerequisites

Before you begin, verify the following prerequisites:

- Make sure that all servers that you want to add as cluster nodes are running the same version of Windows Server.
- Review the hardware requirements to make sure that your configuration is supported. For more information, see [Failover Clustering Hardware Requirements and Storage Options](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj612869(v%3dws.11)). If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).
- To add clustered storage during cluster creation, make sure that all servers can access the storage. (You can also add clustered storage after you create the cluster.)
- Make sure that all servers that you want to add as cluster nodes are joined to the same Active Directory domain.
- (Optional) Create an organizational unit (OU) and move the computer accounts for the servers that you want to add as cluster nodes into the OU. As a best practice, we recommend that you place failover clusters in their own OU in AD DS. This can help you better control which Group Policy settings or security template settings affect the cluster nodes. By isolating clusters in their own OU, it also helps prevent against accidental deletion of cluster computer objects.

Additionally, verify the following account requirements:

- Make sure that the account you want to use to create the cluster is a domain user who has administrator rights on all servers that you want to add as cluster nodes.
- Make sure that either of the following is true:
    - The user who creates the cluster has the **Create Computer objects** permission to the OU or the container where the servers that will form the cluster reside.
    - If the user does not have the **Create Computer objects** permission, ask a domain administrator to prestage a cluster computer object for the cluster. For more information, see [Prestage Cluster Computer Objects in Active Directory Domain Services](prestage-cluster-adds.md).

> [!NOTE]
> This requirement does not apply if you want to create an Active Directory-detached cluster in Windows Server 2012 R2. For more information, see [Deploy an Active Directory-Detached Cluster](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

## Install the Failover Clustering feature

You must install the Failover Clustering feature on every server that you want to add as a failover cluster node.

### Install the Failover Clustering feature

1. Start Server Manager.
2. On the **Manage** menu, select **Add Roles and Features**.
3. On the **Before you begin** page, select **Next**.
4. On the **Select installation type** page, select **Role-based or feature-based installation**, and then select **Next**.
5. On the **Select destination server** page, select the server where you want to install the feature, and then select **Next**.
6. On the **Select server roles** page, select **Next**.
7. On the **Select features** page, select the **Failover Clustering** check box.
8. To install the failover cluster management tools, select **Add Features**, and then select **Next**.
9. On the **Confirm installation selections** page, select **Install**.
<br>A server restart is not required for the Failover Clustering feature.

10. When the installation is completed, select **Close**.
11. Repeat this procedure on every server that you want to add as a failover cluster node.

> [!NOTE]
> After you install the Failover Clustering feature, we recommend that you apply the latest updates from Windows Update. Also, for a Windows Server 2012-based failover cluster, review the [Recommended hotfixes and updates for Windows Server 2012-based failover clusters](https://support.microsoft.com/help/2784261/recommended-hotfixes-and-updates-for-windows-server-2012-based-failove) Microsoft Support article and install any updates that apply.

## Validate the configuration

Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft supports a cluster solution only if the complete configuration passes all validation tests and if all hardware is certified for the version of Windows Server that the cluster nodes are running.

> [!NOTE]
> You must have at least two nodes to run all tests. If you have only one node, many of the critical storage tests do not run.

### Run cluster validation tests

1. On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools, or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. To do this on a server, start Server Manager, and then on the **Tools** menu, select **Failover Cluster Manager**.
2. In the **Failover Cluster Manager** pane, under **Management**, select **Validate Configuration**.
3. On the **Before You Begin** page, select **Next**.
4. On the **Select Servers or a Cluster** page, in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or by a semicolon. For example, enter the names in the format `server1.contoso.com, server2.contoso.com`. When you are finished, select **Next**.
5. On the **Testing Options** page, select **Run all tests (recommended)**, and then select **Next**.
6. On the **Confirmation** page, select **Next**.

    The Validating page displays the status of the running tests.
7. On the **Summary** page, do either of the following:
    
      - If the results indicate that the tests completed successfully and the configuration is suited for clustering, and you want to create the cluster immediately, make sure that the **Create the cluster now using the validated nodes** check box is selected, and then select **Finish**. Then, continue to step 4 of the [Create the failover cluster](#create-the-failover-cluster) procedure.
      - If the results indicate that there were warnings or failures, select **View Report** to view the details and determine which issues must be corrected. Realize that a warning for a particular validation test indicates that this aspect of the failover cluster can be supported, but might not meet the recommended best practices.
        
        > [!NOTE]
        > If you receive a warning for the Validate Storage Spaces Persistent Reservation test, see the blog post [Windows Failover Cluster validation warning indicates your disks don't support the persistent reservations for Storage Spaces](https://blogs.msdn.microsoft.com/clustering/2013/05/24/validate-storage-spaces-persistent-reservation-test-results-with-warning/) for more information.

For more information about hardware validation tests, see [Validate Hardware for a Failover Cluster](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134244(v%3dws.11)>).

## Create the failover cluster

To complete this step, make sure that the user account that you log on as meets the requirements that are outlined in the [Verify the prerequisites](#verify-the-prerequisites) section of this topic.

1. Start Server Manager.
2. On the **Tools** menu, select **Failover Cluster Manager**.
3. In the **Failover Cluster Manager** pane, under **Management**, select **Create Cluster**.
    
    The Create Cluster Wizard opens.
4. On the **Before You Begin** page, select **Next**.
5. If the **Select Servers** page appears, in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or a semicolon. For example, enter the names in the format *server1.contoso.com; server2.contoso.com*. When you are finished, select **Next**.
    
    > [!NOTE]
    > If you chose to create the cluster immediately after running validation in the [configuration validating procedure](#validate-the-configuration), you will not see the **Select Servers** page. The nodes that were validated are automatically added to the Create Cluster Wizard so that you do not have to enter them again.
6. If you skipped validation earlier, the **Validation Warning** page appears. We strongly recommend that you run cluster validation. Only clusters that pass all validation tests are supported by Microsoft. To run the validation tests, select **Yes**, and then select **Next**. Complete the Validate a Configuration Wizard as described in [Validate the configuration](#validate-the-configuration).
7. On the **Access Point for Administering the Cluster** page, do the following:
    
    1. In the **Cluster Name** box, enter the name that you want to use to administer the cluster. Before you do, review the following information:
        
          - During cluster creation, this name is registered as the cluster computer object (also known as the *cluster name object* or *CNO*) in AD DS. If you specify a NetBIOS name for the cluster, the CNO is created in the same location where the computer objects for the cluster nodes reside. This can be either the default Computers container or an OU.
          - To specify a different location for the CNO, you can enter the distinguished name of an OU in the **Cluster Name** box. For example: *CN=ClusterName, OU=Clusters, DC=Contoso, DC=com*.
          - If a domain administrator has prestaged the CNO in a different OU than where the cluster nodes reside, specify the distinguished name that the domain administrator provides.
    2. If the server does not have a network adapter that is configured to use DHCP, you must configure one or more static IP addresses for the failover cluster. Select the check box next to each network that you want to use for cluster management. Select the **Address** field next to a selected network, and then enter the IP address that you want to assign to the cluster. This IP address (or addresses) will be associated with the cluster name in Domain Name System (DNS).
    3. When you are finished, select **Next**.
8. On the **Confirmation** page, review the settings. By default, the **Add all eligible storage to the cluster** check box is selected. Clear this check box if you want to do either of the following:
    
      - You want to configure storage later.
      - You plan to create clustered storage spaces through Failover Cluster Manager or through the Failover Clustering Windows PowerShell cmdlets, and have not yet created storage spaces in File and Storage Services. For more information, see [Deploy Clustered Storage Spaces](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj822937(v%3dws.11)>).
9. Select **Next** to create the failover cluster.
10. On the **Summary** page, confirm that the failover cluster was successfully created. If there were any warnings or errors, view the summary output or select **View Report** to view the full report. Select **Finish**.
11. To confirm that the cluster was created, verify that the cluster name is listed under **Failover Cluster Manager** in the navigation tree. You can expand the cluster name, and then select items under **Nodes**, **Storage** or **Networks** to view the associated resources.
    
    Realize that it may take some time for the cluster name to successfully replicate in DNS. After successful DNS registration and replication, if you select **All Servers** in Server Manager, the cluster name should be listed as a server with a **Manageability** status of **Online**.

After the cluster is created, you can do things such as verify cluster quorum configuration, and optionally, create Cluster Shared Volumes (CSV). For more information, see [Understanding Quorum in Storage Spaces Direct](../storage/storage-spaces/understand-quorum.md) and [Use Cluster Shared Volumes in a failover cluster](failover-cluster-csvs.md).

## Create clustered roles

After you create the failover cluster, you can create clustered roles to host cluster workloads.

>[!NOTE]
>For clustered roles that require a client access point, a virtual computer object (VCO) is created in AD DS. By default, all VCOs for the cluster are created in the same container or OU as the CNO. Realize that after you create a cluster, you can move the CNO to any OU.

Here's how to create a clustered role:

1. Use Server Manager or Windows PowerShell to install the role or feature that is required for a clustered role on each failover cluster node. For example, if you want to create a clustered file server, install the File Server role on all cluster nodes.
    
    The following table shows the clustered roles that you can configure in the High Availability Wizard and the associated server role or feature that you must install as a prerequisite.

   | Clustered Role  | Role or Feature Prerequisite  |
   | ---------       | ---------                    |
   | Namespace Server     |   Namespaces (part of File Server role)       |
   | DFS Namespace Server     |  DHCP Server role       |
   | Distributed Transaction Coordinator (DTC)     | None        |
   | File Server     |  File Server role       |
   | Generic Application     |  Not applicable       |
   | Generic Script     |   Not applicable      |
   | Generic Service     |   Not applicable      |
   | Hyper-V Replica Broker     |   Hyper-V role      |
   | iSCSI Target Server     |    iSCSI Target Server (part of File Server role)     |
   | iSNS Server     |  iSNS Server Service feature       |
   | Message Queuing     |  Message Queuing Services feature       |
   | Other Server     |  None       |
   | Virtual Machine     |  Hyper-V role       |
   | WINS Server     |   WINS Server feature      |

2. In Failover Cluster Manager, expand the cluster name, right-click **Roles**, and then select **Configure Role**.
3. Follow the steps in the High Availability Wizard to create the clustered role.
4. To verify that the clustered role was created, in the **Roles** pane, make sure that the role has a status of **Running**. The Roles pane also indicates the owner node. To test failover, right-click the role, point to **Move**, and then select **Select Node**. In the **Move Clustered Role** dialog box, select the desired cluster node, and then select **OK**. In the **Owner Node** column, verify that the owner node changed.

## Create a failover cluster by using Windows PowerShell

The following Windows PowerShell cmdlets perform the same functions as the preceding procedures in this topic. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines because of formatting constraints.

> [!NOTE]
> You must use Windows PowerShell to create an Active Directory-detached cluster in Windows Server 2012 R2. For information about the syntax, see [Deploy an Active Directory-Detached Cluster](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

The following example installs the Failover Clustering feature.

```PowerShell
Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
```

The following example runs all cluster validation tests on computers that are named *Server1* and *Server2*.

```PowerShell
Test-Cluster –Node Server1, Server2
```

> [!NOTE]
> The **Test-Cluster** cmdlet outputs the results to a log file in the current working directory. For example: C:\Users\<username>\AppData\Local\Temp.

The following example creates a failover cluster that is named *MyCluster* with nodes *Server1* and *Server2*, assigns the static IP address *192.168.1.12*, and adds all eligible storage to the failover cluster.

```PowerShell
New-Cluster –Name MyCluster –Node Server1, Server2 –StaticAddress 192.168.1.12
```

The following example creates the same failover cluster as in the previous example, but it does not add eligible storage to the failover cluster.

```PowerShell
New-Cluster –Name MyCluster –Node Server1, Server2 –StaticAddress 192.168.1.12 -NoStorage
```

The following example creates a cluster that is named *MyCluster* in the *Cluster* OU of the domain *Contoso.com*.

```PowerShell
New-Cluster -Name CN=MyCluster,OU=Cluster,DC=Contoso,DC=com -Node Server1, Server2
```

For examples of how to add clustered roles, see topics such as [Add-ClusterFileServerRole](https://docs.microsoft.com/powershell/module/failoverclusters/add-clusterfileserverrole?view=win10-ps) and [Add-ClusterGenericApplicationRole](https://docs.microsoft.com/powershell/module/failoverclusters/add-clustergenericapplicationrole?view=win10-ps).

## More information

  - [Failover Clustering](failover-clustering.md)
  - [Deploy a Hyper-V Cluster](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj863389(v%3dws.11)>)
  - [Scale-Out File Server for Application Data](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831349(v%3dws.11)>)
  - [Deploy an Active Directory-Detached Cluster](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11))
  - [Using Guest Clustering for High Availability](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn440540(v%3dws.11)>)
  - [Cluster-Aware Updating](cluster-aware-updating.md)
  - [New-Cluster](https://docs.microsoft.com/powershell/module/failoverclusters/new-cluster?view=win10-ps)
  - [Test-Cluster](https://docs.microsoft.com/powershell/module/failoverclusters/test-cluster?view=win10-ps)
