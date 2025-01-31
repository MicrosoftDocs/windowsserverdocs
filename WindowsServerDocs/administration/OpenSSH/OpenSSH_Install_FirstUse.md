---
title: Get started with OpenSSH for Windows
description: Learn how to install and connect to remote machines using the OpenSSH Client and Server for Windows.
ms.date: 08/16/2024
ms.topic: quickstart
ms.author: roharwoo
author: robinharwood
ms.custom: "se-defect-target"
zone_pivot_groups: openssh-windows-version
---

# Get started with OpenSSH for Windows

OpenSSH is a connectivity tool for remote sign-in that uses the SSH protocol. It encrypts all traffic between client and server to eliminate eavesdropping, connection hijacking, and other attacks.

An OpenSSH-compatible client can be used to connect to Windows Server and Windows client devices.

> [!IMPORTANT]
> If you downloaded the OpenSSH beta from the GitHub repo at [PowerShell/Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH), follow the instructions listed there, not the ones in this article. Some information in the Win32-OpenSSH repository relates to prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, express or implied, with respect to the information provided there.

## Prerequisites

Before you start, your computer must meet the following requirements:

- A device running at least Windows Server 2019 or Windows 10 (build 1809).

- PowerShell 5.1 or later.

- An account that is a member of the built-in Administrators group.

### Prerequisites check

To validate your environment, open an elevated PowerShell session and do the following:

- Enter _winver.exe_ and press enter to see the version details for your Windows device.

- Run `$PSVersionTable.PSVersion`. Verify your major version is at least 5, and your minor version at least 1. Learn more about [installing PowerShell on Windows](/powershell/scripting/install/installing-powershell-on-windows).

- Run the following command. The output shows `True` when you're a member of the built-in Administrators group.

  ```powershell
  (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
  ```

:::zone pivot="windows-server-2025"

## Enable OpenSSH for Windows Server 2025

Starting with Windows Server 2025, OpenSSH is now installed by default. You can also enable or disable the `sshd` service in Server Manager.

### [GUI](#tab/gui)

To enable SSHD using Server Manager:

1. In **Server Manager**, on the navigation pane to the left, select **Local Server**.

1. In the **Properties** window, locate **Remote SSH Access**.

1. Select **Disabled** to enable the OpenSSH service.

> [!NOTE]
> If you need to allow or restrict specific users or groups from using OpenSSH for remote access, add them to the **OpenSSH Users** user group.

### [PowerShell](#tab/powershell)

To enable SSHD using PowerShell:

1. Open PowerShell as an administrator and run the following cmdlet to start the SSHD service:

    ```powershell
    # Start the sshd service
    Start-Service sshd
    ```

1. You can also run the following optional but recommended cmdlet to automatically start SSHD to make sure it stays enabled:

    ```powershell
    Set-Service -Name sshd -StartupType 'Automatic'
    ```

1. Finally, run the following command to verify that the SSHD setup process automatically configured the firewall rule:

    ```powershell
    if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
        Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
        New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
    } else {
        Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
    }
    ```

---

:::zone-end

::: zone pivot="windows-server-2022,windows-server-2019"

## Install OpenSSH for Windows Server

### [GUI](#tab/gui)

To install the OpenSSH components on Windows 10 devices:

1. Open **Settings**, select **System**, then select **Optional Features**.

1. Scan the list to see if the OpenSSH is already installed. If not, at the top of the page, select **Add a feature**, then:

    - Find **OpenSSH Client**, then select **Install**
    
    - Find **OpenSSH Server**, then select **Install**

1. Open the **Services** desktop app. (Select **Start**, type _services.msc_ in the search box, and then select the **Service** app or press <kbd>ENTER</kbd>.)

1. In the details pane, double-click **OpenSSH SSH Server**.

1. On the **General** tab, from the **Startup type** drop-down menu, select **Automatic** and then select **Ok**.

1. To start the service, select **Start**.

To install the OpenSSH components on Windows 11 devices:

1. Open **Settings**, select **System**, then select **Optional Features**.

1. Scan the list to see if the OpenSSH is already installed. If not, at the top of the page, select **View Features**, then:

    - Search for **OpenSSH Client**, select **Next**, then select **Install**
    
    - Search for **OpenSSH Server**, select **Next**, then select **Install**

