---
title: Sysmon in Windows
description: Learn how to use Sysmon, a Windows system service and device driver, to monitor and log system activity to the Windows event log. Explore syntax and examples.
#customer intent: As a security analyst, I want to configure Sysmon with a custom configuration file so that I can tailor it to my organization's security needs.
author: robinharwood
ms.author: roharwoo
ms.date: 02/23/2026
ms.topic: reference
---

# sysmon

System Monitor (Sysmon) is a Windows system service and device driver that you install on a system. It stays resident across system reboots to monitor and log system activity to the Windows event log. It provides detailed information about process creations, network connections, and changes to file creation time.

> [!TIP]
> Starting February 2026, Sysmon is available as a built-in optional feature for Windows 11. To learn more, see [Sysmon overview](/windows/security/operating-system-security/sysmon/overview).
>
> Looking for the Sysinternals standalone documentation? See [Sysinternals Sysmon](/sysinternals/downloads/sysmon).

## Syntax

```cmd
sysmon [-i [<configfile>]] [-c [<configfile>]] [-m] [-s] [-u [force]] [-accepteula]
```

## Parameters

| Parameter | Description |
| -- | -- |
| `-i [<configfile>]` | Installs the service and driver. Optionally includes a configuration file. |
| `-c [<configfile>]` | Updates the configuration of an installed Sysmon driver, or dumps the current configuration if no other argument is provided. Optionally includes a configuration file. |
| `-m` | Installs the event manifest. The service install implicitly does this action. |
| `-s [<schemaversion>]` | Prints the configuration schema definition of the specified version. Specify `all` to dump all schema versions. The default is latest. |
| `-u [force]` | Uninstalls the service and driver. Using `-u force` causes uninstall to proceed even when some components aren't installed. |
| `-accepteula` | Automatically accepts the End User License Agreement (EULA) on installation. |
| `-? config` | Displays more information on configuration files. |

## Remarks

- Event logs are stored in `Applications and Services Logs/Microsoft/Windows/Sysmon/Operational` log.
- The install or uninstall options don't require a reboot.
- To reset the configuration to default settings, use `sysmon -c --`.

## Examples

To install Sysmon with default settings, run the following command:

```cmd
sysmon -accepteula -i
```

To install Sysmon with a configuration file, run the following command:

```cmd
sysmon -accepteula -i c:\windows\config.xml
```

To dump the current configuration, run the following command:

```cmd
sysmon -c
```

To reset the configuration to default settings, run the following command:

```cmd
sysmon -c --
```

To reconfigure Sysmon with a configuration file, run the following command:

```cmd
sysmon -c c:\windows\config.xml
```

To display the configuration schema, run the following command:

```cmd
sysmon -s
```

To display the configuration schema for a specific version, run the following command:

```cmd
sysmon -s 4.50
```

To display all configuration schema versions, run the following command:

```cmd
sysmon -s all
```

To uninstall Sysmon, run the following command:

```cmd
sysmon -u
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
