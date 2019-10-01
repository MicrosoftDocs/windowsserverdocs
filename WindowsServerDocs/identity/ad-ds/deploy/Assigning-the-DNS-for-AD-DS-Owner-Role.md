---
ms.assetid: 4163cf03-3bff-426c-9844-4cc2d7897d52
title: Assigning the DNS for AD DS Owner Role
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Assigning the DNS for AD DS Owner Role

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The forest owner assigns a Domain Name System (DNS) for Active Directory Domain Services (AD DS) owner for the forest. The DNS for AD DS owner of the forest is a person (or group of people) who is responsible for overseeing the deployment of the DNS for AD DS infrastructure and for making sure that (if necessary) domain names are registered with the proper Internet authorities.  
  
The DNS for AD DS owner is responsible for the DNS for AD DS design for the forest. If your organization is currently operating a DNS Server service, the DNS designer for the existing DNS Server service works with the DNS for AD DS owner to delegate the forest root DNS name to DNS servers running on domain controllers.  
  
The DNS for AD DS owner for the forest also maintains contact with the Dynamic Host Configuration Protocol (DHCP) group and the DNS group of the organization and coordinates the plans of the individual DNS owners of each domain in the forest (if any) with these groups. The DNS owner for the forest ensures that the DHCP and DNS groups are involved in the DNS for AD DS design process so that each group is aware of the DNS design plan and can provide input early.  
  


