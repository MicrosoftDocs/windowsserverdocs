---
title: Set Automatic Updates Options for Client-Side Troubleshooting
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1c04efba-4793-41f4-9e4c-dd5e8a82b059
author: britw
---
# Set Automatic Updates Options for Client-Side Troubleshooting
You can use the **wuauclt** utility to change the default Automatic Updates functionality. The following Automatic Update options can help you test and troubleshoot issues with client computers.  
  
For more information about the **wuauclt** utility, see [Manage WSUS 3.0 SP2 from the Command Line](../Topic/Manage-WSUS-3.0-SP2-from-the-Command-Line.md).  
  
|Option|Description|  
|----------|---------------|  
|Detectnow|Immediately starts the update detection process.|  
|Reportnow|Asynchronously sends all queued reporting events to the WSUS server.|  
|Resetauthorization|When you enable client\-side targeting, WSUS stores information in cookies on the client computers. This information includes computer group membership. By default, this cookie expires one hour after WSUS creates it. If you use client\-side targeting and change the group membership of a client computer, you can use the *resetauthorization* option in combination with the *detectnow* option to immediately expire the cookie, start detection, and update the computer group membership.|  
  
You can implement these options by using the following procedure:  
  
## <a name="procoption"></a>To enable an Automatic Updates option  
  
1.  Log on to the client computer by using an account that is a member of the local Administrators group.  
  
2.  [!INCLUDE[cmd_admin](../Token/cmd_admin_md.md)]  
  
3.  In the Command Prompt window, type the following command:  
  
    **wuauclt\/** *option*  
  
    where *option* is one of the following options:  
  
    -   *detectnow*  
  
    -   *reportnow*  
  
    -   *resetauthorization \/detectnow*  
  
        > [!NOTE]  
        > You must issue the *resetauthorization \/detectnow* options in the order that is presented here.  
  
