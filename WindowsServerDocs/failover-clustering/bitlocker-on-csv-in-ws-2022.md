---
ms.assetid: 2f4b6641-0ec2-4b1c-85fb-a1f1d16685c8
title: Use BitLocker with Cluster Shared Volumes
description: BitLocker on volumes within a cluster are managed based on how the cluster service "views" the volume to be protected. The volume can be a physical disk resource such as a logical unit number (LUN) on a storage area network (SAN) or network attached storage (NAS).
ms.topic: article
manager: femila
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 10/21/2021
---

# Use BitLocker with Cluster Shared Volumes (CSV)

> Applies to: Windows Server 2022; Azure Stack HCI, versions 22H2 and 21H2

## BitLocker overview

BitLocker Drive Encryption is a data protection feature that integrates with the
operating system and addresses the threats of data theft or exposure from lost,
stolen, or inadequately decommissioned computers.

BitLocker provides the most protection when used with a Trusted Platform Module
(TPM) version 1.2 or later. The TPM is a hardware component installed in many
newer computers by computer manufacturers. It works with BitLocker to help
protect user data and to ensure that a computer hasn't been tampered with while
the system was offline.

On computers that don't have a TPM version 1.2 or later, you can still use
BitLocker to encrypt the Windows operating system drive. However, this
implementation requires the user to insert a USB startup key to start the
computer or resume from hibernation. Starting with Windows 8, you can use an
operating system volume password to protect the volume on a
computer without TPM. Neither option provides the pre-startup system
integrity verification offered by BitLocker with a TPM.

In addition to the TPM, BitLocker gives you the option to lock the normal startup
process until the user supplies a personal identification number (PIN) or
inserts a removable device. This device could be a USB flash drive that contains a startup
key. These additional security measures provide multi-factor authentication and
assurance that the computer won't start or resume from hibernation until the
correct PIN or startup key is presented.

## Cluster Shared Volumes overview

Cluster Shared Volumes (CSV) enable multiple nodes in a Windows Server failover
cluster or Azure Stack HCI to simultaneously have read-write access to the same logical unit number
(LUN), or disk, that is provisioned as an NTFS volume. The disk can be provisioned as
Resilient File System (ReFS). However, the CSV drive is in redirected mode, which means write access is sent to the coordinator node. With CSV, clustered
roles can fail over quickly from one node to another without requiring a
change in drive ownership, or dismounting and remounting a volume. CSV also help
simplify the management of a potentially large number of LUNs in a failover
cluster.

CSV provides a general-purpose, clustered file system that is layered above
NTFS or ReFS. CSV applications include:

- Clustered virtual hard disk (VHD/VHDX) files for clustered Hyper-V virtual machines
- Scale out file shares to store application data for the Scale-Out File Server clustered role. Examples of the application data for this role include Hyper-V virtual machine files and Microsoft SQL Server data. ReFS isn't supported for a Scale-Out File Server in Windows Server 2012 R2 and earlier. For more information about Scale-Out File Server, see [Scale-Out File Server for Application Data](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831349(v=ws.11)).
- Microsoft SQL Server 2014 (or higher) Failover Cluster Instance (FCI) Microsoft SQL Server clustered workload in SQL Server 2012 and earlier versions of SQL Server don't support the use of CSV.
- Windows Server 2019 or higher Microsoft Distributed Transaction Control (MSDTC)

## Use BitLocker with Cluster Shared Volumes

BitLocker on volumes within a cluster are managed based on how the cluster
service "views" the volume to be protected. The volume can be a physical disk
resource such as a logical unit number (LUN) on a storage area network (SAN) or
network attached storage (NAS).

Alternatively, the volume can be a Cluster Shared Volume (CSV) within the
cluster. When using BitLocker with volumes designated for a cluster, the volume
can be enabled with BitLocker before its addition to the cluster or when in the
cluster. Put the resource into maintenance mode before enabling BitLocker.

