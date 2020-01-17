---
title: AD Forest Recovery - Identify the Problem
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 5a291f65-794e-4fc3-996e-094c5845a383
ms.technology: identity-adds
---
# Identify the problem

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2
  
When symptoms of a forest-wide failure appear, such as in event logs or other monitoring solutions, work with Microsoft Support to determine the cause of the failure, and evaluate any possible remedies.  

## Examples of forest-wide failures

- All DCs have been logically corrupted or physically damaged to a point that business continuity is impossible; for example, all business applications that depend on AD DS are nonfunctional.  
- A rogue administrator has compromised the Active Directory environment.  
- An attacker intentionally—or an administrator accidentally—runs a script that spreads data corruption across the forest.  
- An attacker intentionally—or an administrator accidentally—extends the Active Directory schema with malicious or conflicting changes.  
- An attacker has managed to install malicious software on DCs, and you have been advised by Microsoft Support to recover the forest from backup.  
  
   > [!IMPORTANT]
   >  This paper does not cover security recommendations about how to recover a forest that has been hacked or compromised. In general, it is recommended to follow Pass-the-Hash mitigation techniques to harden the environment. For more information, see [Mitigating Pass-the-Hash (PtH) Attacks and Other Credential Theft Techniques](https://www.microsoft.com/download/details.aspx?id=36036).
  
- None of the DCs can replicate with their replication partners.  
- Changes cannot be made to AD DS at any domain controller.  
- New DCs cannot be installed in any domain.  
  
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
