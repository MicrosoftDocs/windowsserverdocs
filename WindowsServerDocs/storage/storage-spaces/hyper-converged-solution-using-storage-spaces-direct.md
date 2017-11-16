---
title: Deploying Storage Spaces Direct
ms.prod: windows-server-threshold
manager: eldenc
ms.author: stevenek
ms.technology: storage-spaces
ms.topic: get-started-article
ms.assetid: 20fee213-8ba5-4cd3-87a6-e77359e82bc0
author: stevenek
ms.date: 11/20/2017
description: Deploy Storage Spaces Direct in a hyper-converged cluster in a test lab.
ms.localizationpriority: medium
---
# Deploying Storage Spaces Direct in a hyper-converged or disaggregated solution

>Applies to: Windows Server 2016

This topic provides instructions for how to deploy [Storage Spaces Direct](storage-spaces-direct-overview.md) to provide software-defined storage for your workloads. It describes both hyper-converged solutions where the cluster hosts the storage and virtual machines as well as a disaggregated (also known as converged) solution where workloads run on a different cluster. Storage Spaces Direct runs on Windows Server 2016 Datacenter Edition.

> [!NOTE]
> Note that for production environments we recommend acquiring a *Windows Server Software-Defined* hardware/software offering, which includes production deployment tools and procedures. These offerings are designed, assembled, and validated to meet Microsoft's requirements for private cloud environments, helping ensure reliable operation. More information about the program and links to our partner websites can be found at: [Windows Server Software Defined](https://www.microsoft.com/cloud-platform/software-defined-datacenter).<br>To evaluate Storage Spaces Direct without investing in hardware, you can use Hyper-V virtual machines, as described in [Using Storage Spaces Direct in guest virtual machine clusters](storage-spaces-direct-in-vm.md).

Before deploying Storage Spaces Direct, we recommended reviewing the [Storage Spaces Direct hardware requirements](Storage-Spaces-Direct-Hardware-Requirements.md) and skimming this document to familiarize yourself with the overall approach, and to get a sense for the important notes associated with some steps.

## Hyper-converged and disaggregated solutions

You can deploy Storage Spaces Direct in the following configurations:

- **Hyper-converged** - Hyper-V VMs run directly on the Storage Spaces Direct cluster that hosts the storage, as shown in Figure 1. Virtual machine files are stored on local CSVs. This allows for scaling Hyper-V compute clusters together with the storage it is using, reducing the number of clusters required.
- **Disaggregated** - Workloads run in a separate cluster from the Storage Spaces Direct cluster. Files for the workloads are stored on file shares hosted by the Storage Spaces Direct cluster and accessed across the network. This allows you to scale your workload cluster(s) separately from your storage, but does increase the number of clusters involved.

   ![A hyper-converged cluster with virtual machines hosted by the Storage Spaces Direct cluster](media/Hyper-converged-solution-using-Storage-Spaces-Direct-in-Windows-Server-2016/StorageSpacesDirectHyperconverged.png)

   **FIGURE 1:** Storage Spaces Direct in a hyper-converged deployment with virtual machines running directly on the storage cluster

## Information gathering

The following information will be needed as inputs to configure provision and manage the hyper-converged system, and therefore it will speed up the process and make it easier for you if you have it on hand when you start:  

-   **Server Names** You should be familiar with your organization's naming policies for computers, files, paths, and other resources as you'll be provisioning several servers each will need to have a unique server name.  

-   **Domain name** You'll be joining computers to your domain, and you'll need to specify the domain name. It would be good to familiarize with your internal domain naming and domain joining policies.  

-   **For RDMA configurations:**  

    -   Top of Rack switch make/model (required when using RoCE v2 NICs)

    -   Network adapter make/model

        There are 2 types of RDMA protocols, note which type your RDMA adapter is (RoCE v2 or iWarp).

    -   VLAN ID to be used for the 2 network interfaces used by the management OS on the hyper-converged hosts. You should be able to obtain this from your network administrator.  

## Installation options

You can use Windows Server 2016 Datacenter Edition with the Server Core, or Server with Desktop Experience installation options.

This guide focuses on deploying using the Server Core installation option. However, the steps in the "Configure the Network" and "Configure Storage Spaces Direct" sections are identical whether you are using Server with Desktop Experience or Server Core installations.

## Management system