Windows PowerShell or the
[Manage-BDE](../administration/windows-commands/manage-bde.md)
command-line interface is the preferred method to manage BitLocker on CSV
volumes. This method is recommended over the BitLocker Control Panel item
because CSV volumes are mount points. Mount points are an NTFS object that is
used to provide an entry point to other volumes. Mount points don't require the
use of a drive letter. Volumes that lack drive letters don't appear in the
BitLocker Control Panel item.

BitLocker unlocks protected volumes without user intervention by attempting
protectors in the following order:

1. Clear Key

2. Driver-based auto-unlock key

3. **ADAccountOrGroup** protector

    1. Service context protector

    2. User protector

4. Registry-based auto-unlock key

Failover Cluster requires the Active Directory-based protector option for
cluster disk resource. Otherwise, CSV resources are not available in the Control Panel
item.

An Active Directory Domain Services (AD DS) protector for protecting clustered
volumes held within your AD DS infrastructure. The **ADAccountOrGroup**
protector is a domain security identifier (SID)-based protector that can be
bound to a user account, machine account, or group. When an unlock request is
made for a protected volume, the BitLocker service interrupts the request and
uses the BitLocker protect/unprotect APIs to unlock or deny the request.

## New functionality

In previous versions of Windows Server and Azure Stack HCI, the only supported
encryption protector is the SID-based protector where the account being used is
Cluster Name Object (CNO) that is created in Active Directory as part of the
Failover Clustering creation. This is a secure design because the protector is
stored in Active Directory and protected by the CNO password. Also, it makes
provisioning and unlocking volumes easy because every Failover Cluster node has
access to the CNO account.

The downside is three-fold:

1. This method obviously doesn't work when a Failover Cluster is created
    without any access to an Active Directory controller in the datacenter.

2. Volume unlock, as part of failover, may take too long (and possibly time
    out) if the Active Directory controller is unresponsive or slow.

3. The online process of the drive fails if an Active Directory controller
    isn't available.

New functionality has been added that Failover Clustering generates and
maintains its own BitLocker Key protector for a volume. It will be encrypted
and saved in the local cluster database. Since the cluster database is a
replicated store backed by the system volume on every cluster node, the system
volume on every cluster node should be BitLocker protected as well. Failover
Clustering doesn't enforce it as some solutions may not want or need to encrypt
the system volume. If the system drive isn't Bitlockered, Failover Cluster flags this as a warning event during the online and unlock process. Failover
Cluster validation logs a message if it detects that this is an Active
Directory-less or workgroup setup and the system volume isn't encrypted.

## Installing BitLocker encryption

BitLocker is a feature that must be added to all nodes of the Cluster.

### Adding BitLocker using Server Manager

1. Open **Server Manager** by selecting the Server Manager icon or running
    servermanager.exe.

2. Select **Manage** from the Server Manager Navigation bar and select **Add
    Roles and Features** to start the **Add Roles and Features Wizard**.

3. With the **Add Roles and Features Wizard** open, select **Next** at the
    **Before you begin** pane (if shown).

4. Select **Role-based or feature-based installation** on the **Installation
    type** pane of the **Add Roles and Features Wizard** pane and select
    **Next** to continue.

5. Select the **Select a server from the server pool** option in the **Server
    Selection** pane and confirm the server for the BitLocker feature install.

6. Select **Next** on the **Server Roles** pane of the **Add Roles and
    Features** wizard to proceed to the **Features** pane.

7. Select the check box next to **BitLocker Drive Encryption** within the
    **Features** pane of the **Add Roles and Features** wizard. The wizard will
    show the additional management features available for BitLocker. If you don't
    want to install these features, deselect the **Include management
    tools** option and select **Add Features**. Once optional features selection
    is complete, select **Next** to continue.

> [!NOTE]
> The **Enhanced Storage** feature is a required feature for enabling BitLocker. This feature enables support for Encrypted Hard Drives on capable systems.

