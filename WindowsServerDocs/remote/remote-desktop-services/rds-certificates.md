---
title: Using certificates in Remote Desktop Services
description: How to create and use authentication certificates for Remote Desktop Services.
ms.author: helohr
ms.date: 05/06/24
ms.topic: how-to
author: Heidilohr
---
# Using certificates in Remote Desktop Services

You can use certificates to secure connections to your Remote Desktop Services (RDS) deployment and between RDS server roles. RDS uses Secure Socket Layer (SSL) or Transport Layer Security (TLS) to encrypt connections to the RDS Web, Connection Broker and Gateway role services.

Certificates prevent man-in-the-middle attacks<!---Elaborate?----> by verifying that the server sending information to the client is authentic. When this trust relationship is set up, the client considers the connection secure and can accept data going to and from the server.

## Prerequisites

The following things are required to use certificates in RDS:

- A computer or computers with the RDS role configured. To learn more, see [Install or uninstall roles, role services, or features](../../administration/server-manager/install-or-uninstall-roles-role-services-or-features.md).

- An account with administrator rights or equivalent to the RDS server(s).

- A server certificate that meets the following requirements:

  - Issued for Server Authentication (EKU 1.3.6.1.5.5.7.3.1).

  - Issued by a certificate authority trusted by the RDS server(s) and clients.

  - An export of the certificate with the corresponding private key in .pfx format. To learn more about exporting the private key, see [Export a certificate with its private key](../../identity/ad-cs/export-certificate-private-key.md).

>[!NOTE]
>If you're using Active Directory Certificate Services (AD CS) to issue certificates, you should also create a certificate template. To learn more about creating certificate templates, see [Create a new certificate template](../../identity/ad-cs/manage-certificate-templates.md#create-a-new-certificate-template).

## Create a Server Authentication certificate

You can generate certificates for your environment using Certification Authority. This service enables you to submit and implement your own certificates that are trusted by all computers within the Active Directory (AD) domain.

Communicating with computers in your AD domain requires a Server Authentication certificate. You can create this certificate with either the Web Server or the computer authentication template.

To create a Server Authentication certificate from a template, follow these steps:

1. Select **Start** and enter **certserv.msc**. In the search results, open **Certification Authority**.

1. In the left pane, select the arrow next to the name of the computer you want to create a certificate in to expand it.

1. Right-click **Certificate Templates**, then select **Manage** to open the **Certificate Templates Console**.

1. In the **Certificate Templates Console**, under **Template Display Name**, right-click **Web Server**, then select **Duplicate Template**.

1. On the **General** tab, change the **Template display name** to **Client Server Authentication**.

1. Select the **Publish certificate in Active Directory** checkbox.

1. In the **Request Handling** tab, select the **Allow private key to exported** checkbox.

1. In the **Security** tab under **Group or user names**, select **Domain Computers**. Under **Permissions for Authenticated Users**, select **Allow Autoenroll**, then select **OK**.

1. Close the **Certificates Templates console**.

1. In **Certification Authority**, right-click **Certificate Templates**, then select **New** > **Certificate Template to Issue**.

1. Select **Client Server Authentication**, then select **OK**.

1. Restart your device.

If you want to let users connect externally without being part of your AD domain, you must deploy certificates from a public CA, such as GoDaddy, Verisign, Entrust, Thawte, or DigiCert.

You can also use self-signed certificates for your deployments. However, self-signed certificates aren't trusted certificates by default. We recommend only using self-signed certificates for testing and evaluation environments. While testing, you must add the self-signed certificate to the personal computer store of the client machines to avoid issues or error messages.

## Certificate contents

In RDS, clients connect directly to the broker, which is the entry point of the RDS deployment.

The certificates you deploy must have a subject name or subject alternate name that matches the name of the server the user is trying to connect to.  

In Server Manager, you can configure the certificates for the following four roles:

- RD Connection Broker: Enable Single Sign-on. This certificate is required for server authentication to the Remote Desktop Services deployment.

- RD Connection Broker: Publishing. This certificate is required to sign RDP files to avoid any additional warning messages for the user.

- RD Web Access. This certificate is required to enable RemoteApp and Desktop Connection subscription and server authentication for RD Web Access.

- RD Gateway. This certificate is required for server authentication for connections through RD Gateway.

Example: <!--Image-->

Depending on your deployment topology, you may have to create different certificates to assign to each role.

You may also want to use a single certificate for all four roles. However, this approach works better with single machines, as it can cause problems in deployments with multiple machines. You can instead use a wildcard certificate to cover all servers in your deployment instead.

For Publishing, the certificate needs to contain the FQDN names of all RDS Broker servers in your deployment. If your deployment is in High Availability mode, the certificate must contain all the fully qualified domain name (FQDN) names of the brokers and the domain name services (DNS) name for the RD Connection Broker High Availability cluster.

