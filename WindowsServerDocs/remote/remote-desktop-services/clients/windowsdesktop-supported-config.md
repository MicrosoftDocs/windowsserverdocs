---
title: Supported configurations for the Windows Desktop client
description: Learn about which OS configurations the Remote Desktop web client supports.
ms.topic: article
author: heidilohr
manager: femila
ms.author: helohr
ms.date: 06/16/2022
---

# Supported configurations for the Windows Desktop client

This article lists which configurations the Windows Desktop client currently supports. Running unsupported OS versions on the client can negatively impact user experience, so it's important to use compatible configurations.

## Client requirements

In order to run properly, you must meet the following requirements:

- Client version must be at or above the minimum supported version. For more information, see [What's new in the Windows Desktop client](windowsdesktop-whatsnew.md).

- Client devices must have .NET Framework 4.6.1 or above. For more information, [Lifecycle FAQ - .NET Framework](/lifecycle/faq/dotnet-framework).

- You cannot sign-in using the built-in Administrator user account.

## Supported operating system versions

The tables in this section list which versions of Windows and Windows Server are compatible with the Windows Desktop client.

### Windows

| Operating system         | Edition  | Minimum version             |
|-------------|---------|---------------------------------|
|Windows 11|Enterprise, Education, Pro, Pro Education, Pro for Workstations|All versions|
|Windows 11 IoT|Enterprise|All versions|
|Windows 10 (Semi-Annual Channel)|Enterprise, Enterprise multi-session, Education|1909|
|Windows 10 (Semi-Annual Channel)|Home, Pro|2004|
|Windows 10 IoT|Enterprise|1909|
|Windows 10 (Long-term Servicing Channel|Enterprise|Version with latest security updates|
|Windows 7|Enterprise, Home Basic, Home Premium, Professional, Starter, Ultimate|Extended security update (Year 2)|
|Windows 7 Embedded Standard|Professional for Embedded Systems, Ultimate for Embedded Systems|Extended security update (Year 1)|

> [!NOTE]
> Extended support for using Windows 7 to connect to Azure Virtual Desktop ends on January 10, 2023.

### Windows Server

| Operating system         | Edition  | Minimum version             |
|-------------|---------|---------------------------------|
|Windows Server (Semi-Annual Channel)|Datacenter, Standard|2004|
|Windows Server 2019 (Long-Term Servicing Channel)|Datacenter, Essentials, Standard|Version with latest security updates|
|Windows Server 2016 (Long-Term Servicing Channel)|Datacenter, Essentials, MultiPoint Premium, Standard|Version with latest security updates|
|Windows Server 2012 R2|Datacenter, Essentials, for Embedded Systems, Foundation, Standard|Version with latest security updates|

## Other resources

For more information about the latest Windows 10 releases, see [Windows 10 release information](/windows/release-health/release-information).
