---
title: Create a Non-Claims-Aware Relying Party Trust
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3b26eb33-879d-4af4-9d47-5b9d5e00f5bb
author: billmath
---
# Create a Non-Claims-Aware Relying Party Trust
In the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in, non\-claims\-aware relying party trusts are objects that are created to represent the trust between the federation service and a single web\-based application that is not claims\-aware and that is accessed through the Web Application Proxy.  
  
A non\-claims\-aware relying party trust is a relying party trust which consists of identifiers, names, and rules for authentication and authorization when the relying party trust is accessed through the Web Application Proxy. These web\-based applications that do not rely on claims, in other words, these Integrated Windows Authentication\-based applications, can have authorization rules that enforce access that is based on claims when the access is external to the corporate network through the Web Application Proxy.  
  
To add a new non\-claims\-aware relying party trust, by using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in, perform the following procedure.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a non\-claims\-aware relying party trust  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] snap\-in, under **AD FS\\Trust Relationships**, right\-click **Relying Party Trusts**, and then click **Add Non\-Claims\-Aware Relying Party Trust** to open the **Add Non\-Claims\-Aware Relying Party Trust Wizard**.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Specify Display Name** page, type a name in **Display name**, under **Notes** type a description for this non\-claims\-aware relying party trust, and then click **Next**.  
  
5.  On the **Configure Identifiers** page, specify one or more identifiers for this relying party, click **Add** to add them to the list, and then click **Next**.  
  
6.  On the **Configure Multi\-factor Authentication Now?** page, do one of the following:  
  
    -   Select **I do not want to configure multi\-factor authentication settings for this relying party trust at this time**, and then proceed to step 9.  
  
    -   Select **Configure multi\-factor authentication settings for this relying party trust**, and then proceed to step 7.  
  
    For more information about MFA, see [Configuring authentication policies for AD FS](../Topic/Configuring-authentication-policies-for-AD-FS.md).  
  
7.  On the **Configure Multi\-factor Authentication** page, configure multi\-factor authentication \(MFA\) that is based on the following available settings:  
  
    -   User or group membership – In **Users\/Groups**, click **Add** to specify those Active Directory \(AD\) users or groups for which you want to require MFA.  
  
    -   Devices – In **Devices**, select either **Unregistered** devices or **Registered devices**.  
  
    -   Locations – In **Locations**, select either **Extranet** or **Intranet**.  
  
    For more information about MFA, see [Configuring authentication policies for AD FS](../Topic/Configuring-authentication-policies-for-AD-FS.md).  
  
8.  On the **Choose Issuance Authorization Rules** page, select either **Permit all users to access this relying party** or **Deny all users access to this relying party**, and then click **Next**.  
  
9. On the **Ready to Add Trust** page, review the settings, and then click **Next** to save your relying party trust information.  
  
10. On the **Finish** page, click **Close**.  
  
> [!IMPORTANT]  
> For the non\-claims\-aware relying party trusts to function there has to be a Web Application Proxy that can orchestrate the authentication and authorization and can translate to the authentication protocol of the application it represents.  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  
