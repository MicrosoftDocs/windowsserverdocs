---
title: Enable Selective Authentication over a Forest Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 76a40c1a-7045-482f-9c45-a459e0871f52
author: Femila
---
# Enable Selective Authentication over a Forest Trust
  Selective authentication over a forest trust restricts access to only those users in a trusted forest who have been explicitly given authentication permissions to computer objects \(resource computers\) that reside in the trusting forest. To explicitly give authentication permissions to computer objects in the trusting forest to certain users, administrators must grant those users the **Allowed to Authenticate** permission in Active Directory Domain Services \(AD DS\). For more information about granting the **Allowed to Authenticate** permission, see [Grant the Allowed to Authenticate Permission on Computers in the Trusting Domain or Forest](../Topic/Grant-the-Allowed-to-Authenticate-Permission-on-Computers-in-the-Trusting-Domain-or-Forest.md). For more information about how selective authentication works, see Security Considerations for Trusts \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=111846](http://go.microsoft.com/fwlink/?LinkID=111846)\).  
  
 To provide access to computers in the trusting forest to only those users in the trusted forest who have the **Allowed to Authenticate** permission applied to the computer objects, you can use this procedure to enable selective authentication over a forest trust with the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or with the Netdom command\-line tool. For more information about how to use the Netdom command\-line tool to configure selective authentication settings, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** in the forest root domain or **Enterprise Admins** in AD DS, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Enabling selective authentication over a forest trust  
  
-   Using the Windows interface  
  
-   Using a command line  
  
#### To enable selective authentication over a forest trust using the Windows interface  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain node for the forest root domain, and then click **Properties**.  
  
3.  On the **Trusts** tab, under either **Domains trusted by this domain \(outgoing trusts\)** or **Domains that trust this domain \(incoming trusts\)**, click the forest trust that you want to administer, and then click **Properties**.  
  
4.  On the **Authentication** tab, click **Selective authentication**, and then click **OK**.  
  
> [!NOTE]  
>  Only the authentication settings for the outgoing trust are displayed when you click **Properties** and then click the **Authentication** tab in Active Directory Domains and Trusts. To view the correct authentication settings for the incoming side of a two\-way, forest trust, connect to a domain controller in the forest root domain of the trusted forest, and then use Active Directory Domains and Trusts to view the authentication settings for the outgoing side of the same trust.  
  
#### To enable selective authentication over a forest trust using a command line  
  
1.  Open a Command Prompt.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    Netdom trust <TrustingDomainName> /domain:<TrustedDomainName> /SelectiveAUTH:Yes /userD:<DomainAdministratorAcct> /passwordD:<DomainAdminPwd>  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |\<TrustingDomainName\>|The Domain Name System \(DNS\) name \(or NetBIOS name\) of the trusting forest root domain in the trust that is being managed.|  
    |\<TrustedDomainName\>|The DNS name \(or NetBIOS name\) of the forest root domain that is trusted in the trust that is being managed.|  
    |\<DomainAdministratorAcct\>|The user account name with the appropriate administrator credentials to modify the trust.|  
    |\<DomainAdminPwd\>|The password of the user account in \<DomainAdministratorAcct\>.|  
  
  