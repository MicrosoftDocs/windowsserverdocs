---
title: Verify DNS Registration and TCP - IP Connectivity
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5832c8d4-4a01-4f4a-beba-a0384035c5cb
author: Femila
---
# Verify DNS Registration and TCP - IP Connectivity
  You can use the Dcdiag command\-line tests in this procedure to verify that a server can successfully connect to domain controllers in the same site or in the enterprise and to verify that Domain Name System \(DNS\) is functioning. By default, all Dcdiag tests verify TCP\/IP connectivity for both IP version 4 \(IPv4\) and IP version 6 \(IPv6\).  
  
> [!NOTE]  
>  Dcdiag is installed with Active Directory Domain Services \(AD DS\) by default. To perform this test on a server that is not a domain controller, you must install Dcdiag. For information about installing Dcdiag, see [Installing Remote Server Administration Tools for AD DS](../Topic/Installing-Remote-Server-Administration-Tools-for-AD-DS.md).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify DNS registration and TCP\/IP connectivity  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, and then click **OK**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `dcdiag /test:dns`  
  
    > [!NOTE]  
    >  For a more detailed response from this command, add `/v` to the end of the command.  
  
     If the test fails, do not attempt any additional steps until you determine and fix the problem that prevents proper DNS functionality.  
  
  