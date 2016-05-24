---
title: Configuring trust relationships for AD FS
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c0857cb-52eb-4139-8b08-9487c53c9496
author: femila
---
# Configuring trust relationships for AD FS
After you deploy the first federation server in the account partner organization, use the AD FS Management snap\-in to create a relying party trust relationship. You can create a relying party trust by entering data about a resource partner manually or by using a federation metadata URL that the administrator of the resource partner organization provides to you. You can use the federation metadata to retrieve the data for the resource partner automatically.  
  
> [!NOTE]  
> If the resource partner publishes its federation metadata or can provide a file copy of it for you to use, we recommend that you retrieve the data automatically because it can save time.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum requirement to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
-   [Create a claims provider trust by using federation metadata](../Topic/Configuring-trust-relationships-for-AD-FS.md#BKMK_Metadata)  
  
-   [Create a claims provider trust manually](../Topic/Configuring-trust-relationships-for-AD-FS.md#BKMK_Manual)  
  
## <a name="BKMK_Metadata"></a>Create a claims provider trust by using federation metadata  
To add a new claims provider trust, use the AD FS Management snap\-in. The snap\-in automatically imports configuration data about the partner from federation metadata that the partner has published to a local network or to the Internet. Perform the following procedure on a federation server in the resource partner organization.  
  
> [!NOTE]  
> To query federation metadata, you should only use a fully qualified domain name, such as https:\/\/myserver.contoso.com.  
  
#### To create a claims provider trust by using federation metadata  
  
1.  [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**AD FS Management**, and then press Enter.  
  
2.  Under **AD FS\\Trust Relationships**, right\-click **Claims Provider Trusts**, and then click **Add Claims Provider Trust** to open the Add Claims Provider Trust Wizard.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Select Data Source** page, click **Import data about the claims provider published online or on a local network**. In **Federation metadata address \(host name or URL\)**, type the federation metadata URL or host name for the partner, and then click **Next**.  
  
5.  On the **Specify Display Name** page, type a **Display name**, under **Notes**, type a description for this claims provider trust, and then click **Next**.  
  
6.  On the **Ready to Add Trust** page, click **Next** to save your claims provider trust information.  
  
7.  On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this claims provider trust, see the "Additional references" section later in this topic.  
  
    > [!IMPORTANT]  
    > If trusted certificate stores have been modified previously on this computer, verify that the service account that is assigned to this Federation Service trusts the SSL certificate that is used to secure the federation metadata retrieval. If the service account does not trust the SSL certificate of this claims provider, monitoring of the trust fails. To prevent this failure, ensure that the issuer of the claims provider’s SSL certificate is in the Local Computer Trusted Root Certification Authorities certificate store on each federation server in the farm.  
  
## <a name="BKMK_Manual"></a>Create a claims provider trust manually  
To add a new claims provider trust, use the AD FS Management snap\-in and manually configure the settings. Perform the following procedure on a resource partner federation server in the resource partner organization.  
  
#### To create a claims provider trust manually  
  
1.  [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**AD FS Management**, and then press Enter.  
  
2.  Under the **AD FS\\Trust Relationships**, right\-click **Claims Provider Trusts**, and then click **Add Claims Provider Trust** to open the Add Claims Provider Trust Wizard.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Select Data Source** page, click **Enter claims provider trust data manually**, and then click **Next**.  
  
5.  On the **Specify Display Name** page, type a **Display name**, under **Notes**, type a description for this claims provider trust, and then click **Next**.  
  
6.  On the **Choose Profile** page, do one of the following:  
  
    -   Click **AD FS Profile**, click **Next**, and then go to step 7.  
  
    -   Click **AD FS 1.0 and 1.1 profile**, click **Next**, and then move to step 8.  
  
    If you know that you require interoperability between this claims provider trust and other, older Active Directory Federation Services \(AD FS\) claims provider trusts, click **AD FS 1.0 and 1.1 profile**. Otherwise, use the default **AD FS profile** option.  
  
7.  On the **Configure URL** page, do one or both of the following, click **Next**, and then go to step 9:  
  
    -   Select the **Enable support for the WS\-Federation Passive protocol** check box. Under **Claims provider WS\-Federation Passive protocol URL**, type the URL for this claims provider trust, and then click **Next**.  
  
    -   Select the **Enable support for the SAML 2.0 WebSSO protocol** check box. Under **Claims provider SAML 2.0 SSO service URL**, type the Security Assertion Markup Language \(SAML\) service endpoint URL for this claims provider trust, and then click **Next**.  
  
    Click the **Help** button on this page for more information about which of these options apply to the requirements of your organization.  
  
8.  On the **Configure URL** page, under **WS\-Federation Passive URL**, type the URL for this claims provider trust, and then click **Next**.  
  
9. On the **Configure Identifier** page, under **Claims provider trust identifier**, type the appropriate identifier, and then click **Next**.  
  
10. On the **Configure Certificates** page, click **Add** to locate a certificate file and add it to the list of certificates, and then click **Next**.  
  
11. On the **Ready to Add Trust** page, click **Next** to save your claims provider trust information.  
  
12. On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this claims provider trust, see the "Additional references" section.  
  
