---
title: Configure additional HGS nodes
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 227f723b-acb2-42a7-bbe3-44e82f930e35
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 05/10/2017
---

>[!div class="step-by-step"]
[« Configure Https](guarded-fabric-configure-hgs-https.md)
[Verify the configuration »](guarded-fabric-verify-hgs-configuration.md)

# Configure additional HGS nodes

>Applies To: Windows Server 2016

In production environments, HGS should be set up in a high availability cluster to ensure that shielded VMs can be powered on even if an HGS node goes down. For test environments, secondary HGS nodes are not required.

Use one of these methods to add HGS nodes, as best suited for your environment.

|                |                         |                              | 
|----------------|-------------------------|------------------------------|
|New HGS forest  | [Using PFX files](#dedicated-hgs-forest-with-pfx-certificates) | [Using certificate thumbprints](#dedicated-hgs-forest-with-certificate-thumbprints) |
|Existing bastion forest |  [Using PFX files](#existing-bastion-forest-with-pfx-certificates) | [Using certificate thumbprints](#existing-bastion-forest-with-certificate-thumbprints) |

## Prerequisites

Make sure that each additional node: 
- Has the same hardware and software configuration as the primary node 
- Is connected to the same network as the other HGS servers
- Can resolve the other HGS servers by their DNS names

## Dedicated HGS forest with PFX certificates

1. Promote the HGS node to a domain controller
2. Initialize the HGS server

### Promote the HGS node to a domain controller

[!INCLUDE [Promote to a domain controller](../../../includes/guarded-fabric-promote-domain-controller.md)] 

### Initialize the HGS server

[!INCLUDE [Initialize the HGS server](../../../includes/guarded-fabric-initialize-hgs-on-the-node.md)] 

## Dedicated HGS forest with certificate thumbprints
 
1. Promote the HGS node to a domain controller
2. Initialize the HGS server
3. Install the private keys for the certificates

### Promote the HGS node to a domain controller

[!INCLUDE [Promote to a domain controller](../../../includes/guarded-fabric-promote-domain-controller.md)] 

### Initialize the HGS server

[!INCLUDE [Initialize the HGS server](../../../includes/guarded-fabric-initialize-hgs-on-the-node.md)] 

### Install the private keys for the certificates

[!INCLUDE [Install private keys](../../../includes/guarded-fabric-install-private-keys.md)]

## Existing bastion forest with PFX certificates

1. Join the node to the existing domain
2. Grant the machine rights to retrieve gMSA password and run Install-ADServiceAccount
3. Initialize the HGS server

### Join the node to the existing domain

1. Ensure at least one NIC on the node is configured to use the DNS server on your first HGS server.
2. Join the new HGS node to the same domain as your first HGS node. 

### Grant the machine rights to retrieve gMSA password and run Install-ADServiceAccount

[!INCLUDE [Grant the machine rights to retrieve the group MSA](../../../includes/guarded-fabric-grant-machine-rights-to-retrieve-gmsa.md)] 

### Initialize the HGS server

[!INCLUDE [Initialize the HGS server](../../../includes/guarded-fabric-initialize-hgs-on-the-node.md)] 

## Existing bastion forest with certificate thumbprints

1. Join the node to the existing domain
2. Grant the machine rights to retrieve gMSA password and run Install-ADServiceAccount
3. Initialize the HGS server
4. Install the private keys for the certificates

### Join the node to the existing domain

1. Ensure at least one NIC on the node is configured to use the DNS server on your first HGS server.
2. Join the new HGS node to the same domain as your first HGS node. 

### Grant the machine rights to retrieve gMSA password and run Install-ADServiceAccount

[!INCLUDE [Grant the machine rights to retrieve the group MSA](../../../includes/guarded-fabric-grant-machine-rights-to-retrieve-gmsa.md)] 

### Initialize the HGS server

[!INCLUDE [Initialize the HGS server](../../../includes/guarded-fabric-initialize-hgs-on-the-node.md)] 

### Install the private keys for the certificates

[!INCLUDE [Install private keys](../../../includes/guarded-fabric-install-private-keys.md)]

## Configure HGS for HTTPS communications

If you want to secure HGS endpoints with an SSL certificate, you must configure the SSL certificate on this node, as well as every other node in the HGS cluster.
SSL certificates *are not* replicated by HGS and do not need to use the same keys for every node (i.e. you can have different SSL certs for each node).

When requesting an SSL cert, ensure the cluster fully qualified domain name (as shown in the output of `Get-HgsServer`) is either the subject common name of the cert, or included as a subject alternative DNS name.
When you've obtained a certificate from your certificate authority, you can configure HGS to use it with [Set-HgsServer](https://technet.microsoft.com/itpro/powershell/windows/hgsserver/set-hgsserver).

```powershell
$sslPassword = Read-Host -AsSecureString -Prompt "SSL Certificate Password"
Set-HgsServer -Http -Https -HttpsCertificatePath 'C:\temp\HgsSSLCertificate.pfx' -HttpsCertificatePassword $sslPassword
```

If you already installed the certificate into the local certificate store and want to reference it by thumbprint, run the following command instead:

```powershell
Set-HgsServer -Http -Https -HttpsCertificateThumbprint 'A1B2C3D4E5F6...'
```

HGS will always expose both the HTTP and HTTPS ports for communication.
It is unsupported to remove the HTTP binding in IIS, however you can use the Windows Firewall or other network firewall technologies to block communications over port 80.

## Next steps

- [Validate the HGS configuration](guarded-fabric-verify-hgs-configuration.md)
