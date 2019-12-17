---
title: Edit Server Settings
description: Learn about MultiPoint Services settings
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: afb64b94-9055-4703-b8ce-a8839b2718da
author: lizap
manager: dongill
ms.author: elizapo
---
# Edit Server Settings
When you installed MultiPoint Services, you configured settings for your system, including opting in to certain programs. This topic describes the settings you can set for your MultiPoint Services system, and explains how to edit the settings.  
  
## About MultiPoint Services settings  
The following table describes the different settings that you can change for your MultiPoint Services system.  
  
|MultiPoint Services setting|Description|  
|-----------------------------------------------------------------------------------------|---------------|  
|Allow one account to have multiple sessions|Allows a single user account to be simultaneously logged on to multiple stations. This can be useful in cases such as a classroom where every student is using a shared, single account. Using this setting, any changes to the account resources, such as document folders or the desktop, are available to all users who are logged on using the same account.|  
|Allow this computer to be managed remotely|Allows the computer that is running MultiPoint Services to be managed by other MultiPoint systems on your network. If this option is selected, and the managing computer is on the same subnet, this computer appears in the list of available servers to be managed. If this option is selected, and the managing computer is on a different subnet, the managing computer can still manage this computer, but you must specify the IP address of the computer.|
|Allow monitoring of this computer's desktops|Allows you to control whether desktops can be monitored on the MultiPoint Services system. If this setting is off (not selected), desktops of stations (both local and remote) that are connected to the computer that is running MultiPoint Services will not display in the Home tab of MultiPoint Manager (including on a different computer if the computer is being remotely managed).|  
|Always start in console mode|Enables the RemoteFX technology, which is designed to allow faster and more efficient Remote Desktop sessions by offloading processing to the CPU and GPU. If you are connecting to MultiPoint Services using a RemoteFX-capable client, you may be able to achieve better performance using this option. The benefits depend on the capabilities of your server and network. For example, this depends in part on whether the time spent doing additional processing to compress the data stream is less than the time that is saved by transmitting less data.|  
|Do not show privacy notification at first user logon|When a user logs on to a MultiPoint station for the first time, a notification displays to advise the user that their station activities may be monitored.|  
|Assign a unique IP to each station|Assigns a unique IP address to each station. By default, MultiPoint Services has one IP address, which is shared with all sessions that are running on the system. This configuration, however, can cause some application compatibility problems. For example, if an application requires a unique IP address, it may not run properly on MultiPoint Services. Selecting this option, also known as IP virtualization, can resolve this problem.<br /><br />IP virtualization is also useful for monitoring active sessions on MultiPoint Services. Some monitoring tools report usage according to the IP address. To enable session monitoring, you can use IP virtualization to assign a unique IP address to each session. Note that if you select this option, each new session receives a unique IP address. Any existing sessions continue to use the shared IP address until they are logged off and logged back on.|  
|Allow IM between MultiPoint Dashboard and a user session on this computer|Enables chat between MultiPoint Manager and user session on this computer. For more information see [Use IM](Use-IM.md).|  
|Allow orchestration of administrator and MultiPoint Dashboard user sessions|When enabled, allows administrators to use the MultiPoint Dashboard for session orchestration. These sessions display as thumbnails.|  
|Allow stations to use GPU hardware rendering|Controls whether stations can use the system's graphics processing unit (GPU).|   
  
## Editing the computer settings  
  
1.  Open MultiPoint Manager in [station mode](Switch-Between-Modes.md), and then click the **Home** tab.  
  
2.  In the **Computer** column, click the computer name, and then, under the *computer name* **Tasks**, click **Edit computer settings**.  
  
3.  Select or clear the items you want to change, and then click **OK**.  
  
## See Also  
[Manage System Tasks Using MultiPoint Manager](Manage-System-Tasks-Using-MultiPoint-Manager.md)  
  
