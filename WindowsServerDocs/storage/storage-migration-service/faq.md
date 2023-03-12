---
title: Storage Migration Service frequently asked questions (FAQ)
description: Frequently asked questions about Storage Migration Service, such as what files are excluded from transfers when migrating from one server to another.
author: nedpyle
ms.author: nedpyle
manager: siroy
ms.date: 11/06/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
---
# Storage Migration Service frequently asked questions (FAQ)

This topic contains answers to frequently asked questions (FAQs) about using [Storage Migration Service](overview.md) to migrate servers.

## <a name="excluded-files"></a> What files and folders are excluded from transfers?

Storage Migration Service won't transfer files or folders that we know could interfere with Windows operation. Specifically, here's what we won't transfer or move into the PreExistingData folder on the destination:

- Windows, Program Files, Program Files (x86), Program Data, Users
- $Recycle.bin, Recycler, Recycled, System Volume Information, $UpgDrv$, $SysReset, $Windows.~BT, $Windows.~LS, Windows.old, boot, Recovery, Documents and Settings
- pagefile.sys, hiberfil.sys, swapfile.sys, winpepge.sys, config.sys, bootsect.bak, bootmgr, bootnxt
- Any files or folders on the source server that conflicts with excluded folders on the destination. <br>For example, if there's a N:\Windows folder on the source and it gets mapped to the C:\ volume on the destination, it won't get transferred—regardless of what it contains—because it would interfere with the C:\Windows system folder on the destination.

## <a name="domain-migration"></a> Are domain migrations supported?

Storage Migration Service doesn't allow migrating between Active Directory domains. Migrations between servers will always join the destination server to the same domain. You can use migration credentials from different domains in the Active Directory forest. The Storage Migration Service does support migrating between workgroups.  

## <a name="cluster-support"></a> Are clusters supported as sources or destinations?

Storage Migration Service doesn't currently migrate between Clusters in Windows Server 2019. We plan to add cluster support in a future release of the Storage Migration Service.

## <a name="local-principals"></a> Do local groups and local users migrate?

Storage Migration Service doesn't currently migrate local users or local groups in Windows Server 2019. We plan to add local user and local group migration support in a future release of the Storage Migration Service.

## <a name="domain-controller"></a> Is domain controller migration supported?

Storage Migration Service doesn't currently migrate domain controllers in Windows Server 2019. As a workaround, as long as you have more than one domain controller in the Active Directory domain, demote the domain controller before migrating it, then promote the destination after cut over completes. We plan to add domain controller migration support in a future release of the Storage Migration Service.

## <a name="share-attributes"></a> What attributes are migrated by the Storage Migration Service?

Storage Migration Service migrates all flags, settings, and security of SMB shares. That list of flags that Storage Migration Service migrates includes:

    - Share State
    - Availability Type
    - Share Type
    - Folder Enumeration Mode *(aka Access-Based Enumeration or ABE)*
    - Caching Mode
    - Leasing Mode
    - Smb Instance
    - CA Timeout
    - Concurrent User Limit
    - Continuously Available
    - Description           
    - Encrypt Data
    - Identity Remoting
    - Infrastructure
    - Name
    - Path
    - Scoped
    - Scope Name
    - Security Descriptor
    - Shadow Copy
    - Special
    - Temporary

## <a name="move-db"></a> Can I move the Storage Migration Service database?

The Storage Migration Service uses an extensible storage engine (ESE) database that is installed by default in the hidden c:\programdata\microsoft\storagemigrationservice folder. This database will grow as jobs are added and transfers are completed, and can consume significant drive space after migrating millions of files if you do not delete jobs. If the database needs to move, perform the following steps:

1. Stop the "Storage Migration Service" service on the orchestrator computer.
2. Take ownership of the `%programdata%/Microsoft/StorageMigrationService` folder
3. Add your user account to have full control over that share and all of its files and subfolders.
4. Move the folder to another drive on the orchestrator computer.
5. Set the following registry REG_SZ value:

    HKEY_Local_Machine\Software\Microsoft\SMS
    DatabasePath = *path to the new database folder on a different volume*
. 
6. Ensure that SYSTEM has full control to all files and subfolders of that folder
7. Remove your own accounts permissions.
8. Start the "Storage Migration Service" service.

## <a name="transfer-threads"></a> Can I increase the number of files that copy simultaneously?

The Storage Migration Service Proxy service copies 8 files simultaneously in a given job. This service runs on the orchestrator during transfer if the destination computers are Windows Server 2012 R2 or Windows Server 2016, but also runs on all Windows Server 2019 destination nodes. You can increase the number of simultaneous copy threads by adjusting the following registry REG_DWORD value name in decimal on every node running the SMS Proxy:

    HKEY_Local_Machine\Software\Microsoft\SMSProxy
    FileTransferThreadCount

 The valid range is 1 to 128 in Windows Server 2019. 

 After changing you must restart the Storage Migration Service Proxy service on all computers partipating in a migration. We plan to raise this number in a future version of Storage Migration Service.

## <a name="non-windows"></a> Can I migrate from sources other than Windows Server?

The Storage Migration Service version shipped in Windows Server 2019 supports migrating from Windows Server 2003 and later operating systems. It cannot currently migrate from Linux, Samba, NetApp, EMC, or other SAN and NAS storage devices. We plan to allow this in a future version of Storage Migration Service, starting with Linux Samba support.

## <a name="previous-versions"></a> Can I migrate previous file versions?

The Storage Migration Service version shipped in Windows Server 2019 doesn't support migrating Previous Versions (made with the volume shadow copy service) of files. Only the current version will migrate. 

## <a name="ntfs-refs"></a> Can I migrate from NTFS to REFS?

The Storage Migration Service version shipped in Windows Server 2019 doesn't support migrating from the NTFS to REFS file systems. You can migrate from NTFS to NTFS and REFS to ReFS. This is by design, due to the many differences in functionality, metadata, and other aspects that ReFS doesn't duplicate from NTFS. ReFS is intended as an application workload file system, not a general file system. For more information, see [Resilient File System (ReFS) overview](../refs/refs-overview.md)

## <a name="consolidate-servers"></a> Can I consolidate multiple servers into one server?

The Storage Migration Service version shipped in Windows Server 2019 doesn't support consolidating multiple servers into one server. An example of consolidation would be migrating three separate source servers - which may have the same share names and local file paths - onto a single new server that virtualized those paths and shares to prevent any overlap or collision, then answered all three previous servers names and IP address. We may add this functionality in a future version of the Storage Migration Service.  


## <a name="give-feedback"></a> What are my options to give feedback, file bugs, or get support?

To give feedback on the Storage Migration Service:

- Use the Feedback Hub tool included in Windows 10, clicking "Suggest a Feature", and specifying the category of "Windows Server" and subcategory of "Storage Migration"
- Use the [Windows Server UserVoice](https://windowsserver.uservoice.com) site
- Email smsfeed@microsoft.com

To file bugs:

- Use the Feedback Hub tool included in Windows 10, clicking "Report a Problem", and specifying the category of "Windows Server" and subcategory of "Storage Migration"
- Open a support case via [Microsoft Support](https://support.microsoft.com)

To get support:

 - Post a question on the [Windows Server Tech Community](https://techcommunity.microsoft.com/t5/Windows-Server/ct-p/Windows-Server)
 - Post on the [Windows Server 2019 Technet Forum](https://social.technet.microsoft.com/Forums/en-US/home?forum=ws2019&filter=alltypes&sort=lastpostdesc) 
 - Open a support case via [Microsoft Support](https://support.microsoft.com)


## See also

- [Storage Migration Service overview](overview.md)
