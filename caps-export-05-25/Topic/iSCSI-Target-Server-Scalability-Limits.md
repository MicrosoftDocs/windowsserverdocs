---
title: iSCSI Target Server Scalability Limits
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4478232c-3a9a-4bb8-aeb5-ea1b2fbf24dc
author: JasonGerend
---
# iSCSI Target Server Scalability Limits
This topic provides the supported and tested Microsoft iSCSI Target Server limits on Windows Server 2012 R2 and Windows Server 2012. The following tables display the tested support limits and, where applicable, whether the limits are enforced.  
  
**General limits**  
  
|Item|Support Limit|Enforced?|Comment|  
|--------|-----------------|-------------|-----------|  
|iSCSI target instances per iSCSI Target Server|256|No||  
|iSCSI logical units \(LUs\) or virtual disks per iSCSI Target Server|512|No|Testing configurations included: 8 LUs per target instance with an average over 64 targets, and 256 target instances with one LU per target.|  
|iSCSI LUs or virtual disks per iSCSI target instance|256 \(128 on Windows Server 2012\)|Yes||  
|Sessions that can simultaneously connect to an iSCSI target instance|544 \(512 on Windows Server 2012\)|Yes||  
|Snapshots per LU|512|Yes|There is a limit of 512 snapshots per independent iSCSI application volume.|  
|Locally mounted virtual disks or snapshots per storage appliance|32|Yes|Locally mounted virtual disks don't offer any iSCSI\-specific functionality, and  are deprecated \- for more info, see [Features Removed or Deprecated in Windows Server 2012 R2](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012-R2.md).|  
  
**Fault Tolerance limits**  
  
|Item|Support Limit|Enforced?|Comment|  
|--------|-----------------|-------------|-----------|  
|Failover cluster nodes|8 \(5 on Windows Server 2012\)|No||  
|Multiple active cluster nodes|Supported|N\/A|Each active node in the failover cluster owns a different iSCSI Target Server clustered instance with other nodes acting as possible owner nodes.|  
|Error recovery level \(ERL\)|0|Yes||  
|Connections per session|1|Yes||  
|Sessions that can simultaneously connect to an iSCSI target instance|544 \(512 on Windows Server 2012\)|No||  
|Multipath Input\/Output \(MPIO\)|Supported|N\/A||  
|MPIO paths|4|No||  
|Converting a stand\-alone iSCSI Target Server to a clustered iSCSI Target Server or vice versa|Not supported|No|The iSCSI Target instance and virtual disk configuration data, including snapshot metadata, is lost during conversion.|  
  
**Network limits**  
  
|Item|Support Limit|Enforced?|Comment|  
|--------|-----------------|-------------|-----------|  
|Maximum number of active network adapters|8|No|Applies to network adapters that are dedicated to iSCSI traffic, rather than the total number of network adapters in the appliance.|  
|Portal \(IP addresses\) supported|64|Yes||  
|Network port speed|1Gbps, 10 Gbps, 40Gbps, 56 Gbps \(Windows Server 2012 R2 only\)|No||  
|IPv4|Supported|N\/A||  
|IPv6|Supported|N\/A||  
|TCP offload|Supported|N\/A|Leverage Large Send \(segmentation\), checksum, interrupt moderation, and RSS offload|  
|iSCSI offload|Not supported|N\/A||  
|Jumbo frames|Supported|N\/A||  
|IPSec|Supported|N\/A||  
|CRC offload|Supported|N\/A||  
  
**iSCSI virtual disk limits**  
  
