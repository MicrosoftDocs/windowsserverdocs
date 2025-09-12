---
title: Manage Windows Server on Amazon EC2 Using Windows Admin Center
description: Learn how to use Windows Admin Center to connect and manage Windows Server on Amazon EC2.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to 
ms.date: 07/05/2023

---

# Manage Windows Server on Amazon EC2 by using Windows Admin Center

By using Windows Admin Center, you can manage Windows Server machines running on Amazon EC2 in Amazon Web Services. In this article, you learn how to prepare and connect a Windows Server machine running on Amazon EC2 to Windows Admin Center by using a public IP address.

## Prerequisites

- Have a running Amazon EC2 instance.
- Configure WinRM for HTTPS. WinRM HTTPS requires a server authentication certificate for a local computer, with a CN that matches the public name of your Windows Server Amazon EC2 instance. For more information, see [How to configure WINRM for HTTPS](/troubleshoot/windows-client/system-management-components/configure-winrm-for-https).
- Enable inbound connections for your Amazon EC2 instance. For more information, see the [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/authorizing-access-to-an-instance.html).
  - For **Type**, select **WinRM-HTTPS**. For the port range, enter **5986**.
  - For **Source**, select **IP Addresses**, and then enter the source IP address that corresponds to your Windows Admin Center gateway.

> [!NOTE]
> Alternatively, you can connect to your Amazon EC2 instance via HTTP by selecting **WinRM-HTTP** and entering **5985** as your port range. However, we recommend that you consider the security implications.

## Prepare your machine

Configure your Windows Server Amazon EC2 instance by using the following steps:

1. Enable WinRM access to your target Amazon EC2 instance by running the `winrm quickconfig` command in PowerShell on the target EC2 instance.

1. Enable inbound connections to port 5986 for WinRM over HTTPS by running the following PowerShell script on the target EC2 instance: `Set-NetFirewallRule -Name WINRM-HTTPS-In-TCP-PUBLIC -RemoteAddress Any`. Alternatively, you can configure port 5985 for WinRM over HTTP.

## Connect to your machine

Add your Windows Server Amazon EC2 instance as a connection in Windows Admin Center:

1. In the Azure portal, open Windows Admin Center.

1. On the **Add or create resource** menu, in the **Servers** section, select **Add**.

1. For **Server name**, enter the public IPv4 address of your Amazon EC2 instance.

1. Select **Use another account for this connection** and enter your Windows credentials.

## Related content

Now that you've set up your Amazon EC2 instance with Windows Admin Center, learn how to manage it:

- [Manage servers with Windows Admin Center](/windows-server/manage/windows-admin-center/use/manage-servers)

