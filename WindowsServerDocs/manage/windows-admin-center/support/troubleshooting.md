---
title: Windows Admin Center common troubleshooting steps
description: Windows Admin Center common troubleshooting steps
ms.topic: troubleshooting-general
author: xelu86
ms.author: alalve
ms.date: 06/19/2025
---

# Troubleshoot Windows Admin Center

This article describes how to diagnose and resolve issues in Windows Admin Center. If you're having an issue with a specific tool, check to see if you're experiencing a [known issue](known-issues.md).

## Prerequisite

Windows Admin Center is supported on the following operating systems:

- For Windows client, your device must be running Windows 10 version 1709 or later (Fall Creators Update).

- For Windows Server, your device must be running Windows Server 2016 or later.

## The Windows Admin Center installer fails to load

```error
The Module 'Microsoft.PowerShell.LocalAccounts' could not be loaded.
```

This failure can happen if your default PowerShell module path has been modified or removed. To resolve this issue, make sure that `%SystemRoot%\system32\WindowsPowerShell\v1.0\Modules` is the first item in your PSModulePath environment variable. You can set this path by running the following command in an elevated PowerShell window:

```powershell
[Environment]::SetEnvironmentVariable("PSModulePath","%SystemRoot%\system32\WindowsPowerShell\v1.0\Modules;" + ([Environment]::GetEnvironmentVariable("PSModulePath","User")),"User")
```

## I receive an error in my web browser

```error
This site/page can't be reached
```

**If the Windows Admin Center app is installed as a standalone app**:

- Check to make sure Windows Admin Center is running in the System tray. You can also open **Task Manager** and check if **Windows Admin Center** is running.

- Make sure you're using either Microsoft Edge or Google Chrome as your web browser with the latest updates.

