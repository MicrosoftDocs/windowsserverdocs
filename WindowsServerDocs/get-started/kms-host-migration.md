---
title: KMS host migration in Windows Server
description: Learn how to migrate your Key Management Services (KMS) host to another device in Windows Server.
ms.topic: how-to
author: xelu86
ms.author: alalve
ms.date: 04/28/2025
---

# Migrate a KMS host to other devices

This article outlines the steps and best practices for migrating the Key Management Services (KMS) host role to a new server. Migrating the KMS host is often necessary when the existing host's operating system (OS) is approaching its end-of-support. It might also be required due to operational or organizational changes that mandate moving the role to a different server. The instructions in this guide provide a seamless migration process while maintaining uninterrupted activation services for Microsoft Windows and Microsoft Office clients. No data migration is required during this process as the KMS Host doesn't rely on any database or backup.

Before proceeding with your installation and licensing tasks, review the following details regarding your new KMS host:

- Ensure you have access to your new KMS host key for Windows and Office through the Microsoft 365 Admin Center. KMS host keys have a predefined activation limit. If you encounter an error stating that you exceeded the activation limit, you can reset the key per request. To learn more, see [Find and use product keys for volume licensing](/microsoft-365/commerce/licenses/product-keys-for-vl?view=o365-worldwide).

- If you're unable to find your KMS host key, [contact support](https://learn.microsoft.com/licensing/contact-us) for licensing assistance.

> [!NOTE]
>
> - **Client Activation Threshold**: KMS requires at least **25** unique activation requests from the client OS within the last 30 days to begin activating them.
> - **Server Activation Threshold**: KMS requires at least **5** unique activation requests from the server OS within the last 30 days to begin activating them.

## Prerequisites

- The **Volume Activation Services** role must be installed on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

  *Alternatively*, you can run the following PowerShell command:

  ```powershell
  Install-WindowsFeature -Name VolumeActivation -IncludeManagementTools
  ```

- You must be a member of the following groups:

  - Administrators
  - Domain Admins
  - Enterprise Admins

- Licenses must be valid and accessible from your organization's licensing portal or the Microsoft 365 Admin Center. Ensure you have the appropriate KMS host keys for the products you're activating, such as:

  - Microsoft Windows OS license key
  - Microsoft Office license key

- Your OS must have the latest Windows updates installed before configuring your device as a KMS host.

## Manage a KMS host

When a KMS host is deployed, network administrators can streamline the activation process for all client machines, reducing the need for individual product keys while bolstering compliance. This process involves installing the appropriate KMS host key, configuring services for automatic client discovery through DNS, and implementing secure communication channels via firewall rules. Performing these actions can be done in an elevated command prompt or PowerShell window.

## Retrieve a KMS host

# [Command Prompt](#tab/cmd1)

To retrieve KMS hosts by the Domain Name System (DNS), run the following command:

```cmd
nslookup -type=srv _vlmcs._tcp
```

To retrieve KMS hosts by the Fully Qualified Domain Name (FQDN), run the following command:

```cmd
nslookup -type=SRV _vlmcs._tcp.mydomain.com
```

To retrieve KMS hosts by a specific DNS server, such as 8.8.8.8, run the following command:

```cmd
nslookup -type=SRV _vlmcs._tcp.mydomain.com 8.8.8.8
```

# [PowerShell](#tab/powershell1)

To retrieve KMS hosts by the DNS, run the following command:

```powershell
Resolve-DnsName -Name _vlmcs._tcp -Type SRV
```

To retrieve KMS hosts by the FQDN, run the following command:

```powershell
Resolve-DnsName -Name _vlmcs._tcp.mydomain.com -Type SRV
```

To retrieve KMS hosts by a specific DNS server, such as 8.8.8.8, run the following command:

```powershell
Resolve-DnsName -Name _vlmcs._tcp.mydomain.com -Type SRV -Server 8.8.8.8
```

---

## Verify KMS host product activation

To verify which products the current KMS host is activating and ensure the new KMS host activates the same Windows OS and Microsoft Office clients, run the following command:

