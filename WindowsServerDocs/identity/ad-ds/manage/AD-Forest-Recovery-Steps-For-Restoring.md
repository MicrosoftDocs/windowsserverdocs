---
title: AD Forest Recovery - Steps for Restoring the forest 
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
# AD Forest Recovery - Steps for Restoring the forest

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

This section provides an overview of the recommended path for recovering a forest. The forest recovery steps are described in detail later.  
  
The following list summarizes the recovery steps at a high level:  
  
1. [Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)  

   Work with IT and Microsoft Support to determine the scope of the problem and potential causes, and evaluate possible remedies with all business stakeholders. In many cases total forest recovery should be the last option.  
  
2. [Decide how to recover the forest](AD-Forest-Recovery-Determine-how-to-Recover.md)  

   After you determine that forest recovery is necessary, complete preliminary steps to prepare for it: determine the current forest structure, identify the functions that each DC performs, decide which DC to restore for each domain, and ensure that all writeable DCs are taken offline.  

3. [Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  

   In isolation, recover one DC for each domain, clean them, and reconnect the domains. Reset privileged accounts, and rectify problems caused by security breaches in this phase.  
  
4. [Redeploy remaining DCs](AD-Forest-Recovery-Restore-Additional-DCs.md)  

   Redeploy the forest to return it to its state before the failure. This step will need to be adapted to your specific design and requirements. Virtualized domain controller cloning can help expedite this process.  

5. [Cleanup](AD-Forest-Recovery-Cleanup.md)  

   After functionality has been restored, reconfigure name resolution as needed, and get LOB applications working.  

The steps in this guide are designed to minimize the possibility of reintroducing dangerous data into the recovered forest. You might have to modify these steps to account for such factors as:  
  
- Scalability  
- Remote manageability  
- Speed of recovery  
