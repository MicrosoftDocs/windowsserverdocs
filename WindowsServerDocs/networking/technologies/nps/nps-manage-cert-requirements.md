---
title: Configure Certificate Templates for PEAP and EAP Requirements
description: This topic provides information about using certificates with Network Policy Server and Remote Access in Windows Server 2016.
ms.topic: article
ms.assetid: 2af0a1df-5c44-496b-ab11-5bc340dc96f0
ms.author: wscontent
author: xelu86
ms.date: 06/15/2023
ms.contributor: samyun
---
# Configure Certificate Templates for PEAP and EAP Requirements

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

All certificates that are used for network access authentication with Extensible Authentication Protocol-Transport Layer Security (EAP-TLS), Protected Extensible Authentication Protocol-Transport Layer Security (PEAP-TLS), and PEAP-Microsoft Challenge Handshake Authentication Protocol version 2 (MS-CHAP v2) must meet the requirements for X.509 certificates and work for connections that use Secure Socket Layer/Transport Level Security (SSL/TLS). Both client and server certificates have additional requirements, detailed below.

> [!IMPORTANT]
> This topic provides instructions for configuring certificate templates. To use these instructions, it is required that you have deployed your own Public Key Infrastructure (PKI) with Active Directory Certificate Services (AD CS).

## Minimum server certificate requirements

With PEAP-MS-CHAP v2, PEAP-TLS, or EAP-TLS as the authentication method, the NPS must use a server certificate that meets the minimum server certificate requirements.

Client computers can be configured to validate server certificates by using the **Validate server certificate** option on the client computer or in Group Policy.

The client computer accepts the authentication attempt of the server when the server certificate meets the following requirements:

- The Subject name contains a value. If you issue a certificate to your server running Network Policy Server (NPS) that has a blank Subject name, the certificate isn't available to authenticate your NPS. To configure the certificate template with a Subject name:

  1. Open Certificate Templates.
  2. In the details pane, right-click the certificate template that you want to change, and then click **Properties** .
  3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
  4. In **Subject name format**, select a value other than **None**.

- The computer certificate on the server:
  - chains to a trusted root certification authority (CA),
  - includes the `Server Authentication` purpose in EKU extensions (the object identifier (OID) for `Server Authentication` is `1.3.6.1.5.5.7.3.1`),
  - and passes:
    - the checks that are performed by CryptoAPI, and
    - the checks that are specified in the remote access policy or network policy

- Configure the server certificate with the required cryptography setting:

    1. Open Certificate Templates.
    2. In the details pane, right-click the certificate template that you want to change, and then click **Properties**.
    3. Click the **Cryptography** tab and make sure to configure the following:
       - **Provider Category:** for example, **Key Storage Provider**
       - **Algorithm Name:** for example, **RSA**
       - **Providers:** for example, **Microsoft Software Key Storage Provider**
       - **Minimum key size:** for example, **2048**
       - **Hash Algorithm:** for example, **SHA256**
    4. Click **Next**.

- The Subject Alternative Name (SubjectAltName) extension, if used, must contain the DNS name of the server. To configure the certificate template with the Domain Name System (DNS) name of the enrolling server:

  1. Open Certificate Templates.
  2. In the details pane, right-click the certificate template that you want to change, and then click **Properties** .
  3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
  4. In **Include this information in alternate subject name**, select **DNS name**.

When using PEAP and EAP-TLS, NPS displays a list of all installed certificates in the computer certificate store, with the following exceptions:

- Certificates that don't contain the `Server Authentication` purpose in EKU extensions aren't displayed.

- Certificates that don't contain a Subject name aren't displayed.

- Registry-based and smart card-logon certificates aren't displayed.

For more information, see [Deploy Server Certificates for 802.1X Wired and Wireless Deployments](../../core-network-guide/cncg/server-certs/deploy-server-certificates-for-802.1x-wired-and-wireless-deployments.md).

## Minimum client certificate requirements

With EAP-TLS or PEAP-TLS, the server accepts the client authentication attempt when the certificate meets the following requirements:

- The client certificate is issued by an enterprise CA or mapped to a user or computer account in Active Directory Domain Services (AD DS).

- The user or computer certificate on the client:

  - chains to a trusted root CA,
  - includes the `Client Authentication` purpose in EKU extensions (the OID for `Client Authentication` is `1.3.6.1.5.5.7.3.2`),
  - and passes:
    - the checks that are performed by CryptoAPI,
    - the checks that are specified in the remote access policy or network policy and,
    - the certificate object identifier checks that are specified in NPS network policy.

- The 802.1X client doesn't use registry-based certificates that are either smart card-logon or password-protected certificates.

- For user certificates, the Subject Alternative Name (SubjectAltName) extension in the certificate contains the user principal name (UPN). To configure the UPN in a certificate template:

  1. Open Certificate Templates.
  2. In the details pane, right-click the certificate template that you want to change, and then click **Properties**.
  3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
  4. In **Include this information in alternate subject name**, select **User principal name (UPN)**.

- For computer certificates, the Subject Alternative Name (SubjectAltName) extension in the certificate must contain the fully qualified domain name (FQDN) of the client, which is also called the *DNS name*. To configure this name in the certificate template:

  1. Open Certificate Templates.
  2. In the details pane, right-click the certificate template that you want to change, and then click **Properties**.
  3. Click the **Subject Name** tab, and then click **Build from this Active Directory information**.
  4. In **Include this information in alternate subject name**, select **DNS name**.

With PEAP-TLS and EAP-TLS, clients display a list of all installed certificates in the Certificates snap-in, with the following exceptions:

- Wireless clients don't display registry-based and smart card-logon certificates.

- Wireless clients and VPN clients don't display password-protected certificates.

- Certificates that don't contain the `Client Authentication` purpose in EKU extensions aren't displayed.

For more information about NPS, see [Network Policy Server (NPS)](nps-top.md).

For more information about EAP, see [Extensible Authentication Protocol (EAP) for network access](/windows-server/networking/technologies/extensible-authentication-protocol/network-access).

For more information about troubleshooting certificate issues with NPS, see [Certificate requirements when you use EAP-TLS or PEAP with EAP-TLS](/troubleshoot/windows-server/networking/certificate-requirements-eap-tls-peap)
