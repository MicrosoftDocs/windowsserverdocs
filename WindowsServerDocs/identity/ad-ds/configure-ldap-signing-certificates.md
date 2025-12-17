---
title: Configure certificates for LDAP over SSL in Active Directory Domain Services
description: Learn how to create and install SSL/TLS certificates for LDAP over SSL (LDAPS) on domain controllers using Microsoft or third-party certification authorities.
author: robinharwood
ms.author: roharwoo
ms.service: windows-server
ms.topic: how-to
ms.date: 12/17/2025

#CustomerIntent: As a domain administrator, I want to configure LDAP over SSL certificates so that LDAP communications with my domain controllers are encrypted and secure.
---

# Configure certificates for LDAP over SSL in Active Directory Domain Services

LDAP over SSL (LDAPS) encrypts LDAP communications between clients and domain controllers using SSL/TLS certificates. This article shows you how to create, install, and verify SSL certificates for LDAPS on domain controllers using either Microsoft certification authorities or third-party certificate providers.

By default, LDAP traffic transmits unencrypted over port 389. LDAPS establishes an encrypted SSL/TLS tunnel over port 636 (or port 3269 for global catalog traffic), protecting authentication credentials and directory queries from interception. Installing a properly formatted certificate on your domain controller automatically enables the LDAP service to accept SSL connections without additional configuration. To learn more about LDAP signing and channel binding security features, see [LDAP signing for Active Directory Domain Services](ldap-signing.md).

## Prerequisites

Before configuring LDAPS certificates, ensure you have:

- Administrative privileges on the domain controller where you'll install the certificate

