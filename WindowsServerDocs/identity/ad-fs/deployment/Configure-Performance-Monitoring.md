---
ms.assetid: 67d8a8d7-2fbd-4ed7-bb41-75769f942024
title: Configure Performance Monitoring
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Configure Performance Monitoring
  
## <a name="bkmk_ConfigurePerfMon"></a>  
AD FS includes its own dedicated performance counters to help you monitor the performance of both federation servers and federation server proxy computers. To use Performance Monitor to monitor the performance of your AD FS servers, it’s useful to create a new data collector set and add the AD FS counters to that view. The following procedure describes how to configure performance monitoring for AD FS.  
  
#### To configure performance monitoring for AD FS using Performance Monitor  
  
1. On the **Start** screen, type **Performance Monitor**, and then press ENTER.  
  
2. In the console tree, expand **Data Collector Sets**, right\-click **User Defined**, point to **New**, and then click **Data Collector Set**.  
  
   The Create New Data Collector Set Wizard appears.  
  
3. In **Create New Data Collector Set**, for **Name** type a name for the new data collector set \(such as "AD FS performance"\), click **Create manually \(Advanced\)**, and then click **Next**.  
  
4. For the type of data to include, verify that **Create data logs** is selected, and then click the check boxes for the following data types: **Performance counter**, **Event trace data**, **System configuration information**.  
  
5. For performance counters, expand **AD FS** in the **Available counters** list, and then click **Add**.  
  
   The AD FS performance counters should appear in the **Added counters** list.  
  
6. When you are prompted to add event trace providers, click **Add**, select **AD FS Eventing** and **AD FS Tracing** from the list of providers.  
  
7. When you are prompted to add registry keys to monitor, click **Next**.  
  
8. When you are prompted to specify the location to save the performance data, you can accept the default location \(**%systemdrive%\\PerfLogs\\Admin\\***<data\_collector\_set>*, and then click **Next**.  
  
9. When you are prompted to create the data collector set, select **Save and close**, and then click **Finish**.  
  
    The new data collector set appears in the console tree under the **User Defined** node.  
  
10. Use the following steps to work with the AD FS performance counters:  
  
    -   To begin performance monitoring using AD FS\-related counters, right\-click the data collector set that you added \(such as "AD FS performance"\), and then click **Start**.  
  
    -   To create a report to view the performance monitoring results, right\-click the data collector set that you added \(such as "AD FS performance"\), and then click **Latest Report**.  
  
    -   To end a capture of performance data so that you can view the latest report, right\-click the data collector set that you added \(such as "AD FS performance"\), and then click **Stop**.  
  
    The latest report is added and numbered automatically \(starting at 000001\) under the **Report\\User Defined**<em>\\<data\_collector\_set></em> node in the console tree.  
  
## AD FS performance counters  
The following table lists the AD FS performance counters and describes how they are useful for monitoring activity that relates to either a federation server or federation server proxy.  
  
|Counter|Description|Can be used on: 
|-----------|---------------|------------------- 
|Token Requests|Monitors the number of token requests sent to the federation server including SSOAuth token requests.|Federation Servers 
|Token Requests\/sec|Monitors the number of token requests sent to the federation server including SSOAuth token requests per second.|Federation Servers  
|Federation Metadata Requests|Monitors the number of incoming federation metadata requests sent to the federation server.|Federation Servers  
|Federation Metadata Requests\/sec|Monitors the number of incoming federation metadata requests per second that are sent to the federation server.|Federation Servers  
|Artifact Resolution Requests|Monitors the number of incoming federation metadata requests per second that are sent to the federation server.|Federation Servers  
|Artifact Resolution Requests\/sec|Monitors the number of requests to the artifact resolution endpoint per second that are sent to the federation server.|Federation Servers  
|Proxy Requests|Monitors the number of incoming requests sent to the federation server proxy.|Federation Server Proxies  
|Proxy Requests\/sec|Monitors the number of incoming requests per second that are sent to the federation server proxy.|Federation Server Proxies  
|Proxy MEX Requests|Monitors the number of incoming WS\-Metadata Exchange \(MEX\) requests that are sent to the federation server proxy.|Federation Server Proxies 
|Proxy MEX Requests\/sec|Monitors the number of incoming MEX requests per second that are sent to the federation server proxy.|Federation Server Proxies  
  

