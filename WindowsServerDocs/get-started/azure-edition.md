---
title: What is Azure Edition for Windows Server Datacenter? 
description: Overview of Azure Edition for Windows Server, including key features and next steps.
author: robinharwood
ms.topic: overview
ms.date: 05/16/2023
ms.author: wscontent 
---

# What is Azure Edition for Windows Server Datacenter?

Windows Server: Azure Edition (WSAE) is a new edition of Windows Server focused on innovation and efficiency. Featuring an annual release cadence and optimized to run on Azure, WSAE brings new functionality to Windows Server users faster than the traditional Long-Term Servicing Channel (LTSC) editions of Windows Server (2016,2019,2022, etc.).

The annual WSAE releases are delivered using Windows Update, rather than a full OS upgrade. As part of this annual release cadence, the WSAE Insider preview program gives the opportunity to access early builds of the next release - leading to general availability. If you're a registered Microsoft Server Insider, you have access to create and use virtual machine images from this preview. Details regarding each preview is shared in release announcements posted to the [Windows Server Insiders](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders) space on Microsoft Tech Community.

## Key differences

The following table summarizes the key differences:

| Description | Windows Server Standard, Datacenter | Windows Server Datacenter: Azure Edition |
|--|--|--|
| New releases | Every 2-3 years | TODO: Every year |
| Support | 5 years of mainstream support, plus 5 years of extended support | TODO: 5 years of mainstream support? |
| Servicing channels | Long-Term Servicing Channel | TODO: Annual? |
| Who can use it? | All customers through all channels | TODO: Software Assurance and cloud customers only? |
| Installation options | Server Core, Server with Desktop Experience, [Nano Server container image](/virtualization/windowscontainers/manage-containers/container-base-images) | Server Core and Server with Desktop Experience |

Capabilities vary by image, see [Getting started with Windows Server Datacenter: Azure Edition](#getting-started-with-windows-server-datacenter-azure-edition) for more detail.

## Key capabilities

### Hotpatch

Beginning with Windows Server 2022 Datacenter: Azure Edition, Hotpatch gives you the ability to apply security updates on your VM without rebooting. When used with Azure, Azure Automanage for Windows Server automates the onboarding, configuration, and orchestration of hot patching. To learn more, see [Hotpatch for new virtual machines](hotpatch.md).

#### Supported platforms

> [!IMPORTANT]
> Hotpatch is currently in PREVIEW for certain platforms in the following table.
> See the [Supplemental Terms of Use for Microsoft Azure Previews](https://azure.microsoft.com/support/legal/preview-supplemental-terms/) for legal terms that apply to Azure features that are in beta, preview, or otherwise not yet released into general availability.

| Operating system | Azure | Azure Stack HCI |
|--|--|--|
| Windows Server 2022 Datacenter: Azure Edition (Core) | Generally available (GA) | Public preview |
| Windows Server 2022 Datacenter: Azure Edition (Desktop Experience) | Public preview | Public preview |

### SMB over QUIC

Beginning with Windows Server 2022 Datacenter: Azure Edition, SMB over QUIC offers an "SMB VPN" for telecommuters, mobile device users, and branch offices. SMB over QUIC provides secure, reliable connectivity to edge file servers over untrusted networks like the Internet. [QUIC](https://datatracker.ietf.org/doc/rfc9000/) is an IETF-standardized protocol used in HTTP/3, designed for maximum data protection with TLS 1.3 and requires encryption that can't be disabled. SMB behaves normally within the QUIC tunnel, meaning the user experience doesn't change. SMB features like multichannel, signing, compression, continuous availability, and directory leasing work normally.

SMB over QUIC is also integrated with [Azure Automanage machine best practices for Windows Server](/azure/automanage/automanage-windows-server) to help make SMB over QUIC management easier. QUIC uses certificates to provide its encryption and organizations often struggle to maintain complex public key infrastructures. Azure Automanage machine best practices ensure that certificates don't expire without warning and that SMB over QUIC stays enabled for maximum continuity of service.

To learn more, see [SMB over QUIC](/windows-server/storage/file-server/smb-over-quic) and [SMB over QUIC management with Automanage machine best practices](/azure/automanage/automanage-smb-over-quic).

### Extended network for Azure

Beginning with Windows Server 2022 Datacenter: Azure Edition, Azure Extended Network enables you to stretch an on-premises subnet into Azure to let on-premises virtual machines keep their original on-premises private IP addresses when migrating to Azure. To learn more, see [Azure Extended Network](/windows-server/manage/windows-admin-center/azure/azure-extended-network).  

## Getting started with Windows Server Datacenter: Azure Edition

To get started using Azure Edition, use your preferred method to create an Azure or Azure Stack HCI VM, and select the _Windows Server Datacenter: Azure Edition_ image that you would like to use.  

> [!IMPORTANT]
> Some capabilities have specific configuration steps to perform during VM creation, and some capabilities that are in preview have specific opt-in and portal viewing requirements.  See the individual capability topics to learn more about using that capability with your VM.

To learn more about creating virtual machine using Azure or Azure Stack HCI, see [Create a Windows virtual machine in the Azure portal](/azure/virtual-machines/windows/quick-create-portal) and [Deploy Windows Server Azure Edition VMs in Azure Stack HCI](/azure-stack/hci/manage/windows-server-azure-edition?tabs=hci).

## Next steps

- [Comparison of Standard, Datacenter, and Datacenter: Azure Edition editions of Windows Server 2022](editions-comparison-windows-server-2022.md)
- [Hotpatch for new virtual machines](hotpatch.md)
- [Enable Hotpatch for Azure Edition virtual machines built from ISO (preview)](enable-hotpatch-azure-edition.md)
- [SMB over QUIC](../storage/file-server/smb-over-quic.md)
- [Extend your on-premises subnets into Azure using extended network for Azure](../manage/windows-admin-center/azure/azure-extended-network.md)
