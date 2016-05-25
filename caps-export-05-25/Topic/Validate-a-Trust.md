---
title: Validate a Trust
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d82f7b44-4e47-4611-8c12-abf9ca1132c0
author: Femila
---
# Validate a Trust
  You can validate all trusts that are made between domains, but you cannot validate realm trusts.  
  
 You can use this procedure to validate a trust by using the New Trust Wizard in the Active Directory Domains and Trusts snap\-in or by using the Netdom command\-line tool. For more information about how to use the Netdom command\-line tool to create a realm trust, see Netdom Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=111537](http://go.microsoft.com/fwlink/?LinkId=111537)\).  
  
 Membership in **Domain Admins** or **Enterprise Admins** in Active Directory Domain Services \(AD DS\), or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Validating a trust  
  
-   [Using the Windows interface](#bkmk_gui)  
  
-   [Using the command line](#bkmk_cmd)  
  
###  <a name="bkmk_gui"></a>   
##### To validate a trust using the Windows interface  
  
1.  Open Active Directory Domains and Trusts.  
  
2.  In the console tree, right\-click the domain that contains the trust that you want to validate, and then click **Properties**.  
  
3.  On the **Trusts** tab, under either **Domains trusted by this domain \(outgoing trusts\)** or **Domains that trust this domain \(incoming trusts\)**, click the trust to be validated, and then click **Properties**.  
  
4.  Click **Validate**.  
  
5.  Do one of the following, and then click **OK**:  
  
    -   Click **No, do not validate the incoming\/outgoing trust**.  
  
         If you click this option, we recommend that you repeat this procedure for the reciprocal domain.  
  
    -   Click **Yes, validate the incoming\/outgoing trust**.  
  
         If you click this option, you must type a user account and password with administrative credentials for the reciprocal domain.  
  
###  <a name="bkmk_cmd"></a>   
##### To validate a trust using the command line  
  
1.  Open a Command Prompt as an administrator: On the **Start** menu, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide credentials, if required, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    ```  
    netdom trust <TrustingDomainName> /d:<TrustedDomainName> /verify  
    ```  
  
    |Value|Description|  
    |-----------|-----------------|  
    |*\<*TrustingDomainName*\>*|Specifies the Domain Name System \(DNS\) name \(or NetBIOS name\) of the trusting domain in the trust that is being created.|  
    |*\<*TrustedDomainName*\>*|Specifies the DNS name \(or NetBIOS name\) of the domain that will be trusted in the trust that is being created.|  
  
  