---
title: Microsoft Server Activation
description: How to activate Windows Server 2016.
ms.date: 09/19/2018
ms.topic: article
ms.assetid: 99f7daa4-30ce-4d13-be65-0a45d5cc7a54
author: JasonGerend
ms.author: thierryp
ms.localizationpriority: medium
---
# Windows Server 2016 Activation

The following information outlines initial planning considerations that you need to review for Key Management Services (KMS) activation involving Windows Server 2016. For information about KMS activation involving operating systems older than those listed here, see [Step 1: Review and Select Activation Methods](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj134256(v=ws.11)).

KMS uses a client-server model to active clients. KMS clients connect to a KMS server, called the KMS host, for activation. The KMS host must reside on your local network.

KMS hosts do not need to be dedicated servers, and KMS can be cohosted with other services. You can run a KMS host on any physical or virtual system that is running Windows 10, Windows Server 2016, Windows Server 2012 R2, Windows 8.1, or Windows Server 2012.

A KMS host running on Windows 10 or Windows 8.1 can only activate computers running client operating systems.
The following table summarizes KMS host and client requirements for networks that include Windows Server 2016 and Windows 10 clients.

> [!NOTE]
> Updates might be required on the KMS server to support activation of any of these newer clients. If you receive activation errors, check that you have the appropriate updates listed below this table.

|Product key group|KMS can be hosted on|Windows editions activated by this KMS host|
|-----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
|Volume License for Windows Server 2016|Windows Server 2012<p>Windows Server 2012 R2<p>Windows Server 2016<p>|Windows Server Semi-Annual Channel <br><br>Windows Server 2016 (all editions)<p>Windows 10 LTSB (2015 and 2016)<p>Windows 10 Professional<p>Windows 10 Enterprise<p>Windows 10 Pro for Workstations<br><br>Windows 10 Education<br><br>Windows Server 2012 R2 (all editions)<p>Windows 8.1 Professional<p>Windows 8.1 Enterprise<p>Windows Server 2012 (all editions)<p>Windows Server 2008 R2 (all editions)<p>Windows Server 2008 (all editions)<p>Windows 7 Professional<p>Windows 7 Enterprise|
|Volume license for Windows 10|Windows 7<p>Windows 8.1<p> Windows 10|Windows 10 Professional<p> Windows 10 Professional N<p> Windows 10 Enterprise<p> Windows 10 Enterprise N<p> Windows 10 Education<p> Windows 10 Education N<p> Windows 10 Enterprise LTSB (2015)<p> Windows 10 Enterprise LTSB N (2015)<p> Windows 10 Pro for Workstations<br><br>Windows 8.1 Professional<p> Windows 8.1 Enterprise<p> Windows 7 Professional<p> Windows 7 Enterprise<p>|
|Volume license for Windows Server 2012 R2 for Windows 10|Windows Server 2008 R2<p> Windows Server 2012 Standard<p> Windows Server 2012 Datacenter<p> Windows Server 2012 R2 Standard<p>Windows Server 2012 R2 Datacenter|Windows 10 Professional<p> Windows 10 Enterprise<p>Windows 10 Enterprise LTSB (2015)<br><br>Windows 10 Pro for Workstations<br><br>Windows 10 Education<br><br> Windows Server 2012 R2 (all editions)<p> Windows 8.1 Professional<p> Windows 8.1 Enterprise<p> Windows Server 2012 (all editions)<p> Windows Server 2008 R2 (all editions)<p>Windows Server 2008 (all editions)<p> Windows 7 Professional<p> Windows 7 Enterprise|

> [!NOTE]
> Depending on which operating system your KMS server is running and which operating systems you want to activate, you might need to install one or more of these updates:
> - Installations of KMS on Windows 7 or Windows Server 2008 R2 must be updated in order to support activation of clients running Windows 10. For more information, see [Update that enables Windows 7 and Windows Server 2008 R2 KMS hosts to activate Windows 10](https://support.microsoft.com/help/3079821/update-that-enables-windows-7-and-windows-server-2008-r2-kms-hosts-to-activate-windows-10). 
> - Installations of KMS on Windows Server 2012 must be updated in order to support activation of clients running Windows 10 and Windows Server 2016, or newer client or server operating systems. For more information, see [July 2016 update rollup for Windows Server 2012](https://support.microsoft.com/help/3172615/july-2016-update-rollup-for-windows-server-2012).
> - Installations of KMS on Windows 8.1 or Windows Server 2012 R2 must be updated in order to support activation of clients running Windows 10 and Windows Server 2016, or newer client or server operating systems. For more information, see [July 2016 update rollup for Windows 8.1 and Windows Server 2012 R2](https://support.microsoft.com/help/3172614/july-2016-update-rollup-for-windows-8.1-and-windows-server-2012-r2). 
> - Windows Server 2008 R2 cannot be updated to support activation of clients running Windows Server 2016, or newer operating systems.

A single KMS host can support an unlimited number of KMS clients. If you have more than 50 clients, we recommend that you have at least two KMS hosts in case one of your KMS hosts becomes unavailable. Most organizations can operate with as few as two KMS hosts for their entire infrastructure.

## Addressing KMS operational requirements
KMS can activate physical and virtual computers, but to qualify for KMS activation, a network must have a minimum number of computers (called the activation threshold). KMS clients activate only after this threshold is met. To ensure that the activation threshold is met, a KMS host counts the number of computers that are requesting activation on the network.

KMS hosts count the most recent connections. When a client or server contacts the KMS host, the host adds the machine ID to its count and then returns the current count value in its response. The client or server will activate if the count is high enough. Clients will activate if the count is 25 or higher. Servers and volume editions of Microsoft Office products will activate if the count is five or greater. The KMS only counts unique connections from the past 30 days, and only stores the 50 most recent contacts.

KMS activations are valid for 180 days, a period known as the activation validity interval. KMS clients must renew their activation by connecting to the KMS host at least once every 180 days to stay activated. By default, KMS client computers attempt to renew their activation every seven days. After a client's activation is renewed, the activation validity interval begins again.

## Addressing KMS functional requirements

KMS activation requires TCP/IP connectivity. KMS hosts and clients are configured by default to use Domain Name System (DNS). By default, KMS hosts use DNS dynamic update to automatically publish the information that KMS clients need to find and connect to them. You can accept these default settings, or if you have special network and security configuration requirements, you can manually configure KMS hosts and clients.

After the first KMS host is activated, the KMS key that is used on the first host can be used to activate up to five more KMS hosts on your network. After a KMS host is activated, administrators can reactivate the same host up to nine times with the same key.

If your organization needs more than six KMS hosts, you should request additional activations for your organization's KMS key—for example, if you have ten physical locations under one volume licensing agreement and you want each location to have a local KMS host.

> [!NOTE]
> To request this exception, contact your Activation Call Center. For more information, see [Microsoft Volume Licensing]( https://www.microsoft.com/licensing).

Computers that are running volume licensing editions of Windows 10, Windows Server 2016, Windows 8.1, Windows Server 2012 R2, Windows Server 2012, Windows 7, Windows Server 2008 R2 are, by default, KMS clients with no additional configuration needed.

If you are converting a computer from a KMS host, MAK, or retail edition of Windows to a KMS client, install the applicable KMS Client Setup Key. For more information, see [KMS Client Setup Keys](KMSclientkeys.md).
