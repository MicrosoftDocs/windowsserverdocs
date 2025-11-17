---
title: Configure failover cluster accounts in Active Directory
description: Learn how to configure cluster accounts in Active Directory for Windows Server failover clusters.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 07/17/2025
---

# Configure cluster accounts in Active Directory

Cluster accounts in Active Directory (AD) are essential for the secure and reliable operation of Windows Server failover clusters. These accounts, which include the cluster name account and accounts for clustered services or applications, enable clusters to interact with domain resources, authenticate actions, and manage permissions. Proper configuration of these accounts ensures that clusters can be created, managed, and maintained in accordance with organizational security policies and best practices.

## Prerequisites

The **Active Directory Domain Services** role must be installed on your device. To learn more, see [Add or remove roles and features in Windows Server](/windows-server/administration/server-manager/add-remove-roles-features).

The account used by the person installing the cluster is important since it's used to create the computer account for the cluster during setup. The following are required based on your scenario:

- **Domain account**: If you're responsible for creating the cluster account in AD and assigning the necessary permissions, you must have domain-level privileges. You must be a member of the **Domain Admins** or **Account Operators** group or have equivalent permissions.

- **Assigning local permissions**: If the cluster account is already created in AD by someone else, and your task is to add this account to the local **Administrators** group on each cluster server, you only need administrative rights on those servers. You must be a member of the local **Administrators** group on each server.

## Configure the cluster account

Create or obtain the domain account for the person who will install the cluster. This account can be a standard domain user account or an **Account Operators** account. If you're using a standard user account, you'll need to grant additional permissions later in this process. If the account you created or obtained isn't automatically part of the local **Administrators** group on domain computers, follow these steps to add it to the local **Administrators** group on each server that becomes part of the failover cluster:

1. In **Server Manager**, select **Tools**, then select **Computer Management**.

1. In the left pane under **System Tools**, expand **Local Users and Groups**, then expand **Groups**.

1. In the center pane, right-click **Administrators**, select **Add to Group**, then select **Add**.

1. Under the **Enter the object names to select** field, type or search for the name of the user account you created or obtained. If prompted, enter the credentials and then select **OK**.

Repeat these steps on each server that become a node in the failover cluster.

> [!IMPORTANT]
> These steps must be repeated on all servers that become nodes in the cluster.

If your account is a domain administrator, you can skip the following steps. Otherwise, you need to grant the account **Create Computer Objects** and **Read All Properties** permissions in the domain's computer accounts container by following these steps on the domain controller (DC):

1. In **Server Manager**, select **Tools**, then select **Active Directory Users and Computers**.

1. Select the **View** tab, then select **Advanced Features**.

1. In the left pane, expand your domain, right-click **Computers**, and then select **Properties**.

1. Select the **Security** tab, then select **Advanced**.

1. Select **Add**, select **Select a principal**, type or search for the name of the account, then select **OK**.

1. Under **Permissions**, select **Create Computer objects**. Under **Properties**, select **Read all properties**. Then select **OK**.

1. Select **OK** to close the **Advanced Security Settings** window, then select **OK** again.

## Prestage the cluster name account

If organizational policies require you to prestage the cluster name account, follow the provided steps. Otherwise, you can allow the Create Cluster Wizard to automatically create and configure the account during cluster setup. Before you begin, ensure you have the cluster name and the user account that will be used to create the cluster. You can use this account to complete the prestaging steps:

1. On the DC, select **Start**, select **Administrative Tools**, and then select **Active Directory Users and Computers**.

1. In the left pane, right-click **Computers**, then select **New** > **Computer**.

1. Enter the name you intend to use for the failover cluster. This is the cluster name that is entered in the Create Cluster Wizard, select **OK**.

1. Right-click the account that you created, then select **Disable Account**. If prompted to confirm your choice, select **Yes**, then select **OK**.

   Disabling the account ensures that the Create Cluster Wizard can verify the account isn't already assigned to another computer or cluster in the domain before proceeding.

1. Select the **View** tab, make sure that **Advanced Features** is selected. If not, select it.

1. Right-click on **Computers**, select **Properties**, select the **Security** tab, then select **Advanced**.

1. Select **Add**, select **Select a principal**, select **Object Types** and ensure **Computers** is selected. Then select **OK**.

1. Under **Enter the object name to select**, type or search for the name of the computer account you created, then select **OK**.

1. A security message displays notifying the addition of a disabled object. Select **OK**.

1. Under **Permissions**, select **Create Computer objects**. Under **Properties**, select **Read all properties**. Select **OK**, then select **OK** again.

If you're using the same account to create the cluster and perform this procedure, you can skip the following steps. Otherwise, ensure that the user account designated for cluster creation has full control permissions on the computer account you created:

1. In **Active Directory Users and Computers**, select the **View** tab. Make sure that **Advanced Features** is selected. If not, select it.

1. In the left pane, select **Computers**. Right-click on the computer account you created and select **Properties**.

1. Select the **Security** tab, select **Add**, select **Object Types** and ensure **Computers** is selected. Then select **OK**.

1. Under **Enter the object name to select**, type or search for the name of the computer account, then select **OK**.

1. Ensure that the user account you just added is selected. Under **Permissions** for the account, select **Full control**, then select **OK**.

## Prestage an account for a clustered service or application (optional)

For most scenarios, it's easier to let the High Availability Wizard automatically create and configure the account during setup. If your organization's policies require prestaging, follow these steps.

Make sure that you know the name of the cluster and the name that the clustered service or application will have.

1. On the DC, in **Server Manager**, select **Tools**, then select **Active Directory Users and Computers**.

1. In the left pane, right-click **Computers**, select **New** > **Computer**.

1. Type the name that you'll use for the clustered service or application, and then select **OK**.

1. Select the **View** tab. Make sure that **Advanced Features** is selected. If not, select it.

1. Right-click the computer account you created, select **Properties**, select the **Security** tab, then select **Add**.

1. Select **Object Types** and ensure **Computers** is selected. Then select **OK**.

1. Under **Enter the object name to select**, type the cluster name account, then select **OK**.

1. Make sure that the cluster name account is selected, select **Full control**, then select **OK**.

## See also

- [Active Directory security groups](/windows-server/identity/ad-ds/manage/understand-security-groups)

- [Troubleshoot issues with accounts used by failover clusters](/troubleshoot/windows-server/high-availability/troubleshoot-issues-accounts-used-failover-clusters)

