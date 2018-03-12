---
ms.assetid: e34622ff-b2d0-4f81-8d00-dacd5d6c215e
title: Windows Time Service
description:
author: shortpatti
ms.author: pashort
manager: brianlic
ms.date: 02/01/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adds
---

# Windows Time Service (W32Time)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The Windows Time service (W32Time) synchronizes the date and time for all computers running in Active Directory Domain Services (AD DS). Time synchronization is critical for the proper operation of many Windows services and line-of-business (LOB) applications. The Windows Time service uses the Network Time Protocol (NTP) to synchronize computer clocks on the network. NTP ensures that an accurate clock value, or timestamp, can be assigned to network validation and resource access requests.

In the Windows Time Service (W32Time) topic, the following content is available:
- **[Windows 2016 Accurate Time](accurate-time.md).** Time synchronization accuracy in Windows Server 2016 has been improved substantially, while maintaining full backwards NTP compatibility with older Windows versions.  Under reasonable operating conditions you can maintain a 1 ms accuracy with respect to UTC or better for Windows Server 2016 and Windows 10 Anniversary Update domain members.
- **[Windows Time service technical reference](windows-time-service-tech-ref.md).** The W32Time service provides network clock synchronization for computers without the need for extensive configuration. The W32Time service is essential to the successful operation of Kerberos V5 authentication and, therefore, to AD DS-based authentication.
    - **[How the Windows Time service works](How-the-Windows-Time-Service-Works.md).** Although the Windows Time service is not an exact implementation of the Network Time Protocol (NTP), it uses the complex suite of algorithms that is defined in the NTP specifications to ensure that clocks on computers throughout a network are as accurate as possible.
    - **[Windows Time service tools and settings](Windows-Time-Service-Tools-and-Settings.md).** Most domain member computers have a time client type of NT5DS, which means that they synchronize time from the domain hierarchy. The only typical exception to this is the domain controller that functions as the primary domain controller (PDC) emulator operations master of the forest root domain, which is usually configured to synchronize time with an external time source.

<!-- In this guide
In this guide:
Windows Accurate Time
High Accuracy
Support Boundary
Configuration for High Accuracy
Traceability for Compliance
Best Practices
Technical Reference
How the Windows Time Service Works
Windows Time Service Tools and Settings
-->

