---
title: Managing WSUS Client computers and WSUS computer Groups
description: "Windows Server Update Service (WSUS) topic - How to manage client computers and groups"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-wsus
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4b1ea915-0f9f-4f0e-8913-a1dd460d07ab
author: coreyp-at-msft
ms.author: coreyp
manager: lizapo
ms.date: 10/16/2017
---
# Managing WSUS Client computers and WSUS computer Groups

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The computers node is central access point in the WSUS administrative console for managing WSUS client computers and devices. Under this node you can find the different groups you have set up (plus the default group, Unassigned computers).

## Managing Client computers
Selecting one of the computer groups in the **computers** node under **Options** causes the computers in that group to be displayed in the details pane. If a computer is assigned to multiple groups, it will appear in the listings of both groups. If you select a computer in the list, you can see its properties, which include general details about the computer and the status of updates for it, such as the installation or detection status of an update for a particular computer. You can filter the list of computers under a given computer group by status. The default shows only computers for which updates are needed or which have had installation failures; however, you can filter the display by any status. Click **Refresh** after changing the status filter.

You can also manage computer groups on the computers page, which includes creating the groups and assigning computers to them. For more information about managing computer groups, see Managing computer Groups in the next section of this guide, and section [1.5. Plan WSUS computer groups](../plan/plan-your-wsus-deployment.md#15-plan-wsus-computer-groups) in Step 1: Prepare for Your WSUS Deployment of the WSUS deployment guide.

> [!NOTE]
> You must first configure client computers to contact the WSUS server before you can manage them from that server. Until you perform this task, your WSUS server will not recognize your client computers and they will not be displayed in the list on the computers page. For more information about setting up client computers, see [1.5. Plan WSUS computer groups](../plan/plan-your-wsus-deployment.md#15-plan-wsus-computer-groups) of Step 1: Prepare for Your WSUS Deployment, and Step 3: Configure WSUS, in the WSUS deployment guide.

## Controlling when WSUS client computers install updates
There are two methods to control when WSUS client computers install updates:

-   Approval with deadlines: Deadlines strictly enforce when an update is installed

-   WSUS Group Policies: Group Policies control when the Windows Update Agent scans and installs updates

    for more information, see: [Step 5: Configure Group Policy Settings for Automatic Updates](../deploy/4-configure-group-policy-settings-for-automatic-updates.md), in the WSUS Deployment Guide.

## Managing computer Groups
WSUS allows you to target updates to groups of client computers, so you can ensure that specific computers always get the right updates at the most convenient times. For example, if all the computers in one department (such as the Accounting team) have a specific configuration, you can set up a group for that team, decide which updates their computers need and what time they should be installed, and then use WSUS reports to evaluate the updates for the team.

Computers are always assigned to the **All computers** group, and remain assigned to the **Unassigned computers** group until you assign them to another group. Computers can belong to more than one group.

Computer groups can be set up in hierarchies (for example, the Payroll group and the Accounts Payable group below the Accounting group). Updates that are approved for a higher group will automatically be deployed to lower groups, as well as to the higher group itself. Thus, if you approve Update1 for the Accounting group, the update will be deployed to all the computers in the Accounting group, all the computers in the Payroll group, and all the computers in the Accounts Payable group.

Because computers can be assigned to multiple groups, it is possible for a single update to be approved more than once for the same computer. However, the update will be deployed only once, and any conflicts will be resolved by the WSUS server. To continue with the example above, if computerA is assigned to both the Payroll and the Accounts Payable groups, and Update1 is approved for both groups, it will be deployed only once.

You can assign computers to computer groups by using one of two methods, server-side targeting or client-side targeting. With server-side targeting, you manually move one or more client computers to one computer group at a time. With client-side targeting, you use Group Policy or edit the registry settings on client computers to enable those computers to automatically add themselves into the previously created computer groups. This process can be scripted and deployed to many computers at once. You must specify the targeting method you will use on the WSUS server by selecting one of the two options on the **computers** section of the **Options** page.

> [!NOTE]
> If a WSUS server is running in replica mode, computer groups cannot be created on that server. All the computer groups needed for clients of the replica server must be created on the WSUS server that is the root of the WSUS server hierarchy. For more information about replica mode, see [Running WSUS Replica mode](running-wsus-replica-mode.md) and for more information about server-side and client-side targeting, see section [1.5. Plan WSUS computer groups](../plan/plan-your-wsus-deployment.md#15-plan-wsus-computer-groups) of Step 1: Prepare for Your WSUS Deployment in the WSUS deployment guide.


