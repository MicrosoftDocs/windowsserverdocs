---
title: Determine Capacity Requirements
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6b585cdf-943c-408a-a70e-0216d9e3a9fd
author: britw
---
# Determine Capacity Requirements
The following table shows performance data for the maximum number of supported client computers for a single server implementation. The table includes test specifications and results that were achieved in a Microsoft test lab. You can use this data as a guideline to develop your own test scenarios and to make your hardware and software decisions.  
  
Be aware that your organization’s performance results can vary if you use different hardware; however, the maximum supported capacity figures do not change. That is, if you use a higher performance server than indicated in the table, there might be an increase in the number of client computer synchronizations per second. However, there is no corresponding increase in the maximum number of supported client computers for the configuration.  
  
###  
  
|Configuration|Maximum Supported<br /><br />Capacity|Hardware and<br /><br />Software|Client<br /><br />Synchronizations<br /><br />and Updates|  
|-----------------|---------------------------------|----------------------------|---------------------------------------------|  
|Single server, non\-NLB|100,000 client computers|Hardware: Intel Core 2 Quad CPU Q6600, 2.40 GHz, 4 GB RAM<br /><br />Software: Windows Server 2003  Standard x64 Edition with Service Pack 2 \(SP2\)<br /><br />Windows Server 2008 Standard x64 Edition<br /><br />Windows Server 2008 R2 Standard x64 Edition|Delta sync at 7 hour frequency<br /><br />Avg. requests per client: 10<br /><br />Transaction rate: 6 clients per second|  
  
**Performance notes**:  
  
-   Transaction rate is defined as the time that is required to service a single client computer. This rate includes multiple requests.  
  
-   Performance testing was done by using delta synchronization requests. An initial request to the server \(that is, a full synchronization\) will generate a server CPU spike as the server builds up its internal caches.  
  
-   If WSUS client computers synchronize with the server more frequently than is shown here, there will be a corresponding increment in the server load. For example, if client computers synchronize every four hours in an NLB configuration, the load is two times as much as in an eight hour synchronization frequency.  
  
    The Group Policy setting that specifies the time that the Windows operating system uses to wait before it checks for available updates automatically staggers the requests to the server. The exact wait time is determined by using the hours specified minus zero to 20 percent of the hours specified. For example, if the policy specifies a 20 hour detection frequency, all client computers to which this policy is applied will check for updates between 16 and 20 hours. Requests are processed on a first\-in, first\-out basis. If the number of concurrent sync requests exceeds capacity, requests are held in the IIS queue until they can be processed.  
  
-   If you increase the number of update languages, you will also increase the server load. Updating in five languages instead of one language approximately doubles the size of the content directory.  
  
> [!NOTE]  
> Installing WSUS update, KB2720211 \(released in June 2012\), resets the "MaximumAllowedComputers" value to the default : 30,000.  If prior to installing KB2720211, you changed the value of MaximumAllowedComputers, it is recommended that you verify that the MaximumAllowedComputers value is set to the correct level.  
>   
> See Community Additions below concerning “Supporting more than 30,000 clients may require modification of MaximumAllowedComputers” for additional details.  
  
### To verify the MaximumAllowedComputers value  
  
1.  In **Start**, right\-click **Windows PowerShell**, and then click **Run as administrator**. The Administrator: Windows PowerShell session opens.  
  
2.  Run the following Windows PowerShell command:  
  
$config \= \(Get\-WsusServer\).GetConfiguration\(\)  
  
$config.MaximumAllowedComputers  
  
### To change the MaximumAllowedComputers value  
  
1.  In **Start**, right\-click **Windows PowerShell**, and then click **Run as administrator**. The Administrator: Windows PowerShell session opens.  
  
2.  Run the following Windows PowerShell command:  
  
$config \= \(Get\-WsusServer\).GetConfiguration\(\)  
  
$config.MaximumAllowedComputers \= 100000, where 100000 represents the value you want to specify.  
  
$config.Save\(\)  
  