- Access to a certification authority (CA):

  - Microsoft Enterprise Certificate Authority with published certificate templates, or

  - Third-party certificate provider (such as DigiCert, Let's Encrypt, or Verisign)

- The Active Directory fully qualified domain name (FQDN) of each domain controller requiring LDAPS

- The root CA certificate installed in the Trusted Root Certification Authorities store on all domain controllers and client computers that will establish LDAPS connections

- Firewall rules configured to allow inbound connections on TCP port 636 for LDAPS (or TCP port 3269 for global catalog LDAPS traffic)

### Understand certificate requirements

LDAPS certificates must meet specific technical requirements to function correctly with Active Directory Domain Services.

#### Certificate store location

The certificate must be installed in one of the following locations:

- **Local Computer's Personal certificate store** (programmatically known as the MY store): Supported on all Windows Server versions
- **NT Directory Services (NTDS) certificate store** (Windows Server 2008 and later): Recommended for modern deployments

Active Directory preferentially checks the NTDS store first, making it the recommended option for Windows Server 2008 and later. Using the NTDS store provides several advantages:

- **Preferential selection**: Active Directory checks the NTDS store first, making it easier to control which certificate is used when multiple valid certificates exist in the Local Computer's store
- **Automatic detection**: Active Directory detects new certificates dropped into the NTDS store and updates SSL certificates without requiring a domain controller restart
- **Manual refresh capability**: You can trigger certificate updates using the renewServerCertificate rootDSE operation without restarting the domain controller

To use the NTDS certificate store, install certificates into the Personal certificate store for the NTDS service instead of the Local Computer's Personal store.

#### Required certificate properties

Regardless of which certificate store you use, certificates must meet these requirements:

- **Enhanced Key Usage extension**: Must include Server Authentication (1.3.6.1.5.5.7.3.1) object identifier
- **Subject or Subject Alternative Name**: Must contain the domain controller's Active Directory FQDN (for example, dc01.contoso.com) in either the Common Name (CN) field or as a DNS entry in the Subject Alternative Name extension
- **Private key**: Must be present in the Local Computer's store, correctly associated with the certificate, and must not have strong private key protection enabled
- **Cryptographic provider**: Must use the Schannel cryptographic service provider (CSP) to generate the key
- **Trust chain**: Must be issued by a CA that both the domain controller and LDAPS clients trust

Domain controllers and clients establish trust by configuring them to trust the root CA to which the issuing CA chains.

## Create the certificate request

### [Microsoft Enterprise CA](#tab/microsoft_enterprise_ca)

If your domain controller has access to a Microsoft Enterprise Certificate Authority, you can request a certificate using the built-in Domain Controller certificate template. To learn more about certificate templates, see [Manage certificate templates](../ad-cs/manage-certificate-templates.md).

1. On the domain controller, press **Windows key + R**, type **certlm.msc**, and press **Enter**.

2. Expand **Personal**, then right-click **Certificates** and select **All Tasks** > **Request New Certificate**.

3. In the Certificate Enrollment wizard, select **Next**.

4. Select **Active Directory Enrollment Policy**, then select **Next**.

5. Select the **Domain Controller** certificate template checkbox.

6. Select **Enroll**.

The certificate is automatically installed in the Local Computer's Personal certificate store. The Domain Controller template is preconfigured with the correct properties for LDAPS, including:

- Server Authentication enhanced key usage
- The domain controller's FQDN in the Subject Alternative Name
- Automatic renewal before expiration

After enrollment completes, restart the domain controller to enable LDAPS.

### [Third-party CA](#tab/third_party_ca)

Use the Certreq.exe utility to create a certificate request that meets LDAPS requirements.

1. Create a new text file named **request.inf** with the following content, replacing `<DC fqdn>` with your domain controller's fully qualified domain name:

   ```ini
   ;----------------- request.inf -----------------
   
   [Version]
   Signature="$Windows NT$"
   
   [NewRequest]
   Subject = "CN=<DC fqdn>" ; replace with the FQDN of the DC
   KeySpec = 1
   KeyLength = 2048 ; Can be 2048, 4096, 8192, or 16384
   Exportable = TRUE
   MachineKeySet = TRUE
   SMIME = False
   PrivateKeyArchive = FALSE
   UserProtected = FALSE
   UseExistingKeySet = FALSE
   ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
   ProviderType = 12
   RequestType = PKCS10
   KeyUsage = 0xa0
   
   [EnhancedKeyUsageExtension]
   OID=1.3.6.1.5.5.7.3.1 ; this is for Server Authentication
   
   ;-----------------------------------------------
   ```

   Some third-party certification authorities require additional information in the Subject parameter, such as email address (E), organizational unit (OU), organization (O), locality or city (L), state or province (S), and country or region (C). You can append this information to the Subject name. For example:

   ```ini
   Subject="E=admin@contoso.com, CN=dc01.contoso.com, OU=Servers, O=Contoso, L=Redmond, S=Washington, C=US"
   ```

2. Open an elevated command prompt and navigate to the folder containing **request.inf**.

3. Generate the certificate request file by running:

   ```cmd
   certreq -new request.inf request.req
   ```

   This command creates a new file named **request.req** containing the base64-encoded certificate request.

4. Submit **request.req** to your certification authority:
   - For Microsoft Enterprise CA: Use the CA's web enrollment interface or submit through the Certification Authority console
   - For third-party CA: Follow your provider's certificate request submission process

### Install the certificate

After receiving the issued certificate from your certification authority, install it on the domain controller.

1. Save the issued certificate as **certnew.cer** in the same folder as your request file. The certificate must be base64-encoded. Some third-party CAs return certificates as base64-encoded text in email messages that you can copy into a new .cer file.

2. Open an elevated command prompt and navigate to the folder containing **certnew.cer**.

3. Install the certificate by running:

   ```cmd
   certreq -accept certnew.cer
   ```

4. Verify the certificate installation:

   1. Press **Windows key + R**, type **mmc.exe**, and press **Enter**.
   2. Select **File** > **Add/Remove Snap-in**.
   3. Select **Certificates**, select **Add**, choose **Computer account**, select **Next**, choose **Local computer**, and select **Finish**.
   4. Select **OK** to close the Add/Remove Snap-in dialog.
   5. Expand **Certificates (Local Computer)** > **Personal** > **Certificates**.
   6. Locate the newly installed certificate. The **Intended Purposes** column should display **Server Authentication**, and the **Issued To** field should show the computer's fully qualified domain name.

5. Restart the domain controller to enable LDAPS.

---

## Verify LDAPS connectivity

After installing the certificate and restarting the domain controller, verify that LDAPS connections work correctly.

1. On the domain controller or a domain-joined client computer, open an elevated command prompt.

2. Start the Active Directory Administration Tool by running:

   ```cmd
   ldp.exe
   ```

3. In LDP, select **Connection** > **Connect**.

4. In the **Connect** dialog:
   - **Server**: Type the name of the domain controller
   - **Port**: Type **636**
   - Select the **SSL** checkbox

5. Select **OK**.

When the connection succeeds, RootDSE information appears in the right pane, confirming LDAPS is functioning. If the connection fails, verify the certificate properties match the requirements and check that the domain controller was restarted after certificate installation.

