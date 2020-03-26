---
title: "Before You Install Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8d0893bd-e2b7-4494-9537-02b1cbbcd57a
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Before You Install Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_BeforeYouBegin"></a> Before you begin your installation of  Windows Server Essentials, perform the following tasks:  

-   **Ensure that your computer meets the minimum hardware requirements**. This includes determining if you need additional hardware and verifying that the drivers for your hardware are supported by  Windows Server Essentials. For more information, see [System Requirements for Windows Server Essentials](../get-started/system-requirements.md).   

> [!IMPORTANT]
> Before you install  Windows Server Essentials on a pre-existing computer, we recommend that you fully format and then repartition the hard disks of the pre-existing computer. By formatting and repartitioning the hard disks, you remove the possibility that hidden partitions remain on the hard disks.  

- **Prepare your network** To prepare your network to install  Windows Server Essentials, do the following:  


  - **Upgrade operating system on your client computers**  Windows Server Essentials supports the following operating systems:  Windows 8, Windows 7, Windows 10, and Macintosh OS X Lion or greater. These operating systems provide the necessary security features, reliability, performance, and functionality for the local network.  

  - **Configure your router** Verify that your router is configured as follows:  

    -   The UPnP framework is enabled on your router.  

    -   The Dynamic Host Configuration Protocol (DHCP) Server service for the LAN can be enabled or disabled.  Windows Server Essentials ensures that DHCP is not running on both the server and the router ? when DHCP is enabled on the router, DHCP is not enabled on the server during installation.  

    -   You have an IP address for the external interface of your router, which is supplied by your Internet service provider (ISP). The IP address can be dynamically assigned by the DHCP Server service at your ISP, or you must manually configure a static IP address by using the router management console.  

    -   If your Internet connection requires a user name and password, also called Point-to-Point Protocol over Ethernet (PPPoE), these settings are configured on your router, even if the device supports the UPnP framework.  

    -   The router is connected to the LAN and the Internet, it is turned on, and it is functioning properly.  

    If your router does not support the UPnP framework, or if your router cannot be configured during installation, you must manually configure it with the settings for your network. Ensure that the following ports are open and are directed to the IP address of the Destination Server:  

  |Port Number|Application|  
  |-----------------|-----------------|  
  |Port 80|HTTP Web traffic|  
  |Port 443|HTTPS Web traffic|  


- **Read the  Windows Server Essentials release documentation**. The release documentation contains the latest information that may be critical to properly installing and configuring  Windows Server Essentials. To view or print release documentation, see [Release Documentation for Windows Server Essentials](../get-started/release-notes.md).  

## See also  

-   [Install Windows Server Essentials](Install-Windows-Server-Essentials.md)

