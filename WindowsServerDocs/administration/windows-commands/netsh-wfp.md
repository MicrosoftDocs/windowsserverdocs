---
title: netsh wfp
description: The netsh wfp command manages the Windows Filtering Platform (WFP) to capture, display, and analyze network traffic in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/11/2025
---

# netsh wfp

The `netsh wfp` command is used to manage and troubleshoot the Windows Filtering Platform (WFP). It enables you to capture, display, and analyze filtering rules, network events, and diagnostics related to network traffic filtering. This tool is useful for administrators who need to investigate network policies, monitor traffic, and resolve issues with WFP configuration.

## Syntax

```
netsh wfp [capture | dump | help | set | show | ?]
```

```
netsh wfp capture start cab=<on|off> traceonly=<on|off> keywords=<none|bcast|mcast|bcast+mcast> file=<path>
netsh wfp capture status
netsh wfp capture stop
```

```
netsh wfp dump
```

```
netsh wfp set options netevents=<on|off> keywords=<none|bcast|mcast|bcast+mcast> txnwatchdog=<milliseconds>
```

```
netsh wfp show appid file=<path>
               boottimepolicy file=<path|->
               filters file=<path|-> protocol=<ipprotocol> localaddr=<ipaddress> remoteaddr=<ipaddress> localport=<port>
                       appid=<path> userid=<user> dir=<in|out> verbose=<on|off>
               ikeevents file=<path|-> remoteaddr=<ipaddress>
               netevents file=<path|-> protocol=<ipprotocol> localaddr=<ipaddress> remoteaddr=<ipaddress> localport=<port>
                         remoteport=<port> appid=<path> userid=<user> timewindow=<seconds>
               options optionsfor=<netevents|keywords|txnwatchdog>
               security type=<callout|engine|filter|ikesadb|ipsecsadb|layer|netevents|provider|providercontext|sublayer>
                        guid=<guid>
               state file=<path|->
               sysports file=<path|->
```

## Parameters

