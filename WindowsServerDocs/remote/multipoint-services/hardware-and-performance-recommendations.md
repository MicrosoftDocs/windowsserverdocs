---
title: Hardware Requirements and Performance Recommendations
description: Provides hardware and performance requirements and recommendations for MultiPoint Services
ms.custom: na
ms.date: 07/22/2016
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 99a5c9c2-270f-4753-a28c-434882c03125
author: evaseydl
manager: scottman
ms.author: evas
---
# Hardware Requirements and Performance Recommendations
This topic describes the hardware that is required to run a MultiPoint Services system and support user application scenarios. The user scenario directly affects the CPU, RAM, and network bandwidth requirements.  

## Optimize MultiPoint Services system performance  
The performance of your MultiPoint Services system will be directly affected by the capability of the CPU, the GPU, and the amount of RAM that is available on the computer that is running MultiPoint Services.  
  
### Applications and Internet content  
Because MultiPoint Services is a shared resource computing solution, the type and number of applications that are running on the stations can impact the performance of your MultiPoint Services system. It is important to consider the types of programs that are used regularly when you are planning your system. For example, a graphics-intensive application requires a more powerful computer than an application such as a word processor. Overloading the computer with graphics-intensive applications will likely cause lag problems throughout the entire system.  
  
The type of content that is accessed by applications also affects the system's performance. If multiple stations are using web browsers to access multimedia content, such as full-motion video, fewer stations can be connected before adversely affecting the system performance. Conversely, if the multiple stations are using web browsers to access static web content, more stations can be connected without a significant effect on performance.  
  
### Hardware recommendations  
To achieve good performance with your MultiPoint Services system under various loads, use the guidelines in the following table when you are planning and testing your system. These are the basic requirements forMultiPoint Services . The actual configuration sizing depends on your system configuration, the workload you are running, and the hardware capability. You should always validate by testing your applications and hardware.  
  
> [!NOTE]  
> 2C = 2 cores, 4C = 4 cores, 6C = 6 cores, MT = multithreading. Processor speed should be at least 2.0 gigahertz (GHz).  
  
### Minimum recommended hardware for running default MultiPoint Server stations  
  
|Application Scenario|Up to 5 Stations|6-8 Stations|9-12 Stations|13-16 Stations|17-20 Stations|21-24 Stations|  
|------------------------|----------------------|-------------------|------------------|-------------------|-------------------|-----------------|  
|**Productivity**<br /><br />Office, web browsing, line-of-business applications|CPU: 2C<br /><br />RAM: 2 GB|CPU: 2C<br /><br />RAM: 4 GB|CPU: 4C<br /><br />RAM: 6 GB|CPU: 4C<br /><br />RAM: 8 GB|CPU: 4C+MT or 6C<br /><br />RAM: 10 GB| CPU: 6C+MT<br /><br />RAM: 12 GB|
|**Mixed**<br /><br />Office, web browsing, line-of-business applications,  and occasional video use by some users|CPU: 2C<br /><br />RAM: 2 GB|CPU: 2C<br /><br />RAM: 4 GB|CPU: 4C<br /><br />RAM: 6 GB|CPU: 4C+MT or 6C<br /><br />RAM: 8 GB|CPU: 6C+MT<br /><br />RAM: 10 GB| CPU: 6C+MT<br /><br />RAM: 12 GB| 
|**Video intensive**<br /><br />Office, web browsing, line-of-business applications,  and frequent video use by all users **Note:** Video testing was performed using 360p H.264 video at native resolution.|CPU: 4C+MT<br /><br />RAM: 2 GB|CPU: 6C+MT<br /><br />RAM: 4 GB|CPU: 8C+MT<br /><br />RAM: 6 GB|CPU: 12C+MT<br /><br />RAM: 8 GB|CPU: 16C+MT<br /><br />RAM: 10 GB<br /><br />-   Thin Client: RemoteFX<br />-   USB video not recommended| CPU: 20C+MT<br /><br />RAM: 12 GB<br /><br />-   Thin Client: RemoteFX<br />-   USB video not recommended|   
  
## Minimum recommended hardware for running full Windows 10 virtual desktops  
Running a full virtual operating system instance for each station is more compute resource-intensive than running the default MultiPoint desktop sessions, so the host hardware requirements per station are higher:  
  
1.  CPU: 1 core or thread per station  
  
2.  Solid State Drive (SSD)  
  
    1.  Capacity >= 20GB per station + 40GB for the WMS host operating system  
  
    2.  Random Read/Write IOPS >= 3K per station  
  
3.  RAM >= 2GB per station + 2GB for the WMS host operating system  
  
BIOS CPU setting has been configured to enable virtualization – Second Level Address Translation (SLAT)  
  
For more information about choosing the best MultiPoint Services hardware for your needs, contact your hardware vendor.  