---
title: Unregister an NPS from an Active Directory Domain
description: You can use this topic to register a server running Network Policy Server in Windows Server 2016 in the NPS default domain or in another domain.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 68a94616-3c29-45bd-bd33-e4c578f119e1
ms.author: lizross 
author: eross-msft
---

# Unregister an NPS from an Active Directory Domain

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In the process of managing your NPS deployment, you might find it useful to move an NPS to another domain, to replace an NPS, or to retire an NPS. 

When you move or decommission an NPS, you can unregister the NPS in the Active Directory domains where the NPS has permission to read the properties of user accounts in Active Directory.

Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

## To unregister an NPS

1. On the domain controller, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers console opens.

2. Click **Users**, and then double-click **RAS and IAS servers**.

3. Click the **Members** tab, and then select the NPS that you want to unregister.

4. Click **Remove**, click **Yes**, and then click **OK**.

