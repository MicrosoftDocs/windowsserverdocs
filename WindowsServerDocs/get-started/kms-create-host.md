---
title: How to create a Key Management Services (KMS) activation host in Windows Server
description: Learn how to create a Key Management Services (KMS) activation host to activate Windows Server and Windows KMS clients.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 9/13/2021
ms.prod: windows-server
---

# How to create a Key Management Services (KMS) activation host

KMS uses a client-server model to active Windows clients and is used for volume activation on your local network. KMS clients connect to a KMS server, called the KMS host, for activation. The KMS clients that a KMS host can activate are dependent on the host key used to activate the KMS host. This article walks you through the steps you need to create a KMS host. To learn more about KMS and the initial planning considerations, see [Key Management Services (KMS) activation planning](kms-activation-planning.md).

## Prerequisites

A single KMS host can support an unlimited number of KMS clients. If you have more than 50 clients, we recommend that you have at least two KMS hosts in case one of your KMS hosts becomes unavailable. Most organizations can operate with as few as two KMS hosts for their entire infrastructure.

KMS hosts do not need to be dedicated servers, and KMS can be co-hosted with other services. You can run a KMS host on any physical or virtual system that is running a supported Windows Server or Windows client operating system.

The version of Windows you use for your KMS host determines the version of Windows you can activate for your KMS clients. Please see the [table of activation versions](kms-activation-planning.md#activation-versions) to help you decide which is right for your environment.

By default, KMS hosts automatically publish SRV resource records in DNS. This enables KMS clients to automatically discover the KMS host and activate without the need for any configuration on the KMS client. Automatic publishing can be disabled and the records can be created manually, which is also necessary for automatic activation if the DNS service does not support dynamic updates.

You will need:

- A computer running Windows Server or Windows. A KMS host running on a Windows Server operating system can activate computers running both server and client operating systems, however a KMS host running on a Windows client operating system can only activate computers also running client operating systems.

- The user account you use must be a member of the Administrators group on the KMS host.

- A KMS host key for your organization. You can get this key from the Product Keys section of the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx).

## Install and configure a KMS host

1. From an elevated PowerShell session, run the following command to install the Volume Activation Services role:

   ```PowerShell
   Install-WindowsFeature -Name VolumeActivation -IncludeManagementTools
   ```

1. Configure the Windows Firewall to allow the Key Management Service to receive network traffic. You can allow this for any network profiles (default), or for any combination of Domain, Private, and Public network profiles. By default, a KMS host is configured to use TCP on port 1688. In the example below, the firewall rule is configured to allow network traffic for the Domain and Private network profiles only:

   ```PowerShell
   Set-NetFirewallRule -Name SPPSVC-In-TCP -Profile Domain,Private -Enabled True
   ```

1. Launch the Volume Activation Tools wizard by running:

   ```PowerShell
   vmw.exe
   ```

1. Select **Next** on the introduction screen. Select **Key Management Service (KMS)** as the activation type and enter `localhost` to configure the local server or the hostname of the server you want to configure.

1. Select **Install your KMS host key** and enter the product key for your organization, then select **Commit**.

1. Once the product key has been installed, you need to activate the product. Click **Next**.

1. Select the product you want to activate from the dropdown menu, then select whether you want to activate online or by phone. In this example, select **Activate online** and then **Commit**.

1. Once activation is successful, the KMS host configuration will be shown. If this is the configuration you want, you can select **Close** to exit the wizard. DNS records will be created and you can start [activating KMS clients](kms-client-activation-keys.md). See the section below if you need to [manually create DNS records](#manually-create-dns-records). If you want to change the configuration settings, select **Next**.

1. **Optional**: Change the configuration values based on your requirements and select **Commit**.

> [!NOTE]
> You can now start [activating KMS clients](kms-client-activation-keys.md), however a network must have a minimum number of computers (called the activation threshold). KMS hosts count the number of recent connections and so when a client or server contacts the KMS host, the host adds the machine ID to its count and then returns the current count value in its response. The client or server will activate if the count is high enough. Windows clients will activate if the count is 25 or higher. Windows Server and volume editions of Microsoft Office products will activate if the count is five or greater. The KMS only counts unique connections from the past 30 days, and only stores the 50 most recent contacts.

## Manually create DNS records

If your DNS service does not support dynamic update, the resource records must be manually created to publish the KMS host. Create DNS resource records for KMS manually with your DNS service using the information below (altering the default port number if you changed this in the KMS host configuration):

| Property | Value |
|--|--|
| Type | SRV |
| Service/Name | _vlmcs |
| Protocol | _tcp |
| Priority | 0 |
| Weight | 0 |
| Port number | 1688 |
| Hostname | *FQDN of the KMS host* |

You should also disable publishing on all KMS hosts if your DNS service does not support dynamic update to prevent event logs from collecting failed DNS publishing events.

> [!TIP]
> Manually created resource records can also coexist with resource records that KMS hosts automatically publish in other domains as long as all records are maintained to prevent conflicts.

### Disable publishing of DNS records

To disable publishing of DNS records by the KMS host:

1. Launch the Volume Activation Tools wizard by running:

   ```PowerShell
   vmw.exe
   ```

1. Select **Next** on the introduction screen. Select **Key Management Service (KMS)** as the activation type and enter `localhost` to configure the local server or the hostname of the server you want to configure.

1. Select **Skip to Configuration**, then select **Next**.

1. Uncheck the box for publish DNS records, then select **Commit**.
