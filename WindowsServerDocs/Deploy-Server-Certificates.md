---
title: Deploy Server Certificates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0a39ecae-39cc-4f26-bd6f-b71ed02fc4ad
---
# Deploy Server Certificates


You can use this guide to deploy server certificates to your Software Defined Networking \(SDN\) infrastructure servers. 

This guide contains the following sections.

-   [Prerequisites for using this guide](#bkmk_pre)

-   [What this guide does not provide](#bkmk_not)

-   [Technology overviews](#bkmk_tech)

-   [Server Certificate Deployment Overview](assetId:///ca5c3e04-ae25-4590-97f3-0376a9c2a9a2)

-   [Server Certificate Deployment Planning](assetId:///7eb746e0-1046-4123-b532-77d5683ded44)

-   [Server Certificate Deployment](assetId:///1ae4384b-f4e4-41e8-bc5f-9ac41953bca4)

### **Digital server certificates**
When you deploy SDN in [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)], your SDN infrastructure servers require server certificates so that their authenticated communications are both trusted and secure. For small SDN deployments, the use of self-signed certificates might suffice, but for larger deployments, the management of self-signed certificates is labor intensive and impractical.

This guide provides instructions for using Active Directory Certificate Services (AD CS) to automatically enroll certificates to SDN infrastructure servers. AD CS allows you to build a public key infrastructure \(PKI\) and provide public key cryptography, digital certificates, and digital signature capabilities for your organization.

When you use digital server certificates for authentication between computers on your network, the certificates provide: 

1. Confidentiality through encryption.
2. Integrity through digital signatures.
3. Authentication by associating certificate keys with computer, user, or device accounts on a computer network.

### **Server types**
By using this guide, you can deploy server certificates to the following types of servers.
- SDN servers that are members of a Network Controller Servers group that you create by following the instructions in this guide.
- SDN servers that are members of a Software Load Balancing Multiplexer \(MUX\) Servers group that you create by following the instructions in this guide.
- Servers that are running the Remote Access service, including RAS Gateway servers, that are members of the **RAS and IAS Servers** group.
- Servers that are running the Network Policy Server \(NPS\) service that are members of the **RAS and IAS Servers** group.

### **Advantages of certificate autoenrollment**
Automatic enrollment of server certificates, also called autoenrollment, provides the following advantages.

- The AD CS certification authority (CA) automatically enrolls a server certificate to all of your SDN servers, eliminating the need to manually create and recreate self-signed certificates on each server.
- All computers in the domain automatically receive your CA certificate, which is installed in the Trusted Root Certification Authorities store on every domain member computer. Because of this, all computers in the domain trust the certificates that are issued by your CA. This trust allows your SDN servers to prove their identities to each other and engage in secure communications.
- Other than refreshing Group Policy, the manual reconfiguration of every SDN server is not required.
- Every server certificate includes both the Server Authentication purpose and the Client Authentication purpose in Enhanced Key Usage \(EKU\) extensions.
- Scalability. After deploying your Enterprise Root CA with this guide, you can expand your public key infrastructure \(PKI\) by adding Enterprise subordinate CAs.
- Manageability. You can manage AD CS by using the AD CS console or by using Windows PowerShell commands and scripts.
- Simplicity. You specify the servers that enroll server certificates by using Active Directory group accounts. For example, you can create a group for Network Controller servers and a different group for Software Load Balancing Multiplexer \(MUX\) servers if you want the server certificates for each of these server types to have different properties, such as different validity periods. Or you can use the same group for all servers.
- When you deploy server certificates, the certificates are based on a template that you configure with the instructions in this guide. This means that you can customize different certificate templates for specific server types, or you can use the same template for all server certificates that you want to issue.
- You can use this guide to enroll server certificates to other types of servers, including Network Policy Server \(NPS\) and Remote Access Service \(RAS\) servers that are DirectAccess or standard virtual private network \(VPN\) servers and are not part of your SDN infrastructure.

## <a name="bkmk_pre"></a>Prerequisites for using this guide

This guide provides instructions on how to deploy server certificates by using AD CS and the Web Server (IIS) server role in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]. Following are the prerequisites for performing the procedures in this guide.

- You must have a fully functioning Active Directory forest, domain, and TCP/IP v4 network.
- You must have already deployed your SDN infrastructure servers before you perform the steps in this guide. This is true because you cannot enroll a server certificate to a server that is not on your network yet.
- You must read the planning section of this guide to ensure that you are prepared for this deployment before you perform the deployment.
- You must perform the steps in this guide in the order in which they are presented. Do not jump ahead and deploy your CA without performing the steps that lead up to deploying the server, or your deployment will fail.
- You must be prepared to deploy two new servers on your network - one server upon which you will install AD CS as an Enterprise Root CA, and one server upon which you will install Web Server (IIS) so that your CA can publish the certificate revocation list (CRL) to the Web server. 

>[!NOTE]
>If you already have a Web server on your network that you want to use for the CRL, you can do so by skipping the Web Server installation process and using the other procedures in the guide to configure the Web server for the CRL publication. If you already have a PKI deployed on your network, you might need to modify some steps in this guide for your deployment.
- You are prepared to assign a static IP address to the Web and AD CS servers that you deploy with this guide, as well as to name the computers according to your organization naming conventions. In addition, you must join the computers to your domain.

## <a name="bkmk_not"></a>What this guide does not provide
This guide does not provide comprehensive instructions for designing and deploying a public key infrastructure \(PKI\) by using AD CS. It is recommended that you review AD CS documentation and PKI design documentation before deploying the technologies in this guide. 

## <a name="bkmk_tech"></a>Technology overviews
Following are technology overviews for AD CS and Web Server (IIS).


### Active Directory Certificate Services
AD CS in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] provides customizable services for creating and managing the X.509 certificates that are used in software security systems that employ public key technologies. Organizations can use AD CS to enhance security by binding the identity of a person, device, or service to a corresponding public key. AD CS also includes features that allow you to manage certificate enrollment and revocation in a variety of scalable environments.

For more information, see [Active Directory Certificate Services Overview](https://technet.microsoft.com/library/hh831740.aspx) and [Public Key Infrastructure Design Guidance](http://social.technet.microsoft.com/wiki/contents/articles/2901.public-key-infrastructure-design-guidance.aspx).

### Web Server (IIS)

The Web Server (IIS) role in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] provides a secure, easy-to-manage, modular, and extensible platform for reliably hosting websites, services, and applications. With IIS, you can share information with users on the Internet, an intranet, or an extranet. IIS is a unified web platform that integrates IIS, ASP.NET, FTP services, PHP, and Windows Communication Foundation (WCF).

For more information, see [Web Server (IIS) Overview](https://technet.microsoft.com/library/hh831725.aspx).




