---
title: Create a shielded VM using PowerShell
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/16/2017
---

# Create a shielded VM using PowerShell

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

>[!div class="step-by-step"]
[« Create a shielding data file](guarded-fabric-tenant-creates-shielding-data.md)
[Deploy a shielded using VMM »](guarded-fabric-tenant-deploys-shielded-vm-using-vmm.md)

In production, you would typically use a fabric manager (e.g. VMM) to deploy shielded VMs. 
However, the steps illustrated below allow you to deploy and validate the entire scenario without a fabric manager.

In a nutshell, you will create a template disk, a shielding data file, an unattended installation answer file and other security artifacts on any machine, then copy these files to a guarded host and provision the shielded VM.

## Create a signed template disk

To create a new shielded VM, you first need a shielded VM template disk that is pre-encrypted with its OS (or boot and root, for Linux) volumes signed.
Follow the links below for more information on how to create a template disk.

- [Prepare a Windows template disk](guarded-fabric-create-a-shielded-vm-template.md)
- [Prepare a Linux template disk](guarded-fabric-create-a-linux-shielded-vm-template.md)

You will also need a copy of the disk's volume signature catalog to create the shielding data file.
To save this file, run the following command:

```powershell
Save-VolumeSignatureCatalog -TemplateDiskPath "C:\temp\MyTemplateDisk.vhdx" -VolumeSignatureCatalogPath "C:\temp\MyTemplateDiskCatalog.vsc"
```

## Download guardian metadata

For each of the virtualization fabrics where you wish to run your shielded VM, you will need to obtain guardian metadata for the fabrics' HGS clusters.
Your hosting provider should be able to provide this information for you.

If you are in an enterprise environment and can communicate with the HGS server, the guardian metadata is available at *http://<HGSCLUSTERNAME>/KeyProtection/service/metadata/2014-07/metadata.xml*.

## Create Shielding Data (PDK) file

