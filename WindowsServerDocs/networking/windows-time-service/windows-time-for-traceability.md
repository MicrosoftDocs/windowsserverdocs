---
ms.assetid: 
title: Windows Time for Traceability
description: Regulations in many sectors require systems to be traceable to UTC.  This means that a system's offset can be attested with respect to UTC. 
author: shortpatti
ms.author: dacuo
manager: alanth
ms.date: 4/16/2018
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: networking
---

# Windows Time for Traceability

## Introduction

Regulations in many sectors require systems to be traceable to UTC.  This means that a system's offset can be attested with respect to UTC.  To enable regulatory compliance scenarios, Windows 10 and Server 2016 provides new event logs to provide a picture from the perspective of the Operating System to form an understanding of the actions taken on the system clock.  These event logs are generated continuously for Windows Time service and can be examined or archived for later analysis.

These new events enable the following questions to be answered:

* Was the system clock altered
* Was the clock frequency modified
* Was the Windows Time service configuration modified

## Availability

These improvements are included in Windows 10 version 1703 and Windows Server 2016 version 1709 or later.

## Configuration

No configuration is required to realize this feature.  These event logs are enabled by default and can be found in the event viewer under the **Applications and Services Log\Microsoft\Windows\Time-Service\Operational** channel.


## List of Event Logs

The following section outlines the events logged for use in traceability scenarios.

<!-- use tabs like the group policies -->


### Service Start

#### Details

This event is logged when the Windows Time Service (W32Time) is started and logs information about the current time, current tick count, runtime configuration, time providers, and current clock rate.

* EventID: 257
* Data Logged:
    * Current Time in UTC
    * Current Tick Count
    * W32Time Configuration
    * Time Provider Configuration
    * Clock Rate
* Throttling Mechanism: None. This event fires every time the service starts.

#### Example Text
<!-- figure out how to incorporate example-->

```
W32time service has started at 2018-02-27T04:25:17.156Z (UTC), System Tick Count 3132937.
```

#### Command

This information can also be queried using the following commands

*W32Time and Time Provider configuration*
```
w32tm.exe /query /configuration
```

*Clock Rate*
```
w32tm.exe /query /status /verbose
```

### Service Stop

#### Details

This event is logged when the Windows Time Service (W32Time) is stopping and logs information about the current time and tick count.

* EventID: 258
* Data Logged:
    * Current Time in UTC
    * Current Tick Count
* Throttling Mechanism: None. This event fires every time the service stops.

#### Example Text
```
W32time service is stopping at 2018-03-01T05:42:13.944Z (UTC), System Tick Count 6370250.
```

### NTP Client Provider Periodic Status

#### Details

This event periodically logs its current list of time sources and its chosen time source.  In addition, it logs the current tick count.  This event does not fire each time a time source changes.  Other events listed later in this document provide this functionality.

* EventID: 259
* Data Logged:
    * Available time sources
    * The chosen reference time server at the time of logging
    * Current Tick Count
* Throttling Mechanism: None. This event typically fires every 8 hours.

#### Example Text

NTP Client provider periodic status:

Ntp Client is receiving time data from the following NTP Servers:

server1.fabrikam.com,0x8 (ntp.m|0x8|[::]:123->[IPAddress]:123)server2.fabrikam.com,0x8 (ntp.m|0x8|[::]:123->[IPAddress]:123);  and the chosen reference time server is Server1.fabrikam.com,0x8 (ntp.m|0x8|[::]:123->[IPAddress]:123) (RefID:0x08d6648e63). System Tick Count 13187937

#### Command

This information can also be queried using the following commands

*Identify Peers*
```
w32tm.exe /query /peers
```
