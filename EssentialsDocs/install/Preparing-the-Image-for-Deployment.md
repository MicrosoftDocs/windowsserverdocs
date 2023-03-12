---
title: "Preparing the Image for Deployment"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 681c6cad-7fde-494f-86a5-f4c7c15d23f9
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Preparing the Image for Deployment

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

A typical tool for preparing an image is sysprep.exe. Running this tool generalizes the image and shuts down the server so that the Initial Configuration will run when the server that contains the image is restarted. All modifications to the image must be complete before you run sysprep.exe.  
  
> [!NOTE]
>  You can reset the Windows Product Activation a maximum of three times by using sysprep.exe.  
  
#### To prepare the image  
  
1.  Delete SkipIC.txt that you have you added.  
  
2.  Open an elevated command prompt window. Click **Start**, right click **Command Prompt**, and then select **Run as Administrator**.  
  
3.  Run the following command to reset the registry key so that the user will have the full grace period before the server becomes noncompliant.  
  
    ```  
    %systemroot%\system32\reg.exe add HKLM\Software\Microsoft\ServerInfrastructureLicensing /v Rearm /t REG_DWORD /d 1 /f  
    ```  
  
4.  Run the following command to add the registry key to display key, language page, locale page and EULA page. By default these pages will not display during initial configuration. Hence, if you are releasing a preinstalled box, you need to add this registry key. However, if you are releasing a DVD, you should not add this key, as these pages will display during WinPE and initial configuration.  
  
    ```  
    %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\windows server\setup" /v ShowPreinstallPages /t REG_SZ /d true /f  
    ```  
  
5.  Disable the initial configuration key page if your box is pre-keyed. The key page will only show when ShowPreinstallPages = true and KeyPreInstalled != true.  
  
    ```  
    %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\windows server\setup" /v KeyPreInstalled /t REG_SZ /d true /f  
    ```  
  
6.  Run the following command to add the registry key if you want to disable the hardware requirement checks. This is only for your pre-installed box that does not meet the hardware requirement. If you are releasing a DVD, or, your box meets the hardware requirement, it is recommended to not add this key.  
  
    ```  
    %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\windows server\setup" /v HWRequirementChecks /t REG_DWORD /d 0 /f  
    ```  
  
7.  (Optional) Remove the logs under **%programdata%\Microsoft\Windows Server\Logs**.  
  
8.  Prepare the unattended xml file for sysprep as shown in the following template.  
  
    ```  
    <unattend xmlns="urn:schemas-microsoft-com:unattend" xmlns:ms="urn:schemas-microsoft-com:asm.v3">  
  
      <settings pass="oobeSystem">  
        <component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="https://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
  
          <!-- Must have -->  
          <OOBE>  
             <HideEULAPage>true</HideEULAPage>  
          </OOBE>  
          <!-- Must have -->  
          <AutoLogon>   
            <Enabled>true</Enabled>   
            <Username>Administrator</Username>   
            <Domain>.</Domain>   
            <Password>   
              <!--You can set any password you like, but keep it consistent with password settings -->       
              <Value>Admin@123</Value>   
              <PlainText>true</PlainText>   
            </Password>   
          </AutoLogon>   
          <UserAccounts>   
           <AdministratorPassword>   
             <!--You can set any password you like, but keep it consistent with auto logon settings -->       
             <Value>Admin@123</Value>   
             <PlainText>true</PlainText>   
           </AdministratorPassword>   
          </UserAccounts>  
  
          <!-- Optional -->  
          <OEMInformation>  
             <HelpCustomized>true</HelpCustomized>  
             <Manufacturer>OEM name</Manufacturer>  
             <Model>model name</Model>  
             <SupportHours>hours</SupportHours>  
             <SupportPhone>123-456-7890</SupportPhone>  
             <SupportURL>http://www.contoso.com</SupportURL>  
          </OEMInformation>  
  
        </component>  
  
      </settings>  
  
      <settings pass="specialize">  
        <component name="Microsoft-Windows-Shell-Setup" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" processorArchitecture="amd64">  
          <!-- Must have -->  
          <ComputerName>Server</ComputerName>          
          <!-- Optional -->  
          <ProductKey>XXXXX-XXXXX-XXXXX-XXXXX-XXXXX</ProductKey>  
        </component>  
      </settings>  
    </unattend>  
    ```  
  
9. Run the following command for sysprep.  
  
    ```  
    %systemroot%\system32\sysprep\sysprep.exe /generalize /OOBE /unattend:xxx.xml /Quit  
    ```  
  
    > [!IMPORTANT]
    >  You can also add the unattend.xml under %systemdrive% instead of as a parameter of sysprep. If the file is located under c:\ it will covered by user's settings, but if used as a parameter of sysprep, it will not be covered by user's settings. The unattend.xml under %systemdrive% will be deleted each time the server restarts. Hence, ensure that after you create unattend.xml under %systemdrive%, the server is not restarted.  
  
10. Run the following command to add the registry key to skip Windows OOBE key page.  
  
    ```  
    %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\Windows\CurrentVersion\Setup\OOBE" /v SetupDisplayedProductKey /t REG_DWORD /d 1 /f  
    ```  
  
11. Run the following command to add the registry key to skip Windows language select page.  
  
    ```  
    %systemroot%\system32\reg.exe add "HKLM\Software\microsoft\Windows\CurrentVersion\Setup\OOBE" /v SetupDisplayedLanguageSelection /t REG_DWORD /d 1 /f  
    ```  
  
    > [!IMPORTANT]
    >  You must perform the last 2 steps, or else the Windows OOBE page will come up which is due with initial configuration page and break remotely administered server scenario.  
  
12. Shut down the box after sysprep, you can capture an image or restart the server to continue Initial Configuration from a client computer.  
  
> [!IMPORTANT]
>  Partners who are planning to create server recovery media must capture the image and create the recovery media before proceeding to the next step.