---
title: Supporting Information Workers with Reliable File Services and Storage
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4eb93f5b-7266-4d6d-bec1-4e448fdbed5f
---
# Supporting Information Workers with Reliable File Services and Storage
One of the major goals of IT professionals is to support information workers who use client applications such as a word processor to work on files that are stored on file shares. Information workers require high levels of availability and performance from the servers that store their files. IT professionals also require those servers to be cost\-effective, manageable, and built with security in mind.  
  
A collection of features have been improved or added to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] in response to the needs of information workers and the IT professionals who support them. At a high level, most of these features fall within the following three categories.  
  
-   [Availability and Performance](#BKMK_Availability)  
  
-   [Cost Effectiveness](#BKMK_Cost)  
  
-   [Security and Manageability](#BKMK_Security)  
  
## <a name="BKMK_Availability"></a>Availability and Performance  
In response to customer requests, we made availability a top priority as we were planning for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
### Always Offline mode  
In [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], administrators can configure the experience for users of Offline Files to always work offline, even when they are connected through a high\-speed network connection. Windows updates files in the Offline Files cache by synchronizing hourly in the background, by default. This addresses a customer concern with Offline Files where users would transition between the Online and Offline modes, depending on network availability and conditions, even when the Slow\-Link mode \(also known as the Slow Connection mode\) was enabled and set to a 1 millisecond latency threshold.  
  
For more information, see [Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md).  
  
### Cluster\-Aware Updating for minimal downtime  
Existing server updating tools are oriented toward standalone servers. Using these tools on clustered servers can be laborious and error\-prone, and can result in unintended downtime during necessary update maintenance. The Cluster\-Aware Updating \(CAU\) feature provides you with options for performing planned updates on server nodes in a failover cluster with minimal downtime and administrative overhead.  
  
For more information, see [Updating Failover Clusters While Maintaining Availability with Cluster\-Aware Updating: scenario overview](assetId:///a8e6dfbb-9d98-4130-86ac-9f6f00241e02).  
  
### SMB and NFS v3 Transparent Failover  
Transparent Failover is a technology that allows file servers to fail over to another node in the cluster in a way that is completely transparent to applications that have files open on SMB or NFS v3 file shares on the failed server node. The delay for application file\-requests might be only a few seconds, while the operations are transferred to the next node in the cluster. When combined with CAU, Transparent Failover takes care of both planned maintenance and unplanned failures with minimal impact.  
  
For more information, see [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md).  
  
### Chkdsk improvements  
In the past, file system corruptions could result in unexpected downtime while Chkdsk scanned the volume and corrected these corruptions, with the downtime proportional to the number of files on the volume.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a new NTFS health model and approach to Chkdsk, reducing surprises, putting the user in control, and making computers more available and scalable. Detection of file system corruptions occurs online, while the correction of these errors happens in a small number of seconds, while offline. The design goal for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is to enable administrators to confidently deploy large volumes, including 64 TB volumes, without concern for availability or scalability.  
  
### Storage Spaces and Storage Pools  
Storage Spaces enables you to virtualize storage by grouping cost\-effective industry\-standard disks into storage pools, and then create storage spaces \(referred to as *virtual disks* in Server Manager\) from the available capacity in the storage pools.  
  
Storage Spaces helps you increase the availability of business\-critical data in a cost\-efficient way, regardless of whether you work in a large enterprise, a hosting company, or a small business. Storage Spaces reduces administration costs by decreasing the time administrators spend provisioning storage. It also simplifies administration tasks, enabling administrators who are not storage professionals to set up and manage resilient and high availability storage. Storage Spaces also saves hardware costs by enabling the use of industry\-standard disks for resilient storage up to multiple petabytes in size, with high availability.  
  
For more information, see [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md).  
  
### SMB Directory Leasing  
For branch office users connecting over WAN networks with high latencies, reducing the number of round\-trips between a client and a server dramatically improves application response times. Directory Leasing is an enhancement to the existing SMB protocol that reduces the number of round\-trips between client and server.  
  
With Directory Leasing, client computers request a lease lock on directory information \(which contains the file metadata\), enabling Windows to cache the information for longer periods. Because many end\-user applications access file metadata frequently, caching it for longer periods reduces the round\-trips that a client has to wait for, improving the application response time.  
  
For more information, see [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md).  
  
## <a name="BKMK_Cost"></a>Cost Effectiveness  
We recognize that cost effectiveness is one of your top priorities, closely rivaling availability.  
  
### Thin provisioning of storage  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] identifies thinly\-provisioned *virtual disks* \(not to be confused with virtual hard disks or VHDs\) created in a storage pool and enables transparent reclamation of capacity when files are deleted. This improves capacity utilization when used with the Storage Spaces subsystem or a third\-party storage subsystem  
  
Sophisticated applications can identify thinly provisioned disks by using Windows Management Instrumentation \(WMI\) or Windows PowerShell, and can invoke commands to reclaim capacity from deleted files as appropriate. Applications are notified via standard Windows events whenever the available capacity in the underlying storage pool for a thinly\-provisioned virtual disk falls below the specified threshold, enabling the applications to take action.  
  
To reclaim unused capacity on thinly provisioned virtual disks and perform other optimization tasks, the new Storage Optimizer runs automatically on a periodic basis. Together, these enhancements enable administrators to separate deployment requirements from purchasing decisions and to offload the burden of accurately predicting future storage capacity requirements.  
  
For more information, see [Thin Provisioning and Trim Storage Technical Preview](assetId:///10062089-3259-4d7e-8605-f7abc57fd06f).  
  
### Data Deduplication  
By using the new Data Deduplication role service to reduce the number of duplicate blocks of data in storage, you can store much more data in a given amount of storage capacity than was previously possible using Single Instance Storage \(SIS\) or NTFS file system compression. General purpose file servers can typically reduce storage capacity utilization by a 2:1 ratio \(for example, files that previously used 1 TB would use 500 GB after deduplication\). Servers that host virtualization data \(such as VHD files\) often reduce storage capacity utilization by a 20:1 ratio, which reduces 1 TB of data to 50 GB. Data deduplication has minimal CPU and memory overhead and maintains a high level of data integrity.  
  
For more information, see [Data Deduplication Overview](../Topic/Data-Deduplication-Overview.md).  
  
### BranchCache for Network Files version 2  
The BranchCache for Network Files role service in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] uses the same technology as the Data Deduplication role service to reduce duplicate data replicated over WAN connections. As a result, the BranchCache in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] can further reduce WAN costs, and improve application response times for branch office users.  
  
### Enhanced support for low cost SATA disks  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] features enhanced support for low\-cost SATA disks. This enhancement decreases the possibility of metadata inconsistency due to unexpected power loss on commodity hard disks while enabling the disk to cache associated data as long as safely possible. This enables customers to more reliably utilize cost\-effective SATA drives in enterprise deployments.  
  
### Access\-denied assistance  
In the past, when users are denied access to a file or folder, typically on a file share, users received little help with troubleshooting the issue. Often times, the solution was to determine the owner of the file share and then send the owner an email asking for access. In other instances, users would call the help desk or give up.  
  
With Access\-denied assistance, file server administrators can provide users with a customized access\-denied message, including troubleshooting information and the ability to request assistance via email. Upon receiving the email requesting assistance, the designated owner of the folder can look at the details provided by Windows to help determine why the user was denied access and then take the appropriate action.  
  
Access\-denied assistance can reduce support costs by enabling server administrators to provide users with the means to help themselves solve access\-denied issues and obtain assistance directly from the folder owners when they need additional help.  
  
For more information, see [Access\-denied assistance](assetId:///d53c603e-6217-4b98-8508-e8e492d16083#BKMK_5).  
  
## <a name="BKMK_Security"></a>Security and Manageability  
  
### Primary Computers support for Folder Redirection and Roaming User Profiles  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can designate a set of computers, known as primary computers, for each domain user, which enables you to control which computers use Folder Redirection, Roaming User Profiles, or both. For example, the administrator can choose to roam user data and settings between a user’s desktop and laptop, and to not roam the information when that user logs on to any other computer, such as a conference room computer. Designating primary computers is a simple and powerful method to associate user data and settings with particular computers or devices, simplify administrator oversight, improve data security, and help protect user profiles from corruption.  
  
For more information, see [Folder Redirection, Offline Files, and Roaming User Profiles overview](../Topic/Folder-Redirection,-Offline-Files,-and-Roaming-User-Profiles-overview.md).  
  
### SMB Encryption  
A security concern that comes up with data traversing untrusted networks is that it is prone to eavesdropping attacks. Existing solutions to the problem typically use IPsec, WAN accelerators, or other dedicated hardware solutions. However, these solutions are expensive to setup and maintain.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes encryption built\-in to the SMB protocol. This allows end to end data protection from snooping attacks with no additional deployment costs. You have the flexibility to decide whether the entire server or only specific shares should be enabled for encryption. SMB encryption is also relevant to server application workloads if the application data is on a file server and traverses untrusted networks. With this feature, data security is maintained while it is on the wire.  
  
For more information, see [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md).  
  
### File Classification Infrastructure and Dynamic Access Control  
Data governance, data retention, and regulatory compliance are responsible for a significant portion of IT budgets. Dynamic access control and the File Classification Infrastructure technologies included in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provide new ways to classify data, control access to data, and achieve regulatory compliance. It provides sophisticated authorization and auditing controls, along with data classification capabilities that enable organizations to apply information governance to unstructured data on their file servers. You now have greater control over file server data, a conditional expression ACL model, centralized authorization and auditing policy management, and business\-driven data.  
  
For more information, see [What's New in File Server Resource Manager in Windows Server 2012 \[redirected\]](assetId:///d53c603e-6217-4b98-8508-e8e492d16083).  
  
### Unified remote management of File and Storage Services in Server Manager  
The File and Storage Services role in Server Manager enables you to remotely manage multiple file servers, including their role services and storage, all from a single window.  
  
This functionality is built on top of a Windows Management Instrumentation \(WMI\) and Windows PowerShell infrastructure. As a result, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes Windows PowerShell cmdlets for performing the majority of administration tasks for file and storage servers, simplifying the task of automating common tasks.  
  
For more information, see [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md).  
  
### Improved management of Folder Redirection, Offline Files, and Roaming User Profiles  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes improved WMI interfaces for Folder Redirection, Offline Files, and Roaming User Profiles, making it easier for independent software vendors \(ISVs\) that deliver management suites to integrate managing, monitoring, and troubleshooting these technologies into their existing management tools.  
  
## See Also  
[File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)  
[Scale-Out File Server for Application Data Overview_1](../Topic/Scale-Out-File-Server-for-Application-Data-Overview_1.md)  
  
