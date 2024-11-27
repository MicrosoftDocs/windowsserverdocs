---
title: Create a failover cluster
description: How to create a failover cluster for Windows Server 2012 R2, Windows Server 2012, Windows Server 2016, and Windows Server 2019.
ms.topic: article
author: robinharwood
ms.author: roharwoo
manager: lizross
ms.date: 3/14/2023
zone_pivot_groups: failover-clustering-management-tools
---
# Create a failover cluster

This article shows how to create a failover cluster by using either the Failover Cluster Manager snap-in or Windows PowerShell. The article covers a typical deployment in which computer objects for the cluster and its associated clustered roles are created in Active Directory Domain Services (AD DS). If you're deploying a Storage Spaces Direct cluster instead, see [Deploy Storage Spaces Direct](../storage/storage-spaces/deploy-storage-spaces-direct.md). For information about using a failover cluster in Azure Stack HCI, see [Create an Azure Stack HCI](/azure-stack/hci/deploy/create-cluster).

You can also deploy an Active Directory-detached cluster. This deployment method enables you to create a failover cluster without permissions to create computer objects in AD DS or the need to request that computer objects are prestaged in AD DS. This option is only available through Windows PowerShell and is only recommended for specific scenarios. For more information, see [Deploy an Active Directory-Detached Cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

## Verify the prerequisites

Before you begin, verify the following prerequisites:

- Make sure that all servers that you want to add as cluster nodes are running the same version of Windows Server.

- Review the hardware requirements to make sure that your configuration is supported. For more information, see [Failover Clustering Hardware Requirements and Storage Options](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj612869(v%3dws.11)). If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).

- To add clustered storage during cluster creation, make sure that all servers can access the storage. (You can also add clustered storage after you create the cluster.)

- Make sure that all servers that you want to add as cluster nodes are joined to the same Active Directory domain.

- (Optional) Create an organizational unit (OU) and move the computer accounts for the servers that you want to add as cluster nodes into the OU. As a best practice, we recommend that you place failover clusters in their own OU in AD DS. This can help you better control which Group Policy settings or security template settings affect the cluster nodes. By isolating clusters in their own OU, it also helps prevent against accidental deletion of cluster computer objects.

Also, make sure that you verify the following account requirements:

- Make sure that the account you want to use to create the cluster is a domain user who has administrator rights on all servers that you want to add as cluster nodes.

- Make sure that either of the following is true:

  - The user who creates the cluster has the **Create Computer objects** permission to the OU or the container where the servers that will form the cluster reside.

  - If the user does not have the **Create Computer objects** permission, ask a domain administrator to prestage a cluster computer object for the cluster. For more information, see [Prestage Cluster Computer Objects in Active Directory Domain Services](prestage-cluster-adds.md).

