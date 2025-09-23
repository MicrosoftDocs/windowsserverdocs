---
title: Use live migration without Failover Clustering to move a VM
description: Gives prerequisites and instructions for doing a virtual machine live migration in a standalone environment.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 02/19/2025
---
# Use live migration without Failover Clustering to move a virtual machine

This article shows you how to move a virtual machine by doing a live migration without using Failover Clustering. A live migration moves running virtual machines between Hyper-V hosts without any noticeable downtime.

To be able to do this, you'll need:

- A user account that's a member of the local Hyper-V Administrators group or the Administrators group on both the source and destination computers.

- The Hyper-V role in Windows Server 2016 and Windows Server 2012 R2 installed on the source and destination servers and set up for live migrations. You can do a live migration between hosts running Windows Server 2016 and Windows Server 2012 R2 if the virtual machine is at least version 5.

    For version upgrade instructions, see [Upgrade virtual machine version in Hyper-V on Windows 10 or Windows Server 2016](../deploy/Upgrade-virtual-machine-version-in-Hyper-V-on-Windows-or-Windows-Server.md). For installation instructions, see [Set up hosts for live migration](../deploy/Set-up-hosts-for-live-migration-without-Failover-Clustering.md).

- The Hyper-V management tools installed on a computer running at least Windows Server 2016 or Windows 10, unless the tools are installed on the source or destination server and you'll run them from there.

## Use Hyper-V Manager to move a running virtual machine

1. Open Hyper-V Manager. (From Server Manager, select **Tools** >>**Hyper-V Manager**.)

1. In the navigation pane, select one of the servers. (If it isn't listed, right-click **Hyper-V Manager**, select **Connect to Server**, type the server name, and select **OK**. Repeat to add more servers.)

1. From the **Virtual Machines** pane, right-click the virtual machine and then select **Move**. This opens the Move Wizard.

1. Use the wizard pages to choose the type of move, destination server, and options.

1. On the **Summary** page, review your choices and then select **Finish**.

## Use Windows PowerShell to move a running virtual machine

The following example uses the Move-VM cmdlet to move a virtual machine named *LMTest* to a destination server named *TestServer02* and moves the virtual hard disks and other file, such checkpoints and Smart Paging files, to the *D:\LMTest* directory on the destination server.

```powershell
PS C:\> Move-VM LMTest TestServer02 -IncludeStorage -DestinationStoragePath D:\LMTest
```

## Troubleshooting

### Failed to establish a connection

If you haven't set up constrained delegation, you must sign in to source server before you can move a virtual machine. If you don't do this, the authentication attempt fails, an error occurs, and this message is displayed:

"Virtual machine migration operation failed at migration Source.
Failed to establish a connection with host *computer name*: No credentials are available in the security package 0x8009030E."

 To fix this problem, sign in to the source server and try the move again. To avoid having to sign in to a source server before doing a live migration, set up constrained delegation. You'll need domain administrator credentials to set up constrained delegation. For instructions, see [Set up hosts for live migration](../deploy/Set-up-hosts-for-live-migration-without-Failover-Clustering.md).

### Failed because the host hardware isn't compatible

 If a virtual machine doesn't have processor compatibility turned on and has one or more snapshots, the move fails if the hosts have different processor versions. An error occurs and this message is displayed:

**The virtual machine cannot be moved to the destination computer. The hardware on the destination computer is not compatible with the hardware requirements of this virtual machine.**

 To fix this problem, shut down the virtual machine and turn on the processor compatibility setting.

1. From Hyper-V Manager, in the **Virtual Machines** pane, right-click the virtual machine and select Settings.
1. In the navigation pane, expand **Processors** and select **Compatibility**.
1. Check **Migrate to a computer with a different processor version**.
1. Select **OK**.

   To use Windows PowerShell, use the [Set-VMProcessor](/powershell/module/hyper-v/set-vmprocessor) cmdlet:

   ```powershell
   PS C:\> Set-VMProcessor TestVM -CompatibilityForMigrationEnabled $true
   ```

