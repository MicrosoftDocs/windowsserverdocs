---
title: STEP 3 Configure DC1
description: Learn how to verify that User1 has a User Principal Name defined on DC1.
manager: brianlic
ms.topic: article
ms.assetid: 836a2a08-3d22-48d2-873e-80d7e57ebbd6
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---
# STEP 3 Configure DC1

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

DC1 acts as a domain controller, DNS server, and DHCP server for the corp.contoso.com domain. Configure DC1 as follows:

## Verify User1 has a User Principal Name defined on DC1

1.  On DC1, open Server Manager, and click **AD DS** in the left pane. Right-click **DC1** and select **Active Directory Users and Computers**. In the left pane expand **corp.contoso.com\Users**, and double-click User1.

2.  On the **Account** tab verify that **User logon name** is set to User1. If not, then enter **User1** in the **User logon name** field.

3.  Click **OK**. Close the **Active Directory Users and Computers** console.