1. Select **Install** on the **Confirmation** pane of the **Add Roles and
    Features Wizard** to begin BitLocker feature installation. The BitLocker
    feature requires a restart to complete. Selecting the **Restart the
    destination server automatically if required** option in the
    **Confirmation** pane will force a restart of the computer after
    installation is complete.

2. If the **Restart the destination server automatically if required** check
    box isn't selected, the **Results** pane of the **Add Roles and Features
    Wizard** will display the success or failure of the BitLocker feature
    installation. If required, a notification of additional action necessary to
    complete the feature installation, such as the restart of the computer, will
    be displayed in the results text.

### Add BitLocker using PowerShell

Use the following command for each server:

```powershell
Install-WindowsFeature -ComputerName "Node1" -Name "BitLocker" -IncludeAllSubFeature -IncludeManagementTools
```

To run the command on all cluster servers at the same time, use the
following script, modifying the list of variables at the beginning to fit your
environment:

Fill in these variables with your values.

```powershell
$ServerList = "Node1", "Node2", "Node3", "Node4" 
$FeatureList = "BitLocker"

```

This part runs the Install-WindowsFeature cmdlet on all servers in \$ServerList, passing the list of features in \$FeatureList.

```powershell
Invoke-Command ($ServerList) {  
    Install-WindowsFeature -Name $Using:Featurelist -IncludeAllSubFeature -IncludeManagementTools 
}
```

Next, restart all the servers:

```powershell
$ServerList = "Node1", "Node2", "Node3", "Node4" Restart-Computer -ComputerName $ServerList -WSManAuthentication Kerberos
```


Multiple roles and features can be added at the same time. For
example, to add BitLocker, Failover Clustering, and the File Server role, the $FeatureList would include all needed separated by a comma. For example:

```powershell
$ServerList = "Node1", "Node2", "Node3", "Node4" 
$FeatureList = "BitLocker", “Failover-Clustering”, “FS-FileServer”
```

## Provision an encrypted volume

Provisioning a drive with BitLocker encryption can be done either when then
drive is a part of the Failover Cluster or outside before adding it. To create
the External Key Protector automatically, the drive must be a resource in the
Failover Cluster before enabling BitLocker. If BitLocker is enabled before
adding the drive to the Failover Cluster, additional manual steps to create the
External Key Protector must be accomplished.

Provisioning encrypted volumes will require PowerShell commands run with
administrative privileges. There are two options to encrypt the drives and have
Failover Clustering be able to create and use its own BitLocker keys.

1. Internal recovery key

2. External recovery key file

### Encrypt using a recovery key

Encrypting the drives using a recovery key will allow a BitLocker recovery key
to be created and added into the Cluster database. As the drive is coming
online, it only needs to consult the local cluster hive for the recovery key.

Move the disk resource to the node where BitLocker encryption will be enabled:

```powershell
Get-ClusterSharedVolume -Name "Cluster Disk 1" | Move-ClusterSharedVolume Resource -Node Node1
```

Put the disk resource into Maintenance Mode:

```powershell
Get-ClusterSharedVolume -Name "Cluster Disk 1" | Suspend-ClusterResource
```

A dialog box will pop up that says:

```powershell
Suspend-ClusterResource

Are you sure that you want to turn on maintenance for Cluster Shared Volume ‘Cluster Disk 1’? Turning on maintenance will stop all clustered roles that use this volume and will interrupt client access.
```

To continue, press **Yes**.

To enable BitLocker encryption, run:

```powershell
Enable-BitLocker -MountPoint "C:\\ClusterStorage\\Volume1" -RecoveryPasswordProtector
```

Once entering the command, a warning appears and provides a numeric recovery
password. Save the password in a secure location as it is also needed in an
upcoming step. The warning looks similar to this:

```powershell

WARNING: ACTIONS REQUIRED:

    1. Save this numerical recovery password in a secure location away from your computer:
        
        271733-258533-688985-480293-713394-034012-061963-682044

    To prevent data loss, save this password immediately. This password helps ensure that you can unlock the encrypted volume.

```

