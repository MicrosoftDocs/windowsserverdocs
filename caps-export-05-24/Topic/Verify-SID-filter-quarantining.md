---
title: Verify SID filter quarantining
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 4b1f0f06-5983-4acd-85c5-d6f2df6c5002
author: Femila
---
# Verify SID filter quarantining
  You can use this procedure to verify the status of security identifier \(SID\) filter quarantining for an external trust or a forest trust using Netdom.exe.  
  
 For more information about the **netdom** command\-line tool, see [Netdom Overview](http://go.microsoft.com/fwlink/?LinkId=111537) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537\).  
  
 For more information about how SID filtering works, see [Security Considerations for Trusts](http://go.microsoft.com/fwlink/?LinkID=111846) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111846\)  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify SID filter quarantining from the trusting domain  
  
1.  Open a command prompt.  
  
2.  At the command prompt, type the following syntax, and then press ENTER:  
  
     `netdom trust <TrustingDomainName> /domain: <TrustedDomainName> /quarantine /userD: <domainadministratorAcct> /passwordD: <domainadminpwd>`  
  
    > [!NOTE]  
    >  For a description of the placeholder values, see [Placeholder reference table](../Topic/Verify-SID-filter-quarantining.md#bkmk1_placeholder_reference_table).  
  
### To verify SID filter quarantining from the trusting forest  
  
1.  Open a command prompt.  
  
2.  At the command prompt, type the following syntax, and then press ENTER:  
  
     `netdom trust <TrustingDomainName> /domain: <TrustedDomainName> /enablesidhistory /userD: <domainadministratorAcct> /passwordD: <domainadminpwd>`  
  
    > [!NOTE]  
    >  For a description of the placeholder values, see [Placeholder reference table](../Topic/Verify-SID-filter-quarantining.md#bkmk1_placeholder_reference_table).  
  
### To verify SID filter quarantining from the trusted domain  
  
1.  Open a command prompt.  
  
2.  At the command prompt, type the following syntax, and then press ENTER:  
  
     `netdom trust <TrustingDomainName> /userO:<domainadministratorAcct> /passwordO:<domainadminpwd> /domain:<TrustedDomainName> /quarantine`  
  
    > [!NOTE]  
    >  For a description of the placeholder values, see [Placeholder reference table](../Topic/Verify-SID-filter-quarantining.md#bkmk1_placeholder_reference_table).  
  
### To verify SID filter quarantining from the trusted forest  
  
1.  Open a command prompt.  
  
2.  At the command prompt, type the following syntax, and then press ENTER:  
  
     `netdom trust <TrustingDomainName> /userO:<domainadministratorAcct> /passwordO:<domainadminpwd> /domain:<TrustedDomainName> /enablesidhistory`  
  
    > [!NOTE]  
    >  For a description of the placeholder values, see [Placeholder reference table](../Topic/Verify-SID-filter-quarantining.md#bkmk1_placeholder_reference_table).  
  
##  <a name="bkmk1_placeholder_reference_table"></a> Placeholder reference table  
 The following table describes the placeholder values in the syntax for the `netdom` command.  
  
|||  
|-|-|  
|**Value**|**Description**|  
|\<TrustingDomainName\>|The Domain Name System \(DNS\) name \(or NetBIOS name\) of the trusting domain in the trust that is being created.|  
|\<TrustedDomainName\>|The DNS name \(or NetBIOS name\) of the domain that will be trusted in the trust that is being created.|  
|\<domainadministratorAcct\>|The user account name with the appropriate administrator credentials to modify the trust.|  
|\<domainadminpwd\>|The password of the user account in *domainadministratorAcct*.|  
  
  