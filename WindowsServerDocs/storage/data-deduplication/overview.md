---
title:Data Deduplication Overview  
description:Data Deduplication, often called Dedup for short, is a feature of Windows Server 2016 which can help reduce the impact of redundant data on storage costs.  
author:wmgries  
ms.author:wgries  
manager:eldenc  
ms.date:08/19/2016   
ms.topic:get-started-article  
ms.prod:windows-server-threshold  
ms.service:na  
ms.technology:
- techgroup-storage
- dedup
---

# Data Deduplication Overview
>Applies to Windows Server 2016

## <a name="what-is-dedup"></a>What is Data Deduplication?
Data Deduplication, often called "**Dedup**" for short, is a feature of Windows Server 2016 which can help reduce the impact of redundant data on storage costs. When enabled, Dedup optimizes free space on a volume by examining the data on the volume for duplication. Once identified, duplicated portions of the volume's dataset are stored once and are (optionally) compressed for additional savings. Data Deduplication optimizes redundancies without compromising data fidelity or integrity. More information on how Dedup works can be found [here](understand.md).

## <a name="why-is-dedup-useful"></a>Why is Data Deduplication useful?  
Data Deduplication is an important tool in a storage administrator's toolkit for reducing costs associated with duplicated data. Large datasets often have **<u>a lot</u>** of duplication which increases the costs of storing the data. For example:

- User file shares may have many copies of the same, or very similar files
- Virtualization guests may be virtually identical from VM-to-VM
- Backup snapshots may have very minor differences from day-to-day.

The space savings that can be gained from Dedup are highly dependent on the dataset or workload on the volume. Datasets with high duplication could see optimization rates of up to 95%, or a 20x reduction in storage utilization. The following table highlights typical deduplication savings for various content types:

<table>
    <thead>
        <tr>
            <th>Scenario</th>
            <th>Content</th>
            <th>Typical Space Savings</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>User documents</td>
            <td>Office documents, photos, music, videos, etc</td>
            <td>30-50%</td>
        </tr>
        <tr>
            <td>Deployment shares</td>
            <td>Software binaries, cab files, symbols files, etc</td>
            <td>70-80%</td>
        </tr>
        <tr>
            <td>Virtualization libraries</td>
            <td>ISOs, Virtual hard disk files, etc</td>
            <td>80-95%</td>
        </tr>
        <tr>
            <td>General file share</td>
            <td>All of the above</td>
            <td>50-60%</td>
        </tr>
    </tbody>
</table>

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
                    <li><a href="https://technet.microsoft.com/en-us/library/dn265974(v=ws.11).aspx">Work Folders</a></li>
                    <li>Software development shares</li>
                </ul>
                General purpose file servers are a good candidate for Dedup because of the tendency for multiple users to have many copies or versions of the same file. Software development shares in particular benefit from Dedup because many binaries remain essentially unchanged from build to build. 
            </td>
        </tr>
        <tr>
            <td style="text-align:center;min-width:150px;vertical-align:center;"><img src="media/overview-vdi.png" /></td>
            <td style="vertical-align:top">
                <b>Virtualized Desktop Infrastructure (VDI) deployments</b><br />
                VDI servers, such as <a href="https://technet.microsoft.com/en-us/library/cc725560(v=ws.11).aspx">Remote Desktop Services</a>, provide a lightweight option for organizations to provision desktops to users. There are many reasons for an organization to rely on such technology:
                <ul>
                    <li><b>Application deployment</b>: You can quickly deploy applications across your enterprise. This is especially useful when you have applications that are frequently updated, infrequently used, or difficult to manage.</li>
                    <li><b>Application consolidation</b>: Applications are installed and run from a set of centrally managed virtual machines, eliminating the need for updating applications on client computers. This also reduces the amount of network bandwidth that is required to access applications.</li>
                    <li><b>Remote access</b>: Users can access enterprise applications from devices such as home computers, kiosks, low-powered hardware, and operating systems other than Windows.</li>
                    <li><b>Branch office access</b>: VDI deployments can provide better application performance for branch office workers who need access to centralized data stores. Data-intensive applications sometimes do not have client/server protocols that are optimized for low-speed connections.</li>
                </ul>
                VDI deployments are a great candidates for Dedup because the virtual hard disks that drive the remote desktops for users are essentially identical. Additionally, Dedup can help with the so-called "VDI boot storm" - the drop in storage performance when all of your users log on to their desktop for the start of day at the same time.
            </td>
        </tr>
        <tr>
            <td style="text-align:center;min-width:150px;vertical-align:center;"><img src="media/overview-backup.png" /></td>
            <td style="vertical-align:top">
                <b>Backup Targets, such as Virtualized Backup Applications</b><br />
                Backup Applications, such as <a href="https://technet.microsoft.com/en-us/library/hh758173.aspx">Microsoft Data Protection Manager (DPM)</a>, are excellent candidates for Dedup because of the significant duplication between backup snapshots.
            </td>
        </tr>
        <tr>
            <td style="text-align:center;min-width:150px;vertical-align:center;"><img src="media/overview-other.png" /></td>
            <td style="vertical-align:top">
                <b>Other Workloads</b><br />
                Other workloads may also be excellent candidates for Dedup. More information on how to evaluate a workload for Dedup can be found [here](install-enable.md#enable-dedup-candidate-workloads).
            </td>
        </tr>
    </tbody>
</table>