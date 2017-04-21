# Configure Nano Server as a guarded host

There are a few different ways to deploy Nano Servers. This section follows the [Nano Server Quick Start](https://technet.microsoft.com/windows-server-docs/get-started/nano-server-quick-start#to-quickly-deploy-nano-server-on-a-physical-computer). In a nutshell, you will create a VHDX file using the New-NanoServerImage cmdlet, and on a physical computer, modify the boot entry to set the default boot option to the VHDX file. All the management of the Nano server is done through Windows PowerShell remoting.

> [!NOTE]
> Nano Server can only run shielded VMs in a guarded fabric; it cannot be used to run shielded VMs without the use of HGS to unlock the virtual TPM devices. This means that you cannot use Nano Server to create a new shielded VM on-premises and move it to a guarded fabric, because Nano Server does not support the use of local key material to start up shielded VMs.

## Creating a Nano Server image

These steps are from [Nano Server Quick Start](https://technet.microsoft.com/windows-server-docs/get-started/nano-server-quick-start#to-quickly-deploy-nano-server-on-a-physical-computer):

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

When you specify the domain name, the Nano Server will be joined to the defined domain. To do this, the machine you are running the cmdlet from should be already be joined to the same domain. This allows the cmdlet to harvest a domain blob from the local computer. If you are planning to use TPM mode, you are not required to join the Nano Server to a domain. For AD mode, the Nano Server must be joined to a domain.

<!-- Appears in guarded-fabric-tpm-trusted-attestation-capturing-hardware.md and guarded-fabric-admin-trusted-attestation-creating-a-security-group.md
-->