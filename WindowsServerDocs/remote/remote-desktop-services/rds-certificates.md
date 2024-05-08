---
title: Using certificates in Remote Desktop Services
description: How to create and use authentication certificates for Remote Desktop Services.
ms.author: helohr
ms.date: 05/06/24
ms.topic: conceptual
author: Heidilohr
manager: femila
---
# Using certificates in Remote Desktop Services

Remote Desktop Services (RDS) uses certificates to secure communication between two computers. A certificate is a signature that validates the identity of the server and client when they try to connect to each other.

Certificates prevent man-in-the-middle attacks<!---Elaborate?----> by verifying that the server sending information to the client is authentic. When this trust relationship is set up, the client considers the connection secure and can accept data going to and from the server.

Certificates in Remote Desktop Services need to meet the following requirements:

- You must install the certificate in the personal certificate store on the local computer.

- The certificate has a corresponding private key.

- The Enhanced Key Usage extension has a value of either `Server Authentication` or `Remote Desktop Authentication (1.3.6.1.4.1.311.54.1.2)`.

## Create a Server Authentication certificate

When you control the client computers, the easiest way to get certificates is by using Active Directory Certificate Services<!---Acronym?--->. You can use this service to request and deploy your own certificates, which are trusted by every computer in the Active Directory (AD) domain.

Communicating with computers in your AD domain requires a Server Authentication certificate. You can create this certificate with either the Web Server or the computer authentication template.

To create a Server Authentication certificate from the template:

1. Open CERTSRV.MSC and configure certificates. <!--What does "configure certificates" mean here? Aren't we already configuring the certificate?-->

1. Open the **Certificate Authority**.

1. In the **Details** pane, select the name of the computer you want to create a certificate for to expand the accordion menu.

1. Right-click **Certificate Templates**, then select **Manage** from the drop-down menu to open the Certificate Templates Console.

1. Right-click **Web Server**, then select **Duplicate Template**.

1. On the **General** tab, change the **Template display name** to **Client Server Authentication**.

1. Select **Publish certificate in Active Directory**.

1. On the **Security** tab, under the options for **Domain Computers**, select **Allow Autoenroll**, then select **OK** to save your changes.

1. Close the Certificates Templates console.

1. In the certsrv snap-in<!--Elaborate?-->, right-click **Certificate Templates**, then select **New** > **Certificate Template to Issue**.

1. Select **Client-Server Authentication**, then select **OK**.

1. Validate that the certificate exists in the Certificates MMC<!--Acronym---> snap-in. When you open the new certificate, the General tab of the certificate will list the purpose as Server Authentication.

Certificates created from this template will contain: <!---Images with no context/alt text--->

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

1. On the **Connection Broker**, open **Server Manager**. 

1. Select **Remote Desktop Services** in the navigation pane on the left side of the window.

1. Go to **Tasks** > **Edit Deployment Properties**.

1. In the **Configure the deployment** window, select **Certificates**.

1. Go to **Select existing certificates**, then browse to the location where you saved the certificate you created in the previous section. Look for the file with the .pfx extension.

1. Import the certificate.

1. Optionally, if your clients are all internal to the domain only, you can use one certificate for all roles by generating a wildcard certificate, such as *.CONTOSO.com, and binding it to all roles.

>[!NOTE]
>Even if you have multiple servers in the deployment, Server Manager imports the certificate to all servers. Server Manager places the certificate in the trusted root for each server, then binds the certificate to its respective roles.

### [PowerShell](#tab/powershell)

1. Open an elevated PowerShell window.

1. Run the [Set-RDCertificate](/powershell/module/remotedesktop/set-rdcertificate?view=windowsserver2016-ps&viewFallbackFrom=windowsserver2016) command.

---

You might want to use certificates for the RDS Session Host along with the certificates you configured in Server Manager. For more information about RDS Session Host certificates, see [Remote Desktop listener certificate configurations](/troubleshoot/windows-server/remote/remote-desktop-listener-certificate-configurations).

## Related content

<!---To be filled later.-->