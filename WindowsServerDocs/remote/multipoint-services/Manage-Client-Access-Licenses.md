---
title: Manage Client Access Licenses
description: Learn how to work with CALs in MultiPoint Services
ms.custom: na
ms.prod: windows-server-threshold
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 675e089e-d841-401e-bba7-69f3929ef609
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Manage Client Access Licenses
Every station that connects to a MultiPoint Services system, including the computer running MultiPoint Services that is used as a station, must have a valid per-user Remote Desktop *client access license (CAL)*.

If you are using station virtual desktops instead of physical stations, you must install a CAL for each station virtual desktop.  
  
1.  Purchase a client license for each station that is connected to your MultiPoint Services computer or server. For more information about purchasing CALs, visit the documentation for Remote Desktop licensing. 

2.  From the **Start** screen, open **MultiPoint Manager**.  
  
3.  Click the **Home** tab, and then click **Add client access licenses**.  This will open the management tool for CAL licensing.

# Set the licensing mode manually
If not properly configured the MultiPoint Services set-up will prompt with a notification about the grace
period being expired. Follow these steps to set the licensing mode:

1. Launch **Local Group Policy Editor** (gpedit.msc).

2. In the left pane, navigate to **Local Computer Policy->Computer Configuration->Administrative Templates->Windows Components->Remote Desktop Services->Remote Desktop Session Host->Licensing**.

3. In the right pane, right click **Use the specified Remote Desktop license servers** and select **Edit**:
   - In the group policy editor dialog, select **Enabled**
   - Enter the local computer name in the **License servers to use** field.
   - Select **OK**
  
4. In the right pane, right click **Set the Remote Desktop licensing mode** and select **Edit**
   - In the group policy editor dialog, select **Enabled**
   - Set the **Licensing mode** to Per Device/Per User
   - Select **OK** 

  
## See Also  
[Manage System Tasks Using MultiPoint Manager](Manage-System-Tasks-Using-MultiPoint-Manager.md)
