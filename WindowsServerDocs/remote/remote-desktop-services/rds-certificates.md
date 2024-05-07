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

Remote Desktop Services uses certificates to sign the communication between two computers. When a client connects to a server, the identity of the server and the information from the client is validated using certificates. 

Using certificates for authentication prevents possible man-in-the-middle attacks. When a communication channel is set up between the client and the server, the authority that generates the certificates vouches that the server is authentic. As long as the client trusts the server it is communicating with, the data being sent to and from the server is considered secure.

Certificates in Remote Desktop Services need to meet the following requirements: 

- The certificate is installed in the local computer’s “Personal” certificate store. 

- The certificate has a corresponding private key. 

- The Enhanced Key Usage extension has a value of either “Server Authentication” or “Remote Desktop Authentication” (1.3.6.1.4.1.311.54.1.2).

## Create a Server Authentication certificate 

The easiest way to get certificates, if you control the client computers, is by using Active Directory Certificate Services. You can request and deploy your own certificates, and they will be trusted by every computer in the AD domain. 

As the name suggests, a Server Authentication certificate is required. You can use either the Web Server or the computer Authentication template to generate this certificate, if necessary. 

To create the Server Authentication certificate from the template: 

1. Open CERTSRV.MSC and configure certificates. 

1. Open the Certificate Authority. 

1. In the Details pane, expand the computer name. 

1. Right-click Certificate Templates, and then click Manage. This opens the Certificate Templates Console. Right-click Web Server and then click Duplicate Template. 

1. On the General tab, change the Template display name to Client Server Authentication, and select Publish certificate in Active Directory. 

1. On the Security tab, select Allow Autoenroll next to Domain Computers. Click OK, and then close the Certificates Templates console. 

1. In the certsrv snap-in right-click Certificate Templates, and then click New > Certificate Template to Issue. 

1. Select Client-Server Authentication, and then click OK. You can validate that the certificate was created in the Certificates MMC snap-in. When you open the new certificate, the General tab of the certificate will list the purpose as “Server Authentication.” 

Certificates created from this template will contain: <!---Images with no context/alt text--->

If you are going to let users to connect externally, and they are not part of your AD domain, you need to deploy certificates from a public CA, such as GoDaddy, Verisign, Entrust, Thawte, or DigiCert. Refer to their documentation on the type of certificates they can offer. 

You can also use self-signed certificates for your deployments. But keep in mind that, by default, the self-signed certificate is not a trusted certificate, and self-signed certificates are recommended only for testing and evaluation purposes. When using this, you will have to add the self-signed certificates to the personal computer store of the client machines to avoid warnings or errors. 

## Certificate contents 

In RDS, clients connect directly to the broker which is now the entry point of the RDS deployment.  

The certificates you deploy need to have a subject name or subject alternate name that matches the name of the server that the user is connecting to.  

In Server Manager, we can configure the certificates for 4 components: 

- RD Connection Broker – Enable Single Sign-on  (This certificate is required for server authentication to the Remote Desktop Services deployment) 

- RD Connection Broker – Publishing  (This certificate is required to sign RDP files to avoid any additional warning messages for the user) 

- RD Web Access  (This certificate is required to enable RemoteApp and Desktop Connection subscription and server authentication for RD Web Access) 

- RD Gateway  (This certificate is required for server authentication for connections through RD Gateway) 

Example: <!--Image-->

If you are going to let users to connect externally, and they are not part of your AD domain, you need to deploy certificates from a public CA, such as GoDaddy, Verisign, Entrust, Thawte, or DigiCert. Refer to their documentation on the type of certificates they can offer. 

You can also use self-signed certificates for your deployments. But keep in mind that, by default, the self-signed certificate is not a trusted certificate, and self-signed certificates are recommended only for testing and evaluation purposes. When using this, you will have to add the self-signed certificates to the personal computer store of the client machines to avoid warnings or errors. 

Depending on your deployment topology, you may have to create different certificates to be assigned for each of the roles.  

You may also want to use a single certificate for all. If you have a deployment with many machines, this approach may be problematic. Instead, you may want to get a wildcard certificate to cover all the servers in the deployment. 

For Publishing, the certificate needs to contain the FQDN names of all the RDS Broker servers in the deployment. If we are in High Availability mode, the certificate will need to contain all the FQDN names of the brokers, in addition to the DNS name for the RD Connection Broker High Availability cluster. 

For Single Sign On, the Certificates requirements are the same as for Publishing. You may use the same certificate depending on your topology. 

