---
title: iSCSI Target Server Overview
TOCTitle: iSCSI Target Server
ms.prod: windows-server
ms.technology: storage-iscsi
ms.topic: article
author: JasonGerend
manager: dougkim
ms.author: jgerend
ms.date: 09/11/2018
---

# iSCSI Target Server overview

Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic provides a brief overview of iSCSI Target Server, a role service in Windows Server that enables you to make storage available via the iSCSI protocol. This is useful for providing access to storage on your Windows server for clients that can't communicate over the native Windows file sharing protocol, SMB.

iSCSI Target Server is ideal for the following:

* **Network and diskless boot**   By using boot-capable network adapters or a software loader, you can deploy hundreds of diskless servers. With iSCSI Target Server, the deployment is fast. In Microsoft internal testing, 256 computers deployed in 34 minutes. By using differencing virtual hard disks, you can save up to 90% of the storage space that was used for operating system images. This is ideal for large deployments of identical operating system images, such as on virtual machines running Hyper-V or in high-performance computing (HPC) clusters.

* **Server application storage**   Some applications require block storage. iSCSI Target Server can provide these applications with continuously available block storage. Because the storage is remotely accessible, it can also consolidate block storage for central or branch office locations.

* **Heterogeneous storage**   iSCSI Target Server supports non-Microsoft iSCSI initiators, making it easy to share storage on servers in a mixed software environment.

* **Development, test, demonstration, and lab environments**   When iSCSI Target Server is enabled, a computer running the Windows Server operating system becomes a network-accessible block storage device. This is useful for testing applications prior to deployment in a storage area network (SAN).

## Block storage requirements

Enabling iSCSI Target Server to provide block storage leverages your existing Ethernet network. No additional hardware is needed. If high availability is an important criterion, consider setting up a high-availability cluster. You need shared storage for a high-availability cluster—either hardware for Fibre Channel storage or a serial attached SCSI (SAS) storage array.

If you enable guest clustering, you need to provide block storage. Any servers running Windows Server software with iSCSI Target Server can provide block storage.

## See Also

[iSCSI Target Block Storage, How To](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh848268(v%3dws.11))  
[What's New in iSCSI Target Server in Windows Server](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn305893(v%3dws.11))

