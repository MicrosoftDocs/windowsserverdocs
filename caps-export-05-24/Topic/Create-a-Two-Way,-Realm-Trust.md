---
title: Create a Two-Way, Realm Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: a7bac3fa-3703-4de2-a8b6-4c442dd869d0
author: Femila
---
# Create a Two-Way, Realm Trust
  A two\-way, realm trust allows users in your [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain or Windows Server 2003 domain \(the domain that you are logged on to at the time that you run the New Trust Wizard\) and users in a specified Kerberos realm to access resources in either the domain or the Kerberos realm. For example, if users in the sales.wingtiptoys.com domain need access to resources in the PRODUCTS.TAILSPINTOYS.com Kerberos realm, and the realm users also need access to resources in the domain, you can use this procedure to establish a two\-way trust relationship that allows users in both the realm and the domain to have access to resources in both places.  
  
> [!NOTE]  
>  Kerberos realm names require uppercase characters.  
  
 You can create this realm trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about how to use the Netdom command\-line tool to create a realm trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a two\-way, realm trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain node for the domain for which you want to establish a realm trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name of the Kerberos realm, and then click **Next**.  
  
5.  On the **Trust Type** page, click **Realm trust**, and then click **Next**.  
  
6.  On the **Transitivity of Trust** page, do one of the following:  
  
    -   To form a trust relationship with the domain and the specified realm only, click **Nontransitive**, and then click **Next**.  
  
    -   To form a trust relationship with the domain and the specified realm and all trusted realms, click **Transitive**, and then click **Next**.  
  
7.  On the **Direction of Trust** page, click **Two\-way**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **Trust Password** page, type the trust password twice, and then click **Next**.  
  
9. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
10. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
> [!NOTE]  
>  For this trust to function, the administrator of the Kerberos realm must complete the trust, using his or her administrative credentials and the exact same trust password that was used during this procedure.  
  
  