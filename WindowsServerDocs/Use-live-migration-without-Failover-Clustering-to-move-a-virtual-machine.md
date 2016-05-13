---
title: Use live migration without Failover Clustering to move a virtual machine
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75c32e42-97f7-48df-aac9-1d82d34825e1
---
# Use live migration without Failover Clustering to move a virtual machine
This article shows you how to move a virtual machine by doing a live migration without using Failover Clustering. A live migration moves running virtual machines between servers running Hyper\-V without any perceived downtime. 

To be able to do this, you'll need: 

-   Hyper-V hosts that are set up for live migration. For instructions, see [Configure hosts for live migration](Configure-hosts-for-live-migration.md).

-   A user account has the appropriate permission to perform the various steps:

    -   The account you use to configure constrained delegation must be a member of the Domain Administrators group.

    -   The account you use to configure live migration and to perform the live migrations must be a member of the local Hyper\-V Administrators group or the Administrators group on both the source and destination computers.

-   A computer running [!INCLUDE[win8_client_1](includes/win8_client_1_md.md)] with the Hyper\-V management tools installed. For instructions, see [http:\/\/technet.microsoft.com\/library\/hh857623.aspx](http://technet.microsoft.com/library/hh857623.aspx).

## <a name="BKMK_Prereqs"></a>Prerequisites
Before you perform the steps in this document, make sure that your environment meets the following prerequisites:

-   The Hyper\-V role in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] is installed on the source and destination servers, and at least one running virtual machine exists on the source computer. For instructions, see [Install the Hyper\-V role and configure a virtual machine](assetId:///243b5705-96c9-4ec7-9ec5-c68a22b0d42d).

    > [!WARNING]
    > In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] Hyper\-V live migration has been updated to support migrating Hyper\-V virtual machines in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] to Hyper\-V in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]. Moving a virtual machine to a down\-level server running Hyper\-V is not supported.

-   The source and destination computers either belong to the same Active Directory domain, or belong to domains that trust each other.

-   The user account has the appropriate permission to perform the various steps:

    -   The account you use to configure constrained delegation must be a member of the Domain Administrators group.

    -   The account you use to configure live migration and to perform the live migrations must be a member of the local Hyper\-V Administrators group or the Administrators group on both the source and destination computers.

-   You have a computer running [!INCLUDE[win8_client_1](includes/win8_client_1_md.md)] with the Hyper\-V management tools installed. For instructions, see [http:\/\/technet.microsoft.com\/library\/hh857623.aspx](http://technet.microsoft.com/library/hh857623.aspx).


## <a name="BKMK_Step3"></a>Step 4: Move a running virtual machine
In this step, you move a running virtual machine from one server running Hyper\-V in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] to another server running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)].

#### To move a running virtual machine

1.  Connect to the source server using one of the following methods \(unless you are signed in to the source server\):

    -   From Server Manager, click **All Servers** and then click the name of the source server. \(For more information about managing multiple servers, see [Manage Multiple, Remote Servers with Server Manager](Manage-Multiple,-Remote-Servers-with-Server-Manager.md).\)

    -   From Hyper\-V Manager, in the navigation pane, click the name of the source server.

2.  From the **Virtual Machines** section of Hyper\-V Manager, right\-click the virtual machine and then click **Move**.

3.  On the **Choose Move Type** page of the Move Wizard, choose **Move the virtual machine**.

4.  On the **Specify Destination** page, type the name or browse to the destination computer.

5.  On the **Choose Move Options** page, select whether you want to move various items stored for a virtual machine, such as virtual hard disks, snapshots, and paging file.

6.  On the **Summary** page, review your choices and then click **Finish**.

![](media/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](includes/wps_proc_title_md.md)]**

[!INCLUDE[wps_proc_intro](includes/wps_proc_intro_md.md)]

To use Windows PowerShell to move a running virtual machine, you use the Move\-VM cmdlet. The following example moves a virtual machine named *LMTest* to a destination server named *TestServer02* and moves the virtual machine’s virtual hard disks and other files \(such as any snapshots and Smart Paging files\) to the *D:\\LMTest* directory on the destination server.

```
PS C:\> Move-VM LMTest TestServer02 –IncludeStorage –DestinationStoragePath D:\LMTest
```

For reference information about the Move\-VM cmdlet, see [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=217784](http://go.microsoft.com/fwlink/?LinkID=217784).

## <a name="BKMK_Step4"></a>Step 5: \[Optional\] Move a running virtual machine again \(back to the original host or to another host\)
This step is optional because you might not need to move the virtual machine back again. However, it’s included to mention the fact that, if you haven’t enabled constrained delegation, you must sign in to source server to complete the step. Then, complete this step using the same instructions as given in the preceding section.

> [!IMPORTANT]
> If the original source server was [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and original destination server was [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] you cannot migrate back to the original source server.

## <a name="BKMK_Links"></a>See also

-   [Hyper\-V Overview](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)

-   [What's New in Hyper\-V](assetId:///29bb5441-81b0-4b8b-b5e2-26bab60e2fff)

-   [Virtual Machine Live Migration Overview](Virtual-Machine-Live-Migration-Overview.md)

-   [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)


