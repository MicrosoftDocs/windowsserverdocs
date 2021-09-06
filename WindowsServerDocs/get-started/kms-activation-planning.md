---
title: Key Management Services (KMS) activation planning
description: Learn how to plan for Key Management Services (KMS) activation in Windows Server
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 9/6/2021
ms.prod: windows-server
ms.localizationpriority: medium
ms.assetid: 99f7daa4-30ce-4d13-be65-0a4d55cca754
---

# Key Management Services (KMS) activation planning

The following information outlines initial planning considerations that you need to review for Key Management Services (KMS) activation.

KMS uses a client-server model to active clients and is used for volume activation. KMS clients connect to a KMS server, called the KMS host, for activation. The KMS host must reside on your local network.

KMS hosts do not need to be dedicated servers, and KMS can be cohosted with other services. You can run a KMS host on any physical or virtual system that is running a [supported](windows-server-release-info.md) Windows Server or Windows client operating system. A KMS host running on a Windows Server operating system can activate computers running both server and client operating systems, however a KMS host running on a Windows client operating system can only activate computers also running client operating systems.

To use KMS, a KMS host needs a key that activates, or authenticates, the KMS host with Microsoft. This key is sometimes referred to as the KMS host key, but it is formally known as a Microsoft Customer Specific Volume License Key (CSVLK). You can get this key from the Product Keys section of the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) for the following agreements: Open, Open Value, Select, Enterprise, and Services Provider License. You can also get assistance by contacting your local [Microsoft Activation Center](https://www.microsoft.com/licensing/existing-customer/activation-centers).

## Operational requirements

KMS can activate physical and virtual computers, but to qualify for KMS activation, a network must have a minimum number of computers (called the activation threshold). KMS clients activate only after this threshold is met. To ensure that the activation threshold is met, a KMS host counts the number of computers that are requesting activation on the network.

KMS hosts count the most recent connections. When a client or server contacts the KMS host, the host adds the machine ID to its count and then returns the current count value in its response. The client or server will activate if the count is high enough. Clients will activate if the count is 25 or higher. Servers and volume editions of Microsoft Office products will activate if the count is five or greater. The KMS only counts unique connections from the past 30 days, and only stores the 50 most recent contacts.

KMS activations are valid for 180 days, a period known as the activation validity interval. KMS clients must renew their activation by connecting to the KMS host at least once every 180 days to stay activated. By default, KMS client computers attempt to renew their activation every seven days. After a client's activation is renewed, the activation validity interval begins again.

A single KMS host can support an unlimited number of KMS clients. If you have more than 50 clients, we recommend that you have at least two KMS hosts in case one of your KMS hosts becomes unavailable. Most organizations can operate with as few as two KMS hosts for their entire infrastructure.

Computers that are running volume licensing editions of Windows Server and Windows client are, by default, KMS clients with no extra configuration needed.

If you are converting a computer from a KMS host, MAK, or retail edition of Windows to a KMS client, you will need to install the applicable KMS client setup key. For more information, see [KMS client setup keys](../get-started/kms-client-activation-keys.md).

## Network requirements

KMS activation requires TCP/IP connectivity. KMS hosts and clients are configured by default to use Domain Name System (DNS). KMS hosts use DNS dynamic updates to automatically publish the information that KMS clients need to find and connect to them. You can accept these default settings, or if you have special network and security configuration requirements, you can manually configure KMS hosts and clients.

After the first KMS host is activated, the CSVLK that is used on the first host can be used to activate up to five more KMS hosts on your network for a total of six. After a KMS host is activated, administrators can reactivate the same host up to nine times with the same key.

If your organization needs more than six KMS hosts, you can request additional activations for your organization's CSVLK - for example, if you have 10 physical locations under one volume licensing agreement and you want each location to have a local KMS host.

> [!NOTE]
> To request this exception, please contact your local [Microsoft Activation Center](https://www.microsoft.com/licensing/existing-customer/activation-centers).

## Activation versions

The following table summarizes KMS host and client versions for networks that include Windows Server and Windows client devices.

> [!NOTE]
>
> - Updates might be required on the KMS server to support activation of any of these newer clients. If you receive activation errors, check that you have the appropriate updates listed below this table.
> - If you are working with virtual machines, see [Automatic Virtual Machine Activation](automatic-vm-activation.md) for information and AVMA keys.

| CSVLK group | CSVLK can be hosted on | Windows editions activated by this KMS host |
|--|--|--|
| Volume License for Windows Server 2019 | <ul><li>Windows Server 2019</li><li>Windows Server 2016</li><li>Windows Server 2012 R2</li></ul> | <ul><li>Windows Server Semi-Annual Channel</li><li>Windows Server 2019 (all editions)</li><li>Windows Server 2016 (all editions)</li><li>Windows 10 Enterprise LTSC 2019 </li><li>Windows 10 Enterprise LTSC N 2019</li><li>Windows 10 LTSB (2015 and 2016)</li><li>Windows 10 Professional</li><li>Windows 10 Enterprise</li><li>Windows 10 Pro for Workstations</li><li>Windows 10 Education</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows 8.1 Professional</li><li>Windows 8.1 Enterprise</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li><li>Windows 7 Professional</li><li>Windows 7 Enterprise</li></ul> |
| Volume License for Windows Server 2016 | <ul><li>Windows Server 2016</li><li>Windows Server 2012 R2</li><li>Windows Server 2012</li></ul> | <ul><li>Windows Server Semi-Annual Channel </li><li>Windows Server 2016 (all editions)</li><li>Windows 10 LTSB (2015 and 2016)</li><li>Windows 10 Professional</li><li>Windows 10 Enterprise</li><li>Windows 10 Pro for Workstations</li><li>Windows 10 Education</li><li>Windows Server 2012 R2 (all editions)</li><li>Windows 8.1 Professional</li><li>Windows 8.1 Enterprise</li><li>Windows Server 2012 (all editions)</li><li>Windows Server 2008 R2 (all editions)</li><li>Windows Server 2008 (all editions)</li><li>Windows 7 Professional</li><li>Windows 7 Enterprise</li></ul> |
| Volume license for Windows 10 | <ul><li>Windows 10</li><li>Windows 8.1</li><li>Windows 7</li></ul> | <ul><li>Windows 10 Professional</li><li>Windows 10 Professional N</li><li>Windows 10 Enterprise</li><li>Windows 10 Enterprise N</li><li>Windows 10 Education</li><li>Windows 10 Education N</li><li>Windows 10 Enterprise LTSB (2015)</li><li>Windows 10 Enterprise LTSB N (2015)</li><li>Windows 10 Pro for Workstations</li><li>Windows 8.1 Professional</li><li>Windows 8.1 Enterprise</li><li>Windows 7 Professional</li><li>Windows 7 Enterprise</li></ul> |

> [!NOTE]
> Depending on which operating system your KMS server is running and which operating systems you want to activate, you might need to install one or more of these updates:
>
> - Installations of KMS on Windows 7 or Windows Server 2008 R2 must be updated in order to support activation of clients running Windows 10. For more information, see [Update that enables Windows 7 and Windows Server 2008 R2 KMS hosts to activate Windows 10](https://support.microsoft.com/help/3079821/update-that-enables-windows-7-and-windows-server-2008-r2-kms-hosts-to-activate-windows-10).
> - Installations of KMS on Windows Server 2012 must be updated in order to support activation of clients running Windows 10 and Windows Server 2016 or Windows Server 2019, or newer client or server operating systems. For more information, see [July 2016 update rollup for Windows Server 2012](https://support.microsoft.com/help/3172615/july-2016-update-rollup-for-windows-server-2012).
> - Installations of KMS on Windows 8.1 or Windows Server 2012 R2 must be updated in order to support activation of clients running Windows 10 and Windows Server 2016 or Windows Server 2019, or newer client or server operating systems. For more information, see [July 2016 update rollup for Windows 8.1 and Windows Server 2012 R2](https://support.microsoft.com/help/3172614/july-2016-update-rollup-for-windows-8.1-and-windows-server-2012-r2).
> - Windows Server 2008 R2 cannot be updated to support activation of clients running Windows Server 2016, Windows Server 2019, or newer operating systems.
> - The KMS installed on Windows Server 2012 R2 must be updated in order to support activation of clients running Windows Server 2019. For more information, see [November 27, 2018—KB4467695 (Preview of Monthly Rollup)](https://support.microsoft.com/help/4467695/).
