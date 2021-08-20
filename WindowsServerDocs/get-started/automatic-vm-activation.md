---
title: Automatic Virtual Machine Activation in Windows Server
description: Automatic Virtual Machine Activation (AVMA) acts as a proof-of-purchase mechanism, helping to ensure that Windows products are used in accordance with the Product Use Rights and Microsoft Software License Terms.
ms.topic: conceptual
author: dknappettmsft
ms.author: daknappe
manager: femila
ms.date: 8/20/2021
ms.prod: windows-server
---

# Automatic Virtual Machine Activation in Windows Server

Automatic Virtual Machine Activation (AVMA) acts as a proof-of-purchase mechanism, helping to ensure that Windows products are used in accordance with the Product Use Rights and Microsoft Software License Terms.

AVMA lets you activate Windows Server virtual machines (VMs) on Windows Server Hyper-V host that is properly activated, even in disconnected environments. AVMA binds the virtual machine activation to the licensed virtualization host and activates the virtual machine when it starts up. You can get real-time reporting on usage and historical data on the license state of the virtual machine when using AVMA. Reporting and tracking data is available on the virtualization host.

## Practical applications

On virtualization hosts, AVMA offers several benefits.

Server data center managers can use AVMA to do the following:

* Activate virtual machines in remote locations
* Activate virtual machines with or without an internet connection
* Track virtual machine usage and licenses from the virtualization host, without requiring any access rights on the virtualized systems

Service Provider License Agreement (SPLA) partners and other hosting providers do not have to share product keys with tenants or access a tenant's virtual machine to activate it. Virtual machine activation is transparent to the tenant when AVMA is used. Hosting providers can use the server logs to verify license compliance and to track client usage history.

## System requirements

The virtualization host that will run virtual machines needs to be activated. Keys can be obtained through the [Volume Licensing Service Center](https://www.microsoft.com/Licensing/servicecenter/default.aspx) or your OEM provider.

> [!NOTE]
> In a failover cluster, each virtualization host in the cluster must be activated for VMs to stay activated regardless of which server they run on.

AVMA requires Windows Server Datacenter edition with the Hyper-V host role installed. The operating system version of the Hyper-V host determines which versions of operating system can be activated in a virtual machine. Here are the guests that the different version hosts can activate:

| Server host version | Windows Server 2022 guest VM | Windows Server 2019 guest VM | Windows Server 2016 guest VM | Windows Server 2012 R2 guest VM |
|--|--|--|--|--|
| Windows Server 2022 | X | X | X | X |
| Windows Server 2019 | | X | X | X |
| Windows Server 2016 | | | X | X |
| Windows Server 2012 R2 | | | | X |

> [!NOTE]
> The table above applies all editions (Datacenter, Standard, or Essentials).
>
> AVMA does not work with other server virtualization technologies.

## How to implement AVMA

To activate VMs with AVMA, you use a generic AVMA key (detailed in the [AVMA keys](#avma-keys) section below) that corresponds to the version of Windows Server that you want to activate. To create a VM and activate it with an AVMA key, do the following:

1. On the server that will host virtual machines, install and configure the Microsoft Hyper-V Server role. For more information, see [Install Hyper-V Server](../virtualization/hyper-v/get-started/install-the-hyper-v-role-on-windows-server.md). Ensure that the server is successfully activated.

1. [Create a virtual machine](../virtualization/hyper-v/get-started/create-a-virtual-machine-in-hyper-v.md) and install a supported Windows Server operating system on it.

   > [!IMPORTANT]
   > The [Data Exchange integration service](../virtualization/hyper-v/manage/Manage-Hyper-V-integration-services.md) (also known as Key-Value Pair Exchange) must be enabled in the VM settings for AVMA to work. It is enabled by default for new VMs.

1. Once Windows Server is installed on the VM, you install the AVMA key in the VM. From PowerShell or an elevated Command Prompt, run the following command:

    ```
    slmgr /ipk <AVMA_key>
    ```

The virtual machine will automatically activate, providing the virtualization host itself is activated.

> [!TIP]
> You can also add the AVMA keys in any [Unattend setup file](/windows-hardware/manufacture/desktop/update-windows-settings-and-scripts-create-your-own-answer-file-sxs).

## AVMA keys

The following AVMA keys can be used for Windows Server 2022:

| Edition | AVMA key |
|--|--|
| Datacenter | W3GNR-8DDXR-2TFRP-H8P33-DV9BG |
| Standard | YDFWN-MJ9JR-3DYRK-FXXRW-78VHK |

The following AVMA keys can be used for Windows Server 2019:

| Edition | AVMA key |
|--|--|
| Datacenter | H3RNG-8C32Q-Q8FRX-6TDXV-WMBMW |
| Standard | TNK62-RXVTB-4P47B-2D623-4GF74 |
| Essentials | 2CTP7-NHT64-BP62M-FV6GG-HFV28 |

The following AVMA keys can be used for Windows Server, versions 1909, 1903, and 1809:

| Edition | AVMA key |
|--|--|
| Datacenter | H3RNG-8C32Q-Q8FRX-6TDXV-WMBMW |
| Standard | TNK62-RXVTB-4P47B-2D623-4GF74 |

The following AVMA keys can be used for Windows Server, version 1803 and 1709:

| Edition | AVMA key |
|--|--|
| Datacenter | TMJ3Y-NTRTM-FJYXT-T22BY-CWG3J |
| Standard | C3RCX-M6NRP-6CXC9-TW2F2-4RHYD |

The following AVMA keys can be used for Windows Server 2016:

| Edition | AVMA key |
|--|--|
| Datacenter | TMJ3Y-NTRTM-FJYXT-T22BY-CWG3J |
| Standard | C3RCX-M6NRP-6CXC9-TW2F2-4RHYD |
| Essentials | B4YNW-62DX9-W8V6M-82649-MHBKQ |

The following AVMA keys can be used for Windows Server 2012 R2:

| Edition | AVMA key |
|--|--|
| Datacenter | Y4TGP-NPTV9-HTC2H-7MGQ3-DV4TW |
| Standard | DBGBW-NPF86-BJVTX-K3WKJ-MTB6V |
| Essentials | K2XGM-NMBT3-2R6Q8-WF2FK-P36R2 |

## Reporting and tracking

The Key-Value Pair (KVP) exchange between the virtualization host and the VM provides real-time tracking data for the guest operating systems, including activation information. This activation information is stored in the Windows registry of the virtual machine. Historical data about AVMA requests is logged in Event Viewer on the virtualization host.

See [Data Exchange: Using key-value pairs to share information between the host and guest on Hyper-V](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn798287(v=ws.11)) for more information about KVP.

> [!NOTE]
> KVP data is not secured. It can be modified and is not monitored for changes.

> [!IMPORTANT]
> KVP data should be removed if the AVMA key is replaced with another product key (retail, OEM, or volume licensing key).

Since the AVMA activation process is transparent, error messages are not displayed. However, AVMA requests are also logged on the virtualization host in Event Viewer in the Application log with Event ID 12310, and on the virtual machine with Event ID 12309.  The following events are captured on the virtual machines:

| Notification | Description |
|--|--|
| AVMA Success | The virtual machine was activated. |
| Invalid Host | The virtualization host is unresponsive. This can happen when the server is not running a supported version of Windows. |
| Invalid Data | This usually results from a failure in communication between the virtualization host and the virtual machine, often caused by corruption, encryption, or data mismatch. |
| Activation Denied | The virtualization host could not activate the guest operating system because the AVMA ID did not match. |
