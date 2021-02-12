---
title: Windows Admin Center in Azure
description: 
ms.topic: article
author: jasongerend
ms.author: jgerend
ms.date: 02/16/2021
---
# Using Windows Admin Center in the Azure portal

You can now use Windows Admin Center (preview) in the Azure portal to manage the Windows Server operating system inside an Azure VM. This provides the ability to manage most operating system functions from the Azure portal without using Remote Desktop or PowerShell to connect to the VM.

This article provides an overview of the functionality provided, how to install Windows Admin Center in your VMs, answers frequently asked questions, and provides a list of known issues and tips for troubleshooting in case something doesn't work quite right.

## Requirements

The Azure VM that you want to manage must have the following:

* Windows Server 2019 or Windows Server 2016
* At least 3 GiB of memory
* Be in any region of an Azure public cloud (it's not supported in Azure China, Azure Government, or other non-public clouds)

The VM also has the following networking requirements, which we step through during the installation procedure:

* Outbound internet access or an outbound port rule allowing HTTPS traffic to the Windows Admin Center service IP address (we don't use service tags yet)

* If using a public IP address to connect to the VM, you need an inbound port rule
<br>Just like with Remote Desktop, if you plan to connect to the VM from a management system that isn't already connected to the VM's virtual network (such as with a VPN), you need to create an inbound port rule to allow access. We recommend using a private IP address for increased security, which eliminates the need for an inbound port rule.

The management system that you use to connect to the Azure portal must have the following:

* The [Microsoft Edge](https://www.microsoft.com/edge) or Google Chrome web browser
* To use a private IP address to connect to your VM, you must be able to access the virtual network that's connected to the VM. For example, by using a [VPN gateway](/azure/vpn-gateway/vpn-gateway-about-vpngateways).

## Implementation details

Windows Admin Center is currently implemented in the Azure portal in the form of an extension that we install on each Azure VM you want to use Windows Admin Center with.

We maintain an external service that manages certificates and DNS records for you.

We create a public DNS record for your VM, but we hash the record name with a salt to anonymize the VM's IP address when saving it in Azure DNS - the IP addresses aren't saved in plain text in DNS. This DNS record is used to issue a certificate for Windows Admin Center on the VM.

## Creating an inbound port rule for connecting from specific public IP addresses

Just like with Remote Desktop, opening an inbound port rule on your VM's public IP address exposes your VM to potential attack from any host on the internet, so we recommend instead accessing the VM using a private IP address.

However, if you need to use a public IP address, you can improve security by limiting the IP addresses that can reach your VM to only the IP addresses used by the systems you use to connect to the Azure portal. Here's how:

1. Open the Azure portal and navigate to your VM > **Networking** > **Inbound port rules**.
2. If you already installed Windows Admin Center and configured it to open an inbound port for your public IP address, select PortForWAC. Otherwise, select **Add inbound port rule**. 
3. Provide the following values, specifying the public IP addresses of your management systems (separated with commas), and optionally changing the destination port from port 6516. Then select **Add**.

   | Field                        | Value              |
   | --------------------------   | ------------------ |
   | **Source**                   | IP address         |
   | **Source IP addresses**      | *Management system IPs* |
   | **Source port ranges**       | *                  |
   | **Destination**              | Any                |
   | **Destination port ranges**  | `6516`             |
   | **Protocol**                 | Any                |
   | **Action**                   | Allow              |

You might need to use a non-Microsoft website or app to find the public IP address of the system you're using to connect to the Azure portal.

## Installing Windows Admin Center in a VM

1. Open the Azure portal and navigate to your VM.
2. If the VM has all outbound internet traffic blocked, create an outbound port rule to connect to the Windows Admin Center service. <br>To do so, in the virtual machine settings, navigate to **Networking** > **Outbound port rules**, select **Add outbound port rule**, enter the following values, and then select **Add**.

   | Field                        | Value              |
   | --------------------------   | ------------------ |
   | **Source**                   | VirtualNetwork     |
   | **Source port ranges**       | *                  |
   | **Destination**              | IP Addresses       |
   | **Destination IP addresses** | `20.66.2.0`        |
   | **Service**                  | HTTPS              |
   | **Action**                   | Allow              |

3. In the virtual machine settings, navigate to **Windows Admin Center** (found in the **Settings** group).
4. To optionally provide access to your VM over the public internet from any IP address, which is convenient for testing but exposes the VM to attack from any host on the internet, you can select **Open this port for me**. However, we recommend instead using a private IP address to connect with, or at least [manually creating an inbound port rule](#creating-an-inbound-port-rule-for-connecting-from-specific-public-ip-addresses) that's locked down to accept traffic from only the IP addresses you specify.
5. Select **Install**.<br>Installing takes a few minutes, with another couple minutes of delay after installation before you can successfully connect if you selected **Open this port for me** or manually created an inbound port rule in the last couple minutes.

## Using Windows Admin Center in a VM

After you've installed Windows Admin Center in an Azure VM, here's how to connect to it and use it to manage Windows Server:

1. Open the Azure portal and navigate to your VM, then Windows Admin Center.
2. If you're connecting using a private IP address, select the IP address you want to use when connecting to the VM, and then select **Connect**.
3. Enter credentials for an account with local Administator permissions on the VM's operating system, and then select **Sign in**.<br>Windows Admin Center opens in the portal, giving you access to the same tools you might be familiar with from using Windows Admin Center in an on-premises deployment.

If you see a "Failed to connect" message and you installed Windows Admin Center or created an inbound port rule for it within the last couple minutes, wait another minute or two and try again--it can take a couple minutes for the rule to propagate.



