---
title: Create a Two-Way, External Trust for Both Sides of the Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 13195ee8-bdf9-4ba3-bc36-771f17c03a45
author: Femila
---
# Create a Two-Way, External Trust for Both Sides of the Trust
  You can use this procedure to create both sides of a two\-way, external trust. You must have administrative credentials for your domain as well as for the reciprocal domain. If you have administrative credentials only for your domain, you can use the procedure [Create a Two-Way, External Trust for One Side of the Trust](../Topic/Create-a-Two-Way,-External-Trust-for-One-Side-of-the-Trust.md) to create your side of the trust. Then, have the administrator for the reciprocal domain create a two\-way, external trust from his or her domain.  
  
 A two\-way, external trust allows users in your domain \(the domain that you are logged on to at the time that you run the New Trust Wizard\) and users in the reciprocal domain to access resources in either of the two domains.  
  
 You can create this external trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about using the Netdom command\-line tool to create an external trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a two\-way, external trust for both sides of the trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain for which you want to establish a trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name \(or NetBIOS name\) of the domain, and then click **Next**.  
  
5.  On the **Trust Type** page, click **External trust**, and then click **Next**.  
  
6.  On the **Direction of Trust** page, click **Two\-way**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
7.  On the **Sides of Trust** page, click **Both this domain and the specified domain**, and then click **Next**.  
  
     For more information about the selections that are available on the **Sides of Trust** page, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **User Name and Password** page, type the user name and password for the appropriate administrator in the specified domain.  
  
9. On the **Outgoing Trust Authentication Level\-\-Local Domain** page, do one of the following, and then click **Next**:  
  
    -   Click **Domain\-wide authentication**.  
  
    -   Click **Selective authentication**.  
  
10. On the **Outgoing Trust Authentication Level\-\-Specified Domain** page, do one of the following, and then click **Next**:  
  
    -   Click **Domain\-wide authentication**.  
  
    -   Click **Selective authentication**.  
  
11. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
12. On the **Trust Creation Complete** page, review the results, and then click **Next**.  
  
13. On the **Confirm Outgoing Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the outgoing trust**. Note that if you do not confirm the trust at this stage, the secure channel will not be established until the first time that the trust is used by users.  
  
    -   If you want to confirm this trust, click **Yes, confirm the outgoing trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
14. On the **Confirm Incoming Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the incoming trust**.  
  
    -   If you want to confirm this trust, click **Yes, confirm the incoming trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
15. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
  