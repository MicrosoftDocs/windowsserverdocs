---
title: Windows Admin Center in Azure
description: 
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.date: 02/16/2021
---
# Using Windows Admin Center in the Azure portal

You can now enable a preview version of Windows Admin Center in the Azure portal so that you can use it to manage the operating system inside Windows Server-based VMs in Azure. This provides the ability to manage most operating system functions from outside the VM, without using Remote Desktop or PowerShell to connect to the VM. This article provides an overview of the functionality provided, how to install Windows Admin Center in your VMs, answers frequently asked questions, and provides a list of known issues and tips for troubleshooting in case something doesn't work quite right.

## Overview and requirements of Windows Admin Center in the Azure portal

Windows Admin Center is currently implemented in the Azure portal in the form of an extension that you install in each Azure VM that you want to use with Windows Admin Center.

* We maintain an external service that manages certificates and DNS records for you

The Azure VM that you want to manage must have the following:

* At least 3 GiB of memory
* Azure public cloud (region check?)
* outbound port rule
* inbound port rule

## Installing Windows Admin Center in a VM

1. Open the Azure portal and navigate to your VM.<br>If you're creating a new VM, make sure it meets the requirements listed earlier in this article.
2. In the virtual machine settings, navigate to **Overview** > **Networking** > **Outbound port rules**.
3. Select **Add outbound port rule**, enter the following values, and then select **Add**.

   | Field                        | Value              |
   | --------------------------   | ------------------ |
   | **Source**                   | VirtualNetwork     |
   | **Source port ranges**       | *                  |
   | **Destination**              | IP Addresses       |
   | **Destination IP addresses** | `20.66.2.0`        |
   | **Service**                  | HTTPS              |
   | **Action**                   | Allow              |

4. In the virtual machine settings, navigate to **Windows Admin Center** (found in the **Settings** group).