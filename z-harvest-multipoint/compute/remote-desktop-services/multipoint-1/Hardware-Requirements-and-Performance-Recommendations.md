---
title: Hardware Requirements and Performance Recommendations
ms.custom: na
ms.date: 07/22/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99a5c9c2-270f-4753-a28c-434882c03125
author: lizap
manager: jwhit
---
# Hardware Requirements and Performance Recommendations
This topic describes the hardware that is required to install a [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] operating system and support user application scenarios. The user scenario directly affects the CPU, RAM, and network bandwidth requirements.  
  
> [!NOTE]  
> A MultiPoint Server system that has a Windows 7, Windows 8, Windows Server 2012 or Windows Server 2012 R2 logo is supported as long as it meets the requirements outlined on this page and [Selecting Hardware for Your MultiPoint Server System](../../../compute/remote-desktop-services/multipoint-1/Selecting-Hardware-for-Your-MultiPoint-Server-System.md).  
  
## <a name="BKMK_OptimizeMultiPointServerSystemPerformance"></a>Optimize MultiPoint Server system performance  
The performance of your [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] system will be directly affected by the capability of the CPU, the GPU, and the amount of RAM that is available on the computer that is running [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)].  
  
### <a name="BKMK_TypeandNumberofInstancesofApplicationsandInternetContent"></a>Applications and Internet content  
Because [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] is a shared resource computing solution, the type and number of applications that are running on the stations can impact the performance of your [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] system. It is important to consider the types of programs that are used regularly when you are planning your system. For example, a graphics\-intensive application requires a more powerful computer than an application such as a word processor. Overloading the computer with graphics\-intensive applications will likely cause lag problems throughout the entire system.  
  
The type of content that is accessed by applications also affects the system’s performance. If multiple stations are using web browsers to access multimedia content, such as full\-motion video, fewer stations can be connected before adversely affecting the system performance. Conversely, if the multiple stations are using web browsers to access static web content, more stations can be connected without a significant effect on performance.  
  
### Hardware recommendations  
To achieve good performance with your [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] system under various loads, use the guidelines in the following table when you are planning and testing your system. These are the basic requirements for [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)]. The actual configuration sizing depends on your system configuration, the workload you are running, and the hardware capability. You should always validate by testing your applications and hardware.  
  
> [!NOTE]  
> 2C \= 2 cores, 4C \= 4 cores, 6C \= 6 cores, MT \= multithreading. Processor speed should be at least 2.0 gigahertz \(GHz\).  
  
### Minimum recommended hardware for running default MultiPoint Server stations  
  
|Application Scenario|Up to 4 Stations|5\-6 Stations|7\-10 Stations|11\-14 Stations|15\-20 Stations|  
|------------------------|--------------------|-----------------|------------------|-------------------|-------------------|  
|**Productivity**<br /><br />Office, web browsing, line\-of\-business applications|CPU: 2C<br /><br />RAM: 2 GB|CPU: 2C<br /><br />RAM: 4 GB|CPU: 4C<br /><br />RAM: 6 GB|CPU: 4C<br /><br />RAM: 8 GB|CPU: 4C\+MT or 6C<br /><br />RAM: 8 GB|  
|**Mixed**<br /><br />Office, web browsing, line\-of\-business applications,  and occasional video use by some users|CPU: 2C<br /><br />RAM: 2 GB|CPU: 2C<br /><br />RAM: 4 GB|CPU: 4C<br /><br />RAM: 6 GB|CPU: 4C\+MT or 6C<br /><br />RAM: 8 GB|CPU: 4C\+MT or 6C<br /><br />RAM: 8 GB|  
|**Video intensive**<br /><br />Office, web browsing, line\-of\-business applications,  and frequent video use by all users **Note:** Video testing was performed using 360p H.264 video at native resolution.|CPU: 2C<br /><br />RAM: 2 GB|CPU: 4C<br /><br />RAM: 4 GB|CPU: 4C\+MT or 6C<br /><br />RAM: 6 GB|CPU: 4C\+MT or 6C<br /><br />RAM: 8 GB|CPU: 4C\+MT or 6C<br /><br />RAM: 8 GB<br /><br />-   Thin Client: RemoteFX<br />-   USB video not recommended|  
  
> [!NOTE]  
> RemoteFX, or equivalent technology for RDP, is required when 15–20 remotely connected thin clients are running full motion video within their session. For more information about the hardware requirements for RemoteFX, see [Hardware Considerations for RemoteFX](http://go.microsoft.com/fwlink/?LinkId=211310).  
  
In addition to the minimum recommended hardware guidelines, there are also maximum hardware allowances that you should consider.  
  
### Maximum allowed hardware requirements  
  
||MultiPoint Server 2012 Standard|MultiPoint Server 2012 Premium|  
|-|-----------------------------------|----------------------------------|  
|Maximum x64 sockets|1|2|  
|Maximum RAM|32 GB|Unlimited|  
  
For hard drives, a minimum of 7200 RPM and SATA 3Gb\/s is recommended. For systems with a higher number of stations, a higher speed interface, e.g. SATA 6 Gb\/s is recommended. For disk\-intensive applications, you should use disks with faster rotational speeds, such as SAS 10K or 15K RPM, or use multiple disk RAID configurations that improve performance \(for example, RAID 5\).  
  
## Minimum recommended hardware for running full Windows 7 or Windows 8 virtual desktops  
Running a full virtual operating system instance for each station is more compute resource\-intensive than running the default WMS desktop sessions, so the host hardware requirements per station are higher:  
  
1.  CPU: 1 core or thread per station  
  
2.  Solid State Drive \(SSD\)  
  
    1.  Capacity >\= 20GB per station \+ 40GB for the WMS host operating system  
  
    2.  Random Read\/Write IOPS >\= 3K per station  
  
3.  RAM >\= 2GB per station \+ 2GB for the WMS host operating system  
  
BIOS CPU setting has been configured to enable virtualization – Second Level Address Translation \(SLAT\)  
  
For more information about choosing the best [!INCLUDE[win8_server_multipoint_3](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_3_md.md)] hardware for your needs, contact your hardware vendor.  
  
