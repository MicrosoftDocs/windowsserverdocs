---
title: Deploy Storage Spaces Direct on Windows Server
description: Step-by-step instructions to deploy software-defined storage with Storage Spaces Direct in Windows Server as either hyperconverged infrastructure or converged (also known as disaggregated) infrastructure.
ms.author: daknappe
author: dknappettmsft
ms.topic: how-to
ms.date: 11/24/2025
---

# Deploy Storage Spaces Direct on Windows Server

This article provides step-by-step instructions to deploy [Storage Spaces Direct](storage-spaces-direct-overview.md) on Windows Server. To deploy Storage Spaces Direct as part of Azure Local, see [About Azure Local](/azure/azure-local/deploy/deployment-introduction?context=/windows-server/context/windows-server-storage).

> [!Tip]
> Looking to acquire hyperconverged infrastructure? Microsoft recommends purchasing a validated hardware/software Azure Local solution from our partners. These solutions are designed, assembled, and validated against our reference architecture to ensure compatibility and reliability, so you get up and running quickly. To peruse a catalog of hardware/software solutions that work with Azure Local, see the [Azure Local Catalog](https://aka.ms/azurelocalcatalog).

> [!Tip]
> You can use Hyper-V virtual machines, including in Microsoft Azure, to [evaluate Storage Spaces Direct without hardware](storage-spaces-direct-in-vm.md). You might also want to review the handy [Windows Server rapid lab deployment scripts](https://aka.ms/wslab), which we use for training purposes.

## Before you start

Review the [Storage Spaces Direct hardware requirements](Storage-Spaces-Direct-Hardware-Requirements.md) to familiarize yourself with the overall approach and important notes associated with some steps.

Gather the following information:

- **Deployment option**: Storage Spaces Direct supports [two deployment options: hyper-converged and converged](/azure/azure-local/concepts/storage-spaces-direct-overview#deployment-options), also known as disaggregated. Familiarize yourself with the advantages of each to decide which option is right for you. Steps 1-3 in this article apply to both deployment options. Step 4 is only needed for converged deployment.

- **Server names**: Get familiar with your organization's naming policies for computers, files, paths, and other resources. You need to provision several servers, each with unique names.

- **Domain name**: Get familiar with your organization's policies for domain naming and domain joining. You join the servers to your domain, and you need to specify the domain name.

- **RDMA networking**: There are two types of RDMA protocols: iWarp and RoCE. Note which one your network adapters use, and if RoCE, also note the version (v1 or v2). For RoCE, also note the model of your top-of-rack switch.

- **VLAN ID**: Note the VLAN ID to use for management OS network adapters on the servers, if any. You should be able to obtain this information from your network administrator.

## Step 1: Deploy Windows Server

### Step 1.1: Install the operating system

First, install Windows Server on every server in the cluster. Storage Spaces Direct requires Windows Server Datacenter Edition. You can use the Server Core installation option or Server with Desktop Experience.

When you install Windows Server by using the Setup wizard, you can choose between *Windows Server* (referring to Server Core) and *Windows Server (Server with Desktop Experience)*, which is the equivalent of the *Full* installation option available in Windows Server 2012 R2. If you don't choose, you get the Server Core installation option. For more information, see [Install Server Core](../../get-started/getting-started-with-server-core.md).

### Step 1.2: Connect to the servers

This guide focuses on the Server Core installation option and deploying and managing remotely from a separate management system. The management system must have:

- A version of Windows Server or Windows 10 that's at least as new as the servers it's managing, with the latest updates.
- Network connectivity to the servers it's managing.
- Joined to the same domain or a fully trusted domain.
- Remote Server Administration Tools (RSAT) and PowerShell modules for Hyper-V and Failover Clustering. RSAT tools and PowerShell modules are available on Windows Server and can be installed without installing other features. You can also install the [Remote Server Administration Tools](https://www.microsoft.com/download/details.aspx?id=45520) on a Windows 10 management PC.

On the management system, install the Failover Cluster and Hyper-V management tools. You can do this through Server Manager by using the **Add Roles and Features** wizard. On the **Features** page, select **Remote Server Administration Tools**, then select the tools to install.

Enter the PowerShell session and use either the server name or the IP address of the node you want to connect to. You're prompted for a password after you execute this command. Enter the administrator password you specified when setting up Windows.

   ```powershell
   Enter-PSSession -ComputerName <myComputerName> -Credential LocalHost\Administrator
   ```

   Here's an example of doing the same thing in a way that's more useful in scripts:

   ```powershell
   $myServer1 = "myServer-1"
   $user = "$myServer1\Administrator"

   Enter-PSSession -ComputerName $myServer1 -Credential $user
   ```

> [!TIP]
> If you're deploying remotely from a management system, you might get an error like *WinRM cannot process the request.* To fix this error, use Windows PowerShell to add each server to the Trusted Hosts list on your management computer:
>
> `Set-Item WSMAN:\Localhost\Client\TrustedHosts -Value Server01 -Force`
>
> The trusted hosts list supports wildcards, like `Server*`.
>
> - To view your Trusted Hosts list, type `Get-Item WSMAN:\Localhost\Client\TrustedHosts`.
> - To empty the list, type `Clear-Item WSMAN:\Localhost\Client\TrustedHost`.

### Step 1.3: Join the domain and add domain accounts

To manage Storage Spaces Direct, you need to join the servers to a domain and use an Active Directory Domain Services domain account that's in the Administrators group on every server.

From the management system, open a PowerShell console with Administrator privileges. Use `Enter-PSSession` to connect to each server and  run the following cmdlet, substituting your own computer name, domain name, and domain credentials:

```powershell
Add-Computer -NewName "Server01" -DomainName "contoso.com" -Credential "CONTOSO\User" -Restart -Force
```

If your storage administrator account isn't a member of the Domain Admins group, add your storage administrator account to the local Administrators group on each node, or add the group you use for storage administrators. You can use the following command, or create a PowerShell script to perform this step. For more information, see [Use PowerShell to Add Domain Users to a Local Group](https://devblogs.microsoft.com/scripting/use-powershell-to-add-domain-users-to-a-local-group/).

```
Net localgroup Administrators <Domain\Account> /add
```

### Step 1.4: Install roles and features

The next step is to install server roles on every server through [Windows Admin Center](../../manage/windows-admin-center/use/manage-servers.md), [Server Manager](../../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md), or PowerShell. Here are the roles to install:

•	Failover Clustering (required to enable S2D)
•	Hyper-V (required if using virtual switch network)
•	File Server (required if you want to host any file shares, such as for a converged deployment)
•	Data-Center-Bridging (required if you're using RoCEv2 instead of iWARP network adapters)
•	RSAT-Clustering-PowerShell (required for managing the environment with powershell remotely)
•	Hyper-V-PowerShell (required for Hyper-V powershell commands)


To install roles via PowerShell, use the [Install-WindowsFeature](/powershell/module/servermanager/install-windowsfeature) cmdlet. You can use it on a single server like this:

```powershell
Install-WindowsFeature -Name "Hyper-V", "Failover-Clustering", "Data-Center-Bridging", "RSAT-Clustering-PowerShell", "Hyper-V-PowerShell", "FS-FileServer"
```

To run the command on all servers in the cluster at the same time, run this script which modifies the list of variables at the beginning of the script to fit your environment.

```powershell
# Fill in these variables with your values
$ServerList = "Server01", "Server02", "Server03", "Server04"
$FeatureList = "Hyper-V", "Failover-Clustering", "Data-Center-Bridging", "RSAT-Clustering-PowerShell", "Hyper-V-PowerShell", "FS-FileServer"

# This part runs the Install-WindowsFeature cmdlet on all servers in $ServerList, passing the list of features into the script block with the "Using" scope modifier so you don't have to hard-code them here.
Invoke-Command ($ServerList) {
    Install-WindowsFeature -Name $Using:Featurelist
}
```

## Step 2: Configure the network

If you're deploying Storage Spaces Direct inside virtual machines, skip this section.

Storage Spaces Direct requires high-bandwidth, low-latency networking between servers in the cluster. You need at least 10-GbE networking, and remote direct memory access (RDMA) is recommended. You can use either iWARP or RoCE as long as it has the Windows Server logo that matches your operating system version, but iWARP is easier to set up.

> [!Important]
> Depending on your networking equipment, and especially with RoCE v2, you might need to configure the top-of-rack switch. Correct switch configuration is important to ensure reliability and performance of Storage Spaces Direct.

Windows Server 2016 introduced switch-embedded teaming (SET) within the Hyper-V virtual switch. This feature allows you to use the same physical network interface card (NIC) ports for all network traffic while using RDMA, reducing the number of physical NIC ports required. Use switch-embedded teaming for Storage Spaces Direct.

- **Switched**: You must properly configure network switches to handle the bandwidth and networking type. If you use RDMA that implements the RoCE protocol, network device and switch configuration is even more important.
- **Switchless**: You can interconnect nodes by using direct connections, avoiding the use of a switch. Every node must have a direct connection with every other node of the cluster.

For instructions to set up networking for Storage Spaces Direct, see the [Windows Server 2016 and 2019 RDMA Deployment Guide](https://github.com/Microsoft/SDN/blob/master/Diagnostics/S2D%20WS2016_ConvergedNIC_Configuration.docx).

## Step 3: Configure Storage Spaces Direct

Perform the following steps on a management system that runs the same version as the servers you're configuring. Don't run these steps remotely by using a PowerShell session. Instead, run them in a local PowerShell session on the management system, with administrative permissions.

### Step 3.1: Clean drives

Before you enable Storage Spaces Direct, make sure your drives are empty with no old partitions or other data. Run the following script, substituting your computer names to remove any old partitions or other data.

> [!Important]
> This script permanently removes any data on drives other than the operating system boot drive!

```powershell
# Fill in these variables with your values
$ServerList = "Server01", "Server02", "Server03", "Server04"

foreach ($server in $serverlist) {
    Invoke-Command ($server) {
        # Check for the Azure Temporary Storage volume
        $azTempVolume = Get-Volume -FriendlyName "Temporary Storage" -ErrorAction SilentlyContinue
        If ($azTempVolume) {
            $azTempDrive = (Get-Partition -DriveLetter $azTempVolume.DriveLetter).DiskNumber
        }

        # Clear and reset the disks
        $disks = Get-Disk | Where-Object {
            ($_.Number -ne $null -and $_.Number -ne $azTempDrive -and !$_.IsBoot -and !$_.IsSystem -and $_.PartitionStyle -ne "RAW")
        }
        $disks | ft Number,FriendlyName,OperationalStatus
        If ($disks) {
            Write-Host "This action will permanently remove any data on any drives other than the operating system boot drive!`nReset disks? (Y/N)"
            $response = read-host
            if ( $response.ToLower() -ne "y" ) { exit }

            $disks | % {
            $_ | Set-Disk -isoffline:$false
            $_ | Set-Disk -isreadonly:$false
            $_ | Clear-Disk -RemoveData -RemoveOEM -Confirm:$false -verbose
            $_ | Set-Disk -isreadonly:$true
            $_ | Set-Disk -isoffline:$true
        }

        #Get-PhysicalDisk | Reset-PhysicalDisk


        }
        Get-Disk | Where-Object {
            ($_.Number -ne $null -and $_.Number -ne $azTempDrive -and !$_.IsBoot -and !$_.IsSystem -and $_.PartitionStyle -eq "RAW")
        } | Group -NoElement -Property FriendlyName
    }
}
```

The output looks like the following example, where **Count** is the number of drives of each model in each server:

```
Count Name                          PSComputerName
----- ----                          --------------
4     ATA SSDSC2BA800G4n            Server01
10    ATA ST4000NM0033              Server01
4     ATA SSDSC2BA800G4n            Server02
10    ATA ST4000NM0033              Server02
4     ATA SSDSC2BA800G4n            Server03
10    ATA ST4000NM0033              Server03
4     ATA SSDSC2BA800G4n            Server04
10    ATA ST4000NM0033              Server04
```

### Step 3.2: Validate the cluster

In this step, you run the cluster validation tool to ensure that the server nodes are configured correctly to create a cluster using Storage Spaces Direct. When you run cluster validation (`Test-Cluster`) before you create the cluster, it runs tests that verify that the configuration is suitable to function as a failover cluster. The following example directly uses the `-Include` parameter, and then specifies the specific categories of tests. This approach ensures that the Storage Spaces Direct specific tests are included in the validation.

Use the following PowerShell command to validate a set of servers for use as a Storage Spaces Direct cluster.

```powershell
Test-Cluster -Node <MachineName1, MachineName2, MachineName3, MachineName4> -Include "Storage Spaces Direct", "Inventory", "Network", "System Configuration"
```

### Step 3.3: Create the cluster

In this step, you create a cluster with the nodes that you validated for cluster creation in the preceding step by using the following PowerShell cmdlet.

When you create the cluster, you get a warning that states "_There were issues while creating the clustered role that may prevent it from starting. For more information, view the report file below._" You can safely ignore this warning. It's due to no disks being available for the cluster quorum. Configure a file share witness or cloud witness after creating the cluster.

> [!NOTE]
> If the servers use static IP addresses, modify the following command to reflect the static IP address by adding the following parameter and specifying the IP address: `-StaticAddress <X.X.X.X>`.
> In the following command, replace the `ClusterName` placeholder with a NetBIOS name that's unique and 15 characters or less.
>
> ```powershell
> New-Cluster -Name <ClusterName> -Node <MachineName1,MachineName2,MachineName3,MachineName4> -NoStorage
> ```

After you create the cluster, it can take time for Domain Name System (DNS) entry for the cluster name to replicate. The time depends on the environment and DNS replication configuration. If resolving the cluster isn't successful, you can use the machine name of a node that is an active member of the cluster instead of the cluster name.

### Step 3.4: Configure a cluster witness

Configure a witness for the cluster so clusters with three or more servers can withstand two servers failing or being offline. A two-server deployment requires a cluster witness; otherwise, if either server goes offline, the other server becomes unavailable. With these systems, you can use a file share as a witness, or use cloud witness. For more information, see [Deploy a quorum witness](../../failover-clustering/deploy-quorum-witness.md).

### Step 3.5: Enable Storage Spaces Direct

After creating the cluster, use the `Enable-ClusterStorageSpacesDirect` PowerShell cmdlet. This cmdlet puts the storage system into the Storage Spaces Direct mode and automatically does the following tasks:

- **Creates a pool**: Creates a single large pool with a name like "S2D on Cluster1".

- **Configures the Storage Spaces Direct caches**: If more than one media (drive) type is available for Storage Spaces Direct use, it enables the fastest as cache devices (read and write in most cases).

- **Creates two tiers as default tiers**: One tier is called "Capacity" and the other tier is called "Performance". The cmdlet analyzes the devices and configures each tier with the mix of device types and resiliency.

From the management system, open an elevated PowerShell window and run the following command. The cluster name is the name of the cluster that you created in the previous steps. If you run this command locally on one of the nodes, you don't need the `-CimSession` parameter.

```powershell
Enable-ClusterStorageSpacesDirect -CimSession <ClusterName>
```

This command enables Storage Spaces Direct. You can choose to use the node name instead of the cluster name. Using the node name might be more reliable because DNS replication delays might occur with the newly created cluster name.

When this command finishes, which might take several minutes, the system is ready for volumes to be created.

### Step 3.6: Create volumes

Use the `New-Volume` cmdlet for the fastest and most straightforward experience. This single cmdlet automatically creates the virtual disk, partitions, and formats it. It creates the volume with a matching name and adds it to cluster shared volumes – all in one easy step.

For more information, see [Creating volumes in Storage Spaces Direct](/azure/azure-local/manage/create-volumes?context=/windows-server/context/windows-server-storage).

### Step 3.7: Optionally enable the CSV cache

You can enable the cluster shared volume (CSV) cache by using system memory (RAM) as a write-through block-level cache for read operations that the Windows cache manager doesn't cache. This feature can improve performance for applications such as Hyper-V. The CSV cache boosts the performance of read requests and is also useful for Scale-Out File Server scenarios.

Enabling the CSV cache reduces the amount of memory available to run VMs on a hyper-converged cluster, so you need to balance storage performance with memory available to VHDs.

To set the size of the CSV cache, open a PowerShell session on the management system with an account that has administrator permissions on the storage cluster. Use the following script, changing the `$ClusterName` and `$CSVCacheSize` variables as appropriate (this example sets a 2 GB CSV cache per server):

```powershell
$ClusterName = "StorageSpacesDirect1"
$CSVCacheSize = 2048 #Size in MB

Write-Output "Setting the CSV cache..."
(Get-Cluster $ClusterName).BlockCacheSize = $CSVCacheSize

$CSVCurrentCacheSize = (Get-Cluster $ClusterName).BlockCacheSize
Write-Output "$ClusterName CSV cache size: $CSVCurrentCacheSize MB"
```

For more info, see [Using the CSV in-memory read cache](/azure/azure-local/manage/use-csv-cache?context=/windows-server/context/windows-server-storage).

### Step 3.8: Deploy virtual machines for hyper-converged deployments

If you're deploying a hyper-converged cluster, the last step is to provision virtual machines on the Storage Spaces Direct cluster.

Store the virtual machine's files on the system's CSV namespace (example: c:\\ClusterStorage\\Volume1) just like clustered VMs on failover clusters.

You can use in-box tools or other tools to manage the storage and virtual machines, such as System Center Virtual Machine Manager.

## Step 4: Deploy Scale-Out File Server for converged solutions

If you're deploying a converged solution, the next step is to create a Scale-Out File Server instance and set up the file shares.

> [!TIP]
> If you're deploying a hyper-converged cluster, you're finished and don't need this section.

Select one of the following tabs for instructions on how to create a Scale-Out File Server role using either Failover Cluster Manager or PowerShell.

### [Failover Cluster Manager](#tab/failover-cluster-manager)

To create a Scale-Out File Server role by using Failover Cluster Manager:

1. In Failover Cluster Manager, select the cluster, go to **Roles**, and then select **Configure Role…**.<br>The High Availability Wizard appears.
1. On the **Select Role** page, select **File Server**.
1. On the **File Server Type** page, select **Scale-Out File Server for application data**.
1. On the **Client Access Point** page, type a name for the Scale-Out File Server.
1. Verify that the role was successfully set up by going to **Roles** and confirming that the **Status** column shows **Running** next to the clustered file server role you created, as shown in Figure 1.

   ![Screenshot of Failover Cluster Manager showing the Scale-Out File Server](media/Hyper-converged-solution-using-Storage-Spaces-Direct-in-Windows-Server-2016/SOFS_in_FCM.png "Failover Cluster Manager showing the Scale-Out File Server")

    **Figure 1** Failover Cluster Manager showing the Scale-Out File Server with the Running status

> [!NOTE]
> After creating the clustered role, network propagation delays might prevent you from creating file shares on it for a few minutes, or potentially longer.

### [PowerShell](#tab/powershell)

To create a Scale-Out File Server role by using PowerShell, open a PowerShell session that's connected to the file server cluster, enter the following commands to create the Scale-Out File Server role, changing *FSCLUSTER* to match the name of your cluster, and *SOFS* to match the name you want to give the Scale-Out File Server role:

```powershell
Add-ClusterScaleOutFileServerRole -Name SOFS -Cluster FSCLUSTER
```

> [!NOTE]
> After creating the clustered role, network propagation delays might prevent you from creating file shares on it for a few minutes, or potentially longer. If the SOFS role fails immediately and doesn't start, it might be because the cluster's computer object doesn't have permission to create a computer account for the SOFS role. For help with that issue, see this blog post: [Scale-Out File Server Role Fails To Start With Event IDs 1205, 1069, and 1194](http://www.aidanfinn.com/?p=14142).

---

### Create file shares

After you create your virtual disks and add them to CSVs, create file shares on them. Create one file share per CSV per virtual disk. System Center Virtual Machine Manager (VMM) is the easiest way to do this task because it handles permissions for you. If you don't have it in your environment, you can use Windows PowerShell to partially automate the deployment.

Use the scripts included in this section to partially automate the process of creating groups and shares. The scripts are written for Hyper-V workloads. If you're deploying other workloads, you might have to modify the settings or perform additional steps after you create the shares. For example, if you're using Microsoft SQL Server, you must grant full control on the share and the file system to the SQL Server service account.

> [!NOTE]
> You need to update the group membership when you add cluster nodes unless you use System Center Virtual Machine Manager to create your shares.

To create file shares by using PowerShell scripts, perform the following steps:

1. Expand each of the following sections and save the contents of each as a separate `.ps1` file with the relevant name in the same folder, such as `C:\Scripts\SetupSMBSharesWithHyperV`, on one of the nodes of the file server cluster:

   <details>
       <summary>Expand this section for <b>ADGroupSetup.ps1</b>.</summary>

   ```powershell
   Param(
       [Parameter(Mandatory=$true)]
       [string]
       $HyperVClusterName,
       [Parameter(Mandatory=$true)]
       [string]
       $HyperVObjectADGroupSamName
   )
   
   # Add and import needed features
   if ((Get-WindowsFeature | ? Name -Like "RSAT-AD-PowerShell") | ? InstallState -NotLike Installed)
   {
       Install-WindowsFeature "RSAT-AD-PowerShell"
   }
   if ((Get-WindowsFeature | ? Name -Like "RSAT-Clustering-PowerShell") | ? InstallState -NotLike Installed)
   {
       Install-WindowsFeature "RSAT-Clustering-PowerShell"
   }
   Import-Module -Name ActiveDirectory
   Import-Module -Name FailoverClusters
   
   # Check for group and create if necessary
   $adGroup = @()
   $adGroup = Get-ADGroup -Filter {samAccountName -eq $HyperVObjectADGroupSamName}
   if ($adGroup.Count -ne 1)
   {
       $adGroup = New-ADGroup -DisplayName $HyperVObjectADGroupSamName -Name $HyperVObjectADGroupSamName -SamAccountName $HyperVObjectADGroupSamName -GroupScope Global -GroupCategory Security -PassThru
   }
   
   # Build array of Hyper-V servers
   $HyperVNodes = (Get-ClusterNode -Cluster $HyperVClusterName).Name | Get-ADComputer
   
   # Add nodes to group if not already members
   for ($i = 0; $i -lt $HyperVNodes.Count; $i++)
   {
       if (!(Get-ADGroupMember $adGroup | ? Name -ieq $HyperVNodes[$i].Name))
       {
           Add-ADGroupMember $adGroup -Members $HyperVNodes[$i]
       }
   }
   
   # Add Hyper-V cluster object to group if not already present
   if (!(Get-ADGroupMember $adGroup | ? Name -ieq $HyperVClusterName))
   {
       Add-ADGroupMember $adGroup -Members (Get-ADComputer $HyperVClusterName)
   }
   ```

   </details>

   <details>
       <summary>Expand this section for <b>FileShareSetup.ps1</b>.</summary>

   ```powershell
   Param(
       [Parameter(Mandatory=$true)]
       [string]
       $HyperVClusterName,
       [Parameter(Mandatory=$true)]
       [string]
       $ScaleOutFSName,
       [Parameter(Mandatory=$true)]
       [string]
       $ShareName,
       [Parameter(Mandatory=$true)]
       [string]
       $HyperVObjectADGroupSamName,
       [int]
       $CSVVolumeNumber = 1,
       [string]
       $VHDFolderName = "VHDs",
       [string]
       $VMFolderName = "VMs"
   )
   
   # Create the share folder
   New-Item -ItemType Directory -Path C:\ClusterStorage\Volume$CSVVolumeNumber\$ShareName
   
   # Create folders in share
   New-Item -ItemType Directory -Path "C:\ClusterStorage\Volume$CSVVolumeNumber\$ShareName\$VHDFolderName"
   New-Item -ItemType Directory -Path "C:\ClusterStorage\Volume$CSVVolumeNumber\$ShareName\$VMFolderName"
   
   # Get the domain name
   $DomainName = Get-Content env:userdnsdomain
   
   # Grant the Hyper-V group permission
   $cmdString = "ICACLS.EXE C:\ClusterStorage\Volume$CSVVolumeNumber\$ShareName  --% /Grant $DomainName\$HyperVObjectADGroupSamName"
   $cmdString += ':(CI)(OI)F'
   Invoke-Expression -Command $cmdString
   
   # Grant domain admins permission
   $DomainAdmins = "Domain Admins"
   $cmdString = "ICACLS.EXE C:\ClusterStorage\Volume$CSVVolumeNumber\$ShareName"
   $cmdString += '  --% /Grant "'
   $cmdString += "$DomainName\$DomainAdmins"
   $cmdString += ':(CI)(OI)F"'
   Invoke-Expression -Command $cmdString
   
   # Remove inheritance (optional)
   ICACLS.EXE C:\ClusterStorage\Volume$CSVVolumeNumber\$ShareName  /Inheritance:R
   
   # Create new share and set matching Share permissions
   $FullAccess = ("$DomainName\$HyperVObjectADGroupSamName","$DomainName\Domain Admins")
   New-SmbShare -Name $ShareName -Path C:\ClusterStorage\Volume$CSVVolumeNumber\$ShareName  -FullAccess $FullAccess
   ```

   </details>

   <details>
       <summary>Expand this section for <b>KCDSetup.ps1</b>.</summary>

   ```powershell
   Param(
       [Parameter(Mandatory=$true)]
       [string]
       $HyperVClusterName,
       [Parameter(Mandatory=$true)]
       [string]
       $ScaleOutFSName,
       [switch]
       $EnableLM = $true
   )
   
   # Add and import needed features
   if ((Get-WindowsFeature | ? Name -Like "RSAT-AD-PowerShell") | ? InstallState -NotLike Installed)
   {
       Install-WindowsFeature "RSAT-AD-PowerShell"
   }
   if ((Get-WindowsFeature | ? Name -Like "RSAT-Clustering-PowerShell") | ? InstallState -NotLike Installed)
   {
       Install-WindowsFeature "RSAT-Clustering-PowerShell"
   }
   Import-Module -Name ActiveDirectory
   
   # Build array of Hyper-V servers
   $HyperVNodes = (Get-ClusterNode -Cluster $HyperVClusterName).Name
   
   # Enable LM and CD 
   $SMBServerAD = Get-ADComputer -Filter {Name -eq $ScaleOutFSName}
   $AllowedToDelegateToSMB = @( 
       ("cifs/"+$SMBServerAD.Name), 
       ("cifs/"+$SMBServerAD.DNSHostName))
   
   for ($serverCounter = 0; $serverCounter -lt $HyperVNodes.Count; $serverCounter++) 
   { 
       $AllowedToDelegateTo = $AllowedToDelegateToSMB 
       if ($EnableLM) 
       { 
           for ($delegateCounter = 0; $delegateCounter -lt $HyperVNodes.Count; $delegateCounter++) 
           { 
               if ($delegateCounter -ne $serverCounter) 
               { 
                   $delegationServer = $HyperVNodes[$delegateCounter] | Get-ADComputer 
                   $AllowedToDelegateTo += @( 
                       ("Microsoft Virtual System Migration Service/"+$delegationServer.Name), 
                       ("Microsoft Virtual System Migration Service/"+$delegationServer.DNSHostName))       
               } 
           } 
       } 
       ($HyperVNodes[$serverCounter] | Get-ADComputer) | Set-ADObject -Add @{"msDS-AllowedToDelegateTo"=$AllowedToDelegateTo} 
   }
   ```

   </details>

1. Open a Windows PowerShell session with Domain Administrator credentials on the management system. Use the script `ADGroupSetup.ps1` to create an Active Directory group for the Hyper-V computer objects. Change the values for the variables as appropriate for your environment:

    ```powershell
    # Replace the values of these variables
    $HyperVClusterName = "Compute01"
    $HyperVObjectADGroupSamName = "Hyper-VServerComputerAccounts" <#No spaces#>
    $ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"

    # Start of script itself
    CD $ScriptFolder
    .\ADGroupSetup.ps1 -HyperVObjectADGroupSamName $HyperVObjectADGroupSamName -HyperVClusterName $HyperVClusterName
    ```

1. Use the script `FileShareSetup.ps1` to create shares for each CSV and grant administrative permissions for the shares to the Domain Admins group and the compute cluster.

    ```powershell
    # Replace the values of these variables
    $StorageClusterName = "StorageSpacesDirect1"
    $HyperVObjectADGroupSamName = "Hyper-VServerComputerAccounts" <#No spaces#>
    $SOFSName = "SOFS"
    $SharePrefix = "Share"
    $ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"

    # Start of the script itself
    CD $ScriptFolder
    Get-ClusterSharedVolume -Cluster $StorageClusterName | ForEach-Object {
        $ShareName = $SharePrefix + $_.SharedVolumeInfo.friendlyvolumename.trimstart("C:\ClusterStorage\Volume")
        Write-host "Creating share $ShareName on "$_.name "on Volume: " $_.SharedVolumeInfo.friendlyvolumename
        .\FileShareSetup.ps1 -HyperVClusterName $StorageClusterName -CSVVolumeNumber $_.SharedVolumeInfo.friendlyvolumename.trimstart("C:\ClusterStorage\Volume") -ScaleOutFSName $SOFSName -ShareName $ShareName -HyperVObjectADGroupSamName $HyperVObjectADGroupSamName
    }
    ```

1. Enable Kerberos constrained delegation for remote scenario management and increased Live Migration security. From one of the storage cluster nodes, use the `KCDSetup.ps1` script. Here's a little wrapper for the script:

   ```powershell
   $HyperVClusterName = "Compute01"
   $ScaleOutFSName = "SOFS"
   $ScriptFolder = "C:\Scripts\SetupSMBSharesWithHyperV"

   CD $ScriptFolder
   .\KCDSetup.ps1 -HyperVClusterName $HyperVClusterName -ScaleOutFSName $ScaleOutFSName -EnableLM
   ```

1. Restart all nodes in the Hyper-V cluster to ensure that the new Kerberos constrained delegation settings take effect. When the nodes are back online, you can start deploying virtual machines to the file shares you created.

## Additional references

- [Storage Spaces Direct overview](storage-spaces-direct-overview.md)
- [Understand the cache in Storage Spaces Direct](/azure/azure-local/concepts/cache?context=/windows-server/context/windows-server-storage)
- [Planning volumes in Storage Spaces Direct](/azure/azure-local/concepts/plan-volumes?context=/windows-server/context/windows-server-storage)
- [Storage Spaces Fault Tolerance](/azure/azure-local/concepts/fault-tolerance?context=/windows-server/context/windows-server-storage)
- [Storage Spaces Direct Hardware Requirements](Storage-Spaces-Direct-Hardware-Requirements.md)
- [To RDMA, or not to RDMA – that is the question](https://techcommunity.microsoft.com/t5/storage-at-microsoft/bg-p/FileCAB) (TechNet blog)
