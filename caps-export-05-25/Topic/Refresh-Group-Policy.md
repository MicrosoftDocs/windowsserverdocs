---
title: Refresh Group Policy
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 65b36794-bb09-4c1b-a2e7-8fc780893d97
author: vhorne
---
# Refresh Group Policy
You can use this procedure to manually refresh Group Policy on the local computer. When Group Policy is refreshed, if certificate autoenrollment is configured and functioning correctly, the local computer is autoenrolled a certificate by the certification authority \(CA\).  
  
> [!NOTE]  
> Group Policy is automatically refreshed when you restart the domain member computer, or when a user logs on to a domain member computer. In addition, Group Policy is periodically refreshed. By default, this periodic refresh is performed every 90 minutes with a randomized offset of up to 30 minutes.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure.  
  
### To refresh Group Policy on the local computer  
  
1.  On the computer where NPS is installed, open [!INCLUDE[wps_1](../Token/wps_1_md.md)] by using the icon on the taskbar.  
  
2.  At the [!INCLUDE[wps_2](../Token/wps_2_md.md)] prompt, type **gpupdate**, and then press ENTER.  
  
