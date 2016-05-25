---
title: Remove a Manually Created Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3163da89-3cfc-406a-856f-2c8c03718e1c
author: Femila
---
# Remove a Manually Created Trust
  It is possible to remove manually created shortcut trusts, external trusts, realm trusts, or forest trusts. It is not possible to remove default, two\-way, transitive trusts between domains in a forest. It is particularly important to verify that you successfully remove trusts if you are planning to re\-create them.  
  
 You can use this procedure to remove a manually created trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about the Netdom command\-line tool, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Removing a manually created trust  
  
-   [Using the Windows interface](#bkmk_gui)  
  
-   [Using a command prompt](#bkmk_cmd)  
  
###  <a name="bkmk_gui"></a>   
##### To remove a manually created trust using the Windows interface  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain that contains the trust that you want to remove, and then click **Properties**.  
  
3.  Click the **Trusts** tab.  
  
4.  In either **Domains trusted by this domain \(outgoing trusts\)** or **Domains that trust this domain \(incoming trusts\)**, click the trust to be removed, and then click **Remove**.  
  
5.  Do one of the following, and then click **OK**:  
  
    -   Click **No, remove the trust from the local domain only**.  
  
         If you click this option, we recommend that you repeat this procedure for the reciprocal domain.  
  
    -   Click **Yes, remove the trust from both the local domain and the other domain**.  
  
         If you click this option, you must type a user account and password with administrative credentials for the reciprocal domain.  
  
###  <a name="bkmk_cmd"></a>   
##### To remove a manually created trust using the command line  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    netdom trust <TrustingDomainName> /d:<TrustedDomainName> /remove /UserD:<User> /PasswordD:*  
    ```  
  
    |Parameter|Description|  
    |---------------|-----------------|  
    |*\<*TrustingDomainName*\>*|The Domain Name System \(DNS\) name \(or NetBIOS name\) of the trusting domain in the trust that is being created.|  
    |*\<*TrustedDomainName*\>*|The DNS name \(or NetBIOS name\) of the domain that will be trusted in the trust that is being created.|  
    |\<User\>|The account name of the user authorized to create the trust.|  
  
> [!NOTE]  
>  If you are using Netdom to remove a realm trust, you must add the **\/force** option to the end of the command \(after **\/remove**\) to remove the trust successfully.  
  
  