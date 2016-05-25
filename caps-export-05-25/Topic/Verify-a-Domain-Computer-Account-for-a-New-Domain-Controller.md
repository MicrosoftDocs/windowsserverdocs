---
title: Verify a Domain Computer Account for a New Domain Controller
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c0b1253e-cf76-4f3a-bdbf-595846b3f880
author: Femila
---
# Verify a Domain Computer Account for a New Domain Controller
  You can use this procedure to verify that a domain computer account is registered properly and that the Service Principal Names \(SPNs\) are advertised. This account is required for the domain controller to function as a domain controller in the domain.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify a domain computer account for a new domain controller  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:MachineAccount`  
  
3.  It the test is successful, you should see the following message:  
  
     `<ComputerName> passed test MachineAccount`.  
  
     To receive more detailed information, including the SPNs that are found for the domain controller, use the `/v` option.  
  
  