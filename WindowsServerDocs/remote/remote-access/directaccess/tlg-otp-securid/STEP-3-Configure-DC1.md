---
title: STEP 3 Configure DC1
description: This topic is part of the Test Lab Guide - Demonstrate DirectAccess with OTP Authentication and RSA SecurID for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 836a2a08-3d22-48d2-873e-80d7e57ebbd6
ms.author: pashort
author: shortpatti
---
# STEP 3 Configure DC1

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

DC1 acts as a domain controller, DNS server, and DHCP server for the corp.contoso.com domain. Configure DC1 as follows:  
  
## Verify User1 has a User Principal Name defined on DC1  
  
1.  On DC1, open Server Manager, and click **AD DS** in the left pane. Right-click **DC1** and select **Active Directory Users and Computers**. In the left pane expand **corp.contoso.com\Users**, and double-click User1.  
  
2.  On the **Account** tab verify that **User logon name** is set to User1. If not, then enter **User1** in the **User logon name** field.  
  
3.  Click **OK**. Close the **Active Directory Users and Computers** console.  
  