For the purposes of this document, the machine that has the management tools to locally or remotely manage the cluster is referred to as the management system. The management system machine has the following requirements:  

- Running Windows Server 2016 with the same updates as the servers it's managing, and also joined to the same domain or a fully trusted domain.

- Remote Server Administration Tools (RSAT) and PowerShell modules for Hyper-V and Failover Clustering. RSAT tools and PowerShell modules are available on Windows Server 2016 and can be installed without installing other features.  

- Management system can be run inside of a virtual machine or on a physical machine.  

- Requires network connectivity to the servers it's managing.

## Step 1: Deploy Windows Server

When you install Windows Server using the Setup wizard, you may be able to choose between Windows Server and Windows Server (Server with Desktop Experience). The Server with Desktop Experience option is the equivalent of the Full installation option available in Windows Server 2012 R2 with the Desktop Experience feature installed. If you don't make a choice in the Setup wizard, Windows Server is installed with the Server Core installation option. The Server Core option reduces the space required on disk, the potential attack surface, and especially the servicing requirements, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the Server with Desktop Experience option.

For more information about these two installation options, see [Installation Options for Windows Server 2016](../../get-started/Windows-Server-2016.md).
For detailed information about deploying Windows Server in Server Core mode, see [Install Server Core](../../get-started/Getting-Started-with-Server-Core.md).

### Step 1.1: Connecting to the cluster nodes

You'll need a management system that has Windows Server with the same updates to manage and configuration as the cluster nodes. If it's a Server with Desktop Experience deployment, you can manage it from a remote machine or by logging into one of the cluster nodes. You may also use a Windows 10 client machine that has the latest updates installed, and the client Remote Server Administration Tools (RSAT) for Windows Server tools installed.

1. On the Management system install the Failover Cluster and Hyper-V management tools. This can be done through Server Manager using the **Add Roles and Features** wizard. On the **Features** page, select **Remote Server Administration Tools**, and then select the tools to install.

    Open a PowerShell session with Administrator privileges and execute the following. This will configure the trusted hosts to all hosts.

    ```PowerShell
    Set-Item WSMan:\localhost\Client\TrustedHosts "*"
    ```

    After the onetime configuration above, You'll not need to repeat Set-Item. However, each time you close and reopen the PowerShell console you should establish a new remote PS Session to the server by running the commands below:

2. Enter the PS session and use either the server name or the IP address of the node you want to connect to. You'll be prompted for a password after you execute this command, enter the administrator password you specified when setting up Windows.

   ```PowerShell
   Enter-PSSession -ComputerName <myComputerName> -Credential LocalHost\Administrator
   ```

Examples of doing the same thing in a way that is more useful in scripts, in case you need to do this more than once:

**Example 1:** using an IP address:

   ```PowerShell
   $ip = "10.100.0.1"
   $user = "$ip\Administrator"

   Enter-PSSession -ComputerName $ip -Credential $user
   ```

**Example 2:** OR you can do something similar with computer name instead of IP address.

   ```PowerShell
   $myServer1 = "myServer-1"
   $user = "$myServer1\Administrator"

   Enter-PSSession -ComputerName $myServer1 -Credential $user
   ```

### Step 1.2: Adding domain accounts

So far this guide has had you deploying and configuring individual nodes with the local administrator account &lt;ComputerName&gt;\\Administrator.

Managing a Storage Spaces Direct cluster often requires using a domain account that is in the Administrators group on each node.

From the management system, perform the following steps:

1. On the management system, open a PowerShell console with Administrator privileges.
2. Use Enter-PSSession to connect to each node and then run the following command to add your domain account(s) to the Administrators local security group. See the section above for information about how to connect to the servers using PSSession.

    ```
    Net localgroup Administrators <Domain\Account> /add
    ```

### Step 1.3: Install server roles and features

