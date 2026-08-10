---
title: nlbmgr
description: Reference article for the nlbmgr command, which helps you to configure and manage your Network Load Balancing clusters and all cluster hosts from a single computer, using the Network Load Balancing Manager.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 10/16/2017
---

# nlbmgr



Configure and manage your Network Load Balancing clusters and all cluster hosts from a single computer, using the Network Load Balancing Manager. You can also use this command to replicate the cluster configuration to other hosts.

You can start the Network Load Balancing Manager from the command-line using the command **nlbmgr.exe**, which is installed in the **systemroot\System32** folder.

## Syntax

```
nlbmgr [/noping][/hostlist <filename>][/autorefresh <interval>][/help | /?]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /noping | Prevents the Network Load Balancing Manager from pinging the hosts prior to trying to contact them through Windows Management Instrumentation (WMI). Use this option if you have disabled Internet Control Message Protocol (ICMP) on all available network adapters. If the Network Load Balancing Manager attempts to contact a host that isn't available, you'll experience a delay when using this option. |
| /hostlist `<filename>` | Loads the hosts specified in filename into the Network Load Balancing Manager. |
| /autorefresh `<interval>` | Causes the Network Load Balancing Manager to refresh its host and cluster information every `<interval>` seconds. If no interval is specified, the information is refreshed every 60 seconds. |
| /? | Displays help at the command prompt. |
| /help | Displays help at the command prompt. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [NetworkLoadBalancingClusters cmdlets reference](/powershell/module/networkloadbalancingclusters)
