---
ms.assetid: 134840f3-c416-4a10-ad73-ef7855b206f7
title: iSCSI target boot overview
ms.prod: windows-server
ms.technology: storage-iscsi
ms.topic: article
author: JasonGerend
manager: dougkim
ms.author: jgerend
ms.date: 09/11/2018
---
# iSCSI target boot overview

> Applies to: Windows Server 2016

iSCSI Target Server in Windows Server can boot hundreds of computers from a single operating system image that is stored in a centralized location. This improves efficiency, manageability, availability, and security.  
  
## <a name="BKMK_OVER"></a>Feature description  
By using differencing virtual hard disks \(VHDs\), you can use a single operating system image \(the "master image"\) to boot up to 256 computers. As an example, let's assume that you deployed  Windows Server with an operating system image of approximately 20 GB, and you used two mirrored disk drives to act as the boot volume. You would have needed approximately 10 TB of storage for only the operating system image to boot 256 computers. With iSCSI Target Server, you will use 40 GB for the operating system base image, and 2 GB for differencing virtual hard disks per server instance, totaling 552 GB for the operating system images. This provides a savings of over 90% on storage for the operating system images alone.  
  
## <a name="BKMK_APP"></a>Practical applications  
Using a controlled operating system image provides the following benefits:  
  
**More secure and easier to manage.** Some enterprises require that data be secured by physically locking storage in a centralized location. In this scenario, servers access the data remotely, including the operating system image. With iSCSI Target Server, administrators can centrally manage the operating system boot images, and control which applications to use for the master image.  
  
**Rapid deployment.** Because the master image is prepared by using Sysprep, when computers boot from the master image, they skip the file copying and installation phase that occurs during Windows Setup, and they go straight to the customization phase. In Microsoft internal testing, 256 computers were deployed in 34 minutes.  
  
**Fast recovery.** Because the operating system images are hosted on the computer running iSCSI Target Server, if a diskless client needs to be replaced, the new computer can point to the operating system image, and boot up immediately.  
  
> [!NOTE]  
> Various vendors provide a storage area network \(SAN\) boot solution, which can be used by the iSCSI Target Server in Windows Server on commodity hardware.  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
iSCSI Target Server does not require special hardware for functional verification. In data centers with large\-scale deployments, the design should be validated against specific hardware. For reference, Microsoft internal testing indicated that a 256 computer deployment required 24x15k\-RPM  disks in a RAID 10 configuration for storage. A network bandwidth of 10 GB is optimal. A general estimate is 60 iSCSI boot servers per 1 GB network adapter.  
  
A network adapter is not required for this scenario, and a software boot loader can be used \(such as iPXE open source boot firmware\).  
  
## <a name="BKMK_SOFT"></a>Software requirements  
iSCSI Target Server can be installed as part of the File and iSCSI Services role service in Server Manager.

> [!NOTE]
> Booting Nano Server from iSCSI (either from the Windows iSCSI Target Server, or a 3rd party target implementation) is not supported.

## See also
* [iSCSI Target Server](https://technet.microsoft.com/library/hh848272(v=ws.11).aspx)
* [iSCSI initiator cmdlets](https://technet.microsoft.com/library/hh826099(v=wps.640).aspx)
* [iSCSI Target Server cmdlets](https://technet.microsoft.com/library/jj612803(v=wps.630).aspx)