To get the BitLocker protector information for the volume, the following command
can be run:

```powershell
(Get-BitlockerVolume -MountPoint "C:\\ClusterStorage\\Volume1").KeyProtector
```

This will display both the key protector ID and the recovery password string.

```powershell
KeyProtectorId : {26935AC3-8B17-482D-BA3F-D373C7954D29}
AutoUnlockProtector :
KeyProtectorType : RecoveryPassword
KeyFileName :
RecoveryPassword : 271733-258533-688985-480293-713394-034012-061963-682044
KeyCertificateType :
Thumbprint :
```

The key protector ID and recovery password will be needed and saved into a new
physical disk private property called **BitLockerProtectorInfo**. This new
property will be used when the resource comes out of Maintenance Mode. The
format of the protector will be a string where the protector ID and the password
are separated by a ":".

```powershell
Get-ClusterSharedVolume "Cluster Disk 1" | Set-ClusterParameter -Name BitLockerProtectorInfo -Value "{26935AC3-8B17-482D-BA3F-D373C7954D29}:271733-258533-688985-480293-713394-034012-061963-682044" -Create
```

To verify that the **BitlockerProtectorInfo** key and value are set, run the
command:

```powershell
Get-ClusterSharedVolume "Cluster Disk 1" | Get-ClusterParameter BitLockerProtectorInfo
```

Now that the information is present, the disk can be brought out of maintenance
mode once the encryption process is completed.

```powershell
Get-ClusterSharedVolume -Name "Cluster Disk 1" | Resume-ClusterResource
```

If the resource fails to come online, it could be a storage issue, an incorrect
recovery password, or some issue. Verify the **BitlockerProtectorInfo** key has
the proper information. If it doesn't, the commands previously given should be
run again. If the problem isn't with this key, we recommended getting with the
proper group within your organization or the storage vendor to resolve the
issue.

If the resource comes online, the information is correct. During the process of
coming out of maintenance mode, the **BitlockerProtectorInfo** key is removed
and encrypted under the resource in the cluster database.

### Encrypting using External Recovery Key file

Encrypting the drives using a recovery key file will allow a BitLocker recovery
key to be created and accessed from a location that all nodes have access to,
such as a file server. As the drive is coming online, the owning node will
connect to the recovery key.

Move the disk resource to the node where BitLocker encryption will be enabled:

```powershell
Get-ClusterSharedVolume -Name "Cluster Disk 2" | Move-ClusterSharedVolume Resource -Node Node2
```

Put the disk resource into Maintenance Mode:

```powershell
Get-ClusterSharedVolume -Name "Cluster Disk 2" | Suspend-ClusterResource
```

A dialog box pops up

```powershell
Suspend-ClusterResource

Are you sure that you want to turn on maintenance for Cluster Shared Volume ‘Cluster Disk 2’? Turning on maintenance will stop all clustered roles that use this volume and will interrupt client access.
```

To continue, press **Yes**.

To enable BitLocker encryption and create the key protector file locally, run
the following command. Creating the file locally first and then move
it to a location accessible to all nodes is recommended.

```powershell
Enable-BitLocker -MountPoint "C:\ClusterStorage\Volume2" -RecoveryKeyProtector -RecoveryKeyPath C:\Windows\Cluster
```

To get the BitLocker protector information for the volume, the following command
can be run:

```powershell
(Get-BitlockerVolume -MountPoint "C:\ClusterStorage\Volume2").KeyProtector
```

This will display both the key protector ID and the key filename it creates.

```powershell
KeyProtectorId : {F03EB4C1-073C-4E41-B43E-B9298B6B27EC}
AutoUnlockProtector :
KeyProtectorType : ExternalKey
KeyFileName : F03EB4C1-073C-4E41-B43E-B9298B6B27EC.BEK
RecoveryPassword :
KeyCertificateType :
Thumbprint :
```

