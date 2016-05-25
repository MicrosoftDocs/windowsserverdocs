---
title: Windows Offloaded Data Transfers Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 921a54a2-79c5-4cca-8e05-9e79073cd86f
author: JasonGerend
---
# Windows Offloaded Data Transfers Overview
This topic provides an overview of Windows Offloaded Data Transfer \(ODX, also known as copy offload\) in Windows. ODX enables direct data transfers within or between compatible storage devices without transferring the data through the host computer.  
  
**Did you mean…**  
  
-   [Storage Management Overview](assetId:///d8442e86-3b63-44e0-b36c-7981643999f8)  
  
-   [Deploy Windows Offloaded Data Transfers](../Topic/Deploy-Windows-Offloaded-Data-Transfers.md)  
  
## <a name="BKMK_OVER"></a>Feature description  
Windows Offloaded Data Transfer \(ODX\) functionality in Windows maximizes an enterprise’s investment in intelligent storage arrays by enabling the arrays to directly transfer data within or between compatible storage devices, bypassing the host computer.  
  
By offloading the file transfer to the storage array, ODX minimizes latencies, maximizes array throughput, and reduces resource usage such as CPU and network consumption on the host computer. Windows offloads file transfers transparently and automatically when you move or copy files, irrespective of whether you drag\-and\-drop files through [!INCLUDE[win8_explorer](../Token/win8_explorer_md.md)] or use command\-line file copy commands.  
  
## Practical applications  
Some of the applications of ODX include:  
  
-   Rapidly import and export Hyper\-V virtual machines that are stored on an ODX\-capable storage array and accessed via iSCSI, Fibre Channel, or SMB file shares  
  
-   Transfer large files such as database files or video files with increased speed and decreased CPU and network resource consumption on the host server  
  
## Important functionality  
In traditional host\-based file transfers, the data to be transferred must be:  
  
1.  Read from the storage through the source server  
  
2.  Transferred across the network to the destination server  
  
3.  Written back to the storage through the destination server  
  
To eliminate this inefficiency, ODX uses a token\-based mechanism for reading and writing data within or between intelligent storage arrays. Instead of routing the data through the host, a small token is copied between the source server and destination server. The token serves as a point\-in\-time representation of the data. As an example, when you copy a file or migrate a virtual machine between storage locations \(within or between storage arrays\), a token representing the virtual machine file is copied, thereby removing the need to copy the underlying data through the servers.  
  
The following figure explains the steps that are involved with a token\-based copy operation.  
  
![](../Image/1_CopyOffload_Rev_Guide.jpg)  
  
**Figure 1** Token\-based copy operation  
  
This procedure is described in the following steps:  
  
1.  A user copies or moves a file by using Windows Explorer, a command line interface, or as part of a virtual machine migration.  
  
2.  Windows automatically translates this transfer request into an ODX \(if supported by the storage array\), and it receives a token that represents the data.  
  
3.  The token is copied between the source server and destination server.  
  
4.  The token is delivered to the storage array.  
  
5.  The storage array internally performs the copy or move and provides status information to the user.  
  
> [!NOTE]  
> -   In the event of an MPIO path failover, Windows retries the ODX transfer. If this fails, Windows initiates a cluster failover \(when part of a failover cluster\).  
> -   In the event of a cluster failover, if the application is cluster aware Windows resumes the ODX transfer after the failover.  
> -   If Windows cannot resume or restart an ODX transfer after an MPIO path or cluster failover, Windows issues a LUN reset to the storage device, ending all outstanding operations on the LUN. It then returns an IO failure back to the application.  
  
## Hardware requirements  
To use ODX, your storage arrays must meet the following requirements:  
  
-   Must be certified compatible with Windows Offloaded Data Transfer \(ODX\)  
  
-   To support ODX between storage arrays, the copy manager for the storage arrays must support cross\-storage array ODX, and the storage arrays must be from the same vendor  
  
-   Must be connected by using one of the following protocols:  
  
    -   iSCSI  
  
    -   Fibre Channel  
  
    -   Fibre Channel over Ethernet  
  
    -   Serial Attached SCSI \(SAS\)  
  
-   Must use one of the following configurations:  
  
    -   One server with one storage array  
  
    -   One server with two storage arrays  
  
    -   Two servers with one storage array  
  
    -   Two servers with two storage arrays  
  
## Software requirements  
To use ODX, your environment must support the following:  
  
-   The computer initiating the data transfer must be running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], or [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)].  
  
-   File system filter drivers such as antivirus and encryption programs need to opt\-in to ODX. ODX is not supported by the following file system filter drivers:  
  
    -   Data Deduplication  
  
    -   BitLocker Drive Encryption  
  
-   Files must be on an unencrypted basic partition. Storage Spaces and dynamic volumes are not supported.  
  
-   Files must be on a volume formatted using NTFS. ReFS and FAT are not supported. Files can be directly transferred to or from this volume, or from one of the following containers:  
  
    -   A Virtual Hard Disk \(VHD\) that uses the VHD or VHDX formats  
  
    -   A file share that uses the SMB protocol  
  
-   The files must be 256 KB or larger – smaller files are transferred using a traditional \(non\-ODX\) file transfer.  
  
-   The application that performs the data transfer must be written to support ODX. The following currently support ODX:  
  
    -   Hyper\-V management operations that transfer large amounts of data at a time, such as creating a fixed size virtual hard disk \(VHD\), merging snapshot or converting virtual hard disks.  
  
    -   [!INCLUDE[win8_explorer](../Token/win8_explorer_md.md)]  
  
    -   Copy commands in Windows PowerShell  
  
    -   Copy commands in Windows command prompt \(including Robocopy\)  
  
-   Files should not be highly fragmented. Transfers of highly fragmented files will have reduced performance.  
  
## Hyper\-V Requirements  
To use ODX with virtual machines hosted by Hyper\-V, the virtual machines need to access storage from an ODX\-capable storage array. You can achieve this by using any of the following approaches.  
  
-   Store the VHD on an ODX\-capable iSCSI LUN  
  
-   Assign ODX\-capable iSCSI LUNs to the virtual machine's iSCSI initiator  
  
-   Assign ODX\-capable Fibre Channel LUNs to the virtual machine's virtual Fibre Channel adapter  
  
-   Connect the host or virtual machine to an SMB file share on another computer that is hosted on an ODX\-capable storage array  
  
## <a name="BKMK_LINKS"></a>See also  
For more information, see the following resources.  
  
|Content type|References|  
|----------------|--------------|  
|**Deployment**|[Deploy Windows Offloaded Data Transfers](../Topic/Deploy-Windows-Offloaded-Data-Transfers.md)|  
|**Community**|[Is Offloaded Data Transfers \(ODX\) working? \(TechNet Blog\)](http://blogs.technet.com/b/askcore/archive/2014/06/26/is-offloaded-data-transfers-odx-working.aspx)|  
|**API Reference**|HYPERLINK "" [FSCTL\_OFFLOAD\_READ control code](http://msdn.microsoft.com/library/windows/hardware/hh451101.aspx) &#124; [FSCTL\_OFFLOAD\_WRITE control code](http://msdn.microsoft.com/library/windows/hardware/hh451122.aspx) &#124; [T10 SCSI Primary Command Spec \(SPC4r36\)](http://www.t10.org/cgi-bin/ac.pl?t=f&f=spc4r36.pdf) &#124; [Windows 8 Devices Requirements](http://msdn.microsoft.com/library/windows/hardware/hh748188)|  
  
