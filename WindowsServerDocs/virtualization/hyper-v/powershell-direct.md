---
title: Manage Windows Virtual Machines with PowerShell Direct
description: Manage Windows Virtual Machines with PowerShell Direct.
keywords: windows 10, hyper-v, powershell, integration services, integration components, automation, powershell direct
author: robinharwood
ms.author: roharwoo
ms.date: 05/02/2016
ms.topic: how-to
---

# Virtual machine automation and management using PowerShell

You can use PowerShell Direct to run arbitrary PowerShell in a Windows 10 or greater, or Windows Server 2016 or newer, virtual machine from your Hyper-V host. Use PowerShell Direct regardless of network configuration or remote management settings.

Here are some ways you can run PowerShell Direct:

* [As an interactive session using the Enter-PSSession cmdlet](#create-and-exit-an-interactive-powershell-session)
* [As a single-use section to execute a single command or script using the Invoke-Command cmdlet](#run-a-script-or-command-with-invoke-command)
* [As a persistant session (build 14280 and later) using the New-PSSession, Copy-Item, and Remove-PSSession cmdlets](#copy-files-with-new-pssession-and-copy-item)

## Requirements

**Operating system requirements:**

* Host: Windows 10, Windows Server 2016, or later running Hyper-V.
* Guest/Virtual Machine: Windows 10, Windows Server 2016, or later.

If you're managing older virtual machines, use Virtual Machine Connection (VMConnect) or connect over a network connection.

**Configuration requirements:**

* The virtual machine must run locally on the host.
* The virtual machine must be turned on and running with at least one configured user profile.
* You must be logged into the host computer as a Hyper-V administrator.
* You must supply valid user credentials for the virtual machine.

## Create and exit an interactive PowerShell session

The easiest way to run PowerShell commands in a virtual machine is to start an interactive session.

When the session starts, the commands that you type run on the virtual machine, just as though you typed them directly into a PowerShell session on the virtual machine itself.

**To start an interactive session:**

1. On the Hyper-V host, open PowerShell as Administrator.

1. Run one of the following commands to create an interactive session using the virtual machine name or GUID:  
  
      ```powershell
      Enter-PSSession -VMName <VMName>
      Enter-PSSession -VMId <VMId>
      ```
  
      Enter credentials for the virtual machine when prompted.

1. Run commands on your virtual machine. You should see the VMName as the prefix for your PowerShell prompt as the following:
  
      ```output
      [VMName]: PS C:\>
      ```
  
      Any command you run executes on your virtual machine. To test, run `ipconfig` or `hostname` to make sure that these commands run in the virtual machine.
  
1. When you're done, run the following command to close the session:
  
      ```powershell
       Exit-PSSession 
      ```

> [!NOTE]
> If your session won't connect, see the [troubleshooting](#troubleshooting) for potential causes.

To learn more about these cmdlets, see [Enter-PSSession](/powershell/module/Microsoft.PowerShell.Core/Enter-PSSession) and [Exit-PSSession](/powershell/module/Microsoft.PowerShell.Core/Exit-PSSession).

## Run a script or command with Invoke-Command

PowerShell Direct with Invoke-Command is perfect for situations where you need to run one command or one script on a virtual machine but don't need to continue interacting with the virtual machine beyond that point.

**To run a single command:**

1. On the Hyper-V host, open PowerShell as Administrator.

1. Run one of the following commands to create a session using the virtual machine name or GUID:  

   ```powershell
   Invoke-Command -VMName <VMName> -ScriptBlock { command } 
   Invoke-Command -VMId <VMId> -ScriptBlock { command }
   ```

   Enter credentials for the virtual machine when prompted.

   The command runs on the virtual machine. If the command produces output, you see it in your console. The connection closes automatically as soon as the command runs.

**To run a script:**

1. On the Hyper-V host, open PowerShell as Administrator.

1. Run one of the following commands to create a session using the virtual machine name or GUID:  

   ```powershell
   Invoke-Command -VMName <VMName> -FilePath C:\host\script_path\script.ps1 
   Invoke-Command -VMId <VMId> -FilePath C:\host\script_path\script.ps1 
   ```

   Enter credentials for the virtual machine when prompted.

   The script runs on the virtual machine. The connection closes automatically as soon as the command runs.

For more information about this cmdlet, see [Invoke-Command](/powershell/module/Microsoft.PowerShell.Core/Invoke-Command).

## Copy files with New-PSSession and Copy-Item

> [!NOTE]
> PowerShell Direct only supports persistent sessions in Windows builds 14280 and later

Persistent PowerShell sessions are incredibly useful when writing scripts that coordinate actions across one or more remote machines.  Once created, persistent sessions exist in the background until you decide to delete them.  This means you can reference the same session over and over again with `Invoke-Command` or `Enter-PSSession` without passing credentials.

By the same token, sessions hold state. Since persistent sessions persist, any variables you create in a session or pass to a session are preserved across multiple calls. You can use a number of tools to work with persistent sessions. For this example, use [New-PSSession](/powershell/module/Microsoft.PowerShell.Core/New-PSSession) and [Copy-Item](/powershell/module/Microsoft.PowerShell.Management/Copy-Item) to move data from the host to a virtual machine and from a virtual machine to the host.

**To create a session then copy files:**  

1. On the Hyper-V host, open PowerShell as Administrator.

1. Run one of the following commands to create a persistent PowerShell session to the virtual machine by using `New-PSSession`.
  
    ```powershell
    $s = New-PSSession -VMName <VMName> -Credential (Get-Credential)
    $s = New-PSSession -VMId <VMId> -Credential (Get-Credential)
    ```
  
    Enter credentials for the virtual machine when prompted.
  
    >[!WARNING]
    > There's a bug in builds before 14500.  If you don't explicitly specify credentials with the `-Credential` flag, the service in the guest crashes and needs to be restarted.  If you encounter this issue, see the section [Error: A remote session might have ended](#error-a-remote-session-might-have-ended) for workaround instructions.
  
1. Copy a file into the virtual machine.
  
    To copy `C:\host_path\data.txt` to the virtual machine from the host machine, run:
  
    ```powershell
    Copy-Item -ToSession $s -Path C:\host_path\data.txt -Destination C:\guest_path\
    ```
  
1. Copy a file from the virtual machine (on to the host).

     To copy `C:\guest_path\data.txt` to the host from the virtual machine, run:
  
    ```powershell
    Copy-Item -FromSession $s -Path C:\guest_path\data.txt -Destination C:\host_path\
    ```

1. Stop the persistent session by using `Remove-PSSession`.
  
    ```powershell
    Remove-PSSession $s
    ```

## Troubleshooting

PowerShell Direct surfaces a small set of common error messages. The following sections describe the most common error messages, some causes, and tools for diagnosing issues.

### -VMName or -VMID parameters don't exist

**Problem:**

`Enter-PSSession`, `Invoke-Command`, or `New-PSSession` don't have a `-VMName` or `-VMId` parameter.

**Potential causes:**

The most likely issue is that your host operating system doesn't support PowerShell Direct.

You can check your Windows build by running the following command:

```powershell
[System.Environment]::OSVersion.Version
```

If you're running a supported build, it's also possible that your version of PowerShell doesn't support PowerShell Direct. For PowerShell Direct and JEA, the major version must be 5 or later.

You can check your PowerShell version build by running the following command:

```powershell
$PSVersionTable.PSVersion
```

### Error: A remote session might have ended

> [!NOTE]
> For Enter-PSSession between host builds 10240 and 12400, all errors report as "A remote session might have ended".

**Error message:**

Enter-PSSession : An error occurred that Windows PowerShell can't handle. A remote session might have ended.

**Potential causes:**

* The virtual machine exists but isn't running.
* The guest OS doesn't support PowerShell Direct. See [requirements](#requirements).
* PowerShell isn't available in the guest yet
  * The operating system hasn't finished booting
  * The operating system can't boot correctly
  * Some boot time event needs user input

Use the [Get-VM](/powershell/module/hyper-v/get-vm) cmdlet to check which VMs are running on the host.

**Error message:**

New-PSSession : An error occurred that Windows PowerShell can't handle. A remote session might have ended.

**Potential causes:**

* One of the reasons listed earlier -- they all apply to `New-PSSession`  
* A bug in current builds where you must explicitly pass credentials with `-Credential`. When this bug occurs, the entire service hangs in the guest operating system and needs to be restarted. You can check if the session is still available with Enter-PSSession.

To work around the credential issue, sign in to the virtual machine using VMConnect, open PowerShell, and restart the vmicvmsession service with the following PowerShell command:

```powershell
Restart-Service -Name vmicvmsession
```

### Error: Parameter set can't be resolved

**Error message:**  

Enter-PSSession : Parameter set can't be resolved by using the specified named parameters.

**Potential causes:**

* You can't use `-RunAsAdministrator` when connecting to virtual machines.

  When connecting to a Windows container, the `-RunAsAdministrator` flag allows Administrator connections without explicit credentials.  Since virtual machines don't give the host implied administrator access, you need to explicitly enter credentials.

You can pass administrator credentials to the virtual machine with the `-Credential` parameter or by entering them manually when prompted.

### Error: The credential is invalid

**Error message:**  

Enter-PSSession : The credential is invalid.

**Potential causes:**

* The guest credentials couldn't be validated
  * The supplied credentials were incorrect.
  * There are no user accounts in the guest (the OS didn't boot before)
  * If connecting as Administrator:  Administrator isn't set as an active user.  For more information, see [Enable and Disable the Built-in Administrator Account](/windows-hardware/manufacture/desktop/enable-and-disable-the-built-in-administrator-account).
  
### Error: The input VMName parameter doesn't resolve to any virtual machine.

**Error message:**  

Enter-PSSession : The input VMName parameter doesn't resolve to any virtual machine.

**Potential causes:**

* You're not a Hyper-V Administrator.  
* The virtual machine doesn't exist.

Use the [Get-VM](/powershell/module/hyper-v/get-vm) cmdlet to check that the credentials you're using have the Hyper-V administrator role and to see which VMs are running locally on the host and booted.

## Samples and user guides

PowerShell Direct supports Just Enough Administration (JEA).

Check out samples on [GitHub](https://github.com/Microsoft/Virtualization-Documentation/search?l=powershell&q=-VMName+OR+-VMGuid&type=Code&utf8=%E2%9C%93).