- Did you select the correct certificate on [first launch](../use/get-started.md#open-windows-admin-center-on-a-windows-pc)?

  Try opening your browser in a private or incognito window. If Windows Admin Center loads successfully, clear your browser cache in your regular session and try again.

- Did you recently upgrade Windows 10 to a new build or version?

  This might've cleared your trusted hosts settings. See the [Configure TrustedHosts list](#configure-trustedhosts-list) section.

**If the Windows Admin Center app is installed as a Gateway on Windows Server**:

- Make sure you're using either Microsoft Edge or Google Chrome as your web browser with the latest updates.

- Open **Task Manager**, select the **Services** tab, make sure that **ServerManagementGateway** or **Windows Admin Center** is running.

- Test the network connection to the Gateway. Run the following command. Replace `<Port>` and `<Gateway>` with your port number and gateway hostname (or IP address):

  ```powershell
  Test-NetConnection -Port <Port> -ComputerName <Gateway> -InformationLevel Detailed
  ```

**If the Windows Admin Center app is installed in an Azure Windows Server VM**:

- Verify and update the inbound port rule for HTTPS through the [network security group](/azure/virtual-network/network-security-groups-overview) or firewall settings.

**Ensure the Windows Remote Management (WinRM) service is running on both the gateway machine and managed node**:

1. Open the run dialog by pressing the **Windows Key** + **R**.

1. Type `services.msc` and press **Enter**.

1. In the **Services** window, check if the **WinRM** service is running and set to automatically start.

## I'm receiving WinRM error messages while managing servers

WinRM doesn't allow credential delegation by default. To allow delegation, the computer needs to have Credential Security Support Provider (CredSSP) enabled temporarily.

If you're receiving WinRM error messages, try the [Manual troubleshooting](/azure/azure-local/manage/troubleshoot-credssp#manual-troubleshooting) section of [Troubleshoot CredSSP](/azure/azure-local/manage/troubleshoot-credssp) to resolve them.

### Did you upgrade your server from 2016 to 2019?

This may have cleared your trusted hosts settings. [Follow these instructions to update your trusted hosts settings.](#configure-trustedhosts)

## I get the message: "Can't connect securely to this page. This might be because the site uses outdated or unsafe TLS security settings."

Your machine is restricted to HTTP/2 connections. Windows Admin Center uses integrated Windows authentication, which isn't supported in HTTP/2. Add the following two registry values under the ```HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Http\Parameters``` key on **the machine running the browser** to remove the HTTP/2 restriction:

```cmd
EnableHttp2Cleartext=dword:00000000
EnableHttp2Tls=dword:00000000
```

## I'm having trouble with the Remote Desktop, Events, and PowerShell tools.

These three tools require the web socket protocol, which is commonly blocked by proxy servers and firewalls. If you're using Google Chrome, there's a [known issue](known-issues.md#google-chrome) with web sockets and NTLM authentication.

## I can connect to some servers, but not others

- Log on to the gateway machine locally and try to ```Enter-PSSession <machine name>``` in PowerShell, replacing \<machine name> with the name of the Machine you're trying to manage in Windows Admin Center.

- If your environment uses a workgroup instead of a domain, see [using Windows Admin Center in a workgroup](#using-windows-admin-center-in-a-workgroup).

- **Using local administrator accounts:** If you're using a local user account that isn't the built-in administrator account, you need to enable the policy on the target machine by running the following command in PowerShell or at a command prompt as Administrator on the target machine:

    ```cmd
    REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1
    ```

## I get this message: "You are not authorized to view this page. If you recently updated Windows Admin Center, you may need to restart your browser, and then refresh the page."

Make sure to select the **Windows Admin Center Client** certificate when prompted on the first launch, and not any other certificate. If you select any other certificate, you'll get this error message. To resolve this error, restart your browser and refresh the page, and select the **Windows Admin Center Client** certificate. If you continue to get the same error, try clearing the browser cache or switching to another browser. If none of these troubleshooting steps resolve the issue, you may need to uninstall and reinstall Windows Admin Center, and then restart it.

## Using Windows Admin Center in a workgroup

### What account are you using?

Make sure the credentials you're using are a member of the target server's local administrators group. In some cases, WinRM also requires membership in the Remote Management Users group. If you're using a local user account that is **not the built-in administrator account**, you'll need to enable the policy on the target machine by running the following command in PowerShell or at a Command Prompt as Administrator on the target machine:

```cmd
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1
```

### Are you connecting to a workgroup machine on a different subnet?

To connect to a workgroup machine that isn't on the same subnet as the gateway, make sure the firewall port for WinRM (TCP 5985) allows inbound traffic on the target machine. You can run the following command in PowerShell or at a Command Prompt as Administrator on the target machine to create this firewall rule:

- **Windows Server**

    ```powershell
    Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any
    ```

- **Windows 10**

    ```powershell
    Set-NetFirewallRule -Name WINRM-HTTP-In-TCP -RemoteAddress Any
    ```

### Configure TrustedHosts list

When installing Windows Admin Center, you're given the option to let Windows Admin Center manage the gateway's TrustedHosts setting. This is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must configure TrustedHosts manually.

**To modify TrustedHosts using PowerShell commands:**

1. Open an elevated PowerShell window.
2. View your current TrustedHosts setting:

    ```powershell
    Get-Item WSMan:\localhost\Client\TrustedHosts
    ```

   > [!WARNING]
   > If the current setting of your TrustedHosts isn't empty, the commands below will overwrite your setting. We recommend that you save the current setting to a text file with the following command so you can restore it if needed:
   >
   > `Get-Item WSMan:localhost\Client\TrustedHosts | Out-File C:\OldTrustedHosts.txt`

3. Set TrustedHosts to the NetBIOS, IP, or FQDN of the machines you
   intend to manage:

    ```powershell
    Set-Item WSMan:localhost\Client\TrustedHosts -Value '192.168.1.1,server01.contoso.com,server02'
    ```

   > [!TIP]
   > For an easy way to set all TrustedHosts at once, you can use a wildcard.
   >
   > ```powershell
   > Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'
   > ```

4. When you're done testing, you can issue the following command from an elevated PowerShell session to clear your TrustedHosts setting:

    ```powershell
    Clear-Item WSMan:localhost\Client\TrustedHosts
    ```

5. If you had previously exported your settings, open the file, copy the values, and use this command:

    ```powershell
    Set-Item WSMan:localhost\Client\TrustedHosts -Value '<paste values from text file>'
    ```

## I previously had Windows Admin Center installed, and now nothing else can use the same TCP/IP port

Manually run these two commands in an elevated command prompt:

```cmd
netsh http delete sslcert ipport=0.0.0.0:443
netsh http delete urlacl url=https://+:443/
```

## Azure features don't work properly in Microsoft Edge

Microsoft Edge has [known issues](https://github.com/AzureAD/azure-activedirectory-library-for-js/wiki/Known-issues-on-Edge) related to security zones that affect Azure login in Windows Admin Center.

If you're having trouble using Azure features when using Microsoft Edge, perform these steps to add the required URLs:

1. Search for **Internet Options** in the Windows Start menu.

1. Go to the **Security** tab.

1. Under the **Trusted sites** option, select the **Sites** button and add the following URLs in the dialog box that opens:

    - Your gateway URL
    - `https://login.microsoftonline.com`
    - `https://login.live.com`

1. Select **Close** and then select **OK**.

1. Update the **Pop-up Blocker** settings in Microsoft Edge:

    1. Browse to edge://settings/content/popups?search=pop-up.

    1. Under the **Allow** section, add the following URLs:

      - Your gateway URL
      - `https://login.microsoftonline.com`
      - `https://login.live.com`

## Have an issue with an Azure-related feature?

Send us an email at wacFeedbackAzure@microsoft.com with the following information:

- General issue information from the [questions listed below](#provide-feedback-on-issues).
- Describe your issue and the steps you took to reproduce the issue.
- Did you previously register your gateway to Azure using the New-AadApp.ps1 downloadable script and then upgrade to version 1807? Or did you register your gateway to Azure using the UI from gateway Settings > Azure?
- Is your Azure account associated with multiple directories/tenants? If yes, when registering the Microsoft Entra application to Windows Admin Center, was the directory you used your default directory in Azure?
- Does your Azure account have access to multiple subscriptions?
- Does the subscription you were using have billing attached?
- Were you logged in to multiple Azure accounts when you encountered the issue?
- Does your Azure account require multi-factor authentication?
- Is the machine you're trying to manage an Azure VM?
- Is Windows Admin Center installed on an Azure VM?

## Collect HAR files

An HTTP Archive Format (HAR) file is a log of a web browser's interaction with a site. This information is crucial for troubleshooting and debugging.

To collect a HAR file in Microsoft Edge or Google Chrome, follow these steps:

1. Press **F12** to open Developer Tools window, then select the **Network** tab.
1. Select the **Clear** icon to clean up network log.
1. Select the **Preserve Log** check box.
1. Reproduce the issue.
1. After reproducing the issue, select **Export HAR**.
1. Specify where to save the log and select **Save**.

    ![The points users have to click on to collect a HAR file are displayed and highlighted based on the numbered bullets.](../media/collect-har.PNG)

> [!WARNING]
> Before sharing your HAR files with Microsoft, ensure that you remove or obfuscate any sensitive information, like passwords.

## Provide feedback on issues

Go to Event Viewer > Application and Services > Microsoft-ServerManagementExperience and look for any errors or warnings.

File a bug on the [Windows Admin Center](https://aka.ms/wacfeedback) feedback intake that describes your issue.

Include any errors or warning you find in the event log, and the following information:

* Platform where Windows Admin Center is **installed** (Windows 10 or Windows Server):
  * If installed on Server, what is the Windows [version](#check-the-windows-version) of **the machine running the browser** to access Windows Admin Center:
  * Are you using the self-signed certificate created by the installer?
  * If you're using your own certificate, does the subject name match the machine?
  * If you're using your own certificate, does it specify an alternate subject name?
* Did you install with the default port setting?
  * If not, which port did you specify?
* Is the machine where Windows Admin Center is **installed** joined to a domain?
* Windows [version](#check-the-windows-version) where Windows Admin Center is **installed**:
* Is the machine that you're **trying to manage** joined to a domain?
* Windows [version](#check-the-windows-version) of the machine that you're **trying to manage**:
* What browser are you using?
  * If you're using Google Chrome, what is the version? (Help > About Google Chrome)
