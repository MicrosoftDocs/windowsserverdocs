---
title: Updates Operations
description: Windows Server Update Service (WSUS) - How to manage updates, including the approval process
ms.topic: article
ms.assetid: 4cb7ff54-3014-4e91-842a-a7b831ea59ff
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/12/2023
---
# Updates Operations

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

After updates have been synchronized to your WSUS server, they'll be scanned automatically for relevance to the server's client computers. However, you must approve the updates before they're deployed to the computers on your network. When you approve an update, you're essentially telling WSUS what to do with it (your choices are **Install** or **Decline** for a new update). You can approve updates for the **All computers** group or for subgroups. If you don't approve an update, its approval status remains **Not approved**, and your WSUS server allows clients to evaluate whether or not they need the update.

If your WSUS server is running in replica mode, you won't be able to approve updates on your WSUS server. For more information about replica mode, see [Running WSUS Replica mode](running-wsus-replica-mode.md).

## Approving Updates
You can approve the installation of updates for all the computers in your WSUS network or for different computer groups. After approving an update, you can do one (or more) of the following:

-   Apply this approval to child groups, if any.

-   Set a deadline for automatic installation. When you select this option, you set specific times and dates to install updates, overriding any settings on the client computers. In addition, you can specify a past date for the deadline if you want to approve an update immediately (to be installed the next time client computers contact the WSUS server).

-   Remove an installed update if that update supports removal.

There are two IMPORTANT considerations that you should keep in mind:

-   First, you can't set a deadline for automatic installation for an update if user input is required (for example, specifying a setting relevant to the update). To determine whether an update will require user input, look at the **May request user input** field in the update properties for an update displayed on the **Updates** page. Also check for a message in the **Approve Updates** box that says, **The selected update requires user input and does not support an installation deadline**.

-   If there are updates to the WSUS server component, you can't approve other updates to client systems until the WSUS update is approved. You'll see this warning message in the Approve Updates dialog: There are WSUS updates that haven't been approved. You should approve the WSUS updates before approving this update. In this case, you should select the WSUS Updates node and make sure that all of the updates in that view have been approved before returning to the general updates.

#### To approve updates

1.  In the WSUS administrative console, select **Updates** and then select **All Updates**.

2.  In the list of updates, select the update that you want to approve and right-click (or go to the Actions pane), and in the Approve Updates dialog, select the computer group for which you want to approve the update, and select the arrow next to it.

3.  Select **Approved for Install**, and then select **Approve**.

4.  The **Approval Progress** window will display the progress toward completing the approval. When the process is complete, the **Close** button appears. Select **Close**.

5.  You can select a deadline by right-clicking the update, selecting the appropriate computer group, selecting the arrow next to it, and then selecting **Deadline**.

    -   You can  select one of the standard deadlines (one week, two weeks, one month), or you can select **Custom** to specify a date and time.

    -   If you want an update to be installed as soon as the client computers contact the server, select **Custom**, and then set a date and time to the current date and time or to one in the past.

#### To approve multiple updates

1.  In the WSUS administrative console, select **Updates** and then select **All Updates**.

2.  To select multiple contiguous updates, press **shift** while selecting updates. To select multiple noncontiguous updates, press and hold down **CTRL** while selecting updates.

3.  Right-click the selection and select **Approve**. The **Approve Updates** dialog opens with the **Approval status** set to **Keep existing approvals** and the **OK** button disabled.

4.  You can change the approvals for the individual groups, but doing so won't affect child approvals. select the group for which you want to change the approval, and select the arrow to its left. In the shortcut menu, select **Approved for Install**.

5.  The approval for the selected group changes to **Install**. If there are any child groups, their approval remains **Keep existing approval**. To change the approval for the child groups, select the group and select the arrow to its left. In the shortcut menu, select **Apply to Children**.

6.  To set a specific child to inherit all its approval from the parent, select the child and select the arrow to its left. In the shortcut menu, select **Same as Parent**. If you set a child to inherit approvals, but aren't changing the parent approvals, the child will inherit the existing approvals of the parent.

7.  If you want the approval behavior to change for all children, approve **All computers**, and then choose **Apply to Children**.

8.  Select **OK** after setting all your approvals. The **Approval Progress** window will display the progress toward completing the approval. When the process is complete, the **Close** button will be available. Select **Close**.

## Declining updates
if you select this option, the update is removed from the default list of available updates and the WSUS server won't offer the update to clients, either for evaluation or installation. You can reach this option by selecting an update or group of updates and right-clicking or going to the Actions pane. Declined updates will appear in the updates list only if you select **Declined** in the Approval list when specifying the filter for the update list under **View**.

#### To decline updates

