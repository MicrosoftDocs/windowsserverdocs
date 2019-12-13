---
title: Troubleshooting the Host Guardian Service
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: 424b8090-0692-49a6-9dc4-3c0e77d74b80
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 09/25/2019
---

# Troubleshooting the Host Guardian Service

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes resolutions to common problems encountered when deploying or operating a Host Guardian Service (HGS) server in a guarded fabric.
If you are unsure of the nature of your problem, first try running the [guarded fabric diagnostics](guarded-fabric-troubleshoot-diagnostics.md) on your HGS servers and Hyper-V hosts to narrow down the potential causes.

## Certificates

HGS requires several certificates in order to operate, including the admin-configured encryption and signing certificate as well as an attestation certificate managed by HGS itself.
If these certificates are incorrectly configured, HGS will be unable to serve requests from Hyper-V hosts wishing to attest or unlock key protectors for shielded VMs.
The following sections cover common problems related to certificates configured on HGS.

### Certificate Permissions

HGS must be able to access both the public and private keys of the encryption and signing certificates added to HGS by the certificate thumbprint.
Specifically, the group managed service account (gMSA) that runs the HGS service needs access to the keys.
To find the gMSA used by HGS, run the following command in an elevated PowerShell prompt on your HGS server:

```powershell
(Get-IISAppPool -Name KeyProtection).ProcessModel.UserName
```

How you grant the gMSA account access to use the private key depends on where the key is stored: on the machine as a local certificate file, on a hardware security module (HSM), or using a custom third-party key storage provider.

#### Grant access to software-backed private keys

If you are using a self-signed certificate or a certificate issued by a certificate authority that is **not** stored in a hardware security module or custom key storage provider, you can change the private key permissions by performing the following steps:

1. Open local certificate manager (certlm.msc)
2. Expand **Personal > Certificates** and find the signing or encryption certificate that you want to update.
3. Right click the certificate and select **All Tasks > Manage Private Keys**.
4. Click **Add** to grant a new user access to the certiciate's private key.
5. In the object picker, enter the gMSA account name for HGS found earlier, then click **OK**.
6. Ensure the gMSA has **Read** access to the certificate.
7. Click **OK** to close the permission window.

