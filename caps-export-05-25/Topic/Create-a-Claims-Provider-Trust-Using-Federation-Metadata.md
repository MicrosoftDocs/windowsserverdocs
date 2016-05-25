---
title: Create a Claims Provider Trust Using Federation Metadata
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: efed6e2b-beb0-4da3-a5da-d1121b773eda
author: billmath
---
# Create a Claims Provider Trust Using Federation Metadata
To add a new claims provider trust, using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in, by automatically importing configuration data about the partner from federation metadata that the partner has published to a local network or to the Internet, perform the following procedure on a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the resource partner organization.  
  
> [!CAUTION]  
> Though it has long been common practice to use certificates with unqualified host names such as https:\/\/myserver, these certificates have no security value and can enable an attacker to impersonate a Federation Service that is publishing federation metadata. Therefore, when querying federation metadata, you should only use a fully qualified domain name such as https:\/\/myserver.contoso.com.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To create a claims provider trust using federation metadata  
  
1.  [!INCLUDE[clickstart](../Token/clickstart_md.md)]**AD FS Management**, and then press ENTER.  
  
2.  Under **AD FS\\Trust Relationships**, right\-click **Claims Provider Trusts**, and then click **Add Claims Provider Trust** to open the Add Claims Provider Trust Wizard.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Select Data Source** page, click **Import data about the claims provider published online or on a local network**. In **Federation metadata address \(host name or URL\)**, type the federation metadata URL or host name for the partner, and then click **Next**.  
  
5.  On the **Specify Display Name** page type a **Display name**, under **Notes** type a description for this claims provider trust, and then click **Next**.  
  
6.  On the **Ready to Add Trust** page, click **Next** to save your claims provider trust information.  
  
7.  On the **Finish** page, click **Close**. This will automatically display the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this claims provider trust, see the Additional references section below.  
  
    > [!IMPORTANT]  
    > If trusted certificate stores have been modified previously on this computer, verify that the SSL certificate that is used to secure the federation metadata retrieval is trusted by the service account that is assigned to this Federation Service. If the service account does not trust the SSL certificate of this claims provider, monitoring of the trust will fail. To prevent this failure, make sure that the issuer of the claims provider’s SSL certificate is in the Local Computer Trusted Root Certification Authorities certificate store on each federation server in the farm.  
  
## Additional references  
[Checklist: Configuring the Resource Partner Organization](../Topic/Checklist--Configuring-the-Resource-Partner-Organization.md)  
  
[Checklist: Creating Claim Rules for a Claims Provider Trust](../Topic/Checklist--Creating-Claim-Rules-for-a-Claims-Provider-Trust.md)  
  
