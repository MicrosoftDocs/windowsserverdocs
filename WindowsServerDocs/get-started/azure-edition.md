---
title: What is Azure Edition for Windows Server? 
description: Overview of Azure Edition for Windows Server, including key features and next steps.
author: robinharwood
ms.topic: overview
ms.date: 05/16/2023
ms.author: wscontent 
---

# What is Azure Edition for Windows Server?

Windows Server Datacenter: Azure Edition is an edition of Windows Server focused on innovation and
virtualization optimized to run on Azure. Azure Edition features a Long-Term Servicing Channel
(LTSC) and yearly product updates, with two major product updates in the first 3 years. Azure
Edition also brings new functionality to Windows Server users faster than the Standard and
Datacenter editions of Windows Server.

The annual Azure Edition updates are delivered using Windows Update, rather than a full OS upgrade.
As part of this annual update cadence, the Azure Edition Insider preview program gives the
opportunity to access early builds - leading to general availability. To get started with Azure
Edition Insider preview, visit the [Azure Edition preview](https://aka.ms/createWSAEpreview) Azure
Marketplace offer. Details regarding each preview is shared in release announcements posted to the
[Windows Server Insiders](https://techcommunity.microsoft.com/t5/windows-server-insiders/bd-p/WindowsServerInsiders)
space on Microsoft Tech Community.

## Key differences

The following table summarizes the key differences:

| Description | Windows Server Standard, Datacenter | Windows Server Datacenter: Azure Edition |
|--|--|--|
| New releases | Typically 2-3 years | Typically 2-3 years |
| Product updates | With new release | Yearly, with two major updates in the first 3 years |
| Support | 5 years of mainstream support, plus 5 years of extended support | 5 years of mainstream support, plus 5 years of extended support |
| Servicing channels | Long-Term Servicing Channel | Long-Term Servicing Channel |
| Who can use it? | All customers through all channels | Software Assurance, [Windows Server subscription](/azure-stack/hci/manage/vm-activate) and cloud customers only |
| Installation options | Server Core, Server with Desktop Experience, [Nano Server container image](/virtualization/windowscontainers/manage-containers/container-base-images) | Server Core and Server with Desktop Experience only. Windows Server containers aren't supported. |
| Operating system environments (OSE) | Physical or virtual | Virtual only |
| Associated virtualization rights | 2 virtual OSEs for Standard, Unlimited virtual OSEs for Datacenter | None |

Capabilities vary by image, see
[Getting started with Windows Server Datacenter: Azure Edition](#get-started-with-windows-server-datacenter-azure-edition)
for more detail.

> [!TIP]
> For more information, see the
> [Microsoft Software Licensing Terms](https://www.microsoft.com/useterms/). The licensing terms may
> vary based on the distribution channel, for example, a Commercial Licensing program, Retail,
> Original Equipment Manufacturer (OEM), and so on.

## Key capabilities

### Hotpatch

Beginning with Windows Server 2022 Datacenter: Azure Edition, Hotpatch gives you the ability to
apply security updates on your VM without rebooting. When used with Azure,
[Azure Guest Patching Service](/azure/virtual-machines/automatic-vm-guest-patching), along with
Automanage for Window Server, automate the onboarding, configuration, and orchestration of
hotpatching. To learn more, see [Hotpatch for new virtual machines](hotpatch.md).

#### Supported platforms

Hotpatch is supported on the following operating systems for VMs running on Azure and Azure Stack
HCI:

- Windows Server 2022 Datacenter: Azure Edition Core
- Windows Server 2022 Datacenter: Azure Edition with Desktop Experience

> [!NOTE]
> Hotpatch isn't supported on Windows Server containers base images.

### SMB over QUIC

Beginning with Windows Server 2022 Datacenter: Azure Edition, SMB over QUIC offers an "SMB VPN" for
telecommuters, mobile device users, and branch offices. SMB over QUIC provides secure, reliable
connectivity to edge file servers over untrusted networks like the Internet.
[QUIC](https://datatracker.ietf.org/doc/rfc9000/) is an IETF-standardized protocol used in HTTP/3,
designed for maximum data protection with TLS 1.3 and requires encryption that can't be disabled.
SMB behaves normally within the QUIC tunnel, meaning the user experience doesn't change. SMB
features like multichannel, signing, compression, continuous availability, and directory leasing
work normally.

SMB over QUIC is also integrated with
[Azure Automanage machine best practices for Windows Server](/azure/automanage/automanage-windows-server)
to help make SMB over QUIC management easier. QUIC uses certificates to provide its encryption and
organizations often struggle to maintain complex public key infrastructures. Azure Automanage
machine best practices ensure that certificates don't expire without warning and that SMB over QUIC
stays enabled for maximum continuity of service.

To learn more, see [SMB over QUIC](/windows-server/storage/file-server/smb-over-quic) and
[SMB over QUIC management with Automanage machine best practices](/azure/automanage/automanage-smb-over-quic).

### Storage Replica compression for data transfer

Beginning with Update 1 for Windows Server 2022 Datacenter: Azure Edition, you can compress Storage
Replica data between source and destination server. The compression results in fewer network packets
to transfer the same amount of data, allowing for more throughput, and less network utilization.
Higher data throughput should also result in lowering synchronization time for when you need it
most, for example in a disaster recovery scenario.

To learn more about Storage Replica features, see
[Storage Replica features](/windows-server/storage/storage-replica/storage-replica-overview#storage-replica-features)

### Extended network for Azure

Beginning with Windows Server 2022 Datacenter: Azure Edition, Azure Extended Network enables you to
stretch an on-premises subnet into Azure to let on-premises virtual machines keep their original
on-premises private IP addresses when migrating to Azure. To learn more, see  
[Azure Extended Network](/windows-server/manage/windows-admin-center/azure/azure-extended-network).

## Get started with Windows Server Datacenter: Azure Edition

To get started using Azure Edition, use your preferred method to create an Azure or Azure Stack HCI
VM, and select the _Windows Server Datacenter: Azure Edition_ image that you would like to use.  

> [!IMPORTANT]
> Some capabilities have specific configuration steps to perform during VM creation, and some
> capabilities that are in preview have specific opt-in and portal viewing requirements. See the
> individual capability topics to learn more about using that capability with your VM.

To learn more about creating virtual machine using Azure or Azure Stack HCI, see
[Create a Windows virtual machine in the Azure portal](/azure/virtual-machines/windows/quick-create-portal)
and
[Deploy Windows Server Azure Edition VMs in Azure Stack HCI](/azure-stack/hci/manage/windows-server-azure-edition?tabs=hci).

## Next steps

- [Comparison of Standard, Datacenter, and Datacenter: Azure Edition editions of Windows Server 2022](editions-comparison-windows-server-2022.md)
- [Hotpatch for new virtual machines](hotpatch.md)
- [Enable Hotpatch for Azure Edition virtual machines built from ISO (preview)](enable-hotpatch-azure-edition.md)
- [SMB over QUIC](../storage/file-server/smb-over-quic.md)
- [Extend your on-premises subnets into Azure using extended network for Azure](../manage/windows-admin-center/azure/azure-extended-network.md)