```cmd
cscript %windir%\system32\slmgr.vbs /dlv All
```

```powershell
cscript $env:windir\system32\slmgr.vbs /dlv All
```

Check the output to determine whether the KMS host is processing activation requests for the Windows OS, Microsoft Office, or both. The partial product keys displayed can help you match these KMS host keys (CSVLK) with your records. Additionally, review the KMS Host Event log to identify which clients are sending activation requests to this KMS host.

## Prepare the KMS host

Before configuring your environment as a KMS host, start with a clean installation of the target OS on the new server. To learn how to install your Windows Server OS, see [Install Windows Server from installation media](/windows-server/get-started/install-windows-server). Ensure that all available OS updates and security patches are applied and reboot as necessary. There are two options available for setting up your KMS host.

# [Windows OS KMS host](#tab/winoshost)

After preparing the host OS, the next step is to configure it to serve as a KMS host. Review the steps outlined in [How to create a Key Management Services (KMS) activation host](/windows-server/get-started/kms-create-host).

# [Microsoft Office KMS host](#tab/officehost)

If you're setting up a KMS host for Microsoft Office activation, other requirement considerations apply. This process involves installing the appropriate Volume License Pack for your Microsoft Office product, which in turn prompts for the Microsoft Office KMS host key activation. To learn more, see [Configure a KMS host computer to activate volume licensed versions of Office](/office/volume-license-activation/configure-a-kms-host-computer-for-office). Activation can be performed over the internet or manually via phone activation.

It's essential to review the system requirements specific to each Microsoft Office Volume License Pack. On the download page, expand **System Requirements** and review the supported host OS for the following versions:

