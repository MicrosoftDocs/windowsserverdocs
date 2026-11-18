---
title: wmic
description: Reference article for wmic, which displays WMI information inside an interactive command shell.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 05/19/2025
ai-usage: ai-assisted
---

# wmic

Displays WMI information inside an interactive command shell.

> [!IMPORTANT]
> The Windows Management Instrumentation (WMI) command-line (WMIC) utility is deprecated as of Windows 10, version 21H1, and as of the 21H1 semi-annual channel release of Windows Server. Beginning with Windows Server 2025, WMIC is available as a Feature on Demand (FOD). To add WMIC, use the `DISM /Add-Capability` command. The announced Windows Server 2028 (preview) release removes the WMIC utility. Windows Server 2028 is in preview, and this removal announcement doesn't mean that WMIC is absent from current preview builds. WMIC might still be available in current preview builds, and the removal plans can change before release. This deprecation and removal apply only to the WMIC utility; WMI itself is not removed. Windows PowerShell replaces this utility for WMI (see [Chapter 7 - Working with WMI](/powershell/scripting/learn/ps101/07-working-with-wmi)). Use PowerShell or programmatically query WMI as a replacement for WMIC. For more information, see [Features removed or no longer developed in Windows Server](../../get-started/removed-deprecated-features-windows-server.md) and [Windows 10 features we're no longer developing](/windows/deployment/planning/windows-10-deprecated-features).

## Syntax

```cmd
wmic </parameter>
```

## Sub-commands

The following sub-commands are available:

|Sub-command|Description|
|-----------|-----------|
|logicaldisk|Displays properties of all the logical disks on this computer.|
|class|Escapes from the default alias mode of WMIC to access classes in the WMI schema directly.|
|path|Escapes from the default alias mode of WMIC to access instances in the WMI schema directly.|
|context|Displays the current values of all global switches.|
|[quit \| exit]|Exits the WMIC command shell.|

## Examples

To display the current values of all global switches, type:

```cmd
wmic context
```

Output similar to the following displays:

```output
NAMESPACE    : root\cimv2
ROLE         : root\cli
NODE(S)      : BOBENTERPRISE
IMPLEVEL     : IMPERSONATE
[AUTHORITY   : N/A]
AUTHLEVEL    : PKTPRIVACY
LOCALE       : ms_409
PRIVILEGES   : ENABLE
TRACE        : OFF
RECORD       : N/A
INTERACTIVE  : OFF
FAILFAST     : OFF
OUTPUT       : STDOUT
APPEND       : STDOUT
USER         : N/A
AGGREGATE    : ON
```

To display all properties of all logical disks on the computer, type:

```cmd
wmic logicaldisk
```

Output similar to the following displays:

```output
Access                    Description        InstallDate                   PowerManagementSupported   StatusInfo
Availability              DeviceID           LastErrorCode                 ProviderName               SupportsDiskQuotas
BlockSize                 DriveType          MaximumComponentLength        Purpose                    SupportsFileBasedCompression
Caption                   ErrorCleared       MediaType                     QuotasDisabled             SystemCreationClassName
Compressed                ErrorDescription   Name                          QuotasIncomplete           SystemName
ConfigManagerErrorCode    ErrorMethodology   NumberOfBlocks                QuotasRebuilding           VolumeDirty
ConfigManagerUserConfig   FileSystem         PNPDeviceID                   Size                       VolumeName
CreationClassName         FreeSpace          PowerManagementCapabilities   Status                     VolumeSerialNumber

0   C:   FALSE   Win32_LogicalDisk   Local Fixed Disk   C:   3   NTFS   543237451776   255   12   C:                                                                                                                                              1021771247616   FALSE   TRUE   Win32_ComputerSystem   <TheDeviceName>   <TheVolumeName>   0011AABB
```

To get the name of the logical disks, type:

```cmd
wmic logicaldisk get name
```

Output similar to the following displays:

```output
Name
C:
```

To change the language ID used by the command line to English (locale ID 409), type:

```cmd
wmic /locale:ms_409
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
