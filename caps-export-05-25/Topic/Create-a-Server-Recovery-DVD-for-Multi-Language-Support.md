---
title: Create a Server Recovery DVD for Multi-Language Support
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c7da0f6c-9732-4784-9c28-7dad72c4071d
author: cfreemanwa
---
# Create a Server Recovery DVD for Multi-Language Support
  
## <a name="BKMK_MLHeadedRecovery"></a>Create a server setup and server recovery DVD for multiple language support on locally administered servers  
  
> [!NOTE]  
> You must first create a multilingual Windows image as described in the [Walkthrough: Multilingual Windows Image Creation](http://technet.microsoft.com/library/jj126995) before you add the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] langauage pack into install.wim.  
  
There are two phases of setup: the Windows Preinstallation Environment \(Windows PE\) and the initial configuration. By default, the language selection page in initial configuration will not be displayed.  
  
-   For an OEM remotely administered installation or an OEM preinstallation scenario, you need to add a registry key using following command to display the language selection page in initial configuration.  
  
    ```  
    %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\windows server\setup" /v ShowPreinstallPages /t REG_SZ /d true /f  
    ```  
  
    > [!IMPORTANT]  
    > When OEMs create an image in the lab, they must choose **English** as the language during the Windows PE phase of setup.  
  
-   For a Reseller Option Kit \(ROK\) scenario, customers receive a DVD, and perhaps, some hardware. The customer should able to select the language during Windows PE setup, and the language selection page is no longer displayed during initial configuration.  
  
You may choose to ship a single dual\-layer DVD that contains multiple languages.  
  
This section describes how to add language support to Windows Setup. The primary tool for customizing Windows PE 3.0 is Deployment Image Servicing and Management \(DISM\), a command\-line tool. This solution enables the following scenarios:  
  
1.  Creating multilingual installations  
  
2.  Creating distributable media  
  
### Prerequisites  
To add multilingual support to Windows Setup, you need the following:  
  
-   A technician computer that provides all the tools and source files necessary to create a customized WinPE image. For more information, see [Prepare the Technician Computer](../Topic/Prepare-the-Technician-Computer.md).  
  
-   A [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] DVD.  
  
-   A [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] Language Pack DVD.  
  
### <a name="BKMK_Steps"></a>Adding multiple language support  
To add multiple language support to Windows Setup you update the Install.wim by adding the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and the [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] language packs to it.  
  
#### Update Install.wim  
In this step, you add [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] language packs into Install.wim.  
  
> [!NOTE]  
> Verify that you install language packs for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]. This assures that you get the appropriate branding. The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Multilingual User Interface Language Packs are available on [Microsoft.com](http://www.microsoft.com/OEM/en/installation/downloads/Pages/technical-downloads.aspx). Please follow the instructions as described in the [Walkthrough: Multilingual Windows Image Creation on creating a multilingual](http://technet.microsoft.com/library/jj126995.aspx) on creating a multilingual Windows image before you add the Windows Server 2012 Essentials language pack into install.wim.  
>   
> Windows Server 2012 Essentials language packs are available in the Language pack media at \\Language Packs\\<CultureName>.  
  
> [!NOTE]  
> Not all language packs may not available prior to the release of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
###### To add language packs to Install.wim  
  
1.  Add operating system and product language packs into the Install.wim as follows \(this example uses French\):  
  
    ```  
    Dism /Mount-Wim /WimFile:C:\my_distribution\sources\install.wim /index:1 /MountDir:C:\InstallMount  
    Mkdir c:\temp_Scratch  
    Dism /Image:C:\InstallMount /ScratchDir:C:\temp_Scratch /Add-Package /PackagePath:<path_to_OS_language_packs>\fr-fr\lp.cab  
    Dism /Image:C:\InstallMount /ScratchDir:C:\temp_Scratch /Add-Package /PackagePath:<OCD\Language Packs\FR-FR\lp.cab  
  
    ```  
  
2.  Add Language specific files to support creating the Client Backup Restore USB flash drive, using the procedure described in [Build Multi-Language Client Restore Media](../Topic/Build-Multi-Language-Client-Restore-Media.md).  
  
3.  Recreate the Lang.ini file in the loose media to reflect the additional language support by using the `DISM /Gen-LangINI` command, for example:  
  
    ```  
    Dism /image:C:\InstallMount /Gen-LangINI /distribution:C:\my_distribution  
  
    ```  
  
4.  Save your changes back into the image by using the `DISM /unmount /commit` command, for example:  
  
    ```  
    Dism /Unmount-Wim /MountDir:C:\InstallMount /Commit  
    ```  
  
## See Also  
[Creating and Customizing the Image](../Topic/Creating-and-Customizing-the-Image.md)  
[Additional Customizations](../Topic/Additional-Customizations.md)  
[Preparing the Image for Deployment](../Topic/Preparing-the-Image-for-Deployment.md)  
[Testing the Customer Experience](../Topic/Testing-the-Customer-Experience.md)  
  