For Single Sign-On, the certificate requirements are the same as the ones for Publishing. Depending on your topology requirements, you can sometimes use the same certificate for both Single Sign-On and Publishing.

The certificate for RDWeb needs to contain the FQDN of the URL based on the name users connect to. If your users connect externally, this name must be an external name that matches the domain your users are trying to connect to. If your users connect internally to RDWeb, the name needs to match the internal name.  

For RD Gateway, the certificate needs to contain the FQDN of the gateway server. If the gateway is in High Availability mode, the certificate will need to contain the FQDN of all RD Gateway machines and the Load Balancer virtual name.

For example, imagine a Remote Desktop High Availability deployment with the following computers:

| Computer name | Description |
|---|---|
| RDSH.CONTOSO.COM  | Session Host with RemoteApp configured |
| RDSH2.CONTOSO.COM  | Session Host with RemoteApp configured |
| RDVH1.CONTOSO.COM | Virtualization host with VDI VMs configured  |
| RDVH2.CONTOSO.COM  | Virtualization host with VDI VMs configured  |
| RDCB1.CONTOSO.COM  | Connection broker |
| RDCB2.CONTOSO.COM  | Connection broker |
| RDWEB1.CONTOSO.COM  | RDWeb and Gateway server  |
| RDWEB2.CONTOSO.COM  | RDWeb and Gateway server  |

This example deployment contains a DNS Round Robin or load balancer in front of the brokers that listens on RDCBHA.CONTOSO.COM. There's a second load balancer in front of the RDWeb1 and RDWeb2 machines that listens on RDWEB.CONTOSO.COM.

In this example, RDWEB1 and RDWEB2 both have RDWEB and RD Gateway roles installed, so you shouldn't configure different certificates for these roles. You must use the same certificate for the RD Web Access and RD Gateway role.

In this example scenario, you can create the following certificates:

One certificate for RD Connection Broker Certificate for both Publishing and Single Sign On: 

```text
Type: Server Authentication
Name: RDCBHA.CONTOSO.COM
CN: RDCBHA.CONTOSO.COM
SAN (DNS Name): RDCB1.CONTOSO.COM; RDCB2.CONTOSO.COM; RDCBHA.CONTOSO.COM.  
```

One certificate for both RD Web Access and RD Gateway:

```text
Type: Server Authentication
Name: RDWEB.CONTOSO.COM
CN: RDWEB.CONTOSO.COM
SAN (DNS Name):  RDWEB.CONTOSO.COM; RDWEB1.CONTOSO.COM; RDWEB2.CONTOSO.COM
```

For a simpler scenario, you may want to choose a wildcard certificate to assign to all roles in the deployment. The following example certificate is based on the information in our example deployment:

```text
Type: Server Authentication
Name: *.CONTOSO.COM
CN: *.CONTOSO.COM
SAN (DNS Name):  *.CONTOSO.COM
```

>[!NOTE]
>Even with a wildcard certificate, you might run into problems in the following scenario if you have external users that access the deployment:
>
>```text
>External name: RDWEB.CONTOSO.com 
>Internal name: RDWEB.CONTOSO.local
>```

If you have a certificate with RDWEB.CONTOSO.COM in the name, certificate error messages appear. The certificate is supposed to validate a server with the FQDN of RDWEB.CONTOSO.COM, but your public firewall or router during port forwarding changed the server name to RDWEB.CONTOSO.local, causing a mismatch.

You can resolve this issue by getting a certificate from a public certificate authority (CA) with the external name (RDWEB.CONTOSO.COM) and binding it to the RD Web Access and RD Gateway roles. These two roles are the only ones exposed to the internet. For the RD Connection Broker: Publishing and RD Connection Broker: Enable Single Sign-On roles, you can use an internal certificate with the DOMAIN.local name instead.

The RD Gateway and Remote Desktop Client provides external users with a secure connection to the deployment. Once connected to the deployment, the internal certificate with the .local name take care of RemoteApp signing (publishing) and Single Sign-On.

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

1. Open an elevated PowerShell window and run the following command:

  ```powershell
  Set-RDCertificate -Role RDWebAccess -ImportPath "<Path to PFX file>" -Password (ConvertTo-SecureString -String "<Certificate Password>" -AsPlainText -Force)
  ```
  
---

You might want to use certificates for the RDS Session Host along with the certificates you configured in Server Manager. For more information about RDS Session Host certificates, see [Remote Desktop listener certificate configurations](/troubleshoot/windows-server/remote/remote-desktop-listener-certificate-configurations).

## Related content

<!---To be filled later.-->