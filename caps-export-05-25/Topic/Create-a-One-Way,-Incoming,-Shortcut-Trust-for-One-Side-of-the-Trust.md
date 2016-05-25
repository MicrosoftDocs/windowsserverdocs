---
title: Create a One-Way, Incoming, Shortcut Trust for One Side of the Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b3b442d9-dd2b-4bbb-9ea8-45b2cfdf98e9
author: Femila
---
# Create a One-Way, Incoming, Shortcut Trust for One Side of the Trust
  You can use this procedure to create one side of a one\-way, incoming, shortcut trust. Although one side of a trust will be created successfully, the new trust will not function until the administrator for the reciprocal domain uses his or her credentials to create the outgoing side of the trust. If you have administrative credentials for both domains that are involved in the trust, you can use the procedure [Create a One-Way, Incoming, Shortcut Trust for Both Sides of the Trust](../Topic/Create-a-One-Way,-Incoming,-Shortcut-Trust-for-Both-Sides-of-the-Trust.md) to create both sides in one simultaneous operation.  
  
 A one\-way, incoming, shortcut trust allows users in your domain \(the domain that you are logged on to at the time that you run the New Trust Wizard\) to more quickly access resources in another domain \(which is nested within another domain tree\) in your forest. For example, if you are the administrator of sales.wingtiptoys.com and users in that domain need to access resources in the marketing.tailspintoys.com domain \(which is a child domain of the tailspintoys.com tree root domain\), you can use this procedure to establish one side of the relationship so that users in your domain can more quickly access resources in the marketing.tailspintoys.com domain.  
  
 You can create this shortcut trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about using the Netdom command\-line tool to create a shortcut trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a one\-way, incoming, shortcut trust for one side of the trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain node for the domain for which you want to establish a trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name \(or NetBIOS name\) of the domain, and then click **Next**.  
  
5.  On the **Trust Type** page, click **External trust**, and then click **Next**.  
  
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
>  For this trust to function, the domain administrator for the specified domain or specified forest must follow the procedure [Create a One-Way, Outgoing, Shortcut Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Outgoing,-Shortcut-Trust-for-One-Side-of-the-Trust.md), using his or her administrative credentials and the exact same trust password that was used during this procedure.  
  
  