---
ms.assetid: e34622ff-b2d0-4f81-8d00-dacd5d6c215e
title: Time Accuracy Improvements for Windows Server 2016
description: Time synchronization accuracy in Windows Server 2016 has been improved substantially, while maintaining full backwards NTP compatibility with older Windows versions. 
author: shortpatti
ms.author: pashort
manager: alanth
ms.date: 02/01/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: networking
---

# Time Accuracy Improvements for Windows Server 2016

>Applies To: Windows Server 2016

Time synchronization accuracy in Windows Server 2016 has been improved substantially, while maintaining full backwards NTP compatibility with older Windows versions.  Under reasonable operating conditions you can maintain a 1 ms accuracy with respect to UTC or better for Windows Server 2016 and Windows 10 Anniversary Update domain members.

## Windows Time Service and NTP
Windows Server 2016 has improved the algorithms it uses to correct time and condition the local clock to synchronize with UTC.  NTP uses 4 values to calculate the time offset, based on the timestamps of the client request/response and server request/response.  However, networks are noisy, and there can be spikes in the data from NTP due to network congestion and other factors that affect network latency.  Windows 2016 algorithms average out this noise using a number of different techniques which results in a stable and accurate clock.  Additionally, the source we use for accurate time references an improved API which gives us better resolution.  With these improvements we are able to achieve 1 ms accuracy with regards to UTC across a domain.

## Hyper-V
Windows 2016 has improved the Hyper-V TimeSync service. Improvements include more accurate initial time on VM start or VM restore and interrupt latency correction for samples provided to w32time.  This improvement allows us to stay with-in 10µs of the host with an RMS, (Root Mean Squared, which indicates variance), of 50µs, even on a machine with 75% load.