1.  In the WSUS administrative console, select **Updates**, and then select **All Updates**.

2.  In the list of updates, select one or more updates that you want to decline.

3.  select **Decline**, and then select **Yes** on the confirmation message.

## Cleaning up declined updates
Declined updates continue to consume some WSUS server resources. You should run the Server Cleanup Wizard to remove declined updates from the WSUS database. See: [The Server cleanup Wizard](the-server-cleanup-wizard.md), for additional details.

## Reinstating declined updates
After an update has been declined, you can still reinstate it.

#### To reinstate declined updates

1.  In the WSUS administrative console, select **Updates** and then select **All Updates**.

2.  change **Approval** to **Declined** and select **Refresh**. The list of declined updates loads.

3.  In the list of updates, select one or more declined updates that you want to reinstate.

4.  To reinstate a particular update, right select on the update and select **Approve**. In the **Approve Updates** dialog, select **OK** to re-apply the default Not Approved approval status. The update will show in the list as **Not approved** instead of Declined.

After a declined update has been cleaned up by using the WSUS Server cleanup Wizard, it will be deleted from the WSUS server and will no longer appear in the All Updates view. You can re-import Declined, cleaned-up updates from the Microsoft Update Catalog. For more information, see [WSUS and the Catalog Site](wsus-and-the-catalog-site.md).

## Change an Approved Update to Not Approved
If an update has been approved and you decide not to install it at this time, and instead want to save it for a future time, you can change the update to a status of Not Approved. This means that the update will remain in the default list of available updates and will report client compliance, but won't be installed on clients.

#### To change an update from approved to not approved

1.  In the WSUS administrative console, select **Updates**, and then select **All Updates**.

2.  In the list of updates, select one or more approved updates that you want to change to Not Approved.

3.  In the shortcut menu or the **Actions** pane, select **Not Approved**, and then select **Yes** on the confirmation message.

## Approving Updates for removal

You can approve an update for removal (that is, to uninstall an already-installed update). This option is available only if the update is already installed and supports removal. You can specify a deadline for the update to be uninstalled, or specify a past date for the deadline if you want to remove the update immediately (the next time client computers contact the WSUS server).

It's IMPORTANT to mention that not all updates, such as [UUP updates](../plan/plan-your-wsus-deployment.md#uup-considerations), support removal. You can see whether an update supports removal by selecting an individual update and looking at the **details** pane. Under **additional details**, you'll see the **removable** category. If the update can't be removed through WSUS, in some cases it can be removed with **add or remove Programs** from **Control Panel**.

#### To approve updates for removal

1.  In the WSUS administrative console, select **Updates** and then select **All Updates**.

2.  In the list of updates, select one or more updates that you want to approve for removal and right-click them (or go to the **Actions** pane).

3.  In the **Approve Updates** dialog, select the computer group from which you want to remove the update, and select the arrow next to it.

4.  Select **Approved for removal**, and then select the **remove** button.

5.  After the remove approval has completed, you can select a deadline by right-clicking the update once more, selecting the appropriate computer group, and then clicking the arrow next to it. Then select **Deadline**. You may select one of the standard deadlines (one week, two weeks, one month), or you can select **Custom** to select a specific date and time.

6.  If you want an update to be removed as soon as the client computers contact the server, select **Custom**, and set a date in the past.

## Approving Updates Automatically
You can configure your WSUS server for automatic approval of certain updates. You can also specify automatic approval of revisions to existing updates as they become available. This option is selected by default. A revision is a version of an update that has had changes made to it (for example, it might have expired, or its applicability rules might have changed). If you don't choose to approve the revised version of an update automatically, WSUS will use the older version, and you must manually approve the update revision.

You can create rules that your WSUS server will automatically apply during synchronization. You specify what updates you want to automatically approve for installation, by update classification, by product, and by computer group. This applies only to new updates, as opposed to revised updates. You can also specify an update approval deadline, which sets a number of days and a specific time of offering before the approved update is deadline-installed. These settings are available in the **Options** pane, under **Automatic Approvals**.

#### To automatically approve updates

1.  In the WSUS administration console, select **Options**, and then select **Automatic Approvals**.

2.  In **Update Rules**, select **New Rule**.

