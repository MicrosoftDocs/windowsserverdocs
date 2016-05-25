---
title: Core Network Companion Guide: Computer and User Certificates Deployment
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fcf5b3bd-5884-4366-ba76-e8354bfbdf5d
author: vhorne
---
# Core Network Companion Guide: Computer and User Certificates Deployment
The [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] Core Network Guide provides instructions for planning and deploying the components required for a fully functioning network and a new Active Directory® domain in a new forest.  
  
This companion guide explains how to build on the core network by providing instructions for deploying client computer and user certificates with Active Directory Certificate Services \(AD CS\).  
  
> [!NOTE]  
> This guide is available in Word format at the Microsoft Download Center \([http:\/\/go.microsoft.com\/fwlink\/p\/?LinkId\=255201](http://go.microsoft.com/fwlink/p/?LinkId=255201)\).  
  
This guide contains the following sections.  
  
-   [Prerequisites for using this guide](#bkmk_pre)  
  
-   [About this guide](#bkmk_about)  
  
-   [What this guide does not provide](#bkmk_not)  
  
-   [Technology overviews](#bkmk_tech)  
  
-   [Certificate Deployment Overview](../Topic/Certificate-Deployment-Overview.md)  
  
-   [Certificate Deployment Planning](../Topic/Certificate-Deployment-Planning.md)  
  
-   [Certificate Deployment](../Topic/Certificate-Deployment.md)  
  
-   [Additional Resources](assetId:///fdb5b540-45c6-46c8-b6c0-a992661c1165)  
  
## <a name="bkmk_pre"></a>Prerequisites for using this guide  
This is a companion guide to the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide. To deploy computer and user certificates with this guide, you must first do the following.  
  
1.  Deploy a core network using the Core Network Guide, or already have the technologies provided in the Core Network Guide installed and functioning correctly on your network. These technologies include TCP\/IP v4, DHCP, Active Directory Domain Services \(AD DS\), DNS, NPS, and Web Server \(IIS\).  
  
    > [!NOTE]  
    > The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide is available in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=154884](http://go.microsoft.com/fwlink/?LinkId=154884)\).  
    >   
    > The Core Network Guide is also available in Word format at the Microsoft Download Center \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=157742](http://go.microsoft.com/fwlink/?LinkId=157742)\).  
  
2.  If you are using computer certificates or user certificates for network access authentication with certificate\-based authentication methods, you must deploy server certificates to NPS servers, RRAS servers, or both by using the Core Network Companion Guide: Server Certificate Deployment; or you must have already deployed a public key infrastructure \(PKI\) and server certificates that meet the requirements for network access authentication.  
  
    > [!NOTE]  
    > The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Companion Guide: Server Certificate Deployment is available in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library \([http:\/\/go.microsoft.com\/fwlink\/p\/?LinkId\=251948](http://go.microsoft.com/fwlink/p/?LinkId=251948)\).  
    >   
    > The Core Network Companion Guide: Server Certificate Deployment is also available in Word format at the Microsoft Download Center \([http:\/\/www.microsoft.com\/en\-us\/download\/details.aspx?id\=30131](http://www.microsoft.com/en-us/download/details.aspx?id=30131)\).  
  
## <a name="bkmk_about"></a>About this guide  
This guide provides instructions for deploying client computer and user certificates to domain member computers and domain users by using AD CS.  
  
Certificates are used for network access authentication because they provide strong security for authenticating users and computers and they eliminate the need for less secure password\-based authentication methods.  
  
When you deploy Extensible Authentication Protocol with Transport Layer Security \(EAP\-TLS\) or Protected EAP with TLS \(PEAP\-TLS\), certificates are required for the authentication of servers, and for either client computers or users, during network connection attempts through network access servers such as 802.1X\-capable switches and wireless access points, virtual private network \(VPN\) servers, and computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and Remote Desktop Gateway \(RD Gateway\) or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and Terminal Services Gateway \(TS Gateway\).  
  
> [!NOTE]  
> All of these network access servers are also called Remote Authentication Dial\-In User Service \(RADIUS\) clients, because they use the RADIUS protocol to send connection requests and other RADIUS messages to RADIUS servers. RADIUS servers process the connection requests and perform authentication and authorization. The RADIUS server and proxy in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is Network Policy Server \(NPS\).  
  
Deploying certificates with AD CS for EAP and PEAP certificate\-based authentication methods provides the following benefits:  
  
-   Security provided with certificate\-based authentication, which binds the identity of the server running NPS, RRAS server, user, or client computer to a private key  
  
-   A cost\-effective and secure method for managing certificates, allowing you to automatically enroll, renew, and revoke certificates to domain member computers and domain users  
  
-   An efficient method for managing certification authorities \(CAs\)  
  
-   The ability to deploy other types of certificates that are used for purposes other than computer, user, or server authentication. For example, you can deploy certificates that provide users with the ability to digitally sign e\-mail, or you can issue certificates used for software code signing.  
  
This guide is designed for network and system administrators who have followed the instructions in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide to deploy a network, or for those who have previously deployed the technologies included in the core network, including Active Directory Domain Services \(AD DS\), Domain Name System \(DNS\), Dynamic Host Configuration Protocol \(DHCP\), TCP\/IP, Network Policy Server \(NPS\), and Web Server \(IIS\).  
  
It is recommended that you review the design and deployment guides for each of the technologies that are used in this deployment scenario. These guides can help you determine whether this deployment scenario provides the services and configuration that you need for your organization network.  
  
### Requirements for deploying computer and user certificates  
Following are the requirements for deploying client computer and user certificates using autoenrollment:  
  
-   AD DS is installed, as are other network technologies, according to the instructions in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Guide.  
  
-   To perform autoenrollment of client computer and user certificates, your CA must be running the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)] Enterprise or Datacenter operating system and must be an issuing CA; or your CA must be running the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Standard, Enterprise, or Datacenter operating system and must be an issuing CA. Although AD CS can be deployed on a single server, many deployments use a two tier public key infrastructure with multiple servers configured as subordinate CAs.  
  
-   To deploy EAP\-TLS or PEAP\-TLS, you must enroll server certificates to NPS servers and, if you are using RRAS servers as virtual private network \(VPN\) servers, to computers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and Routing and Remote Access service \(RRAS\). This guide assumes that you have autoenrolled server certificates in accordance with the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Core Network Companion Guide: Deploying Server Certificates, which is available in HTML format in the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Technical Library \([http:\/\/technet.microsoft.com\/en\-us\/library\/jj125379](http://technet.microsoft.com/en-us/library/jj125379)\). This paper is also available in Word format at the Microsoft Download Center \([http:\/\/www.microsoft.com\/en\-us\/download\/details.aspx?id\=19224](http://www.microsoft.com/en-us/download/details.aspx?id=19224)\).  
  
> [!NOTE]  
> If you deploy one or more RRAS servers as VPN servers and you do not have NPS installed, network policies and the authentication methods included in these policies are configured individually per RRAS server, which can be time\-consuming and can create opportunities for configuration errors. When you install NPS, you can configure RRAS servers as RADIUS clients in NPS, and then use NPS to centrally manage all policies and authentication methods used per policy.  
  
-   To deploy PEAP or EAP for VPN, you must deploy Routing and Remote Access configured as a VPN server. The use of NPS is optional; however, if you have multiple VPN servers, using NPS is recommended for ease of administration and for the RADIUS accounting services that NPS provides.  
  
-   To deploy PEAP or EAP for TS Gateway in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or RD Gateway in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you must deploy TS Gateway and NPS or RD Gateway and NPS, respectively.  
  
-   To deploy PEAP or EAP for 802.1X secure wired or wireless, you must deploy NPS and additional hardware, such as 802.1X\-capable switches or wireless access points.  
  
## <a name="bkmk_not"></a>What this guide does not provide  
This guide does not provide information about the following:  
  
-   How to deploy client computer and user certificates with smart cards.  
  
-   How to deploy server certificates with autoenrollment.  
  
-   How to design and deploy a public key infrastructure \(PKI\) by using AD CS. It is recommended that you review AD CS design and deployment documentation before deploying the technologies in this guide. For more information, see [Additional Resources](https://technet.microsoft.com/library/dd772664(v=ws.10).aspx).  
  
-   How to deploy the network access technologies for which server certificates can be used. There might be other companion guides available that provide instructions for deploying these network access solutions. You might also want to review the NPS documentation for this information.  
  
## <a name="bkmk_tech"></a>Technology overviews  
Following are technology overviews for client computer and user certificates, EAP, PEAP, and AD CS.  
  
### AD CS  
AD CS in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides customizable services for creating and managing the X.509 certificates that are used in software security systems that employ public key technologies. Organizations can use AD CS to enhance security by binding the identity of a person, device, or service to a corresponding public key. AD CS also includes features that allow you to manage certificate enrollment and revocation in a variety of scalable environments.  
  
### Client computer and user certificates  
When you deploy EAP\-TLS or PEAP\-TLS, you can deploy computer certificates for client computer authentication, user certificates for user authentication, or both.  
  
> [!NOTE]  
> EAP does not provide mechanisms that perform dual authentication — that is, the authentication of both the computer being used to access the network and the user who is attempting to connect. For this reason, you are not required to issue both computer and user certificates when you deploy EAP and PEAP with certificate\-based authentication types.  
  
There are two methods for deploying client computer and user certificates:  
  
-   **Using smart cards**. When you deploy certificates using smart cards, you must purchase additional hardware to imprint certificates on user identification or other cards that your employees use to log on to the network. In addition, users must be supplied with smart card readers, which are used to read the certificate that is imprinted on the smart card when they log on.  
  
    > [!IMPORTANT]  
    > This guide does not provide information about how to deploy client computer and user certificates with smart cards.  
  
-   **Using autoenrollment**. When you deploy certificates using autoenrollment, you configure the CA to automatically enroll certificates to computers that are members of the Domain Computers group and to users who are members of the Domain Users group. No additional hardware is required to autoenroll certificates, because the certificates are stored on the computer that is connecting to the network. When a computer receives a computer or user certificate from the CA, the certificate is stored locally in a data store named the certificate store.  
  
> [!IMPORTANT]  
> You should enroll certificates only to the computers and users to whom you want to grant network access through RADIUS clients. You do not have to autoenroll certificates to all members of the Domain Users and Domain Computers groups. Instead, you can issue certificates to subsets of the Domain Users and Domain Computers groups, such as to the Sales team or the Accounting department. To enroll certificates to other groups, create the groups and then add members to the groups in Active Directory Users and Computers. In the Certificate Templates snap\-in, remove the Domain Users or Domain Computers groups from the access control list \(ACL\) on the certificate templates \(the User template and the Workstation Authentication template, respectively\), and then add the groups that you created to the template.  
  
#### Certificate store  
On computers that are running the Windows operating system, certificates that are installed on the computer are kept in a storage area called the *certificate store*. The certificate store is accessible using the Certificates Microsoft Management Console \(MMC\) snap\-in.  
  
This store contains multiple folders, where certificates of different types are stored. For example, the certificate store contains a Trusted Root Certification Authorities folder where the certificates from all trusted root CAs are kept.  
  
When your organization deploys a PKI and installs a private trusted root CA using AD CS, the CA automatically sends its certificate to all domain member computers in the organization. The domain member client and server computers store the CA certificate in the Trusted Root Certification Authorities folder in the Current User and the Local Computer certificate stores. After this occurs, the domain member computers trust certificates that are issued by the trusted root CA.  
  
Similarly, when you autoenroll computer certificates to domain member client computers, the certificate is kept in the Personal certificate store for the Local Computer. When you autoenroll certificates to users, the user certificate is kept in the Personal certificate store for the Current User.  
  
### EAP  
Extensible Authentication Protocol \(EAP\) extends Point\-to\-Point Protocol \(PPP\) by allowing arbitrary authentication methods that use credential and information exchanges of arbitrary lengths. EAP was developed in response to the demand for authentication methods that use security devices such as smart cards, token cards, and crypto calculators. EAP provides an industry\-standard architecture for supporting additional authentication methods within PPP.  
  
With EAP, an arbitrary authentication mechanism is used to verify the identities of the client and server that are establishing a network access connection. The authentication scheme to be used is negotiated by the access client and the authenticator \(the network access server or the RADIUS server\).  
  
For successful authentication to occur, both the network access client and the authenticator \(such as the server running NPS\) must support the same EAP type.  
  
> [!IMPORTANT]  
> Strong EAP types \(such as those that are based on certificates\) offer better protection against brute\-force attacks, dictionary attacks, and password guessing attacks than password\-based authentication protocols \(such as CHAP or MS\-CHAP, version 1\).  
  
#### EAP in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes an EAP infrastructure, two EAP types, and the ability to pass EAP messages to a RADIUS server \(EAP\-RADIUS\) such as NPS.  
  
By using EAP, you can support additional authentication schemes, known as EAP types. The EAP types that are supported by [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] are:  
  
-   **Transport Layer Security \(TLS\)**. EAP\-TLS requires the use of computer certificates or user certificates, in addition to server certificates that are enrolled to computers running NPS.  
  
-   **Microsoft Challenge\-Handshake Authentication Protocol, version 2 \(MS\-CHAP v2\)**. This EAP type is a password\-based authentication protocol. When used within EAP as the authentication method EAP\-MS\-CHAP v2, NPS and RRAS servers provide a server certificate as proof of identity to client computers, while users prove their identity with a user name and password.  
  
-   **Tunneled Transport Layer Security \(TTLS\)**. EAP\-TTLS is new in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and is not available in other versions of Windows Server. EAP\-TTLS is a standards\-based EAP tunneling method that supports mutual authentication. EAP\-TTLS provides a secure tunnel for client authentication using EAP methods and other legacy protocols. EAP\-TTLS also provides you with the ability to configure EAP\-TTLS on client computers for network access solutions in which non\-Microsoft Remote Authentication Dial In User Service \(RADIUS\) servers that support EAP\-TTLS are used for authentication.  
  
In addition, you can install other non\-Microsoft EAP modules on the server running NPS or Routing and Remote Access to provide other EAP authentication types. In most cases, if you install additional EAP types on servers, you must also install matching EAP client authentication components on client computers so that the client and server can successfully negotiate an authentication method to use for connection requests.  
  
#### PEAP  
PEAP uses TLS to create an encrypted channel between an authenticating PEAP client, such as a wireless computer, and a PEAP authenticator, such as a server running NPS or other RADIUS server.  
  
PEAP does not specify an authentication method, but it provides additional security for other EAP authentication protocols \(such as EAP\-MSCHAP v2\) that can operate through the TLS\-encrypted channel provided by PEAP. PEAP is used as an authentication method for access clients that are connecting to your organization's network through the following types of network access servers:  
  
-   802.1X\-capable wireless access points  
  
-   802.1X\-capable authenticating switches  
  
-   Computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and RRAS that are configured as VPN servers  
  
-   Computers running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and RD Gateway  
  
##### Features of PEAP  
To enhance the EAP protocols and network security, PEAP provides:  
  
-   A TLS channel that provides protection for the EAP method negotiation that occurs between the client and server. This TLS channel helps prevent an attacker from injecting packets between the client and the network access server to cause the negotiation of a less secure EAP type. The encrypted TLS channel also helps prevent denial of service attacks against the server running NPS.  
  
-   Support for the fragmentation and reassembly of messages, which allows the use of EAP types that do not provide this functionality.  
  
-   Clients with the ability to authenticate the NPS or other RADIUS server. Because the server also authenticates the client, mutual authentication occurs.  
  
-   Protection against the deployment of an unauthorized wireless access point at the moment when the EAP client authenticates the certificate provided by the server running NPS. In addition, the TLS master secret that is created by the PEAP authenticator and the client is not shared with the access point. Because of this, the access point cannot decrypt the messages that are protected by PEAP.  
  
-   PEAP fast reconnect, which reduces the delay between an authentication request by a client and the response by the NPS or other RADIUS server. Fast reconnect also allows wireless clients to move between access points that are configured as RADIUS clients to the same RADIUS server without repeated requests for authentication. This reduces resource requirements for the client and the server, and it minimizes the number of times that users are prompted for credentials.  
  
#### EAP\-TLS and PEAP\-TLS deployment overview  
The following are the general steps for deploying EAP\-TLS or PEAP\-TLS:  
  
-   Deploy network access servers \(RADIUS clients\) that are both EAP and RADIUS compliant.  
  
-   Autoenroll server certificates to servers running NPS and, if applicable, Routing and Remote Access VPN servers.  
  
-   Autoenroll computer certificates, user certificates, or both, to domain member computers and users, respectively, or to other groups that you have created.  
  
-   Configure network access servers as RADIUS clients in NPS.  
  
-   Configure EAP authentication in NPS or RRAS network policy.  
  
-   Ensure that client computers support EAP. By default, [!INCLUDE[win8_client_1](../Token/win8_client_1_md.md)], [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)], and [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)] support EAP.  
  
### Group Policy  
Group Policy in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is an infrastructure used to deliver and apply one or more desired configurations or policy settings to a set of targeted users and computers within an Active Directory environment. This infrastructure consists of a Group Policy engine and multiple client\-side extensions \(CSEs\) responsible for reading policy settings on target client computers. Group Policy is used in this scenario to enroll and distribute certificates to users, computers, or both.  
  
