---
title: Appendix A - Configure Nano server as TPM attested guarded host
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 40d2a967-a6ee-4b46-aead-e3a0b275e212
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
--

# Appendix A - Configure Nano server as TPM attested guarded host

>Applies To: Windows Server 2016

The following procedures illustrate how to create and configure Nano servers to be TPM trusted guarded hosts. For information about configuring the service that supports guarded hosts, see [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md).

There are a few different ways to deploy Nano servers. This section follows the instructions illustrated in [Nano Server Quick Start](https://technet.microsoft.com/windows-server-docs/get-started/nano-server-quick-start#to-quickly-deploy-nano-server-on-a-physical-computer). In a nutshell, you will create a VHDX file using the New-NanoServerImage cmdlet, and on a physical computer, modify the boot entry to set the default boot option to the VHDX file. All the management of the Nano server is done through Windows PowerShell remoting.

## Nano server as a guarded host

You can run shielded VMs on a Nano server configured as a guarded host. However, the HGS role is not supported on Nano Server. Note the following limitations for a guarded host run on Nano server:

- Nano Server can only run shielded VMs in a guarded fabric; it cannot be used to run shielded VMs without the use of HGS to unlock the virtual TPM devices. This means that you cannot use Nano Server to [Create a new shielded VM on-premises and move it to a guarded fabric](guarded-fabric-create-vm-move-to-guarded-fabric.md), because Nano Server does not support the use of local key material to start up shielded VMs.

- If you are using VMM to manage a guarded host running Nano server, you will not be able to use the ???Apply latest CI Policy??? feature to deploy updated code integrity (CI) policies to Nano server. Instead, you will have to manually copy your CI policy (SIPolicy.p7b) to C:\Windows\System32\CodeIntegrity\SIPolicy.p7b and restart the host to apply it. Enforcement of the CI policy remains the same as with the Core and Desktop Experience editions of Windows Server 2016.

## Creating a Nano server image

The following steps are from [Nano Server Quick Start](https://technet.microsoft.com/windows-server-docs/get-started/nano-server-quick-start#to-quickly-deploy-nano-server-on-a-physical-computer):

1.  Copy the **NanoServerImageGenerator** folder from the \\NanoServer folder in the Windows Server 2016 ISO to a folder on your hard drive.

2.  Start Windows PowerShell as an administrator, change directory to the folder where you have placed the NanoServerImageGenerator folder (e.g. c:\\NanoServer\\NanoServerImageGenerator) and then run

    `Import-Module .\NanoServerImageGenerator -Verbose`

3.  Create the Nano server image using the following set of commands:

    `$mediapath = <location of the mounted ISO image, e.g. E:\>`

    `New-NanoServerImage -MediaPath $mediapath -TargetPath <nanoVHD path> -ComputerName "<nanoserver name>" -OEMDrivers -Compute -DeploymentType Host -Edition Datacenter -Packages Microsoft-NanoServer-SecureStartup-Package, Microsoft-NanoServer-ShieldedVM-Package -EnableRemoteManagementPort ???DomainName <Domain Name>`

    The command will complete in a few minutes.

When you specify the domain name, the Nano server will be joined to the defined domain. To do this, the machine you are running the cmdlet from should be already be joined to the same domain. This allows the cmdlet to harvest a domain blob from the local computer. If you are planning to use TPM-trusted attestation, you are not required to join the Nano server to a domain. For Admin-trusted attestation, the Nano server must be joined to a domain.

## Creating a code integrity policy for a Nano server

If you are using TPM-trusted attestation and you create a host with a new configuration, such as the first Nano server in your guarded fabric, you will need to create a code integrity (CI) policy based on this image. Creating a code integrity policy is a part of the process described in [TPM-trusted attestation: capturing hardware and software information that HGS uses in attestation](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#tpm-trusted-attestation-capturing-hardware). Within that section, code integrity policies are described at [Create and apply a code integrity policy](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#create-and-apply-a-code-integrity-policy).

If you have already created code integrity policies for this image, and captured other hardware and software information that HGS uses in attestation, you can proceed to [Configure the boot menu](#configure-the-boot-menu), later in this topic.

### Differences in creating a code integrity policy for a Nano server

On Nano server, you can only create the code integrity policy against an offline image.

Mount the Nano server VHDX and run [New-CIPolicy](https://technet.microsoft.com/library/mt634473.aspx) in a command like the following from the management server. This example uses G: as the drive on which the VHDX is mounted.

`New-CIPolicy -FilePath .\NanoCI.xml -Level FilePublisher -Fallback Hash -ScanPath G:\ -PathToCatroot G:\Windows\System32\CatRoot\ -UserPEs`

>**Note**&nbsp;&nbsp;The CI policy will need to be added to the HGS server. For information about how to do this, see [Create and apply a code integrity policy](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#create-and-apply-a-code-integrity-policy).

## Configure the boot menu

After the Nano server image is created, you will need to set it as the default boot OS.

Copy the Nano server VHDX file to the physical computer and configure it to boot from that computer:

1.   In File Explorer, mount the generated VHDX file by right-clicking the file and selecting **Mount**. In this example, it is mounted under D:\\.

2.   Run:
    `bcdboot d:\windows`

3.   Unmount the VHDX by right-clicking the VHDX file and selecting **Eject**.

Restart the computer to boot into Nano server. Now the Nano server is ready, and you can follow the procedures in [Confirm hosts can attest successfully](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#confirm-hosts-can-attest-successfully) to configure the server as a guarded host.

## Getting Nano server IP

There isn???t much you need to configure on the Nano server. Everything you do will be done through the remote Windows PowerShell session. You will need to get the Nano server IP address or use the server name for management. In places where this topic uses the IP address as the example, you can replace it with the server name.

-   Log on to the Recovery Console, using the administrator account and password you supplied to build the Nano image.

-   Obtain the IP address of the Nano Server computer and use Windows PowerShell remoting or other remote management tools to connect to and remotely manage the Nano server.

## Remote management

To run commands on Nano server such as Get-PlatformIdentifier, you need to connect to the Nano server from a separate management server running an operating system with a graphical user interface using Windows PowerShell Remoting.

To enable the management server to start the Windows PowerShell remoting session:

`Set-Item WSMan:\localhost\Client\TrustedHosts <nano server ip or name>`

This cmdlet just needs to be run once on the management server.

To start a remote session:

`Enter-PSSession -ComputerName <nano server name or ip> -Credential <nano server name or ip>\administrator`

Occasionally, you might get an access denied error when running the cmdlets above. You can reset the WinRM settings and firewall rules on the Nano server by logging on to the Nano server recovery console and selecting the WinRM option.

## See also

- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
