---
title: "Create a Server Recovery DVD for Multi-Language Support"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c7da0f6c-9732-4784-9c28-7dad72c4071d
4author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Create a Server Recovery DVD for Multi-Language Support

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_MLHeadedRecovery"></a> Create a server setup and server recovery DVD for multiple language support on locally administered servers  
  
> [!NOTE]
>  You must first create a multilingual Windows image as described in the [Walkthrough: Multilingual Windows Image Creation](https://technet.microsoft.com/library/jj126995) before you add the  Windows Server Essentials langauage pack into install.wim.  
  
 There are two phases of setup: the Windows Preinstallation Environment (Windows PE) and the initial configuration. By default, the language selection page in initial configuration will not be displayed.  
  
- For an OEM remotely administered installation or an OEM preinstallation scenario, you need to add a registry key using following command to display the language selection page in initial configuration.  
  
  ```  
  %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\windows server\setup" /v ShowPreinstallPages /t REG_SZ /d true /f  
  ```  
  
  > [!IMPORTANT]
  >  When OEMs create an image in the lab, they must choose **English** as the language during the Windows PE phase of setup.  
  
- For a Reseller Option Kit (ROK) scenario, customers receive a DVD, and perhaps, some hardware. The customer should able to select the language during Windows PE setup, and the language selection page is no longer displayed during initial configuration.  
  
  You may choose to ship a single dual-layer DVD that contains multiple languages.  
  
  This section describes how to add language support to Windows Setup. The primary tool for customizing Windows PE 3.0 is Deployment Image Servicing and Management (DISM), a command-line tool. This solution enables the following scenarios:  
  
1.  Creating multilingual installations  
  
2.  Creating distributable media  
  
### Prerequisites  
 To add multilingual support to Windows Setup, you need the following:  
  

-   A technician computer that provides all the tools and source files necessary to create a customized WinPE image. For more information, see [Prepare the Technician Computer](Prepare-the-Technician-Computer.md).  

-   A technician computer that provides all the tools and source files necessary to create a customized WinPE image. For more information, see [Prepare the Technician Computer](../install/Prepare-the-Technician-Computer.md).  

  
-   A  Windows Server Essentials DVD.  
  
-   A  Windows Server Essentials Language Pack DVD.  
  
###  <a name="BKMK_Steps"></a> Adding multiple language support  
 To add multiple language support to Windows Setup you update the Install.wim by adding the  Windows Server 2012 and the  Windows Server Essentials language packs to it.  
  
#### Update Install.wim  
 In this step, you add  Windows Server 2012 and  Windows Server Essentials language packs into Install.wim.  
  
> [!NOTE]
>  Verify that you install language packs for  Windows Server 2012. This assures that you get the appropriate branding. The  Windows Server 2012 Multilingual User Interface Language Packs are available on [Microsoft.com](https://www.microsoft.com/OEM/en/installation/downloads/Pages/technical-downloads.aspx). Please follow the instructions as described in the [Walkthrough: Multilingual Windows Image Creation on creating a multilingual](https://technet.microsoft.com/library/jj126995.aspx) on creating a multilingual Windows image before you add the Windows Server Essentials language pack into install.wim.  
>   
>  Windows Server Essentials language packs are available in the Language pack media at \Language Packs\\<CultureName\>.  
  
> [!NOTE]
>  Not all language packs may not available prior to the release of  Windows Server 2012.  
  
###### To add language packs to Install.wim  
  
1.  Add operating system and product language packs into the Install.wim as follows (this example uses French):  
  
    ```  
    Dism /Mount-Wim /WimFile:C:\my_distribution\sources\install.wim /index:1 /MountDir:C:\InstallMount  
    Mkdir c:\temp_Scratch  
    Dism /Image:C:\InstallMount /ScratchDir:C:\temp_Scratch /Add-Package /PackagePath:<path_to_OS_language_packs>\fr-fr\lp.cab  
    Dism /Image:C:\InstallMount /ScratchDir:C:\temp_Scratch /Add-Package /PackagePath:<OCD\Language Packs\FR-FR\lp.cab  
  
    ```  
  

2.  Add Language specific files to support creating the Client Backup Restore USB flash drive, using the procedure described in [Build Multi-Language Client Restore Media](Build-Multi-Language-Client-Restore-Media.md).  

2.  Add Language specific files to support creating the Client Backup Restore USB flash drive, using the procedure described in [Build Multi-Language Client Restore Media](../install/Build-Multi-Language-Client-Restore-Media.md).  

  
3.  Recreate the Lang.ini file in the loose media to reflect the additional language support by using the `DISM /Gen-LangINI` command, for example:  
  
    ```  
    Dism /image:C:\InstallMount /Gen-LangINI /distribution:C:\my_distribution  
  
    ```  
  
4.  Save your changes back into the image by using the `DISM /unmount /commit` command, for example:  
  
    ```  
    Dism /Unmount-Wim /MountDir:C:\InstallMount /Commit  
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

