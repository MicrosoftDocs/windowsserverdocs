---
title: Create a Relying Party Trust Manually
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: db113f98-fce0-474b-a98b-6afa22b0d710
author: billmath
---
# Create a Relying Party Trust Manually
To add a new relying party trust using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in and manually configure the settings, perform the following procedure on a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the account partner organization.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a relying party trust manually  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  Under **AD FS\\Trust Relationships**, right\-click **Relying Party Trusts**, and then click **Add Relying Party Trust** to open the Add Relying Party Trust Wizard.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Select Data Source** page, click **Enter data about the relying party manually**, and then click **Next**.  
  
5.  On the **Specify Display Name** page type a name in **Display name**, under **Notes** type a description for this relying party trust, and then click **Next**.  
  
6.  On the **Choose Profile** page, do one of the following:  
  
    -   Click **AD FS profile**, click **Next**, and then move to step 7.  
  
    -   Click **AD FS 1.0 and 1.1 profile**, click **Next**, and then go to step 9.  
  
    If you know you will require interoperability with older Active Directory Federation Services \(AD FS\) federation, as provided in Windows Server 2003 R2, click **AD FS 1.0 and 1.1 profile**. Otherwise, use the default **AD FS profile**.  
  
7.  On the **Configure Certificate** page, click **Browse** to locate a certificate file, and then click **Next**.  
  
8.  On the **Configure URL** page, do one or both of the following, click **Next**, and then go to step 10:  
  
    -   Select the **Enable support for the WS\-Federation Passive protocol** check box. Under **Relying party WS\-Federation Passive protocol URL**, type the URL for this relying party trust, and then click **Next**.  
  
    -   Select the **Enable support for the SAML 2.0 WebSSO protocol** check box. Under **Relying party SAML 2.0 SSO service URL**, type the Security Assertion Markup Language \(SAML\) service endpoint URL for this relying party trust, and then click **Next**.  
  
    Click the **Help** button on this page for more information about which of these options apply to the needs of your organization.  
  
9. On the **Configure URL** page, under **WS\-Federation Passive URL**, type the URL for this relying party trust, and then click **Next**.  
  
10. On the **Configure Identifiers** page, specify one or more identifiers for this relying party, click **Add** to add them to the list, and then click **Next**.  
  
11. On the **Choose Issuance Authorization Rules** page, select either **Permit all users to access this relying party** or **Deny all users access to this relying party**, and then click **Next**.  
  
12. On the **Ready to Add Trust** page, review the settings, and then click **Next** to save your relying party trust information.  
  
13. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this relying party trust, see Additional references.  
  
## Additional references  
[Checklist: Configuring the Account Partner Organization](../Topic/Checklist--Configuring-the-Account-Partner-Organization.md)  
  
[Checklist: Creating Claim Rules for a Relying Party Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Relying-Party-Trust.md)  
  
