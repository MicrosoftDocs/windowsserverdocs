---
title: Create a One-Way, Incoming, Forest Trust for One Side of the Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 434b117b-e14f-4617-aef1-da2941783142
author: Femila
---
# Create a One-Way, Incoming, Forest Trust for One Side of the Trust
  You can use this procedure to create one side of a one\-way, incoming, forest trust. Although one side of a trust will be created successfully, the new trust will not function until the administrator for the reciprocal forest uses his or her credentials to create the outgoing side of the trust. If you have administrative credentials for both forests that are involved in the trust, you can use the procedure [Create a One-Way, Incoming, Forest Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Incoming,-Forest-Trust-for-Both-Sides-of-the-Trust.md) to create both sides of the trust in one simultaneous operation.  
  
 A one\-way, incoming, forest trust allows users in your [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest or Windows Server 2003 forest \(the forest that you are logged on to at the time that you run the New Trust Wizard\) to access resources in another [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest or Windows Server 2003 forest. For example, if you are the administrator of the wingtiptoys.com forest and users in that forest need to access resources in the tailspintoys.com forest, you can use this procedure to establish one side of the relationship so that users in your forest can access resources in any of the domains that make up the tailspintoys.com forest.  
  
 You can create this forest trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in.  
  
 Membership in **Domain Admins** in the forest root domain or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)] If you are a member of the **Incoming Forest Trust Builders** group, you can create one\-way, incoming, forest trusts to your forest. For more information about the Incoming Forest Trust Builders group, see How Domain and Forest Trusts Work \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111481](http://go.microsoft.com/fwlink/?LinkID=111481)\).  
  
### To create a one\-way, incoming, forest trust for one side of the trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain node for the forest root domain of the forest for which you want to establish an incoming forest trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name of the forest root domain of the other forest, and then click **Next**.  
  
5.  On the **Trust Type** page, click **Forest trust**, and then click **Next**.  
  
6.  On the **Direction of Trust** page, click **One\-way: incoming**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
7.  On the **Sides of Trust** page, click **This domain only**, and then click **Next**.  
  
     For more information about the selections that are available on the **Sides of Trust** page, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **Trust Password** page, type the trust password twice, and then click **Next**.  
  
9. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
10. On the **Trust Creation Complete** page, review the results, and then click **Next**.  
  
11. On the **Confirm Incoming Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the incoming trust**.  
  
    -   If you want to confirm this trust, click **Yes, confirm the incoming trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
12. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
> [!NOTE]  
>  For this trust to function, the domain administrator for the specified domain \(the forest root domain in the specified forest\) must complete the procedure [Create a One-Way, Outgoing, Forest Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Outgoing,-Forest-Trust-for-One-Side-of-the-Trust.md), using his or her administrative credentials and the exact same trust password that was used during this procedure.  
  
  