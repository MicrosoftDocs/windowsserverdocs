---
title: Install Network Policy Server
description: You can use this topic to install Network Policy Server (NPS) by using either Windows PowerShell or the Add Roles and Features Wizard in Windows Server 2016
manager: brianlic
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 4842a4ab-70bb-4744-bea7-70f2ac892ad1
ms.author: lizross
author: eross-msft
---

# Install Network Policy Server

You can use this topic to install Network Policy Server (NPS) by using either Windows PowerShell or the Add Roles and Features Wizard. NPS is a role service of the Network Policy and Access Services server role.

> [!NOTE]
> By default, NPS listens for RADIUS traffic on ports 1812, 1813, 1645, and 1646 on all installed network adapters. If Windows Firewall with Advanced Security is enabled when you install NPS, firewall exceptions for these ports are automatically created during the installation process for both Internet Protocol version 6 \(IPv6\) and IPv4 traffic. If your network access servers are configured to send RADIUS traffic over ports other than these defaults, remove the exceptions created in Windows Firewall with Advanced Security during NPS installation, and create exceptions for the ports that you do use for RADIUS traffic.

**Administrative Credentials**

To complete this procedure, you must be a member of the **Domain Admins** group.

## To install NPS by using Windows PowerShell

To perform this procedure by using Windows PowerShell, run Windows PowerShell as Administrator, type the following command, and then press ENTER.

`Install-WindowsFeature NPAS -IncludeManagementTools`

## To install NPS by using Server Manager

1.  On NPS1, in Server Manager, click **Manage**, and then click **Add Roles and Features**. The Add Roles and Features Wizard opens.

2.  In **Before You Begin**, click **Next**.

    > [!NOTE]
    > The **Before You Begin** page of the Add Roles and Features Wizard is not displayed if you have previously selected **Skip this page by default** when the Add Roles and Features Wizard was run.

3.  In **Select Installation Type**, ensure that **Role-Based or feature-based installation** is selected, and then click **Next**.

4.  In **Select destination server**, ensure that **Select a server from the server pool** is selected. In **Server Pool**, ensure that the local computer is selected. Click **Next**.

5.  In **Select Server Roles**, in **Roles**, select **Network Policy and Access Services**. A dialog box opens asking if it should add features that are required for Network Policy and Access Services. Click **Add Features**, and then click **Next**

6.  In **Select features**, click **Next**, and in **Network Policy and Access Services**, review the information that is provided, and then click **Next**.

7.  In **Select role services**, click **Network Policy Server**.  In **Add features that are required for Network Policy Server**, click **Add Features**. Click **Next**.

8.  In **Confirm installation selections**, click **Restart the destination server automatically if required**. When you are prompted to confirm this selection, click **Yes**, and then click **Install**. The Installation progress page displays status during the installation process. When the process completes, the message "Installation succeeded on *ComputerName*" is displayed, where *ComputerName* is the name of the computer upon which you installed Network Policy Server. Click **Close**.

For more information, see [Manage NPSs](nps-manage-servers.md).