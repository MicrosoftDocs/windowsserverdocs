---
title: Configure Certificate Templates for PEAP and EAP Requirements
description: This topic provides information about using certificates with Network Policy Server and Remote Access in Windows Server 2016.
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 2af0a1df-5c44-496b-ab11-5bc340dc96f0
ms.author: lizross 
author: eross-msft
---
# Configure Certificate Templates for PEAP and EAP Requirements

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

All certificates that are used for network access authentication with Extensible Authentication Protocol\-Transport Layer Security \(EAP\-TLS\), Protected Extensible Authentication Protocol\-Transport Layer Security \(PEAP\-TLS\), and PEAP\-Microsoft Challenge Handshake Authentication Protocol version 2 \(MS\-CHAP v2\) must meet the requirements for X.509 certificates and work for connections that use Secure Socket Layer/Transport Level Security (SSL/TLS). Both client and server certificates have additional requirements.

>[!IMPORTANT]
>This topic provides instructions for configuring certificate templates. To use these instructions, it is required that you have deployed your own Public Key Infrastructure \(PKI\) with Active Directory Certificate Services \(AD CS\).

## Minimum server certificate requirements

With PEAP\-MS\-CHAP v2, PEAP\-TLS, or EAP\-TLS as the authentication method, the NPS must use a server certificate that meets the minimum server certificate requirements. 

Client computers can be configured to validate server certificates by using the **Validate server certificate** option on the client computer or in Group Policy. 

The client computer accepts the authentication attempt of the server when the server certificate meets the following requirements:

- The Subject name contains a value. If you issue a certificate to your server running Network Policy Server (NPS) that has a blank Subject name, the certificate is not available to authenticate your NPS. To configure the certificate template with a Subject name:

	1. Open Certificate Templates.
	2. In the details pane, right-click the certificate template that you want to change, and then click **Properties** .
	3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
	4. In **Subject name format**, select a value other than **None**.

- The computer certificate on the server chains to a trusted root certification authority (CA) and does not fail any of the checks that are performed by CryptoAPI and that are specified in the remote access policy or network policy.

- The computer certificate for the NPS or VPN server is configured with the Server Authentication purpose in Extended Key Usage (EKU) extensions. (The object identifier for Server Authentication is 1.3.6.1.5.5.7.3.1.)

- Configure the server certificate with the required cryptography setting:

    1. Open Certificate Templates.
    2. In the details pane, right-click the certificate template that you want to change, and then click **Properties**.
    3. Click the **Cryptography** tab and make sure to configure the following:
       - **Provider Category:** Key Storage Provider
       - **Algorithm Name:** RSA
       - **Providers:** Microsoft Platform Crypto Provider
       - **Minimum key size:** 2048
       - **Hash Algorithm:** SHA2
    4. Click **Next**.

- The Subject Alternative Name (SubjectAltName) extension, if used, must contain the DNS name of the server. To configure the certificate template with the Domain Name System (DNS) name of the enrolling server: 

	1. Open Certificate Templates.
	2. In the details pane, right-click the certificate template that you want to change, and then click **Properties** .
	3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
	4. In **Include this information in alternate subject name**, select **DNS name**.

When using PEAP and EAP-TLS, NPSs display a list of all installed certificates in the computer certificate store, with the following exceptions:

- Certificates that do not contain the Server Authentication purpose in EKU extensions are not displayed.

- Certificates that do not contain a Subject name are not displayed.

- Registry-based and smart card-logon certificates are not displayed.

For more information, see [Deploy Server Certificates for 802.1X Wired and Wireless Deployments](https://technet.microsoft.com/windows-server-docs/networking/core-network-guide/cncg/server-certs/deploy-server-certificates-for-802.1x-wired-and-wireless-deployments).

## Minimum client certificate requirements

With EAP-TLS or PEAP-TLS, the server accepts the client authentication attempt when the certificate meets the following requirements:

- The client certificate is issued by an enterprise CA or mapped to a user or computer account in Active Directory Domain Services \(AD DS\).

- The user or computer certificate on the client chains to a trusted root CA, includes the Client Authentication purpose in EKU extensions \(the object identifier for Client Authentication is 1.3.6.1.5.5.7.3.2\), and fails neither the checks that are performed by CryptoAPI and that are specified in the remote access policy or network policy nor the Certificate object identifier checks that are specified in NPS network policy.

- The 802.1X client does not use registry-based certificates that are either smart card-logon or password-protected certificates.

- For user certificates, the Subject Alternative Name \(SubjectAltName\) extension in the certificate contains the user principal name \(UPN\). To configure the UPN in a certificate template:

	1. Open Certificate Templates.
	2. In the details pane, right-click the certificate template that you want to change, and then click **Properties**.
	3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
	4. In **Include this information in alternate subject name**, select **User principal name \(UPN\)**.

- For computer certificates, the Subject Alternative Name \(SubjectAltName\) extension in the certificate must contain the fully qualified domain name \(FQDN\) of the client, which is also called the *DNS name*. To configure this name in the certificate template:

	1. Open Certificate Templates.
	2. In the details pane, right-click the certificate template that you want to change, and then click **Properties**.
	3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
	4. In **Include this information in alternate subject name**, select **DNS name**.

With PEAP\-TLS and EAP\-TLS, clients display a list of all installed certificates in the Certificates snap-in, with the following exceptions:

- Wireless clients do not display registry-based and smart card-logon certificates. 

- Wireless clients and VPN clients do not display password-protected certificates. 

- Certificates that do not contain the Client Authentication purpose in EKU extensions are not displayed.


For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).
