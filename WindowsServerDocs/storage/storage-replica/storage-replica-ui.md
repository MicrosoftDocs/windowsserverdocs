---
title: Using Storage Replica with Windows Admin Center
description: How to set up and use Windows Admin Center to manage Storage Replica for server-to-server replication in Windows Server.
keywords: Storage Replica, Project Honolulu, Server Manager, Windows Server, Windows Admin Center
author: arduppal
ms.author: arduppal
ms.date: 3/26/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage-replica
manager: mchad
---
# Using Storage Replica with Windows Admin Center

This topic walks you through using the Windows Admin Center browser-based management tool for server-to-server storage replication.<br>

> [!video https://www.microsoft.com/en-us/videoplayer/embed/3aa09fd4-867b-45e9-953e-064008468c4b?autoplay=false]

Storage Replica is Windows Server technology that enables replication of volumes between servers or clusters for disaster recovery. It also enables you to create stretch failover clusters that span two sites, with all nodes staying in sync. For more information, see [Storage Replica overview](storage-replica-overview.md).

Windows Admin Center is a locally deployed, browser-based, management tool set that enables on-premises administration of Windows Servers with no Azure or cloud dependency. Windows Admin Center gives IT administrators full control over all aspects of their server infrastructure and is particularly useful for management on private networks that are not connected to the Internet. For more information, see [Windows Admin Center](../../manage/windows-admin-center/overview.md).

## Setup requirements

Storage Replica and Windows Admin Center have the following requirements:

| System                        | Operating system                                            | Required for     |
|-------------------------------|-------------------------------------------------------------|------------------|
| Two servers <br>(any mix of on-premises hardware, VMs, and cloud VMs including Azure VMs)| Datacenter edition of Windows Server (Semi-Annual Channel) or Windows Server 2016 | Storage Replica  |
| One PC                     | Windows 10                                                  | Windows Admin Center |

## Install Windows Admin Center and Storage Replica

1. Provision operating system, features, roles, storage, and network on the servers. For more information, see [Server to Server Storage Replication](server-to-server-storage-replication.md).
2. Add the server machines and client to the same domain.
3. [Download](https://www.microsoft.com/en-us/evalcenter/evaluate-windows-server-honolulu) and install Windows Admin Center on the client.
4. [Download](https://www.microsoft.com/en-us/download/details.aspx?id=45520) and install RSAT (Remote Server Administration tools) on the client to allow remote management of Windows Server.

## Configure Windows Admin Center

1. On the PC, open a PowerShell session as administrator by selecting the **Start** button, typing **PowerShell**, right-clicking **Windows PowerShell,** and then selecting **Run as administrator**.
2. Enter the following command to enable the WS-Management protocol on the local computer and set up the default configuration for remote management on the client.

    ```PowerShell
    winrm quickconfig
    ```

3. Type **Y** to enable WinRM services and enable WinRM Firewall Exception.

## Set up Storage Replica in Windows Admin Center

1. Add the source server.
    1. Select the **Add** button.
    2. Select **Add server connection**.
    3. Type the name of the server and then select **Submit**.

   ![The Add Server Connection screen showing entering the name of a Storage Replica server.](media\Storage-Replica-UI\Honolulu_Add_Connection.png)

2. On the **All Connections** page, select the source server.
3. Select **Storage Replica** from Tools panel.
4. Select the **New** button to create a new partnership.
5. Provide the details of the partnership, and then select **Create**. <br>
![The New Partnership screen showing partnership details, such as an 8 GB log size.](media\Storage-Replica-UI\Honolulu_SR_CReate_Partnership.png)

## Known issues

- Removing the partnership from Storage Replica in Windows Admin Center doesn’t remove the replication group name.
- Right now you can’t use Windows Admin Center on a server to manage Storage Replica.
