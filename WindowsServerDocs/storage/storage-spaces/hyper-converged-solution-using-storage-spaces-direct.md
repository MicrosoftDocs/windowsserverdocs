---
title: Deploying Storage Spaces Direct
ms.prod: windows-server-threshold
manager: eldenc
ms.author: stevenek
ms.technology: storage-spaces
ms.topic: get-started-article
ms.assetid: 20fee213-8ba5-4cd3-87a6-e77359e82bc0
author: stevenek
ms.date: 3/5/2017
description: Deploy software-defined storage with Storage Spaces Direct and Windows Server in either a hyper-converged solution - where the cluster hosts the storage and virtual machines - or a converged (also known as disaggregated) solution where workloads run on a different cluster. 
ms.localizationpriority: medium
---
# Deploying Storage Spaces Direct

>Applies to: Windows Server 2016

This topic provides instructions for how to deploy [Storage Spaces Direct](storage-spaces-direct-overview.md) to provide software-defined storage for your workloads. It describes both hyper-converged solutions where the cluster hosts the storage and virtual machines as well as a converged (also known as disaggregated) solution where workloads run on a different cluster. Storage Spaces Direct runs on Windows Server 2016 Datacenter Edition.

Note that for production environments we recommend acquiring a [Windows Server Software-Defined](https://microsoft.com/wssd) hardware/software offering, which includes production deployment tools and procedures. These offerings are designed, assembled, and validated to meet Microsoft's requirements for private cloud environments, helping ensure reliable operation.

To evaluate Storage Spaces Direct without investing in hardware, you can use Hyper-V virtual machines, as described in [Using Storage Spaces Direct in guest virtual machine clusters](storage-spaces-direct-in-vm.md).

Before deploying Storage Spaces Direct, we recommend reviewing the [Storage Spaces Direct hardware requirements](Storage-Spaces-Direct-Hardware-Requirements.md) and skimming this document to familiarize yourself with the overall approach, and to get a sense for the important notes associated with some steps. You also might want to review the extensive and handy [Windows Server 2016 rapid lab deployment scripts](https://aka.ms/ws2016lab), which we use for training purposes.

## Converged and hyper-converged solutions

You can deploy Storage Spaces Direct in the following configurations:

- **Converged (disaggregated)** - Workloads run in a separate cluster from the Storage Spaces Direct cluster. Files for the workloads are stored on file shares hosted by the Storage Spaces Direct cluster and accessed across the network. This allows you to scale your workload cluster(s) separately from your storage but does increase the number of clusters involved.
- **Hyper-converged** - Hyper-V VMs run directly on the Storage Spaces Direct cluster that hosts the storage, as shown in Figure 1. Virtual machine files are stored on local CSVs. This allows for scaling Hyper-V compute clusters together with the storage it is using, reducing the number of clusters required.

   ![A hyper-converged cluster with virtual machines hosted by the Storage Spaces Direct cluster](media/Hyper-converged-solution-using-Storage-Spaces-Direct-in-Windows-Server-2016/StorageSpacesDirectHyperconverged.png)

   **FIGURE 1:** Storage Spaces Direct in a hyper-converged deployment with virtual machines running directly on the storage cluster

## Information gathering

The following information will be needed as inputs to configure provision and manage the hyper-converged system, and therefore it will speed up the process and make it easier for you if you have it on hand when you start:  

-   **Server Names** You should be familiar with your organization's naming policies for computers, files, paths, and other resources as you'll be provisioning several servers each will need to have a unique server name.

-   **Domain name** You'll be joining computers to your domain, and you'll need to specify the domain name. It would be good to familiarize with your internal domain naming and domain joining policies.  

-   **For RDMA configurations:**  

    -   Top of Rack switch make/model (required when using RoCE v2 NICs)

    -   Network adapter make/model

        There are 2 types of RDMA protocols, note which type your RDMA adapter is (iWarp or RoCE - also note RoCE version).

    -   VLAN ID to be used for the 2 network interfaces used by the management OS on the hyper-converged hosts. You should be able to obtain this from your network administrator.  

## Installation options

You can use Windows Server 2016 Datacenter Edition with the Server Core, or Server with Desktop Experience installation options.

This guide focuses on deploying using the Server Core installation option. However, the steps in the "Configure the Network" and "Configure Storage Spaces Direct" sections are identical whether you are using Server with Desktop Experience or Server Core installations.

## Management system

For the purposes of this document, the machine that has the management tools to locally or remotely manage the cluster is referred to as the management system. The management system machine has the following requirements:  

- Running Windows Server 2016 with the same updates as the servers it's managing, and also joined to the same domain or a fully trusted domain.

- Remote Server Administration Tools (RSAT) and PowerShell modules for Hyper-V and Failover Clustering. RSAT tools and PowerShell modules are available on Windows Server and can be installed without installing other features. You can also install the [Remote Server Administration Tools](https://www.microsoft.com/download/details.aspx?id=45520) on a Windows 10 management PC.

- Management system can be run inside of a virtual machine or on a physical machine.  

- Requires network connectivity to the servers it's managing.

## Step 1: Deploy Windows Server

When you install Windows Server using the Setup wizard, you may be able to choose between Windows Server and Windows Server (Server with Desktop Experience). The Server with Desktop Experience option is the equivalent of the Full installation option available in Windows Server 2012 R2 with the Desktop Experience feature installed. If you don't make a choice in the Setup wizard, Windows Server is installed with the Server Core installation option. The Server Core option reduces the space required on disk, the potential attack surface, and especially the servicing requirements, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the Server with Desktop Experience option.

For more information about these two installation options, see [Installation Options for Windows Server 2016](../../get-started/Windows-Server-2016.md).
For detailed information about deploying Windows Server in Server Core mode, see [Install Server Core](../../get-started/Getting-Started-with-Server-Core.md).

### Step 1.1: Connecting to the cluster nodes

You'll need a management system that has Windows Server with the same updates to manage and configuration as the cluster nodes. If it's a Server with Desktop Experience deployment, you can manage it from a remote machine or by logging into one of the cluster nodes. You may also use a Windows 10 client machine that has the latest updates installed, and the client Remote Server Administration Tools (RSAT) for Windows Server tools installed.

1. On the Management system install the Failover Cluster and Hyper-V management tools. This can be done through Server Manager using the **Add Roles and Features** wizard. On the **Features** page, select **Remote Server Administration Tools**, and then select the tools to install.

2. Enter the PS session and use either the server name or the IP address of the node you want to connect to. You'll be prompted for a password after you execute this command, enter the administrator password you specified when setting up Windows.

   ```PowerShell
   Enter-PSSession -ComputerName <myComputerName> -Credential LocalHost\Administrator
   ```

   Here's an example of doing the same thing in a way that is more useful in scripts, in case you need to do this more than once:

   ```PowerShell
   $myServer1 = "myServer-1"
   $user = "$myServer1\Administrator"

   Enter-PSSession -ComputerName $myServer1 -Credential $user
   ```

    > [!TIP]
    >  If you're using a management computer that's not joined to the same domain as your file server cluster, you might get the following error when you try to connect to the nodes by using Windows PowerShell.  
    >   
    >  `Connecting to remote server <Node1> failed with the following error message : WinRM cannot process the request. The following error with errorcode 0x80090311 occurred while using Kerberos authentication: There are currently no logon servers available to service the logon request.`  
    >   
    >  To fix this, use Windows PowerShell to add each node to the Trusted Hosts list on your management computer. Here's how (if your nodes all share a common prefix, you can use a wildcard, as shown below):  
    >   
    >  `Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value Node* -Force`  
    >   
    >  To view your Trusted Hosts list, type `Get-Item WSMAN:\Localhost\Client\TrustedHosts`.  
    >   
    >  To empty the list, type `Clear-Item WSMAN:\Localhost\Client\TrustedHost`.  

### Step 1.2: Joining a domain and adding domain accounts

So far this guide has had you deploying and configuring individual nodes with the local administrator account &lt;ComputerName&gt;\\Administrator.

Managing a Storage Spaces Direct cluster often requires using an Active Directory Domain Services domain account that is in the Administrators group on each node. You'll also want to join all the nodes to a domain.

From the management system, perform the following steps:

1. On the management system, open a PowerShell console with Administrator privileges.
2. Use Enter-PSSession to connect to each node and then run the following command to add a node to the appropriate domain, substituting your own computer name, domain name, and domain credentials:

    ```PowerShell  
    Add-Computer -NewName "FSNode01" -DomainName "contoso.com" -Credential "CONTOSO\GAppel" -Restart -Force  
    ``` 
3. If your storage administrator account isn't a member of the Domain Admins group, add your storage administrator account to the local Administrators group on each node - or better yet, add the group you use for storage administrators.  You can use the following command (or write a Windows PowerShell function to do so - see [Use PowerShell to Add Domain Users to a Local Group](http://blogs.technet.com/b/heyscriptingguy/archive/2010/08/19/use-powershell-to-add-domain-users-to-a-local-group.aspx) for more info):

    ```
    Net localgroup Administrators <Domain\Account> /add
    ```

### Step 1.3: Install server roles and features

The next step is to [install the server roles and features](../../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md) on all of the nodes:
* Failover Clustering
* Hyper-V
* File Server (if you want to host any file shares, such as for a converged deployment)
* Data-Center-Bridging (if you're using RoCEv2 instead of iWARP network adapters)
* RSAT-Clustering-PowerShell
* Hyper-V-PowerShell

To do so, use the Install-WindowsFeature cmdlet. Here's an example PowerShell script you can use to install the roles and features on all members - just change the *Servers* and *ServerRoles* variables to fit your deployment:

```PowerShell
# Fill in these variables with your values
$Servers = "storage-node01","storage-node02","storage-node03","storage-node04"
$ServerRoles = "Data-Center-Bridging","Failover-Clustering","Hyper-V","RSAT-Clustering-PowerShell","Hyper-V-PowerShell","FS-FileServer"

foreach ($server in $servers){
    Install-WindowsFeature –Computername $server –Name $ServerRoles
}
```

If you later need to remove some features, update the *$Roles* variable and replace *Install-WindowsFeature* with *Remove-WindowsFeature*.

## Step 2: Configure the network

There are a number of ways to setup networking with Storage Spaces Direct. For details, see [RDMA configuration guidelines for Windows Server 2016 and Windows Server](https://gallery.technet.microsoft.com/RDMA-configuration-425bcdf2). 

If you're testing Storage Spaces Direct inside of virtual machines, skip this section. RDMA is not available for networking inside a virtual machine.

Here are a few points about networking and Storage Spaces Direct:

- Storage Spaces Direct requires high bandwidth and low latency network connections between nodes. This network connectivity is important for both system performance and reliability. We recommend using at least two 10 Gb connections between the nodes, preferably with RDMA to increase throughput and reduce the CPU usage for network traffic.

- There are two common versions of RDMA network adapters - RoCE and iWARP. You can use either with Storage Spaces Direct as long as it has the Windows Server 2016 logo, but iWARP usually requires less configuration. Top of Rack switches and server configurations vary depending on the network adapters and switches. Configuring the server and switch correctly is important to ensure reliability and performance of Storage Spaces Direct.

- Windows Server 2016 also introduces a new virtual switch that has network teaming built in called Switch Embedded Teaming (SET). This virtual switch allows the same physical NIC ports to be used for all network traffic while using RDMA. This reduces the number of physical NIC ports that would otherwise be required and allows managing the networking through the Software Defined Network features of Windows Server.

## Step 3: Configure Storage Spaces Direct

The following steps are done on a management system that is the same version as the servers being configured. The following steps should NOT be run remotely using a PowerShell session, but instead run in a local PowerShell session on the management system, with administrative permissions.

### Step 3.1: Run cluster validation

In this step, you'll run the cluster validation tool to ensure that the server nodes are configured correctly to create a cluster using Storage Spaces Direct. When cluster validation (Test-Cluster) is run before the cluster is created, it runs the tests that verify that the configuration appears suitable to successfully function as a failover cluster. The example directly below uses the "-Include" parameter, and then the specific categories of tests are specified. This ensures that the Storage Spaces Direct specific tests are included in the validation.

Use the following PowerShell command to validate a set of servers for use as a Storage Spaces Direct cluster.

```PowerShell
Test-Cluster –Node <MachineName1, MachineName2, MachineName3, MachineName4> –Include "Storage Spaces Direct", "Inventory", "Network", "System Configuration"
```

### Step 3.2: Create a cluster

In this step, you'll create a cluster with the nodes that you have validated for cluster creation in the preceding step using the following PowerShell cmdlet.

When creating the cluster, you'll get a warning that states - "There were issues while creating the clustered role that may prevent it from starting. For more information, view the report file below." You can safely ignore this warning. It's due to no disks being available for the cluster quorum. Its recommended that a file share witness or cloud witness is configured after creating the cluster.

> [!Note]
> If the servers are using static IP addresses, modify the following command to reflect the static IP address by adding the following parameter and specifying the IP address:–StaticAddress &lt;X.X.X.X&gt;.
> In the following command the ClusterName placeholder should be replaced with a netbios name that is unique and 15 characters or less.
> ```PowerShell
> New-Cluster –Name <ClusterName> –Node <MachineName1,MachineName2,MachineName3,MachineName4> –NoStorage
> ```

After the cluster is created, it can take time for DNS entry for the cluster name to be replicated. The time is dependent on the environment and DNS replication configuration. If resolving the cluster isn't successful, in most cases you can be successful with using the machine name of a node that is an active member of the cluster may be used instead of the cluster name.

### Step 3.3: Configure a cluster witness

It is recommended that you configure a witness for the cluster, so that a three or more node system can withstand two nodes failing or being offline. A two-node deployment requires a cluster witness, otherwise either node going offline will cause the other to become unavailable as well. With these systems, you can use a file share as a witness, or use cloud witness. For more info, see [Deploy a Cloud Witness for a Failover Cluster](../../failover-clustering/deploy-cloud-witness.md).

For more information about configuring a file share witness, see [*Configuring a File Share Witness on a Scale-Out File Server*](https://blogs.msdn.microsoft.com/clustering/2014/03/31/configuring-a-file-share-witness-on-a-scale-out-file-server/).

### Step 3.4: Clean disks

The disks intended to be used for Storage Spaces Direct need to be empty and without partitions or other data. If a disk has partitions or other data, it will not be included in the Storage Spaces Direct system.

On the management system, open a PowerShell ISE window with Administrator privileges, and then create and run the following script, replacing the *&lt;ClusterName&gt;* variable with the appropriate cluster name. Running this script will help identify the disks on each node that are detected to be able to be used for Storage Spaces Direct, and removes all data and partitions from those disks.

You can skip this step if the disks have already been cleaned or verified to be without partitions.

> [!Warning]
> Ensure that there is no data on any of the disks of the cluster before running this set of commands. It will remove any data on the disks that are not being use by the operating system.

```PowerShell
icm (Get-Cluster -Name <cluster or node name> | Get-ClusterNode) {

Update-StorageProviderCache

Get-StoragePool | ? IsPrimordial -eq $false | Set-StoragePool -IsReadOnly:$false -ErrorAction SilentlyContinue

Get-StoragePool | ? IsPrimordial -eq $false | Get-VirtualDisk | Remove-VirtualDisk -Confirm:$false -ErrorAction SilentlyContinue

Get-StoragePool | ? IsPrimordial -eq $false | Remove-StoragePool -Confirm:$false -ErrorAction SilentlyContinue

Get-PhysicalDisk | Reset-PhysicalDisk -ErrorAction SilentlyContinue

Get-Disk | ? Number -ne $null | ? IsBoot -ne $true | ? IsSystem -ne $true | ? PartitionStyle -ne RAW | % {

$_ | Set-Disk -isoffline:$false

$_ | Set-Disk -isreadonly:$false

$_ | Clear-Disk -RemoveData -RemoveOEM -Confirm:$false

$_ | Set-Disk -isreadonly:$true

$_ | Set-Disk -isoffline:$true

}

Get-Disk |? Number -ne $null |? IsBoot -ne $true |? IsSystem -ne $true |? PartitionStyle -eq RAW | Group -NoElement -Property FriendlyName

} | Sort -Property PsComputerName,Count
```

The output from this script will look similar to the following. The **Count** is the number of disks with that name per cluster node (PSComputerName):

```
Count Name                          PSComputerName
----- ----                          --------------
4     ATA SSDSC2BA800G4n            StorageClusterNode1
10    ATA ST4000NM0033              StorageClusterNode1
4     ATA SSDSC2BA800G4n            StorageClusterNode2
10    ATA ST4000NM0033              StorageClusterNode2
4     ATA SSDSC2BA800G4n            StorageClusterNode3
10    ATA ST4000NM0033              StorageClusterNode3
4     ATA SSDSC2BA800G4n            StorageClusterNode4
10    ATA ST4000NM0033              StorageClusterNode4
```

### Step 3.5: Enable Storage Spaces Direct

After creating the cluster, use the Enable-ClusterStorageSpacesDirect PowerShell cmdlet, which will put the storage system into the Storage Spaces Direct mode and do the following automatically:

-   **Create a pool:** Creates a single large pool that has a name like "S2D on Cluster1".

-   **Configures the Storage Spaces Direct caches:** If there is more than one media (drive) type available for Storage Spaces Direct use, it enables the fastest as cache devices (read and write in most cases)

-   **Tiers:** Creates two tiers as default tiers. One is called "Capacity" and the other called "Performance". The cmdlet analyzes the devices and configures each tier with the mix of device types and resiliency.

From the management system, in a PowerShell command windows opened with Administrator privileges, initiate the following command. The cluster name is the name of the cluster that you created in the previous steps. If this command is run locally on one of the nodes, the -CimSession parameter is not necessary.

```PowerShell
Enable-ClusterStorageSpacesDirect –CimSession <ClusterName>
```

To enable Storage Spaces Direct using the above command, you can also use the node name instead of the cluster name. Using the node name may be more reliable due to DNS replication delays that may occur with the newly created cluster name.

When this command is finished, which may take several minutes, the system will be ready for volumes to be created.

### Step 3.6: Create volumes

We recommend using the **New-Volume** cmdlet as it provides the fastest and most straightforward experience. This single cmdlet automatically creates the virtual disk, partitions and formats it, creates the volume with matching name, and adds it to cluster shared volumes – all in one easy step.

For more information, check out [Creating volumes in Storage Spaces Direct](create-volumes.md).

### Step 3.7: Enable the CSV cache

You can optionally enable the cluster shared volume (CSV) cache to use system memory (RAM) as a write-through block-level cache of read operations that aren't already cached by the Windows cache manager. This can improve performance for applications such as Hyper-V. The CSV cache can boost the performance of read requests and is also useful for Scale-Out File Server scenarios.

Enabling the CSV cache reduces the amount of memory available to run VMs on a hyper-converged cluster, so you'll have to balance storage performance with memory available to VHDs. 10 GB of memory per node in a two-node cluster is a common CSV cache size, with 20 GB per node common for a four-node cluster. When scaling to larger clusters, consider adding 5 GB of CSV cache per node for each additional node you add to the cluster, again, balancing this against available memory for the operating system and VMs.

To set the size of the CSV cache, open a PowerShell session on the management system with an account that has administrator permissions on the storage cluster, and then use this script, changing the `$ClusterName` and `$CSVCacheSize` variables as appropriate (this example sets a 10 GB CSV cache):

```PowerShell
$ClusterName = "StorageSpacesDirect1"
$CSVCacheSize = 10240 #Size in MB

Write-Output "Setting the CSV cache..."
(Get-Cluster $ClusterName).BlockCacheSize = $CSVCacheSize

$CSVCurrentCacheSize = (Get-Cluster $ClusterName).BlockCacheSize
Write-Output "$ClusterName CSV cache size: $CSVCurrentCacheSize MB"
```

For more info, see [How to Enable CSV Cache](https://blogs.msdn.microsoft.com/clustering/2013/07/19/how-to-enable-csv-cache/).

### Step 3.7: Deploy virtual machines for hyper-converged deployments

If you're deploying a hyper-converged cluster, the last step is to provision virtual machines on the Storage Spaces Direct cluster.

The virtual machine's files should be stored on the systems CSV namespace (example: c:\\ClusterStorage\\Volume1) just like clustered VMs on failover clusters.

You can use in-box tools or other tools to manage the storage and virtual machines, such as System Center Virtual Machine Manager.

## Step 4: Deploy Scale-Out File Server for converged solutions

If you're deploying a converged solution, the next step is to create a Scale-Out File Server instance and setup some file shares. If you're deploying a hyper-converged cluster - you're finished and don't need this section.

### Step 4.1: Create the Scale-Out File Server role

The next step in setting up the cluster services for your file server is creating the clustered file server role, which is when you create the Scale-Out File Server instance on which your continuously available file shares are hosted.

#### To create a Scale-Out File Server role by using Server Manager

1.  In Failover Cluster Manager, select the cluster, go to **Roles**, and then click **Configure Role…**.<br>The High Availability Wizard appears.
2.  On the **Select Role** page, click **File Server**.
3.  On the **File Server Type** page, click **Scale-Out File Server for application data**.
4.  On the **Client Access Point** page, type a name for the Scale-Out File Server.
5.  Verify that the role was successfully set up by going to **Roles** and confirming that the **Status** column shows **Running** next to the clustered file server role you created, as shown in Figure 2.

    ![Failover Cluster Manager showing the Scale&#45;Out File Server](media\Hyper-converged-solution-using-Storage-Spaces-Direct-in-Windows-Server-2016\SOFS_in_FCM.png "Failover Cluster Manager showing the Scale-Out File Server")

     **Figure 2** Failover Cluster Manager showing the Scale-Out File Server with the Running status

> [!NOTE]
>  After creating the clustered role, there might be some network propagation delays that could prevent you from creating file shares on it for a few minutes, or potentially longer.  
  
#### To create a Scale-Out File Server role by using Windows PowerShell

 In a Windows PowerShell session that's connected to the file server cluster, enter the following commands to create the Scale-Out File Server role, changing *FSCLUSTER* to match the name of your cluster, and *SOFS* to match the name you want to give the Scale-Out File Server role:

```PowerShell
Add-ClusterScaleOutFileServerRole -Name SOFS -Cluster FSCLUSTER
```

> [!NOTE]
>  After creating the clustered role, there might be some network propagation delays that could prevent you from creating file shares on it for a few minutes, or potentially longer. If the SOFS role fails immediately and won't start, it might be because the cluster's computer object doesn't have permission to create a computer account for the SOFS role. For help with that, see this blog post: [Scale-Out File Server Role Fails To Start With Event IDs 1205, 1069, and 1194](http://www.aidanfinn.com/?p=14142).

### Step 4.2: Create file shares

After you've created your virtual disks and added them to CSVs, it's time to create file shares on them - one file share per CSV per virtual disk. System Center Virtual Machine Manager (VMM) is probably the handiest way to do this because it handles permissions for you, but if you don't have it in your environment, you can use Windows PowerShell to partially automate the deployment.

Use the scripts included in the [SMB Share Configuration for Hyper-V Workloads](http://gallery.technet.microsoft.com/SMB-Share-Configuration-4a36272a) script, which partially automates the process of creating groups and shares. It's written for Hyper-V workloads, so if you're deploying other workloads, you might have to modify the settings or perform additional steps after you create the shares. For example, if you're using Microsoft SQL Server, the SQL Server service account must be granted full control on the share and the file system.

> [!NOTE]
>  You'll have to update the group membership when you add cluster nodes unless you use System Center Virtual Machine Manager to create your shares.

To create file shares by using PowerShell scripts, do the following:

1. Download the scripts included in [SMB Share Configuration for Hyper-V Workloads](http://gallery.technet.microsoft.com/SMB-Share-Configuration-4a36272a) to one of the nodes of the file server cluster.
2. Open a Windows PowerShell session with Domain Administrator credentials on the management system, and then use the following script to create an Active Directory group for the Hyper-V computer objects, changing the values for the variables as appropriate for your environment:

    ```PowerShell
    # Replace the values of these variables
    $HyperVClusterName = "Compute01"
    $HyperVObjectADGroupSamName = "Hyper-VServerComputerAccounts" <#No spaces#>
    $ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"

    # Start of script itself
    CD $ScriptFolder
    .\ADGroupSetup.ps1 -HyperVObjectADGroupSamName $HyperVObjectADGroupSamName -HyperVClusterName $HyperVClusterName
    ```
3. Open a Windows PowerShell session with Administrator credentials on one of the storage nodes, and then use the following script to create shares for each CSV and grant administrative permissions for the shares to the Domain Admins group and the compute cluster.

    ```PowerShell
    # Replace the values of these variables
    $StorageClusterName = "StorageSpacesDirect1"
    $HyperVObjectADGroupSamName = "Hyper-VServerComputerAccounts" <#No spaces#>
    $SOFSName = "SOFS"
    $SharePrefix = "Share"
    $ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"

    # Start of the script itself
    CD $ScriptFolder
    Get-ClusterSharedVolume -Cluster $StorageClusterName | ForEach-Object
    {
        $ShareName = $SharePrefix + $_.SharedVolumeInfo.friendlyvolumename.trimstart("C:\ClusterStorage\Volume")
        Write-host "Creating share $ShareName on "$_.name "on Volume: " $_.SharedVolumeInfo.friendlyvolumename
        .\FileShareSetup.ps1 -HyperVClusterName $StorageClusterName -CSVVolumeNumber $_.SharedVolumeInfo.friendlyvolumename.trimstart("C:\ClusterStorage\Volume") -ScaleOutFSName $SOFSName -ShareName $ShareName -HyperVObjectADGroupSamName $HyperVObjectADGroupSamName
    }
    ```

### Step 4.3 Enable Kerberos constrained delegation

To setup Kerberos constrained delegation for remote scenario management and increased Live Migration security, from one of the storage cluster nodes, use the KCDSetup.ps1 script included in [SMB Share Configuration for Hyper-V Workloads](http://gallery.technet.microsoft.com/SMB-Share-Configuration-4a36272a). Here's a little wrapper for the script:

```PowerShell
$HyperVClusterName = "Compute01"
$ScaleOutFSName = "SOFS"
$ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"

CD $ScriptFolder
.\KCDSetup.ps1 -HyperVClusterName $HyperVClusterName -ScaleOutFSName $ScaleOutFSName -EnableLM
```

## Next steps

After deploying your clustered file server, we recommend testing the performance of your solution using synthetic workloads prior to bringing up any real workloads. This lets you confirm that the solution is performing properly and work out any lingering issues before adding the complexity of workloads. For more info, see [Test Storage Spaces Performance Using Synthetic Workloads](https://technet.microsoft.com/library/dn894707.aspx).

## See also

-   [Storage Spaces Direct in Windows Server 2016](storage-spaces-direct-overview.md)
-   [Understand the cache in Storage Spaces Direct](understand-the-cache.md)
-   [Planning volumes in Storage Spaces Direct](plan-volumes.md)
-   [Storage Spaces Fault Tolerance](storage-spaces-fault-tolerance.md)
-   [Storage Spaces Direct Hardware Requirements](Storage-Spaces-Direct-Hardware-Requirements.md)
-   [To RDMA, or not to RDMA – that is the question](https://blogs.technet.microsoft.com/filecab/2017/03/27/to-rdma-or-not-to-rdma-that-is-the-question/) (TechNet blog)
