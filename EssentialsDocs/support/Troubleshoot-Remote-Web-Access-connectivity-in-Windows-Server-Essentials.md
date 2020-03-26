---
title: "Troubleshoot Remote Web Access connectivity in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d3642575-b3ee-4488-b654-5bf9d3b8c935
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot Remote Web Access connectivity in Windows Server Essentials
 
>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
  
 Typically, Windows Server Essentials can automatically configure a broadband router if the router is a UPnP certified device and if the UPnP setting is enabled on the router.  
  
## Possible issues  
 You may encounter the following issues with Remote Web Access connectivity:  
  
-   Your router is not turned on or is not connected to your network.  
  
-   The UPnP setting for your router is turned off.  
  
-   Your router may not fully support the UPnP standard. Microsoft maintains a list of routers that work with the Windows operating systems. To view the list of routers (including wireless routers) that are compatible with Windows Server Essentials, visit the [Windows Compatibility Center](https://www.microsoft.com/windows/compatibility/CompatCenter/Home).  
  
## Possible fixes  
 The following actions may fix these issues:  
  
- Verify that your router is turned on and functioning properly.  
  
- Ensure that your server is connected to your router directly or that it is connected to a switch that is connected to your router.  
  
- Verify that the broadband device that connects to your Internet service provider (ISP) is turned on, functioning properly, and that your router is connected to the broadband device.  
  
- Turn on the UPnP setting for your router. Connect to the configuration web page for your router to turn on the UPnP setting. For information about how to log on to your router and how to turn on the UPnP setting, see the documentation for your router. After you turn on the UPnP setting, run the Turn On  Remote Web Access Wizard again to configure your router.  
  
- If your router does not fully support the UPnP standard, it cannot be automatically configured. You must manually configure your router or purchase a router that supports the UPnP standard.  
  
   To manually configure you router, complete the following tasks:  
  
  - Create IP address reservation for your Windows Server Essentials server.  
  
     Before you manually configure the router to forward the required ports to Windows Server Essentials, you must set up a Dynamic Host Configuration Protocol (DHCP) reservation for your server that is running Windows Server Essentials on the router. This step guarantees that the IP address that you will be forwarding the ports to do not change.  
  
     For information about how to manually set up a DHCP reservation for your server on your router, see the manufacturer's documentation for your router.  
  
  - Configure port forwarding on your router for the following ports:  
  
    |Service or Protocol|Port|  
    |-------------------------|----------|  
    |HTTP|TCP 80|  
    |HTTPS|TCP 443|  
  
    For information about how to manually set up port forwarding on your router, see the manufacturer's documentation.  
  
    A typical router configuration page includes a table that resembles the following.  
  
  > [!NOTE]
  >  In this table, the IP address of the computer that is running Windows Server Essentials is 192.168.0.100. You must determine the IP address of your computer and substitute that IP address for the IP address shown in the table.  
  
  |IP address|Protocol (TCP/UDP)|Schedule|Inbound Filter|  
  |----------------|---------------------------|--------------|--------------------|  
  |192.168.0.100|TCP 80|Always|Allow All|  
  |192.168.0.100|TCP 443|Always|Allow All|  
  
   After you manually configure your router, run the Turn On  Remote Web Access Wizard, ensuring that you select the **Skip router setup** option on the **Getting started** page.  
  
- Purchase a new router if your router does not fully support the UPnP standard.  
  
> [!TIP]
>  Ensure that your router has the latest BIOS firmware installed. You can often update the BIOS firmware for your router from the configuration web page for the router. For more information, see the documentation for your router. After your router is updated, run the Set Up Anywhere Access Wizard.  
  
## See also  
  
-   [Use Remote Web Access](../use/Use-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Remote Web Access](../manage/Manage-Remote-Web-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Anywhere Access](../manage/Manage-Anywhere-Access-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](../manage/Manage-Windows-Server-Essentials.md)  
  

-   [Support Windows Server Essentials](Support-Windows-Server-Essentials.md)

-   [Support Windows Server Essentials](../support/Support-Windows-Server-Essentials.md)

