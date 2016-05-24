---
title: Create a Claims Provider Trust
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 07db283d-52ad-4215-8c3b-207519399e40
author: billmath
---
# Create a Claims Provider Trust
To add a new claims provider trust by using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in and manually configure the settings, perform the following procedure on a resource partner [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the resource partner organization.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a claims provider trust manually  
  
1.  In Server Manager, click **Tools**, and then select **AD FS Management**.  
  
2.  In the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] snap\-in, under the **AD FS\\Trust Relationships**, right\-click **Claims Provider Trusts**, and then click **Add Claims Provider Trust** to open the Add Claims Provider Trust Wizard.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Select Data Source** page, click **Enter claims provider trust data manually**, and then click **Next**.  
  
5.  On the **Specify Display Name** page, type a **Display name**, under **Notes**, type a description for this claims provider trust, and then click **Next**.  
  
6.  On the **Choose Profile** page, do one of the following:  
  
    -   Click **AD FS Profile**, click **Next**, and then go to step 7.  
  
    -   Click **AD FS 1.0 and 1.1 profile**, click **Next**, and then go to step 8.  
  
    If you know that you require interoperability between this claims provider trust and other, older [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] claims provider trusts, click **AD FS 1.0 and 1.1 profile**. Otherwise, use the default **AD FS profile** option.  
  
7.  On the **Configure URL** page, do one or both of the following, click **Next**, and then go to step 9:  
  
    -   Select the **Enable support for the WS\-Federation Passive protocol** check box. Under **Claims provider WS\-Federation Passive protocol URL**, type the URL for this claims provider trust, and then click **Next**.  
  
    -   Select the **Enable support for the SAML 2.0 WebSSO protocol** check box. Under **Claims provider SAML 2.0 SSO service URL**, type the Security Assertion Markup Language \(SAML\) service endpoint URL for this claims provider trust, and then click **Next**.  
  
8.  On the **Configure URL** page, under **WS\-Federation Passive URL**, type the URL for this claims provider trust, and then click **Next**.  
  
9. On the **Configure Identifier** page, under **Claims provider trust identifier**, type the appropriate identifier, and then click **Next**.  
  
10. On the **Configure Certificates** page, click **Add** to locate a certificate file and add it to the list of certificates, and then click **Next**.  
  
11. On the **Ready to Add Trust** page, click **Next** to save your claims provider trust information.  
  
12. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this claims provider trust, see the following additional references.  
  
## Additional references  
[Checklist: Configuring the Resource Partner Organization](../Topic/Checklist--Configuring-the-Resource-Partner-Organization.md)  
  
[Checklist: Creating Claim Rules for a Claims Provider Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Claims-Provider-Trust.md)  
  
## See Also  
[AD FS Operations](../Topic/AD-FS-Operations.md)  
  
