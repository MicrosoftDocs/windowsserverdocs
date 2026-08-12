---
title: Connect Amazon Web Service (AWS) EC2s to Windows Admin Center
description: This article describes how to use Windows Admin Center running on-premises to manage the operating system on one or more on Amazon Web Service (AWS) EC2s.
author: t-denigu
ms.author: t-denizgu
ms.service: #Required; service per approved list. slug assigned by ACOM.
ms.topic: tutorial #Required; leave this attribute/value as-is.
ms.date: 06/22/2023
ms.custom: template-tutorial #Required; leave this attribute/value as-is.
---


# Connect Amazon Web Service (AWS) EC2s to Windows Admin Center 

This article describes how to use Windows Admin Center running on-premises to manage the operating system on one or more  [Amazon Web Service (AWS) EC2s](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)



## Connecting to EC2s with a public IP

If the EC2s you want to manage with Windows Admin Center have public IPs, add them to your Windows Admin Center gateway by IP address. Before adding the EC2s to Windows Admin Center, you must complete the prerequisites.

## Prerequisites

You must configure the following settings for WAC to be able to remotely manage the target EC2 instance:

1. **Enable WinRM access** to your target EC2 instance by running the following in PowerShell or run command on the target EC2 instance:  `winrm quickconfig`
1. **Enable inbound connections to port 5985 for WinRM over HTTP** by running the following PowerShell script on the target EC2 to enable inbound connections to port 5985:  `Set-NetFirewallRule -Name WINRM-HTTP-In-TCP-PUBLIC -RemoteAddress Any` alternatively you can set connections through **port 5986** over **HTTPS**
1. **Enable inbound connections on the [Amazon Web Services (AWS) console](https://aws.amazon.com/console/)**
    - From the top navigation bar, select a Region for the security group. Security groups are specific to a Region, so you should select the same Region in which you created your instance.
    - In the navigation pane, choose Instances.
    :::image type="content" source="add-ews-ec2s-images/image.png" alt-text="Instances in the navigation plane":::
    - Select your instance and, in bottom half of the screen, choose the Security tab. Security groups list the security groups that are associated with the instance. Inbound rules displays a list of the inbound rules that are in effect for the instance.
    - For the security group to which you'll add the new rule, choose the security group ID link to open the security group.
    :::image type="content" source="add-ews-ec2s-images/image-1.png" alt-text="Selecting security group":::
    - On the Inbound rules tab, choose **Edit inbound rules**.
    :::image type="content" source="add-ews-ec2s-images/image-2.png" alt-text="Adding inbound rules":::
    - On the Edit inbound rules page, do the following:
        - Choose Add rule.
        - For Type, choose **WinRM-HTTP** and for port range enter **5985**, alternatively, you can choose **WinRM-HTTPS** and for port range enter **5986**
        - For Source, choose **IP Addresses**, then enter the Source IP address corresponding to your Windows Admin Center gateway.
        - Choose Save rules.
    :::image type="content" source="add-ews-ec2s-images/image-3.png" alt-text="Configuration for inbound rule":::

## Connecting to the instance
After completing the prerequisites above, add your EC2s as connections in Windows Admin Center with the following steps:
- Choose Add and Servers
- For server name enter target EC2’s public IP address
- Next, choose ‘Use another account for this connection’ and enter your EC2 credentials.
