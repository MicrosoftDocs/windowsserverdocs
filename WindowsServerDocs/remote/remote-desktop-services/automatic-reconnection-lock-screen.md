---
title: Automatic Reconnection in RDS Lock Screen Security
description: The article discusses Microsoft Remote Desktop Services and its Automatic Reconnection feature and emphasizes that the lock screen of the Remote Desktop session is not a security boundary as reconnection does not require re-authentication.
author: tyadon
ms.author: riyadon
ms.reviewer: spatnaik
ms.topic: article
ms.date: 06/06/2023
---
# Automatic Reconnection in RDS: Lock Screen Security
Microsoft Remote Desktop Services (RDS) offers a wide range of features designed to enhance your remote working experience. One such feature is Automatic Reconnection. 

Automatic Reconnection allows the client to seamlessly reconnect to their existing sessions, giving a smooth, uninterrupted user experience in case of temporary network disruptions. This behavior and protocol can be understood by visiting: [Automatic Reconnection | Microsoft Learn](https://learn.microsoft.com/openspecs/windows_protocols/ms-rdpbcgr/e729948a-3f4e-4568-9aef-d355e30b5389)

When using Automatic Reconnection, it is crucial to note that the lock screen of the Remote Desktop session is not designed to function as a security boundary. When a policy or the user locks the remote session and the network connection is lost or disrupted, the Remote Desktop Services retains the session state and connection information, and the client will reconnect without needing to re-authenticate. If the automatic reconnection of locked sessions raises concerns for your specific use case, we recommend implementing additional security measures. This could include disabling automatic reconnection on either the RDS Host or the Client:

**Client option to disable Automatic Reconnection:**
- Organizations can configure the following Remote Desktop Protocol (RDP) property centrally in RDS to disable automatic reconnection. More information can be found here: [Supported RDP properties with Remote Desktop Services | Microsoft Learn](https://learn.microsoft.com/windows-server/remote/remote-desktop-services/clients/rdp-files#session-behavior).
  1. **RDP Property**: `autoreconnection enabled:i:value` 

**Host option(s) to disable Automatic Reconnection:**
- In the **session properties for a specific Collection**, Administrators have the ability to disable the reconnection feature. It's important to note that this feature is enabled by default, and therefore, requires explicit action from the administrators to disable it.
- **Group Policy**:

  1.  Open the **Group Policy Edito**r. This can be accessed by typing `gpedit.msc` in the **Start** menu or the **Run** dialog box.
    
  2.  Navigate through the following path:
    
      1.   Local Computer Policy
      2.   Computer Configuration
      3.   Administrative Templates
      4.   Windows Components
      5.   Remote Desktop Services
      6.   Remote Desktop Session Host
      7.   Connections
  3.  In the '**Connections**' section, you will find an option named '**Automatic reconnection**'.
    
  4.  Select this **Automatic reconnection** option.
    
  5.  In the new dialog box that appears, select the **Disabled** option.
    
  6.  Click on '**Apply**' and then '**OK**' to save the changes.