Shielding Data is created and owned by tenant VM owners and contains secrets needed to create shielded VMs that must be protected from the fabric admin, such as the shielded VM's administrator password.
Shielding Data is encrypted such that only the HGS servers and tenant can decrypt it.
Once created by the tenant/VM owner, the resulting PDK file must be copied to the guarded fabric.
For more information, see [What is shielding data and why is it necessary?](guarded-fabric-and-shielded-vms.md#what-is-shielding-data-and-why-is-it-necessary).

In addition, you will need an unattended installation answer file (unattend.xml for Windows, varies for Linux). For a working sample, see [Create an answer file](guarded-fabric-tenant-creates-shielding-data.md#create-an-answer-file).

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
New-ShieldingDataFile -ShieldingDataFilePath 'C:\Contoso.pdk' -Owner $Owner –Guardian $guardian –VolumeIDQualifier (New-VolumeIDQualifier -VolumeSignatureCatalogFilePath 'C:\ServerOSTemplate.vsc' -VersionRule Equals) -WindowsUnattendFile 'C:\unattend.xml' -Policy Shielded
```
    
## Provision shielded VM on a guarded host
Copy the template disk file (ServerOS.vhdx) and the PDK file (contoso.pdk) to the guarded host, to get ready for deployment.

The unattended installation file may have placeholder fields that need to be substituted during deployment to ensure the resulting VM is unique and fully configured, e.g. it contains a computer name and a timezone. These unique values are specified in a FSK (Fabric Specialization Key) file. To create one, use the [New-ShieldedVMSpecializationDataFile](https://docs.microsoft.com/en-us/powershell/module/shieldedvmprovisioning/new-shieldedvmspecializationdatafile?view=win10-ps)

    ```powershell
    <#
    .SYNOPSIS
    This script will provisioin a new shielded VM from existing disk template and a PDK file.   
 
    .DESCRIPTION
    You will need a PDK and associated disk template file prior for shielded VM provisioning
    
    .PARAMETER VMName
    The name of the VM to be created
    
    .PARAMETER PdkFile
    The path for the pdk file
    
    .PARAMETER TemplateDiskPath
    The path for the disk template
    
    .PARAMETER VMPath
    The path for VM location.

    .PARAMETER Linux
    Specifies whether the target OS is Linux
    
    #>
    Param
    (
        [Parameter (Mandatory=$true)][string] $VMName,
        [Parameter (Mandatory=$true)][string] $PdkFile,
        [Parameter (Mandatory=$true)][string] $TemplateDiskPath,
        [Parameter (Mandatory=$true)][string] $VMPath,
        [string] $switch = 'External',
        [Int64] $VMMemSize = 1GB,
        [switch] $Linux = $False
    )
    
    $VmVhdPath = $VMPath + '\' + $VMName + '.vhdx'
    $fskFile = $VMPath + '\' + $VMName + '.fsk'
    
    #check if the VMPath exist
    #create the folder
    If ((Test-Path $VMPath) -eq $false) 
    {
        New-Item $VMPath -Type Directory
    }
    
    #create fsk file
    New-ShieldedVMSpecializationDataFile -ShieldedVMSpecializationDataFilePath $fskfile -SpecializationDataPairs @{ '@ComputerName@' = "$VMName"; '@TimeZone@' = 'Pacific Standard Time' }
    
    #Make a copy of the template
    Copy-Item -Path $TemplateDiskPath -Destination $VmVhdPath
    
    #create VM
    $vm = New-VM -Name $VMName -Generation 2 -VHDPath $VmVhdPath -MemoryStartupBytes $VMMemSize -Path $VMPath -SwitchName $switch -erroraction Stop
    if ($Linux) {
        Set-VMFirmware -VM $vm -SecureBootTemplate OpenSourceShieldedVM
    }
    
    $kp = Get-KeyProtectorFromShieldingDataFile -ShieldingDataFilePath $PdkFile
    Set-VMkeyProtector -VM $vm -KeyProtector $kp
    
    #Get PDK security policy
    $importpdk = Invoke-CimMethod -ClassName  Msps_ProvisioningFileProcessor -Namespace root\msps -MethodName PopulateFromFile -Arguments @{FilePath=$PdkFile }
    $cimvm = Get-CimInstance  -Namespace root\virtualization\v2 -Class Msvm_ComputerSystem -Filter "ElementName = '$VMName'"
     
    $vsd = Get-CimAssociatedInstance -InputObject $cimvm -ResultClassName "Msvm_VirtualSystemSettingData"
    $vmms = gcim -Namespace root\virtualization\v2 -ClassName Msvm_VirtualSystemManagementService
    $ssd = Get-CimAssociatedInstance -InputObject $vsd -ResultClassName "Msvm_SecuritySettingData"
    $ss = Get-CimAssociatedInstance -InputObject $cimvm -ResultClassName "Msvm_SecuritySErvice"
    $cimSerializer = [Microsoft.Management.Infrastructure.Serialization.CimSerializer]::Create()
    $ssdString = [System.Text.Encoding]::Unicode.GetString($cimSerializer.Serialize($ssd, [Microsoft.Management.Infrastructure.Serialization.InstanceSerializationOptions]::None))
    $result = Invoke-CimMethod -InputObject $ss -MethodName SetSecurityPolicy -Arguments @{"SecuritySettingData"=$ssdString;"SecurityPolicy"=$importPdk.ProvisioningFile.PolicyData}
    
    Enable-VMTPM -vm $vm
    Initialize-ShieldedVM -VM $vm -ShieldingDataFilePath $PdkFile -ShieldedVMSpecializationDataFilePath $fskfile
    ```
    
While the shielded VM is being provisioned, you can use the following cmdlet to check the progress:


```powershell
Get-ShieldedVMProvisioningStatus -VMName $vmname
```

Once it's completed, make sure the shielded VM has the correct network adapter configured so it can be accessed through RDP.

## Running Shielded VMs on a Hyper-V cluster

If you are trying to deploy shielded VMs on clustered guarded hosts (using a Windows Failover Cluster), you can configure the shielded VM to be highly available using the following cmdlet:

```powershell
Add-ClusterVirtualMachineRole -VMName 'contososvm1' -Cluster <guarded host cluster name>
```
    
The shielded VM can now be live migrated within the cluster.