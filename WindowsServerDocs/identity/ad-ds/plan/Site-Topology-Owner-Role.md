---
description: "Learn more about: Site Topology Owner Role"
title: Site Topology Owner Role
author: robinharwood
ms.author: roharwoo
ms.date: 05/12/2025
ms.topic: concept-article
---

# Site Topology Owner Role

The administrator who manages the site topology is known as the site topology owner. The site topology owner understands the conditions of the network between sites and has the authority to change settings in Active Directory Domain Services (AD DS) to implement changes to the site topology. Changes to the site topology affect changes in the replication topology. The site topology owner's responsibilities include:

-   Controlling changes to the site topology if network connectivity changes.

-   Obtaining and maintaining information about network connections and routers from the network group. The site topology owner must maintain a list of subnet addresses, subnet masks, and the location to which each belongs. The site topology owner must also understand any issues about network speed and capacity that affect site topology to effectively set costs for site links.

-   Moving Active Directory server objects representing domain controllers between sites if a domain controller's IP address changes to a different subnet in a different site, or if the subnet itself is assigned to a different site. In either case, the site topology owner must manually move the Active Directory server object of the domain controller to the new site.



