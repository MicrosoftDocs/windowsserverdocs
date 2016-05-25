---
title: Create a One-Way, Outgoing, Realm Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 05a50fd3-78a9-44c7-93fe-81fef3e8df74
author: Femila
---
# Create a One-Way, Outgoing, Realm Trust
  A one\-way, outgoing realm trust allows resources in your [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain or Windows Server 2003 domain \(the domain that you are logged on to at the time that you run the New Trust Wizard\) to be accessed by users in the Kerberos realm. For example, if you are the administrator of the sales.wingtiptoys.com domain and resources in that domain need to be accessed by users in the PRODUCTS.TAILSPINTOYS.com Kerberos realm, you can use this procedure to establish a relationship so that users in the Kerberos realm can access resources in the sales.wingtiptoys.com domain.  
  
> [!NOTE]  
>  Kerberos realm names require uppercase characters.  
  
 You can create this realm trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about using the Netdom command\-line tool to create a realm trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Account Operators**, **Domain Admins**, or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a one\-way, outgoing, realm trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain for which you want to establish a realm trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name of the Kerberos realm in uppercase characters, and then click **Next**.  
  
5.  On the **Trust Type** page, click **Realm trust**, and then click **Next**.  
  
6.  On the **Transitivity of Trust** page, do one of the following:  
  
    -   To form a trust relationship with the domain and the specified realm only, click **Nontransitive**, and then click **Next**.  
  
    -   To form a trust relationship with the domain and the specified realm and all trusted realms, click **Transitive**, and then click **Next**.  
  
7.  On the **Direction of Trust** page, click **One\-way: outgoing**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **Trust Password** page, type the trust password twice, and then click **Next**.  
  
9. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
10. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
> [!NOTE]  
>  For this trust to function, the administrator of the realm must complete the trust, using his or her administrative credentials and the exact same trust password that was used during this procedure.  
  
  