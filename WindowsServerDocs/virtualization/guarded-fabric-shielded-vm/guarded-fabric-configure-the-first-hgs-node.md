---
title: Configure the first HGS node
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: a6c7d7c2-dd70-4a75-aa19-4c7c74277fcd
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 05/03/2017
---

# Configure the first Host Guardian Service (HGS) node

>Applies To: Windows Server 2016

The steps in this section guide you through setting up your first HGS node. You should perform these steps on a physical server with Windows Server 2016 installed.

## Add the HGS Server Role

Add the Host Guardian Service role by using Server Manager or by running the following command in an elevated Windows PowerShell console:

```powershell
Install-WindowsFeature -Name HostGuardianServiceRole -IncludeManagementTools -Restart
```
    
## Install HGS in a new forest

The Host Guardian Service should be installed in a separate Active Directory forest than the Hyper-V hosts and fabric managers.
If a secure bastion forest is not already available in your environment, follow the steps in this section to have HGS set up one for you.
To install HGS in an existing bastion forest, skip to [Install HGS in an existing bastion forest](#install-hgs-in-an-existing-bastion-forest).

### Create a new forest for HGS

Ensure that the HGS machine is **not** joined to a domain before performing these steps.

1.  In an elevated Windows PowerShell console, run the following commands to install the Host Guardian Service and configure its domain.
The password you specify here will only apply to the Directory Services Restore Mode password for Active Directory; it will *not* change your admin account's login password.
You may provide any domain name of your choosing to the `-HgsDomainName` parameter.

    ```powershell
    $adminPassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

    Install-HgsServer -HgsDomainName 'relecloud.com' -SafeModeAdministratorPassword $adminPassword -Restart
    ```

2.  After the computer restarts, log in as the domain administrator using the same password you previously used as the local administrator (regardless of the password you specified in the previous step).

### Initialize the HGS cluster

The following commands will complete the configuration of the first HGS node.

1.  Determine a suitable distributed network name (DNN) for the HGS cluster. This name will be registered in the HGS DNS service to make it easy for Hyper-V hosts to contact any node in the HGS cluster. As an example, if you have 3 HGS nodes with hostnames HGS01, HGS02, and HGS03, respectively, you might decide to choose "HGS" or "HgsCluster" for the DNN. Do not provide a fully qualified domain name to the `Initialize-HgsServer` cmdlet (e.g. use "hgs" not "hgs.relecloud.com").

2.  Locate your HGS guardian certificates, as detailed in the [Prepare for HGS]() topic. You will need one signing certificate and one encryption certificate to intitialize the HGS cluster. The easiest way to provide certificates to HGS is to create a password-protected PFX file for each certificate which contains both the public and private keys. If you are using HSM-backed keys or other non-exportable certificates, you must ensure the certificate is installed into the local machine's certificate store before continuing.

3.  Select an [attestation mode](Guarded-Fabric-and-Shielded-VMs.md#attestation-modes-in-the-guarded-fabric-solution) for HGS: AD-trusted or TPM-trusted. If you do not have compatible hardware for TPM attestation, you can switch to TPM attestation in the future when you obtain supported hardware.

4.  Run the [Initialize-HgsServer](https://technet.microsoft.com/library/mt652185.aspx) cmdlet in an elevated PowerShell window on the first HGS node. The syntax of this cmdlet supports many different inputs, but the 2 most common invocations are below:

    -   If you are using PFX files for your signing and encryption certificates, run the following commands:

        ```powershell
        $signingCertPass = Read-Host -AsSecureString -Prompt "Signing certificate password"
        $encryptionCertPass = Read-Host -AsSecureString -Prompt "Encryption certificate password"

        Initialize-HgsServer -HgsServiceName 'MyHgsDNN' -SigningCertificatePath 'C:\temp\SigningCert.pfx' -SigningCertificatePassword $signPass -EncryptionCertificatePath 'C:\temp\EncryptionCert.pfx' -EncryptionCertificatePassword $encryptionCertPass -TrustTpm
        ```

    -   If you are using non-exportable certificates that are installed in the local certificate store, run the following command. If you do not know the thumbprints of your certificates, you can list available certificates by running `Get-ChildItem Cert:\LocalMachine\My`.

        ```powershell
        Initialize-HgsServer -HgsServiceName 'MyHgsDNN' -SigningCertificateThumbprint '1A2B3C4D5E6F...' -EncryptionCertificateThumbprint '0F9E8D7C6B5A...' -TrustTpm
        ```

    > [!NOTE]
    > Provide **-TrustActiveDirectory** to the command instead of **-TrustTpm** if you are using AD-trusted attestation.        

5.  If you provided any certificates to HGS using thumbprints, you will be instructed to grant HGS read access to the private key of those certificates. On a server with the full Windows user interface, complete the following steps:

    1.  Open the local computer certificate manager (**certlm.msc**)
    2.  Find the certificate(s) > right click > all tasks > manage private keys
    3.  Click **Add**
    4.  In the object picker window, click **Object types** and enable **service accounts**
    5.  Enter the name of the service account mentioned in the warning text from `Initialize-HgsServer`
    6.  Ensure the gMSA has "Read" access to the private key.

    On server core, you will need to download a PowerShell module to assist in setting the private key permissions.

    1.  Run `Install-Module GuardedFabricTools` on the HGS server if it has Internet connectivity, or run `Save-Module GuardedFabricTools` on another computer and copy the module over to the HGS server.
    2.  Run `Import-Module GuardedFabricTools`. This will add additional properties to certificate objects found in PowerShell.
    3.  Find your certificate thumbprint in PowerShell with `Get-ChildItem Cert:\LocalMachine\My`
    4.  Update the ACL, replacing the thumbprint with your own and the gMSA account in the code below with the account listed in the warning text of `Initialize-HgsServer`.

        ```powershell
        $certificate = Get-Item "Cert:\LocalMachine\1A2B3C..."
        $certificate.Acl = $certificate.Acl | Add-AccessRule "HgsSvc_1A2B3C" Read Allow
        ```

    If you are using HSM-backed certificates, or certificates stored in a third party key storage provider, these steps may not apply to you. Consult your key storage provider's documentation to learn how to manage permissions on your private key. In some cases, there is no authorization, or authorization is provided to the entire computer when the certificate is installed.

6.  If you initialized HGS in TPM mode, or intend to migrate to TPM mode in the future, follow the steps at the end of this article to [install trusted TPM root certificates](#install-trusted-tpm-root-certificates) on this and all additional HGS servers.

7. That's it! In a production environment, you should continue to [add additional HGS nodes to your cluster](guarded-fabric-configure-additional-hgs-nodes.md). In a test environment, you can skip to [validating your HGS configuration](guarded-fabric-verify-hgs-configuration.md).

## Install HGS in an existing bastion forest

If your datacenter has a secure bastion forest where you want to join HGS nodes, follow the steps in this section.
These steps also apply if you want to configure 2 or more independent HGS clusters that are joined to the same domain.

### Join the HGS server to the existing domain

First, use Server Manager or [Add-Computer](http://go.microsoft.com/fwlink/?LinkId=821564) to join your HGS servers to the desired domain.

### Prepare Active Directory objects

To initialize HGS in an existing domain, you need to create a group managed service account and 2 security groups.
You can also pre-stage the cluster objects if the account you are initializing HGS with does not have permission to create computer objects in the domain.

#### Group managed service account

To create the group managed service account, the identity used by HGS to retrieve and use its certificates, use [New-ADServiceAccount](https://technet.microsoft.com/itpro/powershell/windows/addsadministration/new-adserviceaccount).
If this is the first gMSA in the domain, you will need to add a Key Distribution Service root key.

Each HGS node will need to be permitted to access the group managed service account password.
The easiest way to configure this is to create a security group that contains all of your HGS nodes and grant that security group access to retrieve the gMSA password.

```powershell
# Check if the KDS root key has been set up
if (-not (Get-KdsRootKey)) {
    # Adds a KDS root key effective immediately (ignores normal 10 hour waiting period)
    Add-KdsRootKey -EffectiveTime ((Get-Date).AddHours(-10))
}

# Create a security group for HGS nodes
$hgsNodes = New-ADGroup -Name 'HgsServers' -GroupScope DomainLocal -PassThru

# Add your HGS nodes to this group
# If your HGS server object is under an organizational unit, provide the full distinguished name instead of "HGS01"
Add-ADGroupMember -Identity $hgsNodes -Members "HGS01"

# Create the gMSA
New-ADServiceAccount -Name 'HGSgMSA' -DnsHostName 'HGSgMSA.yourdomain.com' -PrincipalsAllowedToRetrieveManagedPassword $hgsNodes
```

> [!NOTE]
> Group managed service accounts are available beginning with the Windows Server 2012 Active Directory schema.
> Consult the Active Directory documentation for information on [group managed service account requirements](https://technet.microsoft.com/library/jj128431.aspx).

#### JEA security groups

When you set up HGS, a [Just Enough Administration (JEA)](https://aka.ms/JEAdocs) PowerShell endpoint is configured to allow admins to manage HGS without needing full local administrator privileges.
You are not required to use JEA to manage HGS, but it still must be configured when running Initialize-HgsServer.
The configuration of the JEA endpoint consists of designating 2 security groups that contain your HGS admins and HGS reviewers.
Users who belong to the admin group can add, change, or remove policies on HGS; reviewers can only view the current configuration.

Create 2 security groups for these JEA groups using Active Directory admin tools or [New-ADGroup](https://technet.microsoft.com/itpro/powershell/windows/addsadministration/new-adgroup).

```powershell
New-ADGroup -Name 'HgsJeaReviewers' -GroupScope DomainLocal
New-ADGroup -Name 'HgsJeaAdmins' -GroupScope DomainLocal
```

#### Cluster objects

Lastly, if the account you are using to set up HGS does not have permission to create new computer objects in the domain, you will need to pre-stage the cluster objects.
These steps are explained in the [Prestage Cluster Computer Objects in Active Directory Domain Services](https://technet.microsoft.com/en-us/library/dn466519(v=ws.11).aspx) article.

To set up your first HGS node, you will need to create one Cluster Name Object (CNO) and one Virtual Computer Object (VCO).
The CNO represents the name of the cluster, and is primarily used internally by Failover Clustering.
The VCO represents the HGS service that resides on top of the cluster and will be the name registered with the DNS server.

To quickly prestage your CNO and VCO, have an Active Directory admin run the following PowerShell commands:

```powershell
# Create the CNO
$cno = New-ADComputer -Name 'HgsCluster' -Description 'HGS CNO' -Enabled $false -Passthru

# Create the VCO
$vco = New-ADComputer -Name 'HgsService' -Description 'HGS VCO' -Passthru

# Give the CNO full control over the VCO
$vcoPath = Join-Path "AD:\" $vco.DistinguishedName
$acl = Get-Acl $vcoPath
$ace = New-Object System.DirectoryServices.ActiveDirectoryAccessRule $cno.SID, "GenericAll", "Allow"
$acl.AddAccessRule($ace)
Set-Acl -Path $vcoPath -AclObject $acl
```
### Initialize HGS in the bastion forest

When setting up HGS in an existing forest, you should not run `Install-HgsServer` or promote the HGS server to a domain controller for that domain.
Active Directory Domain Services will be installed on the machine, but should remain unconfigured.

Now you are ready to [initalize the HGS server](https://technet.microsoft.com/itpro/powershell/windows/hgsserver/initialize-hgsserver).

If you are using PFX-based certificates, run the following commands on the HGS server:

```powershell
$signingCertPass = Read-Host -AsSecureString -Prompt "Signing certificate password"
$encryptionCertPass = Read-Host -AsSecureString -Prompt "Encryption certificate password"

Install-ADServiceAccount -Identity 'HGSgMSA'

Initialize-HgsServer -UseExistingDomain -ServiceAccount 'HGSgMSA' -JeaReviewersGroup 'HgsJeaReviewers' -JeaAdministratorsGroup 'HgsJeaAdmins' -HgsServiceName 'HgsService' -SigningCertificatePath 'C:\temp\SigningCert.pfx' -SigningCertificatePassword $signPass -EncryptionCertificatePath 'C:\temp\EncryptionCert.pfx' -EncryptionCertificatePassword $encryptionCertPass -TrustTpm
```

> [!NOTE]
> Provide **-TrustActiveDirectory** instead of **-TrustTpm** if you are using AD-trusted attestation.
> Additionally, if you prestaged cluster objects, ensure that the virtual computer object name matches the value provided to `-HgsServiceName`.

If you are using certificates installed on the local machine (such as HSM-backed certificates and non-exportable certificates), use the `-SigningCertificateThumbprint` and `-EncryptionCertificateThumbprint` parameters instead, as documented in the cmdlet help.

## Install trusted TPM root certificates

If you chose TPM mode, or expect to migrate to TPM mode in the future, you need to install root certificates to issue the endorsement key in hosts' TPM modules.
These root certificates are different from those installed by default in Windows and represent the specific root and intermediate certificates used by TPM vendors.
The following steps help you install certificates for TPMs produced by Microsoft's partners.
Some TPMs do not use endorsement key certificates or use certificates not included in this package.
Consult your TPM vendor or server OEM for further assistance in these cases.

1.  Download the latest package from [http://tpmsec.microsoft.com/OnPremisesDHA/TrustedTPM.cab](http://tpmsec.microsoft.com/OnPremisesDHA/TrustedTPM.cab)
2.  Validate that the package is digitally signed by Microsoft. Do not expand the CAB file if it does not have a valid signature.

    ```powershell
    Get-AuthenticodeSignature -Path <Path-To-TrustedTpm.cab>
    ```

3.  Expand the cab file

    ```powershell
    mkdir .\TrustedTPM
    expand.exe -F:* .\TrustedTPM.cab .\TrustedTPM
    ```

4.  By default, the configuration script will install certificates for every TPM vendor. If you only want to import certificates for your specific TPM vendor, delete the folders for TPM vendors not trusted by your organization.

5.  Install the trusted certificate package by running the setup script in the expanded folder.

    ```powershell
    cd .\TrustedTPM
    .\setup.cmd
    ```

The TrustedTpm.cab file is updated regularly with new vendor certificates as they become available.
To add new certificates or ones intentionally skipped during an earlier installation, simply repeat the above steps on every node in your HGS cluster.
Existing certificates will remain trusted but new certificates found in the expanded cab file will be added to the trusted TPM stores.

## Configuring HGS for HTTPS communications

By default, when you initialize the HGS server it will configure the IIS web sites for HTTP-only communications.
All sensitive material being transmitted to and from HGS (including the encryption keys for the VM) are always encrypted using message-level encryption, however if you desire a higher level of security you can also enable HTTPS by configuring HGS with an SSL certificate.

First, obtain an SSL certificate for HGS from your certificate authority. Each Hyper-V host will need to trust the SSL certificate, so it is recommended that you issue the SSL certificate from your company's public key infrastructure or a third party CA. Any SSL certificate supported by IIS is supported by HGS, however **the subject name on the certificate must match the fully qualified HGS service name** (cluster distributed network name). For instance, if the HGS domain is "secure.contoso.com" and your HGS service name is "hgs", your SSL certificate should be issued for "hgs.secure.contoso.com". You can add additional DNS names to the certificate's subject alternative name field if necessary.

Once you have the SSL certificate, you can either provide the certificate to the `Initialize-HgsServer` cmdlet if you haven't already run it, or use `Set-HgsServer` if you've already initialized HGS.

**If you haven't already initialized HGS**

Append the following SSL-related parameters to the `Initialize-HgsServer` command from the [Initialize the HGS cluster](#initialize-the-hgs-cluster) or [Initialize HGS in the bastion forest](#initialize-hgs-in-the-bastion-forest) sections.

```powershell
$sslPassword = Read-Host -AsSecureString -Prompt "SSL Certificate Password"
Initialize-HgsServer <OtherParametersHere> -Http -Https -HttpsCertificatePath 'C:\temp\HgsSSLCertificate.pfx' -HttpsCertificatePassword $sslPassword
```

If your certificate is installed in the local certificate store and cannot be exported to a PFX file with the private key intact, you can provide the SSL certificate by its thumbprint instead:

```powershell
Initialize-HgsServer <OtherParametersHere> -Http -Https -HttpsCertificateThumbprint 'A1B2C3D4E5F6...'
```

**If you've already initialized HGS**

Run [Set-HgsServer](https://technet.microsoft.com/itpro/powershell/windows/host-guardian-service/server/set-hgsserver) to configure the new SSL certificate.
This step must be repeated on every HGS node in your cluster.

```powershell
$sslPassword = Read-Host -AsSecureString -Prompt "SSL Certificate Password"
Set-HgsServer -Http -Https -HttpsCertificatePath 'C:\temp\HgsSSLCertificate.pfx' -HttpsCertificatePassword $sslPassword
```

Or, if you have already installed the certificate into the local certificate store and want to reference it by thumbprint:
```powershell
Set-HgsServer -Http -Https -HttpsCertificateThumbprint 'A1B2C3D4E5F6...'
```

> [!IMPORTANT]
> Configuring HGS with an SSL certificate does not disable the HTTP endpoint.
> If you wish to only allow use of the HTTPS endpoint, configure Windows Firewall to block inbound connections to port 80.
> **Do not modify the IIS bindings** for HGS websites to remove the HTTP endpoint; it is unsupported to do so.

## Next steps
- [Configure additional HGS nodes](guarded-fabric-configure-additional-hgs-nodes.md)
- [Validate the HGS configuration](guarded-fabric-verify-hgs-configuration.md)
