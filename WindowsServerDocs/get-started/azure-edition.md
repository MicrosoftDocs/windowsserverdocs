---
title: What is Azure Edition for Windows Server? 
description: Overview of Azure Automanage for Windows Server capabilities with Windows Server Azure Edition 
author: robinharwood
ms.topic: conceptual
ms.date: 05/16/2023
ms.author: wscontent 
---

# What is Azure Edition for Windows Server?

Windows Server: Azure Edition (WSAE) is a new edition of Windows Server focused on innovation and efficiency. Featuring an annual release cadence and optimized to run on Azure properties, WSAE brings new functionality to Windows Server users faster than the traditional Long-Term Servicing Channel (LTSC) editions of Windows Server (2016,2019,2022, etc.) the first version of this new variant is Windows Server 2022 Datacenter: Azure Edition, announced at Microsoft Ignite in November 2021.

The annual WSAE releases are delivered using Windows Update, rather than a full OS upgrade. As part of this annual release cadence, the WSAE Insider preview program will spin up each spring with the opportunity to access early builds of the next release - leading to general availability in the fall. Install the preview to get early access to all the new features and functionality prior to general availability. If you are a registered Microsoft Server Insider, you have access to create and use virtual machine images from this preview. For more information and to manage your Insider membership, visit the [Windows Insider home page](https://insider.windows.com/) or [Windows Insiders for Business home page.](https://insider.windows.com/for-business/)

Azure Automanage for Windows Server brings new capabilities specifically to _Windows Server Azure Edition_.  These capabilities include:

- Hotpatch
- SMB over QUIC
- Extended network for Azure

Automanage for Windows Server capabilities can be found in one or more of these _Windows Server Azure Edition_ images:

- Windows Server 2022 Datacenter: Azure Edition (Desktop Experience)
- Windows Server 2022 Datacenter: Azure Edition (Core)

Capabilities vary by image, see [getting started](#getting-started-with-windows-server-azure-edition) for more detail.

## Automanage for Windows Server capabilities

### Hotpatch

Hotpatch is available on the following images:

- Windows Server 2022 Datacenter: Azure Edition (Desktop Experience)
- Windows Server 2022 Datacenter: Azure Edition (Core)

Hotpatch gives you the ability to apply security updates on your VM without rebooting. Additionally, Automanage for Windows Server automates the onboarding, configuration, and orchestration of hot patching. To learn more, see [Hotpatch for new virtual machines](hotpactch.md).

#### Supported platforms

> [!IMPORTANT]
> Hotpatch is currently in PREVIEW for certain platforms in the following table.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

| Operating system | Azure | Azure Stack HCI |
|--|--|--|
| Windows Server 2022 Datacenter: Azure Edition (Core) | Generally available (GA) | Public preview |
| Windows Server 2022 Datacenter: Azure Edition (Desktop Experience) | Public preview | Public preview |

### SMB over QUIC

SMB over QUIC is available on the following images:

- Windows Server 2022 Datacenter: Azure Edition (Desktop experience)
- Windows Server 2022 Datacenter: Azure Edition (Core)

SMB over QUIC offers an "SMB VPN" for telecommuters, mobile device users, and branch offices, providing secure, reliable connectivity to edge file servers over untrusted networks like the Internet. [QUIC](https://datatracker.ietf.org/doc/rfc9000/) is an IETF-standardized protocol used in HTTP/3, designed for maximum data protection with TLS 1.3 and requires encryption that can't be disabled. SMB behaves normally within the QUIC tunnel, meaning the user experience doesn't change. SMB features like multichannel, signing, compression, continuous availability, and directory leasing work normally.

SMB over QUIC is also integrated with [Automanage machine best practices for Windows Server](/azure/automanage/automanage-windows-server) to help make SMB over QUIC management easier. QUIC uses certificates to provide its encryption and organizations often struggle to maintain complex public key infrastructures. Automanage machine best practices ensure that certificates don't expire without warning and that SMB over QUIC stays enabled for maximum continuity of service.

To learn more, see [SMB over QUIC](/windows-server/storage/file-server/smb-over-quic) and [SMB over QUIC management with Automanage machine best practices](/azure/automanage/automanage-smb-over-quic).

### Extended network for Azure

Extended Network for Azure is available on the following images:

- Windows Server 2022 Datacenter: Azure Edition (Desktop experience)
- Windows Server 2022 Datacenter: Azure Edition (Core)

Azure Extended Network enables you to stretch an on-premises subnet into Azure to let on-premises virtual machines keep their original on-premises private IP addresses when migrating to Azure. To learn more, see [Azure Extended Network](/windows-server/manage/windows-admin-center/azure/azure-extended-network).  

## Getting started with Windows Server Azure Edition

It's important to consider up front, which Automanage for Windows Server capabilities you would like to use, then choose a corresponding VM image that supports all of those capabilities. Some of the _Windows Server Azure Edition_ images support only a subset of capabilities.

### Deciding which image to use

| Image                                                               | Capabilities                                        |
| ------------------------------------------------------------------- | --------------------------------------------------- |
| Windows Server 2022  Datacenter: Azure Edition (Desktop experience) | SMB over QUIC, Extended network for Azure           |
| Windows Server 2022 Datacenter: Azure Edition (Core)                | Hotpatch, SMB over QUIC, Extended network for Azure |

### Creating a VM

To start using Automanage for Windows Server capabilities on a new VM, use your preferred method to create an Azure VM, and select the _Windows Server Azure Edition_ image that corresponds to the set of [capabilities](#getting-started-with-windows-server-azure-edition) that you would like to use.  

> [!IMPORTANT]
> Some capabilities have specific configuration steps to perform during VM creation, and some capabilities that are in preview have specific opt-in and portal viewing requirements.  See the individual capability topics to learn more about using that capability with your VM.

## Next steps

- [Comparison of Standard, Datacenter, and Datacenter: Azure Edition editions of Windows Server 2022](editions-comparison-windows-server-2022.md)
- [Hotpatch for new virtual machines](hotpactch.md)
- [SMB over QUIC](../storage/file-server/smb-over-quic.md)
- [Extend your on-premises subnets into Azure using extended network for Azure](../manage/windows-admin-center/azure/azure-extended-network.md)
