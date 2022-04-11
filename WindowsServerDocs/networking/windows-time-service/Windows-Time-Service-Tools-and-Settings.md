---
ms.assetid: 6086947f-f9ef-4e18-9f07-6c7c81d7002c
title: Windows Time service tools and settings
author: v-tappelgate
description: Describes the settings that are available for Windows Time Service (W32Time) and the tools that you can use to configure those settings
ms.author: v-tappelgate
ms.date: 11/04/2021
ms.topic: article
ms.custom: contperf-fy21q4
---

# Windows Time service tools and settings

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows 10, Azure Stack HCI, versions 21H2 and 20H2

The Windows Time service (W32Time) synchronizes the date and time for all computers managed by Active Directory Domain Services (AD DS). This article covers the different tools and settings used to manage the Windows Time service.

By default, a computer that is joined to a domain synchronizes time through a domain hierarchy of time sources. However, if a computer has been manually configured to synchronize from a specific time source, perhaps because it was formerly not joined to a domain, you can reconfigure the computer to begin automatically sourcing its time from the domain hierarchy.

Most domain-joined computers have a time client type of NT5DS, which means that they synchronize time from the domain hierarchy. An exception to this is the domain controller, which functions as the primary domain controller (PDC) emulator operations master for the root forest domain. The PDC emulator operations master in turn is usually configured to synchronize time with an external time source.

You can achieve down to one-millisecond time accuracy in your domain. For more information, see [Support boundary for high-accuracy time](support-boundary.md) and see [Accurate Time for Windows Server 2016](accurate-time.md).

> [!CAUTION]
> Don't use the **Net time** command to configure or set a computer's clock time when the Windows Time service is running.
>
> Also, on older computers that run Windows XP or earlier, the **Net time /querysntp** command displays the name of a Network Time Protocol (NTP) server with which a computer is configured to synchronize, but that NTP server is used only when the computer's time client is configured as NTP or AllSync. This command has since been deprecated.

## Network port

The Windows Time service follows the Network Time Protocol (NTP) specification, which requires the use of UDP port 123 for all time synchronization. Whenever the computer synchronizes its clock or provides time to another computer, it happens over UDP port 123. This port is exclusively reserved by the Windows Time service.

> [!NOTE]
> If you have a computer with multiple network adapters (is multi-homed), you cannot enable the Windows Time service based on a network adapter.

## <a id="windows-time-service-tools"></a> Using W32tm.exe

You can use the command-line tool W32tm.exe to configure Windows Time service settings and to diagnose computer time problems. W32tm.exe is the preferred command-line tool for configuring, monitoring, and troubleshooting the Windows Time service. W32tm.exe is included with Windows XP and later and Windows Server 2003 and later.

Membership in the local **Administrators group** is required to run W32tm.exe locally, while membership in the **Domain Admins group** is required to run W32tm.exe remotely.

### Run W32tm.exe

1. In the Windows search bar, enter **cmd**.
1. Right-click **Command Prompt**, then select **Run as administrator**.
1. At the command prompt, enter **w32tm** followed by the applicable parameter, as described below:

