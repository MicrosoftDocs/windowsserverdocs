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

# Configure additional HGS nodes

>Applies To: Windows Server 2016

In production environments, HGS should be set up in a high availability cluster to ensure that shielded VMs can be powered on even if an HGS node goes down. For test environments, secondary HGS nodes are not required.

The following steps will add a node to the HGS cluster.

## Prerequisites

Before you can add an additional node to your HGS cluster, ensure the following prerequisites are met:

1. The additional node has the same hardware and software configuration as the primary node. This is a failover clustering best practice.

2. The additional node is connected to the same network as the other HGS servers, and can resolve the other HGS servers by their DNS names.

3. The Host Guardian Service role is installed on the machine. To install the role, run the following command in an elevated PowerShell console:

    ```powershell
    Install-WindowsFeature -Name HostGuardianServiceRole -IncludeManagementTools -Restart
    ```

## Join the node to the HGS domain

Your new HGS node must be joined to the same domain as your first HGS node.
If you used the `Install-HgsServer` command to set up a new domain for your first HGS node, follow the steps under [Promote to a domain controller in the HGS forest](#promote-to-a-domain-controller-in-the-hgs-forest).
If you joined the first HGS node to an existing bastion forest, skip to [Join an existing bastion forest](#join-an-existing-bastion-forest).

### Promote to a domain controller in the HGS forest

If you set up a new forest for your Host Guardian Service using `Install-HgsServer` on the primary node, you must promote your additional HGS servers to domain controllers using the same command.

1.  Ensure at least one NIC on the node is configured to use the DNS server on your first HGS server for name resolution. This is necessary for the machine to resolve and join the domain.

2.  Run [Install-HgsServer](https://technet.microsoft.com/en-us/itpro/powershell/windows/hgsserver/install-hgsserver) to join the domain and promote the node to a domain controller.

    ```powershell
    $adSafeModePassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

    $cred = Get-Credential 'relecloud\Administrator'

    Install-HgsServer -HgsDomainName 'relecloud.com' -HgsDomainCredential $cred -SafeModeAdministratorPassword $adSafeModePassword -Restart
    ```

3.  When the server reboots, log in with a domain administrator account and follow the steps to [Initialize HGS on the node](#initialize-hgs-on-the-node).

### Join an existing bastion forest

If you joined your first Host Guardian Service node to an existing bastion forest, **do not run** `Install-HgsServer`.
It is unsupported to make HGS a domain controller when you are joining an existing bastion forest (note that the Active Directory Domain Services role will be installed, it will just remain unconfigured).

1.  Ensure at least one NIC on the node is configured to use the DNS server for your existing domain. This is necessary for the machine to resolve and join the domain.

2.  Join the computer to a domain using Server Manager or [Add-Computer](https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.management/add-computer).

3.  Reboot the computer to complete the domain join process.

4.  Have a directory services admin add the computer account for your new node to the security group containing all of your HGS servers that is permissioned to allow those servers to use the HGS gMSA account.

5.  Reboot the new node to obtain a new Kerberos ticket that includes the computer's membership in that security group. After the reboot completes, sign in with a domain identity that belongs to the local administrators group on the computer.

6.  Install the HGS group managed service account on the node.

    ```powershell
    Install-ADServiceAccount -Identity <HGSgMSAAccount>
    ```

7.  Continue installation by following the steps to [Initialize HGS on the node](#initialize-hgs-on-the-node).


## Initialize HGS on the node

With HGS joined to the domain, sign in with a domain account that has local administrator privileges.
Open an elevated PowerShell prompt and run the following command to join the existing HGS cluster.

```powershell
Initialize-HgsServer -HgsServerIPAddress <IP address of first HGS Server>
```

It will take up to 10 minutes for the encryption and signing certificates from the first HGS server to replicate to this node.
If you did not provide a PFX file for either the encryption or signing certificates on the first HGS server, only the public key will be replicated to this server.
You will need to install the private key by importing a PFX file containing the private key into the local certificate store or, in the case of HSM-backed keys, configuring the Key Storage Provider and associating it with your certificates per your HSM manufacturer's instructions.

## Configure HGS for HTTPS communications

If you want to secure HGS endpoints with an SSL certificate, you must configure the SSL certificate on this node, as well as every other node in the HGS cluster.
SSL certificates *are not* replicated by HGS and do not need to use the same keys for every node (i.e. you can have different SSL certs for each node).

When requesting an SSL cert, ensure the cluster fully qualified domain name (as shown in the output of `Get-HgsServer`) is either the subject common name of the cert, or included as a subject alternative DNS name.
When you've obtained a certificate from your certificate authority, you can configure HGS to use it with [Set-HgsServer](https://technet.microsoft.com/en-us/itpro/powershell/windows/hgsserver/set-hgsserver).

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