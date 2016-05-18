---
title: Avoid using legacy network adapters when the guest operating system supports network adapters_deleted
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 49ee3e03-2e1c-4fcf-8528-70758aadcc2d
---
# Avoid using legacy network adapters when the guest operating system supports network adapters_deleted
\[This information is preliminary and subject to change.\]

*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).

|||
|-|-|
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)],<br />              [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)]|
|**Product\/Feature**|Hyper\-V|
|**Severity**|Severity level|
|**Category**|Issue type|

## Issue

> *A guest operating system that supports a network adapter is configured with a legacy network adapter. This configuration is not recommended.*

Hyper\-V provides two types of virtual network adapters—a network adapter and a legacy network adapter. A network adapter requires a virtual machine driver in order to work, but offers better performance.

## Impact

> *Networking performance may be degraded for the following virtual machines: <list of virtual machine names>*

## Resolution

> *Use Hyper\-V Manager to shut down the virtual machine and remove the legacy network adapter. If the virtual machine needs network connectivity, it requires at least one network adapter. If integration services are available, make sure they are installed.*

By default, membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure. However, an administrator can use Authorization Manager to modify the authorization policy so that a user or group of users can complete this procedure. For more information, see [Using Authorization Manager for Hyper-V Security](http://go.microsoft.com/fwlink/?LinkId=142886) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=142886\).

> [!NOTE]
> Integration services are included in [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)]. For all other operating systems, integration services are installed after you install the guest operating system. Integration services include the virtual machine driver required to use the network adapter.

#### To remove a legacy network adapter

1.  Open [!INCLUDE[nextref_virtualname](includes/nextref_virtualname_md.md)] Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.

2.  In the results pane, under **Virtual Machines**, find the virtual machine that you want to configure. The state of the virtual machine should be listed as **Off**. If it is not, right\-click the virtual machine and then click **Shut Down**.

3.  In the **Action** pane, under the virtual machine name, click **Settings**.

4.  In the navigation pane, click the name of the network adapter.

5.  On the **Legacy Network Adapter** page, click **Remove**.

6.  If you do not want to add a network adapter, click **OK**. Otherwise, click **Apply** and continue to the next procedure.

#### To add a network adapter

1.  In the Settings dialog box, in the navigation pane, click **Add Hardware**.

2.  On the **Add Hardware** page, select **Network Adapter**.

3.  Click **Add**. The **Network Adapter** page appears.

4.  Under **Network**, select the virtual network you want to connect to.

5.  If you want to configure a static MAC address or virtual LAN identifier, specify the numbers you want to use.

6.  Click **OK**.


