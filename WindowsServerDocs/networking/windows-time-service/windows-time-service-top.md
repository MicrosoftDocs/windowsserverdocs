---
ms.assetid: e34622ff-b2d0-4f81-8d00-dacd5d6c215e
title: Windows Time Service
description:
author: shortpatti
ms.author: pashort
manager: dougkim
ms.date: 05/08/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: networking
---

# Windows Time Service (W32Time)

>Applies to: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10 or later

The Windows Time service (W32Time) synchronizes the date and time for all computers running in Active Directory Domain Services (AD DS). Time synchronization is critical for the proper operation of many Windows services and line-of-business (LOB) applications. The Windows Time service uses the Network Time Protocol (NTP) to synchronize computer clocks on the network. NTP ensures that an accurate clock value, or timestamp, can be assigned to network validation and resource access requests.

In the Windows Time Service (W32Time) topic, the following content is available:
- **[Windows Server 2016 Accurate Time](accurate-time.md).** Time synchronization accuracy in Windows Server 2016 has been improved substantially, while maintaining full backwards NTP compatibility with older Windows versions. Under reasonable operating conditions you can maintain a 1 ms accuracy with respect to UTC or better for Windows Server 2016 and Windows 10 Anniversary Update domain members.
- **[Support boundary for high-accuracy environments](support-boundary.md).** This article describes the support boundaries for the Windows Time service (W32Time) in environments that require highly accurate and stable system time.
- **[Configuring Systems for high accuracy](configuring-systems-for-high-accuracy.md).** Time synchronization in Windows 10 and Windows Server 2016 has been substantially improved.  Under reasonable operating conditions, systems can be configured to maintain 1ms (millisecond) accuracy or better (with respect to UTC).
- **[Windows Time for Traceability](windows-time-for-traceability.md).** Regulations in many sectors require systems to be traceable to UTC.  This means that a system's offset can be attested with respect to UTC.  To enable regulatory compliance scenarios, Windows 10 and Server 2016 provides new event logs to provide a picture from the perspective of the Operating System to form an understanding of the actions taken on the system clock.  These event logs are generated continuously for Windows Time service and can be examined or archived for later analysis.
- **[Windows Time service technical reference](windows-time-service-tech-ref.md).** The W32Time service provides network clock synchronization for computers without the need for extensive configuration. The W32Time service is essential to the successful operation of Kerberos V5 authentication and, therefore, to AD DS-based authentication.
    - **[How the Windows Time service works](How-the-Windows-Time-Service-Works.md).** Although the Windows Time service is not an exact implementation of the Network Time Protocol (NTP), it uses the complex suite of algorithms that is defined in the NTP specifications to ensure that clocks on computers throughout a network are as accurate as possible.
    - **[Windows Time service tools and settings](Windows-Time-Service-Tools-and-Settings.md).** Most domain member computers have a time client type of NT5DS, which means that they synchronize time from the domain hierarchy. The only typical exception to this is the domain controller that functions as the primary domain controller (PDC) emulator operations master of the forest root domain, which is usually configured to synchronize time with an external time source.


## Related Topics
For more information about the domain hierarchy and scoring system, see the [“What is Windows Time Service?”](https://blogs.msdn.microsoft.com/w32time/2007/07/07/what-is-windows-time-service/) blog post.

The windows time provider plugin model is [documented on TechNet](https://msdn.microsoft.com/library/windows/desktop/ms725475%28v=vs.85%29.aspx).

An addendum referenced by the Windows 2016 Accurate Time article can be downloaded [here](https://windocs.blob.core.windows.net/windocs/WindowsTimeSyncAccuracy_Addendum.pdf)

For a quick overview of Windows Time service, take a look at this [high-level overview video](https://aka.ms/WS2016TimeVideo).
