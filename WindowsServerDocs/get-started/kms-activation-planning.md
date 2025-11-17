---
title: Key Management Services (KMS) activation planning for Windows Server
description: Learn how to plan for Key Management Services (KMS) activation in Windows Server.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 03/17/2025
---

# Key Management Services (KMS) activation planning

The following information outlines initial planning considerations that you need to review for Key Management Services (KMS) activation.

KMS uses a client-server model to active clients and is used for volume activation. KMS clients connect to a KMS server, called the KMS host, for activation. The KMS host must reside on your local network.

KMS hosts don't need to be dedicated servers, and KMS can be cohosted with other services. You can run a KMS host on any physical or virtual system that is running a [supported](windows-server-release-info.md) Windows Server or Windows client operating system. A KMS host running on a Windows Server operating system can activate computers running both server and client operating systems. However, a KMS host running on a Windows client operating system can only activate computers also running client operating systems.

To use KMS, a KMS host needs a key that activates, or authenticates, the KMS host with Microsoft. This key is sometimes referred to as the KMS host key, but is formally known as a Microsoft Customer Specific Volume License Key (CSVLK). You can get this key from the Product Keys section of the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) for the following agreements: Open, Open Value, Select, Enterprise, and Services Provider License. You can also get assistance by contacting your local [Microsoft Activation Center](https://www.microsoft.com/licensing/existing-customer/activation-centers).

## Operational requirements

KMS can activate physical and virtual computers, but to qualify for KMS activation, a network must have a minimum number of computers (called the activation threshold). KMS clients activate only after this threshold is met. To ensure that the activation threshold is met, a KMS host counts the number of computers that are requesting activation on the network.

KMS hosts count the most recent connections. When a client or server contacts the KMS host, the host adds the machine ID to its count and then returns the current count value in its response. The client or server activates if the count is high enough. Clients activate if the count is 25 or higher. Servers and volume editions of Microsoft Office products activate if the count is five or greater. The KMS only counts unique connections from the past 30 days, and only stores the 50 most recent contacts.

KMS activations are valid for 180 days, a period known as the activation validity interval. KMS clients must renew their activation by connecting to the KMS host at least once every 180 days to stay activated. By default, KMS client computers attempt to renew their activation every seven days. After a client's activation is renewed, the activation validity interval begins again.

A single KMS host can support an unlimited number of KMS clients. If you have more than 50 clients, we recommend that you have at least two KMS hosts in case one of your KMS hosts becomes unavailable. Most organizations can operate with as few as two KMS hosts for their entire infrastructure.

After the first KMS host is activated, the CSVLK that is used on the first host can be used to activate up to five more KMS hosts on your network for a total of six. After a KMS host is activated, administrators can reactivate the same host up to nine times with the same key.

If your organization needs more than six KMS hosts, you can request more activations for your organization's CSVLK. For example, if you have 10 physical locations under one volume licensing agreement and you want each location to have a local KMS host. To request this exception, contact your local [Microsoft Activation Center](https://www.microsoft.com/licensing/existing-customer/activation-centers).

Computers that are running volume licensing editions of Windows Server and Windows client are, by default, KMS clients with no extra configuration needed.

If you're converting a computer from a KMS host, MAK, or retail edition of Windows to a KMS client, installing the applicable KMS client setup key is necessary. For more information, see [KMS client setup keys](../get-started/kms-client-activation-keys.md).

## Network requirements

KMS activation requires TCP/IP connectivity. KMS hosts and clients are configured by default to use Domain Name System (DNS). KMS hosts use DNS dynamic updates to automatically publish the information that KMS clients need to find and connect to them. You can accept these default settings, or if you have special network and security configuration requirements, you can manually configure KMS hosts and clients.

By default, a KMS host is configured to use TCP on port 1688.

## Activation versions

The following table summarizes KMS host and client versions for networks that include Windows Server and Windows client devices.

> [!IMPORTANT]
> Windows Updates might be required on the KMS server to support activation of newer clients. If you receive activation errors, check that you have the appropriate updates listed below this table.

# [Windows Server 2025](#tab/server25)

| CSVLK group | CSVLK can <br> be hosted on | Windows editions <br> activated by this KMS host |
|--|--|--|
| Volume License for Windows Server 2025 | <ul><li>Windows Server 2025&sup1;</li><li>Windows Server 2022&sup1;</li><li>Windows Server 2019</li></ul> | <ul><li>Windows Server 2025 (all editions)</li><li>Windows Server 2022 (all editions)</li><li>Windows Server Semi-Annual Channel</li><li>Windows Server 2019 (all editions)</li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 11 Enterprise LTSC 2024</li><li>Windows 11 Enterprise/Enterprise N</li><li>Windows 11 Professional/Professional N</li><li>Windows 11 Professional for Workstations/Professional N for Workstations</li><li>Windows 11 for Education/Education N</li><li>Windows 10 Enterprise LTSC/LTSC N/LTSB</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 for Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |

# [Windows Server 2022](#tab/server22)

| CSVLK group | CSVLK can <br> be hosted on | Windows editions <br> activated by this KMS host |
|--|--|--|
| Volume License for Windows Server 2022 | <ul><li>Windows Server 2022&sup1;</li><li>Windows Server 2019</li><li>Windows Server 2016</li></ul> | <ul><li>Windows Server 2022 (all editions)</li><li>Windows Server Semi-Annual Channel</li><li>Windows Server 2019 (all editions)</li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 11 Enterprise/Enterprise N</li><li>Windows 11 Professional/Professional N</li><li>Windows 11 Professional for Workstations/Professional N for Workstations</li><li>Windows 11 for Education/Education N</li><li>Windows 10 Enterprise LTSC/LTSC N/LTSB</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 for Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |

# [Windows Server 2019](#tab/server19)

| CSVLK group | CSVLK can <br> be hosted on | Windows editions <br> activated by this KMS host |
|--|--|--|
| Volume License for Windows Server 2019 | <ul><li>Windows Server 2019</li><li>Windows Server 2016</li><li>Windows Server 2012 R2</li></ul> | <ul><li>Windows Server Semi-Annual Channel</li><li>Windows Server 2019 (all editions)</li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 10 Enterprise LTSC/LTSC N/LTSB</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 for Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |

# [Windows Server 2016](#tab/server16)

| CSVLK group | CSVLK can <br> be hosted on | Windows editions <br> activated by this KMS host |
|--|--|--|
| Volume License for Windows Server 2016 | <ul><li>Windows Server 2016</li><li>Windows Server 2012 R2</li><li>Windows Server 2012</li></ul> | <ul><li>Windows Server Semi-Annual Channel </li><li>Windows Server 2016 (all editions)</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li> <br> <li>Windows 10 LTSB (2015 and 2016)</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Professional for Workstations/Professional N for Workstations</li><li>Windows 10 Education/Education N</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |

# [Windows 10](#tab/windows10)

| CSVLK group | CSVLK can <br> be hosted on | Windows editions <br> activated by this KMS host |
|--|--|--|
| Volume license for Windows 10 | <ul><li>Windows 10</li><li>Windows 8.1</li><li>Windows 7</li></ul> | <ul><li>Windows 10 Enterprise LTSB/LTSB N (2015)</li><li>Windows 10 Enterprise/Enterprise N</li><li>Windows 10 Professional/Professional N</li><li>Windows 10 Education/Education N</li><li>Windows 10 Pro for Workstations</li><li>Windows 8.1 Enterprise</li><li>Windows 8.1 Professional</li><li>Windows 7 Enterprise</li><li>Windows 7 Professional</li></ul> |

---

1. Azure activates Windows Server Datacenter: Azure Edition, meaning it can't be configured as a KMS host

## KMS host required updates

Depending on which operating system your KMS host is running and which operating systems you want to activate, you might need to install one or more of the following updates. Updates are required when you want to activate a version of Windows that is newer than the version your KMS host is running.

> [!NOTE]
> The updates listed are the minimum required. Where later cumulative updates or monthly rollups are listed as an option, install the latest available version for your operating system to benefit from security and other fixes.

| KMS host OS version | KMS client OS version(s) to activate | Required update |
|--|--|--|
| Windows Server 2022 | - Windows Server 2025 | [February 13, 2024 - KB5034765](https://support.microsoft.com/help/5034765) or later cumulative update |
| Windows Server 2019 | - Windows Server 2025 <br> - Windows Server 2022 | [February 13, 2024 - KB5034768](https://support.microsoft.com/help/5034768) or later cumulative update <br> [June 8, 2021 - KB5003646](https://support.microsoft.com/help/5003646) or later cumulative update |
| Windows Server 2016 | - Windows Server 2022 <br> - Windows Server 2019 | [June 8, 2021 - KB5003638](https://support.microsoft.com/help/5003638) or later cumulative update |
| Windows Server 2016 | - Windows Server 2019 | [December 3, 2018 - KB4478877](https://support.microsoft.com/help/4478877/) or later cumulative update |
| Windows Server 2012 R2 | - Windows Server 2019 <br> - Windows Server 2016 <br> - Windows 10 | [November 27, 2018 - KB4467695 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4467695/) or later monthly rollup |
| Windows Server 2012 R2 | - Windows Server 2016 <br> - Windows 10</li></ul> | [July 2016 update rollup for Windows 8.1 and Windows Server 2012 R2](https://support.microsoft.com/help/3172614) or later monthly rollup |
| Windows Server 2012 | - Windows Server 2016 <br> - Windows Server 2012 R2 <br> - Windows 10</li></ul> | [July 2016 update rollup for Windows Server 2012](https://support.microsoft.com/help/3172615) or later monthly rollup |
| Windows Server 2008 R2 | - Windows Server 2012 R2 <br> - Windows Server 2012 <br> - Windows 10 | [Update that enables Windows 7 and Windows Server 2008 R2 KMS hosts to activate Windows 10](https://support.microsoft.com/help/3079821) |
| Windows 8.1 | - Windows 10 | [July 2016 update rollup for Windows 8.1 and Windows Server 2012 R2](https://support.microsoft.com/help/3172614) or later monthly rollup |
| Windows 7 | - Windows 10 | [Update that enables Windows 7 and Windows Server 2008 R2 KMS hosts to activate Windows 10](https://support.microsoft.com/help/3079821) |

