---
title: Storage Migration Service frequently asked questions (FAQ)
description: Frequently asked questions about Storage Migration Service, such as what files are excluded from transfers when migrating from one server to another.
author: nedpyle
ms.author: nedpyle
manager: siroy
ms.date: 08/19/2019
ms.topic: article
ms.prod: windows-server
ms.technology: storage
---
# Storage Migration Service frequently asked questions (FAQ)

This topic contains answers to frequently asked questions (FAQs) about using [Storage Migration Service](overview.md) to migrate servers.

## What files and folders are excluded from transfers?

Storage Migration Service won't transfer files or folders that we know could interfere with Windows operation. Specifically, here's what we won't transfer or move into the PreExistingData folder on the destination:

- Windows, Program Files, Program Files (x86), Program Data, Users
- $Recycle.bin, Recycler, Recycled, System Volume Information, $UpgDrv$, $SysReset, $Windows.~BT, $Windows.~LS, Windows.old, boot, Recovery, Documents and Settings
- pagefile.sys, hiberfil.sys, swapfile.sys, winpepge.sys, config.sys, bootsect.bak, bootmgr, bootnxt
- Any files or folders on the source server that conflicts with excluded folders on the destination. <br>For example, if there's a N:\Windows folder on the source and it gets mapped to the C:\ volume on the destination, it won't get transferred—regardless of what it contains—because it would interfere with the C:\Windows system folder on the destination.

## Are locked files migrated?

The Storage Migration Service doesn't migrate files that applications exclusively lock. The service does automatically retry three times with a sixty second delay between tries, and you can control the number of attempts and the delay. You can also re-run transfers to copy just the files that were previously skipped due to sharing violations.

## Are domain migrations supported?

The Storage Migration Service doesn't allow migrating between Active Directory domains. Migrations between servers will always join the destination server to the same domain. You can use migration credentials from different domains in the Active Directory forest. The Storage Migration Service does support migrating between workgroups.  

## Are clusters supported as sources or destinations?

The Storage Migration Service supports migrating from and to clusters after installation of cumulative update [KB4513534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) or subsequent updates. This includes migrating from a source cluster to a destination cluster as well as migrating from a standalone source server to a destination cluster for device consolidation purposes. 

## Do local groups and local users migrate?

The Storage Migration Service supports migrating local users and groups after installation of cumulative update [KB4513534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) or subsequent updates. 

## Is domain controller migration supported?

The Storage Migration Service doesn't currently migrate domain controllers in Windows Server 2019. As a workaround, as long as you have more than one domain controller in the Active Directory domain, demote the domain controller before migrating it, then promote the destination after cut over completes. If you do choose to migrate a domain controller source or destination, you won't be able to cut over. You must never migrate users and groups when migrating from or to a domain controller.

## What attributes are migrated by the Storage Migration Service?

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

## Can I consolidate multiple servers into one server?

The Storage Migration Service version shipped in Windows Server 2019 doesn't support consolidating multiple servers into one server. An example of consolidation would be migrating three separate source servers - which may have the same share names and local file paths - onto a single new server that virtualized those paths and shares to prevent any overlap or collision, then answered all three previous servers names and IP address. You can migrate standalone servers onto multiple file server resources on a single cluster, however. 

## Can I migrate from sources other than Windows Server?

