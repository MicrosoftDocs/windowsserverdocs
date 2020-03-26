---
title: "Automate Installation of Add-Ins During Setup"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2e6ff6e4-8d68-4d49-9e38-8088bc8bf95e
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Automate Installation of Add-Ins During Setup

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_AddIns"></a> Automate installing add-ins during setup  
 To install add-ins during setup, use the PostIC.cmd method described in the [Create the PostIC.cmd File for Running Post Initial Configuration Tasks](Create-the-PostIC.cmd-File-for-Running-Post-Initial-Configuration-Tasks.md) section of this document.  
  
 Add the following entry to your PostIC.cmd:  
  
```  
C:\Program Files\Windows Server\bin\Installaddin.exe <full path to wssx file> -q  
```  
  
 The add-in now supports pre-install and customized uninstall steps.  
  
 The pre-install step is run before installing all **.msi** files specified in addin.xml. When run in the interactive mode, the progress dialog will be shown but without changing the progress. The cancellation button is disabled during pre-install phase. To implement a pre-install step, add the following contents in addin.xml (directly under Package):  
  
> [!NOTE]
>  The xml schema needs to exactly follow the one below:  
  
```  
<Package xmlns="https://schemas.microsoft.com/WindowsServerSolutions/2010/03/Addins" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">  
  <Id>...</Id>  
  <Version>...</Version>  
  <Name>...</Name>  
  <Allow32BitOn64BitClients>...</Allow32BitOn64BitClients>  
  <ServerBinary>...</ServerBinary>  
  <ClientBinary32>...</ClientBinary32>  
  <ClientBinary64>...</ClientBinary64>  
  <SupportedSkus>...</SupportUrl>    
  <SupportUrl>...</SupportUrl>  
  <Location>...</Location>    
  <PrivacyStatement>...</PrivacyStatement>  
  <OtherBinaries>...</OtherBinaries>   
  <Preinstall>  
<Executable>exefile</Executable>  
<NormalArgs>args-for-interactive-mode</NormalArgs>  
<SilentArgs>args-for-silent-mode</SilentArgs>  
<IgnoreExitCode>true</IgnoreExitCode>  
  </Preinstall>  
  <UninstallConfirm>...</UninstallConfirm>      
</Package>  
<¦>  
<¦>  
```  
  
 Wherein **exefile** is the executable file in the add-in package to perform the pre-install step, and must be specified. **NormalArgs** specifies arguments to be passed to exefile in command-line when interactive mode is used. In this mode, the exefile can popup some dialogs for user interaction. **SilentArgs** specifies arguments to be passed to exefile in command-line when silent mode is used (-q is specified when invoking installaddin.exe). The exefile should not popup any windows in this mode. If **IgnoreExitCode** is specified with true, the pre-install step is always considered successful, otherwise, exit code 0 indicates success, 1 indicates cancellation, and other values indicate failure. Tags **NormalArgs**, **SilentArgs**, and **IgnoreExitCode** are all optional.  
  
 A customized uninstall step can be used for any of the following:  
  
- Replace the built-in confirmation dialog.  
  
- Populate customized dialogs before uninstallation.  
  
- Perform certain tasks before uninstallation.  
  
  To implement an uninstall step, add the following contents in addin.xml (directly under Package):  
  
```  
<Package xmlns="https://schemas.microsoft.com/WindowsServerSolutions/2010/03/Addins" xmlns:i="http://www.w3.org/2001/XMLSchema-instance">  
  <Id>...</Id>  
  <Version>...</Version>  
  <Name>...</Name>  
  <Allow32BitOn64BitClients>...</Allow32BitOn64BitClients>  
  <ServerBinary>...</ServerBinary>  
  <ClientBinary32>...</ClientBinary32>  
  <ClientBinary64>...</ClientBinary64>  
  <SupportedSkus>...</SupportUrl>    
  <SupportUrl>...</SupportUrl>  
  <Location>...</Location>    
  <PrivacyStatement>...</PrivacyStatement>  
  <OtherBinaries>...</OtherBinaries>   
  <Preinstall>¦</Preinstall>  
<UninstallConfirm>  
<Executable>full-path-to-exefile</Executable>  
<Arguments>command-line-arguments</Arguments>  
</UninstallConfirm>  
</Package>  
```  
  
 Wherein **full-path-to-exefile** specifies the exefile already installed on the system. **Arguments** is optional, and specifies the command line arguments for the exefile. The exefile is invoked before the built-in uninstall confirmation dialog pops up.  
  
 The exefile can perform following tasks in this phase:  
  
- Pops up some dialogs for user interaction.  
  
- Perform some background tasks.  
  
  The exit code of this exe file determines how the uninstall process moves forward:  
  
- 0: the uninstall process continues without populating the built-in confirmation dialog, just as user has already confirmed. (this approach can be used to replace the built-in confirmation dialog);  
  
- 1: the uninstall process is canceled, and finally a canceled message will be shown to user. Everything stays unchanged;  
  
- Other: the uninstall process continues with built-in confirmation dialog, just like the customized uninstall step is not present.  
  
  Any failure invoking the exefile will lead to the same behavior as the exefile returns a code other than 0 or 1.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)