---
title: Deploy Server Certificates for 802.1X Wired and Wireless Deployments
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: 0a39ecae-39cc-4f26-bd6f-b71ed02fc4ad
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
---
# Deploy Server Certificates for 802.1X Wired and Wireless Deployments

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this guide to deploy server certificates to your Remote Access and Network Policy Server (NPS) infrastructure servers.   

This guide contains the following sections.  

-   [Prerequisites for using this guide](#bkmk_pre)  

-   [What this guide does not provide](#bkmk_not)  

-   [Technology overviews](#bkmk_tech)  

-   [Server Certificate Deployment Overview](Server-Certificate-Deployment-Overview.md)  

-   [Server Certificate Deployment Planning](Server-Certificate-Deployment-Planning.md)  

-   [Server Certificate Deployment](Server-Certificate-Deployment.md)  

### **Digital server certificates**  
This guide provides instructions for using Active Directory Certificate Services (AD CS) to automatically enroll certificates to Remote Access and NPS infrastructure servers. AD CS allows you to build a public key infrastructure (PKI) and provide public key cryptography, digital certificates, and digital signature capabilities for your organization.  

When you use digital server certificates for authentication between computers on your network, the certificates provide:   

1. Confidentiality through encryption.  
2. Integrity through digital signatures.  
3. Authentication by associating certificate keys with computer, user, or device accounts on a computer network.  

### **Server types**  
By using this guide, you can deploy server certificates to the following types of servers.  
- Servers that are running the Remote Access service,  that are DirectAccess or standard virtual private network (VPN) servers, and that are members of the **RAS and IAS Servers** group.  
- Servers that are running the Network Policy Server (NPS) service that are members of the **RAS and IAS Servers** group.  

### **Advantages of certificate autoenrollment**  
Automatic enrollment of server certificates, also called autoenrollment, provides the following advantages.  

- The AD CS certification authority (CA) automatically enrolls a server certificate to all of your NPS and Remote Access servers.  
- All computers in the domain automatically receive your CA certificate, which is installed in the Trusted Root Certification Authorities store on every domain member computer. Because of this, all computers in the domain trust the certificates that are issued by your CA. This trust allows your authentication servers to prove their identities to each other and engage in secure communications.  
- Other than refreshing Group Policy, the manual reconfiguration of every server is not required.  
- Every server certificate includes both the Server Authentication purpose and the Client Authentication purpose in Enhanced Key Usage (EKU) extensions.  
- Scalability. After deploying your Enterprise Root CA with this guide, you can expand your public key infrastructure (PKI) by adding Enterprise subordinate CAs.  
- Manageability. You can manage AD CS by using the AD CS console or by using Windows PowerShell commands and scripts.  
- Simplicity. You specify the servers that enroll server certificates by using Active Directory group accounts and group membership.   
- When you deploy server certificates, the certificates are based on a template that you configure with the instructions in this guide. This means that you can customize different certificate templates for specific server types, or you can use the same template for all server certificates that you want to issue.  

## <a name="bkmk_pre"></a>Prerequisites for using this guide  

This guide provides instructions on how to deploy server certificates by using AD CS and the Web Server (IIS) server role in  Windows Server 2016. Following are the prerequisites for performing the procedures in this guide.  

- You must deploy a core network using the  Windows Server 2016 Core Network Guide, or you must already have the technologies provided in the Core Network Guide installed and functioning correctly on your network. These technologies include TCP/IP v4, DHCP, Active Directory Domain Services (AD DS), DNS, and NPS.  
  >[!NOTE]
  >The Windows Server 2016 Core Network Guide is available in the Windows Server 2016 Technical Library. For more information, see [Core Network Guide](../../../core-network-guide/Core-Network-Guide.md).

- You must read the planning section of this guide to ensure that you are prepared for this deployment before you perform the deployment.  
- You must perform the steps in this guide in the order in which they are presented. Do not jump ahead and deploy your CA without performing the steps that lead up to deploying the server, or your deployment will fail.  
- You must be prepared to deploy two new servers on your network - one server upon which you will install AD CS as an Enterprise Root CA, and one server upon which you will install Web Server (IIS) so that your CA can publish the certificate revocation list (CRL) to the Web server.   

>[!NOTE]  
>You are prepared to assign a static IP address to the Web and AD CS servers that you deploy with this guide, as well as to name the computers according to your organization naming conventions. In addition, you must join the computers to your domain.  

## <a name="bkmk_not"></a>What this guide does not provide  
This guide does not provide comprehensive instructions for designing and deploying a public key infrastructure (PKI) by using AD CS. It is recommended that you review AD CS documentation and PKI design documentation before deploying the technologies in this guide.   

## <a name="bkmk_tech"></a>Technology overviews  
Following are technology overviews for AD CS and Web Server (IIS).  

### Active Directory Certificate Services  
AD CS in  Windows Server 2016 provides customizable services for creating and managing the X.509 certificates that are used in software security systems that employ public key technologies. Organizations can use AD CS to enhance security by binding the identity of a person, device, or service to a corresponding public key. AD CS also includes features that allow you to manage certificate enrollment and revocation in a variety of scalable environments.  

For more information, see [Active Directory Certificate Services Overview](https://technet.microsoft.com/library/hh831740.aspx) and [Public Key Infrastructure Design Guidance](https://social.technet.microsoft.com/wiki/contents/articles/2901.public-key-infrastructure-design-guidance.aspx).  

### Web Server (IIS)  

The Web Server (IIS) role in  Windows Server 2016 provides a secure, easy-to-manage, modular, and extensible platform for reliably hosting websites, services, and applications. With IIS, you can share information with users on the Internet, an intranet, or an extranet. IIS is a unified web platform that integrates IIS, ASP.NET, FTP services, PHP, and Windows Communication Foundation (WCF).  

For more information, see [Web Server (IIS) Overview](https://technet.microsoft.com/library/hh831725.aspx).  
