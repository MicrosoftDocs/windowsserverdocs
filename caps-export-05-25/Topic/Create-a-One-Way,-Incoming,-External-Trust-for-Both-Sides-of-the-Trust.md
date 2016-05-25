---
title: Create a One-Way, Incoming, External Trust for Both Sides of the Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d31339bd-b013-468d-b0db-1e1b853a8f1d
author: Femila
---
# Create a One-Way, Incoming, External Trust for Both Sides of the Trust
  You can use this procedure to create both sides of a one\-way, incoming, external trust. You must have administrative credentials for your domain as well for the reciprocal domain. If you have administrative credentials only for your domain, you can use the procedure [Create a One-Way, Incoming, External Trust for One Side of the Trust](../Topic/Create-a-One-Way,-Incoming,-External-Trust-for-One-Side-of-the-Trust.md) to create your side of the trust. Then, have the administrator for the reciprocal domain create a one\-way, outgoing, external trust from his or her domain.  
  
 A one\-way, incoming, external trust allows users in your domain \(the domain that you are logged on to at the time that you run the New Trust Wizard\) to access resources in another Active Directory domain \(outside your forest\) or in a Windows NT 4.0 domain. For example, if you are the administrator of sales.wingtiptoys.com and users in that domain need to access resources in the marketing.tailspintoys.com domain \(which is located in another forest\) you can use this procedure to establish a relationship so that users in your domain can access resources in the marketing.tailspintoys.com domain.  
  
 You can create this external trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about using the Netdom command\-line tool to create an external trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a one\-way, incoming, external trust for both sides of the trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain for which you want to establish a trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name \(or NetBIOS name\) of the external domain, and then click **Next**.  
  
5.  On the **Trust Type** page, click **External trust**, and then click **Next**.  
  
6.  On the **Direction of Trust** page, click **One\-way: incoming**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
7.  On the **Sides of Trust** page, click **Both this domain and the specified domain**, and then click **Next**.  
  
     For more information about the selections that are available on the **Sides of Trust** page, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **User Name and Password** page, type the user name and password for the appropriate administrator in the specified domain.  
  
9. On the **Outgoing Trust Authentication Level\-\-Specified Domain** page, do one of the following, and then click **Next**:  
  
    -   Click **Domain\-wide authentication**.  
  
    -   Click **Selective authentication**.  
  
10. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
11. On the **Trust Creation Complete** page, review the results, and then click **Next**.  
  
12. On the **Confirm Incoming Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the incoming trust**.  
  
    -   If you want to confirm this trust, click **Yes, confirm the incoming trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
13. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
  