- [Office LTSC 2024 Volume License Pack](https://www.microsoft.com/download/details.aspx?id=106246)
- [Office LTSC 2021 Volume License Pack](https://www.microsoft.com/download/details.aspx?id=103446)
- [Office 2019 Volume License Pack](https://www.microsoft.com/download/details.aspx?id=57342)
- [Office 2016 Volume License Pack](https://www.microsoft.com/download/details.aspx?id=49164)

---

## Verify firewall settings

Before proceeding on how to manage a KMS host, ensure that the firewall exception is configured for port **1688** to accept activation requests from KMS clients. Additionally, port **135** (Anonymous RPC) also needs to be configured.

# [GUI](#tab/gui)

1. Select **Start**, type **wf.msc**, then select it to open the **Windows Defender Firewall with Advanced Security**.
1. In the left pane, select **Inbound Rules**.
1. In the right pane, select **New Rule** to open the **New Inbound Rule Wizard**.
1. Under **Rule Type**, select **Port**, then select **Next**.
1. Under **Protocol and Ports**, select **TCP**, enter **1688** in the **Specific local ports** field, then select **Next**.
1. Under **Action**, ensure **Allow the connection** is selected, then select **Next**.
1. Under **Profile**, **Domain**, **Private**, and **Public** are selected by default. Select **Next**.
1. Under **Name**, provide any name desired for your rule, such as "KMS Host", then select **Finish**.

Repeat these steps to configure port **135**.

# [PowerShell](#tab/powershell)

Run the following command in an elevated PowerShell window:

```powershell
New-NetFirewallRule -DisplayName "KMS Host Activation" -Direction Inbound -Protocol TCP -LocalPort 1688 -Action Allow
New-NetFirewallRule -DisplayName "KMS Host RPC" -Direction Inbound -Protocol TCP -LocalPort 135 -Action Allow
```

---

To verify that traffic is allowed through port **1688** or **135**, run the following command where values for **ComputerName** are the device name or IP address:

```powershell
Test-NetConnection -ComputerName "MyDevice" -Port 1688
```

When the connection succeeds, the entry **TcpTestSucceeded** equals **True**, while if the connection to port 1688 can’t be made (for instance, if no service is listening or because of a firewall or network issue) then **TcpTestSucceeded** equals **False**.

## Test a KMS host

Once the KMS host is configured for the Windows OS and Microsoft Office, there are two options available to test the KMS host registration.

# [Without DNS](#tab/nodns)

If you choose not to register the KMS host in your domain, you must manually configure a test device to send activation requests to the new KMS host.

1. Run one of the following commands with elevation where "domain.com" is the FQDN or IP address:

   ```cmd
   cscript %windir%\system32\slmgr.vbs /skms:mydomain.com:1688
   ```

   ```powershell
   cscript $env:windir\system32\slmgr.vbs /skms:mydomain.com:1688
   ```

1. Run one of the following commands to initiate an activation request:

   ```cmd
   cscript %windir%\system32\slmgr.vbs /ato
   ```

   ```powershell
   cscript $env:windir\system32\slmgr.vbs /ato
   ```

If you receive an "insufficient count" error, it verifies that basic network connectivity exists between the client and the KMS host.

# [With DNS](#tab/withdns)

Register the new KMS host in DNS to enable automatic discovery by client machines. This approach also facilitates a faster increase in the activation count. To register the new KMS host in DNS, follow these steps:

1. Manually create the appropriate service (SRV) records. To learn more, see [Manually create DNS records](/windows-server/get-started/kms-create-host#manually-create-dns-records).
1. Verify that the new SRV record is published by using `nslookup` as described in [Retrieve a KMS host](#retrieve-a-kms-host).
1. On the client machines, ensure that any previous manual settings (if any) are cleared so that the client can automatically locate the KMS host via DNS. Then run one of the following commands with elevation:

   ```cmd
   cscript %windir%\system32\slmgr.vbs /ato
   ```

   ```powershell
   cscript $env:windir\system32\slmgr.vbs /ato
   ```

Check which clients are sending activation requests to the new KMS host:

1. Right-click **Start**, then select **Event Viewer**.
1. Expand **Applications and Services Logs**, then select **Key Management Service** to view the baseline.
1. Run one of the following commands on the test machine to verify the KMS client details:

   ```cmd
   cscript %windir%\system32\slmgr.vbs /dlv
   ```

   ```powershell
   cscript $env:windir\system32\slmgr.vbs /dlv
   ```

1. Return to the **Key Management Service** event log and review the entries **KMS machine name from DNS** and **KMS machine IP address** to confirm that the client is communicating with the new KMS host.
1. Once you verify the new KMS host is activating client machines successfully, remove the old KMS host from DNS.

---

> [!NOTE]
> It's important to completely shut down the old KMS host to prevent any confusion and ensure that client devices only contact the new KMS host.

## Troubleshoot KMS activation

Performing these actions must be done in an elevated command prompt or PowerShell window. To further troubleshoot other issues, see [Guidelines for troubleshooting the Key Management Service (KMS)](/windows-server/get-started/activation-troubleshoot-kms-general).

# [Command Prompt](#tab/cmd1)

If client machines aren't connecting to the new KMS host, verify if they're still connected through the old KMS host by running the following command:

```cmd
cscript %windir%\system32\slmgr.vbs /dlv
```

If it’s not pointing to the new KMS host, remove it from the client by running the following command. This command outputs detailed activation information. The entry label **KMS machine name** shows the KMS host that the client is currently using:

```cmd
cscript %windir%\system32\slmgr.vbs /ckms
```

To update the KMS host on your client devices, run the following command:

```cmd
cscript %windir%\system32\slmgr.vbs /skms
```

# [PowerShell](#tab/powershell1)

If client machines aren't connecting to the new KMS host, verify if they're still connected through the old KMS host by running the following command:

```powershell
cscript $env:windir\system32\slmgr.vbs /dlv
```

If it’s not pointing to the new KMS host, remove it from the client by running the following command. This command outputs detailed activation information. The entry label **KMS machine name from DNS** shows the KMS host that the client is currently using:

```powershell
cscript $env:windir\system32\slmgr.vbs /ckms
```

To update the KMS host on your client devices, run the following command:

```powershell
cscript $env:windir\system32\slmgr.vbs /skms
```

---

## See also

- [Key Management Services (KMS) activation planning](/windows-server/get-started/kms-activation-planning)

- [Slmgr.vbs options for obtaining volume activation information](/windows-server/get-started/activation-slmgr-vbs-options)
