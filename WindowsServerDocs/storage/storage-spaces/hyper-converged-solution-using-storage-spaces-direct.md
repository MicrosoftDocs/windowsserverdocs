---
title: Hyper-converged solution using Storage Spaces Direct in Windows Server 2016
ms.prod: windows-server-threshold
manager: eldenc
ms.author: stevenek
ms.technology: storage-spaces
ms.topic: get-started-article
ms.assetid: 20fee213-8ba5-4cd3-87a6-e77359e82bc0
author: stevenek
ms.date: 10/11/2016
---
# Hyper-converged solution using Storage Spaces Direct in Windows Server 2016
>Applies to: Windows Server 2016

This topic provides instructions for how to deploy [Storage Spaces Direct](storage-spaces-direct-overview.md) to provide software-defined storage for virtual machines hosted in the same hyper-converged cluster.

Note that for production environments we recommend acquiring a *Windows Server Software-Defined* hardware/software offering, which includes production deployment tools and procedures. These offerings are designed, assembled, and validated to meet Microsoft's requirements for private cloud environments, helping ensure reliable operation. Windows Server Software-Defined offerings will be available later this year - check back for updates! 

If you would like to evaluate Storage Spaces Direct in Windows Server 2016 without investing in hardware, you can use Hyper-V virtual machines, as described in [Testing Storage Spaces Direct using Windows Server 2016 virtual machines](http://blogs.msdn.com/b/clustering/archive/2015/05/27/10617612.aspx).

   > [!TIP]
   > Before deploying Storage Spaces Direct, we recommended briefly reading this document to familiarize yourself with the overall approach, to get a sense for the important notes associated with some steps, and to acquaint yourself with the additional supporting resources and documentation.

This guide includes instructions to install and configure the components of a hyper-converged system using Windows Server 2016 with either the Server with Desktop Experience or Server Core installation options. The act of deploying a hyper-converged system can be divided into three high level phases:

* [Step 1: Deploy Windows Server](#step-1-deploy-windows-server)
* [Step 2: Configure the network](#step-2-configure-the-network)
* [Step 3: Configure Storage Spaces Direct](#step-3-configure-storage-spaces-direct)

You can work on these steps a few at a time or all at once. However, they do need to be completed in order. After describing some prerequisites and terminology, this guide describes each of the three phases in more detail and provides examples.  

## Solution overview

In the hyper-converged configuration described in this guide, Storage Spaces Direct seamlessly integrates with the features you know today that make up the Windows Server software defined storage stack, including Clustered Shared Volume File System (CSVFS), Storage Spaces and Failover Clustering.  

The hyper-converged deployment scenario has the Hyper-V (compute) and Storage Spaces Direct (storage) components on the same cluster. Virtual machine files are stored on local CSVs. This allows for scaling Hyper-V compute clusters together with the storage it is using. Once Storage Spaces Direct is configured and the CSV volumes are available, configuring and provisioning Hyper-V is the same process and uses the same tools that you would use with any other Hyper-V deployment on a failover cluster. Figure 1 illustrates the hyper-converged deployment scenario.  

![Diagram showing the hyper-converged stack with a single cluster hosting the storage and virtual machines](media/Hyper-converged-solution-using-Storage-Spaces-Direct-in-Windows-Server-2016/StorageSpacesDirectHyperconverged.png)  

**FIGURE 1: Hyperconverged - same cluster configured for Storage Spaces Direct and the hosting of virtual machines**

## Information gathering

The following information will be needed as inputs to configure provision and manage the hyper-converged system, and therefore it will speed up the process and make it easier for you if you have it on hand when you start:  

-   **Server Names** You should be familiar with your organization's naming policies for computers, files, paths, and other resources as you will be provisioning several servers each will need to have a unique server name.  

-   **Domain name** You will be joining computers to your domain, and you will need to specify the domain name. It would be good to familiarize with your internal domain naming and domain joining policies.  

-   **For RDMA configurations:**  

    -   Top of Rack switch make/model (required when using RoCE v2 NICs)

    -   Network adapter make/model

        There are 2 types of RDMA protocols, note which type your RDMA adapter is (RoCE v2 or iWarp).

    -   VLAN ID to be used for the 2 network interfaces used by the management OS on the hyper-converged hosts. You should be able to obtain this from your network administrator.  
-   **[Service Package KB3157663](https://support.microsoft.com/kb/3157663)**  This package has updates that are important to have the hyper-converged nodes, as well as any server managing a Windows Server 2016 hyper-converged deployment.

## Installation options

Hyper-converged deployments can be done using a Nano Server, Server Core, or Server with Desktop Experience installation of Windows Server 2016. Nano Server is a new installation option for Windows Server 2016, see [Getting Started with Nano Server](../../get-started/Getting-Started-with-Nano-Server.md) for more information on the advantages of using Nano Server and deploying and managing Nano server.

This guide focuses on deploying hyper-converged systems using the Server Core installation option.

However, the steps in the "Configure the Network" and "Configure Storage Spaces Direct" sections are identical whether you are using Server with Desktop Experience, Server Core, or Nano Server installations.

## Management system
For the purposes of this document, the machine that has the management tools to locally or remotely manage the cluster is referred to as the management system. The management system machine has the following requirements:  

- Running Windows Server 2016 with the same updates as the servers it's managing, and also joined to the same domain or a fully trusted domain.

- Remote Server Administration Tools (RSAT) and PowerShell modules for Hyper-V and Failover Clustering. RSAT tools and PowerShell modules are available on Windows Server 2016 and can be installed without installing other features.  

- Management system can be run inside of a virtual machine or on a physical machine.  

- Requires network connectivity to the servers it's managing.

## Step 1: Deploy Windows Server

When you install Windows Server 2016 using the Setup wizard, you may be able to choose between Windows Server 2016 and Windows Server 2016 (Server with Desktop Experience). The Server with Desktop Experience option is the Windows Server 2016 equivalent of the Full installation option available in Windows Server 2012 R2 with the Desktop Experience feature installed. If you don't make a choice in the Setup wizard, Windows Server 2016 is installed with the Server Core installation option. The Server Core option reduces the space required on disk, the potential attack surface, and especially the servicing requirements, so we recommend that you choose the Server Core installation unless you have a particular need for the additional user interface elements and graphical management tools that are included in the Server with Desktop Experience option.

For more information about these two installation options, see [Installation Options for Windows Server 2016](../../get-started/Windows-Server-2016.md).
For detailed information about deploying Windows Server 2016 in Server Core mode, see [Install Server Core](../../get-started/Getting-Started-with-Server-Core.md).

### Step 1.1: Connecting to the cluster nodes

You will need a management system that has Windows Server 2016 with the same updates to manage and configuration as the cluster nodes. If it's a Server with Desktop Experience deployment, you can manage it from a remote machine or by logging into one of the cluster nodes. You may also use a Windows 10 client machine that has the latest updates installed, and the client Remote Server Administration Tools (RSAT) for Windows Server 2016 tools installed.

1. On the Management system install the Failover Cluster and Hyper-V management tools. This can be done through Server Manager using the **Add Roles and Features** wizard. On the **Features** page, select **Remote Server Administration Tools**, and then select the tools to install.

    Open a PowerShell session with Administrator privileges and execute the following. This will configure the trusted hosts to all hosts.

    ```PowerShell
    Set-Item WSMan:\localhost\Client\TrustedHosts "*"
    ```

    After the onetime configuration above, you will not need to repeat Set-Item. However, each time you close and reopen the PowerShell console you should establish a new remote PS Session to the server by running the commands below:

2. Enter the PS session and use either the server name or the IP address of the node you want to connect to. You will be prompted for a password after you execute this command, enter the administrator password you specified when setting up Windows.

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

Managing a hyper-converged system, including the cluster and storage and virtualization components, often requires using a domain account that is in the Administrators group on each node.

From the management system, perform the following steps:

1. On the management system, open a PowerShell console with Administrator privileges.
2. Use Enter-PSSession to connect to each node and then run the following command to add your domain account(s) to the Administrators local security group. See the section above for information about how to connect to the servers using PSSession.

    ```
    Net localgroup Administrators <Domain\Account> /add
    ```


## Step 2: Configure the network

Storage Spaces Direct requires high bandwidth and low latency network connections between nodes. This network connectivity is important for both system performance and reliability. It is recommended to have at least 2 10gb connections between the nodes. RDMA is also recommended since it provides significantly better throughput and reduces the CPU usage for network traffic.

There are two common versions of RDMA network adapters. RoCE and iWARP. You can use either with Storage Spaces Direct as long as it has the Windows Server 2016 logo. Top of Rack switches and server configurations may vary, depending on the network adapter and switch. Configuring the server and switch correctly is important to ensure reliability and performance of Storage Spaces Direct.

Windows Server 2016 also introduces a new virtual switch that has network teaming built in called Switch Embedded Teaming (SET). This new virtual switch allows the same 2 physical NIC ports to be used both for VMs as well as the parent partition of the server to have RDMA connectivity. The result is reducing the number of physical NIC ports that would otherwise be required and allows managing the networking through the Software Defined Network features of Windows Server 2016. The steps in this guide are for implementing the new virtual switch with RDMA enabled to the parent partition and SET configured.

The following assumes 2 RDMA physical NIC Ports (1 dual port, or 2 single port) and the Hyper-V switch deployed with RDMA-enabled host virtual NICs. Complete the following steps to configure the network *on each server*.

Skip this **Network Configuration** section, if you are testing Storage Spaces Direct inside of virtual machines. RDMA is not available for networking inside a virtual machine.

### Step 2.1: Configure the Top of Rack (TOR) Switch

Our example configuration is using a network adapter that implements RDMA using RoCEv2. Network QoS and reliable flow of data for this type of RDMA requires that the TOR have specific capabilities set for the network ports that the NICs are connected to. If you are deploying with iWarp, the TOR may not need any configuration.

### Step 2.2: Enable Network Quality of Service (QoS)

Network QoS is used to in this hyper-converged configuration to ensure that the Software Defined Storage system has enough bandwidth to communicate between the nodes to ensure resiliency and performance. Do the following steps from a management system using [*Enter-PSSession*](https://technet.microsoft.com/library/hh849707(v=wps.630).aspx) to connect and do the following to each of the servers.

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

2.  If you are using RoCEv2 turn on Flow Control for SMB as follows (not required for iWarp):

    ```PowerShell
    Install-WindowsFeature "data-center-bridging"
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

5. Apply network QoS policy to the target adapters. The target adapters are the RDMA adapters. Use the "Name" of the target adapters for the –InterfaceAlias in the following example

    ```PowerShell
    Enable-NetAdapterQos –InterfaceAlias "<adapter1>", "<adapter2>"
    ```

   Using the example above, the command would look like this:

    ```PowerShell
    Enable-NetAdapterQoS –InterfaceAlias "Ethernet 2", "SLOT #"
    ```

6.  Create a Traffic class and give SMB Direct 30% of the bandwidth minimum. The name of the class will be "SMB".

    ```PowerShell
    New-NetQosTrafficClass "SMB" –Priority 3 –BandwidthPercentage 30 –Algorithm ETS
    ```

### Step 2.3: Create a Hyper-V virtual switch

The Hyper-V virtual switch allows the physical NIC ports to be used for both the host and virtual machines and enables RDMA from the host which allows for more throughput, lower latency, and less system (CPU) impact. The physical network interfaces are teamed using the Switch Embedded Teaming (SET) feature that is new in Windows Server 2016.

Do the following steps from a management system using [*Enter-PSSession*](https://technet.microsoft.com/library/hh849707(v=wps.650).aspx) to connect to each of the servers.

1.  Identify the network adapters (you will use this info in step \#2)

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

1.  Configure the host vNIC to use a Vlan. They can be on the same or different Vlans.

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

## Step 3: Configure Storage Spaces Direct

The following steps are done on a management system that is the same version as the servers being configured. The following steps should NOT be run remotely using a PSSession, but instead run in a local PowerShell session on the management system, with adminsitrative permissions.

### Step 3.1: Run cluster validation

In this step, you will run the cluster validation tool to ensure that the server nodes are configured correctly to create a cluster using Storage Spaces Direct. When cluster validation (Test-Cluster) is run before the cluster is created, it runs the tests that verify that the configuration appears suitable to successfully function as a failover cluster. The example directly below uses the "-Include" parameter, and then the specific categories of tests are specified. This ensures that the Storage Spaces Direct specific tests are included in the validation.

Use the following PowerShell command to validate a set of servers for use as a Storage Spaces Direct cluster.

```PowerShell
Test-Cluster –Node <MachineName1, MachineName2, MachineName3, MachineName4> –Include "Storage Spaces Direct", "Inventory", "Network", "System Configuration"
```

### Step 3.2: Create a cluster

In this step, you will create a cluster with the nodes that you have validated for cluster creation in the preceding step using the following PowerShell cmdlet. The **–NoStorage parameter is important** to be added to the cmdlet, otherwise disks may be automatically added to the cluster and you will need to remove them before enabling Storage Spaces Direct otherwise they will not be included in the Storage Spaces Direct storage pool.

When creating the cluster, you will get a warning that states - "There were issues while creating the clustered role that may prevent it from starting. For more information, view the report file below." You can safely ignore this warning. It's due to no disks being available for the cluster quorum. Its recommended that a file share witness or cloud witness is configured after creating the cluster.

> [!Note]
> If the servers are using static IP addresses, modify the following command to reflect the static IP address by adding the following parameter and specifying the IP address:–StaticAddress &lt;X.X.X.X&gt;.
> In the following command the ClusterName placeholder should be replaced with a netbios name that is unique and 15 characters or less.
> ```PowerShell
> New-Cluster –Name <ClusterName> –Node <MachineName1,MachineName2,MachineName3,MachineName4> –NoStorage
> ```

After the cluster is created, it can take time for DNS entry for the cluster name to be replicated. The time is dependent on the environment and DNS replication configuration. If resolving the cluster isn't successful, in most cases you can be successful with using the machine name of a node that is an active member of the cluster may be used instead of the cluster name.

### Step 3.3: Configure a cluster witness

It is recommended that you configure a witness for the cluster, so that a 3 or more node system can withstand two nodes failing or being offline. A 2 node deployment requires a cluster witness, otherwise either node going offline will cause the other to become unavailable as well. With these systems, you can use a file share as a witness, or use cloud witness. For more info, see [Deploy a Cloud Witness for a Failover Cluster](../../virtualization/failover-clustering/deploy-cloud-witness.md).

For more information about configuring a file share witness, see [*Configuring a File Share Witness on a Scale-Out File Server*](https://blogs.msdn.microsoft.com/clustering/2014/03/31/configuring-a-file-share-witness-on-a-scale-out-file-server/).

### Step 3.4: Clean disks

The disks intended to be used for Storage Spaces Direct need to be empty and without partitions or other data. If a disk has partitions or other data, it will not be included in the Storage Spaces Direct system. 

On the management system, open a PowerShell ISE window with Administrator privileges, and then create and run the following script, replacing the *&lt;ClusterName&gt;* variable with the appropriate cluster name. Running this script will help identify the disks on each node that are detected to be able to be used for Storage Spaces Direct, and removes all data and partitions from those disks.

You can skip this step if the disks have already been cleaned or verified to be without partitions.

> [!Important]
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
4     ATA SSDSC2BA800G4n            StorageClusterNode1
10    ATA ST4000NM0033              StorageClusterNode1
4     ATA SSDSC2BA800G4n            StorageClusterNode1
10    ATA ST4000NM0033              StorageClusterNode1
4     ATA SSDSC2BA800G4n            StorageClusterNode1
10    ATA ST4000NM0033              StorageClusterNode1
```

### Step 3.5: Enable Storage Spaces Direct

After creating the cluster, use the Enable-ClusterStorageSpacesDirect PowerShell cmdlet, which will put the storage system into the Storage Spaces Direct mode and do the following automatically:

-   **Create a pool:** Creates a single large pool that has a name like "S2D on Cluster1".

-   **Configures the Storage Spaces Direct caches:** If there is more than one media (drive) type available for Storage Spaces Direct use, it enables the fastest as cache devices (read and write in most cases)

-   **Tiers:** Creates 2 tiers as default tiers. One is called "Capacity" and the other called "Performance". The cmdlet analyzes the devices and configures each tier with the mix of device types and resiliency.

From the management system, in a PowerShell command windows opened with Administrator privileges, initiate the following command. The cluster name is the name of the cluster that you created in the previous steps. If this command is run locally on one of the nodes, the -CimSession parameter is not necessary.

```PowerShell
Enable-ClusterStorageSpacesDirect –CimSession <ClusterName>
```

To enable Storage Spaces Direct using the above command, you can also use the node name instead of the cluster name. Using the node name may be more reliable due to DNS replication delays that may occur with the newly created cluster name.

When this command is finished, which may take several minutes, the system will be ready for volumes to be created.

### Step 3.6: Create volumes

We recommend using the **New-Volume** cmdlet as it provides the fastest and most straightforward experience. This single cmdlet automatically creates the virtual disk, partitions and formats it, creates the volume with matching name, and adds it to cluster shared volumes – all in one easy step.

For more information, check out [Creating volumes in Storage Spaces Direct](create-volumes.md).

### Step 3.7: Deploy virtual machines

At this point you can provision virtual machines on to the nodes of the hyper-converged Storage Spaces Direct cluster.

The virtual machine's files should be stored on the systems CSV namespace (example: c:\\ClusterStorage\\Volume1) just like clustered VMs on failover clusters.

You may use in-box tools or other tools to manage the storage and virtual machines, including System Center Virtual Machine Manager.

## See also

-   [Storage Spaces Direct in Windows Server 2016](storage-spaces-direct-overview.md)  
-   [Understand the cache in Storage Spaces Direct](understand-the-cache.md)
-   [Planning volumes in Storage Spaces Direct](plan-volumes.md)
-   [Storage Spaces Fault Tolerance](storage-spaces-fault-tolerance.md)
-   [Storage Spaces Direct Hardware Requirements](Storage-Spaces-Direct-Hardware-Requirements.md)  
