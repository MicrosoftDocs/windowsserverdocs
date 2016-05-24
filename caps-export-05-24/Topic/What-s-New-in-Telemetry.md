---
title: What&#39;s New in Telemetry
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 94f4446b-b464-4d85-b8c1-19ebeabad2c6
---
# What&#39;s New in Telemetry
You can help Microsoft improve the quality, reliability, and performance of its operating systems by participating in the Microsoft Customer Experience Improvement Program \(CEIP\) and Windows Error Reporting \(WER\). Your participation allows Microsoft Corporation to collect statistical information about your system configuration, the performance of some features of Windows, and certain types of events.  
  
By participating in CEIP, Microsoft learns how you use Windows Server and then improves the product based on your feedback. The CEIP report collection and transfer process is lightweight to allow CEIP participants to get the most out of their servers, especially when it comes to server performance and network bandwidth. Windows Server records CEIP usage information using a high\-speed tracing component called Event Tracing for Windows \(ETW\). ETW enables Windows Server to record CEIP usage data with no noticeable impact to server performance. CEIP usage information is then transferred to Microsoft in a two part process using the Consolidator and Uploader scheduled tasks. The Consolidator scheduled task exports CEIP data into a compressed binary format that is ready for transfer. The binary data typically has a size of less than 1 megabyte \(MB\) so that the transfer has minimal impact to network bandwidth. The Uploader scheduled task runs once every twenty\-four hours and transfers the CEIP binary data to the Microsoft frontend servers using the [Windows Telemetry Protocol](http://msdn.microsoft.com/library/hh537806(v=prot.10).aspx).  
  
The CEIP data collected by Microsoft consists of basic information about how servers are configured and used, the roles and features that are installed, and information about hardware. CEIP does not intentionally collect Personally Identifiable Information \(PII\), so CEIP reports do not contain personal contact information, such as names, addresses, or phone numbers. CEIP does not ask you to participate in surveys or to read email, and you will not be contacted in any way. The [Microsoft Customer Experience Improvement Program privacy statement](http://www.microsoft.com/products/ceip/privacypolicy.mspx) discusses, in detail, the data collected by CEIP and how we use it.  
  
The following list outlines some of the ways CEIP data is used to improve products.  
  
-   **Increased server reliability**. In pre\-release versions of [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Reliability Analysis Component \(RAC\) features are enabled to determine the root order cause of why a Windows server or application crashes or stops working. RAC combines CEIP data with Windows Error Reporting \(WER\) data to reconstruct a full view of the system state at the time of the crash or hang. By analyzing the combined CEIP and WER data, high occurrence issues can be identified and then triaged and fixed so that a product is improved with each release. To learn more about the data collected by WER, see the [Microsoft Error Reporting Privacy Statement](http://oca.microsoft.com/en/dcp20.asp).  
  
-   **Improved programmability for server administration scripts**. For large\-scale deployments, system administration is often performed using Windows PowerShell and WMI scripts because scripting simplifies manageability. When a Windows PowerShell cmdlet or WMI interface changes or is removed, rewriting scripts can be cumbersome when you need to accommodate the platform changes. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], CEIP addresses this issue by monitoring deprecated API usage and ensuring that APIs are not removed until they have minimal impact to you. For example, in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the Win32\_ServerFeature WMI interface, which detects installed roles and features, is considered deprecated and is replaced with MSFT\_ServerManagerDeploymentTasks. As part of the deprecation process, CEIP data can now record interface usage and, based on the latest [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Beta CEIP data, it was found that 47% of customers are still using Win32\_ServerFeature. Using this data from the usage of Win32\_ServerFeature, Microsoft can make sure that Win32\_ServerFeature is not formally removed from the product until migration to MSFT\_ServerManagerDeploymentTasks is complete.  
  
-   **Diversity of Windows\-Certified hardware**. One of the frequently asked questions Microsoft gets is *What CEIP data does Microsoft share with partners*? There are certain scenarios where a subset of CEIP data, except for Personally Identifiable Information \(PII\), is shared with independent hardware or software vendors as part of the hardware certification process. It is important that Windows server supports high\-quality drivers for the diverse set of devices that are available. CEIP data is used to model hardware profiles and map the diversity of different devices to notify the independent hardware or software vendors of the requirements for certification. With this data, independent hardware or software vendors determine the range of drivers to certify \(based on what is available\) and prioritize which devices get certified first \(based on popularity\).  
  
-   **Improved product experience**. CEIP data is used on a day\-by\-day basis to understand a broad range of feature configurations, so that Microsoft can prioritize work according to how you use the product. For example, to reduce the cost of installing and configuring new servers, CEIP records what settings you use. This allows Microsoft to refine default settings by adjusting them to reflect most common usage patterns, which allows you to more quickly install and configure a new server.  
  
## <a name="versions"></a>What’s new in Telemetry in Windows Server 2012  
The following table lists functionality in Telemetry that is new for this release or has been changed.  
  
|Feature\/functionality|New or updated|  
|--------------------------|------------------|  
|Windows Feedback Forwarder|New|  
|Windows Automatic Feedback|New|  
|Telemetry module for Windows PowerShell|New|  
  
### Windows Feedback Forwarder  
Windows Feedback Forwarder is a forwarding service that enables you to automatically and securely send feedback to Microsoft after setting up a Group Policy domain or organizational unit. After configuring Group Policy and joining the Customer Experience Improvement Program \(CEIP\), Windows periodically collects and uploads statistical information.  
  
**What value does this change add?**  
  
Using the Windows Feedback Forwarder feature, up to 15,000 computers in one or more domain or organizational units can be automatically opted in to the Microsoft Customer Experience Improvement Program \(CEIP\) through Group Policy settings.  
  
### Windows Automatic Feedback  
Windows Automatic Feedback allows you to enable both CEIP and WER on multiple computers simultaneously using Server Manager.  
  
**What value does this change add?**  
  
Using Windows Automatic Feedback, you can quickly configure multiple computers to use CEIP and WER.  
  
## See also  
  
-   [Telemetry Overview](../Topic/Telemetry-Overview.md)  
  
-   [Deploy Windows Feedback Forwarder](assetId:///2ecf6e63-62d5-4121-9f9e-ba9e27ee6a6f)  
  
