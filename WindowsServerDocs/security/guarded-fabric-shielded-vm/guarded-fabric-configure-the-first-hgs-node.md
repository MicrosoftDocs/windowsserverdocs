---
title: Configure the first HGS node
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: a6c7d7c2-dd70-4a75-aa19-4c7c74277fcd
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 03/02/2017
---

# Configure the first HGS node

>Applies To: Windows Server 2016

The steps in this section guide you through setting up your first HGS node. You should perform these steps on a physical server with Windows Server 2016 installed.

### Add the HGS Role

Add the Host Guardian Service role by using Server Manager or by running the following command in an elevated Windows PowerShell console:

```powershell
Install-WindowsFeature -Name HostGuardianServiceRole -IncludeManagementTools -Restart
```
    
## Install the Host Guardian Service

Follow the next sections to install HGS its own forest (recommended). To install HGS in an existing bastion forest, skip to [Initialize HGS in an existing bastion forest](#initialize-hgs-in-an-existing-bastion-forest). 

### Install HGS in its own new forest

Ensure that the HGS machine is **not** joined to a domain before performing these steps.

1.  In an elevated Windows PowerShell console, run the following commands to install the Host Guardian Service and configure its domain. The password you specify here will only apply to the Directory Services Restore Mode password for Active Directory; it will *not* change the password you log in with.

    ```powershell
    $adminPassword = ConvertTo-SecureString -AsPlainText '<password>' -Force

    Install-HgsServer -HgsDomainName 'relecloud.com' -SafeModeAdministratorPassword $adminPassword -Restart
    ```

2.  After the computer restarts, log in as the domain administrator using the same password you previously used as the local administrator (regardless of the password you specified in the previous step).

## Initialize the HGS server with your chosen mode of attestation

The following commands will complete the configuration of the first HGS node.

1.  Open an elevated Windows PowerShell console, and then run the following commands to initialize the HGS server with the encryption and signing certificates created earlier.

    For &lt;HgsServiceName&gt;, substitute a name of your choosing for the HGS cluster. This name is the distributed network name of the cluster. This name should *not* be fully qualified (e.g. enter "hgs" if you want the DNN to be configured as "hgs.relecloud.com").

    The syntax of the [Initialize-HgsServer](https://technet.microsoft.com/library/mt652185.aspx) command will vary according to the type of certificate and the desired attestation mode. Specifically:

    -   If you have PFX files with private keys intact, use the following parameter set:

        ```
        -SigningCertificatePath <path to PFX>
        -SigningCertificatePassword <secureString>
        -EncryptionCertificatePath <path to PFX>
        -EncryptionCertificatePassword <secureString>
        ```

        You also need to provide the certificate password you chose earlier to the *initialize* cmdlet as a secure string. Enter the following command if you have not already created a variable to hold it.

        ```powershell
        $certificatePassword = ConvertTo-SecureString -AsPlainText '<password>' -Force
        ```
    
    -   If your certificates are in your local certificate store, regardless of whether their private keys are intact or HSM-backed, use the following parameter set:

        ```
        -SigningCertificateThumbprint <thumbprint>
        -EncryptionCertificateThumbprint <thumbprint>
        ```

    Specify your [attestation mode](Guarded-Fabric-and-Shielded-VMs.md#attestation-modes-in-the-guarded-fabric-solution) as follows:

    -   For AD mode, use: `-TrustActiveDirectory`

    -   For TPM mode, use: `-TrustTpm`

    Your final command syntax will look like this:

    ```powershell
    Initialize-HgsServer -HgsServiceName '<HgsServiceName>' -SigningCertificatePath 'C:\signingCert.pfx' -SigningCertificatePassword $certificatePassword -EncryptionCertificatePath 'C:\encryptionCert.pfx' -EncryptionCertificatePassword $certificatePassword [-TrustActiveDirectory | -TrustTPM]
    ```
    
    HTTPS is not needed to secure communication between HGS and a Hyper-V host, but if you want to enable it, see the next section. 

### Initialize HGS server with an HTTPS Certificate 

To enable HTTPS communication on the HGS server, you need to pass in the [HTTPS certificate](#configure-a-certificate-for-enabling-https) when initializing the HGS server. 
Here is an example—run this in place of the command in the previous section.

```powershell
Initialize-HgsServer -HgsServiceName <HgsServiceName> -EncryptionCertificateThumbprint $encryptionCert.Thumbprint -SigningCertificateThumbprint $signingCert.Thumbprint -TrustTpm -Http -Https -HttpsCertificatePath 'C:\HttpsCertificate.pfx' -HttpsCertificatePassword $certificatePassword
```
    
>**Note**&nbsp;&nbsp;If you are setting up multiple HGS servers in a high availability configuration, be sure to import the same HTTPS certificate on each machine. The variables **-Http -Https -HttpsCertificatePath 'C:\HttpsCertificate.pfx' -HttpsCertificatePassword $certificatePassword** (as shown in the previous command) should be included every time you initialize an HGS server in your environment.

### Initialize HGS in an existing bastion forest

The following tables describe the unique **Initialize-HgsServer** parameters to use when you add HGS to an existing forest. Before you run the cmdlet, make sure the [requirements](#requirements-for-adding-hgs-to-an-existing-forest) are complete.

| **Required Parameter**  | **Description**    |
|-------------|----------|
| `-UseExistingDomain`      | Adds HGS to an existing domain.                                                                                              |
| `-JeaAdministratorsGroup` | Identifies the Active Directory group of users who can perform HGS administration (through Just Enough Administration, JEA). |
| `-JeaReviewersGroup`      | Identifies the Active Directory group of users who can view HGS (through JEA).                                               |
| `-ServiceAccount`         | Identifies the group Managed Service Account (gMSA) that will be used for the Key Protection Service.                        |

| **Optional Parameter** | **Description**     |
|------------|-----------|
| `-ClusterName`           | Optionally, identifies the name of an existing cluster for HGS to use, rather than allowing a cluster to be automatically created by **Initialize-HgsServer**. |

**Windows PowerShell example**

```powershell
Initialize-HgsServer -UseExistingDomain -JeaAdministratorsGroup <AdministratorsGroupName> -JeaReviewersGroup <ReviewersGroupName> -ServiceAccount <gMSAforKPS> -ClusterName <ExistingClusterName> -HgsServiceName '<HgsServiceName>' -SigningCertificatePath 'C:\signingCert.pfx' -SigningCertificatePassword $certificatePassword -EncryptionCertificatePath 'C:\encryptionCert.pfx' -EncryptionCertificatePassword $certificatePassword [-TrustActiveDirectory | -TrustTPM]
```

