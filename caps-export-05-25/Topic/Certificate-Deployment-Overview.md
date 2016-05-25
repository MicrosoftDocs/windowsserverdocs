---
title: Certificate Deployment Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f5884d1a-f5dd-4755-b06d-831c7368be8d
author: vhorne
---
# Certificate Deployment Overview
This topic contains the following sections.  
  
-   [Computer and user certificate deployment components](#bkmk_components)  
  
-   [Computer and user certificate deployment process](#bkmk_process)  
  
## <a name="bkmk_components"></a>Computer and user certificate deployment components  
The following illustration depicts the components that are required to deploy client computer and user certificates.  
  
![](../Image/cng_user_certs.gif)  
  
For more information on each item depicted in the illustration above, see the following:  
  
-   [CA1 running the AD CS server role](#bkmk_ca1)  
  
-   [DC1 running the AD DS and DNS server roles](#bkmk_dc1)  
  
-   [Client1](#bkmk_client1)  
  
The following components are required to deploy client computer and user certificates.  
  
### <a name="bkmk_ca1"></a>CA1 running the AD CS server role  
The enterprise root certification authority \(CA\) is also an issuing CA. The CA issues certificates to computers and users that have the correct security permissions to enroll a certificate. Active Directory Certificate Services \(AD CS\) is installed on CA1.  
  
In this scenario, the enterprise root CA is also an issuing CA. For larger networks or where security concerns justify it, you can separate the roles of root CA and issuing CA, and deploy subordinate CAs that are issuing CAs.  
  
In the most secure deployments, the enterprise root CA is taken offline and physically secured. For more information, see [Additional Resources](assetId:///fdb5b540-45c6-46c8-b6c0-a992661c1165).  
  
#### Copy of the User certificate template  
When you deploy user certificates, you make a copy of the User certificate template and then configure the template according to your requirements and the instructions in this guide. You will be using a copy rather than the original so that the configuration of the original template is preserved for possible future use. The CA uses the copy of the user template to create user certificates that it issues to users that are members of the Domain Users group in Active Directory Users and Computers.  
  
#### Copy of the Workstation Authentication certificate template  
When you deploy computer certificates, you make a copy of the Workstation Authentication certificate template and then configure the template according to your requirements and the instructions in this guide. You will be using a copy rather than the original so that the configuration of the original template is preserved for possible future use. The CA uses the copy of the certificate template to create computer certificates that it issues to computers that are members of the Domain Computers group in Active Directory Users and Computers.  
  
### <a name="bkmk_dc1"></a>DC1 running the AD DS and DNS server roles  
After you configure the certificate templates on the CA, you can configure the default domain policy in Group Policy so that certificates are autoenrolled to users, computers, or both. Group Policy is configured in AD DS on the server DC1.  
  
### <a name="bkmk_client1"></a>Client1  
After you have configured certificate templates and Group Policy, you can refresh Group Policy on client computers to enroll certificates.  
  
## <a name="bkmk_process"></a>Computer and user certificate deployment process  
The process of configuring computer and user certificate enrollment occurs in these stages:  
  
-   Deploy a public key infrastructure \(PKI\). This step is required only if you have not already deployed a CA on your network. Instructions for installing AD CS as an enterprise root CA are included in the Core Network Companion Guide: Deploying Server Certificates, which is available in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library. For more information, see [Additional Resources](assetId:///fdb5b540-45c6-46c8-b6c0-a992661c1165).  
  
-   On CA1, which is the computer running the AD CS server role, configure copies of the Workstation Authentication and User certificate templates and add them to the CA. The CA issues certificates based on these certificate templates, so you must configure the templates for the computer and user certificates, and then add them to the CA, before the CA can issue them.  
  
-   On DC1, which is the computer running both the Active Directory Domain Services server role and the DNS server role, configure computer and user certificate autoenrollment in Group Policy. When you configure the autoenrollment of computer certificates, user certificates, or both, all domain member computers, domain users, or both will automatically receive a certificate when Group Policy on the user's computer is refreshed. If you add more computers or users later, they will automatically receive a certificate.  
  
> [!NOTE]  
> If you removed the Domain Users or Domain Computers groups from the certificate template ACL and replaced these groups with custom groups that you created in Active Directory Users and Computers, certificates will be enrolled only to the members of your custom groups.  
  
-   Refresh Group Policy on domain member computers. When Group Policy is refreshed:  
  
    -   If you have deployed computer certificates, the domain member computer enrolls a computer certificate that is based on the template that you configured in the previous step.  
  
    -   If you have deployed user certificates, the domain user enrolls a user certificate that is based on the template that you configured in the previous step.  
  
    -   If you have deployed both user and computer certificates, the domain member computer enrolls a computer certificate and the user enrolls a user certificate that are based on the templates that you configured in the previous steps.  
  
    -   Because you have already deployed a PKI, the CA certificate already exists in the Trusted Root Certification Authorities folder in the certificate store for both the Current User and the Local Computer.  
  
> [!NOTE]  
> Group Policy is automatically refreshed if you restart the domain member computer, or if a user logs on to a domain member computer. In addition, Group Policy is periodically refreshed. By default, this periodic refresh is performed every 90 minutes with a randomized offset of up to 30 minutes.  
  
