---
redirect_url: guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md
title: Shielded VMs for tenants - Creating a new shielded VM on-premises and moving it to a guarded fabric
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 0ca1efa0-01f9-4b6f-87d4-c66db00d7d70
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Shielded VMs for tenants - Creating a new shielded VM on-premises and moving it to a guarded fabric

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes the steps to create a shielded VM using only Hyper-V; that is, without Virtual Machine Manager, template disks, or a shielding data file. This is an uncommon scenario for most public cloud hosting environments, but may be useful when testing a guarded fabric or in enterprise scenarios where a VM is being moved from a departmental fabric to shared IT infrastructure and must be encrypted before migration.

To understand how this topic fits in the overall process of deploying shielded VMs, see [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md).

## Import the guardian configuration on the tenant Hyper-V server

1.  Before beginning the procedure, make sure you are on a Hyper-V host running Windows Server 2016 with the following roles and features installed:

    - Role

        - Hyper-V

    - Features

        - Remote Server Administration Tools\\Feature Administration Tools\\Shielded VM Tools

    > [!NOTE]
    > The host used here should *not* be a host in the guarded fabric. This is a separate host where VMs are prepared before being moved to the guarded fabric.

2.  Before you can run a shielded VM on this machine, you will need to ensure Virtualization Based Security is enabled and running. Run the following command in an elevated Windows PowerShell window to install the Host Guardian Hyper-V Support feature. This will configure all of the necessary settings on your machine to be able to run shielded VMs.

        Install-WindowsFeature HostGuardian

3.  You will need to acquire the guardian metadata for the guarded fabric where your VM will run. This metadata is used to authorize that fabric to run your shielded VM. How you obtain this information will be different for each hosting service provider or enterprise. The hoster (or you, if you have access to the guarded fabric network) can acquire this information by running the following Windows PowerShell command:

        Invoke-WebRequest 'http://hgs.bastion.local/KeyProtection/service/metadata/2014-07/metadata.xml' -OutFile .\RelecloudGuardian.xml

    In the example above, "hgs" is the distributed network name of the HGS cluster and "bastion.local" is the name of the HGS domain.

4.  To import the guardian key, which you will need in a later procedure, run the following command.

    For &lt;Path&gt;&lt;Filename&gt;, substitute the path and filename of the XML file you saved in the previous step, for example: **C:\\temp\\GuardianKey.xml**

    For &lt;GuardianName&gt;, specify a name for your hosting provider or enterprise datacenter, for example, **HostingProvider1**. Record the name for the next procedure.

    Include **-AllowUntrustedRoot** only if the HGS server was set up with self-signed certificates. (These certificates are part of the Key Protection Service in HGS.)

        Import-HgsGuardian -Path '<Path><Filename>' -Name '<GuardianName>' -AllowUntrustedRoot

## Create a new shielded virtual machine on the host

In this procedure, you will create a virtual machine on the Hyper-V host, and prepare it for export to your hosting provider or datacenter administrator, who can run it on a guarded host.

As part of the procedure, you will create a Key Protector that contains two important elements:

-   **Owner**: In the Key Protector, you - or more likely, the group you work in, that shares security elements such as certificates - are identified as "owner" of the VM. Your identity as owner is represented by a certificate that, if you run the commands as shown, is generated as a self-signed certificate. Optionally, you can instead use a certificate backed by PKI infrastructure, and omit the **-AllowUntrustedRoot** parameter in the commands.

-   **Guardians**: Also in the Key Protector, your hosting provider or enterprise datacenter (which runs HGS and guarded hosts) is identified as a "guardian." The guardian is represented by the guardian key that you imported in the previous procedure, [Import the guardian configuration on the tenant Hyper-V server](#import-the-guardian-configuration-on-the-tenant-hyper-v-server).

For an illustration showing the Key Protector, which is an element in a shielding data file, see [What is shielding data and why is it necessary?](guarded-fabric-and-shielded-vms.md#what-is-shielding-data-and-why-is-it-necessary).

1. On a tenant Hyper-V host, to create a new generation 2 virtual machine, run the following command.

   For &lt;ShieldedVMname&gt;, specify a name for the VM, for example: **ShieldVM1**
    
   For &lt;VHDPath&gt;, specify a location to store the VHDX of the VM, for example: **C:\\VMs\\ShieldVM1\\ShieldVM1.vhdx**
    
   For &lt;nnGB&gt;, specify a size for the VHDX, for example: **60GB**

       New-VM -Generation 2 -Name "<ShieldedVMname>" -NewVHDPath <VHDPath>.vhdx -NewVHDSizeBytes <nnGB>

2. Install a supported operating system (Windows Server 2012 or higher, Windows 8 client or higher) on the VM and enable the remote desktop connection and corresponding firewall rule. Record the VM's IP address and/or DNS name; you will need it to remotely connect to it.

3. Use RDP to remotely connect to the VM and verify that RDP and the firewall are configured correctly. As part of the shielding process, console access to the virtual machine through Hyper-V will be disabled, so it is important to ensure you are able to remotely manage the system over the network.

4. To create a new Key Protector (described at the beginning of this section), run the following command.

   For &lt;GuardianName&gt;, use the name you specified in the previous procedure, for example: **HostingProvider1**

   Include **-AllowUntrustedRoot** to allow for self-signed certificates.

       $Guardian = Get-HgsGuardian -Name '<GuardianName>'

       $Owner = New-HgsGuardian -Name 'Owner' -GenerateCertificates

       $KP = New-HgsKeyProtector -Owner $Owner -Guardian $Guardian -AllowUntrustedRoot

   If you wish for more than one datacenter to be able to run your shielded VM (for example, a disaster recovery site and a public cloud provider), you can provide a list of guardians to the **-Guardian** parameter. For more information, see [New-HgsKeyProtector](https://docs.microsoft.com/powershell/module/hgsclient/new-hgskeyprotector?view=win10-ps.

5. To enable the vTPM using the Key Protector, run the following command. For &lt;ShieldedVMname&gt;, use the same VM name used in previous steps.

       $VMName="<ShieldedVMname>"

       Stop-VM -Name $VMName -Force

       Set-VMKeyProtector -VMName $VMName -KeyProtector $KP.RawData

       Set-VMSecurityPolicy -VMName $VMName -Shielded $true

       Enable-VMTPM -VMName $VMName

6. To start the VM to verify that the key protector is working with local owner certificates, run the following command.

       Start-VM -Name $VMName

7. Verify that the VM has started in the Hyper-V console.

8. Use RDP to remotely connect to the VM and enable BitLocker on all partitions on all VHDXs that are attached to the shielded VM.

   > [!IMPORTANT]
   > Before proceeding to the next step, wait for BitLocker encryption to finish on all partitions where you enabled it.

9. Shut down the VM when you are ready to move it to the guarded fabric.

10. On the tenant Hyper-V server, export the VM using the tool of your choice (Windows PowerShell or Hyper-V Manager). Then arrange for the files to be copied to a guarded host maintained by your hosting provider or enterprise datacenter.

11. **For the hosting provider or enterprise datacenter**:

    Import the shielded VM using the Hyper-V Manager or Windows PowerShell. You must import the VM configuration file from the VM owner in order to start the VM. This is because the key protector and the VM's virtual TPM are stored in the configuration file. If the VM is configured to run on the guarded fabric, it should be able to start successfully.

## See also

- [Hosting service provider configuration steps for guarded hosts and shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
