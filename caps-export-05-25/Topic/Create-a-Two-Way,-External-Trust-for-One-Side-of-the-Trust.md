---
title: Create a Two-Way, External Trust for One Side of the Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8fd688b4-32b1-4123-b13f-7a331a4f65be
author: Femila
---
# Create a Two-Way, External Trust for One Side of the Trust
  You can use this procedure to create one side of a two\-way, external trust. Although one side of a trust will be created successfully, the new trust will not function until the administrator for the reciprocal domain uses his or her credentials to create the second side of the trust. If you have administrative credentials for both domains that are involved in the trust, you can use the procedure [Create a Two-Way, External Trust for Both Sides of the Trust](../Topic/Create-a-Two-Way,-External-Trust-for-Both-Sides-of-the-Trust.md) to create both sides of the trust in one simultaneous operation.  
  
 A two\-way, external trust allows users in your domain \(the domain that you are logged on to at the time that you run the New Trust Wizard\) and users in the reciprocal domain to access resources in either of the two domains.  
  
 You can create this external trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about using the Netdom command\-line tool to create an external trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To create a two\-way, external trust for one side of the trust  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain node for the domain for which you want to establish a trust, and then click **Properties**.  
  
3.  On the **Trusts** tab, click **New Trust**, and then click **Next**.  
  
4.  On the **Trust Name** page, type the Domain Name System \(DNS\) name \(or NetBIOS name\) of the domain, and then click **Next**.  
  
5.  On the **Trust Type** page, click **External trust**, and then click **Next**.  
  
6.  On the **Direction of Trust** page, click **Two\-way**, and then click **Next**.  
  
     For more information about the selections that are available on the **Direction of Trust** page, see "Direction of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
7.  On the **Sides of Trust** page, click **This domain only**, and then click **Next**.  
  
     For more information about the selections that are available on the **Sides of Trust** page, see "Sides of Trust" in [Appendix: New Trust Wizard Pages](../Topic/Appendix--New-Trust-Wizard-Pages.md).  
  
8.  On the **Outgoing Trust Authentication Level** page, do one of the following, and then click **Next**:  
  
    -   Click **Domain\-wide authentication**.  
  
    -   Click **Selective authentication**.  
  
9. On the **Trust Password** page, type the trust password twice, and then click **Next**.  
  
10. On the **Trust Selections Complete** page, review the results, and then click **Next**.  
  
11. On the **Trust Creation Complete** page, review the results, and then click **Next**.  
  
12. On the **Confirm Outgoing Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the outgoing trust**. Note that if you do not confirm the trust at this stage, the secure channel will not be established until the first time that the trust is used by users.  
  
    -   If you want to confirm this trust, click **Yes, confirm the outgoing trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
13. On the **Confirm Incoming Trust** page, do one of the following:  
  
    -   If you do not want to confirm this trust, click **No, do not confirm the incoming trust**.  
  
    -   If you want to confirm this trust, click **Yes, confirm the incoming trust**, and then supply the appropriate administrative credentials from the specified domain.  
  
14. On the **Completing the New Trust Wizard** page, click **Finish**.  
  
> [!NOTE]  
>  For this trust to function, the domain administrator for the specified domain or specified forest must follow this same procedure, using his or her administrative credentials and the exact same trust password that was used during this procedure.  
  
  