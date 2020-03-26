---
ms.assetid: 72a90d00-56ee-48a9-9fae-64cbad29556c
title: Accurate Time for Windows Server 2016
description: Time synchronization accuracy in Windows Server 2016 has been improved substantially, while maintaining full backwards NTP compatibility with older Windows versions.
author: eross-msft
ms.author: dacuo
ms.date: 05/08/2018
ms.topic: article
ms.prod: windows-server
ms.technology: networking
---

# Accurate Time for Windows Server 2016

>Applies to: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10 or later

The Windows Time service is a component that uses a plug-in model for client and server time synchronization providers.  There are two built-in client providers on Windows, and there are third-party plug-ins available. One provider uses [NTP (RFC 1305)](https://tools.ietf.org/html/rfc1305) or [MS-NTP](https://msdn.microsoft.com/library/cc246877.aspx) to synchronize the local system time to an NTP and/or MS-NTP compliant reference server. The other provider is for Hyper-V and synchronizes virtual machines (VM) to the Hyper-V host.  When multiple providers exist, Windows will pick the best provider using stratum level first, followed by root delay, root dispersion, and finally time offset.

> [!NOTE]
> For a quick overview of Windows Time service, take a look at this [high-level overview video](https://aka.ms/WS2016TimeVideo).

In this topic, we discuss ... these topics as they relate to enabling accurate time: 

- Improvements
- Measurements
- Best Practices

> [!IMPORTANT]
> An addendum referenced by the Windows 2016 Accurate Time article can be downloaded [here](https://windocs.blob.core.windows.net/windocs/WindowsTimeSyncAccuracy_Addendum.pdf).  This document provides more details about our testing and measurement methodologies.

> [!NOTE] 
> The windows time provider plugin model is [documented on TechNet](https://msdn.microsoft.com/library/windows/desktop/ms725475%28v=vs.85%29.aspx).

## Domain Hierarchy
Domain and Standalone configurations work differently.

- Domain members use a secure NTP protocol, which uses authentication to ensure the security and authenticity of the time reference.  Domain members synchronize with a master clock determined by the domain hierarchy and a scoring system.  In a domain, there is a hierarchical layer of time stratums, whereby each DC points to a parent DC with a more accurate time stratum.  The hierarchy resolves to the PDC or a DC in the root forest, or a DC with the GTIMESERV domain flag, which denotes a Good Time Server for the domain.  See the [Specify a Local Reliable Time Service Using GTIMESERV section below.

- Standalone machines are configured to use time.windows.com by default.  This name is resolved by your DNS Server, which should point to a Microsoft owned resource.  Like all remotely located time references, network outages, may prevent synchronization.  Network traffic loads and asymmetrical network paths may reduce the accuracy of the time synchronization.  For 1 ms accuracy, you can't depend on a remote time sources.

Since Hyper-V guests will have at least two Windows Time providers to choose from, the host time and NTP, you might see different behaviors with either Domain or Standalone when running as a guest.

> [!NOTE] 
> For more information about the domain hierarchy and scoring system, see the [“What is Windows Time Service?”](https://blogs.msdn.microsoft.com/w32time/2007/07/07/what-is-windows-time-service/) blog post.

> [!NOTE]
> Stratum is a concept used in both the NTP and Hyper-V providers, and its value indicates the clocks location in the hierarchy.  Stratum 1 is reserved for the highest-level clock, and stratum 0 is reserved for the hardware assumed to be accurate and has little or no delay associated with it.  Stratum 2 talk to stratum 1 servers, stratum 3 to stratum 2 and so on.  While a lower stratum often indicates a more accurate clock, it is possible to find discrepancies.  Also, W32time only accepts time from stratum 15 or below.  To see the stratum of a client, use *w32tm /query /status*.

## Critical Factors for Accurate Time
In every case for accurate time, there are three critical factors:

1. **Solid Source Clock** - The source clock in your domain needs to be stable and accurate. This usually means installing a GPS device or pointing to a Stratum 1 source, taking #3 into account. The analogy goes, if you have two boats on the water, and you are trying to measure the altitude of one compared to the other, your accuracy is best if the source boat is very stable and not moving. The same goes for time, and if your source clock isn't stable, then the entire chain of synchronized clocks is affected and magnified at each stage. It also must be accessible because disruptions in the connection will interfere with time synchronization. And finally, it must be secure. If the time reference is not properly maintained, or operated by a potentially malicious party, you could expose your domain to time based attacks.
2. **Stable client clock** - A stable client clocks assures that the natural drift of the oscillator is containable.  NTP uses multiple samples from potentially multiple NTP servers to condition and discipline your local computers clock.  It does not step the time changes, but rather slows or speeds up the local clock so that you approach the accurate time quickly and stay accurate between NTP requests.  However, if the client computer clock's oscillator is not stable, then more fluctuations in between adjustments can occur and the algorithms Windows uses to condition the clock don't work accurately.  In some cases, firmware updates might be needed for accurate time.
3. **Symmetrical NTP communication** - It is critical that the connection for NTP communication is symmetrical.  NTP uses calculations to adjust the time that assume the network patch is symmetrical.  If the path the NTP packet takes going to the server takes a different amount of time to return, the accuracy is affected.  For example, the path could change due to changes in network topology, or packets being routed through devices that have different interface speeds.

For battery powered devices, both mobile and portable, you must consider different strategies.  As per our recommendation, keeping accurate time requires the clock to be disciplined once a second, which correlates to the Clock Update Frequency. These settings will consume more battery power than expected and can interfere with power saving modes available in Windows for such devices. Battery powered devices also have certain power modes which stop all applications from running, which interferes with W32time's ability to discipline the clock and maintain accurate time. Additionally, clocks in mobile devices may not be very accurate to begin with.  Ambient environmental conditions affect clock accuracy and a mobile device can move from one ambient condition to the next which may interfere with its ability to keep time accurately.  Therefore, Microsoft does not recommend that you set up battery powered portable devices with high accuracy settings. 

## Why is time important?  
There are many different reasons you might need accurate time.  The typical case for Windows is Kerberos, which requires 5 minutes of accuracy between the client and server.  However, there are many other areas that can be affected by time accuracy including:


- Government Regulations like:
	- 50 ms accuracy for FINRA in the US
	- 1 ms ESMA (MiFID II) in the EU.
- Cryptography Algorithms
- Distributed systems like Cluster/SQL/Exchange and Document DBs
- Blockchain framework for bitcoin transactions
- Distributed Logs and Threat Analysis 
- AD Replication
- PCI (Payment Card Industry), currently 1 second accuracy



[!INCLUDE [windows-server-2016-improvements](windows-server-2016-improvements.md)]
