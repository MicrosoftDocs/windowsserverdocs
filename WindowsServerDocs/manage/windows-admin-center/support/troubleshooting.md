---
title: Windows Admin Center common troubleshooting steps
description: Windows Admin Center common troubleshooting steps
ms.topic: article
author: jwwool
ms.author: jeffrew
ms.date: 01/15/2021
---
# Troubleshoot Windows Admin Center

> Applies to: Windows Admin Center, Windows Admin Center Preview, Azure Stack HCI, versions 21H2 and 20H2

This article describes how to diagnose and resolve issues in Windows Admin Center. If you're having an issue with a specific tool, check to see if you're experiencing a [known issue](./known-issues.md).

## Installer fails with message: **_The Module 'Microsoft.PowerShell.LocalAccounts' could not be loaded._**

This failure can happen if your default PowerShell module path has been modified or removed. To resolve the issue, make sure that `%SystemRoot%\system32\WindowsPowerShell\v1.0\Modules` is the first item in your PSModulePath environment variable. You can achieve this with the following line of PowerShell:

```powershell
[Environment]::SetEnvironmentVariable("PSModulePath","%SystemRoot%\system32\WindowsPowerShell\v1.0\Modules;" + ([Environment]::GetEnvironmentVariable("PSModulePath","User")),"User")
```

## I get a **This site/page can't be reached** error in my web browser

### If you've installed Windows Admin Center as an **App on Windows 10**

- Check to make sure Windows Admin Center is running. Look for the Windows Admin Center icon ![Windows Admin Center icon](../media/trayIcon.PNG) in the System tray or **Windows Admin Center Desktop / SmeDesktop.exe** in Task Manager. If not, launch **Windows Admin Center** from the Start menu.

> [!NOTE]
> After rebooting, you must launch Windows Admin Center from the Start menu.

- [Check the Windows version](#check-the-windows-version).

- Make sure you're using either Microsoft Edge or Google Chrome as your web browser.

- Did you select the correct certificate on [first launch](../use/get-started.md#open-windows-admin-center-on-a-windows-pc)?

  * Try opening your browser in a private session - if that works, you'll need to clear your cache.

- Did you recently upgrade Windows 10 to a new build or version?

  * This may have cleared your trusted hosts settings. [Follow these instructions to update your trusted hosts settings](#configure-trustedhosts).

### If you've installed Windows Admin Center as a **Gateway on Windows Server**

- [Check the Windows version](#check-the-windows-version) of the client and server.

- Make sure you are using either Microsoft Edge or Google Chrome as your web browser.

- On the server, open Task Manager > Services and make sure **ServerManagementGateway / Windows Admin Center** is running.

    ![Task Manager - Services tab](../media/service-task-manager.png)

- Test the network connection to the Gateway (replace \<values> with the information from your deployment)

    ```powershell
    Test-NetConnection -Port <port> -ComputerName <gateway> -InformationLevel Detailed
    ```

### If you have installed Windows Admin Center in an Azure Windows Server VM

- [Check the Windows version](#check-the-windows-version).
- Did you add an inbound port rule for HTTPS?
- [Learn more about installing Windows Admin Center in an Azure VM](../azure/azure-integration.md).

### Check the Windows version

To check the Windows version:

1. Open the run dialog (Windows Key + R) and launch `winver`.

1. Check the version in the **About Windows** window.

    - If you're using Windows 10 version 1703 or earlier, Windows Admin Center isn't supported on your version of Microsoft Edge. Either upgrade to a recent version of Windows 10 or use Google Chrome.

    - If you're using an insider preview version of Windows 10 or Server with a build version between 17134 and 17637, Windows had a bug that caused Windows Admin Center to fail. Use a current supported version of Windows to fix this issue.

### Make sure the Windows Remote Management (WinRM) service is running on both the gateway machine and managed node

1. Open the run dialog with WindowsKey + R.

1. Type `services.msc` and press Enter.

1. In the window that opens, look for Windows Remote Management (WinRM), make sure it is running and set to automatically start.

### If you're getting WinRM error messages while managing servers in Windows Admin Center

WinRM doesn't allow credential delegation by default. To allow delegation, the computer needs to have Credential Security Support Provider (CredSSP) enabled temporarily.

If you're receiving WinRM error messages, try using the verification steps in the [Manual troubleshooting](/azure-stack/hci/manage/troubleshoot-credssp#manual-troubleshooting) section of [Troubleshoot CredSSP](/azure-stack/hci/manage/troubleshoot-credssp) to resolve them.

### Did you upgrade your server from 2016 to 2019?

This may have cleared your trusted hosts settings. [Follow these instructions to update your trusted hosts settings.](#configure-trustedhosts)

## I get the message: "Can't connect securely to this page. This might be because the site uses outdated or unsafe TLS security settings."

Your machine is restricted to HTTP/2 connections. Windows Admin Center uses integrated Windows authentication, which is not supported in HTTP/2. Add the following two registry values under the ```HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Http\Parameters``` key on **the machine running the browser** to remove the HTTP/2 restriction:

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

Make sure the credentials you're using are a member of the target server's local administrators group. In some cases, WinRM also requires membership in the Remote Management Users group. If you're using a local user account that is **not the built-in administrator account**, you will need to enable the policy on the target machine by running the following command in PowerShell or at a Command Prompt as Administrator on the target machine:

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

### Configure TrustedHosts

When installing Windows Admin Center, you're given the option to let Windows Admin Center manage the gateway's TrustedHosts setting. This is required in a workgroup environment, or when using local administrator credentials in a domain. If you choose to forego this setting, you must configure TrustedHosts manually.

**To modify TrustedHosts using PowerShell commands:**

1. Open an Administrator PowerShell session.
2. View your current TrustedHosts setting:

    ```powershell
    Get-Item WSMan:\localhost\Client\TrustedHosts
    ```

   > [!WARNING]
   > If the current setting of your TrustedHosts is not empty, the commands below will overwrite your setting. We recommend that you save the current setting to a text file with the following command so you can restore it if needed:
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

4. When you are done testing, you can issue the following command from an elevated PowerShell session to clear your TrustedHosts setting:

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

If you are having trouble using Azure features when using Microsoft Edge, perform these steps to add the required URLs:

1. Search for **Internet Options** in the Windows Start menu.

1. Go to the **Security** tab.

1. Under the **Trusted sites** option, click on the **Sites** button and add the following URLs in the dialog box that opens:

    - Your gateway URL
    - `https://login.microsoftonline.com`
    - `https://login.live.com`
    
1. Click **Close** and then click **OK**.

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

1. Press **F12** to open Developer Tools window, and then click the **Network** tab.
2. Select the **Clear** icon to clean up network log.
3. Click to select the **Preserve Log** check box.
4. Reproduce the issue.
5. After reproducing the issue, click on **Export HAR**.
6. Specify where to save the log and click **Save**.

    ![The points users have to click on to collect a HAR file are displayed and highlighted based on the numbered bullets.](../media/collect-har.PNG)
    
> [!WARNING] 
> Before sharing your HAR files with Microsoft, ensure that you remove or obfuscate any sensitive information, like passwords.

## Provide feedback on issues

Go to Event Viewer > Application and Services > Microsoft-ServerManagementExperience and look for any errors or warnings.

File a bug on [GitHub](https://aka.ms/wacfeedback) that describes your issue.

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
