---
title: Configure Performance Monitoring
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 714c49af-e1e6-4aaf-8e7d-e746ec30dfeb
author: billmath
---
# Configure Performance Monitoring
  
## <a name="bkmk_ConfigurePerfMon"></a>  
[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] includes its own dedicated performance counters to help you monitor the performance of both federation servers and federation server proxy computers. To use Performance Monitor to monitor the performance of your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers, it’s useful to create a new data collector set and add the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] counters to that view. The following procedure describes how to configure performance monitoring for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
#### To configure performance monitoring for AD FS using Performance Monitor  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)] **Performance Monitor**, and then press ENTER.  
  
2.  In the console tree, expand **Data Collector Sets**, right\-click **User Defined**, point to **New**, and then click **Data Collector Set**.  
  
    The Create New Data Collector Set Wizard appears.  
  
3.  In **Create New Data Collector Set**, for **Name** type a name for the new data collector set \(such as "[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] performance"\), click **Create manually \(Advanced\)**, and then click **Next**.  
  
4.  For the type of data to include, verify that **Create data logs** is selected, and then click the check boxes for the following data types: **Performance counter**, **Event trace data**, **System configuration information**.  
  
5.  For performance counters, expand **AD FS** in the **Available counters** list, and then click **Add**.  
  
    The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] performance counters should appear in the **Added counters** list.  
  
6.  When you are prompted to add event trace providers, click **Add**, select **AD FS Eventing** and **AD FS Tracing** from the list of providers.  
  
7.  When you are prompted to add registry keys to monitor, click **Next**.  
  
8.  When you are prompted to specify the location to save the performance data, you can accept the default location \(**%systemdrive%\\PerfLogs\\Admin\\***<data\_collector\_set>*, and then click **Next**.  
  
9. When you are prompted to create the data collector set, select **Save and close**, and then click **Finish**.  
  
    The new data collector set appears in the console tree under the **User Defined** node.  
  
10. Use the following steps to work with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] performance counters:  
  
    -   To begin performance monitoring using [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]\-related counters, right\-click the data collector set that you added \(such as "[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] performance"\), and then click **Start**.  
  
    -   To create a report to view the performance monitoring results, right\-click the data collector set that you added \(such as "[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] performance"\), and then click **Latest Report**.  
  
    -   To end a capture of performance data so that you can view the latest report, right\-click the data collector set that you added \(such as "[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] performance"\), and then click **Stop**.  
  
    The latest report is added and numbered automatically \(starting at 000001\) under the **Report\\User Defined***\\<data\_collector\_set>* node in the console tree.  
  
## AD FS performance counters  
The following table lists the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] performance counters and describes how they are useful for monitoring activity that relates to either a federation server or federation server proxy.  
  
|Counter|Description|Can be used on:|  
|-----------|---------------|-------------------|  
|Token Requests|Monitors the number of token requests sent to the federation server including SSOAuth token requests.|Federation Servers|  
|Token Requests\/sec|Monitors the number of token requests sent to the federation server including SSOAuth token requests per second.|Federation Servers|  
|Federation Metadata Requests|Monitors the number of incoming federation metadata requests sent to the federation server.|Federation Servers|  
|Federation Metadata Requests\/sec|Monitors the number of incoming federation metadata requests per second that are sent to the federation server.|Federation Servers|  
|Artifact Resolution Requests|Monitors the number of incoming federation metadata requests per second that are sent to the federation server.|Federation Servers|  
|Artifact Resolution Requests\/sec|Monitors the number of requests to the artifact resolution endpoint per second that are sent to the federation server.|Federation Servers|  
|Proxy Requests|Monitors the number of incoming requests sent to the federation server proxy.|Federation Server Proxies|  
|Proxy Requests\/sec|Monitors the number of incoming requests per second that are sent to the federation server proxy.|Federation Server Proxies|  
|Proxy MEX Requests|Monitors the number of incoming WS\-Metadata Exchange \(MEX\) requests that are sent to the federation server proxy.|Federation Server Proxies|  
|Proxy MEX Requests\/sec|Monitors the number of incoming MEX requests per second that are sent to the federation server proxy.|Federation Server Proxies|  
  
