---
title: Manage User Stations
description: Learn how to manage user stations in MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b418578d-3a4c-49b0-90db-8389b320b2f6
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Manage User Stations
This section discusses managing the *stations* that make up the MultiPoint Services system. Managing a MultiPoint Services system includes both managing the hardware and software components of MultiPoint Manager. In a MultiPoint Services system, a desktop is the software user interface presented on the monitor for each user station.  
  
## Station status  
You can view the following types of status for each desktop on the **Stations** tab. Status includes:  
  
-   Users who are logged on  
  
-   User sessions that are suspended, but are still active on the computer  
  
-   Which stations are being used and by which user  
  
For more information about viewing desktop status, see the [View User Connection Status](View-User-Connection-Status.md) topic.  

>[!TIP] 
> You can assign friendly names to each station, which might help you identify the stations more easily. Use **Identify station**, which dipslays the station name on the assigned screen.
  
## Different ways to log standard users off of the MultiPoint Services system  
As an *administrative user*, you can log off Windows at any time, which will have no effect on active users in your MultiPoint Services system. *Standard users* can *disconnect* their session or *log off* the MultiPoint Services system too. In the care where disk protection is enabled, if a user is leaving for the day, they should make sure to save their work on the computer or an external storage device so that when the MultiPoint Services system is shut down, the user can still retrieve their saved work another day.  
  
As an administrative user, you might need to end a standard user's *session*, rather than having the user log off. You can end a standard user's session in one of two ways:  
  
-   End the session and log the user off. For more information about ending a user's session, see the [End a User Session](End-a-User-Session.md) topic.  
  
-   Suspend the user to temporarily end the user's session, but keep the session active in the MultiPoint Services system's computer memory. The suspended user can then reconnect to the session from the same station or a different station and continue his or her work. For more information about suspending a user's session, see the [Suspend and Leave User Session Active](Suspend-and-Leave-User-Session-Active.md) topic.  
  
## Set a station to automatically log on  
As an administrative user, you can set up one or more stations to automatically log on when the computer that is running MultiPoint Services starts. For more information about automatically logging on, see the [Set Up a Station for Automatic Logon](Set-up-a-Station-for-Automatic-Logon.md) topic.  
  
## Split a station  
Any station monitor that has a resolution greater than 1024x768 can be split into two stations. For more information about splitting a station, see the [Split a User Station](Split-a-User-Station.md) topic.  
  
## See Also  
[View User Connection Status](View-User-Connection-Status.md)  
[Log off or Disconnect User Sessions](Log-off-or-Disconnect-User-Sessions.md)  
[Suspend and Leave User Session Active](Suspend-and-Leave-User-Session-Active.md)  
[Set Up a Station for Automatic Logon](Set-up-a-Station-for-Automatic-Logon.md)  
[End a User Session](End-a-User-Session.md)  
[Split a User Station](Split-a-User-Station.md)