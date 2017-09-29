---
title: Features Removed or Planned for Replacement in Windows Server (version 1709)
description: "Features and functionalities removed or planned for removal in releases."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.date: 10/05/2017
author: jaimeo
ms.author: jaimeo
manager: elizapo
---
# Features removed or planned for replacement starting with Windows Server, version 1709

>Applies To: Windows Server, version 1709

The following is a list of features and functionalities in Windows Server, version 1709 that have either been removed from the product in that release or are starting to be considered for potential replacement in subsequent releases. It is intended for IT professionals who are updating operating systems in a commercial environment. **This list is subject to change in subsequent releases and might not include every affected feature or functionality.** 

## Features removed from Windows Server, version 1709
No features or functionalities that are present in Windows Server 2016 have been removed in Windows Server, version 1709.

> [!NOTE]  
> Did you know that Nano Server has changed? See [Changes to Nano Server in Windows Server, version 1709](nano-in-semi-annual-channel.md). In addition to the changes in Nano Server, Windows Server, version 1709 is available only with the Server Core installation option and with a revised servicing model. For details, see [Windows Server Semi-Annual Channel overview](semi-annual-channel-overview.md).



## Features being considered for replacement starting with subsequent releases

The following features and functionalities are being considered for replacement starting with releases after Windows Server, version 1709. Eventually, they may be completely removed from the installed product image and replaced by other features or functionality (or installable from other sources), but they are still available in this release, sometimes with certain functionality removed. You should begin planning now to employ alternate methods or the future replacement for any applications, code, or usage that depend on these features.

If you have feedback about the proposed replacement of any of these features, contact us at [FEEDBACK LINK].

### IIS 6 Management compatibility
Specific features being considered for replacement are:

- IIS 6 Metabase Compatibility (Web-Metabase)
- IIS 6 Management Console (Web-Lgcy-Mgmt-Console)
- IIS 6 Scripting Tools (Web-Lgcy-Scripting)
- IIS 6 WMI Compatibility (Web-WMI)

Instead of IIS 6 Metabase Compatibility (which acts as an emulation layer between IIS 6-based metabase scripts and the file-based configuration used by  IIS 7 or newer versions) you should start migrating management scripts to target IIS file-based configuration directly, by using tools such as the Microsoft.Web.Administration namespace.

You should also start migration from IIS 6.0 or earlier versions, and move to the latest version of IIS, which is always available in the most recent release of Windows Server.


### IIS Digest Authentication
This authentication method is planned for replacement. Instead, you should start using other authentication methods such as Client Certificate Mapping (see [Configuring One-to-One Client Certificate Mappings](https://docs.microsoft.com/iis/manage/configuring-security/configuring-one-to-one-client-certificate-mappings)) or Windows Authentication (see [Application Settings](https://docs.microsoft.com/iis-administration/configuration/appsettings.json)).

### Internet Storage Name Service (iSNS)
iSNS is being considered for replacement. The Server Message Block (SMB) feature offers essentially the same functionality with additional features. See [Server Message Block Overview](https://technet.microsoft.com/library/hh831795(v=ws.11).aspx) for background information on this feature.

### RSA/AES Encryption for IIS 
This encryption method is being considered for replacement because the superior Cryptography API: Next Generation (CNG) method is already available. To learn more about CNG encryption, see [About CNG](https://msdn.microsoft.com/library/windows/desktop/aa375276(v=vs.85).aspx).

### Windows PowerShell 2.0
This early version of Windows PowerShell has been superseded by several more recent versions. For the best features and performance, migrate to Windows PowerShell 5.0 or later. See [PowerShell Documentation](https://docs.microsoft.com/powershell/index?view=powershell-5.1) for plenty of information.

