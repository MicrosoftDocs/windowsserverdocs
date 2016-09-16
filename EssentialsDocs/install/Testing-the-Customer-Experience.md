---
title: "Testing the Customer Experience"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2016 Essentials
ms.assetid: 1b1a2040-4cfd-48bf-8d04-3ffde9c26b9b
caps.latest.revision: 7
author: coreyp-at-msft
ms.author: coreyp

---
# Testing the Customer Experience
To verify the experience of the customer and check your partner customizations, run through Initial Configuration of a target computer. It is recommended that you complete the Initial Configuration at least one time manually to walk through the customer experience. If you cobranded the Dashboard you must complete Initial Configuration to verify the branding. If you cobranded the Remote Web Access site, you must access http://<servername\> to verify the branding (<servername\> is the name of the server). You can use the Initial Configuration section of the cfg.ini file to automate testing of the customer experience. For more information about creating this section in the cfg.ini file see [Create the Cfg.ini File](Create-the-Cfg.ini-File.md).  
  
> [!IMPORTANT]
>  You must run the Sysprep.exe command to prepare the image for deployment before you test the Initial Configuration experience. For more information about running Sysprep.exe, see [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md).  
  
> [!IMPORTANT]
>  A network connection is required to test the Initial Configuration. DHCP is not configured or installed on the server, which enables network testing without interference.  
  
 To verify the partner Support Information, in the Dashboard, click the down arrow next to the Help button.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)