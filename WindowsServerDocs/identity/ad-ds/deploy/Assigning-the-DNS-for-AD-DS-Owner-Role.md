---
ms.assetid: 4163cf03-3bff-426c-9844-4cc2d7897d52
title: DNS for AD DS Owner Role
description: Information about the DNS for AD DS Owner role.
author: robinharwood
ms.author: roharwoo
ms.date: 05/12/2025
ms.topic: concept-article
---

# DNS for AD DS Owner Role

The DNS for AD DS owner of the forest is a person (or group of people) who is responsible for overseeing the deployment of the DNS for AD DS infrastructure and for making sure that (if necessary) domain names are registered with the proper Internet authorities. The forest owner assigns a Domain Name System (DNS) for Active Directory Domain Services (AD DS) owner for the forest.

The DNS for AD DS owner is responsible for the DNS for AD DS design for the forest. If your organization is currently operating a DNS Server service, the DNS designer for the existing DNS Server service works with the DNS for AD DS owner to delegate the forest root DNS name to DNS servers running on domain controllers.

The DNS for AD DS owner for the forest also maintains contact with the Dynamic Host Configuration Protocol (DHCP) group and the DNS group of the organization and coordinates the plans of the individual DNS owners of each domain in the forest (if any) with these groups. The DNS owner for the forest ensures that the DHCP and DNS groups are involved in the DNS for AD DS design process so that each group is aware of the DNS design plan and can provide input early.
