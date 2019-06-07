---
title: iSCSI Target Server Scalability Limits
TOCTitle: iSCSI Target Server Scalability Limits
ms.prod: windows-server-threshold
ms.technology: storage-iscsi
ms.topic: article
author: JasonGerend
manager: dougkim
ms.author: jgerend
ms.date: 09/11/2018
---

# iSCSI Target Server Scalability Limits

Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic provides the supported and tested Microsoft iSCSI Target Server limits on Windows Server. The following tables display the tested support limits and, where applicable, whether the limits are enforced.

## General limits

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Item</p></th>
<th><p>Support Limit</p></th>
<th><p>Enforced?</p></th>
<th><p>Comment</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>iSCSI target instances per iSCSI Target Server</p></td>
<td><p>256</p></td>
<td><p>No</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>iSCSI logical units (LUs) or virtual disks per iSCSI Target Server</p></td>
<td><p>512</p></td>
<td><p>No</p></td>
<td><p>Testing configurations included: 8 LUs per target instance with an average over 64 targets, and 256 target instances with one LU per target.</p></td>
</tr>
<tr class="odd">
<td><p>iSCSI LUs or virtual disks per iSCSI target instance</p></td>
<td><p>256 (128 on Windows Server 2012)</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Sessions that can simultaneously connect to an iSCSI target instance</p></td>
<td><p>544 (512 on Windows Server 2012)</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Snapshots per LU</p></td>
<td><p>512</p></td>
<td><p>Yes</p></td>
<td><p>There is a limit of 512 snapshots per independent iSCSI application volume.</p></td>
</tr>
<tr class="even">
<td><p>Locally mounted virtual disks or snapshots per storage appliance</p></td>
<td><p>32</p></td>
<td><p>Yes</p></td>
<td><p>Locally mounted virtual disks don&#39;t offer any iSCSI-specific functionality, and are deprecated - for more info, see <a href="https://technet.microsoft.com/library/dn303411.aspx">Features Removed or Deprecated in Windows Server 2012 R2</a>.</p></td>
</tr>
</tbody>
</table>

## Fault Tolerance limits

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Item</p></th>
<th><p>Support Limit</p></th>
<th><p>Enforced?</p></th>
<th><p>Comment</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Failover cluster nodes</p></td>
<td><p>8 (5 on Windows Server 2012)</p></td>
<td><p>No</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Multiple active cluster nodes</p></td>
<td><p>Supported</p></td>
<td> 
<p>N/A</p></td>
<td><p>Each active node in the failover cluster owns a different iSCSI Target Server clustered instance with other nodes acting as possible owner nodes.</p></td>
</tr>
<tr class="odd">
<td><p>Error recovery level (ERL)</p></td>
<td><p>0</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Connections per session</p></td>
<td><p>1</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Sessions that can simultaneously connect to an iSCSI target instance</p></td>
<td><p>544 (512 on Windows Server 2012)</p></td>
<td><p>No</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Multipath Input/Output (MPIO)</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>MPIO paths</p></td>
<td><p>4</p></td>
<td><p>No</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Converting a stand-alone iSCSI Target Server to a clustered iSCSI Target Server or vice versa</p></td>
<td><p>Not supported</p></td>
<td><p>No</p></td>
<td><p>The iSCSI Target instance and virtual disk configuration data, including snapshot metadata, is lost during conversion.</p></td>
</tr>
</tbody>
</table>

## Network limits

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Item</p></th>
<th><p>Support Limit</p></th>
<th><p>Enforced?</p></th>
<th><p>Comment</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Maximum number of active network adapters</p></td>
<td><p>8</p></td>
<td><p>No</p></td>
<td><p>Applies to network adapters that are dedicated to iSCSI traffic, rather than the total number of network adapters in the appliance.</p></td>
</tr>
<tr class="even">
<td><p>Portal (IP addresses) supported</p></td>
<td><p>64</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Network port speed</p></td>
<td><p>1Gbps, 10 Gbps, 40Gbps, 56 Gbps (Windows Server 2012 R2 and newer only)</p></td>
<td><p>No</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>IPv4</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>IPv6</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>TCP offload</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td><p>Leverage Large Send (segmentation), checksum, interrupt moderation, and RSS offload</p></td>
</tr>
<tr class="odd">
<td><p>iSCSI offload</p></td>
<td><p>Not supported</p></td>
<td><br/><p>N/A</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Jumbo frames</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>IPSec</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>CRC offload</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
</tbody>
</table>

