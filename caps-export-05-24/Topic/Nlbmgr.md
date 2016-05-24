---
title: Nlbmgr
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 89cb8590-b7cf-4a27-89fa-0fa62ea1a1ca
author: jaimeo
---
# Nlbmgr
Using Network Load Balancing Manager, you can configure and manage your Network Load Balancing clusters and all cluster hosts from a single computer, and you can also replicate the cluster configuration to other hosts. You can start Network Load Balancing Manager from the command\-line using the command **nlbmgr.exe**, which is installed in the **systemroot\\System32** folder.  
  
## Syntax  
  
```  
nlbmgr [/help] [/noping] [/hostlist <filename>] [/autorefresh <interval>]  
```  
  
### Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|\/help|Displays help at the command prompt.|  
|\/noping|Prevents Network Load Balancing Manager from pinging the hosts prior to trying to contact them through Windows Management Instrumentation \(WMI\). Use this option if you have disabled Internet Control Message Protocol \(ICMP\) on all available network adapters. If Network Load Balancing Manager attempts to contact a host that is not available, you will experience a delay when using this option.|  
|\/hostlist <filename>|Loads the hosts specified in filename into Network Load Balancing Manager.|  
|\/autorefresh <interval>|Causes Network Load Balancing Manager to refresh its host and cluster information every <interval> seconds. If no interval is specified, the information is refreshed every 60 seconds.|  
|\/?|Displays Help at the command prompt.|  
  
## Additional references  
  
-   [Command-Line Syntax Key](../Topic/Command-Line-Syntax-Key.md)  
  
-   [Command-Line Reference_1](../Topic/Command-Line-Reference_1.md)  
  
