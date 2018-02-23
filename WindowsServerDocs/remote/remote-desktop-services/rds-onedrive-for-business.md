---
title: RDS and OneDrive for Business in persistent and non-persistent environments
description: Learn about OneDrive in VDI environments
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: low
ms.date: 02/23/2018
---
# OneDrive for Business and VDI environments 

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

For information about using OneDrive for Business in virtualized environments, including Remote Desktop Services, check out the "Windows specific restrictions and limitations" information in [Restrictions and limitations when you sync files and folders](https://support.microsoft.com/help/3125202/restrictions-and-limitations-when-you-sync-files-and-folders).

The OneDrive for Business sync app isn’t supported for client sessions that are hosted on Windows 2008 Terminal Services or Windows 2012 Remote Desktop Services (RDS). This includes both persistent and non-persistent Virtual Desktop Infrastructure (VDI).

For the OneDrive for Business sync app to work as designed, the following requirements must be met: 

- The application must be installed on the local computer.
- The user must be able to write to the user profile.
- Data that's written to the user profile must be saved to the local hard disk and be available without a network connection.

Currently we recommend that OneDrive customers in these environments leverage our OneDrive Office 365 web portal or download our OneDrive [UWP app](https://www.microsoft.com/en-us/store/p/onedrive/9wzdncrfj1p3) (Universal Windows Platform) found in the Microsoft Store.
