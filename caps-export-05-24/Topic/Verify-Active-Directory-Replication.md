---
title: Verify Active Directory Replication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: cc2ec227-38bd-41d6-8be2-bb68e5245a57
author: Femila
---
# Verify Active Directory Replication
  You can use this procedure to verify that Active Directory replication is functioning properly on a domain controller.  
  
 Membership in **Domain Admins**, or equivalent, is required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify Active Directory replication  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:replications`  
  
    > [!NOTE]  
    >  For more detailed replication information, use the `/v` option.  
  
     If this test fails, open Event Viewer and check for errors in the Directory Service log. Use the information in the ActiveDirectory\_DomainService replication events to troubleshoot the problem.  
  
  