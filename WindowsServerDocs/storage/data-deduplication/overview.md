---
description: "Learn more about: Data Deduplication Overview"
ms.assetid: 4b844404-36ba-4154-aa5d-237a3dd644be
title: Data Deduplication Overview
ms.topic: article
author: wmgries
manager: klaasl
ms.author: wgries
ms.date: 02/18/2022
---
# Data Deduplication Overview

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Azure Stack HCI, versions 21H2 and 20H2

## <a name="what-is-dedup"></a>What is Data Deduplication?

Data Deduplication, often called Dedup for short, is a feature that can help reduce the impact of redundant data on storage costs. When enabled, Data Deduplication optimizes free space on a volume by examining the data on the volume by looking for duplicated portions on the volume. Duplicated portions of the volume's dataset are stored once and are (optionally) compressed for additional savings. Data Deduplication optimizes redundancies without compromising data fidelity or integrity. More information about how Data Deduplication works can be found in the '[How does Data Deduplication work?](understand.md#how-does-dedup-work)' section of the [Understanding Data Deduplication](understand.md) page.

> [!Important]
> [KB4025334](https://support.microsoft.com/kb/4025334) contains a roll up of fixes for Data Deduplication, including important reliability fixes, and we strongly recommend installing it when using Data Deduplication with Windows Server 2016 and Windows Server 2019.

## <a name="why-is-dedup-useful"></a>Why is Data Deduplication useful?

Data Deduplication helps storage administrators reduce costs that are associated with duplicated data. Large datasets often have **a lot** of duplication, which increases the costs of storing the data. For example:

- User file shares may have many copies of the same or similar files.
- Virtualization guests might be almost identical from VM-to-VM.
- Backup snapshots might have minor differences from day to day.

The space savings that you can gain from Data Deduplication depend on the dataset or workload on the volume. Datasets that have high duplication could see optimization rates of up to 95%, or a 20x reduction in storage utilization. The following table highlights typical deduplication savings for various content types:

| Scenario       | Content                                        | Typical space savings |
|----------------|------------------------------------------------|-----------------------|
| User documents | Office documents, photos, music, videos, etc.  | 30-50%                |
| Deployment shares | Software binaries, cab files, symbols, etc. | 70-80%                |
| Virtualization libraries | ISOs, virtual hard disk files, etc.  | 80-95%                |
| General file share | All the above                           | 50-60%                |

> [!NOTE]
> If you're just looking to free up space on a volume, consider using Azure File Sync with cloud tiering enabled. This allows you to cache your most frequently accessed files locally and tier your least frequently accessed files to the cloud, saving local storage space while maintaining performance. For details, see [Planning for an Azure File Sync deployment](/azure/storage/files/storage-sync-files-planning).

## <a name ="when-can-dedup-be-use"></a>When can Data Deduplication be used?

| Scenario illustration    | Description |
|---------------- | -----------------------------------------------|
| ![Illustration of file servers.](media/overview-clustered-gpfs.png) | **General purpose file servers**: General purpose file servers are general use file servers that might contain any of the following types of shares: <ul><li>Team shares</li><li>User home folders</li><li>[Work folders](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265974(v=ws.11))</li><li>Software development shares</li></ul>General purpose file servers are a good candidate for Data Deduplication because multiple users tend to have many copies or versions of the same file. Software development shares benefit from Data Deduplication because many binaries remain essentially unchanged from build to build.  |
| ![Illustration of VDI servers.](media/overview-vdi.png)            | **Virtual Desktop Infrastructure (VDI) deployments**: VDI servers, such as [Remote Desktop Services](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc725560(v=ws.11)), provide a lightweight option for organizations to provision desktops to users. There are many reasons for an organization to rely on such technology: <ul><li>**Application deployment**: You can quickly deploy applications across your enterprise. This is especially useful when you have applications that are frequently updated, infrequently used, or difficult to manage.</li><li>**Application consolidation**: When you install and run applications from a set of centrally managed virtual machines, you eliminate the need to update applications on client computers. This option also reduces the amount of network bandwidth that is required to access applications.</li><li>**Remote Access**: Users can access enterprise applications from devices such as home computers, kiosks, low-powered hardware, and operating systems other than Windows.</li><li>**Branch office access**: VDI deployments can provide better application performance for branch office workers who need access to centralized data stores. Data-intensive applications sometimes do not have client/server protocols that are optimized for low-speed connections.</li></ul> VDI deployments are great candidates for Data Deduplication because the virtual hard disks that drive the remote desktops for users are essentially identical. Additionally, Data Deduplication can help with the so-called *VDI boot storm*, which is the drop in storage performance when many users simultaneously sign in to their desktops to start the day.     |
| ![Illustration of backup applications.](media/overview-backup.png) | **Backup targets, such as virtualized backup applications**: Backup applications, such as [Microsoft Data Protection Manager (DPM)](/previous-versions/system-center/system-center-2012-R2/hh758173(v=sc.12)), are excellent candidates for Data Deduplication because of the significant duplication between backup snapshots.   |
| ![Illustration of other workloads.](media/overview-other.png)      | **Other workloads**: [Other workloads may also be excellent candidates for Data Deduplication](install-enable.md#enable-dedup-candidate-workloads).     |

