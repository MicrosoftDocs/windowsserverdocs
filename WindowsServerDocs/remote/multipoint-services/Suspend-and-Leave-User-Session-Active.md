---
title: Suspend and Leave User Session Active
description: Learn how to suspend a user from a MultiPoint session without disconnecting them
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5263bce3-fe92-4398-8393-2e3a4e05d530
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Suspend and Leave User Session Active
You can disconnect or suspend users from the MultiPoint Services system when you do not want to end the users' sessions. A user can also disconnect the session, rather than you disconnecting the session for them. While a user session is suspended, the session remains active in the MultiPoint Services system's computer memory until the computer is shut down or restarted. At that time, all suspended sessions are ended and any unsaved work is lost.  
  
1.  Open MultiPoint Manager in station mode, and then click the **Stations** tab.  
  
2.  In the **Computer** column, click name of the computer whose sessions you want to suspend.  
  
3.  Under **Stations Tasks**, click **Suspend all stations**.  
  
After a user session has been suspended, the user can log on to the same or another station and continue to work in the original session.  
  
## See Also  
[Manage User Desktops](manage-user-desktops-using-multipoint-dashboard.md)  
[Log off or Disconnect User Sessions](Log-off-or-Disconnect-User-Sessions.md)