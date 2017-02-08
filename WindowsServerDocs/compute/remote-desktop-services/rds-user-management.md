---
title: Manage users in your RDS collection
description: Learn how to manage users in Remote Desktop Services.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2727e1ab-69b8-46f3-9f6d-2540324fe596
author: lizap
ms.author: elizapo
ms.date: 02/07/2017
manager: dongill
---
# Manage users in your RDS collection

>Applies To: Windows Server 2016

You can limit who can use specific desktops and remote resources to certain users or groups. There are two steps to managing user access in a Remote Desktop Services (RDS) deployment:

1.	[Create users and groups in Active Directory](#create-your-users-and-groups-in-active-directory)
2.	[Assign users and groups to collections](#assign-users-and-groups-to-collections)


## Create your users and groups in Active Directory

In Remote Desktop Services, you use Active Directory to create and manage users and groups. If you have not already installed the AD DS tools, follow the steps below to get started. Then, use the instructions to create your users and groups in Active Directory.

The following steps detail how to install the AD DS tools to a server already running Active Directory Domain Services (AD DS), if they are not already installed. These tools allow simple management of AD objects, including users and groups. Once installed, you can then [create users](#create-a-user-and-add-to-a-group) or [create groups](#create-a-group).

### Install AD DS tools

1. Connect to the server running Active Directory Domain Services. For Azure deployments:
   1. In the Azure portal, click **Browse > Resource groups**, and then click the resource group for the deployment
   2. Select the AD virtual machine.
   3. Click **Connect > Open** to open the Remote Desktop client.
   4. In the client, click **Connect**, and then click **Use another account**. Enter the user name and password for a domain administrator account.
   5. Click **Yes** when asked about the certificate.
2. Install the AD DS tools:
   1. In Server Manager click **Manage > Add Roles and Features**.
   2. Click **Role-based or feature-based installation**, and then click the current AD server. Follow the steps until you get to the **Features** tab.
   3. Expand **Remote Server Administration Tools > Role Administration Tools > AD DS and AD LDS Tools**, and then select **AD DS Tools**.
   4. Select **Restart the destination server automatically if required**, and then click **Install**.

### Create a group

You can use AD DS groups to grant access to a set of users that need to use the same remote resources.

1. In Server Manager on the server running AD DS, click **Tools > Active Directory Users and Computers**.
2. Expand the domain in the left-hand pane to view its subfolders.
3. Right-click the folder where you want to create the group, and then click **New > Group**.
4. Enter an appropriate group name, then select **Global** and **Security**.

### Create a user and add to a group
1. In Server Manager on the server running AD DS, click **Tools > Active Directory Users and Computers**.
2. Expand the domain in the left-hand pane to view its subfolders.
3. Right-click **Users**, and then click **New > User**.
4. Enter, at minimum, a first name and a user logon name.
5. Enter and a password for the user. Set appropriate user options, like **User must change password at next logon**.
6. Add the new user to a group:
   1. In the **Users** folder right-click the new user.
   2. Click **Add to a group**.
   3. Enter the name of the group to which you want to add the user.

## Assign users and groups to collections
Now that you've create the users and groups in Active Directory, you can add some granularity regarding who has access to the Remote Desktop collections in your deployment.

1. Connect to the server running the Remote Desktop Connection Broker (RD Connection Broker) role, following the steps described earlier.
2. Add the other Remote Desktop servers to the RD Connection Broker’s pool of managed servers:
   1. In Server Manager click **Manage > Add Servers**.
   2. Click **Find Now**.
   3. Click each server in your deployment that is running a Remote Desktop Services role (like the licensing server and RD Gateway), and then click **OK**.
3. Edit a collection to assign access to specific users or groups:
   1. In Server Manager click **Remote Desktop Services > Overview**, and then click a specific collection.
   2. Under **Properties**, click **Tasks > Edit properties**.
   3. Click **User groups**.
   4. Click **Add** and enter the user or group to give access to the collection. You can remove users and groups from this window as well. 
   >[!NOTE] 
   > The User groups can never be empty. To narrow the scope of users who have access to the collection, you must first add specific users or groups before removing broader groups.