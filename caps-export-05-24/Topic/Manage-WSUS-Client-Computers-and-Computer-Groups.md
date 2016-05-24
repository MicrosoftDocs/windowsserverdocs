---
title: Manage WSUS Client Computers and Computer Groups
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5549522b-8fb2-4376-8982-66ae9bbcc72e
author: britw
---
# Manage WSUS Client Computers and Computer Groups
[!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 enables you to manage the entire process of updating your computers, including manually and automatically determining which updates they need and receive, specifying when the updates are installed, and monitoring the status of update deployments on your computers.  
  
WSUS also allows you to target updates to groups of client computers. This capability can help you ensure that specific computers get the right updates at the most convenient times on an ongoing basis. For example, if all the computers in one department of your organization \(such as all computers in the Accounting team\) have a specific configuration, you can determine what updates those computers get, at what time, and then use the WSUS reporting features to evaluate the success of the update activity for that computer group.  
  
## Create and manage WSUS computer groups  
Setting up computer groups is a three\-step process:  
  
#### Step 1: Specify how to assign computers to computer groups  
Use the WSUS console to specify whether you will use client\-side or server\-side targeting. With server\-side targeting, you manually add each computer to its group. With client\-side targeting, you automatically assign the computers by using Group Policy or registry keys.  
  
###### To specify the method for assigning computers to groups  
  
1.  In the WSUS Administration console, click **Options**, and then click **Computers**. In the **Computers** dialog box, select one of the following options:  
  
    -   **Use the Update Services console**. Select this option if you want to create groups and assign computers through the WSUS console.  
  
    -   **Use Group Policy or registry settings on client computers**. Select this option if you want to create groups and assign computers by using Group Policy or by editing registry settings on the client computers.  
  
2.  Click **OK** to save your settings.  
  
#### Step 2: Create computer groups  
The computer groups must be created on an autonomous WSUS server, whether you use client\-side or server\-side targeting. Computer groups cannot be created on a replica server or on a remote administration console.  
  
###### To create a computer group  
  
1.  In the WSUS Administration console, click **Computers**, and then click **All Computers**.  
  
2.  In the **Actions** pane, click **Add Computer Group**.  
  
3.  In the **Name** box, type a name for your new computer group, and then click **OK**.  
  
#### Step 3: Move the computers  
Use WSUS to move computers into groups or to automate this task.  
  
###### To move a computer to a different group by using server\-side targeting  
  
1.  In the WSUS Administration console, click **Computers**, and then click the computer group of the computer you want to move.  
  
2.  In the list of computers, right\-click the computer you want to move, and then click **Change Membership**.  
  
3.  In the **Set Computer Group Membership** dialog box, click the computer group or groups to which you want to move the computer, and then click **OK**.  
  
###### To move a computer to a different group by using client\-side targeting  
  
-   Use Group Policy or the registry to enable client\-side targeting. For more information about how to configure the client computer, see the [Update and Configure the Automatic Updates Client](assetId:///d3d56210-9f71-49b7-b0d1-a04fb52d4e53) section of the WSUS 3.0 SP2 Deployment Guide.  
  
## Manage WSUS client computers  
The central access point in the WSUS Administrative Console for managing computers is the **Computers** node. Under this node you can find the computer groups that you have set up \(plus the default group, Unassigned Computers\). Selecting one of the computer groups causes the computers in that group to be displayed in the **Details** pane. If a computer is assigned to multiple groups, it will appear in the listing for each group.  
  
If you select a computer in the list, you can see its properties, which include general details about the computer and the status of the updates for it, such as the installation or detection status of an update for a particular computer. The default status shows only computers that need updates or that have had installation failures, but you can filter the display by any status. Click **Refresh** after changing the status filter.  
  
You can also manage computer groups on the **Computers** page, which is also where you can create the groups and assign computers to them.  
  
> [!IMPORTANT]  
> You must configure client computers to contact the WSUS server before you can manage them from that server. Until you perform this task, your WSUS server will not recognize your client computers, and they will not be displayed in the list on the **Computers** page.  
>   
> For more information about how to configure the client computer, see the [Update and Configure the Automatic Updates Client](assetId:///d3d56210-9f71-49b7-b0d1-a04fb52d4e53) section of the WSUS 3.0 SP2 Deployment Guide.  
  
