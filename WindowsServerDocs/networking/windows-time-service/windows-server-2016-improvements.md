---
title: Time accuracy improvements for Windows Server 2016
description: Windows Server 2016 has improved the algorithms it uses to correct time and condition the local clock to synchronize with UTC.
author: dknappettmsft
ms.author: daknappe
ms.date: 10/17/2018
ms.topic: how-to
---

# Time accuracy improvements for Windows Server 2016

Windows Server 2016 has improved the algorithms it uses to correct time and condition the local clock to synchronize with Coordinated Universal Time (UTC). The Network Time Protocol (NTP) uses four values to calculate the time offset based on the timestamps of the client request/response and server request/response. However, networks are noisy, and there can be spikes in the data from NTP because of network congestion and other factors that affect network latency. Windows Server 2016 algorithms average out this noise by using several different techniques, which results in a stable and accurate clock. The source we use for accurate time also references an improved API, which gives us better resolution. With these improvements, we can achieve 1-ms accuracy regarding UTC across a domain.

## Hyper-V

Windows Server 2016 has improved the Hyper-V TimeSync service. Improvements include more accurate initial time on the virtual machine (VM) start or the VM restore and interrupt latency correction for samples provided to the Windows Time service (W32Time). This improvement allows us to stay within 10µs of the host with a root mean square (which indicates variance) of 50µs, even on a machine with 75% load. For more information, see [Hyper-V architecture](https://msdn.microsoft.com/library/cc768520.aspx).

> [!NOTE]
> Load was created by using the prime95 benchmark using a balanced profile.

The Stratum level that the host reports to the guest is more transparent. Previously, the host would present a fixed Stratum of 2, regardless of its accuracy. With the changes in Windows Server 2016, the host reports a Stratum 1 greater than the host Stratum, which results in better time for virtual guests. The host Stratum is determined by W32Time through normal means based on its source time. Domain-joined Windows Server 2016 guests find the most accurate clock rather than defaulting to the host. For this reason, we advise that you manually disable the **Hyper-V Time Provider** setting for machines participating in a domain in Windows Server 2012 R2 and earlier.

## Monitoring

Performance Monitor counters have been added. These counters allow you to baseline, monitor, and troubleshoot time accuracy. The following table lists the counters.

|Counter|Description|
|----- | ----- |
|Computed Time Offset| The absolute time offset between the system clock and the chosen time source, as computed by the W32Time service in microseconds. When a new valid sample is available, the computed time is updated with the time offset indicated by the sample. This time is the actual time offset of the local clock. W32Time initiates clock correction by using this offset and updates the computed time in between samples with the remaining time offset that needs to be applied to the local clock. Clock accuracy can be tracked by using this performance counter with a low polling interval (for example, 256 seconds or less) and looking for the counter value to be smaller than the desired clock accuracy limit.|
|Clock Frequency Adjustment| The absolute clock frequency adjustment made to the local system clock by W32Time in parts per billion. This counter helps visualize the actions taken by W32Time.|
|NTP Roundtrip Delay| Most recent roundtrip delay experienced by the NTP client in receiving a response from the server in microseconds. This delay is the time elapsed on the NTP client between transmitting a request to the NTP server and receiving a valid response from the server. This counter helps characterize the delays experienced by the NTP client. Larger or varying roundtrips can add noise to NTP time computations, which in turn might affect the accuracy of time synchronization through NTP.|
|NTP Client Source Count| Active number of NTP Time sources being used by the NTP client. This number is a count of active, distinct IP addresses of time servers that are responding to this client's requests. This number might be larger or smaller than the configured peers, depending on DNS resolution of peer names and current reachability.|
|NTP Server Incoming Requests| Number of requests received by the NTP server (requests/sec).|
|NTP Server Outgoing Responses| Number of requests answered by NTP server (responses/sec).|

The first three counters target scenarios for troubleshooting accuracy issues. For more information, see the section **Troubleshoot time accuracy and NTP** later in this article. The last three counters cover NTP server scenarios and are helpful when you're determining the load and baselining your current performance.

## Configuration updates per environment

The following table describes the changes in default configuration between Windows Server 2016 and previous versions for each role. The settings for Windows Server 2016 and Windows 10 Anniversary Update (build 14393) are now unique, which is why they're shown as separate columns.

|Role|Setting|Windows Server 2016|Windows 10|Windows Server 2012 R2<br>Windows Server 2008 R2<br>Windows 10|
|---|---|---|---|---|
|Standalone/Nano Server||||
| |Time Server|time.windows.com|NA|time.windows.com|
| |Polling Frequency|64 - 1024 seconds|NA|Once a week|
| |Clock Update Frequency|Once a second|NA|Once an hour|
|Standalone Client||||
| |Time Server|NA|time.windows.com|time.windows.com|
| |Polling Frequency|NA|Once a day|Once a week|
| |Clock Update Frequency|NA|Once a day|Once an hour|
|Domain Controller||||
| |Time Server|PDC/GTIMESERV|NA|PDC/GTIMESERV|
| |Polling Frequency|64 -1024 seconds|NA|1,024 - 32,768 seconds|
| |Clock Update Frequency|Once a second|NA|Once an hour|
|Domain Member Server||||
| |Time Server|DC|NA|DC|
| |Polling Frequency|64 -1,024 seconds|NA|1,024 - 32,768 seconds|
| |Clock Update Frequency|Once a second|NA|Once every 5 minutes|
|Domain Member Client||||
| |Time Server|NA|DC|DC|
| |Polling Frequency|NA|1,204 - 32,768 seconds|1,024 - 32,768 seconds|
| |Clock Update Frequency|NA|Once every 5 minutes|Once every 5 minutes|
|Hyper-V Guest||||
| |Time Server|Chooses best option based on Stratum of host and time server|Chooses best option based on Stratum of host and time server|Defaults to host|
| |Polling Frequency|Based on role above|Based on role above|Based on role above|
| |Clock Update Frequency|Based on role above|Based on role above|Based on role above|

>[!NOTE]
>For Linux in Hyper-V, see the section **Allow Linux to use Hyper-V host time**.

## Impact of increased polling and clock update frequency

To provide more accurate time, the defaults for polling frequencies and clock updates are increased, which allows us to make small adjustments more frequently. This change causes more User Datagram Protocol (UDP)/NTP traffic. These packets are small, so there should be little or no effect over broadband links. The benefit is that time should be better on a wider variety of hardware and environments.

For battery-backed devices, increasing the polling frequency can cause issues. Battery devices don't store the time while turned off. When they resume, they might require frequent corrections to the clock. Increasing the polling frequency causes the clock to become unstable and could also use more power. We recommend that you don't change the client default settings.

Domain controllers (DCs) should be minimally affected even with the multiplied effect of the increased updates from NTP clients in an Active Directory domain. NTP has a much smaller resource consumption compared to other protocols and a marginal effect. You're more likely to reach limits for other domain functionality before being affected by the increased settings for Windows Server 2016. Active Directory does use secure NTP, which tends to sync time less accurately than simple NTP. We've verified that it can scale up to clients two Stratum away from the primary domain controller (PDC).

As a conservative plan, you should reserve 100 NTP requests per second per core. For instance, with a domain made up of four DCs with four cores each, you should be able to serve 1,600 NTP requests per second. If you have 10,000 clients configured to sync time once every 64 seconds, and the requests are received uniformly over time, you would see 10,000/64, or around 160 requests/second, spread across all DCs. This amount falls easily within our 1,600 NTP requests/sec based on this example. These planning recommendations are conservative and largely depend on your network, processor speeds, and loads. As always, baseline and test in your environments.

If your DCs are running with a considerable CPU load, greater than 40%, this load almost certainly adds noise to NTP responses and affects your time accuracy in your domain. Again, you need to test in your environment to understand the actual results.

## Time accuracy measurements

To measure the time accuracy for Windows Server 2016, we used various tools, methods, and environments. You can use these techniques to measure and tune your environment and determine if the accuracy results meet your requirements.

### Methodology

Our domain source clock consisted of two high-precision NTP servers with GPS hardware. We also used a separate reference test machine for measurements, which also had high-precision GPS hardware installed from a different manufacturer. For some of the testing, you need an accurate and reliable clock source to use as a reference in addition to your domain clock source.

We used four different methods to measure accuracy with both physical and virtual machines. Multiple methods provided independent means to validate the results.

1. Measure the local clock, which is conditioned by `w32tm`, against our reference test machine, which has separate GPS hardware.

1. Measure NTP pings from the NTP server to clients by using the `W32tm` stripchart.

1. Measure NTP pings from the client to the NTP server by using the `W32tm` stripchart.

1. Measure Hyper-V results from the host to the guest by using the Time Stamp Counter (TSC). This counter is shared between both partitions and the system time in both partitions. We calculated the difference of the host time and the client time in the VM. Then we used the TSC clock to interpolate the host time from the guest because the measurements don't happen at the same time. Also, we used the time-segmented volume clock to factor out delays and latency in the API.

`W32tm` is built in, but the other tools we used during our testing are available for the Microsoft repository on GitHub as open source for your testing and use. For more information about how to use the tools to do measurements, see [Windows Time Calibration Tools Wiki](https://github.com/Microsoft/Windows-Time-Calibration-Tools).

The test results shown are a subset of measurements we made in one of the test environments. They illustrate the accuracy maintained at the start of the time hierarchy and the child domain client at the end of the time hierarchy. These results are compared to the same machines in a 2012-based topology for comparison.

### Topology

For comparison, we tested topologies based on Windows Server 2012 R2 and Windows Server 2016. Both topologies consist of two physical Hyper-V host machines that reference a Windows Server 2016 machine with GPS clock hardware installed. Each host runs three domain-joined Windows guests, which are arranged according to the following topology. The lines represent the time hierarchy and the protocol/transport that's used.

![Diagram that shows the Windows time topology with only one child domain client running in the first Hyper-V host.](../media/Windows-Time-Service/Windows-2016-Accurate-Time/topology1.png)

![Diagram that shows the Windows time topology with two child domain clients. One runs in the first Hyper-V host and another runs in the second Hyper-V host.](../media/Windows-Time-Service/Windows-2016-Accurate-Time/topology2.png)

### Graphical results overview

The following two graphs represent the time accuracy for two specific members in a domain based on the preceding topology. Each graph displays both the Windows Server 2012 R2 and 2016 results overlaid, which demonstrates the improvements visually. The accuracy was measured from within the guest machine compared to the host. The graphical data represents a subset of the entire set of tests we performed and shows the best-case and worst-case scenarios.

![Diagram that shows the Windows time topology with the root domain PDC server and the child domain client servers in the first Hyper-V host called out.](../media/Windows-Time-Service/Windows-2016-Accurate-Time/topology3.png)

### Performance of the root domain PDC

The root PDC is synchronized to the Hyper-V host (by using VMIC), which is a Windows Server 2016 with GPS hardware that's proven to be both accurate and stable. This requirement is critical for 1-ms accuracy, which is shown as the shaded area identified by the callout.

![Diagram that shows the root domain.](../media/Windows-Time-Service/Windows-2016-Accurate-Time/chart1.png)

### Performance of the child domain client

The child domain client is attached to a child domain PDC that communicates to the root PDC. Its time is also within the 1-ms requirement.

![Diagram that shows the child domain client.](../media/Windows-Time-Service/Windows-2016-Accurate-Time/chart2.png)

### Long-distance test

The following chart compares one virtual network hop to six physical network hops with Windows Server 2016. Two charts are overlaid on each other with transparency to show overlapping data. Increasing network hops mean higher latency and larger time deviations. The chart is magnified, so the 1-ms bounds, represented by the shaded area, is larger. As you can see, the time is still within 1 ms with multiple hops. It's negatively shifted, which demonstrates a network asymmetry. Every network is different, and measurements depend on many environmental factors.

![Diagram that shows the long-distance test.](../media/Windows-Time-Service/Windows-2016-Accurate-Time/chart3.png)

## Best practices for accurate timekeeping

Follow these best practices for accurate timekeeping.

### Solid source clock

A machine's time is only as good as the source clock with which it synchronizes. To achieve 1 ms of accuracy, you need GPS hardware or a time appliance on your network that you reference as the master source clock. Using the default of `time.windows.com` might not provide a stable and local time source. As you get farther away from the source clock, the network affects the accuracy. Having a master source clock in each datacenter is required for the best accuracy.

### Hardware GPS options

Various hardware solutions can offer accurate time. In general, solutions today are based on GPS antennas. Radio and dial-up modem solutions use dedicated lines. They attach to your network as an appliance or plug into a PC, for instance, Windows via a PCIe or USB device. Different options deliver different levels of accuracy, and as always, results depend on your environment. Variables that affect accuracy include GPS availability, network stability and load, and PC hardware. These factors are all important when you choose a source clock, which is a requirement for stable and accurate time.

### Domain and synchronizing time

Domain members use the domain hierarchy to determine which machine they use as a source to synchronize time. Each domain member finds another machine to sync with and saves it as its clock source. Each type of domain member follows a different set of rules to find a clock source for time synchronization. The PDC in the forest root is the default clock source for all domains. Listed here are different roles and high-level descriptions for how they find a source:

- **Domain controller with PDC role**: This machine is the authoritative time source for a domain. It has the most accurate time available in the domain. It must sync with a DC in the parent domain, except in cases where the GTIMESERV role is enabled.
- **Any other domain controller**: This machine acts as a time source for clients and member servers in the domain. A DC can sync with the PDC of its own domain or any DC in its parent domain.
- **Clients/member servers**: This machine can sync with any DC or PDC of its own domain or a DC or PDC in the parent domain.

Based on the available candidates, a scoring system is used to find the best time source. This system takes into account the reliability of the time source and its relative location. This check happens once when the time service is started. If you need to have finer control of how time synchronizes, you can add good time servers in specific locations or add redundancy. For more information, see the section **Specify a local reliable time service by using GTIMESERV**.

#### Mixed OS environments (Windows Server 2012 R2 and Windows Server 2008 R2)

Although a pure Windows Server 2016 domain environment is required for the best accuracy, there are still benefits in a mixed environment. Deploying Windows Server 2016 Hyper-V in a Windows Server 2012 domain benefits the guests because of the improvements we mentioned, but only if the guests are also on Windows Server 2016. A Windows Server 2016 PDC can deliver more accurate time because of the improved algorithms, so it's a more stable source. Because replacing your PDC might not be an option, you can instead add a Windows Server 2016 DC with the GTIMESERV roll set, which would be an upgrade in accuracy for your domain. A Windows Server 2016 DC can deliver better time to downstream time clients, but it's only as good as its source NTP time.

Also as stated, the clock polling and refresh frequencies were modified with Windows Server 2016. These frequencies can be changed manually to your down-level DCs or applied via Group Policy. We haven't tested these configurations, but they should behave well in Windows Server 2008 R2 and Windows Server 2012 R2 and deliver some benefits.

Versions before Windows Server 2016 had multiple issues with accurate timekeeping, which resulted in the system time drifting immediately after an adjustment was made. Because of this issue, frequently obtaining time samples from an accurate NTP source and conditioning the local clock with the data leads to smaller drift in their system clocks in the intra-sampling period. The result is better timekeeping on down-level OS versions. The best observed accuracy was approximately 5 ms when a Windows Server 2012 R2 NTP client, configured with the high-accuracy settings, synchronized its time from an accurate Windows Server 2016 NTP server.

In some scenarios involving guest DCs, Hyper-V TimeSync samples can disrupt domain time synchronization. This issue should no longer exist for Windows Server 2016 guests running on Windows Server 2016 Hyper-V hosts.

To disable the Hyper-V TimeSync service from providing samples to W32Time, set the following guest registry key:

 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\VMICTimeProvider
 "Enabled"=dword:00000000`

#### Allow Linux to use Hyper-V host time

For Linux guests running in Hyper-V, clients are typically configured to use the NTP daemon for time synchronization against NTP servers. If the Linux distribution supports the TimeSync version 4 protocol and the Linux guest has the TimeSync integration service enabled, it synchronizes against the host time. This scenario could lead to inconsistent timekeeping if both methods are enabled.

To synchronize exclusively against the host time, we recommend that you disable NTP time synchronization by one of two methods:

- Disable any NTP servers in the `ntp.conf` file.
- Disable the NTP daemon.

In this configuration, the Time Server parameter is this host. Its Polling Frequency is 5 seconds and the Clock Update Frequency is also 5 seconds.

To synchronize exclusively over NTP, we recommend that you disable the TimeSync integration service in the guest.

> [!NOTE]
> Support for accurate time with Linux guests requires a feature that's only supported in the latest upstream Linux kernels. The feature isn't widely available across all Linux distros yet. For more information about support distributions, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](../../virtualization/hyper-v/supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows.md).

#### Specify a local reliable time service by using GTIMESERV

You can specify one or more DCs as accurate source clocks by using the Good Time Server flag GTIMESERV. For instance, specific DCs equipped with GPS hardware can be flagged as GTIMESERV. This flag ensures that your domain references a clock based on the GPS hardware.

> [!NOTE]
> For more information about domain flags, see the [MS-ADTS protocol documentation](/openspecs/windows_protocols/ms-winerrata/fe563333-6e4f-4198-9bf5-741a523cd0d7).

TIMESERV is another related Domain Services flag that indicates whether a machine is currently authoritative, which can change if a DC loses connection. A DC in this state returns `Unknown Stratum` when queried via NTP. After trying multiple times, the DC logs System Event Time-Service Event 36.

If you want to configure a DC as GTIMESERV, configure it manually by using the following command. In this case, the DC uses another machine as the master clock. This machine could be an appliance or dedicated machine.


```dockerfile
w32tm /config /manualpeerlist:"master_clock1,0x8 master_clock2,0x8" /syncfromflags:manual /reliable:yes /update
```

> [!NOTE]
> For more information, see [Configure the Windows Time service](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731191(v=ws.10))

If the DC has the GPS hardware installed, use the following steps to disable the NTP client and enable the NTP server.

Start by disabling the NTP client and enable the NTP server by using these registry key changes:

```powershell
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\w32time\TimeProviders\NtpClient /v Enabled /t REG_DWORD /d 0 /f

reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\w32time\TimeProviders\NtpServer /v Enabled /t REG_DWORD /d 1 /f
```

Next, restart the Windows Time service:

```sql
net stop w32time && net start w32time
```

Finally, you indicate that this machine has a reliable time source:

```dockerfile
w32tm /config /reliable:yes /update
```

To check that the changes were done properly, run the following commands, which affect the results shown here:

```sql
w32tm /query /configuration

Value|Expected Setting|
----- | ----- |
AnnounceFlags| 5 (Local)|
NtpServer |(Local)|
DllName |C:\WINDOWS\SYSTEM32\w32time.DLL (Local)|
Enabled |1 (Local)|
NtpClient| (Local)|

w32tm /query /status /verbose

Value| Expected Setting|
----- | ----- |
Stratum| 1 (primary reference - syncd by radio clock)|
ReferenceId| 0x4C4F434C (source name: "LOCAL")|
Source| Local CMOS Clock|
Phase Offset| 0.0000000s|
Server Role| 576 (Reliable Time Service)|
```

#### Windows Server 2016 on third-party virtual platforms

When Windows is virtualized, by default, the Hypervisor is responsible for providing time. But domain-joined members need to be synchronized with the DC for Active Directory to work properly. It's best to disable any time virtualization between the guest and the host of any third-party virtual platforms.

#### Discover the hierarchy

Because the chain of time hierarchy to the master clock source is dynamic in a domain, and negotiated, you need to query the status of a particular machine to understand its time source and chain to the master source clock. This information can help diagnose time synchronization problems.

If you want to troubleshoot a specific client, the first step is to understand its time source by using this `w32tm` command:

```dockerfile
w32tm /query /status
```

The results display the source, among other things. The source indicates with whom you synchronize time in the domain. It's the first step of this machine's time hierarchy. Next, use the source entry from the preceding command and use the `/stripchart` parameter to find the next time source in the chain.

```yaml
w32tm /stripchart /computer:MySourceEntry /packetinfo /samples:1
```

Also useful, the following command lists each DC it can find in the specified domain and prints a result that lets you determine each partner. This command includes machines that were configured manually.

 `w32tm /monitor /domain:my_domain`

By using the list, you can trace the results through the domain and understand the hierarchy and the time offset at each step. By locating the point where the time offset gets significantly worse, you can pinpoint the root of the incorrect time. From there, you can try to understand why that time is incorrect by turning on `w32tm` logging.

#### Use Group Policy
You can use Group Policy to accomplish stricter accuracy by, for instance, assigning clients to use specific NTP servers or to control how down-level operating systems are configured when virtualized. Here's a list of possible scenarios and relevant Group Policy settings:

**Virtualized domains**: To control virtualized DCs in Windows Server 2012 R2 so that they synchronize time with their domain, rather than with the Hyper-V host, you can disable this registry entry. For the PDC, you don't want to disable the entry because the Hyper-V host delivers the most stable time source. The registry entry requires that you restart W32Time after it's changed.

 `[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\VMICTimeProvider]
 "Enabled"=dword:00000000`

**Accuracy sensitive loads**: For time accuracy sensitive workloads, you could configure groups of machines to set the NTP servers and any related time settings, such as polling and clock update frequency. This task is normally handled by the domain, but for more control you could target specific machines to point directly to the master clock.

Group Policy setting| New value|
----- | ----- |
`NtpServer`| `ClockMasterName`,0x8|
`MinPollInterval`| 6 – 64 seconds|
`MaxPollInterval`| 6|
`UpdateInterval`| 100 – Once per second|
`EventLogFlags`| 3 – All special time logging|

> [!NOTE]
> The `NtpServer` and `EventLogFlags` settings are located under System\Windows Time Service\Time Providers by using the **Configure Windows NTP Client** settings. The other three are located under System\Windows Time Service by using the **Global Configuration** settings.

**Remote accuracy sensitive loads remote**: For systems in branch domains, for instance, Retail and the Payment Credit Industry (PCI), Windows uses the current site information and DC Locator to find a local DC, unless there's a manual NTP time source configured. This environment requires 1 second of accuracy, which uses faster convergence to the correct time. This option allows W32Time to move the clock backwards. If this behavior is acceptable and meets your requirements, you can create the following policy. As with any environment, make sure to test and baseline your network.

Group Policy setting| New value|
----- | ----- |
`MaxAllowedPhaseOffset`| 1, but if more than one second, set clock to correct time.|

The `MaxAllowedPhaseOffset` setting is located under System\Windows Time Service by using the **Global Configuration** settings.

> [!NOTE]
> For more information on Group Policy and related entries, see [Windows Time service tools](windows-time-service-tools-and-settings.md) and the Settings article on TechNet.

## Azure and Windows IaaS considerations

Here are some points to consider for Azure and Windows infrastructure as a service (IaaS).

### Azure virtual machine: Active Directory Domain Services
If the Azure VM running Active Directory Domain Services is part of an existing on-premises Active Directory forest, then TimeSync (VMIC) should be disabled. This action allows all DCs in the forest, both physical and virtual, to use a single time-sync hierarchy. For more information, see [Running domain controllers in Hyper-V](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd363553(v=ws.10)).

### Azure virtual machine: Domain-joined machine
If you're hosting a machine that's domain joined to an existing Active Directory forest, virtual or physical, the best practice is to disable TimeSync for the guest and ensure that W32Time is configured to synchronize with its DC via configuring time for `Type=NTP5`.

### Azure virtual machine: Standalone workgroup machine
If the Azure VM isn't joined to a domain, and it isn't a DC, we recommend that you keep the default time configuration and have the VM synchronize with the host.

## Windows application requires accurate time

Here are some actions you can take if your Windows application requires accurate time.

### Time Stamp API
Programs that require the greatest accuracy relative to UTC, and not the passage of time, should use the [GetSystemTimePreciseAsFileTime API](/windows/win32/api/sysinfoapi/nf-sysinfoapi-getsystemtimepreciseasfiletime). Using this API ensures that your application gets System Time, which is conditioned by the Windows Time service.

### UDP performance
If you have an application that uses UDP communication for transactions and it's important to minimize latency, there are some related registry entries you can use to configure a range of ports to be excluded from the port base filtering engine. This action improves both the latency and increases your throughput. However, changes to the registry should be limited to experienced administrators. This workaround excludes ports from being secured by the firewall. For more information, see the following reference.

For Windows Server 2012 and Windows Server 2008, you need to install a hotfix first. For more information, see [Datagram loss when you run a multicast receiver application in Windows 8 and in Windows Server 2012](https://support.microsoft.com/kb/2808584).

### Update network drivers
Some network vendors have driver updates that improve performance relative to driver latency and buffering UDP packets. Contact your network vendor to see if there are updates to help with UDP throughput.

## Logging for auditing purposes
To comply with time tracing regulations, you can manually archive `w32tm` logs, event logs, and Performance Monitor information. Later, the archived information can be used to attest compliance at a specific time in the past. The following factors are used to indicate the accuracy:

1. Clock accuracy by using the **Computed Time Offset** Performance Monitor counter. This counter shows the clock within the desired accuracy.
1. Clock source looking for `Peer Response from` in the `w32tm` logs. Following the message text is the IP address or VMIC, which describes the time source and the next in the chain of reference clocks to validate.
1. Clock condition status by using the `w32tm` logs to validate that `ClockDispl Discipline: \*SKEW\*TIME\*` is occurring. This status indicates that `w32tm` is active at the time.

### Event logging
To get the complete story, you also need event log information. By collecting the system event log and filtering on Time-Server, Microsoft-Windows-Kernel-Boot, and Microsoft-Windows-Kernel-General, you might be able to discover if other influences changed the time, for instance, third parties. These logs might be necessary to rule out external interference. Group Policy can affect which event logs are written to the log. For more information, see the preceding section **Use Group Policy**.

### <a name="W32Logging"></a>W32Time debug logging
To enable `w32tm` for auditing purposes, the following command enables logging that shows the periodic updates of the clock and indicates the source clock. Restart the service to enable the new logging.

For more information, see [Turn on debug logging in the Windows Time service](https://support.microsoft.com/kb/816043).

 `w32tm /debug /enable /file:C:\Windows\Temp\w32time-test.log /size:10000000 /entries:0-73,103,107,110`

### Performance Monitor
The Windows Server 2016 Windows Time service exposes performance counters, which can be used to collect logging for auditing. These counters can be logged locally or remotely. You can record the **Computer Time Offset** and **Round Trip Delay** counters. Like any performance counter, you can monitor them remotely and create alerts by using System Center Operations Manager. For instance, you can use an alert to alarm you when the Time Offset drifts from the desired accuracy. For more information, see the [System Center Management Pack](/system-center/scsm/management-packs).

### Windows traceability example
From `w32tm` log files, you want to validate two pieces of information. The first is an indication that the log file is currently a condition clock. This indication proves that your clock was being conditioned by the Windows Time service at the disputed time.
```
 151802 20:18:32.9821765s - ClockDispln Discipline: *SKEW*TIME* - PhCRR:223 CR:156250 UI:100 phcT:65 KPhO:14307
 151802 20:18:33.9898460s - ClockDispln Discipline: *SKEW*TIME* - PhCRR:1 CR:156250 UI:100 phcT:64 KPhO:41
 151802 20:18:44.1090410s - ClockDispln Discipline: *SKEW*TIME* - PhCRR:1 CR:156250 UI:100 phcT:65 KPhO:38
```
The main point is that you see messages prefixed with `ClockDispln Discipline`, which is proof that W32Time is interacting with your system clock.

Next, you need to find the last report in the log before the disputed time that reports the source computer, which is currently being used as the reference clock. This information could be an IP address, computer name, or the VMIC provider, which indicates that it's syncing with the host for Hyper-V. The following example provides an IPv4 address of 10.197.216.105:

 `151802 20:18:54.6531515s - Response from peer 10.197.216.105,0x8 (ntp.m|0x8|0.0.0.0:123->10.197.216.105:123), ofs: +00.0012218s`

Now that you've validated the first system in the reference time chain, you need to investigate the log file on the reference time source and repeat the same steps. This process continues until you get to a physical clock, like GPS, or a known time source, like NIST. If the reference clock is GPS hardware, logs from the manufactured might also be required.

## Network considerations
The NTP protocol algorithms have a dependency on the symmetry of your network. As you increase the number of network hops, the probability of asymmetry increases. For this reason, it's difficult to predict what types of accuracies you see in your specific environments.

Performance Monitor and the new Windows Time counters in Windows Server 2016 can be used to assess your environment's accuracy and create baselines. You can also perform troubleshooting to determine the current offset of any machine on your network.

There are two general standards for accurate time over the network:

- [Precision Time Protocol - IEEE 1588](https://www.nist.gov/el/intelligent-systems-division-73500/introduction-ieee-1588) **(PTP)**: PTP has tighter requirements on network infrastructure but can often provide submicrosecond accuracy.
- [Network Time Protocol – RFC 1305](https://tools.ietf.org/html/rfc1305) **(NTP)**: NTP works on a larger variety of networks and environments, which makes it easier to manage.

Windows supports simple NTP (RFC2030) by default for nondomain-joined machines. For domain-joined machines, we use a secure NTP called [MS-SNTP](/openspecs/windows_protocols/ms-sntp/8106cb73-ab3a-4542-8bc8-784dd32031cc), which uses domain-negotiated secrets that provide a management advantage over authenticated NTP described in RFC1305 and RFC5905.

Both the domain and nondomain-joined protocols require UDP port 123. For more information about NTP best practices, see [Network Time Protocol Best Current Practices IETF Draft](https://tools.ietf.org/html/draft-ietf-ntp-bcp-00).

### Reliable hardware clock (RTC)

Windows doesn't step time, unless certain bounds are exceeded, but instead disciplines the clock. That means `w32tm` adjusts the frequency of the clock at a regular interval by using the **Clock Update Frequency** setting, which defaults to once a second with Windows Server 2016. If the clock is behind, it accelerates the frequency. If it's ahead, it slows down the frequency. However, during the time between clock frequency adjustments, the hardware clock is in control. If there's an issue with the firmware or the hardware clock, the time on the machine can become less accurate.

This scenario is another reason why you need to test and baseline in your environment. If the **Computed Time Offset** performance counter doesn't stabilize at the accuracy you're targeting, you might want to verify that your firmware is up to date. As another test, you can see if duplicate hardware reproduces the same issue.

### Troubleshoot time accuracy and NTP

You can use the section **Discover the hierarchy** to understand the source of the inaccurate time. Looking at the time offset, find the point in the hierarchy where time diverges the most from its NTP source. When you understand the hierarchy, you want to try to understand why that particular time source doesn't receive accurate time.

By focusing on the system with divergent time, you can use the following tools to gather more information to help you determine the issue and find a resolution. The `UpstreamClockSource` reference is the clock discovered by using `w32tm /config /status`:

- System event logs
- Enable logging by using `w32tm logs - w32tm /debug /enable /file:C:\Windows\Temp\w32time-test.log /size:10000000 /entries:0-300`
- w32Time registry key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time`
- Local network traces
- Performance counters (from the local machine or `UpstreamClockSource`)
- `W32tm /stripchart /computer:UpstreamClockSource`
- PING `UpstreamClockSource` to understand latency and number of hops to source
- Tracert `UpstreamClockSource`

Problem| Symptoms| Resolution|
----- | ----- | ----- |
| Local TSC clock isn't stable.| Using Perfmon - Physical Computer – Sync clock stable clock, but you still see that every 1-2 minutes of several 100us. | Update firmware or validate that different hardware doesn't display the same issue.|
| Network latency.| The `w32tm` stripchart displays `RoundTripDelay` of more than 10 ms. Variation in the delay can cause noise as large as one half of the round trip time, for instance, a delay that's only in one direction.<br><br>`UpstreamClockSource` is multiple hops, as indicated by PING. TTL should be close to 128.<br><br>Use Tracert to find the latency at each hop.  | Find a closer clock source for time. One solution is to install a source clock on the same segment or manually point to a source clock that's geographically closer. For a domain scenario, add a machine with the GTimeServ role. |
Unable to reliably reach the NTP source.| `W32tm /stripchart` intermittently returns "Request timed out." |NTP source isn't responsive. |
NTP source isn't responsive.| Check Perfmon counters for NTP Client Source Count, NTP Server Incoming Requests, and NTP Server Outgoing Responses and determine your usage compared to your baselines.| By using server performance counters, determine if the load changed in reference to your baselines.<br><br>Are there network congestion issues?|
Domain controller not using the most accurate clock.| Changes in the topology or recently added master time clock.| w32tm /resync /rediscover|
Client clocks are drifting.| Time-Service event 36 in system event log and/or text in log file describing that NTP Client Time Source Count counter is going from 1 to 0.|Troubleshoot the upstream source and understand if it's running into performance issues.|

### Baselining time

Baselining is important so that you can understand the performance and accuracy of your network and then compare it with the baseline in the future when problems occur. You want to baseline the root PDC or any machines marked with GTIMESRV. We also recommend that you baseline the PDC in every forest. Finally, pick any critical DCs or machines that have interesting characteristics, like distance or high loads, and baseline those.

It's also useful to baseline Windows Server 2016 versus 2012 R2. However, you only have `w32tm /stripchart` as a tool that you can use to compare because Windows Server 2012 R2 doesn't have performance counters. You should pick two machines with the same characteristics or upgrade a machine and compare the results after the update. The Windows Time Measurements addendum has more information on how to do detailed measurements between 2016 and 2012.

By using all the W32Time performance counters, collect data for at least a week. This data ensures that you have enough of a reference to account for variations in the network over time and enough of a run to provide confidence that your time accuracy is stable.

### NTP server redundancy

For manual NTP server configuration used with nondomain-joined machines or the PDC, having more than one server is a good redundancy measure in case of availability. It might also give better accuracy, assuming that all the sources are accurate and stable. However, if the topology isn't well designed or the time sources aren't stable, the resulting accuracy could be worse, so caution is advised. The limit of supported time servers that W32Time can manually reference is 10.

## Leap seconds

The earth's rotation period varies over time owing to climatic and geological events. Typically, the variation is about a second every two years. Whenever the variation from atomic time grows too large, a correction of one second (up or down) is inserted, which is called a leap second. This insertion is done in such a way that the difference never exceeds 0.9 seconds. This correction is announced six months ahead of the actual correction. Before Windows Server 2016, the Microsoft Time Service wasn't aware of leap seconds but relied on the external time service to take care of this issue. With the increased time accuracy of Windows Server 2016, Microsoft is working on a more suitable solution for the leap second problem.

## Secure Time Seeding

W32Time in Server 2016 includes the Secure Time Seeding feature. This feature determines the approximate current time from outgoing SSL connections. This time value is used to monitor the local system clock and correct any gross errors. You can read more about the feature in [this blog post](/archive/blogs/w32time/secure-time-seeding-improving-time-keeping-in-windows). In deployments with reliable time sources and well-monitored machines that include monitoring for time offsets, you might choose to not use the Secure Time Seeding feature and rely on your existing infrastructure instead.

To disable the feature:

1. Use Group Policy to manage `SecureTimeSeeding`. See the section that refers to the setting `UtilizeSslTimeData`: Learn: [Policy CSP - ADMX_W32Time](/windows/client-management/mdm/policy-csp-admx-w32time).
1. Alternatively, you can manually set the registry value. Set the `UtilizeSSLTimeData` registry configuration value to `0` on a specific machine:

    ```yaml
    reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\w32time\Config /v UtilizeSslTimeData /t REG_DWORD /d 0 /f
    ```

1. If you're unable to reboot the machine immediately, you can notify W32Time about the configuration update. This notification stops time monitoring and enforcement based on time data collected from SSL connections.

    ```
    W32tm.exe /config /update
    ```

1. Rebooting the machine makes the setting effective immediately and also causes it to stop collecting any time data from SSL connections. The latter part has a small overhead and shouldn't be a performance concern.

1. To apply this setting in an entire domain, set the `UtilizeSSLTimeData` value in the W32Time Group Policy setting to `0` and publish the setting. When the setting is picked up by a Group Policy client, W32Time is notified and it stops time monitoring and enforcement by using SSL time data. The SSL time data collection stops when each machine reboots. If your domain has portable slim laptops/tablets and other devices, you might want to exclude such machines from this policy change. These devices eventually face battery drain and need the Secure Time Seeding feature to bootstrap their time.

