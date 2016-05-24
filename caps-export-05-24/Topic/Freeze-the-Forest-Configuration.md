---
title: Freeze the Forest Configuration
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3fc967e7-298a-4f08-8775-a316651db2f1
author: Femila
---
# Freeze the Forest Configuration
  You can use this procedure to freeze the forest configuration for a domain rename operation. When your domain rename plan is in place and all preliminary procedures are complete, you must ensure that the configuration of your forest will not change until after the domain rename operation is complete. Therefore, before you begin the domain rename operation you must discontinue the following activities in your forest:  
  
-   Creating new domains in, or removing existing domains from, your forest  
  
-   Creating new application directory partitions in, or removing existing application directory partitions from, your forest  
  
-   Adding domain controllers to, or removing domain controllers from, your forest  
  
-   Creating or deleting shortcut trusts within your forest  
  
-   Adding attributes to, or removing attributes from, the set of attributes that replicate to the global catalog \(the partial attribute set\).  
  
 You can resume these activities after you successfully complete the domain rename operation. For more information see, [Unfreeze the Forest Configuration](../Topic/Unfreeze-the-Forest-Configuration.md).  
  
  