The certificate for RDWeb needs to contain the FQDN of the URL, based on the name the users connect to. If you have users connecting externally, this needs to be an external name (it needs to match what they connect to). If you have users connecting internally to RDWeb, the name needs to match the internal name.  

For RD Gateway, the certificate needs to contain the FQDN of the gateway server. If the gateway is in High Availability mode, the certificate will need to contain the FQDN of all the RD Gateway machines in addition to the Load Balancer virtual name. 

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

We have a DNS Round Robin or a Load balancer in front of the brokers which is listening on RDCBHA.CONTOSO.COM. 

We have a Load Balancer in front of the RDWeb1 and RDWeb2 machines which listens on RDWEB.CONTOSO.COM. 

As RDWEB1 and RDWEB2 both have RDWEB and RD Gateway roles installed, you should not configure different certificates for these roles. You will have to use the same certificate for the RD Web Access and RD Gateway role. 

In this situation, you can create these certificates. 

1 certificate for RD Connection Broker Certificate for both Publishing and Single Sign On: 

Type: Server Authentication 

Name: RDCBHA.CONTOSO.COM 

CN: RDCBHA.CONTOSO.COM 

SAN (DNS Name): RDCB1.CONTOSO.COM; RDCB2.CONTOSO.COM; RDCBHA.CONTOSO.COM.  

1 Certificate for both RD Web Access and RD Gateway: 

Type: Server Authentication 

Name: RDWEB.CONTOSO.COM 

CN: RDWEB.CONTOSO.COM 

SAN (DNS Name):  RDWEB.CONTOSO.COM; RDWEB1.CONTOSO.COM; RDWEB2.CONTOSO.COM 

For a simpler scenario, you may want to choose a wildcard certificate and use this certificate for all the roles. For our example, it would contain: 

Type: Server Authentication 

Name: *.CONTOSO.COM 

CN: *.CONTOSO.COM 

SAN (DNS Name):  *.CONTOSO.COM 

Note: Even with a wildcard certificate, you might run into problems in the following scenario if you have external users that access the deployment: 

External name: RDWEB.CONTOSO.com 

Internal name: RDWEB.CONTOSO.local 

If you have a certificate with RDWEB.CONTOSO.COM in the name, you will see certificate errors. This is because the certificate is supposed to validate a server with the FQDN of “RDWEB.CONTOSO.COM,” but your server name is “RDWEB.CONTOSO.local.” (Changing the .com to .local occurs at your public firewall or router using port forwarding.) 

In this case, you can get a certificate from a public CA with the external name (RDWEB.CONTOSO.COM) and bind it to the RD Web Access and RD Gateway roles (These are the only roles that are exposed to the Internet). For the RD Connection Broker – Publishing and RD Connection Broker – Enable Single Sign On roles, you can use an internal certificate with the DOMAIN.local name on it.  

The RD Gateway and Remote Desktop Client provides external users with a secure connection to the deployment. Once connected to the deployment, the internal certificate with the ‘.local’ name will take care of RemoteApp signing (publishing) and Single Sign On. 

## Selecting which certificate to use 

Now that you have created your certificates and understand their contents, you need to configure Remote Desktop to use those certificates. 

1. On the Connection Broker, open the Server Manager. Click Remote Desktop Services in the left navigation pane. 

1. Click Tasks > Edit Deployment Properties. 

1. In the Configure the deployment window, click Certificates. 

1. Click Select existing certificates, and then browse to the location where you saved the certificate you created previously. Look for the file with the .pfx extension. 

1. Import the certificate. 

1. You can use a single certificate for all the roles if your clients are internal to the domain only, by generating a wildcard certificate (*.CONTOSO.com) and binding it to all roles. 

>[!NOTE]
>Even if you have multiple servers in the deployment, Server Manager will import the certificate to all servers, place the certificate in the trusted root for each server, and then bind the certificate to the respective roles. 

You can also use the Set-RDCertificate Powershell CmdLet to set the certificates for the RDS deployment roles: 

[Set-RDCertificate](/powershell/module/remotedesktop/set-rdcertificate?view=windowsserver2016-ps&viewFallbackFrom=windowsserver2016)

Note: in addition to the certificates configured in Server Manager, you may want to use certificates for the RDS Session Host. For this, please refer to this documentation: 

[Remote Desktop listener certificate configurations](/troubleshoot/windows-server/remote/remote-desktop-listener-certificate-configurations)