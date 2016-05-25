---
title: Configure Support for a Wireless Network
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4d7020d4-fd46-4858-a406-de5c0f21ea06
author: cfreemanwa
---
# Configure Support for a Wireless Network
You can configure the operating system to support a wireless network. The following requirements must be met to enable wireless support on the server:  
  
-   The server must have a wired network adapter installed.  
  
-   The correct driver for the wireless network adapter must be preinstalled if the network adapter is not supported by the operating system.  
  
-   The ability to enable and disable the wireless network adapter must be made available. Methods for doing this might include a physical button on the server or a custom user interface in the Dashboard. The product manual should provide the steps for enabling and disabling the wireless network adapter.  
  
-   The ability to select a wireless network and connect to it must be made available. This should be done by adding a custom user interface to the Dashboard. The product manual should provide the steps for selecting and connecting to a wireless network.  
  
-   If the ability to support a wireless ad\-hoc network is needed, an extended user interface in the Dashboard must be provided. The user interface can be a button or a link that launches the Set up a Wireless Ad\-hoc Network Wizard in the control panel in Windows Server 2008 R2.  
  
## Additional considerations  
The following information should also be considered when configuring support for a wireless network:  
  
-   The server must be connected to the network with a wire to run setup.  
  
-   A network computer on which a bare\-metal restore is performed must be connected to the network with a wire.  
  
-   The server must be connected to the network with a wire to perform a bare\-metal restore of the server.  
  
-   If an ad\-hoc network is created on the server, the wireless network adapter is dedicated for the ad\-hoc network so the user must always plug the network cable into the server to obtain an Internet connection.  
  
> [!NOTE]  
> For more information about configuring network connections, see [Preconfiguring a Router](../Topic/Preconfiguring-a-Router.md).  
  
## See Also  
[Creating and Customizing the Image](../Topic/Creating-and-Customizing-the-Image.md)  
[Additional Customizations](../Topic/Additional-Customizations.md)  
[Preparing the Image for Deployment](../Topic/Preparing-the-Image-for-Deployment.md)  
[Testing the Customer Experience](../Topic/Testing-the-Customer-Experience.md)  
  
