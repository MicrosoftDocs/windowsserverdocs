---
title: 7 Scenario #1 – Create a new shielded VM on the tenant Hyper-V host and run it on the guarded host
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e19aa5f3-81ac-47d9-b700-1b41b6eb3c35
robots: noindex,nofollow
---
# 7 Scenario #1 – Create a new shielded VM on the tenant Hyper-V host and run it on the guarded host
Use the following steps to manually create a shielded virtual machine on a tenant Hyper-V host computer and grant permission to run the VM in the Guarded Fabric environment.  
  
Do these steps on a physical server running Windows Server Technical Preview 3 (build \#10514) with the following roles and features installed:    
  1.	Role    
    a.	Hyper-V     
  2.	Features    
    a.	Host Guardian Hyper-V Support    
    b.	Remote Server Administration Tools\Shielded VM Tools  
  
### 7.1  Import the guardian configuration on the tenant Hyper-V server  
Do this step on a tenant Hyper-V (physical) server running Windows Server Technical Preview 3 (build #10514) with following roles and features installed:    
  1. Role    
    2. Hyper-V     
  3. Features    
    4. Host Guardian Hyper-V support    
    5. Remote Server Administration Tools\Feature Administration Tools\Shielded VM Tools    
  
1.	To get guardian key metadata using Internet Explorer, browse to the following URL:  
  
  [http://relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml](http://relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml)  
  
2.	Save the page as C:\temp\GuardianKey.xml.   
  
  >If you don’t have name resolution and/or connectivity between the tenant Hyper-V Host and HGS infrastructure, you can download it on the HGS server and transfer it offline to the tenant Hyper-V Host.    
  
3.	Import the guardian key. Review the following example, modify it as needed, and then run the following command:  
```Import-HgsGuardian -Path ‘C:\temp\GuardianKey.xml’ -Name 'Guardian' -AllowUntrustedRoot```  
  
  The ```-AllowUntrustedRoot``` parameter is only required if you used self-signed certificates when setting up the Key Protection Service.  
  
### 7.2  Create a new VM on tenant Hyper-V  
  
1.  Review, modify as needed, and then run the following commands from a tenant Hyper-V host to create a new generation 2 virtual machine:  
  
  ```New-VM -Generation 2 -Name "ShieldVM1" -Path c:\\VMs -NewVHDPath c:\\VMs\\ShieldVM1\\ShieldVM1.vhdx -NewVHDSizeBytes 60GB```  
  
1.  Install the Windows Server Technical Preview 3 2016 operating system on the VM and enable the remote desktop connection and corresponding firewall rule. Record the VM’s IP address; you will need it to remotely connect to the server.  
  
2.  Use RDP to remotely connect to the VM.  
  
3.  Stop the VM by running the following command:  
  
  ```Stop-VM -Name ShieldVM1```  
  
1.  Create a new Host Guardian Service key protector using hosting service provide metadata and the tenant owner. Review the following example, modify it as needed, and then run the following commands:  
  
  ```$Guardian = Get-HgsGuardian -Name 'Guardian'```  
  
  ```$Owner = New-HgsGuardian –Name 'Owner' -GenerateCertificates```  
  
  ```$KP = New-HgsKeyProtector -Owner $Owner -Guardian $Guardian -AllowUntrustedRoot```  
  
1.  Enable the vTPM using the key protector. Review the following example, modify it as needed, and then run the following commands.  
  
        $VMName="ShieldVM1"    
        Stop-VM -Name $VMName -Force  
        # Add VTPM device on newly created Gen2 VM. VTPM device can only    
        # be added once.  
        Add-VMTPM -vmname $vmName  
  
        # Enable VTPM with newly created KP  
        Set-VMTPM -vmname $vmName -Enabled $true -KeyProtector $KP.RawData  
  
1.  Start the VM to verify that the key protector is working with local owner certificates. Review the following example, modify it as needed, and then run the following command.  
  
  ```Start-VM -Name $VMName```  
  
1.  Verify that the VM has started in the Hyper-V console.  
  
2.  Use RDP to remotely connect to the VM.  
  
3.  Enable BitLocker on all Virtual Hard Disk partitions that are attached to the shielded VM.  
  
  >**Important:** Wait for BitLocker encryption to finish on all partitions where you enabled it before proceeding to the next step.  
  
1.  Stop the VM. Review the following example, modify it as needed, and then run the following command.  
  
  ```Stop-VM -Name ShieldVM1```  
  
1.  Export the VM using the tool of your choice (PowerShell or Hyper-V MMC) from the tenant Hyper-V sever, and then copy the files to the guarded Hyper-V Host and import it using the following PowerShell commands:  
  
  ```$VMConfig = Get-childItem -Path 'C:\\vms\\ShieldVM1\\Virtual Machines\\' -Include "\*.vmcx" -Recurse```  
  
  ```Import-VM -path $VMConfig```  
  
1.  Start the VM on **GuardedHost**.  
  
  >***Important: At this point, the shielded VM will fail to start on the Hyper-V server because the host is not in a “guarded” state. To check the status of the guarded host, run the Get-HgsClientConfiguration cmdlet.***  
  
  ```Start-VM -Name ‘ShieldVM1’```  
  
1.  In order to make the host a guarded host, download the Guardian Key metadata using Internet Explorer by navigating to the following URL:    
  
  [http://relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml](http://relecloud.com/KeyProtection/service/metadata/2014-07/metadata.xml)  
  
2.  Save the page as C:\\temp\\GuardianKey.xml.  
  
  >*If you don’t have name resolution and/or connectivity between the tenant Hyper-V Host and the HGS infrastructure, you can download it on an HGS server and transfer it offline to the tenant Hyper-V Host.*  
  
1.  Import the guardian key and set the appropriate server URLs. Review the following example, modify it as needed, and then run the following commands.  
  
        Import-HgsGuardian -Path ‘C:\temp\GuardianKey.xml’ -Name 'Guardian' -AllowUntrustedRoot    
          
        Set-HgsClientConfiguration -AttestationServerUrl 'http://Relecloud.com/Attestation' -KeyProtectionServerUrl 'http://Relecloud.com/KeyProtection' -confirm:$false    
  
1.  You can run the Get-HgsClientConfiguration cmdlet to check the status of the guarded host. Start the virtual machine on **GuardedHost**.  
  
  ```Start-VM -Name ‘ShieldVM1’```  
  
  This verifies that the key protector works with the HGS guardian certificates.