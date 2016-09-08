---
title: "Important Information for Using the Windows Server 2012 Essentials ADK"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 26cb2992-1250-4672-98ee-8b870baa45d5
caps.latest.revision: 13
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-hk
  - zh-tw
---
# Important Information for Using the Windows Server 2012 Essentials ADK
To create and customize an image of --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials, you use many of the tools in the [Windows 8 ADK](http://go.microsoft.com/fwlink/?LinkId=248647), but there are some important differences between the Windows 8 ADK and the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials ADK.  
  
 You should be aware of the following important differences:  
  
-   Some settings have been changed in **%windir%\setup\script\SetupComplete.cmd**. If you want to use this command, you can add additional cmdlines, but do not remove the existing lines.  
  
## Working with passwords  
  
-   The password of administrator is set to Admin@123 and auto logon is enabled in the Install.wim\unattend.xml. Therefore, you do not need to retype the password multiple times during initial configuration of the server. If you have a customized unattend.xml in the root of removable media, this settings will be overwritten, and you will need to set the password, and logon during start up..  
  
-   During Initial Configuration, the end user is prompted to create a new account and password. This new account becomes the network administrator account for the operating system. The Administrator account and auto logon is then disabled. You can automate this process by using the cfg.ini file for quality assurance testing.  
  
-   Refer to the [Windows 8 ADK](http://go.microsoft.com/fwlink/?LinkId=248694) documentation for details on creating an unattend.xml file.  
  
## See Also  
 [Getting Started with the Windows Server 2012 Essentials ADK](../install/Getting-Started-with-the-Windows-Server-2012-Essentials-ADK.md)   
 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)
