---
title: Install Windows Admin Center
description: Install Windows Admin Center in Administration Mode or Virtualization Mode with the combined installer, and configure TLS, updates, and settings for signing in.
#customer intent: As a system administrator, I want to install the appropriate Windows Admin Center mode so that I can manage my environment from a web browser.
ms.topic: install-set-up-deploy
author: robinharwood
ms.author: roharwoo
ms.date: 10/08/2026
ai-usage: ai-assisted
---
# Install Windows Admin Center in Administration Mode or Virtualization Mode

Windows Admin Center is a browser-based tool for managing Windows servers and clusters. Its combined installer supports Administration Mode and Virtualization Mode. Choose the mode that matches whether you need general server administration or stateful virtualization management at scale.

This article explains how to choose a mode and install Windows Admin Center by using the interactive installer or the command line, with an optional configuration file. Both installation methods support Administration Mode and Virtualization Mode. You then verify the installation and sign in for the first time.

> [!TIP]
> New to Windows Admin Center? Learn more about [Windows Admin Center](../overview.md) or [download Windows Admin Center](https://www.microsoft.com/evalcenter/download-windows-admin-center).

## Prerequisites

- A machine that meets the [supported operating system requirements](../plan/installation-options.md#installation-supported-operating-systems). To install Windows Admin Center on an Azure virtual machine (VM), see [Deploy Windows Admin Center in Azure](../azure/deploy-wac-in-azure.md).
- Admin privileges or equivalent permissions on the machine where you're installing Windows Admin Center.
- Download the Windows Admin Center installer from the [Windows Admin Center Evaluation Center](https://www.microsoft.com/evalcenter/download-windows-admin-center) to the machine where you want to install Windows Admin Center.
- For Virtualization Mode, a dedicated Windows Server machine with:
   <!-- Before publication, confirm the GA operating system, edition, domain membership, FQDN DNS, and same-domain managed-host requirements. -->
  - At least four processor cores.
  - At least 8 GB of memory.
  - At least 10 GB of available disk space.
   - The [Microsoft Visual C++ Redistributable](/cpp/windows/latest-supported-vc-redist). If it isn't installed, install it manually or allow the installer to download and install it by using `winget`.
- Optional: A Transport Layer Security (TLS) certificate for Server Authentication (`1.3.6.1.5.5.7.3.1`). For production environments, use a certificate from a trusted certification authority that you install in the `LocalMachine\My` certificate store. For testing, the installer can generate a self-signed certificate that expires after 60 days.

## Choose a Windows Admin Center mode

The installer provides the following modes:

- **Administration Mode**: Provides a stateless gateway for general Windows Server administration. This mode doesn't use a database.
- **Virtualization Mode**: Provides a stateful gateway for managing Hyper-V, clusters, and storage at scale. This mode includes a self-managed PostgreSQL database. Install this mode on a dedicated Windows Server machine.

You can't change the mode after installation. To change modes, reinstall Windows Admin Center.

## Install Windows Admin Center

Choose the interactive installer or command line. Both methods support Administration Mode and Virtualization Mode.

# [Interactive installer](#tab/interactive-installer)

To install Windows Admin Center by using the interactive installer:

1. Sign in to the machine where you want to install Windows Admin Center.

1. Run the Windows Admin Center installer.

   :::image type="content" source="../media/windows-admin-center-v2-installer.png" alt-text="Screenshot of the Windows Admin Center v2 Installer welcome page with Next and Cancel buttons.":::

1. On the **Welcome to the Windows Admin Center setup wizard** page, select **Next**.

1. On the **License Terms and Privacy Statement** page, if you agree to the terms, select **I accept these terms and understand the privacy statement**, and then select **Next**.

1. On the **Choose your Windows Admin Center mode** page, select **Administration Mode** or **Virtualization Mode**, and then select **Next**.

   :::image type="complex" source="../media/windows-admin-center-v2-mode.png" alt-text="Screenshot of the Windows Admin Center v2 Installer mode selection page with neither mode selected.":::
   The page explains that your mode choice affects the gateway's architecture, scale, and management style and that you can change the mode only by reinstalling. **Administration Mode**, for general server administration, is a stateless gateway that you can install on as many machines as needed, including Windows 11. It uses PowerShell remoting and doesn't use a database, backups, or agents. It supports up to about 10 managed nodes and one concurrent connection per gateway. **Virtualization Mode**, for Hyper-V, clustering, and storage at scale, is a stateful gateway with a self-managed PostgreSQL database. It uses one centralized installation on a dedicated Windows Server operating system, supports up to 1,000 managed nodes, and is designed for large environments and team-based role-based access control (RBAC). Neither mode is selected, so **Next** is unavailable.
   :::image-end:::

1. If you selected **Virtualization Mode**, review the checks on the **Virtualization Mode Requirements** page. Resolve each unmet requirement:

   - If the Microsoft Visual C++ Redistributable is missing, select **Install automatically using winget (recommended)**, and then select **Install**.
   - To install the redistributable yourself, select **I will install it manually**, use the provided download link to install it, and then refresh the requirement status.

   Continue when the overall status confirms that you meet all requirements.

1. On the **Select installation mode** page, select an installer setup type:

   - **Express setup**: Determines network access and port selection based on the operating system. You can't configure extra features.
   - **Custom setup**: Use this option to configure network access, port numbers, the Transport Layer Security (TLS) certificate type and thumbprint, the fully qualified domain name (FQDN) of the endpoint, trusted hosts mode, and Windows Remote Management (WinRM) over HTTPS.

   Select **Next**.

   :::image type="content" source="../media/windows-admin-center-v2-installation-mode.png" alt-text="Screenshot of the Windows Admin Center v2 Installer installation mode page with Express setup selected and Custom setup available.":::

1. On the **Select TLS certificate** page, select one of the following options, and then select **Next**:

   - **Use the pre-installed TLS certificate**: Use a certificate in the `LocalMachine\My` certificate store.
   - **Generate a self-signed certificate (expires in 60 days)**: Use this option for testing only.

   :::image type="content" source="../media/select-tls-certificate.png" alt-text="Screenshot of the Windows Admin Center v2 Installer TLS certificate page with the self-signed certificate option selected.":::

1. If you selected **Virtualization Mode**, on the **PostgreSQL Configuration** page, enter the database username, password, password confirmation, and port. Then select **Next**.

   > [!IMPORTANT]
   > The PostgreSQL username defaults to `postgres` and the port defaults to `5432`. The username must start with a letter or underscore, contain only letters, digits, and underscores, not start with `pg_`, and contain no more than 63 characters. The decrypted password must contain only printable ASCII characters and can't contain spaces, semicolons, or quotation marks. Use a strong, unique password and store it securely.

1. On the **Automatic updates** page, select your preferred update option. By default, the installer selects the recommended option to install updates automatically. Then select **Next**.

1. On the **Send diagnostic data to Microsoft** page, select your preference, and then select **Next**.

1. On the **Ready to Install** page, review the selected configuration, including the installation mode, port numbers, TLS certificate choice, and FQDN. Then select **Install**.

1. Wait for the installer to finish configuring Windows Admin Center.

   <!-- Before publication, confirm whether the GA installer shows Start Windows Admin Center and Finish controls at completion. -->

# [Command Line](#tab/command-line)

Use the command line to install Administration Mode or Virtualization Mode on Desktop Experience or Server Core:

`/Mode=` overrides the configuration-file `Mode` key. When you omit the mode during silent installation, an existing installation keeps its prior mode, and a fresh installation defaults to Administration Mode.

<!-- Before publication, confirm explicit /Mode= behavior when Windows Admin Center is already installed. -->
<!-- Before publication, confirm omitted-mode behavior when /ConfigFile is combined with silent installation flags. -->

1. Sign in to the machine. In `SConfig`, enter option **15**, and then select <kbd>Enter</kbd> to open a PowerShell session. On Desktop Experience, use Remote Desktop to connect to the machine, and then start PowerShell.

1. Download the Windows Admin Center installer by using the following PowerShell command:

   ```powershell
   $parameters = @{
       Source = "https://aka.ms/WACdownload"
       Destination = ".\WindowsAdminCenter.exe"
   }
   Start-BitsTransfer @parameters
   ```

1. Run the installer for the mode that you want to install.

   <!-- Before publication, confirm the final installer executable filename. -->

   For Administration Mode, run:

   ```powershell
   .\WindowsAdminCenter.exe /VERYSILENT /Mode=Administration
   ```

   For Virtualization Mode, run:

   ```powershell
   .\WindowsAdminCenter.exe /VERYSILENT /Mode=Virtualization
   ```

   <!-- Before publication, confirm the complete supported command-line switch list. -->

   Use the `/Silent`, `/VerySilent`, `/HTTPSPortNumber`, and `/CertificateThumbprint` installer options to customize the installation. For example:

   ```powershell
   .\WindowsAdminCenter.exe /HTTPSPortNumber=1234 `
       /CertificateThumbprint="AA11BB22CC33DD44EE55FF66AA77BB88CC99DD00"
   ```

   <!-- Before publication, confirm the supported installer exit codes and log location. -->

1. If necessary, start Windows Admin Center by using the following command:

   ```powershell
   Start-Service -Name WindowsAdminCenter
   ```

### Use a configuration file

Use an INI configuration file to install either mode. All keys are optional. The installer uses default values or automatic detection for omitted keys and deletes the configuration file after processing it. Restrict access to the configuration file while it exists because it contains a credential protected by the Data Protection API (DPAPI). If setup doesn't delete the file, delete it manually.

<!-- Before publication, confirm that setup deletes the configuration file after successful, failed, and canceled installations. -->

Set `Mode=Administration` or `Mode=Virtualization`. The `PostgreSQLUsername`, `PostgreSQLPassword`, and `PostgreSQLPort` keys apply only to Virtualization Mode. The installer ignores them in Administration Mode. To use a TLS certificate from the `LocalMachine\My` certificate store, specify its thumbprint in the `Thumbprint` key. If you omit `Thumbprint` or leave it empty, the installer generates a self-signed certificate.

> [!IMPORTANT]
> The PostgreSQL username defaults to `postgres` and the port defaults to `5432`. The username must start with a letter or underscore, contain only letters, digits, and underscores, not start with `pg_`, and contain no more than 63 characters. The decrypted password must contain only printable ASCII characters and can't contain spaces, semicolons, or quotation marks. Use a strong, unique password and store it securely.

For Virtualization Mode, `PostgreSQLPassword` must contain a DPAPI-encrypted value. Generate the value on the target machine under the user context that runs the installer because DPAPI output is specific to the machine and user. Use the following PowerShell command, and enter the PostgreSQL password when prompted:

```powershell
Read-Host -Prompt "PostgreSQL password" -AsSecureString | ConvertFrom-SecureString
```

The following example configures Virtualization Mode with the default PostgreSQL username and port. Replace `<DPAPI-encrypted-password>` with the output from the preceding command:

```ini
Mode=Virtualization
PostgreSQLUsername=postgres
PostgreSQLPassword=<DPAPI-encrypted-password>
PostgreSQLPort=5432
Thumbprint=
```

Save the configuration file, and then pass its path to the installer:

<!-- Before publication, confirm the final installer executable filename for the /ConfigFile example. -->

```powershell
.\WindowsAdminCenter.exe /ConfigFile="C:\path\to\config.ini"
```

---

## Verify the installation

1. Open the Windows Admin Center endpoint URL (`https://<fully-qualified-domain-name>:<port>`) in a browser by using the FQDN and HTTPS port from the installation. When prompted, enter credentials for an administrator account.

   :::image type="content" source="../media/sign-in-to-windows-admin-center.png" alt-text="Screenshot of the Windows Admin Center page where you enter a username and password and select the Sign In button.":::

1. Select **Sign In**.

1. Verify that the Windows Admin Center dashboard loads. In Virtualization Mode, the dashboard identifies the mode and shows the **Welcome to Windows Admin Center** dialog.

   <!-- Before publication, confirm the authoritative way to verify the installed mode. -->

1. If the **Welcome to Windows Admin Center** dialog appears, dismiss it to view the dashboard.