If you are running HGS on Server Core or are managing the server remotely, you will not be able to manage private keys using the local certificate manager.
Instead, you will need to download the [Guarded Fabric Tools PowerShell module](https://www.powershellgallery.com/packages/GuardedFabricTools) which will allow you to manage the permissions in PowerShell.

1. Open an elevated PowerShell console on the Server Core machine or use PowerShell Remoting with an account that has local administrator permissions on HGS.
2. Run the following commands to install the Guarded Fabric Tools PowerShell module and grant the gMSA account access to the private key.

```powershell
$certificateThumbprint = '<ENTER CERTIFICATE THUMBPRINT HERE>'

# Install the Guarded Fabric Tools module, if necessary
Install-Module -Name GuardedFabricTools -Repository PSGallery

# Import the module into the current session
Import-Module -Name GuardedFabricTools

# Get the certificate object
$cert = Get-Item "Cert:\LocalMachine\My\$certificateThumbprint"

# Get the gMSA account name
$gMSA = (Get-IISAppPool -Name KeyProtection).ProcessModel.UserName

# Grant the gMSA read access to the certificate
$cert.Acl = $cert.Acl | Add-AccessRule $gMSA Read Allow
```

#### Grant access to HSM or custom provider-backed private keys

If your certificate's private keys are backed by a hardware security module (HSM) or a custom key storage provider (KSP), the permission model will depend on your specific software vendor.
For the best results, consult your vendor's documentation or support site for information on how private key permissions are handled for your specific device/software.
In all cases, the gMSA used by HGS requires *read* permissions on the encryption, signing, and communications certificate private keys so that it can perform signing and encryption operations.

Some hardware security modules do not support granting specific user accounts access to a private key; rather, they allow the computer account access to all keys in a specific key set.
For such devices, it is usually sufficient to give the computer access to your keys and HGS will be able to leverage that connection.

**Tips for HSMs**

Below are suggested configuration options to help you successfully use HSM-backed keys with HGS based on Microsoft and its partners' experiences.
These tips are provided for your convenience and are not guaranteed to be correct at the time of reading, nor are they endorsed by the HSM manufacturers.
Contact your HSM manufacturer for accurate information pertaining to your specific device if you have further questions.

HSM Brand/Series      | Suggestion
----------------------|-------------
Gemalto SafeNet       | Ensure the Key Usage Property in the certificate request file is set to 0xa0, allowing the certificate to be used for signing and encryption. Additionally, you must grant the gMSA account *read* access to the private key using the local certificate manager tool (see steps above).
nCipher nShield        | Ensure each HGS node has access to the security world containing the signing and encryption keys. You may additionally need to grant the gMSA *read* access to the private key using the local certificate manager (see steps above).
Utimaco CryptoServers | Ensure the Key Usage Property in the certificate request file is set to 0x13, allowing the certificate to be used for encryption, decryption, and signing.

### Certificate requests

If you are using a certificate authority to issue your certificates in a public key infrastructure (PKI) environment, you will need to ensure your certificate request includes the minimum requirements for HGS' usage of those keys.

**Signing Certificates**

CSR Property | Required Value
-------------|---------------
Algorithm    | RSA
Key Size     | At least 2048 bits
Key Usage    | Signature/Sign/DigitalSignature

**Encryption Certificates**

CSR Property | Required Value
-------------|---------------
Algorithm    | RSA
Key Size     | At least 2048 bits
Key Usage    | Encryption/Encrypt/DataEncipherment

**Active Directory Certificate Services Templates**

If you are using Active Directory Certificate Services (ADCS) certificate templates to create the certificates it is recommended you use a template with the following settings:

ADCS Template Property | Required Value
-----------------------|---------------
Provider Category      | Key Storage Provider
Algorithm Name         | RSA
Minimum Key Size       | 2048
Purpose                | Signature and Encryption
Key Usage Extension    | Digital Signature, Key Encipherment, Data Encipherment ("Allow encryption of user data")


### Time Drift

If your server's time has drifted significantly from that of other HGS nodes or Hyper-V hosts in your guarded fabric, you may encounter issues with the attestation signer certificate validity.
The attestation signer certificate is created and renewed behind the scenes on HGS and is used to sign health certificates issued to guarded hosts by the Attestation Service.

To refresh the attestation signer certificate, run the following command in an elevated PowerShell prompt.

```powershell
Start-ScheduledTask -TaskPath \Microsoft\Windows\HGSServer -TaskName 
AttestationSignerCertRenewalTask
```

Alternatively, you can manually run the scheduled task by opening **Task Scheduler** (taskschd.msc), navigating to **Task Scheduler Library > Microsoft > Windows > HGSServer** and running the task named **AttestationSignerCertRenewalTask**.

## Switching Attestation Modes

If you switch HGS from TPM mode to Active Directory mode or vice versa using the [Set-HgsServer](https://technet.microsoft.com/library/mt652180.aspx) cmdlet, it may take up to 10 minutes for every node in your HGS cluster to start enforcing the new attestation mode.
This is normal behavior.
It is advised that you do not remove any policies allowing hosts from the previous attestation mode until you have verified that all hosts are attesting successfully using the new attestation mode.

**Known issue when switching from TPM to AD mode**

If you intialized your HGS cluster in TPM mode and later switch to Active Directory mode, there is a known issue which will prevent other nodes in your HGS cluster from switching to the new attestation mode.
To ensure all HGS servers are enforcing the correct attestation mode, run `Set-HgsServer -TrustActiveDirectory` **on each node** of your HGS cluster.
This issue does not apply if you are switching from TPM mode to AD mode *and* the cluster was originally set up in AD mode.

You can verify the attestation mode of your HGS server by running [Get-HgsServer](https://technet.microsoft.com/library/mt652162.aspx).

## Memory dump encryption policies

If you are trying to configure memory dump encryption policies and do not see the default HGS dump policies (Hgs\_NoDumps, Hgs\_DumpEncryption and Hgs\_DumpEncryptionKey) or the dump policy cmdlet (Add-HgsAttestationDumpPolicy), it is likely that you do not have the latest cumulative update installed.
To fix this, [update your HGS server](guarded-fabric-manage-hgs.md#patching-hgs) to the latest cumulative Windows update and [activate the new attestation policies](guarded-fabric-manage-hgs.md#updates-requiring-policy-activation).
Ensure you update your Hyper-V hosts to the same cumulative update before activating the new attestation policies, as hosts that do not have the new dump encryption capabilities installed will likely fail attestation once the HGS policy is activated.

## Endorsement Key Certificate error messages

When registering a host using the [Add-HgsAttestationTpmHost](https://docs.microsoft.com/powershell/module/hgsattestation/add-hgsattestationtpmhost) cmdlet, two TPM identifiers are extracted from the provided platform identifier file: the endorsement key certificate (EKcert) and the public endorsement key (EKpub).
The EKcert identifies the manufacturer of the TPM, providing assurances that the TPM is authentic and manufactured through the normal supply chain.
The EKpub uniquely identifies that specific TPM, and is one of the measures HGS uses to grant a host access to run shielded VMs.

You will receive an error when registering a TPM host if either of the two conditions are true:
1. The platform identifier file **does not** contain an endorsement key certificate
2. The platform identifier file contains an endorsement key certificate, but that certificate is **not trusted** on your system

Certain TPM manufacturers do not include EKcerts in their TPMs.
If you suspect that this is the case with your TPM, confirm with your OEM that your TPMs should not have an EKcert and use the `-Force` flag to manually register the host with HGS.
If your TPM should have an EKcert but one was not found in the platform identifier file, ensure you are using an administrator (elevated) PowerShell console when running [Get-PlatformIdentifier](https://docs.microsoft.com/powershell/module/platformidentifier/get-platformidentifier) on the host.

If you received the error that your EKcert is untrusted, ensure that you have [installed the trusted TPM root certificates package](guarded-fabric-install-trusted-tpm-root-certificates.md) on each HGS server and that the root certificate for your TPM vendor is present in the local machine's **TrustedTPM\_RootCA** store. Any applicable intermediate certificates also need to be installed in the **TrustedTPM\_IntermediateCA** store on the local machine.
After installing the root and intermediate certificates, you should be able to run `Add-HgsAttestationTpmHost` successfully.
