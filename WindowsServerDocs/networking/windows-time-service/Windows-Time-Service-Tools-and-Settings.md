---
ms.assetid: 6086947f-f9ef-4e18-9f07-6c7c81d7002c
title: Windows Time service tools and settings
author: Teresa-Motiv
description: Describes the settings that are available for Windows Time Service (W32Time) and the tools that you can use to configure those settings
ms.author: v-tea
ms.date: 03/30/2021
ms.topic: article
ms.custom: contperfq4
---

# Windows Time service tools and settings

> Applies to Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10

The Windows Time service (W32Time) synchronizes the date and time for all computers managed by Active Directory Domain Services (AD DS). This article covers the different tools and settings used to manage the Windows Time service.

If you want to synchronize time for just a domain-joined client computer, see [Configure a client computer for automatic domain time synchronization](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc816884%28v%3dws.10%29). For additional information on configuring the Windows Time service, see [Where to Find Windows Time Service Configuration Information](windows-time-service-top.md).

> [!CAUTION]
> Don't use the **Net time** command to configure or set time when the Windows Time service is running.
>
> Also, on older computers that run Windows XP or earlier versions, the **Net time /querysntp** command displays the name of a Network Time Protocol (NTP) server with which a computer is configured to synchronize, but that NTP server is used only when the computer's time client is configured as NTP or AllSync. That command has since been deprecated.

Most domain member computers have a time client type of NT5DS, which means that they synchronize time from the domain hierarchy. The only typical exception to this is the domain controller that functions as the primary domain controller (PDC) emulator operations master of the forest root domain. The PDC emulator operations master is usually configured to synchronize time with an external time source. To view the time client configuration of a computer (starting in Windows Server 2008 and Windows Vista), run the **W32tm /query /configuration** command from an elevated Command Prompt, and read the **Type** line in the command output. For more information, see [How Windows Time Service Works](How-the-Windows-Time-Service-Works.md). Additionally, you can run the **reg query HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters** command and read the value of **NtpServer** in the command output.

> [!IMPORTANT]
> Prior to Windows Server 2016, the W32Time service was not designed to meet time-sensitive application needs. However, updates to Windows Server 2016 now allow you to implement a solution for one-millisecond accuracy in your domain. For more information, see [Windows 2016 Accurate Time](accurate-time.md) and [Support boundary to configure the Windows Time service for high-accuracy environments](support-boundary.md).

## Network port

Windows Time follows the NTP specification, which requires the use of UDP port 123 for all time synchronization. Whenever the computer synchronizes its clock or provides time to another computer, it happens over UDP port 123. This port is exclusively reserved by the Windows Time service.

> [!NOTE]
> If you have a computer with multiple network adapters (multihomed), you cannot enable the Windows Time service based on a network adapter.

## Using W32tm.exe

You can use W32tm.exe to configure Windows Time service settings and to diagnose time service problems. W32tm.exe is the preferred command-line tool for configuring, monitoring, and troubleshooting the Windows Time service. W32tm.exe is included with Windows XP and later versions and Windows Server 2003 and later versions.

The following tables describe the parameters for W32tm.exe use:

