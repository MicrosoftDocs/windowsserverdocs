---
title: "Install or Remove Language Packs"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 98f13f63-4480-40ba-a7ef-d1d9b7582e5f
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Install or Remove Language Packs

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

> [!NOTE]
>  You must first create a multilingual Windows image as described in the [Language Packs and Deployment](https://technet.microsoft.com/library/hh824829) before you add the  Windows Server Essentials language pack.  
  
 Language packs are only available for creating multi-lingual images. The information in this section is specific to installing or removing language packs on  Windows Server Essentials.  
  
> [!NOTE]
>  If you intend to run Initial Configuration (IC) from a client computer that does not support East-Asian languages, such as ja-jp, and if English is not included in the multilingual image on the server, the IC webpage will display squares. For the IC webpage to default to English, the multilingual image that you create must include English.  
  
## Adding language packs to an image  
 Language packs are available on the OEM Customization DVD. It is recommended that you copy the language packs to your technician computer before adding the language packs to the image.  
  
 You must use the following command to install language packs:  
  
 **dism.exe /online /Add-Package /PackagePath:C:\\<full path to cab file directory\>\lp.cab**  
  
 For example, the following command shows how to add a German language pack:  
  
 **dism.exe /online /Add-Package /PackagePath:C:\Users\Administrator\Desktop\WindowsHomeServer-Product-r\de-de\lp.cab**  
  
> [!IMPORTANT]
>  You must also apply language packs for  Windows Server Essentials to fully localize the operating system.  
  
## Removing language packs from an image  
 You can use the following command to remove a language pack that you no longer want to include in an image:  
  
 **dism.exe /online /Remove-Package /PackagePath:C:\\<full path to cab file directory\>\lp.cab**  
  
 For example, the following command shows how to remove a German language pack:  
  
 **dism.exe /online /Remove-Package /PackagePath:C:\Users\Administrator\Desktop\WindowsHomeServer-Product-r\de-de\lp.cab**  
  
## See Also  

 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