|Parameter |Description |
| --- | --- |
|**/?** |Displays the W32tm command-line help |
|**/register** |Registers the Windows Time service to run as a service and adds its default configuration information to the registry. |
|**/unregister** |Unregisters the Windows Time service and removes all of its configuration information from the registry. |
|**/monitor** [/domain:\<*domain name*>] [/computers:\<*name*>[,\<*name*>[,\<*name*>...]]] [/threads:\<*num*>] |Monitors the Windows Time service.<p>**/domain**: Specifies which domain to monitor. If no domain name is given, or neither the **/domain** nor **/computers** option is specified, the default domain is used. This option might be used more than once.<p>**/computers**: Monitors the given list of computers. Computer names are separated by commas, with no spaces. If a name is prefixed with a **\***, it is treated as a PDC. This option might be used more than once.<p>**/threads**: Specifies the number of computers to analyze simultaneously. The default value is 3. The allowed range is 1-50. |
|**/ntte** \<NT *time epoch*> |Converts a Windows NT system time (measured in 10<sup>-7</sup>-second intervals starting from 0h 1-Jan 1601) into a readable format. |
|**/ntpte** \<NTP *time epoch*> |Converts an NTP time (measured in 2<sup>-32</sup>-second intervals starting from 0h 1-Jan 1900) into a readable format. |
|**/resync** [/computer:\<*computer*>] [/nowait] [/rediscover] [/soft] |Tells a computer that it should resynchronize its clock as soon as possible, throwing out all accumulated error statistics.<p>**/computer:\<*computer*>**: Specifies the computer that should resynchronize. If not specified, the local computer will resynchronize.<p>**/nowait**: do not wait for resynchronization to occur; return immediately. Otherwise, wait for resynchronization to complete before returning.<p>**/rediscover**: Redetects the network configuration and rediscovers network sources, then resynchronizes.<p>**/soft**: Resynchronizes by using existing error statistics. This is used for compatibility purposes. |
|**/stripchart** /computer:\<*target*> [/period:\<*refresh*>] [/dataonly] [/samples:\<*count*>] [/rdtsc] |Displays a strip chart of the offset between this computer and another computer.<p>**/computer:\<*target*>**: The computer to measure the offset against.<p>**/period:\<*refresh*>**: The time between samples, in seconds. The default is 2 seconds.<p>**/dataonly**: Displays the data only, without graphics.<p>**/samples:\<*count*>**: Collects \<*count*> samples, then stops. If not specified, samples will be collected until **Ctrl+C** is pressed.<br/><br/>**/rdtsc**: For each sample, this option prints comma-separated values along with the headers **RdtscStart**, **RdtscEnd**, **FileTime**, **RoundtripDelay**, and **NtpOffset** instead of the text graphic.<br/><ul><li>**RdtscStart**: [RDTSC (Read Time Stamp Counter)](https://en.wikipedia.org/wiki/Time_Stamp_Counter) value collected just before the NTP request was generated.</li><li>**RdtscEnd**: RDTSC value collected just after the NTP response was received and processed.</li><li>**FileTime**: Local FILETIME value used in the NTP request.</li><li>**RoundtripDelay**: Time elapsed in seconds between generating the NTP request and processing the received NTP response, computed as per NTP roundtrip computations.</li><li>**NTPOffset**: Time offset in seconds between the local computer and the NTP server, computed as per NTP offset computations.</li></ul> |
|**/config** [/computer:\<*target*>] [/update] [/manualpeerlist:\<*peers*>] [/syncfromflags:\<*source*>] [/LocalClockDispersion:\<*seconds*>] [/reliable:(YES\|NO)] [/largephaseoffset:\<*milliseconds*>]** |**/computer:\<*target*>**: Adjusts the configuration of \<*target*>. If not specified, the default is the local computer.<p>**/update**: Notifies the Windows Time service that the configuration has changed, causing the changes to take effect.<p>**/manualpeerlist:\<*peers*>**: Sets the manual peer list to \<*peers*>, which is a space-delimited list of DNS or IP addresses. When specifying multiple peers, this option must be enclosed in quotes.<p>**/syncfromflags:\<*source*>**: Sets what sources the NTP client should synchronize from. \<*source*> should be a comma-separated list of these keywords (not case sensitive):<ul><li>**MANUAL**: Include peers from the manual peer list.</li><li>**DOMHIER**: Synchronize from a domain controller (DC) in the domain hierarchy.</li></ul>**/LocalClockDispersion:\<*seconds*>**: Configures the accuracy of the internal clock that W32Time will assume when it can't acquire time from its configured sources.<p>**/reliable:(YES\|NO)**: Set whether this computer is a reliable time source. This setting is only meaningful on domain controllers.<ul><li>**YES**: This computer is a reliable time service.</li><li>**NO**: This computer is not a reliable time service.</li></ul>**/largephaseoffset:\<*milliseconds*>**: sets the time difference between local and network time that W32Time will consider a spike. |
|**/tz** |Displays the current time zone settings. |
|**/dumpreg** [/subkey:\<*key*>] [/computer:\<*target*>] |Displays the values associated with a given registry key.<p>The default key is **HKLM\System\CurrentControlSet\Services\W32Time** (the root key for the Windows Time service).<p>**/subkey:\<*key*>**: Displays the values associated with subkey \<key> of the default key.<p>**/computer:\<*target*>**: Queries registry settings for computer \<*target*> |
|**/query** [/computer:\<*target*>] {/source \| /configuration \| /peers \| /status} [/verbose] |Displays the computer's Windows Time service information. This parameter was first made available for the Windows Time client in Windows Vista and Windows Server 2008.<p>**/computer:\<*target*>**: Queries the information of \<*target*>. If not specified, the default value is the local computer.<p>**/source**: Displays the time source.<p>**/configuration**: Displays the configuration of run time and where the setting comes from. In verbose mode, display the undefined or unused setting too.<p>**/peers**: Displays a list of peers and their status.<p>**/status**: Displays Windows Time service status.<p>**/verbose**: Sets the verbose mode to display more information. |
|**/debug** {/disable \| {/enable /file:\<*name*> /size:/<*bytes*> /entries:\<*value*> [/truncate]}} |Enables or disables the local computer Windows Time service private log. This parameter was first made available for the Windows Time client in Windows Vista and Windows Server 2008.<p>**/disable**: Disables the private log.<p>**/enable**: Enables the private log.<ul><li>**file:\<*name*>**: Specifies the absolute file name.</li><li>**size:\<*bytes*>**: Specifies the maximum size for circular logging.</li><li>**entries:\<*value*>**: Contains a list of flags, specified by number and separated by commas, that specify the types of information that should be logged. Valid values are 0 to 300. A range of numbers is valid, in addition to single numbers, such as 0-100,103,106. Value 0-300 is for logging all information.</li></ul>**/truncate**: Truncate the file if it exists. |

### Set client to use two time servers

To set a client computer to point to two different time servers, one named `ntpserver.contoso.com` and another named `clock.adatum.com`, type the following command at the command prompt, and then press ENTER:

```cmd
w32tm /config /manualpeerlist:"ntpserver.contoso.com clock.adatum.com" /syncfromflags:manual /update
```

### Set client to sync time automatically from a domain source

To configure a client computer that is currently synchronizing time using a manually-specified computer to synchronize time automatically from the AD domain hierarchy, run the following following:

```cmd
w32tm /config /syncfromflags:domhier /update

net stop w32time

net start w32time
```

### Check client time configuration

To check a client configuration from a Windows-based client computer that has a host name of `contosoW1`, run the following command:

```cmd
W32tm /query /computer:contosoW1 /configuration
```

The output of this command displays a list of W32time configuration parameters that are set for the client.

> [!IMPORTANT]
> [Windows Server 2016 has improved the time synchronization algorithms](./accurate-time.md) to align with RFC specifications. Therefore, if you want to set the local time client to point to multiple peers, we recommended that you prepare three or more different time servers.
>
> If you have only two time servers, you should specify the **Ntpserver**`UseAsFallbackOnly` flag (0x2)to de-prioritize one of them. For example, if you want to prioritize `ntpserver.contoso.com` over `clock.adatum.com`, run the following command.
> ```cmd
> w32tm /config /manualpeerlist:"ntpserver.contoso.com,0x8 clock.adatum.com,0xa" /syncfromflags:manual /update
> ```

Additionally, you can run the following command and read the value of `NtpServer` in the output:

```cmd
reg query HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters
```

### Configure computer clock reset

In order for W32tm.exe to reset a computer clock, it first checks the offset (`CurrentTimeOffset`, also known as `Phase Offset`) between the current time and the computer clock time to determine whether the offset is less than the `MaxAllowedPhaseOffset` value.  

- `CurrentTimeOffset` &le; `MaxAllowedPhaseOffset`: Adjust the computer clock gradually by using the clock rate.  
- `CurrentTimeOffset` &gt; `MaxAllowedPhaseOffset`: Set the computer clock immediately.  

Then, to adjust the computer clock by using the clock rate, W32tm.exe calculates a `PhaseCorrection` value. This algorithm varies depending on the version of Windows:  

- Windows Server 2016 and later versions:  

  > `PhaseCorrection_raw` = |`CurrentTimeOffset`| &divide; (16 &times; `PhaseCorrectRate` &times; `pollIntervalInSeconds`)  
  > `MaximumCorrection` = |`CurrentTimeOffset`| &divide; (`UpdateInterval` &divide; 100)  
  > `PhaseCorrection` = min(`PhaseCorrection_raw`, `MaximumCorrection`)  

- Windows Server 2012 R2 and earlier versions:  

To get the `SystemClockRate` value, you can use the following command and convert it from seconds to clock ticks by using the formula of (seconds &times; 1,000 &times; 10,000):
  > `PhaseCorrection` = |`CurrentTimeOffset`| &divide; (`PhaseCorrectRate` &times; `UpdateInterval`)  

All versions of Windows use the same final equation to check `PhaseCorrection`:  

   > `PhaseCorrection` &le; `SystemClockRate` &divide; 2  

> [!NOTE]  
> - Windows Server 2019 and Windows 10 1809 have the same formula as [Windows Server 2016 and later versions] described above by applying cumulative updates from KB5006744 onwards.
> - These equations use `PhaseCorrectRate`, `UpdateInterval`, `MaxAllowedPhaseOffset`, and `SystemClockRate` measured in units of clock ticks. On Windows systems, 1 ms = 10,000 clock ticks.
> - `MaxAllowedPhaseOffset` is configurable in the registry. However, the registry parameter is measured in seconds instead of clock ticks.
> - To see the `SystemClockRate` and `pollIntervalInSeconds` values (measured in seconds), open a Command Prompt window and then run `W32tm /query /status /verbose`. This command produces output that resembles the following.  
>    :::image type="content" source="media/windows-time-service-tools-and-settings/windows-time-service-parameter-status.png" alt-text="Output of the w32tm /query /status /verbose command, that lists parameter values for the time service.":::  
>     The output presents the poll interval in both clock ticks and in seconds. The equations use the value measured in seconds (the value in parentheses).  
>    The output presents the clock rate in seconds. To see the `SystemClockRate` value in clock ticks, use the following formula:  
>   > (`value in seconds`) &times; 1,000 &times; 10,000  
>   
>    For example, if `SystemClockRate` is 0.0156250 seconds, the value that the equation uses is 156,250 clock ticks.
> For full descriptions of the configurable parameters and their default values, see [Config entries](#config) later in this article.

The following examples show how to apply these calculations for Windows Server 2012 R2 and earlier versions.  

#### Example: System clock rate off by four minutes

Your computer clock time is 11:05 and the actual current time is 11:09:

> `PhaseCorrectRate` = 1
>
> `UpdateInterval` = 30,000 clock ticks
>
> `SystemClockRate` = 156,000 clock ticks
>
> `MaxAllowedPhaseOffset` = 10 min = 600 seconds = 600 &times; 1,000 &times; 10,000 = 6,000,000,000 clock ticks
>
> |`CurrentTimeOffset`| = 4 min = 4 &times; 60 &times; 1,000 &times; 10,000 = 2,400,000,000 clock ticks
>
Is `CurrentTimeOffset` &le; `MaxAllowedPhaseOffset`?

> 2,400,000,000 &le; 6,000,000,000: TRUE

AND does it satisfy the following equation?

> (|`CurrentTimeOffset`| &divide; (`PhaseCorrectRate` &times; `UpdateInterval`) &le; `SystemClockRate` &divide; 2)

Is 2,400,000,000 / (30,000 &times; 1) &le; 156,000 &divide; 2

80,000 &le; 78,000: FALSE

Therefore, W32tm.exe would set the clock back immediately.

> [!NOTE]
> In this case, if you want to set the clock back slowly, you would also have to adjust the values of `PhaseCorrectRate` or `UpdateInterval` in the registry to make sure that the equation result is TRUE.

#### Example: System clock rate off by three minutes

Your computer clock time is 11:05 and the actual current time is 11:08:

> `PhaseCorrectRate` = 1
>
> `UpdateInterval` = 30,000 clock ticks
>
> `SystemClockRate` = 156,000 clock ticks
>
> `MaxAllowedPhaseOffset` = 10 min = 600 seconds = 600 &times; 1,000 &times; 10,000 = 6,000,000,000 clock ticks
>
> |`CurrentTimeOffset`| = 3 mins = 3 &times; 60 &times; 1,000 &times; 10,000 = 1,800,000,000 clock ticks
>
Is `CurrentTimeOffset` &le; `MaxAllowedPhaseOffset`?
>
> 1,800,000,000 &le; 6,000,000,000: TRUE

AND does it satisfy the following equation?

> (|`CurrentTimeOffset`| &divide; (`PhaseCorrectRate` &times; `UpdateInterval`) &le; `SystemClockRate` &divide; 2)

 Is 3 mins &times; (1,800,000,000) &divide; (30,000 &times; 1) &le; 156,000 &divide; 2

> Is 60,000 &le; 78,000: TRUE

In this case, the clock will be set back slowly.

## Using Local Group Policy Editor

The Windows Time service stores a number of configuration properties as registry entries. You can use Group Policy Objects (GPOs) in Local Group Policy Editor to configure most of this information. For example, you can use GPOs to configure a computer to be an NTPServer or NTPClient, configure the time synchronization mechanism, or configure a computer to be a reliable time source.

> [!NOTE]
> Group Policy settings for the Windows Time service can be applied on Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and Windows Server 2008 R2 domain controllers and can be applied to computers running Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and Windows Server 2008 R2.

Windows stores the Windows Time service policy information in the Local Group Policy Editor under `Computer Configuration\Administrative Templates\System\Windows Time Service`. It stores configuration information that the policies define in the Windows registry, and then uses those registry entries to configure the registry entries specific to the Windows Time service. As a result, the values defined by Group Policy overwrite any pre-existing values in the Windows Time service section of the registry. Some of the preset GPO settings differ from the corresponding default Windows Time service registry entries.

For example, suppose you edit policy settings in the **Time Providers\Configure Windows NTP Client** policy. Windows loads these settings into the policy area of the registry under the following subkey:

> `HKLM\Software\Policies\Microsoft\W32time\TimeProviders\NtpClient`

Then Windows uses the policy settings to configure the related Windows Time service registry entries under the following subkey:

> `HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Time Providers\NTPClient\\`

The following table lists the policies that you can configure for the Windows Time service, and the registry subkeys that those policies affect.

> [!NOTE]
> When you remove a Group Policy setting, Windows removes the corresponding entry from the policy area of the registry.

|Group Policy<sup>1</sup> |Registry locations<sup>2,</sup> <sup>3</sup> |
| --- | --- |
|Global Configuration Settings |W32Time<br />W32Time\Config<br />W32Time\Parameters |
|Time Providers\Configure Windows NTP Client |W32Time\TimeProviders\NtpClient |
|Time Providers\Enable Windows NTP Client |W32Time\TimeProviders\NtpClient |
|Time Providers\Enable Windows NTP Server |W32Time\TimeProviders\NtpServer |

<sup>1</sup> `Category path: Computer Configuration\Administrative Templates\System\Windows Time Service`<br>
<sup>2</sup> Subkey: `HKLM\SOFTWARE\Policies\Microsoft`<br>
<sup>3</sup> Subkey: `HKLM\SYSTEM\CurrentControlSet\Services`

## Windows registry reference

> [!WARNING]
> This information is provided as a reference for use in troubleshooting and validation. Windows registry keys are used by W32Time to store critical information. Don't change these values. Modifications to the registry are not validated by the registry editor or by Windows before they are applied. If the registry contains invalid values, Windows may experience unrecoverable errors.

The Windows Time service stores information in the registry at the **HKLM\SYSTEM\CurrentControlSet\Services\W32Time** path under the following subkeys:

- [**\Config**](#config)
- [**\Parameters**](#parameters)
- [**\TimeProviders\NtpClient**](#ntpclient)
- [**\TimeProviders\NtpServer**](#ntpserver)

In the following tables, "All versions" refers to Windows 7, Windows 8, Windows 10, Windows Server 2008 and Windows Server 2008 R2, Windows Server 2012 and Windows Server 2012 R2, Windows Server 2016, and Windows Server 2019. 

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
|**MaxAllowedPhaseOffset** |All versions |Specifies the maximum offset (in seconds) for which W32Time attempts to adjust the computer clock by using the clock rate. When the offset exceeds this rate, W32Time sets the computer clock directly. The default value for domain members is **300**. The default value for stand-alone clients and servers is **1**. |
|**MaxClockRate** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default value for domain members is **155860**. The default value for stand-alone clients and servers is **155860**. |
|**MaxNegPhaseCorrection** |All versions |Specifies the largest negative time correction, in seconds, that the service makes. If the service determines that a change larger than this is required, it logs an event instead.<p>**Note**<br />The value **0xFFFFFFFF** is a special case. This value means that the service always corrects the time.<p>The default value for domain members is **0xFFFFFFFF** (hexadecimal). The default value for domain controllers is **172,800** (48 hrs). The default value for stand-alone clients and servers is **54,000** (15 hrs).|
|**MaxPollInterval** |All versions |Specifies the largest interval, in log2 seconds, allowed for the system polling interval. Note that while a system must poll according to the scheduled interval, a provider can refuse to produce samples when requested to do so. The default value for domain controllers is **10**. The default value for domain members is **15**. The default value for stand-alone clients and servers is **15**. |
|**MaxPosPhaseCorrection** |All versions |Specifies the largest positive time correction in seconds that the service makes. If the service determines that a change larger than this is required, it logs an event instead.<p>**Note**<br />The value **0xFFFFFFFF** is a special case. This value means that the service always corrects the time.<p>The default value for domain members is **0xFFFFFFFF** (hexadecimal). The default value for domain controllers is **172,800** (48 hrs). The default value for stand-alone clients and servers is **54,000** (15 hrs). |
|**MinClockRate** |All versions |Maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default value for domain members is **155860**. The default value for stand-alone clients and servers is **155860**. |
|**MinPollInterval** |All versions |Specifies the smallest interval, in log base 2 seconds, allowed for the system polling interval. Note that while a system does not request samples more frequently than this, a provider can produce samples at times other than the scheduled interval. The default value for domain controllers is **6**. The default value for domain members is **10**. The default value for stand-alone clients and servers is **10**. |
|**PhaseCorrectRate** |All versions |Controls the rate at which the phase error is corrected. Specifying a small value corrects the phase error quickly, but might cause the clock to become unstable. If the value is too large, it takes a longer time to correct the phase error.<p>The default value on domain members is **1**. The default value on stand-alone clients and servers is **7**.<p>**Note**<br />Zero is not a valid value for the **PhaseCorrectRate** registry entry. On Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and  Windows Server 2008 R2 computers, if the value is set to **0**, the Windows Time service automatically changes it to **1**. |
|**PollAdjustFactor** |All versions |Controls the decision to increase or decrease the poll interval for the system. The larger the value, the smaller the amount of error that causes the poll interval to be decreased. The default value on domain members is **5**. The default value on stand-alone clients and servers is **5**. |
|**RequireSecureTimeSyncRequests** |Windows 8 and later versions |Controls whether or not the DC will respond to time sync requests that use older authentication protocols. If enabled (set to **1**), the DC will not respond to requests using such protocols. This is a boolean setting, and the default value is **0**. |
|**SpikeWatchPeriod** |All versions |Specifies the amount of time that a suspicious offset must persist before it is accepted as correct (in seconds). The default value on domain members is **900**. The default value on stand-alone clients and workstations is **900**. |
|**TimeJumpAuditOffset** |All versions |An unsigned integer that indicates the time jump audit threshold, in seconds. If the time service adjusts the local clock by setting the clock directly, and the time correction is more than this value, then the time service logs an audit event. |
|**UpdateInterval** |All versions |Specifies the number of clock ticks between phase correction adjustments. The default value for domain controllers is **100**. The default value for domain members is **30,000**. The default value for stand-alone clients and servers is **360,000**.<p>**Note**<br />Zero is not a valid value for the **UpdateInterval** registry entry. On computers running Windows Server 2003, Windows Server 2003 R2, Windows Server 2008, and Windows Server 2008 R2, if the value is set to **0**, the Windows Time service automatically changes it to **1**.|
|**UtilizeSslTimeData** |Windows versions later than Windows 10 build 1511 |Value of **1** indicates that W32Time uses multiple SSL timestamps to seed a clock that is grossly inaccurate. |

### <a id="parameters"></a>Parameters entries

The `Parameters` subkey entries are located at `HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters`.

| Registry entry | Versions | Description |
| --- | --- | --- |
|**AllowNonstandardModeCombinations** |All versions |Indicates that non-standard mode combinations are allowed in synchronization between peers. The default value for domain members is **1**. The default value for stand-alone clients and servers is **1**. |
|**NtpServer** |All versions |Specifies a space-delimited list of peers from which a computer obtains time stamps, consisting of one or more DNS names or IP addresses per line. Each DNS name or IP address listed must be unique. Computers connected to a domain must synchronize with a more reliable time source, such as the official U.S. time clock.  <ul><li>0x01 SpecialInterval </li><li>0x02 UseAsFallbackOnly</li><li>0x04 SymmetricActive: For more information about this mode, see [Windows Time Server](https://go.microsoft.com/fwlink/?LinkId=208012).</li><li>0x08 Client</li></ul><br />There is no default value for this registry entry on domain members. The default value on stand-alone clients and servers is `time.windows.com,0x1`. |
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
|AllowNonstandardModeCombinations |All versions |Indicates that non-standard mode combinations are allowed in synchronization between clients and servers. The default value for domain members is **1**. The default value for stand-alone clients and servers is **1**. |
|DllName |All versions |Specifies the location of the DLL for the time provider. The default location for this DLL on both domain members and stand-alone clients and servers is `%windir%\System32\W32Time.dll`.  |
|Enabled |All versions |Indicates if the NtpServer provider is enabled in the current Time Service. <ul><li>**1** - Yes</li><li>**0** - No</li></ul>The default value on domain members is **1**. The default value on stand-alone clients and servers is **1**. |
|InputProvider |All versions |Indicates whether to enable the NtpClient as an InputProvider, which obtains time information from the NtpServer. The NtpServer is a time server that responds to client time requests on the network by returning time samples that are useful for synchronizing the local clock. <ul><li>**1** - Yes</li><li>**0** - No = 0 </li></ul>Default value for both domain members and stand-alone clients: 1 |

### Enhanced logging

The following registry entries are not a part of the W32Time default configuration but can be added to the registry to obtain enhanced logging capabilities. The information logged to the System Event log can be modified by changing values for the **EventLogFlags** setting in the Group Policy Object Editor. By default, the Windows Time service logs an event every time that it switches to a new time source.

In order to enable W32Time logging, add the following registry entries:

|Entry |Versions |Description |
| --- | --- | --- |
|FileLogEntries |All versions |Controls the number of entries created in the Windows Time log file. The default value is none, which does not log any Windows Time activity. Valid values are **0** to **300**. This value does not affect the event log entries normally created by Windows Time |
|FileLogName |All versions |Controls the location and file name of the Windows Time log. The default value is blank, and should not be changed unless **FileLogEntries** is changed. A valid value is a full path and file name that Windows Time will use to create the log file. This value does not affect the event log entries normally created by Windows Time. |
|FileLogSize |All versions |Controls the circular logging behavior of Windows Time log files. When **FileLogEntries** and **FileLogName** are defined, defines the size, in bytes, to allow the log file to reach before overwriting the oldest log entries with new entries. Please use **1000000** or larger value for this setting. This value does not affect the event log entries normally created by Windows Time. |

## Group Policy Object settings

Group Policy settings are contained in the **Global Configuration Settings** and the **Windows NTP Client Settings** GPOs.

### Global Configuration Settings

These are the global Group Policy settings and default values for the Windows Time service. These settings are contained in the **Global Configuration Settings** GPO in Local Policy Editor.

|Group Policy setting|Default value|
| --- | --- |
|AnnounceFlags|10|
|EventLogFlags|2|
|FrequencyCorrectRate|4|
|HoldPeriod|5|
|LargePhaseOffset|1,280,000|
|LocalClockDispersion|10|
|MaxAllowedPhaseOffset|300|
|MaxNegPhaseCorrection|54,000 (15 hours)|
|MaxPollInterval|15|
|MaxPosPhaseCorrection|54,000 (15 hours)|
|MinPollInterval|10|
|PhaseCorrectRate|7|
|PollAdjustFactor|5|
|SpikeWatchPeriod|90|
|UpdateInterval|100|

### Windows NTP Client settings

These are the Windows NTP client settings and default values for the Windows Time service. These settings are contained in the **Configure Windows NTP Client** GPO in Local Group Policy Editor.

|Group Policy setting|Default value|
|------------------------|-----------------|
|NtpServer|`time.windows.com`, 0x1|
|Type|**NTP** - Use for non-domain-joined computers<br>**NT5DS** - Use for domain-joined computers|
|CrossSiteSyncFlags|2|
|ResolvePeerBackoffMinutes|15|
|ResolvePeerBackoffMaxTimes|7|
|SpecialPollInterval|3,600|
|EventLogFlags|0|

## Related information

See [RFC 1305 - Network Time Protocol](https://datatracker.ietf.org/doc/rfc1305/) of the Internet Engineering Task Force (IETF).
