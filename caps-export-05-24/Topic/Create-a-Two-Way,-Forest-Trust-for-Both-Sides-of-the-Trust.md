---
title: Create a Two-Way, Forest Trust for Both Sides of the Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 0424234a-787f-4957-a030-d6872ec0d2d4
author: Femila
---
# Create a Two-Way, Forest Trust for Both Sides of the Trust
  You can this procedure to create both sides of a two\-way, forest trust You must have administrative credentials for your forest as well as for the reciprocal forest. If you have administrative credentials only for your forest, you can use the procedure [Create a Two-Way, Forest Trust for One Side of the Trust](../Topic/Create-a-Two-Way,-Forest-Trust-for-One-Side-of-the-Trust.md) to create your side of the trust. Then, have the administrator for the reciprocal forest create a one\-way, outgoing forest trust from his or her forest.  
  
 A two\-way, forest trust allows users in your forest \(the forest that you are logged on to at the time that you run the New Trust Wizard\) and users in the reciprocal forest to access resources in any of the domains in either of the two forests.  
  
 You can create this forest trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in.  
  
 Membership in **Domain Admins** in the forest root domain or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]\) If you are a member of the **Incoming Forest Trust Builders** group, you can create one\-way, incoming, forest trusts to your forest. For more information about the Incoming Forest Trust Builders group, see How Domain and Forest Trusts Work \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111481](http://go.microsoft.com/fwlink/?LinkID=111481)\).  
  
### To create a two\-way, forest trust for both sides of the trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain node for the forest root domain for which you want to establish a trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name of the forest root domain of the other forest, and then click **Next**.  
  
5.  On the **Trust Type** page, click **Forest trust**, and then click **Next**.  
  
6.  On the **Direction of Trust** page, click **Two\-way**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
7.  On the **Sides of Trust** page, click **Both this domain and the specified domain**, and then click **Next**.  
  
     For more information about the selections that are available on the **Sides of Trust** page, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **User Name and Password** page, type the user name and password for the appropriate administrator in the specified domain.  
  
9. On the **Outgoing Trust Authentication Level\-\-Local Forest** page, do one of the following, and then click **Next**:  
  
    -   Click **Forest\-wide authentication**.  
  
    -   Click **Selective authentication**.  
  
10. On the **Outgoing Trust Authentication Level\-\-Specified Forest** page, do one of the following, and then click **Next**:  
  
    -   Click **Forest\-wide authentication**.  
  
    -   Click **Selective authentication**.  
  
11. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
12. On the **Trust Creation Complete** page, review the results, and then click **Next**.  
  
13. On the **Confirm Outgoing Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the outgoing trust**. Note that if you do not confirm the trust at this stage, the secure channel will not be established until the first time the trust is used by users.  
  
    -   If you want to confirm this trust, click **Yes, confirm the outgoing trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
14. On the **Confirm Incoming Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the incoming trust**.  
  
    -   If you want to confirm this trust, click **Yes, confirm the incoming trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
15. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
  