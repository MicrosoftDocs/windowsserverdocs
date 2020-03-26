---
title: "Create a Simple Customized Image"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 29f9a09f-e4e8-476d-ada1-ab9202a670d7
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Create a Simple Customized Image

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can use the following procedure for creating a simple customized image:  
  
#### To create the image  
  
1.  After server installation, at the first page of Initial Configuration, press Shift+F10 to launch the cmd window.  
  
2.  Create a SkipIC.txt file under the root of system drive.  
  
3.  Restart the server.  
  
4.  Start the server by using a USB flash drive or DVD, which includes the unattend.xml file. For information about creating a bootable USB flash drive, see [Create a Bootable USB Flash Drive](Create-a-Bootable-USB-Flash-Drive.md).  
  
5.  Add logo branding to the Dashboard. For more information about adding branding, see [Add Branding to the Dashboard, Remote Web Access, and Launchpad](Add-Branding-to-the-Dashboard--Remote-Web-Access--and-Launchpad.md).  
  
6.  Create the OOBE.xml file to display custom information, such as company name, logo, and EULA. For more information about the OOBE.xml file, see [Create the Oobe.xml File Including Logo and EULA](Create-the-Oobe.xml-File-Including-Logo-and-EULA.md).  
  
7.  Change the default server name if you do not define it in unattend.xml.  
  
8.  By default the server name will be a random string. Change the server name to another string (such as, ContosoServer), and then inform your customer about the new server name.  
  
9. Prepare the Image for Deployment as described in [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md).  
  
## See Also  
 [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)