1. Open the **Services** desktop app. (Select **Start**, type _services.msc_ in the search box, and then select the **Service** app or press <kbd>ENTER</kbd>.)

1. In the details pane, double-click **OpenSSH SSH Server**.

1. On the **General** tab, from the **Startup type** drop-down menu, select **Automatic** and then select **Ok**.

1. To start the service, select **Start**.

To install the OpenSSH components on Windows Server devices:

1. Open **Settings**, select **System**, then select **Optional Features** (also referred to as **Manage optional features**).

1. Scan the list to see if the OpenSSH is already installed. If not, at the top of the page, select **Add a feature**, then:

    - Search for **OpenSSH Client**, then select **Install**
    
    - Search for **OpenSSH Server**, then select **Install**

1. Open the **Services** desktop app. (Select **Start**, type _services.msc_ in the search box, and then select the **Service** app or press <kbd>ENTER</kbd>.)

1. In the details pane, double-click **OpenSSH SSH Server**.

1. On the **General** tab, from the **Startup type** drop-down menu, select **Automatic** and then select **Ok**.

1. To start the service, select **Start**.

> [!NOTE]
> Installing OpenSSH Server will create and enable a firewall rule named `OpenSSH-Server-In-TCP`. This allows inbound SSH traffic on port 22. If this rule is not enabled and this port is not open, connections will be refused or reset.

### [PowerShell](#tab/powershell)

To install OpenSSH using PowerShell:

1. Run PowerShell as an Administrator.

1. Run the following cmdlet to make sure that OpenSSH is available:

    ```powershell
    Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH*'
    ```

    The command should return the following output if neither are already installed:

    ```powershell
    Name  : OpenSSH.Client~~~~0.0.1.0
    State : NotPresent

    Name  : OpenSSH.Server~~~~0.0.1.0
    State : NotPresent
    ```

1. After that, run the following cmdlets to install the server or client components as needed:

    ```powershell
    # Install the OpenSSH Client
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

    # Install the OpenSSH Server
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    ```

    Both commands should return the following output:

    ```powershell
    Path          :
    Online        : True
    RestartNeeded : False
    ```

1. To start and configure OpenSSH Server for initial use, open an elevated PowerShell prompt (right-click, then select **Run as an administrator**), then run the following commands to start the `sshd service`:

    ```powershell
    # Start the sshd service
    Start-Service sshd

    # OPTIONAL but recommended:
    Set-Service -Name sshd -StartupType 'Automatic'

    # Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
    if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
        Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
        New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
    } else {
        Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
    }
    ```

---
::: zone-end

## Connect to OpenSSH Server

Once installed, you can connect to OpenSSH Server from a Windows or Windows Server device with the OpenSSH client installed. From a PowerShell prompt, run the following command.

```powershell
ssh domain\username@servername
```

Once connected, you get a message similar to the following output.

```powershell
The authenticity of host 'servername (10.00.00.001)' can't be established.
ECDSA key fingerprint is SHA256:(<a large string>).
Are you sure you want to continue connecting (yes/no)?
```

Entering _yes_ adds that server to the list of known SSH hosts on your Windows client.

At this point, the service prompts you for your password. As a security precaution, the characters of your password aren't displayed as you enter them.

Once connected, you should see the following Windows command shell prompt:

```powershell
domain\username@SERVERNAME C:\Users\username>
```

## Uninstall OpenSSH for Windows

### [GUI](#tab/gui)

To uninstall OpenSSH using Windows Settings:

1. Open **Settings**, select **System**, then select **Optional Features** (also referred to as **Manage optional features**).

1. In the list, select **OpenSSH Client** or **OpenSSH Server**.

1. Select **Uninstall**.

### [PowerShell](#tab/powershell)

To uninstall the OpenSSH components using PowerShell, use the following commands:

```powershell
# Uninstall the OpenSSH Client
Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Uninstall the OpenSSH Server
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
```

---

If the service was in use when you uninstalled it, you should restart Windows.

## Next steps

Now that you're done installing OpenSSH Server for Windows, here are some articles that can help you learn how to use it:

- Learn more about using key pairs for authentication in [OpenSSH key management](OpenSSH_KeyManagement.md)

- Learn more about the [OpenSSH Server configuration for Windows](OpenSSH_Server_Configuration.md)
