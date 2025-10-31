---
title: Create a failover cluster
description: How to create a failover cluster for Windows Server 2012 R2, Windows Server 2012, Windows Server 2016, and Windows Server 2019.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 1/15/2025
zone_pivot_groups: failover-clustering-management-tools
---
# Create a failover cluster

This article shows how to create a failover cluster by using Windows Admin Center, the Failover Cluster Manager snap-in, or Windows PowerShell. The article covers a typical deployment in which computer objects for the cluster and its associated clustered roles are created in Active Directory Domain Services (AD DS). If you're deploying a failover cluster that uses Storage Spaces Direct (S2D) instead, see [Deploy Storage Spaces Direct](../storage/storage-spaces/deploy-storage-spaces-direct.md#step-35-enable-storage-spaces-direct). For information about using a failover cluster in Azure Local, see [Create an Azure Local](/azure/azure-local/deploy/create-cluster?context=/windows-server/context/windows-server-failover-clustering).

You can also deploy an Active Directory-detached cluster. This deployment method enables you to create a failover cluster without permissions to create computer objects in AD DS or the need to request that computer objects are prestaged in AD DS. This option is only available through Windows PowerShell and is only recommended for specific scenarios. For more information, see [Deploy an Active Directory-Detached Cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

## Verify the prerequisites

Before you begin, verify the following prerequisites:

- Make sure that all servers that you want to add as cluster nodes are running the same version of Windows Server.

- Review the hardware requirements to make sure that your configuration is supported. For more information, see [Failover Clustering Hardware Requirements and Storage Options](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj612869(v%3dws.11)). If you're creating a Storage Spaces Direct cluster, see [Storage Spaces Direct hardware requirements](../storage/storage-spaces/storage-spaces-direct-hardware-requirements.md).

- To add clustered storage during cluster creation, make sure that all servers can access the storage. (You can also add clustered storage after you create the cluster.)

- Make sure that all servers that you want to add as cluster nodes are joined to the same Active Directory domain and in the same time zone as your local domain controller.

- Ensure that the domain controller isn't hosted on any of the machines in the cluster.

- (Optional) Create an organizational unit (OU) and move the computer accounts for the servers that you want to add as cluster nodes into the OU. We recommend that you place failover clusters in their own OU in AD DS. Creating an OU gives you more control over which Group Policy settings or security template settings affect the cluster nodes. Isolating clusters in their own OU also helps prevent accidental deletion of cluster computer objects.

If you're using Windows Admin Center to create the cluster:

- Install the latest version of Windows Admin Center on a PC or server for management. See [Install Windows Admin Center](../manage/windows-admin-center/deploy/install.md).

- Ensure that Windows Admin Center and your domain controller aren't installed on the same system.

- If you're running Windows Admin Center on a server (instead of a local PC), use an account that's a member of the Gateway Administrators group, or the local Administrators group on the Windows Admin Center server.

- Verify that your Windows Admin Center management computer is joined to the same Active Directory domain in which you create the cluster or joined to a fully trusted domain. The servers that you cluster don't need to belong to the domain yet; they can be added to the domain during cluster creation.

Also, make sure that you verify the following account requirements:

- Make sure that the account you use to create the cluster is a domain user with administrator rights on all servers that you want to turn into cluster nodes.

- Make sure that the user account that creates the clusters meets one of the following criteria:

  - The user who creates the cluster has the **Create Computer objects** permission to the OU or container where the servers that make up the cluster are located.

  - If the user doesn't have the **Create Computer objects** permission, ask a domain administrator to prestage a cluster computer object for the cluster. For more information, see [Prestage Cluster Computer Objects in Active Directory Domain Services](prestage-cluster-adds.md).

  > [!NOTE]
  > This requirement doesn't apply if you want to create an Active Directory-detached cluster. For more information, see [Deploy an Active Directory-Detached Cluster](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn265970(v=ws.11)).

::: zone pivot="powershell"

## Install the Failover Clustering feature using PowerShell

You must install the Failover Clustering feature on every server that you want to add as a failover cluster node.

The following example installs the Failover Clustering feature.

```PowerShell
Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools
```

::: zone-end  

::: zone pivot="failover-cluster-manager"

## Install the Failover Clustering feature using Failover Cluster Manager

You must install the Failover Clustering feature on every server that you want to add as a failover cluster node.

To install the Failover Clustering feature:

1. Under **Configure this local server**, select **Add Roles and Features**.

1. Follow the directions in [Install roles, role services, and features by using the Add Roles and Features Wizard](../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md#install-roles-role-services-and-features-by-using-the-add-roles-and-features-wizard) to install the **Failover Clustering** feature.

1. When the installation is completed, select **Close**.

1. Repeat this procedure on every server that you want to add as a failover cluster node.

> [!NOTE]
> After you install the Failover Clustering feature, we recommend that you apply the latest updates from Windows Update. Also, for a Windows Server 2012-based failover cluster, review the [Recommended hotfixes and updates for Windows Server 2012-based failover clusters](https://support.microsoft.com/help/2784261/recommended-hotfixes-and-updates-for-windows-server-2012-based-failove) Microsoft Support article and install any updates that apply.
::: zone-end  

::: zone pivot="powershell"

## Validate the configuration using PowerShell

Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft only supports cluster solutions if the complete configuration passes all validation tests and only has certified hardware compatible with whichever version of Windows Server your cluster nodes use.

The following example runs all cluster validation tests on computers that are named *Server1* and *Server2*.

```PowerShell
Test-Cluster –Node Server1, Server2
```

> [!NOTE]
> The **Test-Cluster** cmdlet outputs the results to a log file in the current working directory. For example: C:\Users\<username>\AppData\Local\Temp.

::: zone-end  

::: zone pivot="failover-cluster-manager"

## Validate the configuration using Failover Cluster Manager

Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft only supports cluster solutions if the complete configuration passes all validation tests and only has certified hardware compatible with whichever version of Windows Server your cluster nodes use.

> [!NOTE]
> You must have at least two nodes to run all tests. If you have only one node, many of the critical storage tests don't run.

### Run cluster validation tests

To run cluster validation tests in Failover Cluster Manager:

1. On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. If you're on a server, start Server Manager and then on the **Tools** menu, select **Failover Cluster Manager**.

1. In the failover cluster management pane, under the **Management** node, go to the **Actions** pane on the right side of the window and select **Validate Configuration**.

1. On the **Before You Begin** page, select **Next**.

1. On the **Select Servers or a Cluster** page in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node and then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or by a semicolon. For example, enter the names in the format `server1.contoso.com, server2.contoso.com`. When you're finished, select **Next**.

1. On the **Testing Options** page, select **Run all tests (recommended)** and then select **Next**.

1. On the **Confirmation** page, select **Next**.

    The Validating page displays the status of the running tests.

1. On the **Summary** page, do either of the following:

      - If the results indicate that the tests completed successfully and the configuration is suited for clustering and you want to create the cluster immediately, make sure that the **Create the cluster now using the validated nodes** check box is selected and then select **Finish**. Then, continue to step 4 of the [Create the failover cluster](#create-the-failover-cluster) procedure.

      - If the results indicate that there were warnings or failures, select **View Report** to view the details and determine which issues must be corrected. A warning for a particular validation test indicates that this aspect of the failover cluster can still function, but might not meet recommended configuration standards.

        > [!NOTE]
        > If you receive a warning for the Validate Storage Spaces Persistent Reservation test, see the blog post [Windows Failover Cluster validation warning indicates your disks don't support the persistent reservations for Storage Spaces](https://blogs.msdn.microsoft.com/clustering/2013/05/24/validate-storage-spaces-persistent-reservation-test-results-with-warning/) for more information.

::: zone-end  

For more information about hardware validation tests, see [Validate Hardware for a Failover Cluster](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134244(v%3dws.11)>).

## Create the failover cluster

To complete this step, make sure that the user account that you sign in with meets the requirements outlined in the [Verify the prerequisites](#verify-the-prerequisites) section of this topic.

::: zone pivot="windows-admin-center"

### Start the Create Cluster wizard

To start the Create Cluster wizard in Windows Admin Center:

1. Sign in to Windows Admin Center.

1. Under **All connections**, select **Add**.

1. In the **Add or create resources** panel, under **Server clusters**, select **Create new**.

1. Under **Choose the cluster type**, select **Windows Server**.

1. Under **Select the workload type**, select either **Cluster-aware roles and apps** or **Virtual machines**, depending on your needs.

1. Under **Select server locations**, select one the following:

   - All servers in one site

   - Servers in two sites (for stretched cluster)

1. When you're finished, select **Create**. The Create Cluster wizard should open.

Proceed to the next step in the cluster creation workflow, [Step 1: Get started](#step-1-get-started).

### Step 1: Get started

Step 1 of the wizard walks you through making sure all prerequisites are met, adding the server nodes, installing needed features, and then restarting each server if needed.

1. On the **Check the prerequisites** page, make sure your server and network meet all prerequisites, then select **Next**.

1. On the **Add servers** page, enter your account username using the format domain\username. Enter your password, then select **Next**. This account must be a member of the local Administrators group on each server.

1. Specify the first server you want to use in the cluster, and then select **Add**. When you're finished adding servers, select **Next**.

1. On the **Install required features** page, optionally review the features that you can install on each of the servers and then select **Install features**. When you're finished, select **Next**.

1. On the **Optionally install operating system updates** page, review the available OS updates, and then select **Install updates** to install them. When you're finished, select **Next**.

1. On the **Restart servers** page, restart the servers if the new features you installed require a restart. When you're finished, select **Next: Networking**.

### Step 2: Networking

Step 2 of the wizard walks you through configuring the host networking elements for your cluster.

1. On the **Check the network adapters** page, a popup window might ask if you want to remove existing virtual switches. Select **Yes** to delete any older virtual switches and let Windows Admin Center create the appropriate switches, unless you intentionally created them and want to preserve the switches.

1. To enable any adapters that you want to use, select the name of the adapter, then select **Enable**. Select **Disable** for any adapters you don't want to use. When you're finished, select **Next**.

1. On the **Select the adapters to use for management** page, select one or two management adapters to use for each server. You must select at least one of the adapters for management purposes, as the wizard requires at least one dedicated physical NIC for cluster management. Once you designate an adapter for management, the wizard excludes it from the rest of the wizard workflow.

    Management adapters have two configuration options:

    - **One physical network adapter for management**. This option supports both DHCP or static IP address assignment.

    - **Two physical network adapters teamed for management**. When you team a pair of physical adapters, they only support static IP address assignment. If the one or both of the adapters use DHCP addressing, the DHCP IP addresses are converted to static IP addresses before you create the virtual switch.

    By using teamed adapters, you have a single connection to multiple switches but only use a single IP address. Load-balancing becomes available and fault-tolerance is instant instead of waiting for DNS records to update.

    After you select the adapters for management, do the following for each server:

    - Select the **Description** checkbox. Selecting this checkbox also selects all adapters and might cause the wizard to offer you a recommendation.

    - Clear the checkboxes for the adapters you don't want to use for cluster management.

    > [!NOTE]
    > You can use 1 Gb adapters as management adapters, but we recommend using 10 Gb or faster adapters for carrying storage and workload VM traffic.

1. Under the **Virtual switch** page, select one of the following options as applicable. Depending on how many network adapters there are, not all options may be available:

    - Choose **Skip virtual switch creation** if you want to set up virtual switches later.

    - Choose **Create one virtual switch for compute and storage together** if you want to use the same virtual switch for your VMs and Storage Spaces Direct. This is the "converged" option.

    - Choose **Create one virtual switch for compute only** if you want to use a virtual switch for your VMs only.

    - Choose **Create two virtual switches** if you want a dedicated virtual switch each for VMs and for Storage Spaces Direct.

    The following table shows which virtual switch configurations are supported and enabled for various network adapter configurations:

    | Option | 1-2 adapters | 3+ adapters | Teamed adapters |
    | :------------- | :--------- |:--------| :---------|
    | single switch (compute + storage) | enabled | enabled  | not supported |
    | single switch (compute only) | not supported| enabled | enabled |
    | two switches | not supported | enabled | enabled |

1. The **Optionally configure RDMA** page is optional. If you want to configure remote direct memory access (RDMA), select the **Configure RDMA (Recommended)**. When you're done, select **Apply changes**, and then select **Next**.

1. On the **Define Networks** page, review and edit the Name, IP address, Subnet mask, VLAN ID, and Default gateway fields for each listed adapter.

1. Select **Apply and test** to verify the configuration for your nodes. If everything looks okay, select **Next: Clustering**.

### Step 3: Clustering

Step 3 of the wizard makes sure everything is set up correctly so far and then creates the cluster. 

1. On the **Validate this cluster** page, select **Validate**. Validation can take several minutes. The in-wizard validation is different from the post-cluster creation validation step, which performs additional checks to catch any hardware or configuration problems before the cluster goes into production. 

1. Wait for the validation to finish, review all warnings, make changes as appropriate, and select **Validate again** as needed. When you're ready to proceed, select **Next**.

1. On the **Create the cluster** page, enter a unique name for your cluster and specify the IP address for the cluster. When you're finished, select **Create cluster**. The creation process can take a while to complete.

    If you get the error "Failed to reach cluster through DNS," select the **Retry connectivity checks** button. You might have to wait several hours before it succeeds on larger networks due to DNS propagation delays.

    > [!IMPORTANT]
    > If the cluster creation process fails, don't select the **Back** button. Instead, select the **Retry connectivity checks button**. If you select **Back**, the Cluster Creation wizard exits prematurely, which can potentially reset the entire process.

    If you encounter issues with deployment after you create the cluster and you want to restart the Cluster Creation wizard, you must remove the cluster by running the `Remove-Cluster` PowerShell cmdlet.

1. Once the cluster creation process is finished, you can select the **Go to connections list** to view your cluster.

   >[!NOTE]
   >It might take a few minutes for the cluster you created to become accessible by name. If you don't see your cluster on the connections list, wait a few minutes and then refresh.

::: zone-end  

::: zone pivot="powershell"

The following example  creates a failover cluster named *MyCluster* with nodes *Server1* and *Server2*, assigns the static IP address *192.168.1.12*, and adds all eligible storage to the failover cluster.

```PowerShell
New-Cluster –Name MyCluster –Node Server1, Server2 –StaticAddress 192.168.1.12
```

The following example creates the same failover cluster as in the previous example, but it doesn't add eligible storage to the failover cluster.

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

1. If the **Select Servers** page appears, in the **Enter name** box enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, then select **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or a semicolon. For example, enter the names in the format *server1.contoso.com; server2.contoso.com*. When you're finished, select **Next**.

    > [!NOTE]
    > If you chose to create the cluster immediately after running validation in the [configuration validating procedure](#step-3-clustering), you won't see the **Select Servers** page. The nodes you validated are automatically added to the Create Cluster Wizard so that you don't have to enter them again.

1. If you skipped validation earlier, the **Validation Warning** page appears. We strongly recommend that you run cluster validation. Microsoft only supports clusters that pass all validation tests. To run the validation tests, select **Yes**, and then select **Next**. Complete the Validate a Configuration Wizard as described in [Step 3: Clustering](#step-3-clustering).

1. On the **Access Point for Administering the Cluster** page, do the following:

    1. In the **Cluster Name** box, enter the name that you want to use to administer the cluster. Before you do, review the following information:

          - During cluster creation, this name is registered as the cluster computer object, also known as the *cluster name object (CNO)*, in AD DS. If you specify a NetBIOS name for the cluster, the CNO is created in the same location where the computer objects for the cluster nodes reside. This location can be either the default Computers container or an OU.

          - To specify a different location for the CNO, you can enter the distinguished name of an OU in the **Cluster Name** box. For example: *CN=ClusterName, OU=Clusters, DC=Contoso, DC=com*.

          - If a domain administrator prestaged the CNO in a different OU than where the cluster nodes reside, specify the distinguished name that the domain administrator provides.

    1. If the server doesn't have a network adapter that is configured to use Dynamic Host Configuration Protocol (DHCP), you must configure one or more static IP addresses for the failover cluster. Select the check box next to each network that you want to use for cluster management. Select the **Address** field next to a selected network and then enter the IP address that you want to assign to the cluster. This IP address (or addresses) is associated with the cluster name in Domain Name System (DNS).

          >[!NOTE]
          > If you're using Windows Server 2019, you can use a distributed network name for the cluster. A distributed network name uses the IP addresses of the member servers instead of requiring a dedicated IP address for the cluster. By default, Windows uses a distributed network name if it detects that you're creating the cluster in Azure (so you don't have to create an internal load balancer for the cluster) or a normal static or IP address if you're running on-premises. For more info, see [Distributed Network Name](https://blogs.windows.com/windowsexperience/2018/08/14/announcing-windows-server-2019-insider-preview-build-17733/#W0YAxO8BfwBRbkzG.97).

    1. When you're finished, select **Next**.

1. On the **Confirmation** page, review the settings. By default, the **Add all eligible storage to the cluster** check box is selected. Clear this check box if you want to do either of the following things:

      - You want to configure storage later.

      - You plan to create clustered storage spaces through Failover Cluster Manager or through the Failover Clustering Windows PowerShell cmdlets and haven't created storage spaces in File and Storage Services yet. For more information, see [Deploy Clustered Storage Spaces](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj822937(v%3dws.11)>).

1. Select **Next** to create the failover cluster.

1. On the **Summary** page, confirm that the failover cluster was successfully created. If there were any warnings or errors, view the summary output or select **View Report** to view the full report. Select **Finish**.

1. To confirm that the cluster was created, verify that the cluster name is listed under **Failover Cluster Manager** in the navigation tree. You can expand the cluster name and then select items under **Nodes**, **Storage** or **Networks** to view the associated resources.

    It may take some time for the cluster name to successfully replicate in DNS. After successful DNS registration and replication, if you select **All Servers** in Server Manager, the cluster name should be listed as a server with a **Manageability** status of **Online**.

::: zone-end  

After you create the cluster, you can verify cluster quorum configuration and create Cluster Shared Volumes (CSV). For more information, see [Understanding Quorum in Storage Spaces Direct](/azure-stack/hci/concepts/quorum) and [Use Cluster Shared Volumes in a failover cluster](failover-cluster-csvs.md).

::: zone pivot="powershell"

## Create clustered roles in PowerShell

After you create the failover cluster, you can create clustered roles to host cluster workloads.

>[!NOTE]
>For clustered roles that require a client access point, a virtual computer object (VCO) is created in AD DS. By default, all VCOs for the cluster are created in the same container or OU as the CNO. Realize that after you create a cluster, you can move the CNO to any OU.

For examples of how to add clustered roles using PowerShell, see [Add-ClusterFileServerRole](/powershell/module/failoverclusters/add-clusterfileserverrole) and [Add-ClusterGenericApplicationRole](/powershell/module/failoverclusters/add-clustergenericapplicationrole).

::: zone-end  

::: zone pivot="failover-cluster-manager"

## Create clustered roles in Failover Cluster Manager

After you create the failover cluster, you can create clustered roles to host cluster workloads.

>[!NOTE]
>For clustered roles that require a client access point, a virtual computer object (VCO) is created in AD DS. By default, all VCOs for the cluster are created in the same container or OU as the CNO. Realize that after you create a cluster, you can move the CNO to any OU.

Use Server Manager to install the role or feature that is required for a clustered role on each failover cluster node. For example, if you want to create a clustered file server, install the File Server role on all cluster nodes.

The following table shows the clustered roles that you can configure in the High Availability Wizard and the associated server role or feature that you must install as a prerequisite.

| Clustered role  | Role or feature prerequisite  |
| ---------       | ---------                    |
| Namespace Server     |   Namespaces (part of File Server role)       |
| Distributed File System (DFS) Namespace Server     |  DHCP Server role       |
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

1. To verify that you successfully created the clustered role, in the **Roles** pane, make sure that the role has a status of **Running**. The Roles pane also indicates the owner node. To test failover, right-click the role, point to **Move** and then select **Select Node**. In the **Move Clustered Role** dialog box, select the desired cluster node, then select **OK**. In the **Owner Node** column, verify that the owner node changed.

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


