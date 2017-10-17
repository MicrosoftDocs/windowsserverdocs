---
title: Unregister an NPS Server from an Active Directory Domain
description: You can use this topic to register a server running Network Policy Server in Windows Server 2016 in the NPS server default domain or in another domain.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 68a94616-3c29-45bd-bd33-e4c578f119e1
ms.author: jamesmci 
author: jamesmci
---

# Unregister an NPS Server from an Active Directory Domain

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

In the process of managing your NPS server deployment, you might find it useful to move an NPS server to another domain, to replace an NPS server, or to retire an NPS server. 

When you move or decommission an NPS server, you can unregister the NPS server in the Active Directory domains where the NPS server has permission to read the properties of user accounts in Active Directory.

Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

## To unregister an NPS server

1. On the domain controller, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers console opens.

2. Click **Users**, and then double-click **RAS and IAS servers**.

3. Click the **Members** tab, and then select the NPS server that you want to unregister.

4. Click **Remove**, click **Yes**, and then click **OK**.

