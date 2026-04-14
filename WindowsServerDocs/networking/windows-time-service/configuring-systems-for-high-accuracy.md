---
title: Configuring systems for high accuracy in Windows
description: Improve Windows Time synchronization tuning under reasonable operating conditions where systems can be configured to maintain 1 ms (millisecond) accuracy or better with respect to UTC.
author: robinharwood
ms.author: roharwoo
ms.date: 02/25/2025
ms.topic: how-to
---

# Configuring systems for high accuracy

Time synchronization in Windows 10 and Windows Server 2016 is enhanced. Under optimal conditions, these systems can be configured to achieve and maintain an accuracy of 1 millisecond (ms) or better with respect to UTC.

> [!WARNING]
> Windows Server 2012 R2 and previous releases doesn't meet the same high accuracy objectives. These operating systems aren't supported for high accuracy. In these versions, the Windows Time service satisfied the following requirements:
>
> - Provided the necessary time accuracy to satisfy Kerberos version 5 authentication requirements.
> - Provided loosely accurate time for Windows clients and servers joined to a common Active Directory forest.
>
> Greater tolerances on 2012 R2 and previous releases are outside the design specification of the Windows Time service.

## Windows 10 and Windows Server 2016 default configuration

While we support accuracy up to 1 ms on Windows 10 or Windows Server 2016, most customers don't require highly accurate time.

As such, the **default configuration** is intended to satisfy the same requirements as prior operating systems that:

- Provide the necessary time accuracy to satisfy Kerberos version 5 authentication requirements.
- Provide loosely accurate time for Windows clients and servers joined to a common Active Directory forest.

## How to configure systems for high accuracy

Time accuracy entails the end-to-end distribution of accurate time from the authoritative time source to the end device. Anything that adds asymmetry in measurements along this path negatively influences the accuracy achievable on your devices.

For this reason, the [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md) is documented outlining the environmental requirements that must also be satisfied to reach high accuracy targets.

### Operating System requirements

High accuracy configurations require Windows 10 or Windows Server 2016. All Windows devices in the time topology must meet this requirement including higher stratum Windows time servers, and in virtualized scenarios, the Hyper-V Hosts that run the time-sensitive virtual machines. All of these devices must be at least Windows 10 or Windows Server 2016.

In the following illustration, the virtual machines requiring high accuracy are running Windows 10 or Windows Server 2016. Likewise, the Hyper-V Host on which the virtual machines reside, and the upstream Windows time server must also run Windows Server 2016.

![A diagram that shows three virtual machines connected to a Windows Server 2016 Hyper-V host utilizing the Windows Time service.](../media/Windows-Time-Service/Configuring-Systems-for-High-Accuracy/topology-2016.png)

> [!TIP]
> You can run the `winver` command in a command prompt or through PowerShell to view the OS version and build number:
>
> ![A screenshot of the w i n v e r command displaying Windows Server 2016 version 1607 and operating system build 14393.](../media/Windows-Time-Service/Configuring-Systems-for-High-Accuracy/winver-2016.png)

### System configuration

Reaching high accuracy targets requires system configuration. There are various ways to perform this configuration, including directly in the registry or through group policy. More information for each of these settings can be found in the [Windows Time Service Technical Reference: Windows Time Service Tools](Windows-Time-Service-Tools-and-Settings.md#windows-time-service-tools-and-settings).

### Windows Time service startup type

To ensure the Windows Time service (W32Time) runs continuously, set its startup type to **Automatic**.

![A screenshot of the Windows Time service properties box displaying its startup type set to automatic.](../media/Windows-Time-Service/Configuring-Systems-for-High-Accuracy/automatic-service.png)

### Cumulative one-way network latency

Measurement uncertainty and "noise" increases network latency. As such, it's imperative that a network latency be within a reasonable boundary. The specific requirements are dependent on your target accuracy and are outlined in the [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md) article.

To calculate the cumulative one-way network latency, add the individual one-way delays between pairs of Network Time Protocol (NTP) client-server nodes in the time topology, starting with the target and ending at the high-accuracy stratum 1 time source.

For example: Consider a time sync hierarchy with a highly accurate source, two intermediary NTP servers A and B, and the target machine in that order. To obtain the cumulative network latency between the target and source, measure the average individual NTP roundtrip times (RTTs) between:

- The target and time server B
- Time server B and time server A
- Time server A and the Source

This measurement can be obtained using the inbox `w32tm.exe` tool by performing the following steps:

1. Perform the calculation from the target and time server B.

   ```cmd
   w32tm /stripchart /computer:TimeServerB /rdtsc /samples:450 > c:\temp\Target_TsB.csv
   ```

1. Perform the calculation from time server B against (pointed at) time server A.

   ```cmd
   w32tm /stripchart /computer:TimeServerA /rdtsc /samples:450 > c:\temp\Target_TsA.csv
   ```

1. Perform the calculation from time server A against the source.

1. Next, add the average RoundTripDelay measured in the previous step and divide by 2 to obtain the cumulative network delay between target and source.

## Registry settings

### MinPollInterval

Configures the smallest interval in log2 seconds allowed for system polling.

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 6 |
| Outcome | The minimum polling interval is now 64 seconds. |

### MaxPollInterval

Configures the largest interval in log2 seconds allowed for system polling.

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 6 |
| Outcome | The maximum polling interval is now 64 seconds. |

### UpdateInterval

The number of clock ticks between phase correction adjustments.

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 100 |
| Outcome | The number of clock ticks between phase correction adjustments is now 100 ticks. |

### SpecialPollInterval

Configures the poll interval in seconds when the SpecialInterval 0x1 flag is enabled.

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient |
| Setting | 64 |
| Outcome | The poll interval is now 64 seconds. |

### FrequencyCorrectRate

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 2 |

### UtilizeSslTimeData

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 0 |
| Outcome | Secure Time Seeding feature is disabled. |

## Applying modified registry settings


The following command signals Windows Time to pick up the updated settings:

```cmd
w32tm /config /update
```

The following command restarts Windows Time to pick up the updated settings:

```cmd
net stop w32time && net start w32time
```

Applying UtilizeSslTimeData setting change requires system restart.


> [!NOTE]
> To learn more about the W32Time registry settings, see [W32Time registry reference](Windows-Time-Service-Tools-and-Settings.md#w32time-registry-reference)

