---
title: "Preconfiguring a Router"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9153ac90-bb0c-4b8d-93b2-e2121ed13636
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Preconfiguring a Router

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Typically, a new installation of the operating system requires an Internet capable router and firewall to connect the internal network of the customer to the Internet. If you provide a router as an additional value with a preconfigured server, you can take additional steps to preconfigure the router to provide a better user experience.  
  
 The router should have DHCP turned on. The server should be assigned a static IP address. You can do this by DHCP reservation of an IP address or by assigning an IP address that is outside of the DHCP address range.  
  
 You should also preconfigure the port forwarding settings on the router to forward specific ports from the external interface of the router to the address of the server on the internal network. The following table lists the recommended configuration.  
  
|Configuration setting|Details|  
|---------------------------|-------------|  
|DHCP|On|  
|Port forwarding|You should forward the following ports to the address of the server:<br /><br /> -   80 (For hosted configuration, only use 443)<br />-   443|  
|UPnP support|You should enable UPnP �¢ support to provide the easiest router configuration for the customer and the best customer experience during installation.<br /><br /> **Warning:** The UPnP architecture can pose a security risk if it is left enabled.|  
  
 In addition to the basic router preconfiguration settings, you can complete the following tasks to provide a more integrated user experience for managing the router:  
  
-   Extend the Dashboard by providing an add-in on the server that enables users to manage the router through a custom user interface.  
  
-   Extend the health alerts so that any alerts from the router can be seen in the Alert Viewer.  
  
-   If the router supports multiple subnets, the IP address of the server must be handed out as one DNS server through DHCP.  
  
-   If the router has an integrated access control feature for Active DirectoryÂ® Domain Services, you can automate the Active Directory integration during the Initial Configuration of the server. You should also expose this feature through the router management add-in in the Dashboard.  
  
> [!NOTE]
>  For more information about configuring wireless connections, see [Configure Support for a Wireless Network](Configure-Support-for-a-Wireless-Network.md).  
  
## See Also  
 [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)