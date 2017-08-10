---
title: Create a shielded VM using PowerShell
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

>[!div class="step-by-step"]
[« Create a shielding data file](guarded-fabric-tenant-creates-shielding-data.md)
[Deploy a shielded using VMM »](guarded-fabric-tenant-deploys-shielded-vm-using-vmm.md)
# Create a shielded VM using PowerShell

In production, you would typically use a fabric manager (e.g. VMM) to deploy shielded VMs. 
However, the steps illustrated below allow you to deploy and validate the entire scenario without a fabric manager.

In a nutshell, you will create a template disk, a shielding data file, a Windows unattend.xml file and other security artifacts on the tenant host, then copy these files to a guarded host and provision shielded VMs.

## Prerequisites
In order to create the template disk and the shielding data file, you will need to install the “Shielded VM Tools” feature under the Remote Server Administration Tools -> Feature Administration Tools on the tenant host machine. You can do this either in Server Manager or by running the following cmdlet:

    Install-WindowsFeature RSAT-Shielded-VM-Tools
    
Next, you will also need a VHDX file with a fully installed and sysprepped OS—we’ll call it ServerOS.vhdx.

## Create a signed template disk

In order to create the signed template disk, you will need to have a certificate to sign it. 
For simplicity, let’s create a self-signed certificate for this purpose.  
Run the following PowerShell commands on the tenant host:

    $cert = New-SelfSignedCertificate -DnsName 'signing.contoso.com'
    
Now, we sign the disk:

    Protect-TemplateDisk -Path ‘C:\ServerOS.vhdx’ -TemplateName "ServerOSTemplate" -Version 1.0.0.1 -Certificate $cert

## Create Shielding Data (PDK) file

Shielding Data is created and owned by tenant VM owners and contains secrets needed to create shielded VMs that must be protected from the fabric admin, such as the shielded VM’s administrator password.  
Shielding Data is contained in a PDK file which is also encrypted.  
Once created by the tenant/VM owner, the resulting PDK file must be copied to the guarded fabric. 
For more information, see [What is shielding data and why is it necessary?](guarded-fabric-and-shielded-vms.md#what-is-shielding-data-and-why-is-it-necessary).

In addition, you will need a Windows unattend.xml file. For a working sample, see [Create an answer file](guarded-fabric-tenant-creates-shielding-data.md#create-an-answer-file).
During deployment, you will need to import the HGS guardian. It will be referenced as ‘C:\HGSGuardian.xml’ below.
Run the following cmdlets on the tenant host to create the PDK:

#Create a VolumeSignatureCatalog file for the template disk, to ensure the template disk is not being tampered by anyone at the deployment time
Save-VolumeSignatureCatalog -TemplateDiskPath "ServerOS.vhdx" –VolumeSignatureCatalogPath "C:\ServerOSTemplate.vsc"
 
    ```powershell
    # Create owner certificate
    $Owner = New-HgsGuardian –Name 'Owner' –GenerateCertificates
 
    # Import the HGS guardian
    $Guardian = Import-HgsGuardian -Path C:\HGSGuardian.xml -Name 'TestFabric' –AllowUntrustedRoot
 
    # Create the PDK file on Server running post TP5 build
    New-ShieldingDataFile -ShieldingDataFilePath 'C:\Contoso.pdk' -Owner $Owner –Guardian $guardian –VolumeIDQualifier (New-VolumeIDQualifier -VolumeSignatureCatalogFilePath 'C:\ServerOSTemplate.vsc' -VersionRule Equals) -WindowsUnattendFile 'C:\unattend.xml' -policy Encryptionsupported
    ```
    
## Provision shielded VM on a guarded host
Copy the template disk file (ServerOS.vhdx) and the PDK file (contoso.pdk) to the guarded host, to get ready for deployment.

The Windows unattend.xml file has some placeholder settings that need to be substituted during deployment to ensure the resulting VM is unique and fully configured, e.g. it contains a computer name and a timezone. These unique values are specified in a FSK (Fabric Specialization Key) file. To create one, run the following cmdlet on the guarded host to create the FSK file, and provision a shielded VM using the signed template disk:

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
    
    #>
    Param
    (
        [Parameter (Mandatory=$true)][string] $VMName,
        [Parameter (Mandatory=$true)][string] $PdkFile,
        [Parameter (Mandatory=$true)][string] $TemplateDiskPath,
        [Parameter (Mandatory=$true)][string] $VMPath,
        [string] $switch = 'External',
        [Int64] $VMMemSize = 1GB
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

    Get-ShieldedVMProvisioningStatus -VMName $vmname

Once it’s completed, make sure the shielded VM has the correct network adapter configured so it can be accessed through RDP.

## Running Shielded VMs on a Hyper-V cluster

If you are trying to deploy shielded VMs on clustered guarded hosts (using a Windows Failover Cluster), you can configure the shielded VM to be highly available using the following cmdlet:

    Add-ClusterVirtualMachineRole -VMName 'contososvm1' -Cluster <guarded host cluster name>
    
The shielded VM can now be live migrated within the cluster.