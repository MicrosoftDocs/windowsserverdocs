---
title: Manage Windows Server in Amazon EC2 using Windows Admin Center
description: Learn how to use Windows Admin Center to connect and manage Windows Server on Amazon EC2
author: t-denizgu
ms.author: t-denizgu
ms.topic: how-to #Required; leave this attribute/value as-is
ms.date: 07/05/2023

---


# Manage Windows Server in Amazon EC2 using Windows Admin Center

Using Windows Admin Center you can manage the Windows Server operating system of your machines hosted in Amazon Web Services. In this article, you’ll learn how to prepare and connect your Amazon EC2 Windows Server to Windows Admin Center using a public IP.

## Prerequisites

To connect your Amazon EC2, you must have the following prerequisites ready before you start:
- Have a running Amazon EC2 instance
- Enable inbound connections for your Amazon EC2 instance. For more information on how to, see [AWS documentation](https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/authorizing-access-to-an-instance.html).
    - For Type, choose **WinRM-HTTP** and for port range enter **5985**, alternatively, you can choose **WinRM-HTTPS** and for port range enter **5986**.
    - For Source, choose **IP Addresses**, then enter the Source IP address corresponding to your Windows Admin Center gateway.

## Prepare your machine

1. **Enable WinRM access** to your target EC2 instance by running the following in PowerShell or run command on the target EC2 instance:  `winrm quickconfig`
1. **Enable inbound connections to port 5985 for WinRM over HTTP** by running the following PowerShell script on the target EC2 to enable inbound connections to port 5985:  `Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any` alternatively you can set connections through **port 5986** over **HTTPS**

## Connect to your machine
After completing the prerequisites above, add your EC2s as connections in Windows Admin Center with the following steps:
1. Choose Add and Servers
1. For server name enter target EC2’s public IP address
1. Next, choose ‘Use another account for this connection’ and enter your EC2 credentials.

## Next Steps
Now you've set up your Amazon EC2 with Windows Admin Center, learn how to manage it:
- [Manage Servers with Windows Admin Center](/windows-server/manage/windows-admin-center/use/manage-servers)