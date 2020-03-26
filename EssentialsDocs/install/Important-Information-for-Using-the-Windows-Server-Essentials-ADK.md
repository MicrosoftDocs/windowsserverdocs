---
title: "Important Information for Using the Windows Server Essentials ADK"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 26cb2992-1250-4672-98ee-8b870baa45d5
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Important Information for Using the Windows Server Essentials ADK

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

To create and customize an image of  Windows Server Essentials, you use many of the tools in the [Windows 8 ADK](https://go.microsoft.com/fwlink/?LinkId=248647), but there are some important differences between the Windows 8 ADK and the  Windows Server Essentials ADK.  
  
 You should be aware of the following important differences:  
  
-   Some settings have been changed in **%windir%\setup\script\SetupComplete.cmd**. If you want to use this command, you can add additional cmdlines, but do not remove the existing lines.  
  
## Working with passwords  
  
-   The password of administrator is set to Admin@123 and auto logon is enabled in the Install.wim\unattend.xml. Therefore, you do not need to retype the password multiple times during initial configuration of the server. If you have a customized unattend.xml in the root of removable media, this settings will be overwritten, and you will need to set the password, and logon during start up..  
  
-   During Initial Configuration, the end user is prompted to create a new account and password. This new account becomes the network administrator account for the operating system. The Administrator account and auto logon is then disabled. You can automate this process by using the cfg.ini file for quality assurance testing.  
  
-   Refer to the [Windows 8 ADK](https://go.microsoft.com/fwlink/?LinkId=248694) documentation for details on creating an unattend.xml file.  
  
## See Also  

 [Getting Started with the Windows Server Essentials ADK](Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Getting Started with the Windows Server Essentials ADK](../install/Getting-Started-with-the-Windows-Server-Essentials-ADK.md)   
 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

