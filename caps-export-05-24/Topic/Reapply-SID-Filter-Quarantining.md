---
title: Reapply SID Filter Quarantining
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6c26c15d-9073-4230-8ec1-a6e945567f78
author: Femila
---
# Reapply SID Filter Quarantining
  You can use this procedure to reapply security identifier \(SID\) filter quarantining to an external trust that has had SID filter quarantining disabled. Also, use this procedure to apply SID filter quarantining to any external trust that has been created using Windows 2000 administrative tools\/domain controllers. By default, SID filter quarantining is enabled automatically on all external trusts that are created using Windows Server 2003 or later domain controllers. For more information about how SID filter quarantining works, see Security Considerations for Trusts \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111846](http://go.microsoft.com/fwlink/?LinkID=111846)\).  
  
 You can reapply SID filter quarantining by using the Netdom command\-line tool. For more information about the Netdom command\-line tool, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** in the trusting domain or **Enterprise Admins** in the forest of the trusting domain Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To reapply SID filter quarantining for the trusting domain  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `Netdom trust <TrustingDomainName> /domain:<TrustedDomainName> /quarantine:Yes /userD:<DomainAdministratorAcct> /passwordD:<DomainAdminPwd>`  
  
    > [!NOTE]  
    >  For a description of the placeholder values, see [Placeholder reference table](../Topic/Reapply-SID-Filter-Quarantining.md#bkmk1_placeholder_ref_table)  
  
### To reapply SID filter quarantining for the trusting forest  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `Netdom trust <TrustingDomainName> /domain:<TrustedDomainName> enablesidhistory/:Yes /userD:<DomainAdministratorAcct> /passwordD:<DomainAdminPwd>`  
  
    > [!NOTE]  
    >  For a description of the placeholder values, see [Placeholder reference table](../Topic/Reapply-SID-Filter-Quarantining.md#bkmk1_placeholder_ref_table).  
  
##  <a name="bkmk1_placeholder_ref_table"></a> Placeholder reference table  
 The following table describes the placeholder values in the syntax for the `netdom` command.  
  
|||  
|-|-|  
|**Value**|**Description**|  
|\<TrustingDomainName\>|The Domain Name System \(DNS\) name \(or NetBIOS name\) of the trusting domain in the trust that is being created.|  
|\<TrustedDomainName\>|The DNS name \(or NetBIOS name\) of the domain that will be trusted in the trust that is being created.|  
|\<domainadministratorAcct\>|The user account name with the appropriate administrator credentials to modify the trust.|  
|\<domainadminpwd\>|The password of the user account in *domainadministratorAcct*.|  
  
  