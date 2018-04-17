---
title: Verify that the Standard VPN works
description: 'In this step, configure the template VPN profile on a domain-joined client computer. The type of user account you use (that is, standard user or administrator) for this part of the process does not matter.'
ms.prod: windows-server-threshold
ms.technology: networking
ms.assetid: 51a1ee61-3ffe-4f65-b8de-ff21903e1e74
ms.topic: article
ms.date: 03/19/2018
ms.author: pashort
author: shortpatti
manager: alanth
ms.reviewer: jairoc
---

# STEP 5: Verify that the Standard VPN works
In this step, configure the template VPN profile on a domain-joined client computer. The type of user account you use (that is, standard user or administrator) for this part of the process does not matter.

1.  Sign in to a domain-joined client computer as a member of the **VPN Users** group.

2.  On the Start menu, type **VPN**, and press Enter.

3.  In the details pane, click **Add a VPN connection**.

4.  In the VPN Provider list, click **Windows (built-in)**.

5.  In Connection Name, enter the name of the VPN profile.

6.  In Server name or address, enter the **external** FQDN of your VPN server \(for example, **vpn.contoso.com**\).

7. In VPN type, select **Automatic**.

8. In Type of sign-in info, select **User name and password**.

9. In User name (optional), enter the user name.

10. In Password, enter the user's password.

11. Click **Save**.

12. In the Setting window, click the VPN connection you just added and click **Connect**.