## iSCSI virtual disk limits

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Item</p></th>
<th><p>Support limit</p></th>
<th><p>Enforced?</p></th>
<th><p>Comment</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>From an iSCSI initiator converting the virtual disk from a basic disk to a dynamic disk </p></td>
<td><p>Yes</p></td>
<td><p>No</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Virtual hard disk format</p></td>
<td><p>.vhdx (Windows Server 2012 R2 and newer only)</p>
<p>.vhd</p></td>
<td></td>
<td></td>
</tr>
<tr class="odd">
<td><p>VHD minimum format size</p></td>
<td><p>.vhdx: 3 MB</p>
<p>.vhd: 8 MB</p></td>
<td><p>Yes</p></td>
<td><p>Applies to all supported VHD types: parent, differencing, and fixed.</p></td>
</tr>
<tr class="even">
<td><p>Parent VHD max size</p></td>
<td><p>.vhdx: 64 TB</p>
<p>.vhd: 2 TB</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Fixed VHD max size</p></td>
<td><p>.vhdx: 64 TB</p>
<p>.vhd: 16 TB</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Differencing VHD max size</p></td>
<td><p>.vhdx: 64 TB</p>
<p>.vhd: 2 TB</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>VHD fixed format</p></td>
<td><p>Supported</p></td>
<td><p>No</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>VHD differencing format</p></td>
<td><p>Supported</p></td>
<td><p>No</p></td>
<td><p>Snapshots cannot be taken of differencing VHD-based iSCSI virtual disks.</p></td>
</tr>
<tr class="odd">
<td><p>Number of differencing VHDs per parent VHD</p></td>
<td><p>256</p></td>
<td><p>No (Yes on Windows Server 2012)</p></td>
<td><p>Two levels of depth (grandchildren .vhdx files) is the maximum for .vhdx files; one level of depth (child .vhd files) is the maximum for .vhd files.</p></td>
</tr>
<tr class="even">
<td><p>VHD dynamic format</p></td>
<td><p>.vhdx: Yes</p>
<p>.vhd: Yes (No on Windows Server 2012)</p></td>
<td><p>Yes</p></td>
<td><p>Unmap isn&#39;t supported.</p></td>
</tr>
<tr class="odd">
<td><p>exFAT/FAT32/FAT (hosting volume of the VHD)</p></td>
<td><p>Not supported</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>CSV v2</p></td>
<td><p>Not supported</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>ReFS</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>NTFS</p></td>
<td><p>Supported</p></td>
<td><p>N/A</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Non-Microsoft CFS</p></td>
<td><p>Not supported</p></td>
<td><p>Yes</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Thin provisioning</p></td>
<td><p>No</p></td>
<td><p>N/A</p></td>
<td><p>Dynamic VHDs are supported, but Unmap isn&#39;t supported.</p></td>
</tr>
<tr class="odd">
<td><p>Logical Unit shrink</p></td>
<td><p>Yes (Windows Server 2012 R2 and newer only)</p></td>
<td><p>N/A</p></td>
<td><p>Use <a href="https://docs.microsoft.com/powershell/module/iscsitarget/resize-iscsivirtualdisk">Resize-iSCSIVirtualDisk</a> to shrink a LUN.</p></td>
</tr>
<tr class="even">
<td><p>Logical Unit cloning</p></td>
<td><p>Not supported</p></td>
<td><p>N/A</p></td>
<td><p>You can rapidly clone disk data by using differencing VHDs.</p></td>
</tr>
</tbody>
</table>

## Snapshot limits

<table>
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Item</p></th>
<th><p>Support limit</p></th>
<th><p>Comment</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Snapshot create</p></td>
<td><p>Supported</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Snapshot restore</p></td>
<td><p>Supported</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Writable snapshots</p></td>
<td><p>Not supported</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Snapshot – convert to full</p></td>
<td><p>Not supported</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Snapshot – online rollback</p></td>
<td><p>Not supported</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Snapshot – convert to writable</p></td>
<td><p>Not supported</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Snapshot - redirection</p></td>
<td><p>Not supported</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>Snapshot - pinning</p></td>
<td><p>Not supported</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Local mount</p></td>
<td><p>Supported</p></td>
<td><p>Locally mounted iSCSI virtual disks are deprecated - for more info, see <a href="https://technet.microsoft.com/library/dn303411.aspx">Features Removed or Deprecated in Windows Server 2012 R2</a>. Dynamic disk snapshots cannot be locally mounted.</p></td>
</tr>
</tbody>
</table>

