---
title: Create a One-Way, Outgoing, Forest Trust for One Side of the Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b052d1a0-44bc-4fc0-81ec-dbb65ece08b6
author: Femila
---
# Create a One-Way, Outgoing, Forest Trust for One Side of the Trust
  You can use this procedure to create one side of a one\-way, outgoing, forest trust. Although one side of a trust will be created successfully, the new trust will not function until the administrator for the reciprocal forest uses his or her credentials to create the incoming side of the trust. If you have administrative credentials for both forests that are involved in the trust, you can use the procedure [Create a One-Way, Outgoing, Forest Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Outgoing,-Forest-Trust-for-Both-Sides-of-the-Trust.md) to create both sides of the trust in one simultaneous operation.  
  
 A one\-way, outgoing, forest trust allows resources in your [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest or Windows Server 2003 forest \(the forest that you are logged on to at the time that you run the New Trust Wizard\) to be accessed by users in another [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest or Windows Server 2003 forest. For example, if you are the administrator of the wingtiptoys.com forest and resources in that forest need to be accessed by users in the tailspintoys.com forest, you can use this procedure to establish one side of the relationship so that users in the tailspintoys.com forest can access resources in any of the domains that make up the wingtiptoys.com forest.  
  
 You can create this forest trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in.  
  
 Membership in **Domain Admins** in the forest root domain or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)] If you are a member of the **Incoming Forest Trust Builders** group, you can create one\-way, incoming, forest trusts to your forest. For more information about the Incoming Forest Trust Builders group, see How Domain and Forest Trusts Work \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111481](http://go.microsoft.com/fwlink/?LinkID=111481)\).  
  
### To create a one\-way, outgoing, forest trust for one side of the trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain node for the forest root domain for which you want to establish an outgoing forest trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name of the forest root domain of the other forest, and then click **Next**.  
  
5.  On the **Trust Type** page, click **Forest trust**, and then click **Next**.  
  
6.  On the **Direction of Trust** page, click **One\-way: outgoing**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
7.  On the **Sides of Trust** page, click **This domain only**, and then click **Next**.  
  
     For more information about the selections that are available on the **Sides of Trust** page, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **Outgoing Trust Authentication Level** page, do one of the following, and then click **Next**:  
  
    -   Click **Forest\-wide authentication**.  
  
    -   Click **Selective authentication**.  
  
9. On the **Trust Password** page, type the trust password twice, and then click **Next**.  
  
10. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
11. On the **Trust Creation Complete** page, review the results, and then click **Next**.  
  
12. On the **Confirm Outgoing Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the outgoing trust**. Note that if you do not confirm the trust at this stage, the secure channel will not be established until the first time the trust is used by users.  
  
    -   If you want to confirm this trust, click **Yes, confirm the outgoing trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
13. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
> [!NOTE]  
>  For this trust to function, the domain administrator for the specified domain \(the forest root domain in the specified forest\) must follow the procedure [Create a One-Way, Incoming, Forest Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Incoming,-Forest-Trust-for-One-Side-of-the-Trust.md), using his or her administrative credentials and the exact same trust password that was used during this procedure.  
  
  