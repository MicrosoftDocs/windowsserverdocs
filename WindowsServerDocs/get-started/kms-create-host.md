---
title: Create a Key Management Services (KMS) Activation Host in Windows Server
description: See how to create a Key Management Services (KMS) activation host that you can use for volume activation on Windows Server and Windows KMS clients.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.date: 04/03/2025
# customer intent: As an administrator, I want to create a Key Management Services (KMS) host so that I can take advantage of automatic and centralized activation for volume-licensed products in my network.
---

# Create a Key Management Services (KMS) activation host

Key Management Services (KMS) uses a client-server model to activate Windows clients. KMS is used for volume activation on your local network. KMS clients connect to a KMS server, called the KMS host, for activation. The KMS clients that a KMS host can activate are dependent on the host key used to activate the KMS host.

This article walks you through the steps you need to create a KMS host. For more information about KMS and initial planning considerations, see [Key Management Services (KMS) activation planning](kms-activation-planning.md).

## Prerequisites

A single KMS host can support an unlimited number of KMS clients. If you have more than 50 clients, we recommend that you have at least two KMS hosts in case one of your KMS hosts becomes unavailable. Most organizations can operate with as few as two KMS hosts for their entire infrastructure.

KMS hosts don't need to be dedicated servers. You can host other services on a KMS host. You can run a KMS host on any physical or virtual system that runs a supported Windows Server or Windows client operating system.

The version of Windows you use for your KMS host determines the version of Windows you can activate for your KMS clients. For help with deciding which version is appropriate for your environment, see the [table of activation versions](kms-activation-planning.md#activation-versions).

By default, KMS hosts publish Service (SRV) resource records in your Domain Name System (DNS). As a result, KMS clients can automatically discover the KMS host and activate without the need for any configuration on the KMS client. You can disable automatic publishing and create the records manually. These steps are needed for automatic activation if the DNS service doesn't support dynamic updates.

To create a KMS host, you need the following prerequisites:

- A computer running Windows Server or Windows. A KMS host running on Windows Server can activate computers running both server and client operating systems. However, a KMS host running on a Windows client operating system can only activate computers also running client operating systems.
- A user account that's a member of the Administrators group on the KMS host.
- KMS and client versions that are compatible with each other, and a Windows version that can host KMS. For more information, see [Key Management Services (KMS) activation planning](kms-activation-planning.md?tabs=server25).
- A KMS host key for your organization. You can get this key from the Microsoft 365 admin center. For more information, see [Find and use product keys for volume licensing](/microsoft-365/commerce/licenses/product-keys-for-vl).
- Access to the internet for activating the KMS host or performing a phone activation.

## Install and configure a KMS host

To install and configure a KMS host, take the steps in the following sections.

### Install the Volume Activation Services role

To install the Volume Activation Services role, run the following command in an elevated PowerShell session:

```PowerShell
Install-WindowsFeature -Name VolumeActivation -IncludeManagementTools
```

### Configure Windows Firewall

Configure Windows Firewall to allow KMS to receive network traffic. You can allow this traffic for any network profiles, which is the default setting, or for any combination of Domain, Private, and Public network profiles. By default, a KMS host is configured to use Transmission Control Protocol (TCP) on port 1688.

To configure the firewall rule to allow network traffic for only the Domain and Private network profiles, run the following command:

```PowerShell
Set-NetFirewallRule -Name SPPSVC-In-TCP -Profile Domain,Private -Enabled True
```

### Use the Volume Activation Tools wizard to configure the host

1. Open the Volume Activation Tools wizard by running the following command:

   ```PowerShell
   vmw.exe
   ```

1. On the introduction page, select **Next**.

1. For the activation type, select **Key Management Service (KMS)**. For the server, enter **localhost** to configure the local server. If you want to configure a different server, enter its host name. Select **Next**.

1. Select **Install your KMS host key**, enter the product key for your organization, and then select **Commit**.

1. After the product key is installed, select **Next** to activate the product.

1. Under **Select product**, select the product you want to activate, and then select an activation method. To activate the key online, select **Activate online**, and then select **Commit**. If you're prompted to confirm activation of the KMS host, select **Yes**.

### Complete the configuration

After the activation finishes successfully, the KMS host configuration appears.

- If the configuration settings meet your requirements:
  1. Select **Close** to exit the wizard. The system creates DNS records, and you can start [activating KMS clients](kms-client-activation-keys.md).
  1. If you need to create SRV records manually to publish the KMS host, see [Manually create DNS records](#manually-create-dns-records) later in this article.

- If you want to change the configuration settings:
  1. Select **Next**.
  1. Change the configuration values based on your requirements, and then select **Commit**.

> [!NOTE]
> You can now start [activating KMS clients](kms-client-activation-keys.md). However, a network must first have a minimum number of computers (called the activation threshold). KMS hosts keep track of the number of recent connections. When a client or server contacts the KMS host, the host notes the machine ID, increments the count of contacts, and then returns the current count in its response. The client or server is activated if the count is high enough:
>
> - Windows clients are activated if the count is 25 or greater.
> - Windows Server and volume editions of Microsoft Office products are activated if the count is five or greater.
>
> In the count, KMS includes only unique connections from the past 30 days, and it stores only the 50 most recent contacts.

## Manually create DNS records

If your DNS service doesn't support dynamic updates, you must manually create the resource records in order to publish the KMS host. Create DNS resource records for KMS manually with your DNS service by using the following information. If you change the default port number in the KMS host configuration, also adjust the port number that you use for the resource records.

| Property | Value |
|--|--|
| Type | SRV |
| Service/Name | _vlmcs |
| Protocol | _tcp |
| Priority | 0 |
| Weight | 0 |
| Port number | 1688 |
| Hostname | \<FQDN-of-KMS-host\> |

You should also disable publishing on all KMS hosts if your DNS service doesn't support dynamic updates. For instructions, see [Disable publishing of DNS records](#disable-publishing-of-dns-records) later in this article. By disabling publishing, you prevent event logs from collecting failed DNS publishing events.

> [!TIP]
> Manually created resource records can also coexist with resource records that KMS hosts automatically publish in other domains as long as all records are maintained to prevent conflicts.

### Disable publishing of DNS records

To disable publishing of DNS records by the KMS host:

1. Open the Volume Activation Tools wizard by running the following command:

   ```PowerShell
   vmw.exe
   ```

1. On the introduction page, select **Next**.

1. For the activation type, select **Key Management Service (KMS)**. For the server, enter **localhost** to configure the local server. If you want to configure a different server, enter its host name. Select **Next**.

1. Select **Skip to Configuration**, and then select **Next**.

1. Next to **DNS Records**, clear the **Publish** checkbox, and then select **Commit**.
