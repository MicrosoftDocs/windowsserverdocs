title: AD Forest Recovery - Steps for Restoring the forest 
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/02/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.assetid: 5a291f65-794e-4fc3-996e-094c5845a383
ms.technology: identity-adfs
---

#AD Forest Recovery - Steps for Restoring the forest 
This section provides an overview of the recommended path for recovering a forest. The forest recovery steps are described in detail later.  
  
 The following list summarizes the recovery steps at a high level:  
  
1.  [Identify the problem](../Topic/Recovering%20Your%20Active%20Directory%20Forest.md#BKMK_Identify)  
  
     Work with IT and Microsoft Support to determine the scope of the problem and potential causes, and evaluate possible remedies with all business stakeholders. In many cases total forest recovery should be the last option.  
  
2.  [Decide how to recover the forest](../Topic/Recovering%20Your%20Active%20Directory%20Forest.md#BKMK_Decide)  
  
     After you determine that forest recovery is necessary, complete preliminary steps to prepare for it: determine the current forest structure, identify the functions that each DC performs, decide which DC to restore for each domain, and ensure that all writeable DCs are taken offline.  
  
3.  [Perform initial recovery](../Topic/Recovering%20Your%20Active%20Directory%20Forest.md#BKMK_Recover)  
  
     In isolation, recover one DC for each domain, clean them, and reconnect the domains. Reset privileged accounts, and rectify problems caused by security breaches in this phase.  
  
4.  [Redeploy remaining DCs](../Topic/Recovering%20Your%20Active%20Directory%20Forest.md#BKMK_Redeploy)  
  
     Redeploy the forest to return it to its state before the failure. This step will need to be adapted to your specific design and requirements. Virtualized domain controller cloning can help expedite this process.  
  
5.  [Cleanup](../Topic/Recovering%20Your%20Active%20Directory%20Forest.md#BKMK_Cleanup)  
  
     After functionality has been restored, reconfigure name resolution as needed, and get LOB applications working.  
  
 The following flowchart shows the recovery process.  
  
 ![](../Image/adds_01f.gif "adds_01f")  
  
 The steps in this guide are designed to minimize the possibility of reintroducing dangerous data into the recovered forest. You might have to modify these steps to account for such factors as:  
  
-   Scalability  
  
-   Remote manageability  
  
-   Speed of recovery  
  
 However, modifications to these forest recovery steps can increase the risk of reintroducing dangerous data. For more information about possible modifications to these forest recovery steps, see [What can I do to speed up recovery?](../Topic/Appendix%20B:%20Frequently%20Asked%20Questions.md#BKMK_Speed)  
  
<a name="BKMK_Identify"></a>   
