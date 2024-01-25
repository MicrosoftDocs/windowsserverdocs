---
title: verifier
description: Reference article for the verifier command, which runs the Driver Verifier manager utility.
ms.topic: reference
ms.assetid: 782173d6-f196-4bc4-a547-76109829453c
ms.author: alalve
author: JasonGerend
ms.date: 10/20/2022
---

# verifier

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Driver Verifier monitors Windows kernel-mode drivers and graphics drivers to detect illegal function calls or actions that might corrupt the system. Driver Verifier can subject Windows drivers to a variety of stresses and tests to find improper behavior. You can configure which tests to run, which allows you to put a driver through heavy stress loads or through more streamlined testing. You can also run Driver Verifier on multiple drivers simultaneously, or on one driver at a time.

> [!IMPORTANT]
> You must be in the Administrators group on the computer to use Driver Verifier.
> Running Driver Verifier can cause the computer to crash, so you should only run this utility on computers used for testing and debugging.

## Syntax

```
verifier /standard /all
verifier /standard /driver NAME [NAME ...]
verifier /flags <options> /all
verifier /flags <options> /driver NAME [NAME ...]
verifier /rules [OPTION ...]
verifier /query
verifier /querysettings
verifier /bootmode [persistent | disableafterfail | oneboot]
verifier /reset
verifier /faults [Probability] [PoolTags] [Applications] [DelayMins]
verifier /faultssystematic [OPTION ...]
verifier /log LOG_FILE_NAME [/interval SECONDS]
verifier /volatile /flags <options>
verifier /volatile /adddriver NAME [NAME ...]
verifier /volatile /removedriver NAME [NAME ...]
verifier /volatile /faults [Probability] [PoolTags] [Applications] [DelayMins]
verifier /domain <types> <options> /driver ... [/logging | /livedump]
verifier /logging
verifier /livedump
verifier /?
verifier /help
```

### Parameters