## iSCSI Target Server manageability and backup

If you want to create volume shadow copies (VSS open-file snapshots) of data on iSCSI virtual disks from an application server, or you want to manage iSCSI virtual disks with an older app (such as the Diskraid command) that requires a Virtual Disk Service (VDS) hardware provider, install the iSCSI Target Storage Provider on the server from which you want to take a snapshot or use a VDS management app.

The iSCSI Target Storage Provider is a role service in Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012; you can also download and install [iSCSI Target Storage Providers (VDS/VSS) for down-level application servers](http://www.microsoft.com/download/details.aspx?id=34759) on the following operating systems as long as the iSCSI Target Server is running on Windows Server 2012:

  - Windows Storage Server 2008 R2

  - Windows Server 2008 R2

  - Windows HPC Server 2008 R2

  - Windows HPC Server 2008

Note that if the iSCSI Target Server is hosted by a server running Windows Server 2012 R2 or newer and you want to use VSS or VDS from a remote server, the remote server has to also run the same version of Windows Server and have the iSCSI Target Storage Provider role service installed. Also note that on all versions of Windows you should install only one version of the iSCSI Target Storage Provider role service.

For more info about the iSCSI Target Storage Provider, see [iSCSI Target Storage (VDS/VSS) Provider](http://blogs.technet.com/b/filecab/archive/2012/10/08/iscsi-target-storage-vds-vss-provider.aspx).

## Tested compatibility with iSCSI initiators

We've tested the iSCSI Target Server software with the following iSCSI initiators:

<table>
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p>Initiator</p></td>
<td><p>Windows Server 2012 R2</p></td>
<td><p>Windows Server 2012</p></td>
<td><p>Comments</p></td>
</tr>
<tr class="even">
<td><p>Windows Server 2012 R2</p></td>
<td><p>Validated</p></td>
<td></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Windows Server 2012, Windows Server 2008 R2, Windows Server 2008, Windows Server 2003</p></td>
<td><p>Validated</p></td>
<td><p>Validated</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>VMWare vSphere 5</p></td>
<td></td>
<td><p>Validated</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>VMWare ESXi 5.0</p></td>
<td><p>Validated</p></td>
<td></td>
<td></td>
</tr>
<tr class="even">
<td><p>VMWare ESX 4.1</p></td>
<td><p>Validated</p></td>
<td></td>
<td></td>
</tr>
<tr class="odd">
<td><p>CentOS 6.x</p></td>
<td><p>Validated</p></td>
<td></td>
<td><p>Must log out a session and log back in to detect a resized virtual disk.</p></td>
</tr>
<tr class="even">
<td><p>Red Hat Enterprise Linux 6</p></td>
<td><p>Validated</p></td>
<td></td>
<td></td>
</tr>
<tr class="odd">
<td><p>RedHat Enterprise Linux 5 and 5</p></td>
<td><p>Validated</p></td>
<td><p>Validated</p></td>
<td></td>
</tr>
<tr class="even">
<td><p>SUSE Linux Enterprise Server 10</p></td>
<td></td>
<td><p>Validated</p></td>
<td></td>
</tr>
<tr class="odd">
<td><p>Oracle Solaris 11.x</p></td>
<td><p>Validated</p></td>
<td></td>
<td></td>
</tr>
</tbody>
</table>

We've also tested the following iSCSI initiators performing a diskless boot from virtual disks hosted by iSCSI Target Server:

  - Windows Server 2012 R2

  - Windows Server 2012

  - PCIe NIC with iPXE

  - CD or USB disk with iPXE

## See also

The following list provides additional resources about iSCSI Target Server and related technologies.

- [iSCSI Target Block Storage Overview](iscsi-target-server.md)

- [iSCSI Target Boot Overview](iscsi-boot-overview.md)

- [Storage in Windows Server](../storage.md)

