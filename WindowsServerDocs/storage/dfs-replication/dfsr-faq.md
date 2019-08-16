---
Title: 'DFS Replication: Frequently Asked Questions (FAQ)'
ms.date: 06/18/2014
ms.prod: windows-server-threshold
ms.technology: storage
author: JasonGerend
manager: elizapo
ms.author: jgerend
---

# DFS Replication: Frequently Asked Questions (FAQ)


Updated: April 30, 2019

Applies To: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

This FAQ answers questions about Distributed File System (DFS) Replication (also known as DFS-R or DFSR) for Windows Server.

For information about DFS Namespaces, see [DFS Namespaces: Frequently Asked Questions](https://technet.microsoft.com/library/ee404780).

For information about what's new in DFS Replication, see the following topics:

  - [DFS Namespaces and DFS Replication Overview](https://technet.microsoft.com/library/jj127250) (in Windows Server 2012)  
      
  - [What's New in Distributed File System](https://technet.microsoft.com/library/ee307957) topic in [Changes in Functionality from Windows Server 2008 to Windows Server 2008 R2](https://technet.microsoft.com/library/dd391932)  
      
  - [Distributed File System](https://technet.microsoft.com/library/cc753479) topic in [Changes in Functionality from Windows Server 2003 with SP1 to Windows Server 2008](https://technet.microsoft.com/library/cc753208)  
      

For a list of recent changes to this topic, see the [Change History](#change-history) section of this topic.

      

## Interoperability

### Can DFS Replication communicate with FRS?

No. DFS Replication does not communicate with File Replication Service (FRS). DFS Replication and FRS can run on the same server at the same time, but they must never be configured to replicate the same folders or subfolders because doing so can cause data loss.

### Can DFS Replication replace FRS for SYSVOL replication

Yes, DFS Replication can replace FRS for SYSVOL replication on servers running Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008. Servers running Windows Server 2003 R2 do not support using DFS Replication to replicate the SYSVOL folder.

For more information about replicating SYSVOL by using DFS Replication, see the [SYSVOL Replication Migration Guide: FRS to DFS Replication](https://technet.microsoft.com/library/dd640019).

### Can I upgrade from FRS to DFS Replication without losing configuration settings?

Yes. To migrate replication from FRS to DFS Replication, see the following documents:

  - To migrate replication of folders other than the SYSVOL folder, see [DFS Operations Guide: Migrating from FRS to DFS Replication](http://go.microsoft.com/fwlink/?linkid=192776) and [FRS2DFSR – An FRS to DFSR Migration Utility](http://go.microsoft.com/fwlink/?linkid=195437) (http://go.microsoft.com/fwlink/?LinkID=195437).  
      
  - To migrate replication of the SYSVOL folder to DFS Replication, see [SYSVOL Replication Migration Guide: FRS to DFS Replication](https://technet.microsoft.com/library/dd640019).  
      

### Can I use DFS Replication in a mixed Windows/UNIX environment?

Yes. Although DFS Replication only supports replicating content between servers running Windows Server, UNIX clients can access file shares on the Windows servers. To do so, install Services for Network File Systems (NFS) on the DFS Replication server.

You can also use the SMB/CIFS client functionality included in many UNIX clients to directly access the Windows file shares, although this functionality is often limited or requires modifications to the Windows environment (such as disabling SMB Signing by using Group Policy).

DFS Replication interoperates with NFS on a server running a Windows Server operating system, but you cannot replicate an NFS mount point.

### Can I use the Volume Shadow Copy Service with DFS Replication?

Yes. DFS Replication is supported on Volume Shadow Copy Service (VSS) volumes and previous snapshots can be restored successfully with the Previous Versions Client.

### Can I use Windows Backup (Ntbackup.exe) to remotely back up a replicated folder?

No, using Windows Backup (Ntbackup.exe) on a computer running Windows Server 2003 or earlier to back up the contents of a replicated folder on a computer running Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008 is not supported.

To back up files that are stored in a replicated folder, use Windows Server Backup or Microsoft® System Center Data Protection Manager. For information about Backup and Recovery functionality in Windows Server 2008 R2 and Windows Server 2008, see [Backup and Recovery](https://technet.microsoft.com/library/Cc754097). For more information, see [System Center Data Protection Manager](http://go.microsoft.com/fwlink/?linkid=182261) (http://go.microsoft.com/fwlink/?LinkId=182261).

### Do file system policies impact DFS Replication?

Yes. Do not configure file system policies on replicated folders. The file system policy reapplies NTFS permissions at every Group Policy refresh interval. This can result in sharing violations because an open file is not replicated until the file is closed.

### Does DFS Replication replicate mailboxes hosted on Microsoft Exchange Server?

No. DFS Replication cannot be used to replicate mailboxes hosted on Microsoft Exchange Server.

### Does DFS Replication support file screens created by File Server Resource Manager?

Yes. However, the File Server Resource Manager (FSRM) file screening settings must match on both ends of the replication. In addition, DFS Replication has its own filter mechanism for files and folders that you can use to exclude certain files and file types from replication.

The following are best practices for implementing file screens or quotas:

  - The hidden DfsrPrivate folder must not be subject to quotas or file screens.  
      
  - Screened files must not exist in any replicated folder before screening is enabled.  
      
  - No folders may exceed the quota before the quota is enabled.  
      
  - You must use hard quotas with caution. It is possible for individual members of a replication group to stay within a quota before replication, but exceed it when files are replicated. For example, if a user copies a 10 megabyte (MB) file onto server A (which is then at the hard limit) and another user copies a 5 MB file onto server B, when the next replication occurs, both servers will exceed the quota by 5 megabytes. This can cause DFS Replication to continually retry replicating the files, causing holes in the version vector and possible performance problems.  
      

### Is DFS Replication cluster aware?

Yes, DFS Replication in Windows Server 2012 R2, Windows Server 2012 and Windows Server 2008 R2 includes the ability to add a failover cluster as a member of a replication group. For more information, see [Add a Failover Cluster to a Replication Group](http://go.microsoft.com/fwlink/?linkid=155085) (http://go.microsoft.com/fwlink/?LinkId=155085). The DFS Replication service on versions of Windows prior to Windows Server 2008 R2 is not designed to coordinate with a failover cluster, and the service will not fail over to another node.


> [!NOTE]
> DFS Replication does not support replicating files on Cluster Shared Volumes. 
<br>


### Is DFS Replication compatible with Data Deduplication?

Yes, DFS Replication can replicate folders on volumes that use Data Deduplication in Windows Server.

### Is DFS Replication compatible with RIS and WDS?

Yes. DFS Replication replicates volumes on which Single Instance Storage (SIS) is enabled. SIS is used by Remote Installation Services (RIS), Windows Deployment Services (WDS), and Windows Storage Server.

### Is it possible to use DFS Replication with Offline Files?

You can safely use DFS Replication and Offline Files together in scenarios when there is only one user at a time who writes to the files. This is useful for users who travel between two branch offices and want to be able to access their files at either branch or while offline. Offline Files caches the files locally for offline use and DFS Replication replicates the data between each branch office.

Do not use DFS Replication with Offline Files in a multi-user environment because DFS Replication does not provide any distributed locking mechanism or file checkout capability. If two users modify the same file at the same time on different servers, DFS Replication moves the older file to the DfsrPrivate\\ConflictandDeleted folder (located under the local path of the replicated folder) during the next replication.

### What antivirus applications are compatible with DFS Replication?

Antivirus applications can cause excessive replication if their scanning activities alter the files in a replicated folder. For more information, [Testing Antivirus Application Interoperability with DFS Replication](http://go.microsoft.com/fwlink/?linkid=73990) (http://go.microsoft.com/fwlink/?LinkId=73990).

### What are the benefits of using DFS Replication instead of Windows SharePoint Services?

Windows® SharePoint® Services provides tight coherency in the form of file check-out functionality that DFS Replication does not. If you are concerned about multiple people editing the same file, we recommend using Windows SharePoint Services. Windows SharePoint Services 2.0 with Service Pack 2 is available as part of Windows Server 2003 R2. Windows SharePoint Services can be downloaded from the Microsoft Web site; it is not included in newer versions of Windows Server. However, if you are replicating data across multiple sites and users will not edit the same files at the same time, DFS Replication provides greater bandwidth and simpler management.

## Limitations and requirements

### Can DFS Replication replicate between branch offices without a VPN connection?

Yes—assuming that there is a private Wide Area Network (WAN) link (not the Internet) connecting the branch offices. However, you must open the proper ports in external firewalls. DFS Replication uses the RPC Endpoint Mapper (port 135) and a randomly assigned ephemeral port above 1024. You can use the **Dfsrdiag** command line tool to specify a static port instead of the ephemeral port. For more information about how to specify the RPC Endpoint Mapper, see [article 154596](http://go.microsoft.com/fwlink/?linkid=73991) in the Microsoft Knowledge Base (http://go.microsoft.com/fwlink/?LinkId=73991).

### Can DFS Replication replicate files encrypted with the Encrypting File System?

No. DFS Replication will not replicate files or folders that are encrypted using the Encrypting File System (EFS). If a user encrypts a file that was previously replicated, DFS Replication deletes the file from all other members of the replication group. This ensures that the only available copy of the file is the encrypted version on the server.

### Can DFS Replication replicate Outlook .pst or Microsoft Office Access database files?

DFS Replication can safely replicate Microsoft Outlook personal folder files (.pst) and Microsoft Access files only if they are stored for archival purposes and are not accessed across the network by using a client such as Outlook or Access (to open .pst or Access files, first copy the files to a local storage device). The reasons for this are as follows:

  - Opening .pst files over network connections could lead to data corruption in the .pst files. For more information about why .pst files cannot be safely accessed from across a network, see [article 297019](http://go.microsoft.com/fwlink/?linkid=125363) in the Microsoft Knowledge Base (http://go.microsoft.com/fwlink/?LinkId=125363).  
      
  - .pst and Access files tend to stay open for long periods of time while being accessed by a client such as Outlook or Office Access. This prevents DFS Replication from replicating these files until they are closed.  
      

### Can I use DFS Replication in a workgroup?

No. DFS Replication relies on Active Directory® Domain Services for configuration. It will only work in a domain.

### Can more than one folder be replicated on a single server?

Yes. DFS Replication can replicate numerous folders between servers. Ensure that each of the replicated folders has a unique root path and that they do not overlap. For example, D:\\Sales and D:\\Accounting can be the root paths for two replicated folders, but D:\\Sales and D:\\Sales\\Reports cannot be the root paths for two replicated folders.

### Does DFS Replication require DFS Namespaces?

No. DFS Replication and DFS Namespaces can be used separately or together. In addition, DFS Replication can be used to replicate standalone DFS namespaces, which was not possible with FRS.

### Does DFS Replication require time synchronization between servers?

No. DFS Replication does not explicitly require time synchronization between servers. However, DFS Replication does require that the server clocks match closely. The server clocks must be set within five minutes of each other (by default) for Kerberos authentication to function properly. For example, DFS Replication uses time stamps to determine which file takes precedence in the event of a conflict. Accurate times are also important for garbage collection, schedules, and other features.

### Does DFS Replication support replicating an entire volume?

Yes. However, you must first install Windows Server 2003 Service Pack 2 or the hotfix. For more information, see [article 920335](http://go.microsoft.com/fwlink/?linkid=76776) in the Microsoft Knowledge Base (http://go.microsoft.com/fwlink/?LinkId=76776). Additionally, replicating an entire volume can cause the following problems:

  - If the volume contains a Windows paging file, replication fails and logs DFSR event 4312 in the system event log.  
      
  - DFS Replication sets the System and Hidden attributes on the replicated folder on the destination server(s). This occurs because Windows applies the System and Hidden attributes to the volume root folder by default. If the local path of the replicated folder on the destination server(s) is also a volume root, no further changes are made to the folder attributes.  
      
  - When replicating a volume that contains the Windows system folder, DFS Replication recognizes the %WINDIR% folder and does not replicate it. However, DFS Replication does replicate folders used by non-Microsoft applications, which might cause the applications to fail on the destination server(s) if the applications have interoperability issues with DFS Replication.  
      

### Does DFS Replication support RPC over HTTP?

No.

### Does DFS Replication work across wireless networks?

Yes. DFS Replication is independent of the connection type.

### Does DFS Replication work on ReFS or FAT volumes?

No. DFS Replication supports volumes formatted with the NTFS file system only; the Resilient File System (ReFS) and the FAT file system are not supported. DFS Replication requires NTFS because it uses the NTFS change journal and other features of the NTFS file system.

### Does DFS Replication work with sparse files?

Yes. You can replicate sparse files. The **Sparse** attribute is preserved on the receiving member.

### Do I need to log in as administrator to replicate files?

No. DFS Replication is a service that runs under the local system account, so you do not need to log in as administrator to replicate. However, you must be a domain administrator or local administrator of the affected file servers to make changes to the DFS Replication configuration.

For more information, see "DFS Replication security requirements and delegation" in the [Delegate the Ability to Manage DFS Replication](http://go.microsoft.com/fwlink/?linkid=182294) (http://go.microsoft.com/fwlink/?LinkId=182294).

### How can I upgrade or replace a DFS Replication member?

To upgrade or replace a DFS Replication member, see this blog post on the Ask the Directory Services Team blog: [Replacing DFSR Member Hardware or OS](http://blogs.technet.com/b/askds/archive/2010/09/10/series-wrap-up-and-downloads-replacing-dfsr-member-hardware-or-os.aspx).

### Is DFS Replication suitable for replicating roaming profiles?

Yes. Certain scenarios are supported when replicating roaming user profiles. For information about the supported scenarios, see [Microsoft’s Support Statement Around Replicated User Profile Data](http://go.microsoft.com/fwlink/?linkid=201282) (http://go.microsoft.com/fwlink/?LinkId=201282).

### Is there a file character limit or limit to the folder depth?

Windows and DFS Replication support folder paths with up to 32 thousand characters. DFS Replication is not limited to folder paths of 260 characters.

### Must members of a replication group reside in the same domain?

No. Replication groups can span across domains within a single forest but not across different forests.

### What are the supported limits of DFS Replication?

The following list provides a set of scalability guidelines that have been tested by Microsoft on Windows Server 2012 R2:

  - Size of all replicated files on a server: 100 terabytes.  
      
  - Number of replicated files on a volume: 70 million.  
      
  - Maximum file size: 250 gigabytes.  
      


> [!IMPORTANT]
> When creating replication groups with a large number or size of files we recommend exporting a database clone and using pre-seeding techniques to minimize the duration of initial replication. For more information, see <A href="http://blogs.technet.com/b/filecab/archive/2013/08/21/dfs-replication-initial-sync-in-windows-server-2012-r2-attack-of-the-clones.aspx">DFS Replication Initial Sync in Windows Server 2012 R2: Attack of the Clones</A>. 
<br>


The following list provides a set of scalability guidelines that have been tested by Microsoft on Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008:

  - Size of all replicated files on a server: 10 terabytes.  
      
  - Number of replicated files on a volume: 11 million.  
      
  - Maximum file size: 64 gigabytes.  
      


> [!NOTE]
> There is no longer a limit to the number of replication groups, replicated folders, connections, or replication group members. 
<br>


For a list of scalability guidelines that have been tested by Microsoft for Windows Server 2003 R2, see [DFS Replication scalability guidelines](http://go.microsoft.com/fwlink/?linkid=75043) (http://go.microsoft.com/fwlink/?LinkId=75043).

### When should I not use DFS Replication?

Do not use DFS Replication in an environment where multiple users update or modify the same files simultaneously on different servers. Doing so can cause DFS Replication to move conflicting copies of the files to the hidden DfsrPrivate\\ConflictandDeleted folder.

When multiple users need to modify the same files at the same time on different servers, use the file check-out feature of Windows SharePoint Services to ensure that only one user is working on a file. Windows SharePoint Services 2.0 with Service Pack 2 is available as part of Windows Server 2003 R2. Windows SharePoint Services can be downloaded from the Microsoft Web site; it is not included in newer versions of Windows Server.

### Why is a schema update required for DFS Replication?

DFS Replication uses new objects in the domain-naming context of Active Directory Domain Services to store configuration information. These objects are created when you update the Active Directory Domain Services schema. For more information, see [Review Requirements for DFS Replication](http://go.microsoft.com/fwlink/?linkid=182264) (http://go.microsoft.com/fwlink/?LinkId=182264).

## Monitoring and management tools

### Can I automate the health report to receive warnings?

Yes. There are three ways to automate health reports:

  - Use the DFSR Windows PowerShell module included in Windows Server 2012 R2 or DfsrAdmin.exe in conjunction with Scheduled Tasks to regularly generate health reports. For more information, see [Automating DFS Replication Health Reports](http://go.microsoft.com/fwlink/?linkid=74010) (http://go.microsoft.com/fwlink/?LinkId=74010).  
      
  - Use the DFS Replication Management Pack for System Center Operations Manager to create alerts that are based on specified conditions.  
      
  - Use the DFS Replication WMI provider to script alerts.  
      

### Can I use Microsoft System Center Operations Manager to monitor DFS Replication?

Yes. For more information, see the [DFS Replication Management Pack for System Center Operations Manager 2007](http://go.microsoft.com/fwlink/?linkid=182265) in the Microsoft Download Center (http://go.microsoft.com/fwlink/?LinkId=182265).

### Does DFS Replication support remote management?

Yes. DFS Replication supports remote management using the DFS Management console and the **Add Replication Group** command. For example, on server A, you can connect to a replication group defined in the forest with servers A and B as members.

DFS Management is included with Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, and Windows Server 2003 R2. To manage DFS Replication from other versions of Windows, use Remote Desktop or the [Remote Server Administration Tools for Windows 7](https://technet.microsoft.com/library/Ee449475).


> [!IMPORTANT]
> To view or manage replication groups that contain read-only replicated folders or members that are failover clusters, you must use the version of DFS Management that is included with Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, the <a href="http://go.microsoft.com/fwlink/p/?linkid=238560">Remote Server Administration Tools for Windows 8</a>, or the <a href="https://technet.microsoft.com/library/ee449475">Remote Server Administration Tools for Windows 7</a>. 
<br>


### Do Ultrasound and Sonar work with DFS Replication?

No. DFS Replication has its own set of monitoring and diagnostics tools. Ultrasound and Sonar are only capable of monitoring FRS.

### How can files be recovered from the ConflictAndDeleted or PreExisting folders?

To recover lost files, restore the files from the file system folder or shared folder using File History, the **Restore previous versions** command in File Explorer, or by restoring the files from backup. To recover files directly from the ConflictAndDeleted or PreExisting folder, use the `Get-DfsrPreservedFiles` and `Restore-DfsrPreservedFiles` Windows PowerShell cmdlets (included with the DFSR module in Windows Server 2012 R2), or the [RestoreDFSR](http://code.msdn.microsoft.com/restoredfsr) sample script from the MSDN Code Gallery. This script is intended only for disaster recovery and is provided AS-IS, without warranty.

### Is there a way to know the state of replication?

Yes. There are a number of ways to monitor replication:

  - DFS Replication has a management pack for System Center Operations Manager that provides proactive monitoring.  
      
  - DFS Management has an in-box diagnostic report for the replication backlog, replication efficiency, and the number of files and folders in a given replication group.  
      
  - The DFSR Windows PowerShell module in Windows Server 2012 R2 contains cmdlets for starting propagation tests and writing propagation and health reports. For more information, see [Distributed File System Replication Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/dn296601.aspx).  
      
  - Dfsrdiag.exe is a command-line tool that can generate a backlog count or trigger a propagation test. Both show the state of replication. Propagation shows you if files are being replicated to all nodes. Backlog shows you how many files still need to replicate before two computers are in sync. The backlog count is the number of updates that a replication group member has not processed. On computers running Windows Server 2012 R2, Windows Server 2012 or Windows Server 2008 R2, Dfsrdiag.exe can also display the updates that DFS Replication is currently replicating.  
      
  - Scripts can use WMI to collect backlog information—manually or through MOM.  
      

## Performance

### Does DFS Replication support dial-up connections?

Although DFS Replication will work at dial-up speeds, it can get backlogged if there are large numbers of changes to replicate. If small changes are made to existing files, DFS Replication with Remote Differential Compression (RDC) will provide a much higher performance than copying the file directly.

### Does DFS Replication perform bandwidth sensing?

No. DFS Replication does not perform bandwidth sensing. You can configure DFS Replication to use a limited amount of bandwidth on a per-connection basis (bandwidth throttling). However, DFS Replication does not further reduce bandwidth utilization if the network interface becomes saturated, and DFS Replication can saturate the link for short periods. Bandwidth throttling with DFS Replication is not completely accurate because DFS Replication throttles bandwidth by throttling RPC calls. As a result, various buffers in lower levels of the network stack (including RPC) may interfere, causing bursts of network traffic.

### Does DFS Replication throttle bandwidth per schedule, per server, or per connection?

If you configure bandwidth throttling when specifying the schedule, all connections for that replication group will use that setting for bandwidth throttling. Bandwidth throttling can be also set as a connection-level setting using DFS Management.

### Does DFS Replication use Active Directory Domain Services to calculate site links and connection costs?

No. DFS Replication uses the topology defined by the administrator, which is independent of Active Directory Domain Services site costing.

### How can I improve replication performance?

To learn about different methods of tuning replication performance, see [Tuning Replication Performance in DFSR](http://blogs.technet.com/b/askds/archive/2010/03/31/tuning-replication-performance-in-dfsr-especially-on-win2008-r2.aspx) on the [Ask the Directory Services Team blog](http://blogs.technet.com/b/askds/).

### How does DFS Replication avoid saturating a connection?

In DFS Replication you set the maximum bandwidth you want to use on a connection, and the service maintains that level of network usage. This is different from the Background Intelligent Transfer Service (BITS), and DFS Replication does not saturate the connection if you set it appropriately.

Nonetheless, the bandwidth throttling is not 100% accurate and DFS Replication can saturate the link for short periods of time. This is because DFS Replication throttles bandwidth by throttling RPC calls. Because this process relies on various buffers in lower levels of the network stack, including RPC, the replication traffic tends to travel in bursts which may at times saturate the network links.

DFS Replication in Windows Server 2008 includes several performance enhancements, as discussed in [Distributed File System](https://technet.microsoft.com/library/Cc753479), a topic in [Changes in Functionality from Windows Server 2003 with SP1 to Windows Server 2008](https://technet.microsoft.com/library/cc753208).

### How does DFS Replication performance compare with FRS?

DFS Replication is much faster than FRS, particularly when small changes are made to large files and RDC is enabled. For example, with RDC, a small change to a 2 MB PowerPoint® presentation can result in only 60 kilobytes (KB) being sent across the network—a 97 percent savings in bytes transferred.

RDC is not used on files smaller than 64 KB and might not be beneficial on high-speed LANs where network bandwidth is not contended. RDC can be disabled on a per-connection basis using DFS Management.

### How frequently does DFS Replication replicate data?

Data replicates according to the schedule you set. For example, you can set the schedule to 15-minute intervals, seven days a week. During these intervals, replication is enabled. Replication starts soon after a file change is detected (generally within seconds).

The replication group schedule may be set to Universal Time Coordinate (UTC) while the connection schedule is set to the local time of the receiving member. Take this into account when the replication group spans multiple time zones. Local time means the time of the member hosting the inbound connection. The displayed schedule of the inbound connection and the corresponding outbound connection reflect time zone differences when the schedule is set to local time.

### How much of my server's system resources will DFS Replication consume?

The disk, memory, and CPU resources used by DFS Replication depend on a number of factors, including the number and size of the files, rate of change, number of replication group members, and number of replicated folders. In addition, some resources are harder to estimate. For example, the Extensible Storage Engine (ESE) technology used for the DFS Replication database can consume a large percentage of available memory, which it releases on demand. Applications other than DFS Replication can be hosted on the same server depending on the server configuration. However, when hosting multiple applications or server roles on a single server, it is important that you test this configuration before implementing it in a production environment.

### What happens if a WAN link fails during replication?

If the connection goes down, DFS Replication will keep trying to replicate while the schedule is open. There will also be connectivity errors noted in the DFS Replication event log that can be harvested using MOM (proactively through alerts) and the DFS Replication Health Report (reactively, such as when an administrator runs it).

## Remote Differential Compression details

### Are changes compressed before being replicated?

Yes. Changed portions of files are compressed before being sent for all file types except the following (which are already compressed): .wma, .wmv, .zip, .jpg, .mpg, .mpeg, .m1v, .mp2, .mp3, .mpa, .cab, .wav, .snd, .au, .asf, .wm, .avi, .z, .gz, .tgz, and .frx. Compression settings for these file types are not configurable in Windows Server 2003 R2.

### Can an administrator turn off RDC or change the threshold?

Yes. You can turn off RDC through the property page of a given connection. Disabling RDC can reduce CPU utilization and replication latency on fast local area network (LAN) links that have no bandwidth constraints or for replication groups that consist primarily of files smaller than 64 KB. If you choose to disable RDC on a connection, test the replication efficiency before and after the change to verify that you have improved replication performance.

You can change the RDC size threshold by using the **Dfsradmin Connection Set** command, the DFS Replication WMI Provider, or by manually editing the configuration XML file.

### Does RDC work on all file types?

Yes. RDC computes differences at the block level irrespective of file data type. However, RDC works more efficiently on certain file types such as Word docs, PST files, and VHD images.

### How does RDC work on a compressed file?

DFS Replication uses RDC, which computes the blocks in the file that have changed and sends only those blocks over the network. DFS Replication does not need to know anything about the contents of the file—only which blocks have changed.

### Is cross-file RDC enabled when upgrading to Windows Server Enterprise Edition or Datacenter Edition?

The Standard Editions of Windows Server do not support cross-file RDC. However, it is automatically enabled when you upgrade to an edition that supports cross-file RDC, or if a member of the replication connection is running a supported edition. For a list of editions that support cross-file RDC, see Which editions of the Windows operating system support cross-file RDC?

### Is RDC true block-level replication?

No. RDC is a general purpose protocol for compressing file transfer. DFS Replication uses RDC on blocks at the file level, not at the disk block level. RDC divides a file into blocks. For each block in a file, it calculates a signature, which is a small number of bytes that can represent the larger block. The set of signatures is transferred from server to client. The client compares the server signatures to its own. The client then requests the server send only the data for signatures that are not already on the client.

### What happens if I rename a file?

DFS Replication renames the file on all other members of the replication group during the next replication. Files are tracked using a unique ID, so renaming a file and moving the file within the replica has no effect on the ability of DFS Replication to replicate a file.

### What is cross-file RDC?

Cross-file RDC allows DFS Replication to use RDC even when a file with the same name does not exist at the client end. Cross-file RDC uses a heuristic to determine files that are similar to the file that needs to be replicated, and uses blocks of the similar files that are identical to the replicating file to minimize the amount of data transferred over the WAN. Cross-file RDC can use blocks of up to five similar files in this process.

To use cross-file RDC, one member of the replication connection must be running an edition of Windows that supports cross-file RDC. For a list of editions that support cross-file RDC, see Which editions of the Windows operating system support cross-file RDC?

### What is RDC?

Remote differential compression (RDC) is a client-server protocol that can be used to efficiently update files over a limited-bandwidth network. RDC detects insertions, removals, and rearrangements of data in files, enabling DFS Replication to replicate only the changes when files are updated. RDC is used only for files that are 64 KB or larger by default. RDC can use an older version of a file with the same name in the replicated folder or in the DfsrPrivate\\ConflictandDeleted folder (located under the local path of the replicated folder).

### When is RDC used for replication?

RDC is used when the file exceeds a minimum size threshold. This size threshold is 64 KB by default. After a file exceeding that threshold has been replicated, updated versions of the file always use RDC, unless a large portion of the file is changed or RDC is disabled.

### Which editions of the Windows operating system support cross-file RDC?

To use cross-file RDC, one member of the replication connection must be running an edition of the Windows operating system that supports cross-file RDC. The following table shows which editions of the Windows operating system support cross-file RDC.

### Cross-file RDC availability in editions of the Windows operating system

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Operating System Version</th>
<th>Standard Edition</th>
<th>Enterprise Edition</th>
<th>Datacenter Edition</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td><p>Windows Server 2012 R2</p></td>
<td><p>Yes<em></p></td>
<td><p>Not available</p></td>
<td><p>Yes</em></p></td>
</tr>
<tr class="odd">
<td><p>Windows Server 2012</p></td>
<td><p>Yes</p></td>
<td><p>Not available</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="even">
<td><p>Windows Server 2008 R2</p></td>
<td><p>No</p></td>
<td><p>Yes</p></td>
<td><p>Yes</p></td>
</tr>
<tr class="odd">
<td><p>Windows Server 2008</p></td>
<td><p>No</p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
</tr>
<tr class="even">
<td><p>Windows Server 2003 R2</p></td>
<td><p>No</p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
</tr>
</tbody>
</table>

\* You can optionally disable cross-file RDC on Windows Server 2012 R2.

## Replication details

### Can I change the path for a replicated folder after it is created?

No. If you need to change the path of a replicated folder, you must delete it in DFS Management and add it back as a new replicated folder. DFS Replication then uses Remote Differential Compression (RDC) to perform a synchronization that determines whether the data is the same on the sending and receiving members. It does not replicate all the data in the folder again.

### Can I configure which file attributes are replicated?

No, you cannot configure which file attributes that DFS Replication replicates.

For a list of attribute values and their descriptions, see [File Attributes](http://go.microsoft.com/fwlink/?linkid=182268) on MSDN (http://go.microsoft.com/fwlink/?LinkId=182268).

The following attribute values are set by using the `SetFileAttributes dwFileAttributes` function, and they are replicated by DFS Replication. Changes to these attribute values trigger replication of the attributes. The contents of the file are not replicated unless the contents change as well. For more information, see [SetFileAttributes Function](http://go.microsoft.com/fwlink/?linkid=182269) in the MSDN library (http://go.microsoft.com/fwlink/?LinkId=182269).

  - FILE\_ATTRIBUTE\_HIDDEN  
      
  - FILE\_ATTRIBUTE\_READONLY  
      
  - FILE\_ATTRIBUTE\_SYSTEM  
      
  - FILE\_ATTRIBUTE\_NOT\_CONTENT\_INDEXED  
      
  - FILE\_ATTRIBUTE\_OFFLINE  
      

The following attribute values are replicated by DFS Replication, but they do not trigger replication.

  - FILE\_ATTRIBUTE\_ARCHIVE  
      
  - FILE\_ATTRIBUTE\_NORMAL  
      

The following file attribute values also trigger replication, although they cannot be set by using the `SetFileAttributes` function (use the `GetFileAttributes` function to view the attribute values).

  - FILE\_ATTRIBUTE\_REPARSE\_POINT  
      

> [!NOTE]
> DFS Replication does not replicate reparse point attribute values unless the reparse tag is IO_REPARSE_TAG_SYMLINK. Files with the IO_REPARSE_TAG_DEDUP, IO_REPARSE_TAG_SIS or IO_REPARSE_TAG_HSM reparse tags are replicated as normal files. However, the reparse tag and reparse data buffers are not replicated to other servers because the reparse point only works on the local system. 
<br>

  - FILE\_ATTRIBUTE\_COMPRESSED  
      
  - FILE\_ATTRIBUTE\_ENCRYPTED  
      

> [!NOTE]
> DFS Replication does not replicate files that are encrypted by using the Encrypting File System (EFS). DFS Replication does replicate files that are encrypted by using non-Microsoft software, but only if it does not set the FILE_ATTRIBUTE_ENCRYPTED attribute value on the file. 
<br>

  - FILE\_ATTRIBUTE\_SPARSE\_FILE  
      
  - FILE\_ATTRIBUTE\_DIRECTORY  
      

DFS Replication does not replicate the FILE\_ATTRIBUTE\_TEMPORARY value.

### Can I control which member is replicated?

Yes. You can choose a topology when you create a replication group. Or you can select **No topology** and manually configure connections after the replication group has been created.

### Can I seed a replication group member with data prior to the initial replication?

Yes. DFS Replication supports copying files to a replication group member before the initial replication. This "prestaging" can dramatically reduce the amount of data replicated during the initial replication.

The initial replication does not need to replicate contents when files differ only by real attributes or time stamps. A real attribute is an attribute that can be set by the Win32 function `SetFileAttributes`. For more information, see [SetFileAttributes Function](http://go.microsoft.com/fwlink/?linkid=182269) in the MSDN library (http://go.microsoft.com/fwlink/?LinkId=182269). If two files differ by other attributes, such as compression, then the contents of the file are replicated.

To prestage a replication group member, copy the files to the appropriate folder on the destination server(s), create the replication group, and then choose a primary member. Choose the member that has the most up-to-date files that you want to replicate because the primary member's content is considered "authoritative." This means that during initial replication, the primary member's files will always overwrite other versions of the files on other members of the replication group.

For information about pre-seeding and cloning the DFSR database, see [DFS Replication Initial Sync in Windows Server 2012 R2: Attack of the Clones](http://blogs.technet.com/b/filecab/archive/2013/08/21/dfs-replication-initial-sync-in-windows-server-2012-r2-attack-of-the-clones.aspx).

For more information about the initial replication, see [Create a Replication Group](https://technet.microsoft.com/library/cc725893).

### Does DFS Replication overcome common File Replication Service issues?

Yes. DFS Replication overcomes three common FRS issues:

  - Journal wraps: DFS Replication recovers from journal wraps on the fly. Each existing file or folder will be marked as journalWrap and verified against the file system before replication is enabled again. During the recovery, this volume is not available for replication in either direction.  
      
  - Excessive replication: To prevent excessive replication, DFS Replication uses a system of credits.  
      
  - Morphed folders: To prevent morphed folder names, DFS Replication stores conflicting data in a hidden DfsrPrivate\\ConflictandDeleted folder (located under the local path of the replicated folder). For example, creating multiple folders simultaneously with identical names on different servers replicated using FRS causes FRS to rename the older folder(s). DFS Replication instead moves the older folder(s) to the local Conflict and Deleted folder.  
      

### Does DFS Replication replicate files in chronological order?

No. Files may be replicated out of order.

### Does DFS Replication replicate files that are being used by another application?

If an application opens a file and creates a file lock on it (preventing it from being used by other applications while it is open), DFS Replication will not replicate the file until it is closed. If the application opens the file with read-share access, the file can still be replicated.

### Does DFS Replication replicate NTFS file permissions, alternate data streams, hard links, and reparse points?

  - DFS Replication replicates NTFS file permissions and alternate data streams.  
      
  - Microsoft does not support creating NTFS hard links to or from files in a replicated folder – doing so can cause replication issues with the affected files. Hard link files are ignored by DFS Replication and are not replicated. Junction points also are not replicated, and DFS Replication logs event 4406 for each junction point it encounters.  
      
  - The only reparse points replicated by DFS Replication are those that use the IO\_REPARSE\_TAG\_SYMLINK tag; however, DFS Replication does not guarantee that the target of a symlink is also replicated. For more information, see the [Ask the Directory Services Team blog](http://blogs.technet.com/b/askds/archive/2011/09/30/friday-mail-sack-super-slo-mo-edition.aspx).  
      
  - Files with the IO\_REPARSE\_TAG\_DEDUP, IO\_REPARSE\_TAG\_SIS, or IO\_REPARSE\_TAG\_HSM reparse tags are replicated as normal files. The reparse tag and reparse data buffers are not replicated to other servers because the reparse point only works on the local system. As such, DFS Replication can replicate folders on volumes that use Data Deduplication in Windows Server 2012, or Single Instance Storage (SIS), however, data deduplication information is maintained separately by each server on which the role service is enabled.  
      

### Does DFS Replication replicate timestamp changes if no other changes are made to the file?

No, DFS Replication does not replicate files for which the only change is a change to the timestamp. Additionally, the changed timestamp is not replicated to other members of the replication group unless other changes are made to the file.

### Does DFS Replication replicate updated permissions on a file or folder?

Yes. DFS Replication replicates permission changes for files and folders. Only the part of the file associated with the Access Control List (ACL) is replicated, although DFS Replication must still read the entire file into the staging area.


> [!NOTE]
> Changing ACLs on a large number of files can have an impact on replication performance. However, when using RDC, the amount of data transferred is proportionate to the size of the ACLs, not the size of the entire file. The amount of disk traffic is still proportional to the size of the files because the files must be read to and from the staging folder. 
<br>


### Does DFS Replication support merging text files in the event of a conflict?

DFS Replication does not merge files when there is a conflict. However, it does attempt to preserve the older version of the file in the hidden DfsrPrivate\\ConflictandDeleted folder on the computer where the conflict was detected.

### Does DFS Replication use encryption when transmitting data?

Yes. DFS Replication uses Remote Procedure Call (RPC) connections with encryption.

### Is it possible to disable the use of encrypted RPC?

No. The DFS Replication service uses remote procedure calls (RPC) over TCP to replicate data. To secure data transfers across the Internet, the DFS Replication service is designed to always use the authentication-level constant, `RPC_C_AUTHN_LEVEL_PKT_PRIVACY`. This ensures that the RPC communication across the Internet is always encrypted. Therefore, it is not possible to disable the use of encrypted RPC by the DFS Replication service.

For more information, see the following Microsoft Web sites:

  - [RPC Technical Reference](http://go.microsoft.com/fwlink/?linkid=182278)  
      
  - [About Remote Differential Compression](http://go.microsoft.com/fwlink/?linkid=182279)  
      
  - [Authentication-Level Constants](http://go.microsoft.com/fwlink/?linkid=182280)  
      

### How are simultaneous replications handled?

There is one update manager per replicated folder. Update managers work independently of one another.

By default, a maximum of 16 (four in Windows Server 2003 R2) concurrent downloads are shared among all connections and replication groups. Because connections and replication group updates are not serialized, there is no specific order in which updates are received. If two schedules are opened, updates are generally received and installed from both connections at the same time.

### How do I force replication or polling?

You can force replication immediately by using DFS Management, as described in [Edit Replication Schedules](https://technet.microsoft.com/library/Cc732278). You can also force replication by using the `Sync-DfsReplicationGroup` cmdlet, included in the DFSR PowerShell module introduced with Windows Server 2012 R2, or the **Dfsrdiag SyncNow** command. You can force polling by using the `Update-DfsrConfigurationFromAD` cmdlet, or the **Dfsrdiag PollAD** command.

### Is it possible to configure a quiet time between replications for files that change frequently?

No. If the schedule is open, DFS Replication will replicate changes as it notices them. There is no way to configure a quiet time for files.

### Is it possible to configure one-way replication with DFS Replication?

Yes. If you are using Windows Server 2012 or Windows Server 2008 R2, you can create a read-only replicated folder that replicates content through a one-way connection. For more information, see [Make a Replicated Folder Read-Only on a Particular Member](http://go.microsoft.com/fwlink/?linkid=156740) (http://go.microsoft.com/fwlink/?LinkId=156740).

We do not support creating a one-way replication connection with DFS Replication in Windows Server 2008 or Windows Server 2003 R2. Doing so can cause numerous problems including health-check topology errors, staging issues, and problems with the DFS Replication database.

If you are using Windows Server 2008 or Windows Server 2003 R2, you can simulate a one-way connection by performing the following actions:

  - Train administrators to make changes only on the server(s) that you want to designate as primary servers. Then let the changes replicate to the destination servers.  
      
  - Configure the share permissions on the destination servers so that end users do not have Write permissions. If no changes are allowed on the branch servers, then there is nothing to replicate back, simulating a one-way connection and keeping WAN utilization low.  
      

### Is there a way to force a complete replication of all files including unchanged files?

No. If DFS Replication considers the files identical, it will not replicate them. If changed files have not been replicated, DFS Replication will automatically replicate them when configured to do so. To overwrite the configured schedule, use the WMI method **ForceReplicate()**. However, this is only a schedule override, and it does not force replication of unchanged or identical files.

### What happens if the primary member suffers a database loss during initial replication?

During initial replication, the primary member's files will always take precedence in the conflict resolution that occurs if the receiving members have different versions of files on the primary member. The primary member designation is stored in Active Directory Domain Services, and the designation is cleared after the primary member is ready to replicate, but before all members of the replication group replicate.

If the initial replication fails or the DFS Replication service restarts during the replication, the primary member sees the primary member designation in the local DFS Replication database and retries the initial replication. If the primary member's DFS Replication database is lost after clearing the primary designation in Active Directory Domain Services, but before all members of the replication group complete the initial replication, all members of the replication group fail to replicate the folder because no server is designated as the primary member. If this happens, use the **Dfsradmin membership /set /isprimary:true** command on the primary member server to restore the primary member designation manually.

For more information about initial replication, see [Create a Replication Group](https://technet.microsoft.com/library/cc725893).


> [!WARNING]
> The primary member designation is used only during the initial replication process. If you use the <STRONG>Dfsradmin</STRONG> command to specify a primary member for a replicated folder after replication is complete, DFS Replication does not designate the server as a primary member in Active Directory Domain Services. However, if the DFS Replication database on the server subsequently suffers irreversible corruption or data loss, the server attempts to perform an initial replication as the primary member instead of recovering its data from another member of the replication group. Essentially, the server becomes a rogue primary server, which can cause conflicts. For this reason, specify the primary member manually only if you are certain that the initial replication has irretrievably failed. 
<br>


### What happens if the replication schedule closes while a file is being replicated?

If remote differential compression (RDC) is enabled on the connection, inbound replication of a file larger than 64 KB that began replicating immediately prior to the schedule closing (or changing to **No bandwidth**) continues when the schedule opens (or changes to something other than **No bandwidth**). The replication continues from the state it was in when replication stopped.

If RDC is turned off, DFS Replication completely restarts the file transfer. This can delay when the file is available on the receiving member.

### What happens when two users simultaneously update the same file on different servers?

When DFS Replication detects a conflict, it uses the version of the file that was saved last. It moves the other file into the DfsrPrivate\\ConflictandDeleted folder (under the local path of the replicated folder on the computer that resolved the conflict). It remains there until Conflict and Deleted folder cleanup, which occurs when the Conflict and Deleted folder exceeds the configured size or DFS Replication encounters an Out of disk space error. The Conflict and Deleted folder is not replicated, and this method of conflict resolution avoids the problem of morphed directories that was possible in FRS.

When a conflict occurs, DFS Replication logs an informational event to the DFS Replication event log. This event does not require user action for the following reasons:

  - It is not visible to users (it is visible only to server administrators).  
      
  - DFS Replication treats the Conflict and Deleted folder as a cache. When a quota threshold is reached, it cleans out some of those files. There is no guarantee that conflicting files will be saved.  
      
  - The conflict could reside on a server different from the origin of the conflict.  
      

## Staging

### Does DFS Replication continue staging files when replication is disabled by a schedule or bandwidth throttling quota, or when a connection is manually disabled?

No. DFS Replication does not continue to stage files outside of scheduled replication times, if the bandwidth throttling quota has been exceeded, or when connections are disabled.

### Does DFS Replication prevent other applications from accessing a file during staging?

No. DFS Replication opens files in a way that does not block users or applications from opening files in the replication folder. This method is known as "opportunistic locking."

### Is it possible to change the location of the staging folder with the DFS Management Tool?

Yes. The staging folder location is configured on the **Advanced** tab of the **Properties** dialog box for each member of a replication group.

### When are files staged?

Files are staged on the sending member when the receiving member requests the file (unless the file is 64 KB or smaller) as shown in the following table. If Remote Differential Compression (RDC) is disabled on the connection, the file is staged unless it is 256 KB or smaller. Files are also staged on the receiving member as they are transferred if they are less than 64 KB in size, although you can configure this setting between 16 KB and 1 MB. If the schedule is closed, files are not staged.

### The minimum file sizes for staging files

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th> </th>
<th>RDC enabled</th>
<th>RDC disabled</th>
</tr>
</thead>
<tbody>
<tr class="even">
<td><p>Sending member</p></td>
<td><p>64 KB</p></td>
<td><p>256 KB</p></td>
</tr>
<tr class="odd">
<td><p>Receiving member</p></td>
<td><p>64 KB by default</p></td>
<td><p>64 KB by default</p></td>
</tr>
</tbody>
</table>

### What happens if a file is changed after it is staged but before it is completely transmitted to the remote site?

If any part of the file is already being transmitted, DFS Replication continues the transmission. If the file is changed before DFS Replication begins transmitting the file, then the newer version of the file is sent.

## Change History


<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th>Date</th>
<th>Description</th>
<th>Reason</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>November 15, 2018</p></td>
<td><p>Updated for Windows Server 2019.</p></td>
<td><p>New operating system.</p></td>
</tr>
<tr class="even">
<td><p>October 9th, 2013</p></td>
<td><p>Updated the What are the supported limits of DFS Replication? section with results from tests on Windows Server 2012 R2.</p></td>
<td><p>Updates for the latest version of Windows Server</p></td>
</tr>
<tr class="odd">
<td><p>January 30th, 2013</p></td>
<td><p>Added the Does DFS Replication continue staging files when replication is disabled by a schedule or bandwidth throttling quota, or when a connection is manually disabled? entry.</p></td>
<td><p>Customer questions</p></td>
</tr>
<tr class="even">
<td><p>October 31st, 2012</p></td>
<td><p>Edited the What are the supported limits of DFS Replication? entry to increase the tested number of replicated files on a volume.</p></td>
<td><p>Customer feedback</p></td>
</tr>
<tr class="odd">
<td><p>August 15, 2012</p></td>
<td><p>Edited the Does DFS Replication replicate NTFS file permissions, alternate data streams, hard links, and reparse points? entry to further clarify how DFS Replication handles hard links and reparse points.</p></td>
<td><p>Feedback from Customer Support Services</p></td>
</tr>
<tr class="even">
<td><p>June 13, 2012</p></td>
<td><p>Edited the Does DFS Replication work on ReFS or FAT volumes? entry to add discussion of ReFS.</p></td>
<td><p>Customer feedback</p></td>
</tr>
<tr class="odd">
<td><p>April 25, 2012</p></td>
<td><p>Edited the Does DFS Replication replicate NTFS file permissions, alternate data streams, hard links, and reparse points? entry to clarify how DFS Replication handles hard links.</p></td>
<td><p>Reduce potential confusion</p></td>
</tr>
<tr class="even">
<td><p>March 30, 2011</p></td>
<td><p>Edited the Can DFS Replication replicate Outlook .pst or Microsoft Office Access database files? entry to correct the potential impact of using DFS Replication with .pst and Access files.</p>
<p>Added How can I improve replication performance?</p></td>
<td><p>Customer questions about the previous entry, which incorrectly indicated that replicating .pst or Access files could corrupt the DFS Replication database.</p></td>
</tr>
<tr class="odd">
<td><p>January 26, 2011</p></td>
<td><p>Added How can files be recovered from the ConflictAndDeleted or PreExisting folders?</p></td>
<td><p>Customer feedback</p></td>
</tr>
<tr class="even">
<td><p>October 20, 2010</p></td>
<td><p>Added How can I upgrade or replace a DFS Replication member?</p></td>
<td><p>Customer feedback</p></td>
</tr>
</tbody>
</table>

