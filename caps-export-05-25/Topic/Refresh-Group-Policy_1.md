---
title: Refresh Group Policy_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2bd9726a-6e7e-4506-80f2-5ed82a2ff198
author: vhorne
---
# Refresh Group Policy_1
You can use this procedure to manually refresh Group Policy on the local computer. When Group Policy is refreshed, if certificate autoenrollment is configured and functioning correctly, the local computer is autoenrolled a certificate by the certification authority \(CA\).  
  
> [!NOTE]  
> Group Policy is automatically refreshed when you restart the domain member computer, or when a user logs on to a domain member computer. In addition, Group Policy is periodically refreshed. By default, this periodic refresh is performed every 90 minutes with a randomized offset of up to 30 minutes.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.  
  
### To refresh Group Policy on the local computer  
  
1.  Open [!INCLUDE[wps_1](../Token/wps_1_md.md)].  
  
2.  Type the following command, and then press ENTER: `gpupdate /force`  
  
