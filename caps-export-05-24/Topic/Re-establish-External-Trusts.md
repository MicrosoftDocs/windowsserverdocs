---
title: Re-establish External Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 490b3cb2-0a04-4f36-80a3-3b2935d94c96
author: Femila
---
# Re-establish External Trusts
  You can use this procedure to re\-establish external trusts after a domain rename operation. All intraforest shortcut trusts within the forest in which the domain rename occurred are automatically adjusted during the domain rename operation so that they continue to work. However, as a result of the domain name changes in your forest, any external trust relationships that your forest has with other forests \(including trusts across forests\) will not be valid. Therefore, they must be re\-established.  
  
 In particular, when a domain in your forest is renamed, the following trust relationships are not valid:  
  
-   Any interforest trust relationship that is established at the forest root level \(a trust across forests\).  
  
-   Any external trust relationship with a domain in another forest.  
  
 All external trusts from or to the forest in which the domain rename operation occurred must be deleted and recreated. You can use the Active Directory Domains and Trusts Microsoft Management Console \(MMC\) snap\-in to delete and recreate all such trust relationships. For more information, see [Administering Domain and Forest Trusts](../Topic/Administering-Domain-and-Forest-Trusts.md).  
  
  