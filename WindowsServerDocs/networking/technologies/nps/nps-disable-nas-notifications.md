---
title: Disable NAS Notification Forwarding in NPS
description: This topic provides instructions on configuring Network Policy Server concurrent authentications in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: a09bfb03-95fc-4534-bf3c-97078ef6b07e
ms.author: lizross 
author: eross-msft
---

# Disable NAS Notification Forwarding in NPS

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to disable the forwarding of start and stop messages from network access servers (NASs) to members of a remote RADIUS server group configured in NPS.

When you have remote RADIUS server groups configured and, in NPS **Connection Request Policies**, you clear the **Forward accounting requests to this remote RADIUS server group** check box, these groups are still sent NAS start and stop notification messages. 

This creates unnecessary network traffic. To eliminate this traffic, disable NAS notification forwarding for individual servers in each remote RADIUS server group.

To complete this procedure, you must be a member of the **Administrators** group.

### To disable NAS notification forwarding

1. In Server Manager, click **Tools**, and then click **Network Policy Server**. The NPS console opens.

2. In the NPS console, double-click **RADIUS Clients and Servers**, click **Remote RADIUS Server Groups**, and then double-click the remote RADIUS server group that you want to configure. The remote RADIUS server group **Properties** dialog box opens.

3. Double-click the group member that you want to configure, and then click the **Authentication/Accounting** tab.

4. In **Accounting**, clear the **Forward network access server start and stop notifications to this server** check box, and then click **OK**.

5. Repeat steps 3 and 4 for all group members that you want to configure.

For more information about managing NPS, see [Manage Network Policy Server](nps-manage-top.md).

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