> [!NOTE]
> See this article on [Hyper-V architecture](https://msdn.microsoft.com/library/cc768520.aspx) for more information.

> [!NOTE]
> Load was created using prime95 benchmark using balanced profile.

Additionally, the stratum level that the Host reports to the guest is more transparent.  Previously the Host would present a fixed stratum of 2, regardless of its accuracy.  With the changes in Windows Server 2016, the host reports a stratum one greater than the host stratum, which results in better time for virtual guests.  The host stratum is determined by w32time through normal means based on its source time.  Domain joined Windows 2016 guests will find the most accurate clock, rather than defaulting to the host.  It was for this reason that we advised to manually disable Hyper-V Time Provider setting for machines participating in a domain in Windows 2012R2 and below.

## Monitoring
Performance monitor counters have been added.  These allow you to baseline, monitor, and troubleshoot time accuracy.  These counters include:

Counter|Description|
----- | ----- |
Computed Time Offset|	The absolute time offset between the system clock and the chosen time source, as computed by W32Time Service in microseconds. When a new valid sample is available, the computed time is updated with the time offset indicated by the sample. This is the actual time offset of the local clock. W32time initiates clock correction using this offset and updates the computed time in between samples with the remaining time offset that needs to be applied to the local clock. Clock accuracy can be tracked using this performance counter with a low polling interval (eg:256 seconds or less) and looking for the counter value to be smaller than the desired clock accuracy limit.|
Clock Frequency Adjustment|	The absolute clock frequency adjustment made to the local system clock by W32Time in parts per billion. This counter helps visualize the actions being taken by W32time.|
NTP Roundtrip Delay|	Most recent round-trip delay experienced by the NTP Client in receiving a response from the server in microseconds. This is the time elapsed on the NTP client between transmitting a request to the NTP server and receiving a valid response from the server. This counter helps characterize the delays experienced by the NTP client. Larger or varying roundtrips can add noise to NTP time computations, which in turn may affect the accuracy of time synchronization through NTP.|
NTP Client Source Count|	Active number of NTP Time sources being used by the NTP Client. This is a count of active, distinct IP addresses of time servers that are responding to this client’s requests. This number may be larger or smaller than the configured peers, depending on DNS resolution of peer names and current reach-ability.|
NTP Server Incoming Requests|	Number of requests received by the NTP Server (Requests/Sec).|
NTP Server Outgoing Responses|	Number of requests answered by NTP Server (Responses/Sec).|

The first 3 counters target scenarios for troubleshooting accuracy issues.  The Troubleshooting Time Accuracy and NTP section below, under [Best Practices](#BestPractices), has more detail.
The last 3 counters cover NTP server scenarios and are helpful when determine the load and baselining your current performance.

## Configuration Updates per Environment
The following describes the changes in default configuration between Windows 2016 and previous versions for each Role.  The settings for Windows Server 2016 and Windows 10 Anniversary Update (build 14393), are now unique which is why there are shown as separate columns. 

|Role|Setting|Windows Server 2016|Windows 10 Version 1607|Windows Server 2012 R2</br>Windows Server 2008 R2</br>Windows 10|
|---|---|---|---|---|
|**Standalone/Nano Server**||||
| |*Time Server*|time.windows.com|NA|time.windows.com|
| |*Polling Frequency*|64 - 1024 seconds|NA|Once a week|
| |*Clock Update Frequency*|Once a second|NA|Once a hour|
|**Standalone Client**||||
| |*Time Server*|NA|time.windows.com|time.windows.com|
| |*Polling Frequency*|NA|Once a day|Once a week|
| |*Clock Update Frequency*|NA|Once a day|Once a week|
|**Domain Controller**||||
| |*Time Server*|PDC/GTIMESERV|NA|PDC/GTIMESERV|
| |*Polling Frequency*|64 -1024 seconds|NA|1024 - 32768 seconds|
| |*Clock Update Frequency*|Once a day|NA|Once a week|
|**Domain Member Server**||||
| |*Time Server*|DC|NA|DC|
| |*Polling Frequency*|64 -1024 seconds|NA|1024 - 32768 seconds|
| |*Clock Update Frequency*|Once a second|NA|Once every 5 minutes|
|**Domain Member Client**||||
| |*Time Server*|NA|DC|DC|
| |*Polling Frequency*|NA|1204 - 32768 seconds|1024 - 32768 seconds|
| |*Clock Update Frequency*|NA|Once every 5 minutes|Once every 5 minutes|
|**Hyper-V Guest**||||
| |*Time Server*|Chooses best option based on stratum of Host and Time server|Chooses best option based on stratum of Host and Time server|Defaults to Host|
| |*Polling Frequency*|Based on Role above|Based on Role above|Based on Role above|
| |*Clock Update Frequency*|Based on Role above|Based on Role above|Based on Role above|

>[!NOTE]
>For Linux in Hyper-V, see the [Allowing Linux to use Hyper-V Host Time](#AllowingLinux) in the Best Practices section.

## Impact of increased polling and clock update frequency
<!-- Is this an improvement to WS2016? -->
In order to provide more accurate time, the defaults for polling frequencies and clock updates are increased which allow us to make small adjustments more frequently.  This will cause more UDP/NTP traffic, however, these packets are small so there should be very little or no impact over broadband links. The benefit, however, is that time should be better on a wider variety of hardware and environments.

For battery backed devices, increasing the polling frequency can cause issues.  Battery devices don’t store the time while turned off.  When they resume, it may require frequent corrections to the clock.  Increasing the polling frequency will cause the clock to become unstable and could also use more power.  Microsoft recommends you do not change the client default settings.

Domain Controllers should be minimally impacted even with the multiplied effect of the increased updates from NTP Clients in an AD Domain.  NTP has a much smaller resource consumption as compared to other protocols and a marginal impact.  You are more likely to reach limits for other domain functionality before being impacted by the increased settings for Windows Server 2016.  Active Directory does use secure NTP, which tends to sync time less accurately than simple NTP, but we’ve verified it will scale up to clients two stratum away from the PDC.

As a conservative plan, you should reserve 100 NTP requests per second per core.  For instance, a domain made up of 4 DCs with 4 cores each, you should be able to serve 1600 NTP requests per second.  If you have 10k clients configured to sync time once every 64 seconds, and the requests are received uniformly over time, you would see 10,000/64 or around 160 requests/second, spread across all DCs.  This falls easily within our 1600 NTP requests/sec based on this example.  These are conservative planning recommendations and of course have a large dependency on your network, processor speeds and loads, so as always baseline and test in your environments.

It is also important to note that if your DCs are running with a considerable CPU load, greater than 40%, this will almost certainly add noise to NTP responses and affect your time accuracy in your domain.  Again, you need to test in your environment to understand the actual results.