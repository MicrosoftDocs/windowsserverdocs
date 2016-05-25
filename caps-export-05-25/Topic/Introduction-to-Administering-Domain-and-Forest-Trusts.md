---
title: Introduction to Administering Domain and Forest Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4630e4d7-e3f2-429a-b3aa-5eddf965d12f
author: Femila
---
# Introduction to Administering Domain and Forest Trusts
  By using [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain and forest trusts, service administrators can create or extend collaborative relationships between two or more domains or forests. [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domains and forests can also trust Kerberos realms and other [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forests, as well as Windows Server 2003 domains, Microsoft® Windows® 2000 Server domains, and Microsoft Windows NT® Server 4.0 domains.  
  
 When a trust exists between two domains, the authentication mechanisms for each domain trust the authentications coming from the other domain. Trusts help to provide controlled access to shared resources in a resource domain \(the trusting domain\) by verifying that incoming authentication requests come from a trusted authority \(the trusted domain\). In this way, trusts act as bridges that allow only validated authentication requests to travel between domains.  
  
 How a specific trust passes authentication requests depends on how it is configured. Trust relationships can be one\-way, providing access from the trusted domain to resources in the trusting domain, or two\-way, providing access from each domain to resources in the other domain. Trusts are also either nontransitive, in which case a trust exists only between the two trust partner domains, or transitive, in which case a trust automatically extends to any other domains that either of the partners trusts.  
  
 In some cases, trust relationships are established automatically when domains are created. In other cases, administrators must choose a type of trust and explicitly establish the appropriate relationships. The specific types of trusts that are used and the structure of the resulting trust relationships in a given trust implementation depend on such factors as how Active Directory Domain Services \(AD DS\) is organized and whether different versions of Windows coexist on the network.  
  
  