## Configuring the boot menu

After the Nano Server image is created, you will need to set it as the default boot OS.

Copy the Nano Server VHDX file to the physical computer and configure it to boot from that computer:

1.   In File Explorer, right-click the generated VHDX and select **Mount**. In this example, it is mounted under D:\\.

2.   Run:
    `bcdboot d:\windows`

3.   Right-click the VHDX file and select **Eject** to unmount it.

Restart the computer to boot into Nano Server. Now the Nano Server is ready.

## Getting the IP address

You will need to get the Nano Server IP address or use the server name for management. 

-   Log on to the Recovery Console, using the administrator account and password you supplied to build the Nano image.

-   Obtain the IP address of the Nano Server computer and use Windows PowerShell remoting or other remote management tools to connect to and remotely manage the Nano Server.

## Remote management

To run commands on Nano Server such as Get-PlatformIdentifier, you need to connect to the Nano Server from a separate management server running an operating system with a graphical user interface using Windows PowerShell Remoting.

To enable the management server to start the Windows PowerShell remoting session:

```powershell
Set-Item WSMan:\localhost\Client\TrustedHosts <nano server ip address or name>
```

This cmdlet just needs to be run once on the management server.

To start a remote session:

```powershell
Enter-PSSession -ComputerName <nano server name or ip address> -Credential <nano server>\administrator
```

Occasionally, you might get an access denied error when running the preceding cmdlets. You can reset the WinRM settings and firewall rules on the Nano Server by logging on to the Nano Server recovery console and selecting the WinRM option.


<!-- Appears in guarded-fabric-tpm-trusted-attestation-capturing-hardware.md and guarded-fabric-admin-trusted-attestation-creating-a-security-group.md
-->