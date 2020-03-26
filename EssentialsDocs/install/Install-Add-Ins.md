---
title: "Install Add-Ins"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e62e4f07-c2ba-4c5e-b30c-bdc287cd654e
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Install Add-Ins

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can include add-ins on all server or client computers by installing them before creating an image. These add-ins will then be automatically included on all computers replicated using that image. You can either install an add-in by running the .wssx file or you can install individual add-in files by following the guidance in the [SDK documentation](https://go.microsoft.com/fwlink/?LinkID=248648)for each type of add-in. If you install by using a .wssx file, the add-in can be uninstalled through the Add-In Manager. If you install the individual files, the add-in is not managed from the Add-In Manager.  
  
> [!NOTE]
>  Any software that is installed or downloaded on the server (including Dashboard tabs and health notifications) should have a localized interface that matches the language of the operating system that is installed on the server.  
  
#### To install an add-in  
  
1.  (Optional) If you are installing the add-in by using a .wssx file, complete the following steps:  
  
    1.  Save the <AddinName\>.wssx file on the reference computer.  
  
    2.  Double click the .wssx file to open the Add-in Installation Wizard.  
  
    3.  Follow the instructions in the wizard to complete the installation.  
  
2.  (Optional) Install the individual add-in files in the appropriate locations as defined in the SDK for each type of add-in.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)