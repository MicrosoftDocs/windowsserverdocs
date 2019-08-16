---
title: Setting up the Host Guardian Service for Always Encrypted in SQL Server
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 11/03/2018
---

# Setting up the Host Guardian Service for Always Encrypted with secure enclaves in SQL Server 

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, SQL Server 2019 preview
 
[Always Encrypted with secure enclaves](https://docs.microsoft.com/sql/relational-databases/security/encryption/always-encrypted-enclaves) in SQL Server 2019 preview is a feature designed to enable confidential computations on sensitive data stored in a database. 
The Host Guardian Service (HGS) plays an important role in keeping your data safe when a secure enclave, configured for Always Encrypted, is a virtualization-based security (VBS) memory enclave. 
The security of a VBS memory enclave depends on the security of the Windows Hypervisor and, more broadly, the security of the machine hosting SQL Server. 

Therefore, before a database client application permits the VBS memory enclave used for Always Encrypted to perform computations on sensitive data, the application must attest with a trusted HGS. 
Attestation proves the machine hosting SQL Server, which contains the enclave, is in the correct state and can be trusted. 
For the rest of this topic, we'll refer to the machine hosting SQL Server as simply the host machine.

There are two, mutually exclusive ways for the application to attest: 

- Host key attestation authorizes a host by proving it possesses a known and trusted private key. Host key attestation and either a physical host machine or a generation 2 virtual machine running SQL Server is recommended for pre-production environments.
- TPM attestation validates hardware measurements to make sure a host runs only the correct binaries and security policies. TPM attestation and a physical host machine (not a virtual machine) running SQL Server is recommended for production environments.

For more information about the Host Guardian Service and what it can measure, see [Guarded fabric and shielded VMs overview](https://docs.microsoft.com/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms). 
Note that although the documents talk about shielded VMs, the same protections, architecture and best practices apply to SQL Server Always Encrypted using VBS enclaves. 

This article will help you set up HGS in a recommended configuration. 

## Prerequisites 

This section covers prerequisites for HGS and host machines. 

### HGS servers

- 1-3 servers to run HGS. 

  > [!NOTE]
  > Only 1 HGS server is required for a test or pre-production environment.

  These servers should be carefully protected since they control which machines can run your SQL Server instances using Always Encrypted with secure enclaves. 
  It is recommended that different administrators manage the HGS cluster and that you run the HGS on physical hardware isolated from the rest of your infrastructure, or in separate virtualization fabrics or Azure subscriptions.

  - Windows Server 2019 Standard or Datacenter edition.
  - 2 CPUs
  - 8GB RAM
  - 100GB storage

  You can use either the [Long-Term Servicing Channel (LTSC)](https://docs.microsoft.com/windows-server/get-started/semi-annual-channel-overview#long-term-servicing-channel-ltsc) or the [Semi-Annual Channel](https://docs.microsoft.com/windows-server/get-started/semi-annual-channel-overview#semi-annual-channel). 
  To register and download the Windows Server Insider Preview, see [Getting started with the Windows Insider Program](https://insider.windows.com/for-business-getting-started-server/).

- Choose a name for the new Active Directory forest created by the Host Guardian Service. 
  HGS should not be joined to your existing corporate domain and should have separate administrators managing it.   

- Firewall and routing rules to allow inbound HTTP (TCP 80) or HTTPS (TCP 443) traffic on the Host Guardian Service nodes from: 

  - The machines running SQL Server
  - The machines running database client applications (such as web servers) that issue database queries and use Always Encrypted with secure enclaves. 

### SQL Server host machines

- Your SQL Server instance should run on a machine that meets the following requirements:

  - Windows: 
    - Windows 10 Enterprise, version 1809  
    - Windows Server 2019 Datacenter (Semi-Annual Channel), version 1809
    - Windows Server 2019 Datacenter
  - Physical machine for production, or a generation 2 virtual machine for testing (Note that Azure does not support generation 2 VMs)
  - General requirements listed in [Hardware and Software Requirements for Installing SQL Server](https://docs.microsoft.com/sql/sql-server/install/hardware-and-software-requirements-for-installing-sql-server?view=sql-server-2017).   

  You can use either the [Long-Term Servicing Channel (LTSC)](https://docs.microsoft.com/windows-server/get-started/semi-annual-channel-overview#long-term-servicing-channel-ltsc) or the [Semi-Annual Channel](https://docs.microsoft.com/windows-server/get-started/semi-annual-channel-overview#semi-annual-channel). 
  To register and download the Windows Server Insider Preview, see [Getting started with the Windows Insider Program](https://insider.windows.com/for-business-getting-started-server/).

- Requirements specific to the chosen attestation mode:
  - **TPM mode** is the strongest attestation mode and will use a Trusted Platform Module (TPM) to cryptographically validate that your host machines are known to your datacenter (using a unique ID from each TPM), running trusted hardware and firmware configurations (using a TPM baseline), and running trustworthy kernel and user mode code (using Windows Defender Application Control). The following hardware is required to use TPM mode: 
    - TPM 2.0 module installed and enabled 
    - Secure Boot enabled with the Microsoft Secure Boot policy (do not enable the 3rd party Secure Boot CA policy or any custom policies)
    - IOMMU (Intel VT-d or AMD IOV) to prevent direct memory access attacks 

  - **Host key mode** uses an asymmetric key pair (much like SSH keys) to identify and authorize host machines that wish to run SQL Server. This mode is easier to set up and does not have any specific hardware requirements but will not verify the software or firmware running on the host machines.  

To check if your TPM is compatible, run the following commands on the host machine where you intend to run SQL Server using Always Encrypted with secure enclaves. 
“2.0” must appear in the list of supported SpecVersions for you to use TPM attestation:

```powershell
Get-CimInstance -ClassName Win32_Tpm -Namespace root/cimv2/Security/MicrosoftTpm 
```

## Set up the first HGS node 

The Host Guardian Service operates in a highly available configuration using a 3-node cluster. 
It is recommended that you set up one node completely before adding other nodes. 

Run all of the following commands in an elevated PowerShell session.

1. [!INCLUDE [Install the HGS server role](../../includes/guarded-fabric-install-hgs-server-role.md)]

2. [!INCLUDE [Install HGS by default](../../includes/install-hgs-default.md)] 

3. [!INCLUDE [Determine a DNN](../../includes/guarded-fabric-initialize-hgs-default-step-one.md)]

   For Always Encrypted with secure enclaves, the host machines that run SQL Server and machines that run database client applications both need to contact HGS, though only the host machines require attestation.

4. After the machine reboots, HGS will be installed and the server will also be a domain controller with Active Directory configured. 
   During the Active Directory configuration, the local machine Administrator account is added to the Domain Admins group, and only members of this group can sign in to a domain controller.
   Sign in using the domain Administrator account (for example, administrator@bastion.local or bastion.local\administrator) or create another Domain Admin account for sign in and then configure the attestation service.
   You will need to choose TPM or host key attestation and run the corresponding command. 
   For the HgsServiceName, specify the DNN you chose.

   For TPM mode:

   ```powershell
   Initialize-HgsAttestation -HgsServiceName 'hgs' -TrustTpm
   ```

   For host key mode:

   ```powershell
   Initialize-HgsAttestation -HgsServiceName 'hgs' -TrustHostKey 
   ```

5. Ensure the host machines that run SQL Server will be able to resolve the DNS names of your new HGS domain members by setting up a forwarder from your corporate DNS servers to the new HGS domain controller. If you’re using Windows Server DNS, you can set up a conditional forwarder by running the following commands in an elevated PowerShell console on a DNS server in your organization. Substitute the names and addresses in the Windows PowerShell syntax below as needed for your environment. After you add more HGS nodes, run this command again to add them as master servers.

   ```powershell
   Add-DnsServerConditionalForwarderZone -Name <HGS domain name> -ReplicationScope "Forest" -MasterServers <IP addresses of HGS servers>
   ```

## Set up additional HGS nodes for production deployments

To add nodes to the cluster, run the following commands in an elevated PowerShell session. 

1. [!INCLUDE [Install the HGS server role](../../includes/guarded-fabric-install-hgs-server-role.md)]

2. Set the DNS client resolver to point to your primary HGS server so that it can resolve your HGS domain name. If you’re using Server with Desktop Experience, you can do this in the Network and Sharing Center. On Server Core, you can use the **sconfig.exe** tool, option 8, or **Set-DnsClientServerAddress** to set the DNS address. 

3. Next, we will promote this server to a domain controller. You will need Domain Admin credentials to complete this task and will be prompted to enter a Directory Services Repair Mode password after running the command. 

   ```powershell
   $HgsDomainName = 'bastion.local' 
   $HgsDomainCredential = Get-Credential 
 
   Install-HgsServer -HgsDomainName $HgsDomainName -HgsDomainCredential $HgsDomainCredential -Restart 
   ```

4. [!INCLUDE [Initialize HGS](../../includes/guarded-fabric-initialize-hgs-on-the-node.md)] 

## Configure HGS for HTTPS 

By default, when you initialize the HGS server it will configure the IIS web sites for HTTP-only communications.

> [!NOTE]
> Configuring HTTPS using a well known and trusted HGS server certificate is required to prevent man-in-the-middle attacks and is therefore advised for production deployments.

[!INCLUDE [Configure HTTPS](../../includes/configure-hgs-for-https.md)] 

> [!NOTE]
> For Always Encrypted with secure enclaves, the SSL certificate needs to be trusted on both host machines that run SQL Server and machines that run database client applications need to contact HGS. 

## Collect attestation info from the host machines

Once HGS is set up, it needs to be configured with attestation information from your host machines so that it knows which machines should be authorized to perform confidential computations using Always Encrypted and VBS secure enclaves. These steps vary based on which attestation mode you use. 

### Collect TPM attestation artifacts 

If you are using TPM mode, run the following commands in an elevated PowerShell session on each host machine to install support for attestation and collect the information you’ll need to register with the Host Guardian Service. 

1. To install the HGS client on your host machine, install the Guarded Host feature, which will also install Hyper-V. 
   While you will not be running VMs on this machine, the hypervisor is required to enable the Virtualization-Based Security features that isolate VBS enclaves.

   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName HostGuardian -All 
   ```

2. Restart your computer when prompted to complete installation of Hyper-V. 
3. Compose a code integrity policy to restrict which software can run on the system. 
   Any Windows Defender Application Control policy is sufficient. 
   If you are only running Microsoft software on the server, the following commands will quickly create a policy for you. 
   The policy will be in audit mode, meaning it will log an event about unauthorized code, but will not keep it from running.  

   ```powershell
   mkdir C:\artifacts
   Copy-Item C:\Windows\Schemas\CodeIntegrity\ExamplePolicies\AllowMicrosoft.xml C:\artifacts\AllowMicrosoft-Audit.xml 
   Set-RuleOption -FilePath C:\artifacts\AllowMicrosoft-Audit.xml -Option 3 
   ConvertFrom-CIPolicy -XmlFilePath C:\artifacts\AllowMicrosoft-Audit.xml -BinaryFilePath C:\artifacts\AllowMicrosoft-Audit.bin 
   Copy-Item C:\artifacts\AllowMicrosoft-Audit.bin C:\Windows\System32\CodeIntegrity\SIPolicy.p7b 
   Restart-Computer 
   ```

   Windows Defender Application Control has numerous features to cover a variety of security postures. 
   If you need to allow non-Microsoft software or customize the default policy, se the [Windows Defender Application Control deployment guide](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-deployment-guide).   


4. Verify that Virtualization Based Security is running on your computer with the following command. 
   You will know that VBS is running if the DeviceGuardSecurityServicesRunning field has “HypervisorEnforcedCodeIntegrity” listed in it. 
   If it is not running, download the [Device Guard Readiness Tool](https://www.microsoft.com/download/details.aspx?id=53337) and run “DG_Readiness.ps1 -Enable -HVCI” to enable it.  
   
   ```powershell
   Get-ComputerInfo -Property DeviceGuard* 
   ```

5. Collect the TPM identifier and baseline:

   ```powershell 
   (Get-PlatformIdentifier -Name $env:computername).Save("C:\artifacts\TpmID-$env:computername.xml") 
   Get-HgsAttestationBaselinePolicy -SkipValidation -Path "C:\artifacts\TpmBaseline-$env:computername.tcglog" 
   ```
   
6. Copy the xml, tcglog, and bin files from C:\artifacts to your HGS server.
7. If this is the first TPM host you’re adding to the HGS server, you will need to install the Trusted TPM Root Certificates on each HGS server. 
   Follow the [guidance on the HGS documentation](https://docs.microsoft.com/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-install-trusted-tpm-root-certificates) to complete this step.
8. On the HGS server, authorize this host to pass attestation. 
   The scripts below assume the 3 files were copied to C:\temp on the HGS server and that your server’s computer name is “ServerA”. 
   Adjust the paths and names to match your own environment. 

   ```powershell
   Add-HgsAttestationTpmHost -Name ServerA -Path C:\temp\TpmID-ServerA.xml 
   Add-HgsAttestationTpmPolicy -Name ServerA-Baseline -Path C:\temp\TpmBaseline-ServerA.tcglog 
   Add-HgsAttestationCiPolicy -Name AllowMicrosoft-Audit -Path C:\temp\AllowMicrosoft-Audit.bin 
   ```

9. Your first server is now ready to attest! 
   On the host machine, run the following command to tell it where to attest (change the DNS name to that of your HGS cluster, typically you will use the HGS Service Name combined with the HGS domain name). 
   If you receive a HostUnreachable error, ensure you can resolve and ping the DNS names of your HGS servers. 

   ```powershell
   Set-HgsClientConfiguration -AttestationServerUrl https://hgs.bastion.local/Attestation -KeyProtectionServerUrl https://hgs.bastion.local/KeyProtection/ 
   ```

10. The result of the above command should show that AttestationStatus = Passed. If it does not, see [Attestation Failures](https://docs.microsoft.com/windows-server/virtualization/guarded-fabric-shielded-vm/guarded-fabric-troubleshoot-hosts#attestation-failures) for guidance on how to resolve the error.   
11. Repeat steps 1-10 for each host machine. 
    If you are using identical hardware, you will not need to capture a new baseline or CI policy for every machine. 
    The baseline from your first server will cover all identically configured machines, and the CI policy can be re-used across multiple machines so long as Microsoft software is the only software on the machine.

### Collecting Host Keys 

> [!NOTE] 
> Host key attestation is only recommended for use in test environments. 
> TPM attestation provides the strongest assurances that VBS enclaves processing your sensitive data on SQL Server are running trusted code and the machines are configured with the recommended security settings. 

If you chose to set up HGS in host key attestation mode, you’ll need to generate and collect keys from each host machine and register them with the Host Guardian Service. 

1. To get the HGS client installed on your host machine, install the Guarded Host feature, which will also install Hyper-V. 
   While you will not be running VMs on this machine, the hypervisor is required to enable the virtualization-based security features that isolate the VBS enclaves that run Always Encrypted queries. 

   ```powershell
   Enable-WindowsOptionalFeature -Online -FeatureName HostGuardian -All 
   ```

2. Restart your computer when prompted to complete installation of Hyper-V.
3. Generate a unique host key and export the resulting public key to a file. 

   ```powershell
   Set-HgsClientHostKey 
   mkdir C:\artifacts 
   Get-HgsClientHostKey -Path C:\artifacts\$env:computername.cer 
   ```
   
   Alternatively, you can specify a thumbprint if you want to use your own certificate. 
   This can be useful if you want to share a certificate across multiple machines, or use a certificate bound to a TPM or an HSM. Here’s an example of creating a TPM-bound certificate (which prevents it from having the private key stolen and used on another machine and requires only a TPM 1.2):

   ```powershell
   $tpmBoundCert = New-SelfSignedCertificate -Subject “Host Key Attestation ($env:computername)” -Provider “Microsoft Platform Crypto Provider”
   Set-HgsClientHostKey -Thumbprint $tpmBoundCert.Thumbprint
   ```

4. Copy the host key to the Host Guardian Service. 
5. Register the host key with any HGS node, using a relevant name and path for your environment: 

   ```powershell
   Add-HgsAttestationHostKey -Name 'ServerA' -Path C:\temp\ServerA.cer 
   ``` 

6. Your first server is now ready to attest! 
   On the host machine, run the following command to tell it where to attest (change the DNS name to that of your HGS cluster, typically you will use the HGS Service Name combined with the HGS domain name). 
   If you receive a HostUnreachable error, ensure you can resolve and ping the DNS names of your HGS servers.    

   ```powershell
   Set-HgsClientConfiguration -AttestationServerUrl http://hgs.bastion.local/Attestation -KeyProtectionServerUrl http://hgs.bastion.local/KeyProtection/  
   ```

7. The result of the above command should show that AttestationStatus = Passed. 
   If you get a HostUnreachable error, that means your host machine cannot communicate with HGS. 
   Ensure that DNS resolution is set up between the host machine and the HGS servers and that you can ping the servers. 
   An UnauthorizedHost error indicates that the public key was not registered with the HGS server – repeat steps 4 and 5 to resolve the error. 
   If all else fails, run Clear-HgsClientHostKey and repeat steps 3-6.   

8. Repeat steps 1-7 for each server that will run SQL Server Always Encrypted using VBS enclaves.     


