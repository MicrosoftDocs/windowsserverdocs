---
title: Configure certificates for LDAP over SSL in Active Directory Domain Services
description: Learn how to create and install SSL/TLS certificates for LDAP over SSL (LDAPS) on domain controllers using Microsoft or third-party certification authorities.
author: robinharwood
ms.author: roharwoo
ms.service: windows-server
ms.topic: how-to
ms.date: 12/18/2025
ai-usage: ai-assisted
#CustomerIntent: As a domain administrator, I want to configure LDAP over SSL certificates so that LDAP communications with my domain controllers are encrypted and secure.
---

# Configure certificates for LDAP over SSL in Active Directory Domain Services

LDAP over SSL (LDAPS) encrypts LDAP communications between clients and domain controllers using SSL/TLS certificates. This article shows you how to create, install, and verify SSL certificates for LDAPS on domain controllers using either Microsoft certification authorities or third-party certificate providers.

By default, LDAP traffic transmits unencrypted over port 389. LDAPS establishes an encrypted SSL/TLS tunnel over port 636 (or port 3269 for global catalog traffic), which protects authentication credentials and directory queries from interception. When you install a properly formatted certificate on your domain controller, you automatically enable the LDAP service to accept SSL connections without any extra configuration. For more information about LDAP signing and channel binding security features, see [LDAP signing for Active Directory Domain Services](ldap-signing.md).

## Prerequisites

Before configuring LDAPS certificates, make sure you have:

- Administrative privileges on the domain controller where you install the certificate

- Access to a certification authority (CA):

  - Microsoft Enterprise Certificate Authority with published certificate templates, or

  - Third-party certificate provider such as DigiCert, Let's Encrypt, or Verisign

- Firewall rules configured to allow inbound connections on TCP port 636 for LDAPS (or TCP port 3269 for global catalog LDAPS traffic)

LDAPS certificates must meet the following requirements:

- **Enhanced Key Usage extension**: Must include Server Authentication (1.3.6.1.5.5.7.3.1) object identifier

- **Subject or Subject Alternative Name**: Must contain the domain controller's Active Directory FQDN (for example, dc01.contoso.com) in either the Common Name (CN) field or as a DNS entry in the Subject Alternative Name extension

- **Private key**: Must be present in the Local Computer's store, correctly associated with the certificate, and must not have strong private key protection enabled

- **Cryptographic provider**: Must use the Schannel cryptographic service provider (CSP) to generate the key

- **Trust chain**: Must be issued by a CA that both the domain controller and LDAPS clients trust

You establish trust between domain controllers and clients by configuring them to trust the root CA to which the issuing CA chains.

## Create the certificate request

You can create and install LDAPS certificates using either a Microsoft Enterprise CA or a third-party CA. You must install the certificate in one of the following locations:

- **Local Computer's Personal certificate store**
- **NT Directory Services (NTDS) certificate store**

Active Directory preferentially checks the NTDS store first. Using the NTDS store provides several advantages:

- **Preferential selection**: Active Directory checks the NTDS store first, making it easier to control which certificate is used when multiple valid certificates exist in the Local Computer's store.
- **Automatic detection**: Active Directory detects new certificates dropped into the NTDS store and updates SSL certificates without requiring a domain controller restart.
- **Manual refresh capability**: You can trigger certificate updates by using the renewServerCertificate rootDSE operation without restarting the domain controller.

To use the NTDS certificate store, import certificates into the Personal certificate store for the NTDS service instead of the Local Computer's Personal store.

### [Microsoft Enterprise CA](#tab/microsoft-enterprise-ca)

If your domain controller can access a Microsoft Enterprise Certificate Authority, you can request a certificate using the built-in Domain Controller certificate template. For more information about certificate templates, see [Manage certificate templates](../ad-cs/manage-certificate-templates.md). To request and install the certificate, follow these steps:

1. On the domain controller, press **Windows key + R**, type **certlm.msc**, and press **Enter**.

1. Expand **Personal**, right-click **Certificates**, and select **All Tasks** > **Request New Certificate**.

1. In the Certificate Enrollment wizard, select **Next**.

1. Select **Active Directory Enrollment Policy**, and select **Next**.

1. Select the **Domain Controller** certificate template checkbox.

1. Select **Enroll**.

The process automatically installs the certificate in the Local Computer's Personal certificate store. The Domain Controller template comes preconfigured with the correct properties for LDAPS, including:

- Server Authentication enhanced key usage
- The domain controller's FQDN in the Subject Alternative Name
- Automatic renewal before expiration

After the enrollment finishes, restart the domain controller to enable LDAPS.

### [Third-party CA](#tab/third-party-ca)

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

   Some third-party certification authorities require additional information in the Subject parameter, such as email address (E), organizational unit (OU), organization (O), locality, or city (L), state or province (S), and country or region (C). You can append this information to the Subject name. For example:

   ```ini
   Subject="E=admin@contoso.com, CN=dc01.contoso.com, OU=Servers, O=Contoso, L=Redmond, S=Washington, C=US"
   ```

1. Open an elevated command prompt and go to the folder containing **request.inf**.

1. Generate the certificate request file by running:

   ```cmd
   certreq -new request.inf request.req
   ```

   This command creates a new file named **request.req** containing the base64-encoded certificate request.

1. Submit **request.req** to your certification authority:
   - For Microsoft Enterprise CA: Use the CA's web enrollment interface or submit through the Certification Authority console.
   - For third-party CA: Follow your provider's certificate request submission process.

#### Install the certificate

After receiving the issued certificate from your certification authority, install it on the domain controller.

1. Save the issued certificate as **certnew.cer** in the same folder as your request file. The certificate must be base64-encoded. Some third-party CAs return certificates as base64-encoded text in email messages that you can copy into a new .cer file.

1. Open an elevated command prompt and go to the folder containing **certnew.cer**.

1. Install the certificate by running:

   ```cmd
   certreq -accept certnew.cer
   ```

1. Verify the certificate installation:

   1. Press **Windows key + R**, type **mmc.exe**, and press **Enter**.
   1. Select **File** > **Add/Remove Snap-in**.
   1. Select **Certificates**, select **Add**, choose **Computer account**, select **Next**, choose **Local computer**, and select **Finish**.
   1. Select **OK** to close the Add/Remove Snap-in dialog.
   1. Expand **Certificates (Local Computer)** > **Personal** > **Certificates**.
   1. Locate the newly installed certificate. The **Intended Purposes** column should display **Server Authentication**, and the **Issued To** field should show the computer's fully qualified domain name.

1. To enable LDAPS restart the domain controller.

---

## Verify LDAPS connectivity

After you install the certificate and restart the domain controller, verify that LDAPS connections work correctly.

1. On the domain controller or a domain-joined client computer, open an elevated command prompt.

1. Start the Active Directory Administration Tool by running:

   ```cmd
   ldp.exe
   ```

1. In LDP, select **Connection** > **Connect**.

1. In the **Connect** dialog:
   - **Server**: Type the name of the domain controller.
   - **Port**: Type **636**.
   - Select the **SSL** checkbox.

1. Select **OK**.

When the connection succeeds, RootDSE information appears in the right pane, confirming LDAPS is functioning. If the connection fails, verify the certificate properties match the requirements and check that the domain controller was restarted after certificate installation.

## Next steps

> [!div class="nextstepaction"]
> [Manage LDAP signing using Group Policy](manage-ldap-signing-group-policy.md)
