---
ms.assetid: 
title: Windows Time for Traceability
description: Regulations in many sectors require systems to be traceable to UTC.  This means that a system's offset can be attested with respect to UTC. 
author: eross-msft
ms.author: dacuo
manager: dougkim
ms.date: 10/17/2018
ms.topic: article
ms.prod: windows-server
ms.technology: networking
---

# Windows Time for Traceability
>Applies to: Windows Server 2016 version 1709 or later, and Windows 10 version 1703 or later


Regulations in many sectors require systems to be traceable to UTC.  This means that a system's offset can be attested with respect to UTC.  To enable regulatory compliance scenarios, Windows 10 (version 1703 or higher) and Windows Server 2016 (version 1709 or higher) provides new event logs to provide a picture from the perspective of the Operating System to form an understanding of the actions taken on the system clock.  These event logs are generated continuously for Windows Time service and can be examined or archived for later analysis.

These new events enable the following questions to be answered:

* Was the system clock altered
* Was the clock frequency modified
* Was the Windows Time service configuration modified

## Availability

These improvements are included in Windows 10 version 1703 or higher, and Windows Server 2016 version 1709 or higher.

## Configuration

No configuration is required to realize this feature.  These event logs are enabled by default and can be found in the event viewer under the **Applications and Services Log\Microsoft\Windows\Time-Service\Operational** channel.


## List of Event Logs

The following section outlines the events logged for use in traceability scenarios.

# [257](#tab/257)
This event is logged when the Windows Time Service (W32Time) is started and logs information about the current time, current tick count, runtime configuration, time providers, and current clock rate.

|||
|---|---|
|Event description |Service Start |
|Details |Occurs at W32time Startup |
|Data logged |<ul><li>Current Time in UTC</li><li>Current Tick Count</li><li>W32Time Configuration</li><li>Time Provider Configuration</li><li>Clock Rate</li></ul> |
|Throttling mechanism  |None. This event fires every time the service starts. |

**Example:**
```
W32time service has started at 2018-02-27T04:25:17.156Z (UTC), System Tick Count 3132937.
```

**Command:**

This information can also be queried using the following commands

*W32Time and Time Provider configuration*
```
w32tm.exe /query /configuration
```

*Clock Rate*
```
w32tm.exe /query /status /verbose
```


# [258](#tab/258)
This event is logged when the Windows Time Service (W32Time) is stopping and logs information about the current time and tick count.

|||
|---|---|
|Event description |Service Stop |
|Details |Occurs at W32time Shutdown |
|Data logged |<ul><li>Current Time in UTC</li><li>Current Tick Count</li></ul> |
|Throttling mechanism  |None. This event fires every time the service stops. |

**Example text:**
`W32time service is stopping at 2018-03-01T05:42:13.944Z (UTC), System Tick Count 6370250.`

# [259](#tab/259)
This event periodically logs its current list of time sources and its chosen time source.  In addition, it logs the current tick count.  This event does not fire each time a time source changes.  Other events listed later in this document provide this functionality.

|||
|---|---|
|Event description |NTP Client Provider Periodic Status |
|Details |List of time sources(s) used by NTP Client |
|Data logged |<ul><li>Available time sources</li><li>The chosen reference time server at the time of logging</li><li>Current Tick Count</li></ul>  |
|Throttling mechanism  |Logged once every 8 hours. |

**Example text:**
NTP Client provider periodic status:

Ntp Client is receiving time data from the following NTP Servers:

server1.fabrikam.com,0x8 (ntp.m|0x8|[::]:123->[IPAddress]:123)server2.fabrikam.com,0x8 (ntp.m|0x8|[::]:123->[IPAddress]:123);  and the chosen reference time server is Server1.fabrikam.com,0x8 (ntp.m|0x8|[::]:123->[IPAddress]:123) (RefID:0x08d6648e63). System Tick Count 13187937

**Command**
This information can also be queried using the following commands

*Identify Peers*
`w32tm.exe /query /peers`

# [260](#tab/260)

|||
|---|---|
|Event description |Time service configuration and status |
|Details |W32time periodically logs its configuration and status. This is the equivalent of calling:<br><br>`w32tm /query /configuration /verbose`<br>OR<br>`w32tm /query /status /verbose` |
|Throttling mechanism  |Logged once every 8 hours. |

# [261](#tab/261)
This logs each instance when System Time is modified using SetSystemTime API.

|||
|---|---|
|Event description |System Time is set |
|Throttling mechanism  |None.<br><br>This should happen rarely on systems with reasonable time synchronization, and we want to log it each time it occurs. We ignore TimeJumpAuditOffset setting while logging this event since that setting was meant to throttle events in the Windows System event log. |

# [262](#tab/262)

|||
|---|---|
|Event description |System clock frequency adjusted |
|Details |System clock frequency is constantly modified by W32time when the clock is in close synchronization. We want to capture “reasonably significant” adjustments made to the clock frequency without overrunning the event log. |
|Throttling mechanism  |All clock adjustments below TimeAdjustmentAuditThreshold (min = 128 part per million, default = 800 part per million) are not logged.<br><br>2 PPM change in clock frequency with current granularity yields 120 µsec/sec change in clock accuracy.<br><br>On a synchronized system, the majority of the adjustments are below this level. If you want finer tracking, this setting can be adjusted down or you can use PerfCounters, or you can do both. |

# [263](#tab/263)

|||
|---|---|
|Event description |Change in the Time service settings or list of loaded time providers. |
|Details |Re-reading W32time settings can cause certain critical settings to be modified in-memory, which can affect the overall accuracy of the time synchronization.<br><br>W32time logs each occurrence when rereading its settings which gives the potential impact on time synchronization. |
|Throttling mechanism  |None.<br><br>This event occurs only when an admin or GP update changes the time providers and then triggers W32time. We want to record each instance of change of settings. |


# [264](#tab/264)

|||
|---|---|
|Event description |Change in time source(s) used by NTP Client |
|Details |NTP Client records an event with the current state of the time servers/peers when a time server/peer changes state (**Pending ->Sync**, **Sync -> unreachable**, or other transitions) |
|Throttling mechanism  |Max frequency – only once every 5 minutes to protect the log from transient issues and bad provider implementation. |

# [265](#tab/265)

|||
|---|---|
|Event description |Time service source or stratum number changes |
|Details |W32time Time Source and Stratum Number are important factors in time traceability and any changes to these must be logged. If W32time has no source of time and you have not configured as a reliable time source, then it will stop advertising as a time server, and by-design respond to requests with some invalid parameters. This event is critical to track the state changes in an NTP topology. |
|Throttling mechanism  |None. |


# [266](#tab/266)

|||
|---|---|
|Event description |Time re-synchronization is requested |
|Details |This operation is triggered:<ul><li>When network changes occur</li><li>System returns from connected standby/hibernation</li><li>When we didn't sync for a long time</li><li>Admin issues the resync command</li></ul>This operation results in immediate loss of fine-grained time sync accuracy because it causes NTP client to clear its filters. |
|Throttling mechanism  |Max frequency - once every 5 minutes.<br><br>It is possible that a bad network card (or a poor script) can trigger this operation repeatedly and result in logs getting overwhelmed. Hence the need to throttle this event.<br><br>Note that accurate time sync takes far more than 5 minutes to achieve, and throttling does not lose information about the original event that resulted in loss of time accuracy.  |

---
