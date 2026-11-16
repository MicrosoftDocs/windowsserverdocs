---
title: Windows Admin Center Virtualization Mode Backup
description: 'Windows Admin Center Virtualization Mode backup and restore: Learn how to create, validate, recover, and monitor the encrypted management database.'
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 11/04/2026
ai-usage: ai-generated
appliesto:
   - Windows Admin Center
#customer intent: As a Windows Server administrator, I want to back up and restore a Windows Admin Center Virtualization Mode instance so that I can recover its database.
---

# Back up and restore Windows Admin Center Virtualization Mode

A backup is an encrypted copy of the Windows Admin Center Virtualization Mode management database. Use it to recover the gateway's management database after data loss or a gateway rebuild.

Restoring a backup doesn't roll back managed servers, clusters, virtual machines, storage, or networks. After recovery, Windows Admin Center observes the current infrastructure state as agents reconnect and collectors run.

In this article, you create and validate a backup, restore the management database, confirm database recovery, and monitor agent trust convergence. Database recovery and agent trust convergence are independent outcomes.

## Prerequisites for Windows Admin Center Virtualization Mode backup and restore

- Complete [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md).
- An account with the Windows Admin Center [**Global Administrator**](virtualization-mode-authentication-access-control.md) role. This role is a Windows Admin Center role, not a Microsoft Entra role.
- An encryption password that contains 12 to 256 characters.
- To restore an instance, use a backup file that the target gateway can access and the password that you used to create that backup.
- For a restore to a rebuilt gateway:
   - A target gateway that uses the same intended hostname as the original gateway.
   - A gateway release and database schema that are compatible with the backup. The restore validation checks compatibility.
   - An administrator-managed gateway HTTPS certificate that's valid for the hostname. Provision this certificate separately. The backup doesn't include it.
   - If the backup uses Active Directory Certificate Services (AD CS) for agent trust, configure the required AD CS Client certificate template before restoring. If the target gateway currently uses self-signed agent trust, configure the gateway for AD CS before restoring the AD CS backup.
- For a backup or restore on a UNC share, share and NTFS permissions for the gateway's domain machine account, which commonly appears as `<DOMAIN>\<GatewayComputerName>$`. At both permission layers, grant write access for backup and read access for validation and restore. A rebuilt gateway computer account might require new grants even when you reuse the hostname.

Windows Admin Center doesn't create network shares, configure share or NTFS permissions, or store alternate share credentials. Windows Admin Center doesn't support workgroup or standalone shares that require alternate credentials.

> [!IMPORTANT]
> Treat the backup password as a restore credential. Anyone with both the backup file and its password can decrypt and restore the management database. Store the password separately from the backup and protect it as an administrative secret. If the password is lost, Windows Admin Center can't recover it, and the backup can't be restored.
>
> Backup files and retained recovery artifacts can contain sensitive management data. Store them in access-controlled locations, and remove them when they're no longer needed.

## Create a Windows Admin Center Virtualization Mode backup

Create an encrypted backup and monitor the operation until it finishes. For a UNC backup path, first grant the gateway's domain machine account write access at both the share and NTFS permission layers.

1. Sign in to the Windows Admin Center Virtualization Mode gateway site.

1. From **Overview**, select **Backup & Restore**.

1. Select **Backup**.

1. In the **Create backup** dialog, complete the fields:

   | Create backup field | What to enter |
   |---|---|
   | **Backup path (Optional)** | Enter an absolute local folder or a UNC share. Leave the field blank to use `C:\ProgramData\WindowsAdminCenter\Backup`. |
   | **Encryption password** | Enter a password that contains from 12 through 256 characters. |
   | **Confirm encryption password** | Enter the password again. |

   :::image type="content" source="media/back-up-restore-virtualization-mode/create-backup-dialog.jpg" alt-text="Screenshot of the Windows Admin Center Create backup dialog with Backup path (Optional), Encryption password, and Confirm encryption password fields.":::

1. Select **Start backup**.

1. In **Backup and restore history**, verify that the new backup entry changes from **In progress** to **Succeeded**.

1. Select the notification bell icon to open the **Workflow status** panel. Verify that **Action** is **Backup** and **Status** is **Complete**.

## Restore a Windows Admin Center Virtualization Mode backup

Validate and restore a backup from an existing backup-history record or a custom path. A custom path supports recovery of a rebuilt gateway that doesn't have the original backup-history records. During restoration, the interface shows the restore status while the service restarts. Before you restore a rebuilt gateway, use the same intended hostname as the original gateway, provision its HTTPS certificate, configure AD CS when required, and grant its domain machine account read access at both the share and NTFS permission layers for a UNC backup path.

1. Sign in to the Windows Admin Center Virtualization Mode gateway site.

1. From **Overview**, select **Backup & Restore**.

1. Select **Restore**.

1. In the **Restore from backup** dialog, choose a restore source:

   - Choose **Select from existing backups**, and then select a backup from the list.
   - Select **Enter a custom path**, and then enter the full path to a backup file in an absolute local folder or a UNC share.

1. Verify that **Backup file path** shows the path for the selected backup.

1. Enter the password for the selected backup in **Backup password**, and then select **Validate**.

   Validation checks the password, detects unauthorized modifications to the backup, and verifies that its gateway release and database schema are compatible. Validation fails for an incorrect password, an unauthorized modification, or an incompatible backup.

1. Verify that the message **Backup is compatible and ready to restore** appears and **Start restore** becomes available.

1. Select **Start restore**, and then in the **Restore database?** dialog, select **Confirm restore**.

1. Verify that **Start restore** changes to **Restoring...** and the **Restore in progress** dialog appears.

1. Wait for the service to restart, and then select **OK**.

1. From **Overview**, select **Backup & Restore**.

1. Verify the following results:
   - **Last restore** reports a successful restore and shows a current timestamp that corresponds to the restore you initiated.
   - In **Backup and restore history**, find the row whose **Operation** is **Restore** and verify that **Status** is **Succeeded**. Don't use a previous **Backup** row to confirm the restore.

## Monitor agent trust convergence

Agent trust convergence can continue after the management database restore succeeds, especially when agents are offline. The desired final fleet state is 100%, but database recovery doesn't require the fleet to reach that state.

1. From **Overview**, select **Backup & Restore**.

1. Monitor **Agent convergence** for up to the 24-hour reconciliation window. Interpret the agent reconciliation states as follows:

   - **Trusted and reconciled (green):** The agent is trusted and reconciled.
   - **Pending reconciliation (yellow):** The agent is pending reconnection or automatic healing before the deadline.
   - **Action required (red):** The reconciliation deadline expired. An administrator must take action in the **Resource Health** tool.

1. Review the reported trust mode to understand how Windows Admin Center reconciles agents:

   | Trust mode | Recovery behavior |
   |---|---|
   | **Self-signed CA retained** | The restored gateway retained the Windows Admin Center self-signed certificate authority (CA) recorded in the backup. |
   | **Self-signed CA changed** | The gateway uses a new Windows Admin Center self-signed CA and establishes trust as agents reconnect without recovering the old CA private key. |
   | **Active Directory Certificate Services** | Agent trust remains on the customer-managed public key infrastructure. |

> [!NOTE]
> Windows Admin Center doesn't support direct PostgreSQL access, schema changes, or database modification. Use supported Windows Admin Center APIs instead.

## Related content

- [What is Windows Admin Center Virtualization Mode?](virtualization-mode-overview.md)
- [Install Windows Admin Center Virtualization Mode](install-virtualization-mode.md)
- [Known issues for Windows Admin Center Virtualization Mode](virtualization-mode-known-issues.md)