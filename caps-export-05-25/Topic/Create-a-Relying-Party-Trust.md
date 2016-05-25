---
title: Create a Relying Party Trust
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df1c2236-3900-450d-a205-662ea405ccce
author: billmath
---
# Create a Relying Party Trust
To add a new relying party trust by using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in and manually configure the settings, perform the following procedure on a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a relying party trust manually  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] snap\-in, under **AD FS\\Trust Relationships**, right\-click **Relying Party Trusts**, and then click **Add Relying Party Trust** to open the Add Relying Party Trust Wizard.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Select Data Source** page, click **Enter data about the relying party manually**, and then click **Next**.  
  
5.  On the **Specify Display Name** page, type a name in **Display name**, under **Notes** type a description for this relying party trust, and then click **Next**.  
  
6.  On the **Choose Profile** page, do one of the following:  
  
    -   Click **AD FS profile**, click **Next**, and then move to step 7.  
  
    -   Click **AD FS 1.0 and 1.1 profile**, click **Next**, and then go to step 9.  
  
    If you know that you will require interoperability with an older [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] federation, as provided in Windows Server 2003 R2, click **AD FS 1.0 and 1.1 profile**. Otherwise, use the default **AD FS profile**.  
  
7.  On the **Configure Certificate** page, click **Browse** to locate a certificate file, and then click **Next**.  
  
8.  On the **Configure URL** page, do one or both of the following, click **Next**, and then go to step 10:  
  
    -   Select the **Enable support for the WS\-Federation Passive protocol** check box. Under **Relying party WS\-Federation Passive protocol URL**, type the URL for this relying party trust, and then click **Next**.  
  
    -   Select the **Enable support for the SAML 2.0 WebSSO protocol** check box. Under **Relying party SAML 2.0 SSO service URL**, type the Security Assertion Markup Language \(SAML\) service endpoint URL for this relying party trust, and then click **Next**.  
  
9. On the **Configure URL** page, under **WS\-Federation Passive URL**, type the URL for this relying party trust, and then click **Next**.  
  
10. On the **Configure Identifiers** page, specify one or more identifiers for this relying party, click **Add** to add them to the list, and then click **Next**.  
  
11. On the **Configure Multi\-factor Authentication Now?** page, do one of the following:  
  
    -   Select **I do not want to configure multi\-factor authentication settings for this relying party trust at this time**, and then proceed to step 13.  
  
    -   Select **Configure multi\-factor authentication settings for this relying party trust**, and then proceed to step 12.  
  
    For more information about MFA, see [Configuring authentication policies for AD FS](../Topic/Configuring-authentication-policies-for-AD-FS.md).  
  
12. On the **Configure Multi\-factor Authentication** page, configure multi\-factor authentication \(MFA\) that is based on the following available settings:  
  
    -   User or group membership – In **Users\/Groups**, click **Add** to specify those Active Directory \(AD\) users or groups for which you want to require MFA.  
  
    -   Devices – In **Devices**, select either **Unregistered** devices or **Registered devices**.  
  
    -   Locations – In **Locations**, select either **Extranet** or **Intranet**.  
  
    For more information about MFA, see [Configuring authentication policies for AD FS](../Topic/Configuring-authentication-policies-for-AD-FS.md).  
  
13. On the **Choose Issuance Authorization Rules** page, select either **Permit all users to access this relying party** or **Deny all users access to this relying party**, and then click **Next**.  
  
14. On the **Ready to Add Trust** page, review the settings, and then click **Next** to save your relying party trust information.  
  
15. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box.  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  
