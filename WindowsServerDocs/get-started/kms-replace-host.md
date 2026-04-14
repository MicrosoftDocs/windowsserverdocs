---
title: Replace a KMS host in Windows Server
description: Learn how to replace your Key Management Services (KMS) host in Windows Server.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 07/30/2025
---

# Replace a KMS host

This article outlines the steps and best practices for migrating the Key Management Services (KMS) host role to a new server. Migrating the KMS host is often necessary when the existing host's operating system (OS) is approaching its end-of-support. It might also be required due to operational or organizational changes that mandate moving the role to a different server. The instructions in this guide provide a seamless migration process while maintaining uninterrupted activation services for Microsoft Windows and Microsoft Office clients. No data migration is required during this process as the KMS Host doesn't rely on any database or backup.

Before proceeding with your installation and licensing tasks, review the following details regarding your new KMS host:

- Ensure you have access to your new Customer Specific Volume License Key (CSVLK). Your CSVLK is also known as the **KMS host key** for the Microsoft Windows OS and Microsoft Office, which are obtained through the Microsoft 365 Admin Center. The CSVLK has a predefined activation limit. If you encounter an error stating that you exceeded the activation limit, you can reset the key per request. To learn more, see [Find and use product keys for volume licensing](/microsoft-365/commerce/licenses/product-keys-for-vl).

- If you're unable to find your CSVLK, [contact support](/microsoft-365/commerce/licenses/contact-vl-support) for licensing assistance.

## Prerequisites

- The **Volume Activation Services** role must be installed on the device that acts as the new KMS host. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

  *Alternatively*, you can run the following PowerShell command:

  ```powershell
  Install-WindowsFeature -Name VolumeActivation -IncludeManagementTools
  ```

- You must be a member of the following groups:

  - Administrators
  - Domain Admins
  - Enterprise Admins

- The CSVLK must be valid and accessible from your organization's licensing portal or the Microsoft 365 Admin Center. Ensure you have the appropriate CSVLK for the products you're activating, such as:

  - Microsoft Windows OS CSVLK
  - Microsoft Office CSVLK

- Your OS must have the latest Windows updates installed before configuring your device as a KMS host. To learn more, see [KMS host required updates](/windows-server/get-started/kms-activation-planning#kms-host-required-updates).

## Verify existing KMS hosts

Before you migrate to a new KMS host, it's recommended to inventory your environment to identify all existing KMS hosts. This helps ensure there aren't unauthorized or unnecessary KMS hosts present. Unapproved KMS hosts might appear if a CSVLK was used to activate a device that shouldn't serve as a KMS host. Only authorized servers should be activated with a CSVLK and configured as KMS hosts. Performing these actions can be done in an elevated command prompt or PowerShell window.

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

If you discover unauthorized KMS hosts, you can revert them to KMS clients by running the following command in an elevated window and then restart the device. Replace the Generic Volume License Key ([GVLK](/windows-server/get-started/kms-client-activation-keys#generic-volume-license-keys)) with your GVLK:

```
slmgr.vbs /ipk <GVLK>
```

## Verify KMS host product activation

To verify which products the current KMS host is activating and ensure the new KMS host activates the same Windows OS and Microsoft Office clients, run the following command:

```cmd
cscript %windir%\system32\slmgr.vbs /dlv All
```

```powershell
cscript $env:windir\system32\slmgr.vbs /dlv All
```

Check the output to determine whether the KMS host is processing activation requests for the Windows OS, Microsoft Office, or both. The partial product keys displayed can help you match these KMS host keys (CSVLK) with your records. Additionally, review the [KMS Host Event log](/windows-server/get-started/activation-troubleshoot-kms-general#useful-kms-host-events) to identify which clients are sending activation requests to this KMS host.

## Prepare the KMS host

Before configuring your environment as a KMS host, start with a clean installation of the target OS on the new server. To learn how to install your Windows Server OS, see [Install Windows Server from installation media](/windows-server/get-started/install-windows-server). Ensure that all available OS updates and security patches are applied and reboot as necessary. There are two options available for setting up your KMS host.

# [Windows OS KMS host](#tab/winoshost)

After you prepare the host OS, the next step is to configure it to serve as a KMS host. See [Create a Key Management Services (KMS) activation host](/windows-server/get-started/kms-create-host).

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

## Register a KMS host

After you configure the KMS host for Windows OS and Microsoft Office, it might automatically register with DNS if your domain permissions allow. If manual registration is required, follow the steps in [Manually create DNS records](/windows-server/get-started/kms-create-host#manually-create-dns-records).

After registering the new KMS host in DNS, you can remove the old KMS host from DNS. Client devices begin sending activation requests to the new KMS host, though it might take some time for the activation count to reach the required minimum thresholds.

> [!NOTE]
>
> - **KMS Count client activation threshold**: KMS requires at least **25** unique activation requests from the client or server OS to begin activating the client OS.
> - **KMS Count server activation threshold**: KMS requires at least **5** unique activation requests from the server or client OS to begin activating the server OS.

To confirm successful migration, review the *Event Log* on the new KMS host (**Event Viewer** > **Application and Services Log** > **Key Management Service**). You can also run the following command and review the output:

```
slmgr.vbs /dlv
```

Once client devices are sending activation requests to the new host, you can safely remove the old KMS host from DNS.

> [!NOTE]
>
> - To remove the KMS host functionality from old KMS host, install your GVLK and restart your device.
> - Best practice is to completely shut down the old KMS host to ensure that client devices transition to the new KMS host.
> - If a device was configured for a specific KMS host using `slmgr.vbs /skms`, executing `slmgr.vbs /ckms` clears that configuration and allows the devices to automatically detect the new KMS host.

## Troubleshoot KMS activation

Performing these actions must be done in an elevated command prompt or PowerShell window. To further troubleshoot other issues, see [Guidelines for troubleshooting the Key Management Service (KMS)](/windows-server/get-started/activation-troubleshoot-kms-general).

## See also

- [Key Management Services (KMS) activation planning](/windows-server/get-started/kms-activation-planning)

- [Slmgr.vbs options for obtaining volume activation information](/windows-server/get-started/activation-slmgr-vbs-options)