The next step is to install the following server roles and features on all of the nodes:
* Failover Clustering
* Hyper-V
* File Server (if you want to host any file shares, such as for a disaggregated deployment)
* Data-Center-Bridging (if you're using RoCEv2 instead of iWARP network adapters)
* RSAT-Clustering-PowerShell
* Hyper-V-PowerShell

To do so, use the following PowerShell command:

```PowerShell
Install-WindowsFeature -Name "Data-Center-Bridging","Failover-Clustering","Hyper-V","RSAT-Clustering-PowerShell","Hyper-V-PowerShell","FS-FileServer"
```

## Step 2: Configure the network

Storage Spaces Direct requires high bandwidth and low latency network connections between nodes. This network connectivity is important for both system performance and reliability. We recommended using at least two 10Gb connections between the nodes, preferably with RDMA to increase throughput and reduce the CPU usage for network traffic.

There are two common versions of RDMA network adapters - RoCE and iWARP. You can use either with Storage Spaces Direct as long as it has the Windows Server 2016 logo. iWARP usually requires minimal configuration. Top of Rack switches and server configurations may vary, depending on the network adapter and switch. Configuring the server and switch correctly is important to ensure reliability and performance of Storage Spaces Direct.

Windows Server 2016 also introduces a new virtual switch that has network teaming built in called Switch Embedded Teaming (SET). This virtual switch allows the same 2 physical NIC ports to be used for VMs as well as the parent partition of the server to have RDMA connectivity. The result is reducing the number of physical NIC ports that would otherwise be required and allows managing the networking through the Software Defined Network features of Windows Server. The steps in this guide are for implementing the new virtual switch with RDMA enabled to the parent partition and SET configured.

The following assumes 2 RDMA physical NIC Ports (1 dual port, or 2 single port) and the Hyper-V switch deployed with RDMA-enabled host virtual NICs. Complete the following steps to configure the network *on each server*.

Skip this **Network Configuration** section, if you are testing Storage Spaces Direct inside of virtual machines. RDMA is not available for networking inside a virtual machine.

### Step 2.1: Configure the Top of Rack (TOR) Switch

Our example configuration is using a network adapter that implements RDMA using RoCEv2. Network QoS and reliable flow of data for this type of RDMA requires that the TOR have specific capabilities set for the network ports that the NICs are connected to. If you are deploying with iWarp, the TOR might not need any configuration.

### Step 2.2: Enable Network Quality of Service (QoS)

Network QoS is used to ensure that Storage Spaces Direct has enough bandwidth to communicate between the nodes to ensure resiliency and performance. Do the following steps from a management system using [*Enter-PSSession*](https://docs.microsoft.com/powershell/module/microsoft.powershell.core/enter-pssession) to connect and do the following to each of the servers.

1.  Set a network QoS policy for SMB-Direct, which is the protocol that the software defined storage system uses.

    ```PowerShell
    New-NetQosPolicy "SMB" –NetDirectPortMatchCondition 445 –PriorityValue8021Action 3
    ```

    The output should look something like this:

    ```
    Name : SMB
    Owner : Group Policy (Machine)
    NetworkProfile : All
    Precedence : 127
    JobObject :
    NetDirectPort : 445
    PriorityValue :
    ```

2.  If you are using RoCEv2, install Data-Center-Bridging if you haven't already (see Step 1.3), then turn on Flow Control for SMB as follows (not required for iWarp):

    ```PowerShell
    Enable-NetQosFlowControl –Priority 3
    ```

3.  Disable flow control for other traffic as follows (optional for iWarp):

    ```PowerShell
    Disable-NetQosFlowControl –Priority 0,1,2,4,5,6,7
    ```

4.  Get a list of the network adapters to identify the target adapters (RDMA adapters) as follows:

    ```PowerShell
    Get-NetAdapter | FT Name, InterfaceDescription, Status, LinkSpeed
    ```

    The output should look something like the following. The Mellanox ConnectX03 Pro adapters are the RDMA network adapters and are the only ones connected to a switch, in this example configuration.

    ```
    Name       InterfaceDescription                                      Status       LinkSpeed
    ----       --------------------------------------------------------- ----------   ----------
    NIC3       QLogic BCM57800 Gigabit Ethernet (NDIS VBD Client) #46    Disconnected 0 bps
    Ethernet 2 Mellanox ConnectX-3 Pro Ethernet Adapter #2               Up           10 Gbps
    SLOT #     Mellanox ConnectX-3 Pro Ethernet Adapter                  Up           10 Gbps
    NIC4       QLogic BCM57800 Gigabit Ethernet (NDIS VBD Client) #47    Disconnected 0 bps
    NIC1       QLogic BCM57800 10 Gigabit Ethernet (NDIS VBD Client) #44 Disconnected 0 bps
    NIC2       QLogic BCM57800 10 Gigabit Ethernet (NDIS VBD Client) #45 Disconnected 0 bps
    ```

5. Apply network QoS policy to the target adapters. The target adapters are the RDMA adapters. Use the "Name" of the target adapters for the –Name in the following example

    ```PowerShell
    Enable-NetAdapterQos –Name "<adapter1>", "<adapter2>"
    ```

   Using the example above, the command would look like this:

    ```PowerShell
    Enable-NetAdapterQoS –Name "Ethernet 2", "SLOT #"
    ```

6.  Create a Traffic class and give SMB Direct 30% of the bandwidth minimum. The name of the class will be "SMB".

    ```PowerShell
    New-NetQosTrafficClass "SMB" –Priority 3 –BandwidthPercentage 30 –Algorithm ETS
    ```

### Step 2.3: Create a Hyper-V virtual switch

The Hyper-V virtual switch allows the physical NIC ports to be used for both the host and virtual machines (in a hyper-converged configuration) and enables RDMA from the host which allows for more throughput, lower latency, and less system (CPU) impact. The physical network interfaces are teamed using the Switch Embedded Teaming (SET) feature.

Do the following steps from a management system using *Enter-PSSession* to connect to each of the servers.

1.  Identify the network adapters (you'll use this info in step \#2)

    ```PowerShell
    Get-NetAdapter | FT Name, InterfaceDescription, Status, LinkSpeed
    ```
1.  Create the virtual switch connected to both of the physical network adapters, and enable the Switch Embedded Teaming (SET). You may notice a message that your PSSession lost connection. This is expected and your session will reconnect.

    ```PowerShell
    New-VMSwitch –Name SETswitch –NetAdapterName "<adapter1>", "<adapter2>" –EnableEmbeddedTeaming $true
    ```
1.  Add host vNICs to the virtual switch. This configures a virtual NIC (vNIC) from the virtual switch that you just configured for the management OS to use.

     ```PowerShell
     Add-VMNetworkAdapter –SwitchName SETswitch –Name SMB_1 –managementOS
     Add-VMNetworkAdapter –SwitchName SETswitch –Name SMB_2 –managementOS
     ```
1.  Configure the host vNIC to use a VLAN. They can be on the same or different Vlans.

    ```PowerShell
    Set-VMNetworkAdapterVlan -VMNetworkAdapterName "SMB_1" -VlanId <vlan number> -Access -ManagementOS
    Set-VMNetworkAdapterVlan -VMNetworkAdapterName "SMB_2" -VlanId <vlan number> -Access -ManagementOS
    ```
1.  Verify that the VLANID is set

    ```PowerShell
    Get-VMNetworkAdapterVlan –ManagementOS
    ```

    The output should look like this:

    ```
    VMName VMNetworkAdapterName Mode VlanList
    ------ ------------------- ---- --------
           SMB_1               Access 13
           SETswitch           Untagged
           SMB_2               Access 13
    ```

1.  Restart each host vNIC adapter so that the Vlan is active.

    ```PowerShell
    Restart-NetAdapter "vEthernet (SMB_1)"
    Restart-NetAdapter "vEthernet (SMB_2)"
    ```

1.  Enable RDMA on the host vNIC adapters

    ```PowerShell
    Enable-NetAdapterRDMA "vEthernet (SMB_1)", "vEthernet (SMB_2)"
    ```

1.  Associate each of the vNICs configured for RDMA to a physical adapter that is connected to the virtual switch

    ```PowerShell
    Set-VMNetworkAdapterTeamMapping -VMNetworkAdapterName "SMB_1" –ManagementOS –PhysicalNetAdapterName "SLOT 2"
    Set-VMNetworkAdapterTeamMapping -VMNetworkAdapterName "SMB_2" –ManagementOS –PhysicalNetAdapterName "SLOT 2 2"
    ```

1.  Verify RDMA capabilities.

    ```PowerShell
    Get-SmbClientNetworkInterface
    ```

    Values should show **True** for RDMA Capable for the RDMA enabled interfaces. The following is an example where you show true for the adapters **vEthernet (SMB\_1)** and **vEthernet (SMB\_2)**.

    ```
    Interface Index RSS Capable RDMA Capable Speed    IpAddresses                                                    Friendly Name                                                   
    --------------- ----------- ------------ -----    -----------                                                    -------------                                                   
    15              True        True        20 Gbps  {fe80::4dec:79a4:95c1:69ff, 10.0.1.200, 10.0.1.50, 10.0.1.113} vEthernet (SMB_1)                                               
    10              True        True        20 Gbps  {fe80::8522:df04:73ae:266, 10.0.2.200}                         vEthernet (SMB_2)                                               
    28              False       False        10 Gbps  {fe80::c5e3:bfc7:1c78:910e, 169.254.4.227}                     Local Area Connection* 11                                       
    21              True        False        20 Gbps  {fe80::d1d4:70ca:8b8b:d29c, 10.0.1.107}                        vEthernet (SETswitch)                                           
    22              True        False        1 Gbps   {fe80::a031:def0:3a80:d997, 169.254.217.151}                   NIC1                                                          
    ```

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

### Step 3.7: Deploy virtual machines for hyper-converged deployments

If you're deploying a hyper-converged cluster, the last step is to provision virtual machines on the Storage Spaces Direct cluster.

The virtual machine's files should be stored on the systems CSV namespace (example: c:\\ClusterStorage\\Volume1) just like clustered VMs on failover clusters.

You can use in-box tools or other tools to manage the storage and virtual machines, such as System Center Virtual Machine Manager.

## Step 4: Deploy Scale-Out File Server for disaggregated solutions

If you're deploying a disaggregated solution, the next step is to create a Scale-Out File Server instance and setup some file shares. If you're deploying a hyper-converged cluster - you're finished and don't need this section.

### Step 4.1: Create the Scale-Out File Server role

The next step in setting up the cluster services for your file server is creating the clustered file server role, which is when you create the Scale-Out File Server instance on which your continuously available file shares are hosted.

#### To create a Scale-Out File Server role by using Server Manager

1.  In Failover Cluster Manager, select the cluster, go to **Roles**, and then click **Configure Role…**.<br>The High Availability Wizard appears.
2.  On the **Select Role** page, click **File Server**.
3.  On the **File Server Type** page, click **Scale-Out File Server for application data**.
4.  On the **Client Access Point** page, type a name for the Scale-Out File Server.
5.  Verify that the role was successfully set up by going to **Roles** and confirming that the **Status** column shows **Running** next to the clustered file server role you created, as shown in Figure 2.

    ![Failover Cluster Manager showing the Scale&#45;Out File Server](../Image/Failover%20Cluster%20Manager%20showing%20the%20Scale-Out%20File%20Server.png "Failover Cluster Manager showing the Scale-Out File Server")

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
2. Open a Windows PowerShell session with Domain Administrator credentials on one of the file server nodes, and then use the following script to create the appropriate Active Directory group, changing the values for the variables as appropriate for your environment:

    ```PowerShell  
    $HyperVClusterName = "Compute01" <#15 character limit#>  
    $HyperVObjectADGroupSamName = "Hyper-VServerComputerAccounts" <#No spaces#>  
    $ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"  

    CD $ScriptFolder  
    .\ADGroupSetup.ps1 -HyperVObjectADGroupSamName $HyperVObjectADGroupSamName -HyperVClusterName $HyperVClusterName     
    ```
3. Use the following script to create shares for each CSV and set appropriate permissions for the shares.

    ```PowerShell  
    #Replace the values of these variables  
    $HyperVClusterName = "Compute01" <#15 character limit#>  
    $HyperVObjectADGroupSamName = "Hyper-VServerComputerAccounts" <#No spaces#>  
    $SOFSName = "SOFS"  
    $SharePrefix = "Share"  
    $ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"  
  
    #Start of the script itself  
    CD $ScriptFolder  
    Get-ClusterSharedVolume | ForEach-Object {  
    $ShareName = $SharePrefix + $_.SharedVolumeInfo.friendlyvolumename.trimstart("C:\ClusterStorage\Volume")   
  
    Write-host "Creating share $ShareName on "$_.name "on Volume: " $_.SharedVolumeInfo.friendlyvolumename  
    .\FileShareSetup.ps1 -CSVVolumeNumber $_.SharedVolumeInfo.friendlyvolumename.trimstart("C:\ClusterStorage\Volume")`  
     -HyperVClusterName $HyperVClusterName  -ScaleOutFSName $SOFSName -ShareName $ShareName -HyperVObjectADGroupSamName $HyperVObjectADGroupSamName  
    }  
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