| Parameter | Description |
|--|--|
| /all | Directs the Driver Verifier utility to verify all installed drivers after the next boot. |
| /bootmode `[persistent \| disableafterfail \| oneboot \| resetonunusualshutdown]` | Controls whether the settings for the Driver Verifier utility are enabled after a reboot. To set or change this option, you must reboot the computer. The following modes are available:<ul><li>**persistent** - Ensures that the Driver Verifier settings persist (stay in effect) over many reboots. This is the default setting.</li><li>**disableafterfail** - If Windows fails to start, this setting disables the Driver Verifier utility for subsequent reboots.</li><li>**oneboot** - Only enables the Driver Verifier settings for the next time the computer starts. The Driver Verifier utility is disabled for subsequent reboots.</li><li>**resetonunusualshutdown** - The Driver Verifier utility will persist until an unusual shutdown occurs. Its abbrevation, 'rous', can be used.</li></ul> |
| /driver `<driverlist>` | Specifies one or more drivers that will be verified. The **driverlist** parameter is a list of drivers by binary name, such as *driver.sys*. Use a space to separate each driver name. Wildcard values, such as `n*.sys`, aren't supported. |
| /driver.exclude `<driverlist>` | Specifies one or more drivers that will be excluded from verification. This parameter is applicable only if all drivers are selected for verification. The **driverlist** parameter is a list of drivers by binary name, such as *driver.sys*. Use a space to separate each driver name. Wildcard values, such as `n*.sys`, aren't supported. |
| /faults | Enables the **Low Resources Simulation** feature in the Driver Verifier utility. You can use **/faults** in place of `/flags 0x4`. However, you can't use `/flags 0x4` with the **/faults** subparameters. You can use the following subparameters of the /faults parameter to configure the Low Resources Simulation:<ul><li>**Probability** - Specifies the probability that the Driver Verifier utility will fail a given allocation. Type a number (in decimal or hexadecimal) to represent the number of chances in 10,000 that the Driver Verifier utility will fail the allocation. The default value, 600, means 600/10000 or 6%.</li><li>**Pool Tags** - Limits the allocations that the Driver Verifier utility can fail to allocations with the specified pool tags. You can use a wildcard character (*) to represent multiple pool tags. To list multiple pool tags, separate the tags with spaces. By default, all allocations can fail.</li><li>**Applications** - Limits the allocations that the Driver Verifier utility can fail to allocations for the specified program. Type the name of an executable file. To list programs, separate the program names with spaces. By default, all allocations can fail.</li><li>**DelayMins** - Specifies the number of minutes after booting during which the Driver Verifier utility does not intentionally fail any allocations. This delay allows the drivers to load and the system to stabilize before the test begins. Type a number (in decimal or hexadecimal). The default value is 7 (minutes).</li></ul> |
| /faultssystematic | Specifies the options for **Systematic Low Resources** simulation. Use the `0x40000` flag to select the **Systematic Low Resources** simulation option. The following options are available:<ul><li>**enableboottime** - Enables fault injections across computer reboots.</li><li>**disableboottime** - Disables fault injections across computer reboots (this is the default setting).</li><li>**recordboottime** - Enables fault injections in what if mode across computer reboots.</li><li>**resetboottime** - Disables fault injections across computer reboots and clears the stack exclusion list.</li><li>**enableruntime** - Dynamically enables fault injections.</li><li>**disableruntime** - Dynamically disables fault injections.</li><li>**recordruntime** - Dynamically enables fault injections in what if mode.</li><li>**resetruntime** - Dynamically disables fault injections and clears the previously faulted stack list.</li><li>**querystatistics** - Shows the current fault injection statistics.</li><li>**incrementcounter** - Increments the test pass counter used to identify when a fault was injected.</li><li>**getstackid COUNTER** - Retrieves the indicated injected stack identifier.</li><li>**excludestack STACKID** - Excludes the stack from fault injection.</li></ul> |
| /flags `<options>` | Activates the specified options after the next reboot. This number can be entered in decimal or in hexadecimal (with an 0x prefix) format. Any combination of the following values is allowed:<ul><li>**Value: 1 or 0x1 (bit 0)** - [Special pool checking](/windows-hardware/drivers/devtest/special-pool)</li><li>**Value: 2 or 0x2 (bit 1)** - [Force IRQL Checking](/windows-hardware/drivers/devtest/force-irql-checking)</li><li>**Value: 4 or 0x4 (bit 2)** - [Low Resources Simulation](/windows-hardware/drivers/devtest/low-resources-simulation)</li><li>**Value: 8 or 0x8 (bit 3)** - [Pool Tracking](/windows-hardware/drivers/devtest/pool-tracking)</li><li>**Value: 16 or 0x10 (bit 4)** - [I/O Verification](/windows-hardware/drivers/devtest/i-o-verification)</li><li>**Value: 32 or 0x20 (bit 5)** - [Deadlock Detection](/windows-hardware/drivers/devtest/deadlock-detection)</li><li>**Value: 64 or 0x40 (bit 6)** - [Enhanced I/O Verification](/windows-hardware/drivers/devtest/enhanced-i-o-verification). This option is automatically activated when you select **I/O Verification**.</li><li>**Value: 128 or 0x80 (bit 7)** - [DMA Verification](/windows-hardware/drivers/devtest/dma-verification)</li><li>**Value: 256 or 0x100 (bit 8)** - [Security Checks](/windows-hardware/drivers/devtest/security-checks)</li><li>**Value: 512 or 0x200 (bit 9)** - [Force Pending I/O Requests](/windows-hardware/drivers/devtest/force-pending-i-o-requests)</li><li>**Value: 1024 or 0x400 (bit 10)** - [IRP Logging](/windows-hardware/drivers/devtest/irp-logging)</li><li>**Value: 2048 or 0x800 (bit 11)** - [Miscellaneous Checks](/windows-hardware/drivers/devtest/miscellaneous-checks)</li><li>**Value: 8192 or 0x2000 (bit 13)** - [Invariant MDL Checking for Stack](/windows-hardware/drivers/devtest/invariant-mdl-checking-for-stack)</li><li>**Value: 16384 or 0x4000 (bit 14)** - [Invariant MDL Checking for Driver](/windows-hardware/drivers/devtest/invariant-mdl-checking-for-driver)</li><li>**Value: 32768 or 0x8000 (bit 15)** - [Power Framework Delay Fuzzing](/windows-hardware/drivers/devtest/concurrency-stress-test)</li><li>**Value: 65536 or 0x10000 (bit 16)** - Port/miniport interface checking</li><li>**Value: 131072 or 0x20000 (bit 17)** - [DDI compliance checking](/windows-hardware/drivers/devtest/ddi-compliance-checking)</li><li>**Value: 262144 or 0x40000 (bit 18)** - [Systematic low resources simulation](/windows-hardware/drivers/devtest/systematic-low-resource-simulation)</li><li>**Value: 524288 or 0x80000 (bit 19)** - [DDI compliance checking (additional)](/windows-hardware/drivers/devtest/ddi-compliance-checking)</li><li>**Value: 2097152 or 0x200000 (bit 21)** - [NDIS/WIFI verification](/windows-hardware/drivers/devtest/ndis-wifi-verification)</li><li>**Value: 8388608 or 0x800000 (bit 23)** - [Kernel synchronization delay fuzzing](/windows-hardware/drivers/devtest/kernel-synchronization-delay-fuzzing)</li><li>**Value: 16777216 or 0x1000000 (bit 24)** - [VM switch verification](/windows-hardware/drivers/devtest/vm-switch-verification)</li><li>**Value: 33554432 or 0x2000000 (bit 25)** - Code integrity checks. You can't use this method to activate the SCSI Verification or Storport Verification options. For more information, see [SCSI Verification](/windows-hardware/drivers/devtest/scsi-verification) and [Storport Verification](/windows-hardware/drivers/devtest/dv-storport-verification).</li></ul> |
| /flags `<volatileoptions>` | Specifies the the Driver Verifier utility options that are changed immediately without rebooting.This number can be entered in decimal or in hexadecimal (with an 0x prefix) format. Any combination of the following values is allowed:<ul><li>**Value: 1 or 0x1 (bit 0)** - Special pool</li><li>**Value: 2 or 0x2 (bit 1)** - Force IRQL Checking</li><li>**Value: 4 or 0x4 (bit 2)** - Low Resources Simulation</li></ul> |
| `<probability>` | Number between 1 and 10,000 specifying the fault injection probability. For example, specifying 100 means a fault injection probability of 1% (100/10,000).<p>if this parameter isn't specified, the default probability of 6% is used. |
| `<tags>` | Specifies the pool tags that will be injected with faults, separated by space characters. If this parameter is not specified, then any pool allocation can be injected with faults. |
| `<apps>` | Specifies the image file name of the apps that will be injected with faults, separated by space characters. If this parameter isn't specified, then low resources simulation can take place in any application. |
| `<minutes>` | A positive number specifying the length of the period after rebooting, in minutes, during which no fault injection will occur. If this parameter isn't specified, then the default length of *8 minutes* is used. |
| /iolevel `<level>` | Specifies the level of I/O Verification. The value of [level] can be **1** - Enables Level 1 I/O Verification (default) or **2** - Enables Level 1 I/O Verification and Level 2 I/O Verification. If I/O Verification isn't enabled (by using `/flags 0x10`), **/iolevel** is ignored. |
| /log `<logfilename> [/intervalseconds]` | Creates a log file using the specified name. The Driver Verifier utility periodically writes statistics to this file, based on the interval you optionally set. The default interval is *30 seconds*.<p> If a verifier **/log** command is typed at the command line, the command prompt doesn't return. To close the log file and return a prompt, use the **CTRL+C** key. After a reboot, to create a log, you must submit the verifier **/log** command again. |
| /rules `<option>` | Options for rules that can be disabled, including:<ul><li>**query** - Shows current status of controllable rules.</li><li>**reset** - Resets all rules to their default state.</li><li>**default ID** - Sets rule ID to its default state. For the supported rules, the rule ID is the Bug Check 0xC4 (DRIVER_VERIFIER_DETECTED_VIOLATION) parameter 1 value.</li><li>**disable ID** - Disables specified rule ID. For the supported rules, the rule ID is the Bug Check 0xC4 (DRIVER_VERIFIER_DETECTED_VIOLATION) parameter 1 value.</li></ul> |
| /standard | Activates the "standard" or default Driver Verifier options after the next restart. The standard options are Special Pool, Force IRQL Checking, Pool Tracking, I/O Verification, Deadlock Detection, DMA Verification, Security Checks, Miscellaneous Checks, and DDI compliance checking. This is equivalent to `/flags 0x209BB`.<p>[!NOTE] Starting in Windows 10 versions after 1803, using `/flags 0x209BB` will no longer automatically enable WDF verification. Use the **/standard** syntax to enable standard options, with WDF verification included. |
| /volatile | Changes the settings without rebooting the computer. Volatile settings take effect immediately.<p>You can use the **/volatile** parameter with the **/flags** parameter to enable and disable some options without rebooting. You can also use **/volatile** with the **/adddriver** and **/removedriver** parameters to start or stop the verification of a driver without rebooting, even if the Driver Verifier utility isn't running. For more information, see [Using Volatile Settings](/windows-hardware/drivers/devtest/using-volatile-settings). |
| /adddriver `<volatiledriverlist>` | Adds the specified drivers from the volatile settings. To specify multiple drivers, list their names, separated by spaces. Wildcard values, such as *n.sys*, aren't supported. |
| /removedriver `<volatiledriverlist>` | Removes the specified drivers from the volatile settings. To specify multiple drivers, list their names, separated by spaces. Wildcard values, such as *n.sys*, aren't supported. |
| /reset | Clears all the Driver Verifier utility settings. After the next restart, no drivers will be verified. |
| /querysettings | Displays a summary of the options that will be activated and drivers that will be verified after the next boot. The display doesn't include drivers and options added by using the **/volatile** parameter. For other ways to view these settings, see [Viewing Driver Verifier Settings](/windows-hardware/drivers/devtest/viewing-driver-verifier-settings). |
| /query | Displays a summary of the Driver Verifier utility's current activity. The **Level** field in the display is the hexadecimal value of options set with the **/volatile** parameter. For explanations of each statistic, see [Monitoring Global Counters](/windows-hardware/drivers/devtest/monitoring-global-counters) and [Monitoring Individual Counters](/windows-hardware/drivers/devtest/monitoring-individual-counters). |
| /domain `<types> <options>` | Controls the verifier extension settings. The following verifier extension types are supported:<ul><li>**wdm** - Enables verifier extension for WDM drivers.</li><li>**ndis** - Enables verifier extension for networking drivers.</li><li>**ks** - Enables verifier extension for kernel mode streaming drivers.</li><li>**audio** - Enables verifier extension for audio drivers.</li></ul>. The following extension options are supported:<ul><li>**rules.default** - Enables default validation rules for the selected verifier extension.</li><li>**rules.all** - Enables all validation rules for the selected verifier extension.</li></ul> |
| /logging | Enables logging for violated rules detected by the selected verifier extensions. |
| /livedump | Enables live memory dump collection for violated rules detected by the selected verifier extensions. |
| /? | Displays command-line help. |

### Return Codes

The following values are returned after driver verifier has run:

- 0: EXIT_CODE_SUCCESS

- 1: EXIT_CODE_ERROR

- 2: EXIT_CODE_REBOOT_NEEDED

#### Remarks

- You can use the **/volatile** parameter with some of the Driver Verifier utility **/flags** options and with **/standard**. You can't use **/volatile** with the **/flags** options for [DDI compliance checking](/windows-hardware/drivers/devtest/ddi-compliance-checking), [Power Framework Delay Fuzzing](/windows-hardware/drivers/devtest/concurrency-stress-test), [Storport Verification](/windows-hardware/drivers/devtest/dv-storport-verification), or [SCSI Verification](/windows-hardware/drivers/devtest/scsi-verification). For more information, see [Using Volatile Settings](/windows-hardware/drivers/devtest/using-volatile-settings).

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Driver Verifier](/windows-hardware/drivers/devtest/driver-verifier)

- [Controlling Driver Verifier](/windows-hardware/drivers/devtest/controlling-driver-verifier)

- [Monitoring Driver Verifier](/windows-hardware/drivers/devtest/monitoring-driver-verifier)

- [Using Volatile Settings](/windows-hardware/drivers/devtest/using-volatile-settings)
