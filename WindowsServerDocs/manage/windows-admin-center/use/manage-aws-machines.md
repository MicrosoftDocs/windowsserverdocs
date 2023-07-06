---
title: Manage Windows Server in Amazon EC2 using Windows Admin Center
description: Learn how to use Windows Admin Center to connect and manage Windows Server on Amazon EC2
author: t-denizgu
ms.author: t-denizgu
ms.topic: how-to 
ms.date: 07/05/2023

---

# Manage Windows Server in Amazon EC2 using Windows Admin Center

Using Windows Admin Center you can manage Windows Server machines running on Amazon EC2 in Amazon Web Services. In this article, you’ll learn how to prepare and connect your Amazon EC2 Windows Server to Windows Admin Center using a public IP.

## Prerequisites

To connect your Windows Server Amazon EC2 instance, you must have the following prerequisites ready before you start:
- Have a running Amazon EC2 instance.
- Configure WinRM for HTTPS. WinRM HTTPS requires a local computer Server Authentication certificate with a CN matching the public name of your Windows Server Amazon EC2 instance. For more information on how to, see [How to configure WINRM for HTTPS](/troubleshoot/windows-client/system-management-components/configure-winrm-for-https).
- Enable inbound connections for your Amazon EC2 instance. For more information on how to, see [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/authorizing-access-to-an-instance.html).
  - For **Type**, select **WinRM-HTTPS** and for port range enter **5986**.
  - For **Source**, select **IP Addresses**, then enter the source IP address corresponding to your Windows Admin Center gateway.

> [!NOTE]
> Alternatively you can choose to connect to your Amazon EC2 instance via HTTP by selecting **WinRM-HTTP** and entering **5985** as your port range. However, we recommend you consider the security implications.

## Prepare your machine

After completing the prerequisites above, you must configure your Windows Server Amazon EC2 instance with the following steps:
1. Enable WinRM access to your target Amazon EC2 instance by running the following in PowerShell or run command on the target EC2 instance:  `winrm quickconfig`.
1. Enable inbound connections to port 5986 for WinRM over HTTPS by running the following PowerShell script on the target EC2 to enable inbound connections to port 5986. Alternatively you can configure port 5985 for WinRM over HTTP: `Set-NetFirewallRule -Name WINRM-HTTPS-In-TCP-PUBLIC -RemoteAddress Any`.

## Connect to your machine

Now you can add your Windows Server Amazon EC2 instance as connections in Windows Admin Center with the following steps:
1. Open your Windows Admin Center portal.
1. To add a new server select Add, from the Add or create resource menu select Add under the Servers section.
1. In the Server name field, enter the public IPv4 address of your Amazon EC2 instance.
1. Next, choose ‘Use another account for this connection’ and enter your Windows credentials.

## Next steps

Now you've set up your Amazon EC2 with Windows Admin Center, learn how to manage it:
- [Manage Servers with Windows Admin Center](/windows-server/manage/windows-admin-center/use/manage-servers).