|Parameter |Description |
| --- | --- |
|**w32tm /?** |Displays the W32tm command-line help |
|**w32tm /register** |Registers the time service to run as a service and adds its default configuration information to the registry. |
|**w32tm /unregister** |Unregisters the time service and removes all of its configuration information from the registry. |
|**w32tm /monitor [/domain:\<*domain name*>] [/computers:\<*name*>[,\<*name*>[,\<*name*>...]]] [/threads:\<*num*>]** |Monitors the Windows Time service.<p>**/domain**: Specifies which domain to monitor. If no domain name is given, or neither the **/domain** nor **/computers** option is specified, the default domain is used. This option might be used more than once.<p>**/computers**: Monitors the given list of computers. Computer names are separated by commas, with no spaces. If a name is prefixed with a **\***, it is treated as a PDC. This option might be used more than once.<p>**/threads**: Specifies the number of computers to analyze simultaneously. The default value is three. Allowed range is 1-50. |
|**w32tm /ntte \<NT *time epoch*>** |Converts a Windows NT system time (measured in 10<sup>-7</sup>-second intervals starting from 0h 1-Jan 1601) into a readable format. |
|**w32tm /ntpte \<NTP *time epoch*>** |Converts an NTP time (measured in 2<sup>-32</sup>-second intervals starting from 0h 1-Jan 1900) into a readable format. |
|**w32tm /resync [/computer:\<*computer*>] [/nowait] [/rediscover] [/soft]** |Tells a computer that it should resynchronize its clock as soon as possible, throwing out all accumulated error statistics.<p>**/computer:\<*computer*>**: Specifies the computer that should resynchronize. If not specified, the local computer will resynchronize.<p>**/nowait**: do not wait for the resynchronize to occur; return immediately. Otherwise, wait for the resynchronize to complete before returning.<p>**/rediscover**: Redetects the network configuration and rediscovers network sources, then resynchronize.<p>**/soft**: Resynchronizes by using existing error statistics. Not useful, provided for compatibility. |
|**w32tm /stripchart /computer:\<*target*> [/period:\<*refresh*>] [/dataonly] [/samples:\<*count*>] [/rdtsc]** |Displays a strip chart of the offset between this computer and another computer.<p>**/computer:\<*target*>**: The computer to measure the offset against.<p>**/period:\<*refresh*>**: The time between samples, in seconds. The default is two seconds.<p>**/dataonly**: Displays the data only, without graphics.<p>**/samples:\<*count*>**: Collects \<*count*> samples, then stops. If not specified, samples will be collected until **Ctrl+C** is pressed.<br/><br/>**/rdtsc**: For each sample, this option prints comma-separated values along with the headers **RdtscStart**, **RdtscEnd**, **FileTime**, **RoundtripDelay**, and **NtpOffset** instead of the text graphic.<br/><ul><li>**RdtscStart**: [RDTSC (Read Time Stamp Counter)](https://en.wikipedia.org/wiki/Time_Stamp_Counter) value collected just before the NTP request was generated.</li><li>**RdtscEnd**: RDTSC value collected just after the NTP response was received and processed.</li><li>**FileTime**: Local FILETIME value used in the NTP request.</li><li>**RoundtripDelay**: Time elapsed in seconds between generating the NTP request and processing the received NTP response, computed as per NTP roundtrip computations.</li><li>**NTPOffset**: Time offset in seconds between the local computer and the NTP server, computed as per NTP offset computations.</li></ul> |
|**w32tm /config [/computer:\<*target*>] [/update] [/manualpeerlist:\<*peers*>] [/syncfromflags:\<*source*>] [/LocalClockDispersion:\<*seconds*>] [/reliable:(YES\|NO)] [/largephaseoffset:\<*milliseconds*>]** |**/computer:\<*target*>**: Adjusts the configuration of \<*target*>. If not specified, the default is the local computer.<p>**/update**: Notifies the time service that the configuration has changed, causing the changes to take effect.<p>**/manualpeerlist:\<*peers*>**: Sets the manual peer list to \<*peers*>, which is a space-delimited list of DNS and/or IP addresses. When specifying multiple peers, this option must be enclosed in quotes.<p>**/syncfromflags:\<*source*>**: Sets what sources the NTP client should synchronize from. \<*source*> should be a comma-separated list of these keywords (not case sensitive):<ul><li>**MANUAL**: Include peers from the manual peer list.</li><li>**DOMHIER**: Synchronize from a domain controller (DC) in the domain hierarchy.</li></ul>**/LocalClockDispersion:\<*seconds*>**: Configures the accuracy of the internal clock that W32Time will assume when it can't acquire time from its configured sources.<p>**/reliable:(YES\|NO)**: Set whether this computer is a reliable time source. This setting is only meaningful on domain controllers.<ul><li>**YES**: This computer is a reliable time service.</li><li>**NO**: This computer is not a reliable time service.</li></ul>**/largephaseoffset:\<*milliseconds*>**: sets the time difference between local and network time which W32Time will consider a spike. |
|**w32tm /tz** |Display the current time zone settings. |
|**w32tm /dumpreg [/subkey:\<*key*>] [/computer:\<*target*>]** |Display the values associated with a given registry key.<p>The default key is **HKLM\System\CurrentControlSet\Services\W32Time** (the root key for the time service).<p>**/subkey:\<*key*>**: Displays the values associated with subkey <key> of the default key.<p>**/computer:\<*target*>**: Queries registry settings for computer \<*target*> |
|**w32tm /query [/computer:\<*target*>] {/source \| /configuration \| /peers \| /status} [/verbose]** |Displays a computer's Windows Time service information. This parameter was first made available in the Windows Time client in Windows Vista and Windows Server 2008.<p>**/computer:\<*target*>**: Queries the information of \<*target*>. If not specified, the default value is the local computer.<p>**/source**: Displays the time source.<p>**/configuration**: Displays the configuration of run time and where the setting comes from. In verbose mode, display the undefined or unused setting too.<p>**/peers**: Displays a list of peers and their status.<p>**/status**: Displays Windows Time service status.<p>**/verbose**: Sets the verbose mode to display more information. |
|**w32tm /debug {/disable \| {/enable /file:\<*name*> /size:/<*bytes*> /entries:\<*value*> [/truncate]}}** |Enables or disables the local computer Windows Time service private log. This parameter was first made available in the Windows Time client in Windows Vista and Windows Server 2008.<p>**/disable**: Disables the private log.<p>**/enable**: Enables the private log.<ul><li>**file:\<*name*>**: Specifies the absolute file name.</li><li>**size:\<*bytes*>**: Specifies the maximum size for circular logging.</li><li>**entries:\<*value*>**: Contains a list of flags, specified by number and separated by commas, that specify the types of information that should be logged. Valid numbers are 0 to 300. A range of numbers is valid, in addition to single numbers, such as 0-100,103,106. Value 0-300 is for logging all information.</li></ul>**/truncate**: Truncate the file if it exists. |

**Examples**

To set a local client to point to two different time servers, one named ntpserver.contoso.com and another named clock.adatum.com, type the following command at the command line, and then press ENTER:

```cmd
w32tm /config /manualpeerlist:"ntpserver.contoso.com clock.adatum.com" /syncfromflags:manual /update
```

If you want to check the Windows Time client configuration from a Windows-based client computer that has a host name of CONTOSOW1, run the following command:

```cmd
W32tm /query /computer:contosoW1 /configuration
```

The output of this command is a list of configuration parameters that are set for the Windows Time client.

> [!IMPORTANT]
> [Windows Server 2016 has improved the time synchronization algorithms](./accurate-time.md) to align with RFC specifications. Therefore, if you want to set the local Windows Time client to point to multiple peers, it is highly recommended that you prepare three or more different time servers.
>
> If you have only two time servers, you should specify the **UseAsFallbackOnly** flag (0x2) to de-prioritize one of them. For instance, if you want to prioritize ntpserver.contoso.com over clock.adatum.com, run the following command.
> ```cmd
> w32tm /config /manualpeerlist:"ntpserver.contoso.com,0x8 clock.adatum.com,0xa" /syncfromflags:manual /update
> ```
> For the meaning of the specified flag, see [Parameters subkeys](#parameters).

## Using Local Group Policy Editor

The Windows Time service stores a number of configuration properties as registry entries. You can use Group Policy Objects to configure most of this information. For example, you can use GPOs to configure a computer to be an NTPServer or NTPClient, configure the time synchronization mechanism, or configure a computer to be a reliable time source.

> [!NOTE]
> Group Policy settings for the Windows Time service can be configured on Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and Windows Server 2008 R2 domain controllers and can be applied only to computers running Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and Windows Server 2008 R2.

Windows stores the Windows Time service policy information in the W32Time.admx administrative template file, under **Computer Configuration\Administrative Templates\System\Windows Time Service**. It stores the configuration information that the policies define in the registry, and uses those registry entries to configure the registry entries for the Windows Time service. As a result, the values defined by Group Policy overwrite any pre-existing values in the Windows Time service section of the registry.

> [!IMPORTANT]
> Some of the preset GPO settings differ from the corresponding default registry entries. If you plan to use a GPO to configure any Windows Time setting, be sure that you review [Preset values for the Windows Time service Group Policy settings are different from the corresponding Windows Time service registry entries in Windows Server 2003](https://go.microsoft.com/fwlink/?LinkId=186066). This issue applies to Windows Server 2008 R2, Windows Server 2008, Windows Server 2003 R2, and Windows Server 2003.

For example, suppose you edit policy settings in the **Configure Windows NTP Client** policy.

Your changes are stored in the following location in the administrative template:

> **Computer Configuration\Administrative Templates\System\Windows Time Service\Time Providers\ Configure Windows NTP Client**

Windows loads these settings into the policy area of the registry under the following subkey:

> **HKLM\Software\Policies\Microsoft\W32time\TimeProviders\NtpClient**

Then Windows uses the policy settings to configure the related Windows Time service registry entries under the following subkey:

> **HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Time Providers\NTPClient\\**

The following table lists the policies that you can configure for the Windows Time service, and the registry subkeys that those policies affect.

> [!NOTE]
> When you remove a Group Policy setting, Windows removes the corresponding entry from the policy area of the registry.

|Policy<sup>1</sup> |Registry locations<sup>2,</sup> <sup>3</sup> |
| --- | --- |
|Global Configuration Settings |W32Time<br />W32Time\Config<br />W32Time\Parameters |
|Time Providers\Configure Windows NTP Client |W32Time\TimeProviders\NtpClient |
|Time Providers\Enable Windows NTP Client |W32Time\TimeProviders\NtpClient |
|Time Providers\Enable Windows NTP Server |W32Time\TimeProviders\NtpServer |

> <sup>1</sup> Category path: **Computer Configuration\Administrative Templates\System\Windows Time Service**
> <sup>2</sup> Subkey: **HKLM\SOFTWARE\Policies\Microsoft**
> <sup>3</sup> Subkey: **HKLM\SYSTEM\CurrentControlSet\Services**

## How a computer clock is reset

In order for the Windows Time service to reset a computer clock, the computer clock time offset from the current time (`CurrentTimeOffset`) must be less than the `MaxAllowedPhaseOffset` value and satisfy the following at the same time:

- Windows Server 2016 and later:

  > |**CurrentTimeOffset**| &divide; (16 &times; **PhaseCorrectRate** &times; **pollIntervalInSeconds**) &le; **SystemClockRate** &divide; 2

- Windows Server 2012 R2 and earlier:

  > |**CurrentTimeOffset**| &divide; (**PhaseCorrectRate** &times; **UpdateInterval**) &le; **SystemClockRate** &divide; 2

**CurrentTimeOffset** is measured in clock ticks, where 1 ms = 10,000 clock ticks on a Windows system.

**SystemClockRate** and **PhaseCorrectRate** are also measured in clock ticks. To get the **SystemClockRate** value, you can use the following command and convert it from seconds to clock ticks by using the formula of *seconds* &times; 1,000 &times; 10,000:

```cmd
W32tm /query /status /verbose

ClockRate: 0.0156000s
```

**SystemClockRate** is the rate of the clock on the system. Using 156,000 seconds as an example, the **SystemClockRate** value would be 0.0156000 &times; 1,000 &times; 10,000 = 156,000 clock ticks.

**MaxAllowedPhaseOffset** is also measured in seconds. To convert it to clock ticks, multiply **MaxAllowedPhaseOffset** &times; 1,000 &times; 10,000.

The following examples show how to apply these calculations when you use Windows Server 2012 R2 or an earlier version.

### Example 1: Clock time off by four minutes

Your computer clock time is 11:05 and the actual current time is 11:09:

> **PhaseCorrectRate** = 1
>
> **UpdateInterval** = 30,000 clock ticks
>
> **SystemClockRate** = 156,000 clock ticks
>
> **MaxAllowedPhaseOffset** = 10 min = 600 seconds = 600 &times; 1,000 &times; 10,000 = 6,000,000,000 clock ticks
>
> |**CurrentTimeOffset**| = 4 min = 4 &times; 60 &times; 1,000 &times; 10,000 = 2,400,000,000 clock ticks
>
> Is **CurrentTimeOffset** &le; **MaxAllowedPhaseOffset**?
>
> 2,400,000,000 &le; 6,000,000,000: TRUE

AND does it satisfy the above equation?

> (|**CurrentTimeOffset**| &divide; (**PhaseCorrectRate** &times; **UpdateInterval**) &le; **SystemClockRate** &divide; 2)

Is 2,400,000,000 / (30,000 &times; 1) &le; 156,000 &divide; 2

80,000 &le; 78,000: FALSE

Therefore, W32tm would set the clock back immediately.

> [!NOTE]
> In this case, if you want to set the clock back slowly, you would also have to adjust the values of **PhaseCorrectRate** or **UpdateInterval** in the registry to make sure that the equation result is **TRUE**.

### Example 2: Clock time off by three minutes

Your computer clock time is 11:05 and the actual current time is 11:08:

> **PhaseCorrectRate** = 1
>
> **UpdateInterval** = 30,000 clock ticks
>
> SystemClockRate = 156,000 clock ticks
>
> **MaxAllowedPhaseOffset** = 10 min = 600 seconds = 600 &times; 1,000 &times; 10,000 = 6,000,000,000 clock ticks
>
> |**CurrentTimeOffset**| = 3 mins = 3 &times; 60 &times; 1,000 &times; 10,000 = 1,800,000,000 clock ticks
>
> Is |**CurrentTimeOffset**| &le; **MaxAllowedPhaseOffset**?
>
> 1,800,000,000 &le; 6,000,000,000: TRUE

AND does it satisfy the above equation?

> (|**CurrentTimeOffset**| &divide; (**PhaseCorrectRate** &times; **UpdateInterval**) &le; **SystemClockRate** &divide; 2)
>
> Is 3 mins &times; (1,800,000,000) &divide; (30,000 &times; 1) &le; 156,000 &divide; 2
>
> Is 60,000 &le; 78,000: TRUE

In this case, the clock will be set back slowly.

## Windows registry reference

> [!WARNING]
> This information is provided as a reference for use in troubleshooting and validation. Windows registry keys are used by W32Time to store critical information. Don't change these values. Modifications to the registry are not validated by the registry editor or by Windows before they are applied. If the registry contains invalid values, Windows may experience unrecoverable errors.

Windows Time service stores information in the following registry subkeys:

- [**HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config**](#config)
- [**HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters**](#parameters)
- [**HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient**](#ntpclient)
- [**HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer**](#ntpserver)

Additionally, for troubleshooting purposes, you can [add entries in order to configure logs](#enabling-w32time-logging).

In the following tables, "All versions" refers to Windows 7, Windows 8, Windows 10, Windows Server 2008 and Windows Server 2008 R2, Windows Server 2012 and Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019. Some entries are only available on later Windows versions.

> [!NOTE]
> Some of the parameters in the registry are measured in clock ticks and some are measured in seconds. To convert the time from clock ticks to seconds, use these conversion factors:
> - 1 minute = 60 sec
> - 1 sec = 1000 ms
> - 1 ms = 10,000 clock ticks on a Windows system, as described at [DateTime.Ticks Property](/dotnet/api/system.datetime.ticks).
>
> For example, 5 minutes becomes 5 &times; 60 &times; 1000 &times; 10000 = 3,000,000,000 clock ticks.

### <a id="config"></a> Config entries

The `Config` subkey entries are located at `HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config`.

|Registry entry |Versions |Description |
| --- | --- | --- |
|**AnnounceFlags** |All versions |Controls whether this computer is marked as a reliable time server. A computer is not marked as reliable unless it is also marked as a time server.<ul><li>**0x00**. Not a time server</li><li>**0x01**. Always time server</li><li>**0x02**. Automatic time server</li><li>**0x04**. Always-reliable time server</li><li>**0x08**. Automatic reliable time server</li></ul><br />The default value for domain members is **10**. The default value for stand-alone clients and servers is **10**. |
|**ChainDisable** | |Controls whether or not the chaining mechanism is disabled. If chaining is disabled (set to 0), a read-only domain controller (RODC) can synchronize with any domain controller, but hosts that do not have their passwords cached on the RODC will not be able to synchronize with the RODC. This is a boolean setting, and the default value is **0**.|
|**ChainEntryTimeout** | |Specifies the maximum amount of time that an entry can remain in the chaining table before the entry is considered to be expired. Expired entries may be removed when the next request or response is processed. The default value is **16** (seconds). |
|**ChainLoggingRate** | |Controls the frequency at which an event that indicates the number of successful and unsuccessful chaining attempts is logged to the System log in Event Viewer. The default is **30** (minutes). |
|**ChainMaxEntries** | |Controls the maximum number of entries that are allowed in the chaining table. If the chaining table is full and no expired entries can be removed, any incoming requests are discarded. The default value is **128** (entries). |
|**ChainMaxHostEntries** | |Controls the maximum number of entries that are allowed in the chaining table for a particular host. The default value is **4** (entries). |
|**ClockAdjustmentAuditLimit** |Windows Server 2016 Version 1709 and later versions; Windows 10 Version 1709 and later versions |Specifies the smallest local clock adjustments that may be logged to the W32time service event log on the target computer. The default value is **800** (parts per million - PPM). |
|**ClockHoldoverPeriod** |Windows Server 2016 Version 1709 and later versions; Windows 10 Version 1709 and later versions |Indicates the maximum number of seconds a system clock can nominally hold its accuracy without synchronizing with a time source. If this period of time passes without W32time obtaining new samples from any of its input providers, W32time initiates a rediscovery of time sources. Default: 7,800 seconds. |
|**EventLogFlags** |All versions |Controls which events that the time service logs.<ul><li>**0x1**. Time jump</li><li>**0x2**. Source change</li></ul>The default value on domain members is **2**. The default value on stand-alone clients and servers is **2**. |
|**FrequencyCorrectRate** |All versions |Controls the rate at which the clock is corrected. If this value is too small, the clock is unstable and overcorrects. If the value is too large, the clock takes a long time to synchronize. The default value on domain members is **4**. The default value on stand-alone clients and servers is **4**.<p>**Note** <br />Zero is not a valid value for the **FrequencyCorrectRate** registry entry. On Windows Server 2003, Windows Server 2003 R2, Windows Server 2008 , and Windows Server 2008 R2 computers, if the value is set to **0**, the Windows Time service automatically changes it to **1**. |
|**HoldPeriod** |All versions |Controls the period of time for which spike detection is disabled in order to bring the local clock into synchronization quickly. A spike is a time sample indicating that time is off a number of seconds, and is usually received after good time samples have been returned consistently. The default value on domain members is **5**. The default value on stand-alone clients and servers is **5**. |
|**LargePhaseOffset** |All versions |Specifies that a time offset greater than or equal to this value in 10<sup>-7</sup> seconds is considered a spike. A network disruption such as a large amount of traffic might cause a spike. A spike will be ignored unless it persists for a long period of time. The default value on domain members is **50000000**. The default value on stand-alone clients and servers is **50000000**. |
|**LastClockRate** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default value on domain members is **156250**. The default value on stand-alone clients and servers is **156250**. |
|**LocalClockDispersion** |All versions |Controls the dispersion (in seconds) that you must assume when the only time source is the built-in CMOS clock. The default value on domain members is **10**. The default value on stand-alone clients and servers is **10**. |
|**MaxAllowedPhaseOffset** |All versions |Specifies the maximum offset (in seconds) for which W32Time attempts to adjust the computer clock by using the clock rate. When the offset exceeds this rate, W32Time sets the computer clock directly. The default value for domain members is **300**. The default value for stand-alone clients and servers is **1**. For more information, see [Configuring how Windows Time service resets the computer clock](#configuring-how-windows-time-service-resets-the-computer-clock). |
|**MaxClockRate** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default value for domain members is **155860**. The default value for stand-alone clients and servers is **155860**. |
|**MaxNegPhaseCorrection** |All versions |Specifies the largest negative time correction, in seconds, that the service makes. If the service determines that a change larger than this is required, it logs an event instead.<p>**Note**<br />The value **0xFFFFFFFF** is a special case. This value means that the service always corrects the time.<p>The default value for domain members is **0xFFFFFFFF**. The default value for stand-alone clients and servers is **54,000** (15 hrs).|
|**MaxPollInterval** |All versions |Specifies the largest interval, in log2 seconds, allowed for the system polling interval. Note that while a system must poll according to the scheduled interval, a provider can refuse to produce samples when requested to do so. The default value for domain controllers is **10**. The default value for domain members is **15**. The default value for stand-alone clients and servers is **15**. |
|**MaxPosPhaseCorrection** |All versions |Specifies the largest positive time correction in seconds that the service makes. If the service determines that a change larger than this is required, it logs an event instead.<p>**Note**<br />The value **0xFFFFFFFF** is a special case. This value means that the service always corrects the time.<p>The default value for domain members is **0xFFFFFFFF**. The default value for stand-alone clients and servers is **54,000** (15 hrs). |
|**MinClockRate** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default value for domain members is **155860**. The default value for stand-alone clients and servers is **155860**. |
|**MinPollInterval** |All versions |Specifies the smallest interval, in log2 seconds, allowed for the system polling interval. Note that while a system does not request samples more frequently than this, a provider can produce samples at times other than the scheduled interval. The default value for domain controllers is **6**. The default value for domain members is **10**. The default value for stand-alone clients and servers is **10**. |
|**PhaseCorrectRate** |All versions |Controls the rate at which the phase error is corrected. Specifying a small value corrects the phase error quickly, but might cause the clock to become unstable. If the value is too large, it takes a longer time to correct the phase error.<p>The default value on domain members is **1**. The default value on stand-alone clients and servers is **7**.<p>**Note**<br />Zero is not a valid value for the **PhaseCorrectRate** registry entry. On Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and  Windows Server 2008 R2 computers, if the value is set to **0**, the Windows Time service automatically changes it to **1**. |
|**PollAdjustFactor** |All versions |Controls the decision to increase or decrease the poll interval for the system. The larger the value, the smaller the amount of error that causes the poll interval to be decreased. The default value on domain members is **5**. The default value on stand-alone clients and servers is **5**. |
|**RequireSecureTimeSyncRequests** |Windows 8 and later versions |Controls whether or not the DC will respond to time sync requests that use older authentication protocols. If enabled (set to **1**), the DC will not respond to requests using such protocols. This is a boolean setting, and the default value is **0**. |
|**SpikeWatchPeriod** |All versions |Specifies the amount of time that a suspicious offset must persist before it is accepted as correct (in seconds). The default value on domain members is **900**. The default value on stand-alone clients and workstations is **900**. |
|**TimeJumpAuditOffset** |All versions |An unsigned integer that indicates the time jump audit threshold, in seconds. If the time service adjusts the local clock by setting the clock directly, and the time correction is more than this value, then the time service logs an audit event. |
|**UpdateInterval** |All versions |Specifies the number of clock ticks between phase correction adjustments. The default value for domain controllers is **100**. The default value for domain members is **30,000**. The default value for stand-alone clients and servers is **360,000**.<p>**Note**<br />Zero is not a valid value for the **UpdateInterval** registry entry. On computers running Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and Windows Server 2008 R2, if the value is set to **0**, the Windows Time service automatically changes it to **1**.|
|**UtilizeSslTimeData** |Windows versions later than Windows 10 build 1511 |Value of **1** indicates that W32Time uses multiple SSL timestamps to Seed a clock that is grossly inaccurate. |

### <a id="parameters"></a>Parameters entries

The `Parameters` subkey entries are located at `HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters`.

| Registry entry | Versions | Description |
| --- | --- | --- |
|**AllowNonstandardModeCombinations** |All versions |Indicates that non-standard mode combinations are allowed in synchronization between peers. The default value for domain members is **1**. The default value for stand-alone clients and servers is **1**. |
|**NtpServer** |All versions |Specifies a space-delimited list of peers from which a computer obtains time stamps, consisting of one or more DNS names or IP addresses per line. Each DNS name or IP address listed must be unique. Computers connected to a domain must synchronize with a more reliable time source, such as the official U.S. time clock.  <ul><li>0x01 SpecialInterval </li><li>0x02 UseAsFallbackOnly</li><li>0x04 SymmetricActive: For more information about this mode, see [Windows Time Server: 3.3 Modes of Operation](https://go.microsoft.com/fwlink/?LinkId=208012).</li><li>0x08 Client</li></ul><br />There is no default value for this registry entry on domain members. The default value on stand-alone clients and servers is **time.windows.com,0x1**. |
|**ServiceDll** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default location for this DLL on both domain members and stand-alone clients and servers is %windir%\System32\W32Time.dll. |
|**ServiceMain** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default value on domain members is **SvchostEntry_W32Time**. The default value on stand-alone clients and servers is **SvchostEntry_W32Time**. |
|**Type** |All versions |Indicates which peers to accept synchronization from:  <ul><li>**NoSync**. The time service does not synchronize with other sources.</li><li>**NTP**. The time service synchronizes from the servers specified in the **NtpServer**. registry entry.</li><li>**NT5DS**. The time service synchronizes from the domain hierarchy.  </li><li>**AllSync**. The time service uses all the available synchronization mechanisms.  </li></ul>The default value on domain members is **NT5DS**. The default value on stand-alone clients and servers is **NTP**. |

### <a id="ntpclient"></a>NtpClient entries

The `NtpClient` subkey entries are located at `HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient`

|Registry entry |Version |Description |
| --- | --- | --- |
|**AllowNonstandardModeCombinations** |All versions |Indicates that non-standard mode combinations are allowed in synchronization between peers. The default value for domain members is **1**. The default value for stand-alone clients and servers is **1**.|
|**CompatibilityFlags** |All versions |Specifies the following compatibility flags and values:<ul><li>**0x00000001** - DispersionInvalid</li><li>**0x00000002** - IgnoreFutureRefTimeStamp</li><li>**0x80000000** - AutodetectWin2K</li><li>**0x40000000** - AutodetectWin2KStage2</li></ul>The default value for domain members is **0x80000000**. The default value for stand-alone clients and servers is **0x80000000**. |
|**CrossSiteSyncFlags** |All versions |Determines whether the service chooses synchronization partners outside the domain of the computer. The options and values are:<ul><li>**0** - None</li><li>**1** - PdcOnly</li><li>**2** - All</li></ul>This value is ignored if the NT5DS value is not set. The default value for domain members is **2**. The default value for stand-alone clients and servers is **2**. |
|**DllName** |All versions |Specifies the location of the DLL for the time provider.<p>The default location for this DLL on both domain members and stand-alone clients and servers is **%windir%\System32\W32Time.dll**. |
|**Enabled** |All versions |Indicates if the NtpClient provider is enabled in the current Time Service.<ul><li>**1** - Yes</li><li>**0** - No</li></ul>The default value on domain members is **1**. The default value on stand-alone clients and servers is **1**.|
|**EventLogFlags** |All versions |Specifies the events logged by the Windows Time service.<ul><li>**0x1** - Reachability changes</li><li>**0x2** - Large sample skew (This is applicable to Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and  Windows Server 2008 R2 only)</li></ul>The default value on domain members is **0x1**. The default value on stand-alone clients and servers is **0x1**.|
|**InputProvider** |All versions |Indicates whether to enable the NtpClient as an InputProvider, which obtains time information from the NtpServer. The NtpServer is a time server that responds to client time requests on the network by returning time samples that are useful for synchronizing the local clock. <ul><li>**1** - Yes</li><li>**0** - No</li></ul>Default value for both domain members and stand-alone clients is **1**. |
|**LargeSampleSkew** |All versions |Specifies the large sample skew for logging, in seconds. To comply with Security and Exchange Commission (SEC) specifications, this should be set to three seconds. Events will be logged for this setting only when **EventLogFlags** is explicitly configured for 0x2 large sample skew. The default value on domain members is 3. The default value on stand-alone clients and servers is 3. |
|**ResolvePeerBackOffMaxTimes** |All versions |Specifies the maximum number of times to double the wait interval when repeated attempts to locate a peer to synchronize with fail. A value of zero means that the wait interval is always the minimum. The default value on domain members is **7**. The default value on stand-alone clients and servers is **7**. |
|**ResolvePeerBackoffMinutes** |All versions |Specifies the initial interval to wait, in minutes, before attempting to locate a peer to synchronize with. The default value on domain members is **15**. The default value on stand-alone clients and servers is **15**.  |
|**SpecialPollInterval** |All versions |Specifies the special poll interval, in seconds, for manual peers. When the **SpecialInterval** 0x1 flag is enabled, W32Time uses this poll interval instead of a poll interval determined by the operating system. The default value on domain members is **3,600**. The default value on stand-alone clients and servers is **604,800**.<br/><br/>New for build 1703, **SpecialPollInterval** is contained by the **MinPollInterval** and **MaxPollInterval** Config registry values.|
|**SpecialPollTimeRemaining** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system. It specifies the time, in seconds, before W32Time will resynchronize after the computer has restarted. Any changes to this setting can cause unpredictable results. The default value on both domain members and on stand-alone clients and servers is left blank. |

### <a id="ntpserver"></a>NtpServer entries

The `NtpClient` subkey entries are located at `HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer`.

|Registry Entry |Versions |Description |
| --- | --- | --- |
|**AllowNonstandardModeCombinations** |All versions |Indicates that non-standard mode combinations are allowed in synchronization between clients and servers. The default value for domain members is **1**. The default value for stand-alone clients and servers is **1**. |
|**DllName** |All versions |Specifies the location of the DLL for the time provider. The default location for this DLL on both domain members and stand-alone clients and servers is **%windir%\System32\W32Time.dll**.  |
|**Enabled** |All versions |Indicates if the NtpServer provider is enabled in the current Time Service. <ul><li>**1** - Yes</li><li>**0** - No</li></ul>The default value on domain members is **1**. The default value on stand-alone clients and servers is **1**. |
|**InputProvider** |All versions |Indicates whether to enable the NtpClient as an InputProvider, which obtains time information from the NtpServer. The NtpServer is a time server that responds to client time requests on the network by returning time samples that are useful for synchronizing the local clock. <ul><li>**1** - Yes</li><li>**0** - No = 0 </li></ul>Default value for both domain members and stand-alone clients: 1 |

### Logging entries

The following registry entries are not a part of the W32Time default configuration but can be added to the registry to obtain increased logging capabilities. The information logged to the System Event log can be modified by changing value for the **EventLogFlags** setting in the Group Policy Object Editor. By default, the time service logs an event every time that it switches to a new time source.

In order to enable W32Time logging, add the following registry entries:

|Registry Entry |Versions |Description |
| --- | --- | --- |
|**FileLogEntries** |All versions |Controls the number of entries created in the Windows Time log file. The default value is none, which does not log any Windows Time activity. Valid values are **0** to **300**. This value does not affect the event log entries normally created by Windows Time |
|**FileLogName** |All versions |Controls the location and file name of the Windows Time log. The default value is blank, and should not be changed unless **FileLogEntries** is changed. A valid value is a full path and file name that Windows Time will use to create the log file. This value does not affect the event log entries normally created by Windows Time. |
|**FileLogSize** |All versions |Controls the circular logging behavior of Windows Time log files. When **FileLogEntries** and **FileLogName** are defined, Entry defines the size, in bytes, to allow the log file to reach before overwriting the oldest log entries with new entries. Please use **1000000** or larger value for this setting. This value does not affect the event log entries normally created by Windows Time. |

## Global Group Policy settings

The following lists the global Group Policy settings associated with the Windows Time service and the default value for each setting. These settings are contained in the **Global Configuration Settings** GPO.

|Group Policy setting|Default value|
| --- | --- |
|**AnnounceFlags**|10|
|**EventLogFlags**|2|
|**FrequencyCorrectRate**|4|
|**HoldPeriod**|5|
|**LargePhaseOffset**|1,280,000|
|**LocalClockDispersion**|10|
|**MaxAllowedPhaseOffset**|300|
|**MaxNegPhaseCorrection**|54,000 (15 hours)|
|**MaxPollInterval**|15|
|**MaxPosPhaseCorrection**|54,000 (15 hours)|
|**MinPollInterval**|10|
|**PhaseCorrectRate**|7|
|**PollAdjustFactor**|5|
|**SpikeWatchPeriod**|90|
|**UpdateInterval**|100|

## Windows NTP Client settings

The following the available settings for the **Configure Windows NTP Client** GPO and the default values associated with the Windows Time service.

|Group Policy setting|Default value|
|------------------------|-----------------|
|**NtpServer**|time.windows.com, 0x1|
|**Type**|**NTP** - Use for non-domain-joined computers<br>**NT5DS** - Use for domain-joined computers|
|**CrossSiteSyncFlags**|2|
|**ResolvePeerBackoffMinutes**|15|
|**ResolvePeerBackoffMaxTimes**|7|
|**SpecialPollInterval**|3,600|
|**EventLogFlags**|0|

## Related information

Also see [RFC 1305 - Network Time Protocol](https://datatracker.ietf.org/doc/rfc1305/) of the Internet Engineering Task Force (IETF).