---
title: "Build Multi-Language Client Restore Media"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2fdbc016-d464-43cb-bd75-8a63e61588a2
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Build Multi-Language Client Restore Media

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

> [!NOTE]
>  You must first create a multilingual Windows image as described in the [Walkthrough: Multilingual Windows Image Creation](https://technet.microsoft.com/library/jj126995) before you add the  Windows Server Essentials langauage pack into install.wim.  
  
 When building the multi-language server installation DVD, the language packs will be installed for Server install.wim. The localized resources for restore wizard will be installed as part of language pack.  
  
### To build a multi-language client restore media  
  
1.  Mount install.wim at c:\mount, we call c:\mount\Program Files\Windows Server\bin\ClientRestore folder as root of client restore media: [RestoreMediaRoot] below:  
  
    ```  
    dism /mount-wim /wimfile:install.wim /index:1 /mountdir:c:\mount  
    ```  
  
2.  Mount the client restore WIM file at [RestoreMediaRoot]\Sources\Boot.wim (Same steps need to be performed for boot_x86.wim too). The command line is:  
  
    ```  
    dism /mount-wim /wimfile:boot.wim /index:1 /mountdir:c:\mountRestore  
    ```  
  
3.  Add WinPE-Setup.cab package to the restore media, by running:  
  
    ```  
    dism /image:c:\mountRestore /add-package /packagepath:WinPE-Setup.cab  
    ```  
  
4.  Use notepad to edit c:\mountRestore\windows\system32\winpeshl.ini, fill with following content:  
  
    ```  
    [LaunchApp]  
    AppPath = %SYSTEMDRIVE%\sources\SelectLanguage.exe  
    ```  
  
5.  Add language packs to the restore media. Adding language packs can be done by running following command:  
  
    ```  
    dism /image:c:\mountRestore /add-package /packagepath:[language pack path]  
    ```  
  
     Following language packs need to be added:  
  
    1.  WinPE language pack (lp.cab)  
  
    2.  WinPE-Setup language pack (WinPE-Setup_[lang].cab, for example, WinPE-Setup_en-us.cab)  
  
    3.  For Asian fonts, including zh-cn, zh-tw, zh-hk, ko-kr, ja-jp, additional font pack need to be installed (winpe-fontsupport-[lang].cab, for example, winpe-fontsupport-zh-cn.cab)  
  
6.  Generate new Lang.ini file, by running:  
  
    ```  
    dism /image:c:\mountRestore /Gen-LangINI /distribution:mount  
    ```  
  
7.  Commit and unmount the image, by running:  
  
    ```  
    dism /unmount-wim /mountdir:c:\mountRestore /commit  
    ```  
  
8.  Repeat step 2 to Step 7 for [RestoreMediaroot]\Sources\Boot_x86.wim.  
  
9. Commit and unmount the image, by running:  
  
    ```  
    dism /unmount-wim /mountdir:c:\mount /commit  
    ```  
  
## See Also  

 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

