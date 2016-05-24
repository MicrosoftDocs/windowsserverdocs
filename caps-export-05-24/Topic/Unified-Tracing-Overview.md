---
title: Unified Tracing Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7c2bf126-2d99-4022-8fde-4f45d78d2f18
---
# Unified Tracing Overview
This topic provides an overview of Unified Tracing in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] and [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)].  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Unified Tracing introduced the new parameter **capturetype** for the **netsh trace** command. This parameter extends tracing capabilities and enables network administrators to more efficiently capture network traffic on both physical and virtual networks, making the process of troubleshooting network issues more effective and efficient.  
  
In an environment where there are multiple virtual networks on a single physical computer, Unified Tracing can capture traffic between VMs on the same network, as well as between VMs on different virtual networks.  
  
If you have a server that is running Hyper\-V that has multiple virtual machines \(VMs\) and you want to analyze the network traffic between VMs, you can execute the **netsh trace** command using the **capturetype** parameter on the Hyper\-V host. By starting the capture on the host machine, tracing is enabled on each of the VMs simultaneously, and you’re able to analyze the traffic between the VMs.  
  
The parameter **capturetype** allows you to specify the type of traffic to capture:  
  
-   When you specify the value **physical** for the **capturetype** parameter, you can capture traffic on the physical computer, and specifically, traffic through the physical network adapter.  
  
-   When you specify the value **vmswitch** for the **capturetype** parameter, you can capture traffic that traverses Hyper\-V Virtual Switches.  
  
-   When you specify the value **both** for the **capturetype** parameter, you can capture all traffic on the physical computer and that traverses the Hyper\-V Virtual Switch.  
  
For the purpose of backward compatibility, the default value of the **capturetype** parameter is **physical**.  
  
When the value for the **capturetype** parameter is specified as **vmswitch**, only traffic traversing the switch is captured. If the same traffic traverses the physical network adapter \(for example, the traffic is also sent to a different physical computer\), then it is not captured again at the physical network adapter level.  
  
For details about Netsh Trace in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], see [Netsh Commands for Network Trace](http://technet.microsoft.com/library/jj129397.aspx) in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library.  
  
## <a name="BKMK_LINKS"></a>See also  
Following is a list of related technologies:  
  
-   [Hyper\-V Virtual Switch](http://technet.microsoft.com/library/hh831823.aspx) in the [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] Technical Library.  
  
-   [Using Netsh to Manage Traces](http://msdn.microsoft.com/library/windows/desktop/dd569142(v=vs.85).aspx) in the Microsoft Developer Network \(MSDN\) library  
  
-   [Netsh Commands for Network Trace](http://technet.microsoft.com/library/dd878517(WS.10).aspx) in the [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] Technical Library.  
  
-   [Netsh technical reference](http://technet.microsoft.com/library/cc725935(WS.10).aspx) in the [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] and [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] Technical Library.  
  