3.  In the **add Rule** dialog, under **Step 1: select properties**, select whether to use **When an update is in a specific classification** or **When an update is in a specific product** (or both) as criteria. Optionally, select whether to **Set a deadline** for the approval.
    - When selecting the **Upgrades** classification, be aware that Windows feature updates that get published monthly are also classified as **Upgrades**. Automatically approving these updates could cause devices to upgrade their OS. For example, applicable Windows 10 devices could get upgraded to Windows 11. Additionally, feature updates would require additional disk space. For more information, see [UUP considerations when planning your WSUS deployment](../plan/plan-your-wsus-deployment.md#uup-considerations).

4.  In **Step 2: edit the properties** select the underlined properties to select the Classifications, Products, and computer groups for which you want automatic approvals, as applicable. Optionally, choose the update approval deadline Day and time.

5.  In **Step 3: Specify a name box**, type a unique name for the rule.

6.  Select **OK**.

Automatic approval rules won't apply to updates requiring an End User License Agreement (EULA) that hasn't yet been accepted on the server. If you find that applying an automatic approval rule doesn't cause all the relevant updates to be approved, you should approve these updates manually.

## Automatically Approving Revisions to Updates and Declining Expired Updates
The Automatic Approvals section of the Options pane contains a default option to automatically approve revisions to approved updates. You can also set your WSUS server to automatically decline expired updates. If you choose not to approve the revised version of an update automatically, your WSUS server will use the older revision, and you must manually approve the update revision.

> [!NOTE]
> A revision is a version of an update that has changed (for example, it might have expired or have updated applicability rules).

#### To automatically approve revisions to updates and decline expired updates

1.  In the WSUS administration console, select **Options**, and then select **Automatic Approvals**.

2.  On the **Advanced** tab, make sure that both **Automatically approve new revisions of approved updates** and **Automatically decline updates when a new revision causes them to expire** are selected.

3.  Select OK.

    > [!NOTE]
    > Keeping the default values for these options allows you maintain good performance on your WSUS network. If you do not want expired updates to be declined automatically, you should make sure to decline them manually on a periodic basis.

## Automatically Declining Superseded Updates
When you approve a new update that supersedes an existing update that is automatically approved, the superseded update becomes Not Applicable to a computer or device once the newer update has been installed. You can verify in the WSUS console that an update is Not Applicable for all computers. When that is the case, the update can be safely Declined. additionally, the update may be automatically declined when you run the WSUS Server cleanup Wizard.

To search for superseded updates, you can select the Superseded flag column in the All Updates view, and sort on that column. There will be four groups:

-   Updates that have never been superseded (a blank icon).

-   Updates that have been superseded, but have never superseded another update (an icon with a blue square at the bottom).

-   Updates that have been superseded and have superseded another update (an icon with a blue square in the middle).

-   Updates that have superseded another update (an icon with a blue square at the top).

There's no feature in Windows Server Update Services that automatically declines superseded updates upon approval of a newer update. It's recommended to first set the approval to Not Approved, and then use the Server cleanup Wizard to automatically decline the update when all relevant conditions have been satisfied. For more information, see: [The Server cleanup Wizard](the-server-cleanup-wizard.md).

## Approving Superseding or Superseded Updates

Typically, an update that supersedes other updates does one or more of the following:

-   Enhances, improves, or adds to the fix provided by one or more previously released updates.

-   Improves the efficiency of its update file package, which is installed on client computers if the update is approved for installation. For example, the superseded update might contain files that are no longer relevant to the fix or to the operating systems now supported by the new update, so those files aren't included in the superseding update's file package.

-   Updates newer versions of operating systems. It's also IMPORTANT to note that the superseding update might not support earlier versions of operating systems.

Conversely, an update that is superseded by another update does the following:

-   Fixes a problem similar to that of the update that supersedes it. However, the update that supersedes it might enhance the fix that the superseded update provides.

-   Updates earlier versions of operating systems. In some cases, these versions of operating systems are no longer updated by the superseding update.

In an individual update's detail pane, an informational icon and a message at the top indicates that it either supersedes or is superseded by another update. In addition, you can determine which updates supersede or are superseded by the update by looking at the **Updates superseding this update** and **Updates superseded by this update** entries in the **additional details** section of the **Properties**. An update's detail pane is displayed below the list of updates.

WSUS doesn't automatically decline superseded updates, and it's recommended that you don't assume that superseded updates should be declined in favor of the new, superseding update. Before declining a superseded update, make sure that it's no longer needed by any of your client computers. The following are examples of scenarios in which you might need to install a superseded update:

- If a superseding update supports only newer versions of an operating system, and some of your client computers run earlier versions of the operating system
- If a superseding update has more restricted applicability than the update it supersedes, which would make it inappropriate for some client computers
- If an update no longer supersedes a previously released update because of new changes. It's possible that through changes at each release, an update no longer supersedes an update it previously superseded in an earlier version. In this scenario, you'll still see a message about the superseded update, even though the update that supersedes it has been replaced by an update that doesn't
- Keep quality and feature updates in sync. This means that if a feature update is one month old, then the quality update should be as well. If the feature update is two months old, and the quality update is at one month then language pack and Feature on Demand acquisition won't work
