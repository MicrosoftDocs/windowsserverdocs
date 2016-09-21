---
title: "Before You Install Windows Server 2012 Essentials"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2016 Essentials
ms.assetid: 8d0893bd-e2b7-4494-9537-02b1cbbcd57a
caps.latest.revision: 13
author: coreyp-at-msft
ms.author: coreyp

---
# Before You Install Windows Server 2012 Essentials
##  <a name="BKMK_BeforeYouBegin"></a> Before you begin your installation of  Windows Server 2012 Essentials, perform the following tasks:  
  
-   **Read the  Windows Server 2012 Essentials FAQs and Evaluation Guide**. To view and print the FAQs, see [Windows Server 2012 Essentials Frequently Asked Questions](http://download.microsoft.com/download/0/B/2/0B22F531-338D-4843-B43B-814D922EB724/Windows-Server-2012-Essentials-FAQ.pdf). To view and print the Evaluation Guide, visit the **Start Here** section of the [Windows Server 2012 Essentials Evaluation Resources](http://technet.microsoft.com/evalcenter/jj659308.aspx) page.  
  

-   **Ensure that your computer meets the minimum hardware requirements**. This includes determining if you need additional hardware and verifying that the drivers for your hardware are supported by  Windows Server 2012 Essentials. For more information, see [System Requirements for Windows Server 2012 Essentials](System-Requirements-for-Windows-Server-2012-Essentials.md).  

-   **Ensure that your computer meets the minimum hardware requirements**. This includes determining if you need additional hardware and verifying that the drivers for your hardware are supported by  Windows Server 2012 Essentials. For more information, see [System Requirements for Windows Server 2012 Essentials](../install/System-Requirements-for-Windows-Server-2012-Essentials.md).  

  
    > [!IMPORTANT]
    >  Before you install  Windows Server 2012 Essentials on a pre-existing computer, we recommend that you fully format and then repartition the hard disks of the pre-existing computer. By formatting and repartitioning the hard disks, you remove the possibility that hidden partitions remain on the hard disks.  
  
-   **Prepare your network** To prepare your network to install  Windows Server 2012 Essentials, do the following:  
  
    -   Find a suitable place to put your server before you run  Windows Server 2012 Essentials Setup. The location you choose must have an available, wired network connection to your broadband router or to a switch that is connected to your broadband router as shown in the diagram. Verify that the broadband router and switch, if used, are powered on and functioning properly. Then connect your server to an electrical outlet.  
  

         ![Network Diagram](media/strt_WHS_NetworkOverviewc_new.gif "strt_WHS_NetworkOverviewc_new")  

         ![Network Diagram](../install/media/strt_WHS_NetworkOverviewc_new.gif "strt_WHS_NetworkOverviewc_new")  

  
    -   **Upgrade operating system on your client computers**  Windows Server 2012 Essentials supports the following operating systems:  Windows 8, Windows 7, and Macintosh OS X Lion or greater. These operating systems provide the necessary security features, reliability, performance, and functionality for the local network.  
  
    -   **Configure your router** Verify that your router is configured as follows:  
  
        -   The UPnP framework is enabled on your router.  
  
        -   The Dynamic Host Configuration Protocol (DHCP) Server service for the LAN can be enabled or disabled.  Windows Server 2012 Essentials ensures that DHCP is not running on both the server and the router— when DHCP is enabled on the router, DHCP is not enabled on the server during installation.  
  
        -   You have an IP address for the external interface of your router, which is supplied by your Internet service provider (ISP). The IP address can be dynamically assigned by the DHCP Server service at your ISP, or you must manually configure a static IP address by using the router management console.  
  
        -   If your Internet connection requires a user name and password, also called Point-to-Point Protocol over Ethernet (PPPoE), these settings are configured on your router, even if the device supports the UPnP framework.  
  
        -   The router is connected to the LAN and the Internet, it is turned on, and it is functioning properly.  
  
     If your router does not support the UPnP framework, or if your router cannot be configured during installation, you must manually configure it with the settings for your network. Ensure that the following ports are open and are directed to the IP address of the Destination Server:  
  
    |Port Number|Application|  
    |-----------------|-----------------|  
    |Port 80|HTTP Web traffic|  
    |Port 443|HTTPS Web traffic|  
  

-   **Read the  Windows Server 2012 Essentials release documentation**. The release documentation contains the latest information that may be critical to properly installing and configuring  Windows Server 2012 Essentials. To view or print release documentation, see [Release Documentation for Windows Server 2012 Essentials](Release-Documentation-for-Windows-Server-2012-Essentials.md).  
  
## See also  
  
-   [Install Windows Server Essentials](Install-Windows-Server-Essentials.md)

-   **Read the  Windows Server 2012 Essentials release documentation**. The release documentation contains the latest information that may be critical to properly installing and configuring  Windows Server 2012 Essentials. To view or print release documentation, see [Release Documentation for Windows Server 2012 Essentials](../install/Release-Documentation-for-Windows-Server-2012-Essentials.md).  
  
## See also  
  
-   [Install Windows Server Essentials](../install/Install-Windows-Server-Essentials.md)