| Command | Description |
|--|--|
| netsh `wfp capture start` | Starts a capture session for network events processed by WFP. <br><br> **cab** - Specifies whether to compress the output files into a single `.cab` archive. <li> `on` (default): Combines all files into one `.cab` file. <li> `off`: Leaves files uncompressed, useful for manual troubleshooting. </li><br> **traceonly** - Determines if only event tracing data is collected. <br><li> `on`: Captures only event tracing, resulting in smaller output files. <li> `off` (default): Captures all relevant data. </li><br> **keywords** - Sets the network event keywords for the capture session. Options include: <br><li> `NONE`: Excludes both to minimize file size for extended captures. <li> `BCAST`: Includes broadcast events. <li> `MCAST`: Includes multicast events. <li> `BCAST+MCAST` Includes both broadcast & multicast events (default). </li><br> **file** - Specifies the output file name. The default is `wfpdiag.cab`. If the `cab` parameter is set to `on`, the file name shouldn't include the extension since the `.cab` is automatically added to the output file. |
| netsh `wfp capture status` | Displays the status of the current capture session, indicating whether a session is active and providing details about the ongoing capture process. |
| netsh `wfp capture stop` | Stops an active capture session that was started with the `capture start` command. Use this command to end data collection and finalize the output files for analysis. |
| netsh `wfp dump` | Generates a script reflecting the current WFP configuration. You can save this script to a file and later use it to restore any modified settings. |
| netsh `wfp set options` | Configures global options for the Windows Filtering Platform. Only one option parameter can be modified per command execution. <br><br> **netevents** - Enables or disables the collection of network events. <li> `on`: Network events are captured. <li> `off`: Network event collection is disabled. </li><br> **keywords** - Specifies which types of network events to capture. Options include: <li> `NONE`: No broadcast or multicast events are captured (default). <li> `BCAST`: Captures broadcast events only. <li> `MCAST`: Captures multicast events only. <li> `BCAST+MCAST`: Captures both broadcast and multicast events. </li><br> **txnwatchdog** - Sets the timeout (in milliseconds) for transaction watchdog events. Provide an integer value to specify the timeout. If set to zero or not specified, an event is triggered for every transaction. |
| netsh `wfp show appid` | Displays the device path of the executable using `file=<path>` format. |
| netsh `wfp show boottimepolicy` | Displays the boot-time policy and filters using `file=<path>` as the output file name. By default, the output is saved as `btpol.xml`. If you set this parameter to a dash (`file=-`), the output is displayed directly in the console instead of being saved to a file. |
| netsh `wfp show filters` | Displays filters matching the specified traffic parameters. <br><br><li> **file** - Specifies the output file name in the `file=<path>` format. The default is `filters.xml`. If set to a dash (`file=-`), the output is displayed in the console instead of being saved to a file. <li> **protocol** - The IP protocol number, for example, use `6` for TCP or `17` for UDP. To learn more, see [IANA Protocol Numbers](https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml). <li> **localaddr** / **remoteaddr** - Specifies the local or remote IP addresses respectively. Both must be either IPv4 or IPv6, and if both are specified, they must belong to the same address family. <li> **localport** / **remoteport** - Specifies the local or remote port numbers respectively. <li> **appid** - The application path on the local host that is sending or receiving traffic. Accepts either an NT path (`\device\harddiskvolume1\windows\system32\ftp.exe`) or a DOS path (`C:\Windows\System32\ftp.exe`). The specified path must exist. <li> **userid** - The user associated with the traffic on the local host. Can be a security identifier (SID) such as `S-1-5-18` or a user name such as `NT AUTHORITY\SYSTEM`. <li> **dir** - The direction of the connection. By default, both inbound and outbound filters are shown. Use `IN` to display only inbound filters or `OUT` for outbound filters. <li> **verbose** - Controls the level of detail in the output. Set to `ON` to display all matching filters, or `OFF` (default) to suppress filters unlikely to affect connectivity. </li> |
| netsh `wfp show ikeevents` | Displays recent Internet Key Exchange (IKE) epoch events matching the specified parameters. <br><br><li> **file** - Specifies the output file name for the results in the format `file=<path>`. The default is `netevents.xml`. If you set this parameter to a dash (`file=-`), the output is displayed directly in the console instead of being saved to a file. <li> **remoteaddr** - The remote IP address to filter events by. Accepts either an IPv4 or IPv6 address. </li> |
| netsh `wfp show netevents` | Displays recent network events matching the specified traffic parameters. <br><br><li> **file** - Specifies the output file name in the `file=<path>` format. The default is `filters.xml`. If set to a dash (`file=-`), the output is displayed in the console instead of being saved to a file. <li> **protocol** - The IP protocol number, for example, use `6` for TCP or `17` for UDP. <li> **localaddr** / **remoteaddr** - Specifies the local or remote IP addresses respectively. Both must be either IPv4 or IPv6, and if both are specified, they must belong to the same address family. <li> **localport** / **remoteport** - Specifies the local or remote port numbers respectively. <li> **appid** - The application path on the local host that is sending or receiving traffic. Accepts either an NT path (`\device\harddiskvolume1\windows\system32\ftp.exe`) or a DOS path (`C:\Windows\System32\ftp.exe`). The specified path must exist. <li> **userid** - The user associated with the traffic on the local host. Can be a security identifier (SID) such as `S-1-5-18` or a user name such as `NT AUTHORITY\SYSTEM`. <li> **timewindow** - Limits the displayed network events to a specified time frame in seconds. </li> |
| netsh `wfp show options` | Specifies which global WFP option to display in `optionsfor=` format. Options are: <br><br><li> `NETEVENTS`: Shows whether network event diagnostics are enabled or disabled. <li> `KEYWORDS`: Displays the types of network events (such as broadcast or multicast) that are being captured for diagnostics. <li> `TXNWATCHDOG`: Displays the current timeout value (in milliseconds) for the transaction watchdog event. </li> |
| netsh `wfp show security` | Displays the specified security descriptor. <br><br> **type** - Specifies the WFP object type whose security descriptor you want to display in `type=` format. Options include: <li> `CALLOUT` <li> `ENGINE` <li> `FILTER` <li> `IKESADB` <li> `IPSECSADB` <li> `LAYER` <li> `NETEVENTS` <li> `PROVIDER` <li> `PROVIDERCONTEXT` <li> `SUBLAYER` <br><br> **guid** - For object types that support individual security descriptors, this parameter specifies the object's GUID in `guid=<guid>` format. If omitted, the command uses `IID_NULL` to retrieve the security descriptor for the entire type container. The following object types support per-object security descriptors: <li> `callout` <li> `filter` <li> `layer` <li> `provider` <li> `providercontext` <li> `sublayer` |
| netsh `wfp show state` | Displays the current state of WFP and IPsec. <br><br> **file** - Specifies the output file name in `file=` format. By default, the output is saved as `wfpstate.xml`. If you set this parameter to a dash (`file=-`), the output is displayed directly in the console instead of being saved to a file. |
| netsh `wfp show sysports` | Displays system ports used by the TCP/IP Stack and RPC subsystem. <br><br> **file** - Specifies the output file name in `file=` format. By default, the output is saved as `sysports.xml`. If you set this parameter to a dash (`file=-`), the output is displayed directly in the console instead of being saved to a file. |
| `help` *or* `?` | Displays a list of commands and their descriptions in the current context. |

## Examples

To start a capture session for network events and compress the output files into a single `.cab` archive, run the following command:

```cmd
netsh wfp capture start cab=on
```

To start a capture session that collects only event tracing data and includes both broadcast and multicast events, run the following command:

```cmd
netsh wfp capture start traceonly=on keywords=BCAST+MCAST
```

To enable the collection of network events and capture broadcast events only, run the following command:

```cmd
netsh wfp set options netevents=on keywords=BCAST
```

To set the transaction watchdog timeout to 5,000 milliseconds, run the following command:

```cmd
netsh wfp set options txnwatchdog=5000
```

To display the application path for a specified file, run the following command:

```
netsh wfp show appid file="C:\folder\app.exe"
```

To display whether network event diagnostics are enabled or disabled, run the following command:

```cmd
netsh wfp show options optionsfor=NETEVENTS
```

To display the security descriptor for a specific WFP object type, for example, a filter with a known GUID, run the following command:

```cmd
netsh wfp show security type=FILTER guid=YourGUID
```

## See also

- [Command-Line Syntax Key](command-line-syntax-key.md)
