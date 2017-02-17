---
title: Appendix A - Configure Nano server as TPM attested guarded host
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 40d2a967-a6ee-4b46-aead-e3a0b275e212
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Appendix A - Configure Nano Server as a TPM-attested guarded host

>Applies To: Windows Server 2016

There are a few different ways to deploy Nano Servers. This section follows the instructions illustrated in [Nano Server Quick Start](https://technet.microsoft.com/windows-server-docs/get-started/nano-server-quick-start#to-quickly-deploy-nano-server-on-a-physical-computer). In a nutshell, you will create a VHDX file using the New-NanoServerImage cmdlet, and on a physical computer, modify the boot entry to set the default boot option to the VHDX file. All the management of the Nano server is done through Windows PowerShell remoting.

## Nano Server as a guarded host

Guarded hosts that run on Nano Server have these limitations:

- Nano Server can only run shielded VMs in a guarded fabric; it cannot be used to run shielded VMs without the use of HGS to unlock the virtual TPM devices. This means that you cannot use Nano Server to create a new shielded VM on-premises and move it to a guarded fabric, because Nano Server does not support the use of local key material to start up shielded VMs.

- If you are using VMM to manage a guarded host running Nano Server, you can't use the "Apply latest CI Policy" feature to deploy updated code integrity (CI) policies to Nano Server. Instead, you will have to manually copy your CI policy (SIPolicy.p7b) to C:\Windows\System32\CodeIntegrity\SIPolicy.p7b and restart the host to apply it. Enforcement of the CI policy remains the same as with the Server Core and Desktop Experience.

## Creating a Nano Server image

The following steps are from [Nano Server Quick Start](https://technet.microsoft.com/windows-server-docs/get-started/nano-server-quick-start#to-quickly-deploy-nano-server-on-a-physical-computer):

1.  Copy the **NanoServerImageGenerator** folder from the \\NanoServer folder in the Windows Server 2016 ISO to a folder on your hard drive.

2.  Start Windows PowerShell as an administrator, change directory to the folder where you have placed the NanoServerImageGenerator folder (e.g. c:\\NanoServer\\NanoServerImageGenerator) and then run:

    ```powershell
    Import-Module .\NanoServerImageGenerator -Verbose
    ```

3.  Create the Nano Server image using the following set of commands:

    ```powershell
    $mediapath = <location of the mounted ISO image, e.g. E:\>

    New-NanoServerImage -MediaPath $mediapath -TargetPath <nanoVHD path> -ComputerName "<nanoserver name>" -OEMDrivers -Compute -DeploymentType Host -Edition Datacenter -Packages Microsoft-NanoServer-SecureStartup-Package, Microsoft-NanoServer-ShieldedVM-Package -EnableRemoteManagementPort -DomainName <Domain Name>
    ```

    The command will complete in a few minutes.

When you specify the domain name, the Nano Server will be joined to the defined domain. To do this, the machine you are running the cmdlet from should be already be joined to the same domain. This allows the cmdlet to harvest a domain blob from the local computer. If you are planning to use TPM-trusted attestation, you are not required to join the Nano Server to a domain. For Admin-trusted attestation, the Nano Server must be joined to a domain.

## Creating a code integrity policy for a Nano Server

If you are using TPM-trusted attestation and you create a host with a new configuration, such as the first Nano Server in your guarded fabric, you will need to [create a code integrity (CI) policy](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md#create-and-apply-a-code-integrity-policy) based on this image.

If you already created code integrity policies for this image, and captured other hardware and software information that HGS uses in attestation, you can proceed to [Configure the boot menu](#configure-the-boot-menu).

### Differences in creating a code integrity policy for a Nano Server

On Nano Server, you can only create the code integrity policy against an offline image.

Mount the Nano Server VHDX and run [New-CIPolicy](https://technet.microsoft.com/library/mt634473.aspx) in a command like the following from the management server. This example uses G: as the drive on which the VHDX is mounted.

```powershell
New-CIPolicy -FilePath .\NanoCI.xml -Level FilePublisher -Fallback Hash -ScanPath G:\ -PathToCatroot G:\Windows\System32\CatRoot\ -UserPEs
```

>**Note**&nbsp;&nbsp;The CI policy will need to be added to the HGS Server. For more information, see [Add host information for TPM-trusted attestation](guarded-fabric-setting-up-the-host-guardian-service-hgs.md#add-host-information-for-tpm-trusted-attestation).

## Configure the boot menu

After the Nano Server image is created, you will need to set it as the default boot OS.

Copy the Nano Server VHDX file to the physical computer and configure it to boot from that computer:

1.   In File Explorer, mount the generated VHDX file by right-clicking the file and selecting **Mount**. In this example, it is mounted under D:\\.

2.   Run:
    `bcdboot d:\windows`

3.   Right-click the VHDX file and select **Eject** to unmount it.

Restart the computer to boot into Nano Server. Now the Nano Server is ready, and you can follow the steps in [Configuration steps for Hyper-V hosts that will become guarded hosts](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md).

## Getting Nano Server IP

There isn't much you need to configure on the Nano Server. Everything you do will be done through the remote Windows PowerShell session. You will need to get the Nano Server IP address or use the server name for management. In places where this topic uses the IP address as the example, you can replace it with the server name.

-   Log on to the Recovery Console, using the administrator account and password you supplied to build the Nano image.

-   Obtain the IP address of the Nano Server computer and use Windows PowerShell remoting or other remote management tools to connect to and remotely manage the Nano Server.

## Remote management

To run commands on Nano Server such as Get-PlatformIdentifier, you need to connect to the Nano Server from a separate management server running an operating system with a graphical user interface using Windows PowerShell Remoting.

To enable the management server to start the Windows PowerShell remoting session:

```powershell
Set-Item WSMan:\localhost\Client\TrustedHosts <nano server ip or name>
```

This cmdlet just needs to be run once on the management server.

To start a remote session:

```powershell
Enter-PSSession -ComputerName <nano server name or ip> -Credential <nano server name or ip>\administrator
```

Occasionally, you might get an access denied error when running the cmdlets above. You can reset the WinRM settings and firewall rules on the Nano Server by logging on to the Nano Server recovery console and selecting the WinRM option.

## See also

- [Guarded fabric and shielded VMs](guarded-fabric-and-shielded-vms-top-node.md)
