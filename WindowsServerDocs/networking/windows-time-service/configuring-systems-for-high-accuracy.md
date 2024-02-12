---
ms.assetid:
title: Configuring systems for high accuracy
description: Improve Windows Time synchronization tuning under reasonable operating conditions where systems can be configured to maintain 1 ms (millisecond) accuracy or better with respect to UTC.
author: xelu86
ms.author: wscontent
ms.date: 05/30/2023
ms.topic: article
---

# Configuring systems for high accuracy

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows 11, Windows 10 version 1607 and later, Azure Stack HCI versions 21H2 and 20H2

Time synchronization in Windows 10 and Windows Server 2016 has been substantially improved. Under reasonable operating conditions, systems can be configured to maintain 1 ms (millisecond) accuracy or better (with respect to UTC).

> [!WARNING]
> Windows Server 2012 R2 and below can not meet the same high accuracy objectives. These operating systems are not supported for high accuracy. In these versions, the Windows Time service satisfied the following requirements:
>
> - Provided the necessary time accuracy to satisfy Kerberos version 5 authentication requirements.
> - Provided loosely accurate time for Windows clients and servers joined to a common Active Directory forest.
>
> Greater tolerances on 2012 R2 and below are outside the design specification of the Windows Time service.

## Windows 10 and Windows Server 2016 default configuration

While we support accuracy up to 1 ms on Windows 10 or Windows Server 2016, most customers don't require highly accurate time.

As such, the **default configuration** is intended to satisfy the same requirements as prior operating systems that:

- Provide the necessary time accuracy to satisfy Kerberos version 5 authentication requirements.
- Provide loosely accurate time for Windows clients and servers joined to a common Active Directory forest.

## How to configure systems for high accuracy

Time accuracy entails the end-to-end distribution of accurate time from the authoritative time source to the end device. Anything that adds asymmetry in measurements along this path will negatively influence the accuracy achievable on your devices.

For this reason, we have documented the [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md) outlining the environmental requirements that must also be satisfied to reach high accuracy targets.

### Operating System requirements

High accuracy configurations require Windows 10 or Windows Server 2016. All Windows devices in the time topology must meet this requirement including higher stratum Windows time servers, and in virtualized scenarios, the Hyper-V Hosts that run the time-sensitive virtual machines. All of these devices must be at least Windows 10 or Windows Server 2016.

In the illustration shown below, the virtual machines requiring high accuracy are running Windows 10 or Windows Server 2016. Likewise, the Hyper-V Host on which the virtual machines reside, and the upstream Windows time server must also run Windows Server 2016.

![A diagram that shows three virtual machines connected to a Windows Server 2016 Hyper-V host utilizing the Windows Time service.](../media/Windows-Time-Service/Configuring-Systems-for-High-Accuracy/topology-2016.png)

> [!TIP]
> You can run the command `winver` at a command prompt to verify the OS version is 1607 (or higher) and OS Build is 14393 (or higher) as shown below:
>
> ![A screenshot of the winver command displaying Windows Server 2016 version 1607 and operating system build 14393.](../media/Windows-Time-Service/Configuring-Systems-for-High-Accuracy/winver-2016.png)

### System configuration

Reaching high accuracy targets requires system configuration. There are various ways to perform this configuration, including directly in the registry or through group policy. More information for each of these settings can be found in the [Windows Time Service Technical Reference: Windows Time Service Tools](Windows-Time-Service-Tools-and-Settings.md#windows-time-service-tools-and-settings).

### Windows Time service startup type

The Windows Time service (W32Time) must run continuously. To do this, configure the Windows Time service's startup type to "Automatic" start.

![A screenshot of the Windows Time service properties box displaying its startup type set to automatic.](../media/Windows-Time-Service/Configuring-Systems-for-High-Accuracy/automatic-service.png)

### Cumulative one-way network latency

Measurement uncertainty and "noise" increases network latency. As such, it's imperative that a network latency be within a reasonable boundary. The specific requirements are dependent on your target accuracy and are outlined in the [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md) article.

To calculate the cumulative one-way network latency, add the individual one-way delays between pairs of NTP client-server nodes in the time topology, starting with the target and ending at the high-accuracy stratum 1 time source.

For example: Consider a time sync hierarchy with a highly accurate source, two intermediary NTP servers A and B, and the target machine in that order. To obtain the cumulative network latency between the target and source, measure the average individual NTP roundtrip times (RTTs) between:

- The target and time server B
- Time server B and time server A
- Time server A and the Source

This measurement can be obtained using the inbox w32tm.exe tool. To do this:

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

The following command signals Windows Time to pick up the updated settings:

```cmd
w32tm /config /update
```

### MaxPollInterval

Configures the largest interval in log2 seconds allowed for system polling.

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 6 |
| Outcome | The maximum polling interval is now 64 seconds. |

The following command signals Windows Time to pick up the updated settings:

```cmd
w32tm /config /update
```

### UpdateInterval

The number of clock ticks between phase correction adjustments.

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 100 |
| Outcome | The number of clock ticks between phase correction adjustments is now 100 ticks. |

The following command signals Windows Time to pick up the updated settings:

```cmd
w32tm /config /update
```

### SpecialPollInterval

Configures the poll interval in seconds when the SpecialInterval 0x1 flag is enabled.

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient |
| Setting | 64 |
| Outcome | The poll interval is now 64 seconds. |

The following command restarts Windows Time to pick up the updated settings:

```cmd
net stop w32time && net start w32time
```

### FrequencyCorrectRate

| Description | Value |
|--|--|
| Key location | HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config |
| Setting | 2 |

> [!NOTE]
> To learn more about the W32Time registry settings, see [Windows Time registry reference](Windows-Time-Service-Tools-and-Settings.md#windows-time-registry-reference)