|Item|Support limit|Enforced?|Comment|  
|--------|-----------------|-------------|-----------|  
|From an iSCSI initiator converting the virtual disk from a basic disk to a dynamic disk|Yes|No||  
|Virtual hard disk format|.vhdx \(Windows Server 2012 R2 only\)<br /><br />.vhd|||  
|VHD minimum format size|.vhdx: 3 MB<br /><br />.vhd: 8 MB|Yes|Applies to all supported VHD types: parent, differencing, and fixed.|  
|Parent VHD max size|.vhdx: 64 TB<br /><br />.vhd: 2 TB|Yes||  
|Fixed VHD max size|.vhdx: 64 TB<br /><br />.vhd: 16 TB|Yes||  
|Differencing VHD max size|.vhdx: 64 TB<br /><br />.vhd: 2 TB|Yes||  
|VHD fixed format|Supported|No||  
|VHD differencing format|Supported|No|Snapshots cannot be taken of differencing VHD\-based iSCSI virtual disks.|  
|Number of differencing VHDs per parent VHD|256|No \(Yes on Windows Server 2012\)|Two levels of depth \(grandchildren .vhdx files\) is the maximum for .vhdx files; one level of depth \(child .vhd files\) is the maximum for .vhd files.|  
|VHD dynamic format|.vhdx: Yes<br /><br />.vhd: Yes \(No on Windows Server 2012\)|Yes|Unmap isn't supported.|  
|exFAT\/FAT32\/FAT \(hosting volume of the VHD\)|Not supported|Yes||  
|CSV v2|Not supported|Yes||  
|ReFS|Supported|N\/A||  
|NTFS|Supported|N\/A||  
|Non\-Microsoft CFS|Not supported|Yes||  
|Thin provisioning|No|N\/A|Dynamic VHDs are supported, but Unmap isn't supported.|  
|Logical Unit shrink|Yes \(Windows Server 2012 R2 only\)|N\/A|Use [Resize\-iSCSIVirtualDisk](http://technet.microsoft.com/library/dn448369.aspx) to shrink a LUN.|  
|Logical Unit cloning|Not supported|N\/A|You can rapidly clone disk data by using differencing VHDs.|  
  
**Snapshot limits**  
  
|Item|Support limit|Comment|  
|--------|-----------------|-----------|  
|Snapshot create|Supported||  
|Snapshot restore|Supported||  
|Writable snapshots|Not supported||  
|Snapshot – convert to full|Not supported||  
|Snapshot – online rollback|Not supported||  
|Snapshot – convert to writable|Not supported||  
|Snapshot \- redirection|Not supported||  
|Snapshot \- pinning|Not supported||  
|Local mount|Supported|Locally mounted iSCSI virtual disks are deprecated \- for more info, see [Features Removed or Deprecated in Windows Server 2012 R2](../Topic/Features-Removed-or-Deprecated-in-Windows-Server-2012-R2.md). Dynamic disk snapshots cannot be locally mounted.|  
  
**iSCSI Target Server manageability and backup**  
  
If you want to create volume shadow copies \(VSS open\-file snapshots\) of data on iSCSI virtual disks from an application server,  or you want to manage iSCSI virtual disks with an older app \(such as the Diskraid command\) that requires a Virtual Disk Service \(VDS\) hardware provider, install the iSCSI Target Storage Provider on the server from which you want to take a snapshot or use a VDS management app.  
  
The iSCSI Target Storage Provider is a role service in Windows Server 2012 R2 and Windows Server 2012;  you can also download and install [iSCSI Target Storage Providers \(VDS\/VSS\) for down\-level application servers](http://www.microsoft.com/en-us/download/details.aspx?id=34759) on the following operating systems as long as the iSCSI Target Server is running on Windows Server 2012:  
  
-   Windows Storage Server 2008 R2  
  
-   Windows Server 2008 R2  
  
-   Windows HPC Server 2008 R2  
  
-   Windows HPC Server 2008  
  
Note that if the iSCSI Target Server is hosted by a server running Windows Server 2012 R2 and you want to use VSS or VDS from a remote server, the remote server has to also run Windows Server 2012 R2 and have the iSCSI Target Storage Provider role service installed. Also note that on all versions of Windows you should install only one version of the iSCSI Target Storage Provider role service.  
  
For more info about the iSCSI Target Storage Provider, see [iSCSI Target Storage \(VDS\/VSS\) Provider](http://blogs.technet.com/b/filecab/archive/2012/10/08/iscsi-target-storage-vds-vss-provider.aspx).  
  
**Tested compatibility with iSCSI initiators**  
  
We've tested the iSCSI Target Server software with the following iSCSI initiators:  
  
|||||  
|-|-|-|-|  
|Initiator|Windows Server 2012 R2|Windows Server 2012|Comments|  
|Windows Server 2012 R2|Validated|||  
|Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows Server 2003|Validated|Validated||  
|VMWare vSphere 5||Validated||  
|VMWare ESXi 5.0|Validated|||  
|VMWare ESX 4.1|Validated|||  
|CentOS 6.x|Validated||Must log out a session and log back in to detect a resized virtual disk.|  
|Red Hat Enterprise Linux 6|Validated|||  
|RedHat Enterprise Linux 5 and 5|Validated|Validated||  
|SUSE Linux Enterprise Server 10||Validated||  
|Oracle Solaris 11.x|Validated|||  
  
We've also tested the following iSCSI initiators performing a diskless boot from  virtual disks hosted by iSCSI Target Server:  
  
-   Windows Server 2012 R2  
  
-   Windows Server 2012  
  
-   PCIe NIC with iPXE  
  
-   CD or USB disk with iPXE  
  
## See also  
The following list provides additional resources about iSCSI Target Server and related technologies.  
  
-   [iSCSI Target Block Storage Overview](http://technet.microsoft.com/library/hh848272.aspx)  
  
-   [iSCSI Target Boot Overview](http://technet.microsoft.com/library/hh848273.aspx)  
  
-   [File and Storage Services](http://technet.microsoft.com/library/hh831487.aspx)  
  
