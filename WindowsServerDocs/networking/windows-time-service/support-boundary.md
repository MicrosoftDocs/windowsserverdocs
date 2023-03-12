---
ms.assetid: 
title: Support boundary for high-accuracy time
description: This article describes the support boundary for the Windows Time (W32Time) service in environments that require highly accurate and stable system time. 
author: shortpatti
ms.author: dacuo
manager: dougkim
ms.date: 10/17/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: networking
---

# Support boundary for high-accuracy time

>Applies to: Windows Server 2016, and Windows 10 version 1607 or later

This article describes the support boundaries for the Windows Time service (W32Time) in environments that require highly accurate and stable system time.

## High Accuracy support for Windows 8.1 and 2012 R2 (or Prior)

Earlier versions of Windows (Prior to Windows 10 1607 or Windows Server 2016 1607) cannot guarantee highly accurate time. The Windows Time service on these systems:

-   Provided the necessary time accuracy to satisfy Kerberos version 5 authentication requirements

-   Provided loosely accurate time for Windows clients and servers joined to a common Active Directory forest

Tighter accuracy requirements were outside of the design specification of the Windows Time Service on these operating systems and is not supported.

## Windows 10 and Windows Server 2016

Time accuracy in Windows 10 and Windows Server 2016 has been substantially improved, while maintaining full backwards NTP compatibility with older Windows versions. Under the right operating conditions, systems running Windows 10 or Windows Server 2016 and newer releases can deliver 1 second, 50ms (milliseconds), or 1ms accuracy.

>[!IMPORTANT]
>**Highly accurate time sources**<br>
>The resulting time accuracy in your topology is highly dependent on using an accurate, stable root (stratum 1) time source. There are Windows based and non-Windows based highly accurate, Windows compatible, NTP Time source hardware sold by 3rd-party vendors. Please check with your vendor on the accuracy of their products.

>[!IMPORTANT]
>**Time accuracy**<br>
>Time accuracy entails the end-to-end distribution of accurate time from a highly accurate authoritative time source to the end device. Anything that introduces network asymmetry will negatively influence accuracy, for example physical network devices or high CPU load on the target system.

## High Accuracy Requirements

The rest of this document outlines the environmental requirements that must be satisfied to support the respective high accuracy targets.

### Target Accuracy: 1 Second (1s)

To achieve 1s accuracy for a specific target machine when compared to a highly accurate time source:

-   The target system must run Windows 10, Windows Server 2016.

-   The target system must synchronize time from an NTP hierarchy of time servers, culminating in a highly accurate, Windows compatible NTP time source.

-   All Windows operating systems in the NTP hierarchy mentioned above must be configured as documented in the [Configuring Systems for High Accuracy](configuring-systems-for-high-accuracy.md) documentation.

-   The cumulative one-way network latency between the target and source must not exceed 100ms. The cumulative network delay is measured by adding the individual one-way delays between pairs of NTP client-server nodes in the hierarchy starting with the target and ending at the source. For more information, please review the high accuracy time sync document.

### Target Accuracy: 50 Milliseconds

All requirements outlined in the section **Target Accuracy: 1 Second** apply, except where stricter controls are outlined in this section.

The additional requirements to achieve 50ms accuracy for a specific target system are:

-   The target computer must have better than 5ms of network latency between its time source.

-   The target system must be no further than stratum 5 from a highly accurate time source

    >[!Note]
    >Run "w32tm /query /status" from the command line to see the stratum.

-   The target system must be within 6 or less network hops from the highly accurate time source

-   The one-day average CPU utilization on all stratums must not exceed 90%

-   For virtualized systems, the one-day average CPU utilization of the host must not exceed 90%

### Target Accuracy: 1 Millisecond

All requirements outlined in the sections **Target Accuracy: 1 Second** and **Target Accuracy: 50 Milliseconds** apply, except where stricter controls are outlined in this section.

The additional requirements to achieve 1 ms accuracy for a specific target system are:

-   The target computer must have better than 0.1 ms of network latency between its time source

-   The target system must be no further than stratum 5 from a highly accurate time source

    >[!Note]
    >Run `w32tm /query /status' from the command line to see the stratum

-   The target system must be within 4 or less network hops from the highly accurate time source

-   The one-day average CPU utilization across each stratum must not exceed 80%

-   For virtualized systems, the one-day average CPU utilization of the host must not exceed 80%
