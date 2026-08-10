---
description: "Learn more about: Planning Forest Root Domain Controller Placement"
title: Planning Forest Root Domain Controller Placement
author: robinharwood
ms.author: roharwoo
ms.date: 05/12/2025
ms.topic: concept-article
---

# Planning Forest Root Domain Controller Placement

Forest root domain controllers are needed to create trust paths for clients that need to access resources in domains other than their own. Place forest root domain controllers in hub locations and at locations that host datacenters. If users in a given location need to access resources from other domains in the same location, and the network availability between the datacenter and the user location is unreliable, you can either add a forest root domain controller in the location or create a shortcut trust between the two domains. It is more cost efficient to create a shortcut trust between the domains unless you have other reasons to place a forest root domain controller in that location.

Shortcut trusts help to optimize authentication requests made from users located in either domain. For more information about shortcut trusts between domains, see the article [Understanding When to Create a Shortcut Trust](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc754538(v=ws.11)).

For a worksheet to assist you in documenting your forest root domain controller placement, see [Job Aids for Windows Server 2003 Deployment Kit](https://microsoft.com/download/details.aspx?id=9608), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open "Domain Controller Placement" (DSSTOPO_4.doc).

You will need to refer to this information when you create the forest root domain. For more information about deploying the forest root domain, see [Deploying a Windows Server 2008 Forest Root Domain](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc731174(v=ws.10)).
