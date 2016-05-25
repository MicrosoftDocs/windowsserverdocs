---
title: Create a Failover Cluster
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 26f7bb1d-1b63-4ffb-8fd0-157c3439fd50
author: kumudd
---
# Create a Failover Cluster
This topic shows how to create a failover cluster by using either the Failover Cluster Manager snap\-in or Windows PowerShell. The topic covers a typical deployment, where computer objects for the cluster and its associated clustered roles are created in Active Directory Domain Services \(AD DS\).  
  
> [!NOTE]  
> In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] you can also deploy an Active Directory\-detached cluster. This deployment method enables you to create a failover cluster without permissions to create computer objects in AD DS or the need to request that computer objects are prestaged in AD DS. This option is only available through Windows PowerShell, and is only recommended for specific scenarios. For more information, see [Deploy an Active Directory-Detached Cluster](../Topic/Deploy-an-Active-Directory-Detached-Cluster.md).  
  
![](../Image/2b05dce3-938f-4168-9b8f-1f4398cbdb9b.gif)**Checklist: Create a failover cluster**  
  
||Task|Reference|  
|-|--------|-------------|  
|![](../Image/icon_checkboxo.gif)|Verify the prerequisites|[Verify the prerequisites](#BKMK_ClusPrereq)|  
|![](../Image/icon_checkboxo.gif)|Install the Failover Clustering feature on every server that you want to add as a cluster node|[Install the Failover Clustering feature](#BKMK_InstallFeature)|  
|![](../Image/icon_checkboxo.gif)|Run the Cluster Validation Wizard to validate the configuration|[Validate the configuration](#BKMK_Validate)|  
|![](../Image/icon_checkboxo.gif)|Run the Create Cluster Wizard to create the failover cluster|[Create the failover cluster](#BKMK_Create)|  
|![](../Image/icon_checkboxo.gif)|Create clustered roles to host cluster workloads|[Create clustered roles](#BKMK_CreateRole)|  
  
![](../Image/PowerShellLogoSmall.gif)[Complete these tasks by using Windows PowerShell](#BKMK_PowerShell)  
  
## <a name="BKMK_ClusPrereq"></a>Verify the prerequisites  
Before you begin, verify the following prerequisites:  
  
-   Make sure that all servers that you want to add as cluster nodes are running the same version of Windows Server.  
  
    > [!NOTE]  
    > You can use the Failover Clustering feature on all editions of [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This includes Server Core installations.  
  
-   Review the hardware requirements to make sure that your configuration is supported. For more information, see [Failover Clustering Hardware Requirements and Storage Options](../Topic/Failover-Clustering-Hardware-Requirements-and-Storage-Options.md).  
  
-   If you want to add clustered storage during cluster creation, make sure that all servers can access the storage. \(You can also add clustered storage after you create the cluster.\)  
  
-   Make sure that all servers that you want to add as cluster nodes are joined to the same Active Directory domain.  
  
-   \(Optional\) Create an organizational unit \(OU\) and move the computer accounts for the servers that you want to add as cluster nodes into the OU. As a best practice, we recommend that you place failover clusters in their own OU in AD DS. This can help you better control which Group Policy settings or security template settings affect the cluster nodes. By isolating clusters in their own OU, it also helps prevent against accidental deletion of cluster computer objects.  
  
Additionally, verify the following account requirements:  
  
-   Make sure that the account you want to use to create the cluster is a domain user who has administrator rights on all servers that you want to add as cluster nodes.  
  
-   Make sure that either of the following is true:  
  
    -   The user who creates the cluster has the **Create Computer objects** permission to the OU or the container where the servers that will form the cluster reside.  
  
    -   If the user does not have the **Create Computer objects** permission, ask a domain administrator to prestage a cluster computer object for the cluster. For more information, see [Prestage Cluster Computer Objects in Active Directory Domain Services](../Topic/Prestage-Cluster-Computer-Objects-in-Active-Directory-Domain-Services.md).  
  
    > [!NOTE]  
    > This requirement does not apply if you want to create an Active Directory\-detached cluster in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For more information, see [Deploy an Active Directory-Detached Cluster](../Topic/Deploy-an-Active-Directory-Detached-Cluster.md).  
  
## <a name="BKMK_InstallFeature"></a>Install the Failover Clustering feature  
You must install the Failover Clustering feature on every server that you want to add as a failover cluster node.  
  
#### To install the Failover Clustering feature  
  
1.  Start Server Manager.  
  
2.  On the **Manage** menu, click **Add Roles and Features**.  
  
3.  On the **Before you begin** page, click **Next**.  
  
4.  On the **Select installation type** page, click **Role\-based or feature\-based installation**, and then click **Next**.  
  
5.  On the **Select destination server** page, click the server where you want to install the feature, and then click **Next**.  
  
6.  On the **Select server roles** page, click **Next**.  
  
7.  On the **Select features** page, select the **Failover Clustering** check box.  
  
8.  To install the failover cluster management tools, click **Add Features**, and then click **Next**.  
  
9. On the **Confirm installation selections** page, click **Install**.  
  
    > [!NOTE]  
    > A server restart is not required for the Failover Clustering feature.  
  
10. When the installation is completed, click **Close**.  
  
11. Repeat this procedure on every server that you want to add as a failover cluster node.  
  
> [!NOTE]  
> After you install the Failover Clustering feature, we recommend that you apply the latest updates from Windows Update. Also, for a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\-based failover cluster, review the Microsoft Support article [Recommended hotfixes and updates for Windows Server 2012\-based Failover Clusters](http://support.microsoft.com/kb/2784261), and install any updates that apply.  
  
## <a name="BKMK_Validate"></a>Validate the configuration  
Before you create the failover cluster, we strongly recommend that you validate the configuration to make sure that the hardware and hardware settings are compatible with failover clustering. Microsoft supports a cluster solution only if the complete configuration passes all validation tests and if all hardware is certified for the version of Windows Server that the cluster nodes are running.  
  
> [!NOTE]  
> You must have at least two nodes to run all tests. If you have only one node, many of the critical storage tests do not run.  
  
#### To run cluster validation tests  
  
1.  On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools, or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. To do this on a server, start Server Manager, and then on the **Tools** menu, click **Failover Cluster Manager**.  
  
2.  In the **Failover Cluster Manager** pane, under **Management**, click **Validate Configuration**.  
  
3.  On the **Before You Begin** page, click **Next**.  
  
4.  On the **Select Servers or a Cluster** page, in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then click **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or by a semicolon. For example, enter the names in the format *server1.contoso.com, server2.contoso.com*. When you are finished, click **Next**.  
  
5.  On the **Testing Options** page, click **Run all tests \(recommended\)**, and then click **Next**.  
  
6.  On the **Confirmation** page, click **Next**.  
  
    The Validating page displays the status of the running tests.  
  
7.  On the **Summary** page, do either of the following:  
  
    -   If the results indicate that the tests completed successfully and the configuration is suited for clustering, and you want to create the cluster immediately, make sure that the **Create the cluster now using the validated nodes** check box is selected, and then click **Finish**. Then, continue to step 4 of the [Create the failover cluster](#BKMK_Create) procedure.  
  
    -   If the results indicate that there were warnings or failures, click **View Report** to view the details and determine which issues must be corrected. Realize that a warning for a particular validation test indicates that this aspect of the failover cluster can be supported, but might not meet the recommended best practices.  
  
        > [!NOTE]  
        > If you receive a warning for the Validate Storage Spaces Persistent Reservation test, see the blog post [Windows Failover Cluster validation warning indicates your disks don't support the persistent reservations for Storage Spaces](http://blogs.msdn.com/b/clustering/archive/2013/05/24/10421247.aspx) for more information.  
  
    For more information about hardware validation tests, see [Validate Hardware for a Failover Cluster_1](../Topic/Validate-Hardware-for-a-Failover-Cluster_1.md).  
  
## <a name="BKMK_Create"></a>Create the failover cluster  
To complete this step, make sure that the user account that you log on as meets the requirements that are outlined in the [Verify the prerequisites](#BKMK_ClusPrereq) section of this topic.  
  
#### To create the failover cluster  
  
1.  Start Server Manager.  
  
2.  On the **Tools** menu, click **Failover Cluster Manager**.  
  
3.  In the **Failover Cluster Manager** pane, under **Management**, click **Create Cluster**.  
  
    The Create Cluster Wizard opens.  
  
4.  On the **Before You Begin** page, click **Next**.  
  
5.  If the **Select Servers** page appears, in the **Enter name** box, enter the NetBIOS name or the fully qualified domain name of a server that you plan to add as a failover cluster node, and then click **Add**. Repeat this step for each server that you want to add. To add multiple servers at the same time, separate the names by a comma or a semicolon. For example, enter the names in the format *server1.contoso.com; server2.contoso.com*. When you are finished, click **Next**.  
  
    > [!NOTE]  
    > If you chose to create the cluster immediately after running validation in the procedure [Validate the configuration](#BKMK_Validate), you will not see the **Select Servers** page. The nodes that were validated are automatically added to the Create Cluster Wizard so that you do not have to enter them again.  
  
6.  If you skipped validation earlier, the **Validation Warning** page appears. We strongly recommend that you run cluster validation. Only clusters that pass all validation tests are supported by Microsoft. To run the validation tests, click **Yes**, and then click **Next**. Complete the Validate a Configuration Wizard as described in the procedure [Validate the configuration](#BKMK_Validate).  
  
7.  On the **Access Point for Administering the Cluster** page, do the following:  
  
    1.  In the **Cluster Name** box, enter the name that you want to use to administer the cluster. Before you do, review the following information:  
  
        -   During cluster creation, this name is registered as the cluster computer object \(also known as the *cluster name object* or *CNO*\) in AD DS. If you specify a NetBIOS name for the cluster, the CNO is created in the same location where the computer objects for the cluster nodes reside. This can be either the default Computers container or an OU.  
  
        -   To specify a different location for the CNO, you can enter the distinguished name of an OU in the **Cluster Name** box. For example: *CN\=ClusterName, OU\=Clusters, DC\=Contoso, DC\=com*.  
  
        -   If a domain administrator has prestaged the CNO in a different OU than where the cluster nodes reside, specify the distinguished name that the domain administrator provides.  
  
    2.  If the server does not have a network adapter that is configured to use DHCP, you must configure one or more static IP addresses for the failover cluster. Select the check box next to each network that you want to use for cluster management. Click the **Address** field next to a selected network, and then enter the IP address that you want to assign to the cluster. This IP address \(or addresses\) will be associated with the cluster name in Domain Name System \(DNS\).  
  
    3.  When you are finished, click **Next**.  
  
8.  On the **Confirmation** page, review the settings. By default, the **Add all eligible storage to the cluster** check box is selected. Clear this check box if you want to do either of the following:  
  
    -   You want to configure storage later.  
  
    -   You plan to create clustered storage spaces through Failover Cluster Manager or through the Failover Clustering Windows PowerShell cmdlets, and have not yet created storage spaces in File and Storage Services. For more information, see [Deploy Clustered Storage Spaces](assetId:///7b33931e-7971-49b0-b385-b1e5a90d94fe).  
  
9. Click **Next** to create the failover cluster.  
  
10. On the **Summary** page, confirm that the failover cluster was successfully created. If there were any warnings or errors, view the summary output or click **View Report** to view the full report. Click **Finish**.  
  
11. To confirm that the cluster was created, verify that the cluster name is listed under **Failover Cluster Manager** in the navigation tree. You can expand the cluster name, and then click items under **Nodes**, **Storage** or **Networks** to view the associated resources.  
  
    Realize that it may take some time for the cluster name to successfully replicate in DNS. After successful DNS registration and replication, if you click **All Servers** in Server Manager, the cluster name should be listed as a server with a **Manageability** status of **Online**.  
  
After the cluster is created, you can do things such as verify cluster quorum configuration, and optionally, create Cluster Shared Volumes \(CSV\). For more information, see [Configure and Manage the Quorum in a Windows Server 2012 Failover Cluster](../Topic/Configure-and-Manage-the-Quorum-in-a-Windows-Server-2012-Failover-Cluster.md)and[Use Cluster Shared Volumes in a Failover Cluster](../Topic/Use-Cluster-Shared-Volumes-in-a-Failover-Cluster.md).  
  
## <a name="BKMK_CreateRole"></a>Create clustered roles  
After you create the failover cluster, you can create clustered roles to host cluster workloads.  
  
> [!NOTE]  
> For clustered roles that require a client access point, a virtual computer object \(VCO\) is created in AD DS. By default, all VCOs for the cluster are created in the same container or OU as the CNO. Realize that after you create a cluster, you can move the CNO to any OU.  
  
#### To create a clustered role  
  
1.  Use Server Manager or Windows PowerShell to install the role or feature that is required for a clustered role on each failover cluster node. For example, if you want to create a clustered file server, install the File Server role on all cluster nodes.  
  
    The following table shows the clustered roles that you can configure in the High Availability Wizard and the associated server role or feature that you must install as a prerequisite.  
  
    |Clustered Role|Role or Feature Prerequisite|  
    |------------------|--------------------------------|  
    |DFS Namespace Server|DFS Namespaces \(part of File Server role\)|  
    |DHCP Server|DHCP Server role|  
    |Distributed Transaction Coordinator \(DTC\)|None|  
    |File Server|File Server role|  
    |Generic Application|Not applicable|  
    |Generic Script|Not applicable|  
    |Generic Service|Not applicable|  
    |Hyper\-V Replica Broker|Hyper\-V role|  
    |iSCSI Target Server|iSCSI Target Server \(part of File Server role\)|  
    |iSNS Server|iSNS Server Service feature|  
    |Message Queuing|Message Queuing Services feature|  
    |Other Server|None|  
    |Virtual Machine|Hyper\-V role|  
    |WINS Server|WINS Server feature|  
  
2.  In Failover Cluster Manager, expand the cluster name, right\-click **Roles**, and then click **Configure Role**.  
  
3.  Follow the steps in the High Availability Wizard to create the clustered role.  
  
4.  To verify that the clustered role was created, in the **Roles** pane, make sure that the role has a status of **Running**. The Roles pane also indicates the owner node. To test failover, right\-click the role, point to **Move**, and then click **Select Node**. In the **Move Clustered Role** dialog box, click the desired cluster node, and then click **OK**. In the **Owner Node** column, verify that the owner node changed.  
  
## <a name="BKMK_PowerShell"></a>Create a failover cluster by using Windows PowerShell  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
The following Windows PowerShell cmdlets perform the same function as the preceding procedures in this topic. Enter each cmdlet on a single line, even though they may appear word\-wrapped across several lines because of formatting constraints.  
  
> [!NOTE]  
> You must use Windows PowerShell to create an Active Directory\-detached cluster in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. For information about the syntax, see [Deploy an Active Directory-Detached Cluster](../Topic/Deploy-an-Active-Directory-Detached-Cluster.md).  
  
The following example installs the Failover Clustering feature.  
  
```  
Install-WindowsFeature –Name Failover-Clustering –IncludeManagementTools  
```  
  
The following example runs all cluster validation tests on computers that are named *Server1* and *Server2*.  
  
```  
Test-Cluster –Node Server1, Server2  
```  
  
> [!NOTE]  
> The **Test\-Cluster** cmdlet outputs the results to a log file in the current working directory, for example C:\\Users\\*username*\\AppData\\Local\\Temp.  
  
The following example creates a failover cluster that is named *MyCluster* with nodes *Server1* and *Server2*, assigns the static IP address *192.168.1.12*, and adds all eligible storage to the failover cluster.  
  
```  
New-Cluster –Name MyCluster –Node Server1, Server2 –StaticAddress 192.168.1.12  
```  
  
The following example creates the same failover cluster as in the previous example, but it does not add eligible storage to the failover cluster.  
  
```  
New-Cluster –Name MyCluster –Node Server1, Server2 –StaticAddress 192.168.1.12 -NoStorage  
```  
  
The following example creates a cluster that is named *MyCluster* in the *Cluster* OU of the domain *Contoso.com*.  
  
```  
New-Cluster -Name CN=MyCluster,OU=Cluster,DC=Contoso,DC=com -Node Server1, Server2  
```  
  
For examples of how to add clustered roles, see topics such as [Add\-ClusterFileServerRole](http://technet.microsoft.com/library/hh847258.aspx) and [Add\-ClusterGenericApplicationRole](http://technet.microsoft.com/library/hh847236.aspx).  
  
## See also  
  
-   [Failover Clustering Overview](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)  
  
-   [Deploy a Hyper-V Cluster](../Topic/Deploy-a-Hyper-V-Cluster.md)  
  
-   [Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)  
  
-   [Deploy an Active Directory-Detached Cluster](../Topic/Deploy-an-Active-Directory-Detached-Cluster.md)  
  
-   [Using Guest Clustering for High Availability](../Topic/Using-Guest-Clustering-for-High-Availability.md)  
  
-   [Cluster\-Aware Updating Overview](assetId:///a8e6dfbb-9d98-4130-86ac-9f6f00241e02)  
  
-   [New\-Cluster](http://technet.microsoft.com/library/hh847246.aspx)  
  
-   [Test\-Cluster](http://technet.microsoft.com/library/hh847274.aspx)  
  
