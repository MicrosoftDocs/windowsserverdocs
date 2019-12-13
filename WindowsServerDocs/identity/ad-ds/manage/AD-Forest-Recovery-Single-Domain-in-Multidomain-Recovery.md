---
title: AD Forest Recovery - Recovering a single domain in a multidomain forest
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 267541be-2ea7-4af6-ab34-8b5a3fedee2d
ms.technology: identity-adds
---
# AD Forest Recovery - Recovering a single domain in a multidomain forest

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

There can be times when it is necessary to recover only a single domain within a forest that has multiple domains, rather than a full forest recovery. This topic covers considerations for recovering a single domain and possible strategies for recovery.  
  
A single domain recovery presents a unique challenge for rebuilding global catalog (GC) servers. For example, if the first domain controller (DC) for the domain is restored from a backup that was created one week earlier, then all other GCs in the forest will have more up-to-date data for that domain than the restored DC. To re-establish GC data consistency, there are a couple options:  
  
- Unhost and then rehost the recovered domains partition from all GCs in the forest, except those in the recovered domain, at the same time.  
- Follow the forest recovery process to recover the domain, and then remove lingering objects from GCs in other domains.  
  
The following sections provide general considerations for each option. The complete set of steps that need to be done for the recovery will vary for different Active Directory environments.  
  
## Rehost all GCs  

> [!WARNING]
> The password of the Domain Administrator account for all domains must be ready for use in case a problem prevents access to a GC for logon.  

Rehosting all GCs can be done using repadmin /unhost and repadmin /rehost commands (part of repadmin /experthelp). You would run the repadmin commands on every GC in each domain that is not recovered. It needs to be ensured, that all GCs do not hold a copy of the recovered domain anymore. To achieve this, unhost the domain partition first from all domain controllers across all none-recovered domains of the forest first. After all GCs do not contain the partition anymore, you can rehost it. When rehosting, consider the site- and replication-structure of your forest, for example, finish the rehost of one DC per site prior to rehosting the other DCs of that site.  
  
This option can be advantageous for a small organization that has only a few domain controllers for each domain. All of the GCs could be rebuilt on a Friday night and, if necessary, complete replication for all read-only domain partitions before Monday morning. But if you need to recover a large domain that covers sites across the globe, rehosting the read-only domain partition on all GCs for other domains can significantly impact operations and potentially require down time.  
  
## Remove lingering objects

Similar to the forest recovery process, you restore one DC from backup in the domain that you need to recover, perform metadata cleanup of remaining DCs, and then re-install AD DS to build out the domain. On the GCs of all other domains in the forest, you remove the lingering objects for the read-only partition of the recovered domain.  

The source for the lingering object cleanup must be a DC in the recovered domain. To be certain that the source DC does not have any lingering objects for any domain partitions, you can remove the global catalog if it was a GC.  

Removing lingering objects is advantageous for larger organizations that cannot risk the down time associated with the other options.  

For more information, see [Use Repadmin to remove lingering objects](https://technet.microsoft.com/library/cc785298.aspx).

## Next Steps

- [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)  
- [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)  
- [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)
- [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)
- [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
- [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)  
- [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)  
- [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md)  
