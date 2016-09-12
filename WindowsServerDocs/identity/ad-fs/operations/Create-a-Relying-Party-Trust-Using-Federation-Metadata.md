---
title: Create a Relying Party Trust Using Federation Metadata
description:
author: billmath
manager: femila
ms.date: 08/23/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.service: active-directory
ms.technology: active-directory-federation-services
ms.author:billmath
---

# Create a Relying Party Trust Using Federation Metadata

>Applies To: Windows Server 2016, Windows Server 2012 R2

To add a new relying party trust, using the AD FS Management snap\-in, by automatically importing configuration data about the partner from federation metadata that the partner published to a local network or to the Internet, perform the following procedure on a federation server in the account partner organization.  
  
> [!CAUTION]  
> Though it has long been common practice to use certificates with unqualified host names such as https:\/\/myserver, these certificates have no security value and can enable an attacker to impersonate a Federation Service that is publishing federation metadata. Therefore, when querying federation metadata, you should only use a fully qualified domain name such as https:\/\/myserver.contoso.com.  
  
Membership in **Administrators**, or equivalent, on the local computer is the minimum required to complete this procedure.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](http://go.microsoft.com/fwlink/?LinkId=83477).   
  
#### To create a relying party trust using federation metadata  
  
1.  On the **Start** screen, type**AD FS Management**, and then press ENTER.  
  
2.  Under the **AD FS\\Trust Relationships** folder, right\-click **Relying Party Trusts**, and then click **Add Relying Party Trust** to open the Add Relying Party Trust Wizard.  
  
3.  On the **Welcome** page, click **Start**.  
  
4.  On the **Select Data Source** page, click **Import data about the relying party published online or on a local network**. In **Federation metadata address \(host name or URL\)**, type the federation metadata URL or host name for the partner, and then click **Next**.  
  
5.  On the **Specify Display Name** page type a name in **Display name**, under **Notes** type a description for this relying party trust, and then click **Next**.  
  
6.  On the **Choose Issuance Authorization Rules** page, select either **Permit all users to access this relying party** or **Deny all users access to this relying party**, and then click **Next**.  
  
7.  On the **Ready to Add Trust** page, review the settings, and then click **Next** to save your relying party trust information.  
  
8.  On the **Finish** page, click **Close**. This action automatically displays the **Edit Claim Rules** dialog box. For more information about how to proceed with adding claim rules for this relying party trust, see the Additional references.  
  
    > [!IMPORTANT]  
    > If trusted certificate stores have been modified previously on this computer, verify that the SSL certificate that is used to secure the federation metadata retrieval is trusted by the service account that is assigned to this Federation Service. If the service account does not trust the SSL certificate of this relying party, monitoring of the trust will fail. To prevent this failure, make sure that the issuer of the relying party’s SSL certificate is in the Local Computer Trusted Root Certification Authorities certificate store on each federation server in the farm.  

## See Also  
[AD FS Operations](../../ad-fs/AD-FS-2016-Operations.md) 