When going to the folder that was specified creating it in, you will not see it
at first glance. The reasoning is that it will be created as a hidden file. For
example:

```dos
C:\Windows\Cluster\>dir f03  

Directory of C:\\Windows\\Cluster 

File Not Found 

C:\Windows\Cluster\>dir /a f03  

Directory of C:\Windows\Cluster 

<Date> <Time> 148 F03EB4C1-073C-4E41-B43E-B9298B6B27EC.BEK 

C:\Windows\Cluster\>attrib f03 

A SHR C:\Windows\Cluster\F03EB4C1-073C-4E41-B43E-B9298B6B27EC.BEK
```

Since this is created on a local path, it must be copied over to a network path
so that all nodes will have access to it using the **Copy-Item** command.

```powershell
Copy-Item -Path C:\Windows\Cluster\F03EB4C1-073C-4E41-B43E-B9298B6B27EC.BEK -Destination \\Server\Share\Dir
```

Since the drive will be using a file and is located on a network share, bring
the drive out of maintenance mode specifying the path to the file. Once the
drive has completed with encryption, the command to resume it would be:

```powershell
Resume-ClusterPhysicalDiskResource -Name "Cluster Disk 2" -RecoveryKeyPath \\Server\Share\Dir\F03EB4C1-073C-4E41-B43E-B9298B6B27EC.BEK
```

Once the drive has been provisioned, the *.BEK file can be removed from share
and is no longer needed.

## New PowerShell cmdlets

With this new feature, two new cmdlets have been created to bring the resource
online or resuming the resource manually using the recovery key or the recovery
key file.

### Start-ClusterPhysicalDiskResource

**Example 1**
    
```powershell
    Start-ClusterPhysicalDiskResource -Name "My Disk" -RecoveryPassword "password-string"
```
    
**Example 2**

```powershell
    Start-ClusterPhysicalDiskResource -Name "My Disk" -RecoveryKeyPath "path-to-external-key-file"
```

### Resume-ClusterPhysicalDiskResource

**Example 1**
    
```powershell
    Resume-ClusterPhysicalDiskResource -Name "My Disk" -RecoveryPassword "password-string"
```
    
**Example 2**
    
```powershell
     Resume-ClusterPhysicalDiskResource -Name "My Disk" -RecoveryKeyPath "path-to-external-key-file"
```

## New events

There are several new events that have been added that are in the
Microsoft-Windows-FailoverClustering/Operational event channel.

When it is successful in creating the key protector or key protector file, the
event shown would be similar to:

`
Source: Microsoft-Windows-FailoverClustering
Event ID: 1810
Task Category: Physical Disk Resource
Level: Information
Description:
Cluster Physical Disk Resource added a protector to a BitLocker encrypted
volume.
`

If there is a failure in creating the key protector or key protector file, the
event shown would be similar to:

`
Source: Microsoft-Windows-FailoverClustering
Event ID: 1811
Task Category: Physical Disk Resource
Level: Information
Description:
Cluster Physical Disk Resource failed to create an external key protector for
the volume
`

As mentioned previously, since the cluster database is a replicated store backed
by the system volume on every cluster node, it is recommended the system volume
on every cluster node should also be BitLocker protected. Failover Clustering
will not enforce it as some solutions may not want or need to encrypt the system
volume. If the system drive isn't secured by BitLocker, Failover Cluster will flag this
as an event during the unlock/online process. The event shown would be similar
to:

`
Source: Microsoft-Windows-FailoverClustering
Event ID: 1824
Task Category: Physical Disk Resource
Level: Warning
Description:
Cluster Physical Disk Resource contains a BitLocker protected volume, but the
system volume is not BitLocker protected. For data protection, it is recommended
that the system volume be BitLocker protected as well.
ResourceName: Cluster Disk 1
`

Failover Cluster validation logs a message if it detects that this is an
Active Directory-less or workgroup setup and the system volume is not encrypted.
