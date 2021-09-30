---
title: Unregister an NPS from an Active Directory Domain
description: Learn how to unregister an NPS from an Active Directory Domain so you can move an NPS to another domain, replace an NPS, or retire an NPS.
manager: brianlic
ms.topic: article
ms.assetid: 68a94616-3c29-45bd-bd33-e4c578f119e1
ms.author: jgerend
author: JasonGerend
ms.date: 08/07/2020
---

# Unregister an NPS from an Active Directory Domain

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

In the process of managing your NPS deployment, you might find it useful to move an NPS to another domain, to replace an NPS, or to retire an NPS.

When you move or decommission an NPS, you can unregister the NPS in the Active Directory domains where the NPS has permission to read the properties of user accounts in Active Directory.

Membership in **Administrators**, or equivalent, is the minimum required to perform these procedures.

## To unregister an NPS

1. On the domain controller, in Server Manager, click **Tools**, and then click **Active Directory Users and Computers**. The Active Directory Users and Computers console opens.

2. Click **Users**, and then double-click **RAS and IAS servers**.

3. Click the **Members** tab, and then select the NPS that you want to unregister.

4. Click **Remove**, click **Yes**, and then click **OK**.