> [!NOTE]
> This requirement does not apply if you want to create an Active Directory-detached cluster. For more information, see [Deploy an Active Directory-Detached Cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

## Install the Failover Clustering feature

You must install the Failover Clustering feature on every server that you want to add as a failover cluster node.

::: zone pivot="windows-admin-center"

1. Sign in to Windows Admin Center.

1. Under **All connections**, select **Add**.

1. In the **Add or create resources** panel, under **Server clusters**, select **Create new**.

1. under **Choose the cluster type**, select **Windows Server**.

1. Under **Select the workload type**, select **Virtual machines**.

1. Under **Select Server locations**, select **All servers in one site**.

1. Select **Create**.

1. In **Check the prerequisites**, make sure your deployment meets the requirements for servers and networks, then select **Next**.

1. In **Add servers**, enter a username and password for the administrator account for connecting to the servers.

1. Next, enter the computer name, IP address, or fully qualified domain name (FQDN) for each server you want to add, then select **Add**.

1. Join a domain. <!--Screenshot missing--->

1. Install any required features by selecting **Install features**.

1. Select **Next**,

1. Optionally, you can install any operating system updates by selecting **Install updates**.

1. Select **Next**,

1. Select **Restart servers** to restart the servers and apply changes.

1. Select **Next: Networking**.

1. Under **Networking**, a popup window will appear asking you if you want to remove existing virtual switches. If you want to remove them, select **Yes**. If not, select **No**.

1. The wizard will check the network adapters. To enable a network adapter, select the name of the adapter, then select **Enable**. To disable an adapter, select the name of the adapter, then select **Disable**.

  >[!NOTE]
  >If the wizard can't find the servers, select **Back**, then select **Next** to refresh the page. If you still see an error message, try using a server that isn't on a VLAN instead.

1. Select **Next**.

1. On **Select the adapters to use for management**, select **One physical network adapter for management**, then select **Next**.

1. On **Virtual switch**, select **Create one virtual switch for compute and storage together**, then select **Next**.

1. On **Optionally configure RDMA**, select **Next**.

1. On **Define networks**, enter the name, IP address, Subnet mask, and VLAN ID of the adapters you want to use for storage and compute traffic for VMS within the cluster. When you're done, select **Apply and test** to validate the adapters.

1. When the validation process is finished, select **Next: Clustering**.

1. On **Validate the cluster**, select **Validate**.

1. When the validation process finishes, review any warning messages that appear and resolve them if you can. Once you're finished, select **Next**.

1. On **Create the cluster**, enter a name for your cluster, then select **Specify one or more static addresses**. Next, select the **Use network** checkbox and enter the IP address for your cluster in the **IP address** field. when you're done, select **Create cluster**.

1. When the cluster creation process is done, select **Finish**.
::: zone-end  

::: zone pivot="powershell"

> [!NOTE]
> You must use Windows PowerShell to create an Active Directory-detached cluster in Windows Server 2012 R2. For information about the syntax, see [Deploy an Active Directory-Detached Cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

The following example installs the Failover Clustering feature.

```PowerShell
Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
```

::: zone-end  

::: zone pivot="failover-cluster-manager"

1. Under **Configure this local server**, select **Add Roles and Features**.

1. Follow the directions in [Install roles, role services, and features by using the add Roles and Features Wizard](../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md#install-roles-role-services-and-features-by-using-the-add-roles-and-features-wizard) to install the **Failover Clustering** feature.

1. When the installation is completed, select **Close**.

1. Repeat this procedure on every server that you want to add as a failover cluster node.

> [!NOTE]
> After you install the Failover Clustering feature, we recommend that you apply the latest updates from Windows Update. Also, for a Windows Server 2012-based failover cluster, review the [Recommended hotfixes and updates for Windows Server 2012-based failover clusters](https://support.microsoft.com/help/2784261/recommended-hotfixes-and-updates-for-windows-server-2012-based-failove) Microsoft Support article and install any updates that apply.
::: zone-end  

## Validate the configuration

Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft supports a cluster solution only if the complete configuration passes all validation tests and if all hardware is certified for the version of Windows Server that the cluster nodes are running.

::: zone pivot="powershell"

The following example runs all cluster validation tests on computers that are named *Server1* and *Server2*.

```PowerShell
Test-Cluster –Node Server1, Server2
```

> [!NOTE]
> The **Test-Cluster** cmdlet outputs the results to a log file in the current working directory. For example: C:\Users\<username>\AppData\Local\Temp.

::: zone-end  

::: zone pivot="failover-cluster-manager"

> [!NOTE]
> You must have at least two nodes to run all tests. If you have only one node, many of the critical storage tests do not run.

### Run cluster validation tests

1. On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. To do this on a server, start Server Manager and then on the **Tools** menu, select **Failover Cluster Manager**.

1. In the failover cluster mangment pane, under the **Management** node, go to the **Actions** pane on the right side of the window and selet **Validate Configuration**>

1. On the **Before You Begin** page, select **Next**.

1. On the **Select Servers or a Cluster** page in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or by a semicolon. For example, enter the names in the format `server1.contoso.com, server2.contoso.com`. When you are finished, select **Next**.

1. On the **Testing Options** page, select **Run all tests (recommended)** and then select **Next**.

1. On the **Confirmation** page, select **Next**.

    The Validating page displays the status of the running tests.

1. On the **Summary** page, do either of the following:

      - If the results indicate that the tests completed successfully and the configuration is suited for clustering and you want to create the cluster immediately, make sure that the **Create the cluster now using the validated nodes** check box is selected and then select **Finish**. Then, continue to step 4 of the [Create the failover cluster](#create-the-failover-cluster) procedure.
      - If the results indicate that there were warnings or failures, select **View Report** to view the details and determine which issues must be corrected. Realize that a warning for a particular validation test indicates that this aspect of the failover cluster can be supported but might not meet the recommended best practices.

        > [!NOTE]
        > If you receive a warning for the Validate Storage Spaces Persistent Reservation test, see the blog post [Windows Failover Cluster validation warning indicates your disks don't support the persistent reservations for Storage Spaces](https://blogs.msdn.microsoft.com/clustering/2013/05/24/validate-storage-spaces-persistent-reservation-test-results-with-warning/) for more information.

::: zone-end  

For more information about hardware validation tests, see [Validate Hardware for a Failover Cluster](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134244(v%3dws.11)>).

## Create the failover cluster

To complete this step, make sure that the user account that you log on as meets the requirements that are outlined in the [Verify the prerequisites](#verify-the-prerequisites) section of this topic. <!---There's no WAC version here. Ask if lab left off before we could write these steps.--->

::: zone pivot="powershell"

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

::: zone-end  

::: zone pivot="failover-cluster-manager"

1. Start Server Manager.

1. On the **Tools** menu, select **Failover Cluster Manager**.

1. In the **Failover Cluster Manager** pane, under **Management**, select **Create Cluster**.

    The Create Cluster Wizard opens.

1. On the **Before You Begin** page, select **Next**.

1. If the **Select Servers** page appears, in the **Enter name** box enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or a semicolon. For example, enter the names in the format *server1.contoso.com; server2.contoso.com*. When you are finished, select **Next**.

    > [!NOTE]
    > If you chose to create the cluster immediately after running validation in the [configuration validating procedure](#validate-the-configuration), you will not see the **Select Servers** page. The nodes that were validated are automatically added to the Create Cluster Wizard so that you do not have to enter them again.

1. If you skipped validation earlier, the **Validation Warning** page appears. We strongly recommend that you run cluster validation. Only clusters that pass all validation tests are supported by Microsoft. To run the validation tests, select **Yes**, and then select **Next**. Complete the Validate a Configuration Wizard as described in [Validate the configuration](#validate-the-configuration).

1. On the **Access Point for Administering the Cluster** page, do the following:

    1. In the **Cluster Name** box, enter the name that you want to use to administer the cluster. Before you do, review the following information:

          - During cluster creation, this name is registered as the cluster computer object (also known as the *cluster name object* or *CNO*) in AD DS. If you specify a NetBIOS name for the cluster, the CNO is created in the same location where the computer objects for the cluster nodes reside. This can be either the default Computers container or an OU.
          - To specify a different location for the CNO, you can enter the distinguished name of an OU in the **Cluster Name** box. For example: *CN=ClusterName, OU=Clusters, DC=Contoso, DC=com*.
          - If a domain administrator has prestaged the CNO in a different OU than where the cluster nodes reside, specify the distinguished name that the domain administrator provides.

    1. If the server does not have a network adapter that is configured to use DHCP, you must configure one or more static IP addresses for the failover cluster. Select the check box next to each network that you want to use for cluster management. Select the **Address** field next to a selected network and then enter the IP address that you want to assign to the cluster. This IP address (or addresses) will be associated with the cluster name in Domain Name System (DNS).

      >[!NOTE]
      > If you're using Windows Server 2019, you have the option to use a distributed network name for the cluster. A distributed network name uses the IP addresses of the member servers instead of requiring a dedicated IP address for the cluster. By default, Windows uses a distributed network name if it detects that you're creating the cluster in Azure (so you don't have to create an internal load balancer for the cluster) or a normal static or IP address if you're running on-premises. For more info, see [Distributed Network Name](https://blogs.windows.com/windowsexperience/2018/08/14/announcing-windows-server-2019-insider-preview-build-17733/#W0YAxO8BfwBRbkzG.97).

    1. When you are finished, select **Next**.

1. On the **Confirmation** page, review the settings. By default, the **Add all eligible storage to the cluster** check box is selected. Clear this check box if you want to do either of the following:

      - You want to configure storage later.

      - You plan to create clustered storage spaces through Failover Cluster Manager or through the Failover Clustering Windows PowerShell cmdlets and have not yet created storage spaces in File and Storage Services. For more information, see [Deploy Clustered Storage Spaces](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj822937(v%3dws.11)>).

1. Select **Next** to create the failover cluster.

1. On the **Summary** page, confirm that the failover cluster was successfully created. If there were any warnings or errors, view the summary output or select **View Report** to view the full report. Select **Finish**.

1. To confirm that the cluster was created, verify that the cluster name is listed under **Failover Cluster Manager** in the navigation tree. You can expand the cluster name and then select items under **Nodes**, **Storage** or **Networks** to view the associated resources.

    It may take some time for the cluster name to successfully replicate in DNS. After successful DNS registration and replication, if you select **All Servers** in Server Manager, the cluster name should be listed as a server with a **Manageability** status of **Online**.

::: zone-end  

After you create the cluster, you can verify cluster quorum configuration and create Cluster Shared Volumes (CSV). For more information, see [Understanding Quorum in Storage Spaces Direct](/azure-stack/hci/concepts/quorum) and [Use Cluster Shared Volumes in a failover cluster](failover-cluster-csvs.md).

## Create clustered roles

After you create the failover cluster, you can create clustered roles to host cluster workloads.

>[!NOTE]
>For clustered roles that require a client access point, a virtual computer object (VCO) is created in AD DS. By default, all VCOs for the cluster are created in the same container or OU as the CNO. Realize that after you create a cluster, you can move the CNO to any OU.

::: zone pivot="powershell"

For examples of how to add clustered roles using Powershell, see [Add-ClusterFileServerRole](/powershell/module/failoverclusters/add-clusterfileserverrole) and [Add-ClusterGenericApplicationRole](/powershell/module/failoverclusters/add-clustergenericapplicationrole).

<!---This one's going to need some more specific directions.--->

::: zone-end  

::: zone pivot="failover-cluster-manager"

Use Server Manager or Windows PowerShell to install the role or feature that is required for a clustered role on each failover cluster node. For example, if you want to create a clustered file server, install the File Server role on all cluster nodes.

The following table shows the clustered roles that you can configure in the High Availability Wizard and the associated server role or feature that you must install as a prerequisite.

| Clustered role  | Role or feature prerequisite  |
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

To create a clustered role:

1. In the pane on the left side of the window, expand the accordion menu next to the name of your cluster, then select **Roles**.

1. Select the name of the role you want to add, then follow any instructions you see until you finish.

1. To verify that you successfully created the clustered role, in the **Roles** pane, make sure that the role has a status of **Running**. The Roles pane also indicates the owner node. To test failover, right-click the role, point to **Move** and then select **Select Node**. In the **Move Clustered Role** dialog box, select the desired cluster node and then select **OK**. In the **Owner Node** column, verify that the owner node changed.

::: zone-end  

## More information

- [Failover Clustering](./failover-clustering-overview.md)
- [Deploy a Hyper-V Cluster](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj863389(v%3dws.11)>)
- [Scale-Out File Server for Application Data](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831349(v%3dws.11)>)
- [Deploy an Active Directory-Detached Cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11))
- [Using Guest Clustering for High Availability](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn440540(v%3dws.11)>)
- [Cluster-Aware Updating](cluster-aware-updating.md)
- [New-Cluster](/powershell/module/failoverclusters/new-cluster)
- [Test-Cluster](/powershell/module/failoverclusters/test-cluster)
