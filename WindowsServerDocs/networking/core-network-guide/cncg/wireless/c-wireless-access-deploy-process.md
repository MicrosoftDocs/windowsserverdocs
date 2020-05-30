---
title: Wireless Access Deployment Process
description: This topic is part of the Windows Server 2016 Networking guide "Deploy Password-Based 802.1X Authenticated Wireless Access"
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 2555f238-926e-4b20-9bfb-9774831062da
author: eross-msft
ms.author: lizross
---
# Wireless Access Deployment Process

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

The process that you use to deploy wireless access occurs in these stages:

## Stage 1 – AP Deployment

Plan, deploy, and configure your APs for wireless client connectivity and for use with NPS. Depending on your preference and network dependencies, you can either pre\-configure settings on your wireless APs prior to installing them on your network, or you can configure them remotely after installation.

## Stage 2 – AD DS Group Configuration

In AD DS, you must create one or more wireless users security groups.

Next, identify the users who are allowed wireless access to the network.

Finally, add the users to the appropriate wireless users security groups that you created.

>[!NOTE]
>By default, the **Network Access Permission** setting in user account dial-in properties is configured with the setting **Control access through NPS Network Policy**. Unless you have specific reasons to change this setting, it is recommended that you keep the default. This allows you to control network access through the network policies that you configure in NPS.

## Stage 3 – Group Policy Configuration

Configure the Wireless Network \(IEEE 802.11\) Policies extension of Group Policy by using the Group Policy Management Editor Microsoft Management Console \(MMC\).

To configure domain\-member computers using the settings in the wireless network policies, you must apply Group Policy. When a computer is first joined to the domain, Group Policy is automatically applied. If changes are made to Group Policy, the new settings are automatically applied:

- By Group Policy at pre\-determined intervals

- If a domain user logs off and then back on to the network

- By restarting the client computer and logging on to the domain

You can also force Group Policy to refresh while logged on to a computer by running the command **gpupdate** at the command prompt.

## Stage 4 – NPS configuration

Use a configuration wizard in NPS to add wireless access points as RADIUS clients, and to create the network policies that NPS uses when processing connection requests.

When using the wizard to create the network policies, specify PEAP as the EAP type, and the wireless users security group that was created in the second stage.

## Stage 5 – Deploy wireless clients

Use client computers to connect to the network.

For domain member computers that can log on to the wired LAN, the necessary wireless configuration settings are automatically applied when Group Policy is refreshed.

If you have enabled the setting in Wireless Network \(IEEE 802.11\) Policies to connect automatically when the computer is within broadcast range of the wireless network, your wireless, domain\-joined computers will then automatically attempt to connect to the wireless LAN.

To connect to the wireless network, users need only supply their domain user name and password credentials when prompted by Windows.

To plan your wireless access deployment, see [Wireless Access Deployment Planning](d-wireless-access-planning.md).
