---
title: STEP 3: Configure DC1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 904a6edc-a771-45ed-9630-a34a680bb522
author: vhorne
---
# STEP 3: Configure DC1
DC1 acts as a domain controller, DNS server, and DHCP server for the corp.contoso.com domain. Configure DC1 as follows:  
  
### Verify User1 has a User Principal Name defined on DC1  
  
1.  On DC1, open Server Manager, and click **AD DS** in the left pane. Right\-click **DC1** and select **Active Directory Users and Computers**. In the left pane expand **corp.contoso.com\\Users**, and double\-click User1.  
  
2.  On the **Account** tab verify that **User logon name** is set to User1. If not, then enter **User1** in the **User logon name** field.  
  
3.  Click **OK**. Close the **Active Directory Users and Computers** console.  
  
