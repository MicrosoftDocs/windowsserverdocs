---
title: Shielded VMs for tenants - Creating a template disk - optional
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: c1992f8b-6f88-4dbc-b4a5-08368bba2787
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Shielded VMs for tenants - Creating a template disk (optional)

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

To create a new shielded VM, you will need to use a specially prepared, signed template disk. Metadata from signed template disks helps ensure that the disks are not modified after they have been created and allows you as a tenant to restrict which disks can be used to create your shielded VMs. One way to provide this disk is for you, the tenant, to create it, as described in this topic. 

> [!IMPORTANT]
> If you prefer, you can instead use a template disk provided by your hosting service provider. If you do this, it is important to deploy a test VM using that template disk and run your own tools (antivirus, vulnerability scanners, and so on) to validate the disk is, in fact, in a state that you trust.

## Prepare an operating system VHDX

In order to create a shielded template disk, you need to first prepare an OS disk that will be run through the template disk wizard. This disk will be used as the OS disk in shielded VMs. You can use any existing tooling to create this disk, such as Microsoft Desktop Image Service Manager (DISM), or manually set up a VM with a blank VHDX and install the OS onto that disk. When setting up the disk, it must adhere to the following requirements that are specific to generation 2 and/or shielded VMs: 

| Requirement for VHDX | Reason |
|-----------|----|
|Must be a GUID Partition Table (GPT) disk | Needed for generation 2 virtual machines to support UEFI|
|Disk type must be **Basic** as opposed to **Dynamic**. <br>Note: This refers to the logical disk type, not the "dynamically expanding" VHDX feature supported by Hyper-V. | BitLocker does NOT support dynamic disks.|
|The disk has at least two partitions. One partition must include the drive on which Windows is installed. This is the drive that BitLocker will encrypt. The other partition is the active partition, which contains the bootloader and remains unencrypted so that the computer can be started.|Needed for BitLocker|
|File system is NTFS | Needed for BitLocker|
|The operating system installed on the VHDX is one of the following:<br>- Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, or Windows Server 2012 <br>- Windows 10, Windows 8.1, Windows 8| Needed to support generation 2 virtual machines and the Microsoft Secure Boot template|
|Operating system must be generalized (run sysprep.exe) | Template provisioning involves specializing VMs for a specific tenant's workload| 

> [!NOTE]
> Do not copy the template disk into the VMM library at this stage. 

### Required packages to create a Nano Server template disk

If you are planning to run Nano Server as your guest OS in shielded VMs, you must ensure your Nano Server image includes the following packages:

- Microsoft-NanoServer-Guest-Package
- Microsoft-NanoServer-SecureStartup-Package

## Run Windows Update on the template operating system

On the template disk, verify that the operating system has all of the latest Windows updates installed. Recently released updates improve the reliability of the end-to-end shielding process - a process that may fail to complete if the template operating system is not up-to-date.

## Sign and protect the VHDX with the template disk wizard

To use a template disk with shielded VMs, the disk must be signed and encrypted with BitLocker. To do this, you will use the Shielded Template Disk Creation Wizard. This wizard will generate a hash for the disk and add it to a volume signature catalog (VSC). The VSC is signed using a certificate you specify and is used during the provisioning process to ensure the disk being deployed for a tenant has not been altered or replaced with a disk the tenant does not trust. Finally, BitLocker is installed on the disk's operating system (if it is not already there) to prepare the disk for encryption during VM provisioning.

> [!NOTE]
> The template disk wizard will modify the template disk you specify in-place. You may want to make a copy of the unprotected VHDX before running the wizard to make updates to the disk at a later time. You will not be able to modify a disk that has been protected with the template disk wizard.

Perform the following steps on a computer running Windows Server 2016 (does not need to be a guarded host or your VMM server):

1. Copy the generalized VHDX created in [Prepare an operating system VHDX](#prepare-an-operating-system-vhdx) to the server, if it is not already there.

2. Install the **Shielded VM Tools** feature from **Remote Server Administration Tools** on the machine.

        Install-WindowsFeature RSAT-Shielded-VM-Tools -Restart

3. Obtain or create a certificate to sign the VHDX that will become the template disk for new shielded VMs. Details about this certificate will be incorporated into a shielding data file, which authorizes the disk as a trusted disk. Therefore, it is important to obtain this certificate from a certificate authority that you and your hosting service provider trust. In enterprise scenarios where you are both the hoster and tenant, you might consider issuing this certificate from your PKI.

    If you are setting up a test environment and just want to use a self-signed certificate to sign your template disk, run a command similar to the following on your machine:

        New-SelfSignedCertificate -DnsName publisher.fabrikam.com

4. Start the **Template Disk Wizard** from the **Administrative Tools** folder on the Start menu or by typing **TemplateDiskWizard.exe** into a command prompt.

5. On the **Certificate** page, click **Browse** to display a list of certificates. Select the certificate with which to sign the disk template. Click **OK** and then click **Next**.

6. On the Virtual Disk page, click **Browse** to select the VHDX that you have prepared, then click **Next**.

7. On the Signature Catalog page, provide a friendly **disk name** and **version.** These fields are present to help you identify the disk once it has been signed.

    For example, for **disk name** you could type _WS2016_ and for **Version**, _1.0.0.0_

8. Review your selections on the Review Settings page of the wizard. When you click **Generate**, the wizard will enable BitLocker on the template disk, compute the hash of the disk, and create the Volume Signature Catalog, which is stored in the VHDX metadata.

    Wait until the signing process has finished before attempting to mount or move the template disk. This process may take a while to complete, depending on the size of your disk. 

9. On the **Summary** page, information about the disk template, the certificate used to sign the template, and the certificate issuer is shown. Click **Close** to exit the wizard.


Provide the shielded disk template to the hosting service provider, along with a shielding data file that you create, as described in [Creating shielding data to define a shielded VM](guarded-fabric-tenant-creates-shielding-data.md).

## See also

- [Deploy shielded VMs](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
