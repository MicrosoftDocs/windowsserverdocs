---
title: Use certificates in Remote Desktop Services
description: How to create and use authentication certificates for Remote Desktop Services.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 07/14/2025
---

# Use certificates in Remote Desktop Services

You can use certificates to secure connections to your Remote Desktop Services (RDS) deployment and between RDS server roles. RDS uses Secure Socket Layer (SSL) or Transport Layer Security (TLS) to encrypt connections to the RDS Web, Connection Broker, and Gateway role services.

Certificates prevent man-in-the-middle attacks, where a bad actor intercepts traffic between the Remote Desktop Protocol (RDP) server and client to steal confidential information or deny access to credentials, by verifying that the server sending information to the client is authentic. When this trust relationship is set up, the client considers the connection secure and can accept data going to and from the server.

## Prerequisites

The following are required to use certificates in RDS:

- A computer or computers where the RDS role is configured. To learn more, see [Install or uninstall roles, role services, or features](../../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md).

- An account with administrator rights or equivalent to one or more RDS servers.

- A server certificate that meets the following requirements:

  - Issued for Server Authentication (EKU 1.3.6.1.5.5.7.3.1).

  - Issued for Enhanced Key Usage (OID 2.5.29.37).

  - Issued for Key Usage (OID 2.5.29.15).

  - Issued by a certificate authority trusted by one or more RDS servers and clients.

  - Issued with an exportable private key.

  - An export of the certificate with the corresponding private key in `.pfx` format. To learn more about exporting the private key, see [Export a certificate with its private key](../../identity/ad-cs/export-certificate-private-key.md).

>[!NOTE]
>If you're using Active Directory Certificate Services (AD CS) to issue certificates, you can also create a certificate template or duplicate the Web Server certificate template. To learn more about creating certificate templates, see [Create a new certificate template](../../identity/ad-cs/manage-certificate-templates.md#create-a-new-certificate-template).

## Configure Remote Desktop to use certificates

Now that you created your certificates and understand their contents, you must configure Remote Desktop to use those certificates.

To configure Remote Desktop to use specific certificates:

### [GUI](#tab/gui)

1. In **Server Manager**, on the left pane, select **Remote Desktop Services**.

1. On the **Overview** tab, under **Deployment Overview**, select **TASKS**, then select **Edit Deployment Properties**.

1. In the **Configure the deployment** window, select **Certificates**.

1. Choose **Select existing certificate**, select **Browse**, locate your certificate file in `.pfx` format, then select **Open**.

1. In the **Password** field, enter the password for the certificate you created, then select **OK**.

1. Select the **Allow the certificate to be added to the Trusted Root Certification Authorities certificate store on the destination computers** checkbox, then select **OK**.

1. Select **OK** to finalize your deployment.

>[!NOTE]
>Even if you have multiple servers in the deployment, Server Manager imports the certificate to all servers. Server Manager places the certificate in the trusted root for each server, then binds the certificate to its respective roles.

### [PowerShell](#tab/powershell)

1. Sign on to a computer with the RDS Remote Server Administration Tools (RSAT) installed and the RD role you wish to configure.

1. Open an elevated PowerShell session.

1. Run the following script for the RD certificate you plan to use for your session where it prompts you for the password and location for the exported certificate. Replace `<PathToPFXFile>` with the full file path including the `.pfx` file.

  ```powershell
  $password = Read-Host -AsSecureString -Prompt "Enter Password"
  $parameters = @{
    Role        = "RDWebAccess"
    Password    = $password
    ImportPath  = "PathToPFXFile"
  }
  Set-RDCertificate @parameters
  ```

To set the certificate based on a specific **-Role** type, see [Set-RDCertificate](/powershell/module/rdmgmt/set-rdcertificate).

To view all of the configured RDS certificates, run the following command:

```powershell
Get-RDCertificate
```

---

You might want to use certificates for the RDS Session Host along with the certificates you configured in Server Manager. For more information about RDS Session Host certificates, see [Remote Desktop listener certificate configurations](/troubleshoot/windows-server/remote/remote-desktop-listener-certificate-configurations).

## Related content

- [Remote Desktop Services - Secure data storage with UPDs](rds-plan-secure-data-storage.md)

- [Remote Desktop Services - Multifactor Authentication](rds-plan-mfa.md)

