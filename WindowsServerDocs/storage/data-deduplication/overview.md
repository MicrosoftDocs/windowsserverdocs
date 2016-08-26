---
title: Data Deduplication Overview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
author: wmgries
manager: eldenc
ms.author: wgries
--- 
# Data Deduplication Overview
>Applies to Windows Server 2016

## <a name="what-is-dedup"></a>What is Data Deduplication?
Data Deduplication, often called Dedup for short, is a feature of Windows Server 2016 that can help reduce the impact of redundant data on storage costs. When enabled, Data Deduplication optimizes free space on a volume by examining the data on the volume for duplication. Once identified, duplicated portions of the volume's dataset are stored once and are (optionally) compressed for additional savings. Data Deduplication optimizes redundancies without compromising data fidelity or integrity. Further description of how Data Deduplication works can be found in the '[How does Data Deduplication work?](understand.md#how-does-dedup-work)' section of the [Understanding Data Deduplication](understand.md) page.

## <a name="why-is-dedup-useful"></a>Why is Data Deduplication useful?  
Data Deduplication is an important tool in a storage administrator's toolkit for reducing costs associated with duplicated data. Large datasets often have **<u>a lot</u>** of duplication which increases the costs of storing the data. For example:

- User file shares may have many copies of the same, or very similar files
- Virtualization guests may be virtually identical from VM-to-VM
- Backup snapshots may have very minor differences from day-to-day.

The space savings that can be gained from Data Deduplication are highly dependent on the dataset or workload on the volume. Datasets with high duplication could see optimization rates of up to 95%, or a 20x reduction in storage utilization. The following table highlights typical deduplication savings for various content types:

| Scenario       | Content                                      | Typical Space Savings |
|----------------|----------------------------------------------|-----------------------|
| User Documents | Office documents, photos, music, videos, etc | 30-50%                |
| Deployment shares | Software binaries, cab files, symbols, etc | 70-80%               |
| Virtualization libraries | ISOs, virtual hard disk files, etc | 80-95%                |
| General file share | All of the above                         | 50-60%                |

## <a id="when-can-dedup-be-used"></a>When can Data Deduplication be used?  
<table>
    <tbody>
        <tr>
            <td style="text-align:center;min-width:150px;vertical-align:center;"><img src="media/overview-clustered-gpfs.png" /></td>
            <td style="vertical-align:top">
                <b>General Purpose File Servers</b><br />
                General Purpose File Servers are general use file servers that may contain any of the following types of shares:
                <ul>
                    <li>Team Shares</li>
                    <li>User home folders</li>
                    <li><a href="https://technet.microsoft.com/library/dn265974.aspx">Work Folders</a></li>
                    <li>Software development shares</li>
                </ul>
                General purpose file servers are a good candidate for Data Deduplication because of the tendency for multiple users to have many copies or versions of the same file. Software development shares in particular benefit from Data Deduplication because many binaries remain essentially unchanged from build to build. 
            </td>
        </tr>
        <tr>
            <td style="text-align:center;min-width:150px;vertical-align:center;"><img src="media/overview-vdi.png" /></td>
            <td style="vertical-align:top">
                <b>Virtualized Desktop Infrastructure (VDI) deployments</b><br />
                VDI servers, such as <a href="https://technet.microsoft.com/library/cc725560.aspx">Remote Desktop Services</a>, provide a lightweight option for organizations to provision desktops to users. There are many reasons for an organization to rely on such technology:
                <ul>
                    <li><b>Application deployment</b>: You can quickly deploy applications across your enterprise. This is especially useful when you have applications that are frequently updated, infrequently used, or difficult to manage.</li>
                    <li><b>Application consolidation</b>: Applications are installed and run from a set of centrally managed virtual machines, eliminating the need for updating applications on client computers. This also reduces the amount of network bandwidth that is required to access applications.</li>
                    <li><b>Remote access</b>: Users can access enterprise applications from devices such as home computers, kiosks, low-powered hardware, and operating systems other than Windows.</li>
                    <li><b>Branch office access</b>: VDI deployments can provide better application performance for branch office workers who need access to centralized data stores. Data-intensive applications sometimes do not have client/server protocols that are optimized for low-speed connections.</li>
                </ul>
                VDI deployments are a great candidates for Data Deduplication because the virtual hard disks that drive the remote desktops for users are essentially identical. Additionally, Data Deduplication can help with the so-called "VDI boot storm" - the drop in storage performance when all of your users log on to their desktop for the start of day at the same time.
            </td>
        </tr>
        <tr>
            <td style="text-align:center;min-width:150px;vertical-align:center;"><img src="media/overview-backup.png" /></td>
            <td style="vertical-align:top">
                <b>Backup Targets, such as Virtualized Backup Applications</b><br />
                Backup Applications, such as <a href="https://technet.microsoft.com/library/hh758173.aspx">Microsoft Data Protection Manager (DPM)</a>, are excellent candidates for Data Deduplication because of the significant duplication between backup snapshots.
            </td>
        </tr>
        <tr>
            <td style="text-align:center;min-width:150px;vertical-align:center;"><img src="media/overview-other.png" /></td>
            <td style="vertical-align:top">
                <b>Other Workloads</b><br />
                [Other workloads may also be excellent candidates for Data Deduplication](install-enable.md#enable-dedup-candidate-workloads).
            </td>
        </tr>
    </tbody>
</table>