---
title: Disable Automatic Reconnection in Remote Desktop Service for Windows Server
description: Learn about the Remote Desktop Services Automatic Reconnection feature, lock screen security, and how to disable Automatic Reconnection.
author: robinharwood
ms.author: wscontent
ms.reviewer: spatnaik
ms.topic: how-to
ms.date: 08/15/2023
---
# Disable Automatic Reconnection

Learn about Automatic Reconnection in Remote Desktop Service (RDS), lock screen security, and how to disable Automatic Reconnection for RDS session hosts and clients using Server Manager, Group Policy, and Remote Desktop Protocol (RDP) properties.

## Automatic Reconnection

Microsoft Remote Desktop offers a wide range of features designed to enhance your remote working experience, such as Automatic Reconnection. Automatic Reconnection allows the client to seamlessly reconnect to their existing sessions, giving a smooth, uninterrupted user experience when temporary network disruptions occur. To learn more about the automatic reconnection behavior, see the [Automatic Reconnection](/openspecs/windows_protocols/ms-rdpbcgr/e729948a-3f4e-4568-9aef-d355e30b5389) open specification. Automation Reconnection is available to Remote Desktop when connecting to a local PC or Remote Desktop Services (RDS).

> [!IMPORTANT]
> Automatic Reconnection is enabled by default, and therefore, requires explicit action from the administrators to disable it.

## Lock Screen Security

When a policy or the user locks the remote session and the network connection is lost or disrupted, RDS retains the session state and connection information. If the automatic reconnection of locked sessions raises concerns for your specific use case, we recommend implementing extra security measures. Because RDS retains the session state and connection information, the client reconnects without needing to reauthenticate. The lock screen of the Remote Desktop session isn't designed to function as a security boundary.  Security measures can include disabling Automatic Reconnection on either the RDS session host or the client. This article describes how to disabled Automatic Reconnection.

## Prerequisites

Before you can configure Automatic Reconnection for Remote Desktop, you need to complete the following
prerequisites:

- A Windows client or Windows Server machine to connect from and to.
- An account that is a member of RDS session host administrators group, or equivalent.
- If your machine is a domain member, you also need a domain account that is a member of the
  [Group Policy Creator Owners](../../identity/ad-ds/manage/understand-security-groups.md#group-policy-creator-owners)
  group, or equivalent.

If you're using RDS, you also need:

- A Windows Server with the RDS installed and configured. To learn more about deploying RDS, see [Deploy your Remote Desktop environment](rds-deploy-infrastructure.md).
- A Remote Desktop Session Collection. To learn more about creating a Remote Desktop Session Collection, see [Create a Remote Desktop Services collection for desktops and apps to run](rds-create-collection.md).

## Methods to disable Automatic Reconnection

To disable Automatic Reconnection, you can configure your server, client, or both.

> [!TIP]
>
> - If you disable Automatic Reconnection from your server, clients will be unable to perform Automatic Reconnection regardless of the client configuration.
>
> - Changes to the Automatic Reconnection setting only apply to new sessions. Existing sessions will continue to use the Automatic Reconnection setting from the time of connection.

### Client RDP Properties

You can configure the following Remote Desktop Protocol (RDP) property to disable Automatic Reconnection using the Remote Desktop Connection app or by editing the `.rdp` file. More information can be found here: [Supported RDP properties with Remote Desktop Services](clients/rdp-files.md#supported-rdp-properties-with-remote-desktop-services). To disabled Automatic Reconnection, select the relevant method and follow the steps.

#### [RDP file](#tab/rdpfile)

Here's how to disable Automatic Reconnection by editing the `.rdp` file.

1. Locate your `.rdp` file, right-click the file, expand the **Open with** menu, then select **Choose another app**.

1. Select **Notepad**, then select **Just once**

1. Scroll to the last line of the file, then enter the following text.

   ```RDP
   autoreconnection enabled:i:0
   ```

#### [Remote Desktop Connection app](#tab/mstsc)

Here's how to disable Automatic Reconnection using the Remote Desktop Connection app (`mstsc.exe`).

1. Open the **Remote Desktop Connection** app and enter your connection information.

1. Go to **Show Options**, then select the **Experience** tab.

1. Clear the **Reconnect if the connection is dropped** checkbox.

---

### Remote Desktop Services server configuration

To disable Automatic Reconnection for your RDS session host, select the relevant method and follow the steps.

> [!TIP]
> If you have an RDS deployment and want to configure Automatic Reconnection using the Session Collection properties, Group Policy must be in the **Not Configured** state for each session host. The Group Policy setting applied to each session host takes priority over the Automatic Reconnection setting for the Remote Desktop Session Collection.

#### [Group Policy](#tab/gpo)

Here's how to disable Automatic Reconnection for RDS session hosts using Group Policy.

1. Open the **Group Policy Management Console**, create or edit a policy applied to your server.

1. In the console tree, select **Computer Configuration > Administrative Templates > Windows Components > Remote Desktop Service > Remote Desktop Session Host > Connections**.

1. For the setting, right-click **Automatic reconnection** and select **Edit**.

1. Select **Disable**, from the radio buttons.

1. Select **OK** to complete the configuration.

#### [Server Manager](#tab/servermanager)

Here's how to disable Automatic Reconnect using Server Manager from the Windows desktop.

1. From the Windows desktop, open the **Start** menu, enter the *Server Manager* and select the matching service entry.

1. From Server Manager, in the panel on left, select **Remote Desktop Services**, then select your collection.

1. In the *Properties* section, select **TASKS**, then select **Edit Properties** from the drop-down menu.

1. Select the Session Collection, select **Session**.

1. From the *Configure Session Properties* page, uncheck the **Enable automatic reconnection** box, then select **OK**.

#### [PowerShell](#tab/powershell)

Here's how to disable Automatic reconnection using the
[Set-RDSessionCollectionConfiguration](/powershell/module/remotedesktop/Set-RDSessionCollectionConfiguration) PowerShell
command.

To disable Automatic Reconnection for the Remote Desktop Session Collection named `Desktops`, run the
following command on a computer with the Remote Desktop Services server role installed:

```powershell
Set-RDSessionCollectionConfiguration -CollectionName "Desktops" -AutomaticReconnectionEnabled $false
```

---

## Next steps

- [Remote Desktop clients for Remote Desktop Services and remote PCs](clients/remote-desktop-clients.md).