The Storage Migration Service supports migrating from Samba Linux servers after installation of cumulative update [KB4513534](https://support.microsoft.com/help/4512534/windows-10-update-kb4512534) or subsequent updates. See the requirements for a list of supported Samba versions and Linux distros.

## Can I migrate previous file versions?

The Storage Migration Service version shipped in Windows Server 2019 doesn't support migrating Previous Versions (made with the volume shadow copy service) of files. Only the current version will migrate. 

## Optimizing inventory and transfer performance

The Storage Migration Service contains a multi-threaded read and copy engine called the Storage Migration Service Proxy service which we designed to be both fast as well as bring along perfect data fidelity lacking in many file copy tools. While the default configuration will be optimal for many customers, there are ways to improve SMS performance during inventory and transfer.

- **Use Windows Server 2019 for the destination operating system.** Windows Server 2019 contains the Storage Migration Service Proxy service. When you install this feature and migrate to Windows Server 2019 destinations, all transfers operate as direct line of sight between source and destination. This service runs on the orchestrator during transfer if the destination computers are Windows Server 2012 R2 or Windows Server 2016, which means the transfers double-hop and will be much slower. If there are multiple jobs running with Windows Server 2012 R2 or Windows Server 2016 destinations, the orchestrator will become a bottleneck. 

- **Alter default transfer threads.** The Storage Migration Service Proxy service copies 8 files simultaneously in a given job. You can increase the number of simultaneous copy threads by adjusting the following registry REG_DWORD value name in decimal on every node running the Storage Migration Service Proxy:

    HKEY_Local_Machine\Software\Microsoft\SMSProxy
    
    FileTransferThreadCount

   The valid range is 1 to 128 in Windows Server 2019. After changing you must restart the Storage Migration Service Proxy service on all computers participating in a migration. Use caution with this setting; setting it higher may require additional cores, storage performance, and network bandwidth. Setting it too high may lead to reduced performance compared to default settings.

- **Add cores and memory.**  We strongly recommend that the source, orchestrator, and destination computers have at least two processor cores or two vCPUs, and more can significantly aid inventory and transfer performance, especially when combined with FileTransferThreadCount (above). When transferring files that are larger than the usual Office formats (gigabytes or greater) transfer performance will benefit from more memory than the default 2GB minimum.

- **Create multiple job.** When creating a job with multiple server sources, each server is contacted in serial fashion for inventory, transfer, and cutover. This means that each server must complete its phase before another server starts. To run more servers in parallel, simply create multiple jobs, with each job containing only one servers. SMS supports up to 100 simultaneously running jobs, meaning a single orchestrator can parallelize many Windows Server 2019 destination computers. We do not recommend running multiple parallel jobs if your destination computers are Windows Server 2016 or Windows Server 2012 R2 as without the SMS proxy service running on the destination, the orchestrator must perform all transfers itself and could become a bottleneck. The ability for servers to run in parallel inside a single job is a feature we plan to add in a later version of SMS.

- **Use SMB 3 with RDMA networks.** If transferring from a Windows Server 2012 or later source computer, SMB 3.x supports SMB Direct mode and RDMA networking. RDMA moves most CPU cost of transfer from the motherboard CPUs to onboard NIC processors, reducing latency and server CPU utilization. In addition, RDMA networks like ROCE and iWARP typically have substantially higher bandwidth than typical TCP/ethernet, including 25, 50, and 100Gb speeds per interface. Using SMB Direct typically moves the transfer speed limit from the network down to the storage itself.   

- **Use SMB 3 multichannel.** If transferring from a Windows Server 2012 or later source computer, SMB 3.x supports multichannel copies that can greatly improve file copy performance. This feature works automatically as long as the source and destination both have:

   - Multiple network adapters
   - One or more network adapters that support Receive Side Scaling (RSS)
   - One of more network adapters that are configured by using NIC Teaming
   - One or more network adapters that support RDMA

- **Update drivers.** As appropriate, install latest vendor storage and enclosure firmware and drivers, latest vendor HBA drivers, latest vendor BIOS/UEFI firmware, latest vendor network drivers, and latest motherboard chipset drivers on source, destination, and orchestrator servers. Restart nodes as needed. Consult your hardware vendor documentation for configuring shared storage and networking hardware.

- **Enable high-performance processing.** Ensure that BIOS/UEFI settings for servers enable high performance, such as disabling C-State, setting QPI speed, enabling NUMA, and setting highest memory frequency. Ensure power management in Windows Server is set to High Performance. Restart as required. Don't forget to return these to appropriate states after completing migration. 

- **Tune hardware** Review the [Performance Tuning Guidelines for Windows Server 2016](https://docs.microsoft.com/windows-server/administration/performance-tuning/) for tuning the orchestrator and destination computers running Windows Server 2019 and Windows Server 2016. The [Network Subsystem Performance Tuning](https://docs.microsoft.com/windows-server/networking/technologies/network-subsystem/net-sub-performance-tuning-nics) section contains especially valuable information.

- **Use faster storage.** While it may be difficult to upgrade the source computer storage speed, you should ensure the destination storage is at least as fast at write IO performance as the source is at read IO performance in order to ensure there is no unnecessary  bottleneck in transfers. If the destination is a VM, ensure that, at least for the purposes of migration, it runs in the fastest storage layer of your hypervisor hosts, such as on the flash tier or with Storage Spaces Direct HCI clusters utilizing mirrored all-flash or hybrid spaces. When the SMS migration is complete the VM can be live migrated to a slower tier or host.

- **Update antivirus.** Always ensure your source and destination are running the latest patched version of antivirus software to ensure minimal performance overhead. As a test, you can *temporarily* exclude scanning of folders you're inventorying or migrating on the source and destination servers. If your transfer performance is improved, contact your antivirus software vendor for instructions or for an updated version of the antivirus software or an explanation of expected performance degradation.

## Can I migrate from NTFS to REFS?

The Storage Migration Service version shipped in Windows Server 2019 doesn't support migrating from the NTFS to REFS file systems. You can migrate from NTFS to NTFS and REFS to ReFS. This is by design, due to the many differences in functionality, metadata, and other aspects that ReFS doesn't duplicate from NTFS. ReFS is intended as an application workload file system, not a general file system. For more information, see [Resilient File System (ReFS) overview](../refs/refs-overview.md) 

## Can I move the Storage Migration Service database?

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

## Does the Storage Migration Service migrate locally installed applications from the source computer?

No, the Storage Migration Service doesn't migrate locally installed applications. After you complete migration, re-install any applications onto the destination computer that were running on the source computer. There's no need to reconfigure any users or their applications; the Storage Migration Service is designed to make the server change invisible to clients. 

## What happens with existing files on the destination server?

When performing a transfer, the Storage Migration Service seeks to mirror data from the source server. The destination server should not contain any production data or connected users, as that data could be overwritten. By default, the first transfer makes a backup copy of any data on the destination server as a safeguard. On all subsequent transfers, by default, the Storage Migration Service will mirror data onto the destination; this means not only adding new files, but also arbitrarily overwriting any existing files and deleting any files not present on the source. This behavior is intentional and provides perfect fidelity with the source computer. 

## What do the error numbers mean in the transfer CSV?

Most errors found in the transfer CSV file are Windows System Error Codes. You can find out what each error means by reviewing the [Win32 error codes documentation](https://docs.microsoft.com/windows/win32/debug/system-error-codes). 

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
