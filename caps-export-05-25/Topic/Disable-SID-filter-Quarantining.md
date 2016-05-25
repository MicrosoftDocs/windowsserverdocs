---
title: Disable SID filter Quarantining
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9b619f84-41e8-4b4f-988a-758249fe6433
author: Femila
---
# Disable SID filter Quarantining
  Although it is not recommended, you can use this procedure to disable security identifier \(SID\) filter quarantining for an external trust with the Netdom.exe tool. You should consider disabling SID filter quarantining only in the following situations:  
  
-   You have an equally high level of confidence in the administrators who have physical access to domain controllers in the trusted domain and the administrators with such access in the trusting domain.  
  
-   You have a strict requirement to assign universal groups to resources in the trusting domain, even when those groups were not created in the trusted domain.  
  
-   Users have been migrated to the trusted domain with their SID histories preserved, and you want to grant those users access to resources in the trusting domain \(the former domain of the migrated users\) based on the **sIDHistory** attribute.  
  
 For more information about how SID filtering works, see Security Considerations for Trusts \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111846](http://go.microsoft.com/fwlink/?LinkID=111846)\).  
  
 You can disable SID filter quarantining by using the Netdom command\-line tool. For more information about the Netdom command\-line tool, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To disable SID filter quarantining for the trusting domain  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    Netdom trust <TrustingDomainName> /domain:<TrustedDomainName> /quarantine:No /userD:<DomainAdministratorAcct> /passwordD:<DomainAdminPwd>  
    ```  
  
    > [!NOTE]  
    >  You can enable or disable SID filter quarantining only from the trusting side of the trust. If the trust is a two\-way trust, you can also disable SID filter quarantining in the trusted domain by using the domain administrator’s credentials for the trusted domain and reversing the \<TrustingDomainName\> and \<TrustedDomainName\> values in the command\-line syntax.  
  
### To disable SID filter quarantining for the trusting forest  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    Netdom trust <TrustingDomainName> /domain:<TrustedDomainName> /enablesidhistory:Yes /userD:<DomainAdministratorAcct> /passwordD:<DomainAdminPwd>  
    ```  
  
    > [!NOTE]  
    >  You can enable or disable SID filter quarantining only from the trusting side of the trust. If the trust is a two\-way trust, you can also disable SID filter quarantining in the trusted domain by using the domain administrator’s credentials for the trusted domain and reversing the \<TrustingDomainName\> and \<TrustedDomainName\> values in the command\-line syntax.  
  
## Placeholder reference table  
 The following table describes the placeholder values in the syntax for the `netdom` command.  
  
|Parameter|Description|  
|---------------|-----------------|  
|\<TrustingDomainName\>|The Domain Name System \(DNS\) name \(or NetBIOS name\) of the trusting domain in the trust that is being created.|  
|\<TrustedDomainName\>|The DNS name \(or NetBIOS name\) of the domain that will be trusted in the trust that is being created.|  
|\<DomainAdministratorAcct\>|The user account name with the appropriate administrator credentials to modify the trust.|  
|\<DomainAdminPwd\>|The password of the user account in \<DomainAdministratorAcct\>.|  
  
## See Also  
 [Reapply SID Filter Quarantining](../Topic/Reapply-SID-Filter-Quarantining.md)  
  
  