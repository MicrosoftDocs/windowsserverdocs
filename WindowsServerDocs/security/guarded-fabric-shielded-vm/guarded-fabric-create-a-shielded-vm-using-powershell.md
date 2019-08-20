---
title: Create a shielded VM using PowerShell
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Create a shielded VM using PowerShell

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

In production, you would typically use a fabric manager (e.g. VMM) to deploy shielded VMs. 
However, the steps illustrated below allow you to deploy and validate the entire scenario without a fabric manager.

In a nutshell, you will create a template disk, a shielding data file, an unattended installation answer file and other security artifacts on any machine, then copy these files to a guarded host and provision the shielded VM.

## Create a signed template disk

To create a new shielded VM, you first need a shielded VM template disk that is pre-encrypted with its OS volume (or boot and root partitions on Linux) signed.
Follow the links below for more information on how to create a template disk.

- [Prepare a Windows template disk](guarded-fabric-create-a-shielded-vm-template.md)
- [Prepare a Linux template disk](guarded-fabric-create-a-linux-shielded-vm-template.md)

You will also need a copy of the disk's volume signature catalog to create the shielding data file.
To save this file, run the following command on the machine where you created the template disk:

```powershell
Save-VolumeSignatureCatalog -TemplateDiskPath "C:\temp\MyTemplateDisk.vhdx" -VolumeSignatureCatalogPath "C:\temp\MyTemplateDiskCatalog.vsc"
```

## Download guardian metadata

For each of the virtualization fabrics where you wish to run your shielded VM, you will need to obtain guardian metadata for the fabrics' HGS clusters.
Your hosting provider should be able to provide this information for you.

If you are in an enterprise environment and can communicate with the HGS server, the guardian metadata is available at *http://\<HGSCLUSTERNAME\>/KeyProtection/service/metadata/2014-07/metadata.xml*

## Create Shielding Data (PDK) file

Shielding Data is created and owned by tenant VM owners and contains secrets needed to create shielded VMs that must be protected from the fabric admin, such as the shielded VM's administrator password.
Shielding Data is encrypted such that only the HGS servers and tenant can decrypt it.
Once created by the tenant/VM owner, the resulting PDK file must be copied to the guarded fabric.
For more information, see [What is shielding data and why is it necessary?](guarded-fabric-and-shielded-vms.md#what-is-shielding-data-and-why-is-it-necessary).

In addition, you will need an unattended installation answer file (unattend.xml for Windows, varies for Linux). See [Create an answer file](guarded-fabric-tenant-creates-shielding-data.md#create-an-answer-file) for guidance on what to include in the answer file.

Run the following cmdlets on a machine with the Remote Server Administration Tools for Shielded VMs installed.
If you are creating a PDK for a Linux VM, you must do this on a server running Windows Server, version 1709 or later.

 
```powershell
# Create owner certificate, don't lose this!
# The certificate is stored at Cert:\LocalMachine\Shielded VM Local Certificates
$Owner = New-HgsGuardian –Name 'Owner' –GenerateCertificates
 
# Import the HGS guardian for each fabric you want to run your shielded VM
$Guardian = Import-HgsGuardian -Path C:\HGSGuardian.xml -Name 'TestFabric'
 
# Create the PDK file
# The "Policy" parameter describes whether the admin can see the VM's console or not
# Use "EncryptionSupported" if you are testing out shielded VMs and want to debug any issues during the specialization process
New-ShieldingDataFile -ShieldingDataFilePath 'C:\temp\Contoso.pdk' -Owner $Owner –Guardian $guardian –VolumeIDQualifier (New-VolumeIDQualifier -VolumeSignatureCatalogFilePath 'C:\temp\MyTemplateDiskCatalog.vsc' -VersionRule Equals) -WindowsUnattendFile 'C:\unattend.xml' -Policy Shielded
```
    
## Provision shielded VM on a guarded host
Copy the template disk file (ServerOS.vhdx) and the PDK file (contoso.pdk) to the guarded host to get ready for deployment.

On the guarded host, install the Guarded Fabric Tools PowerShell module, which contains the New-ShieldedVM cmdlet to simplify the provisioning process. If your guarded host has access to the Internet, run the following command:

```powershell
Install-Module GuardedFabricTools -Repository PSGallery -MinimumVersion 1.0.0
```

You can also download the module on another computer that has Internet access and copy the resulting module to `C:\Program Files\WindowsPowerShell\Modules` on the guarded host.

```powershell
Save-Module GuardedFabricTools -Repository PSGallery -MinimumVersion 1.0.0 -Path C:\temp\
```

Once the module is installed, you're ready to provision your shielded VM.

```powershell
New-ShieldedVM -Name 'MyShieldedVM' -TemplateDiskPath 'C:\temp\MyTemplateDisk.vhdx' -ShieldingDataFilePath 'C:\temp\Contoso.pdk' -Wait
```

If your template disk contains a Linux-based OS, include the `-Linux` flag when running the command:

```powershell
New-ShieldedVM -Name 'MyLinuxVM' -TemplateDiskPath 'C:\temp\MyTemplateDisk.vhdx' -ShieldingDataFilePath 'C:\temp\Contoso.pdk' -Wait -Linux
```

Check the help content using `Get-Help New-ShieldedVM -Full` to learn more about other options you can pass to the cmdlet.

Once the VM finishes provisioning, it will enter the OS-specific specialization phase, after which it will be ready for use.
Be sure to connect the VM to a valid network so you can connect to it once it is running (using RDP, PowerShell, SSH, or your preferred management tool).

## Running Shielded VMs on a Hyper-V cluster

If you are trying to deploy shielded VMs on clustered guarded hosts (using a Windows Failover Cluster), you can configure the shielded VM to be highly available using the following cmdlet:

```powershell
Add-ClusterVirtualMachineRole -VMName 'MyShieldedVM' -Cluster <Hyper-V cluster name>
```

The shielded VM can now be live migrated within the cluster.

## Next step

> [!div class="nextstepaction"]
> [Deploy a shielded using VMM](guarded-fabric-tenant-deploys-shielded-vm-using-vmm.md)