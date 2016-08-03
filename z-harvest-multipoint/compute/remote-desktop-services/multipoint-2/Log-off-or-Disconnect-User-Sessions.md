---
title: Log off or Disconnect User Sessions
ms.custom: na
ms.date: 07/15/2016
ms.prod: multipoint-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3e9bbcdc-e33b-481e-8b46-787a4f6d58bc
manager: jeffgilb
translation.priority.ht: 
  - cs-cz
  - de-de
  - es-es
  - fr-fr
  - hu-hu
  - it-it
  - ja-jp
  - ko-kr
  - nl-nl
  - pl-pl
  - pt-br
  - pt-pt
  - ru-ru
  - sv-se
  - tr-tr
  - zh-cn
  - zh-tw
---
# Log off or Disconnect User Sessions
MultiPoint Services users can *log on* and *log off* of their desktop *sessions* as they would with any Windows session. Users can also *disconnect* or suspend their session so that the MultiPoint Services *station* is not being used, but their session remains active in the MultiPoint Services system’s computer memory.  
  
In addition, administrative users can *end* a user’s session if the user has stepped away from their MultiPoint Services session or has forgotten to log off of the system.  
  
## Logging off or disconnecting a session  
The following table describes the different options that you or any user can use to log off, suspend, or end a session.  
  
|||  
|-|-|  
|**Action**|**Effect**|  
|Click **Start**, click Settings, click the user name \(top\-right corner\), and then click **Sign out**.|The session ends and the station is available for log on by any user.|  
|Click **Start**, click **Settings**, click Power, and then click **Disconnect**.|Your session is disconnected and your session is preserved in computer memory. The station becomes available for log on by the same user or a different user.|  
|Click **Start**, click Settings, click the user name \(top\-right corner\), and then click **Lock**|The station is locked and your session is preserved in computer memory.|  
  
## Suspending or ending a user’s session  
The following table describes the different options that you, as an administrative user, can use to disconnect or end a user’s session.  
  
|||  
|-|-|  
|**Action**|**Effect**|  
|**Suspend:** In [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)], use the **Stations** tab to suspend the user’s session. For more information, see the [Suspend and Leave User Session Active](../../../compute/remote-desktop-services/multipoint-2/Suspend-and-Leave-User-Session-Active.md) topic.|The user’s session ends and is preserved in computer memory. The station becomes available for log on by the same user or a different user. The user can log on to the same station or another station and continue with their work.|  
|**End:** In [!INCLUDE[win8_server_multipoint_manager](../../../compute/remote-desktop-services/multipoint-1/includes/win8_server_multipoint_manager_md.md)], use the **Stations** tab to end the user’s session. You can also end all user sessions on the **Stations** tab. For more information, see the [End a User Session](../../../compute/remote-desktop-services/multipoint-2/End-a-User-Session.md) topic.|The user’s session ends and the station becomes available for log on by any user. The user’s session no longer displays on the **Stations** tab, and it is not in computer memory.|  
  
## See Also  
[Suspend and Leave User Session Active](../../../compute/remote-desktop-services/multipoint-2/Suspend-and-Leave-User-Session-Active.md)  
[End a User Session](../../../compute/remote-desktop-services/multipoint-2/End-a-User-Session.md)  
[Manage User Desktops](assetId:///248034b7-8cfa-4a2d-af59-13e9e0b5cb1b)  
[Log Off User Sessions](../../../compute/remote-desktop-services/multipoint-2/Log-Off-User-Sessions.md)  
[Glossary](../../../compute/remote-desktop-services/multipoint-1/Glossary.md)  
  
