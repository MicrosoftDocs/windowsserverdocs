---
title: Step 3 - Approve and Deploy Updates in WSUS
description: Windows Server Update Service (WSUS) topic - Approve and Deploy Updates in WSUS is step three in a four step process for deploying WSUS
ms.topic: how-to
author: xelu86
ms.author: alalve
ms.date: 05/03/2025
# freshness notes: Other than specific feedback, this article should be evergreen as of 5/02/2025 until the next version released or the end of support. The content is still relevant and accurate, and the links are still valid. The article is not time-sensitive and does not require any updates or changes at this time.
---
# Step 3: Approve and Deploy Updates in WSUS

Computers in a computer group automatically contact the WSUS server over the next 24 hours to obtain updates. You can use the WSUS reporting feature to determine whether those updates were deployed to the test computers. When the tests are successfully completed, you can approve the updates for the applicable computer groups in your organization. 

## <a name=BKM_3.1.></a>3.1. Approve and deploy WSUS updates
Use the following procedure to approve and deploy updates.

#### To approve and deploy WSUS updates

1.  On the WSUS Administration Console, click **Updates**. In the right pane, an update status summary is displayed for **All Updates**, **Critical Updates**, **Security Updates**, and **WSUS Updates**.

2.  In the **All Updates** section, click **Updates needed by computers**.

3.  In the list of updates, select the updates that you want to approve for installation in your test computer group. Information about a selected update is available in the bottom pane of the **Updates** panel. To select multiple contiguous updates, hold down the **shift** key while clicking the update names. To select multiple noncontiguous updates, press down the **CTRL** key while clicking the update names.

4.  Right-click the selection, and then click **Approve**.

5.  In the **Approve Updates** dialog box, select your test group, and then click the down arrow.

6.  Click **Approved for Install**, and then click **OK**.

7.  The **Approval Progress** window appears, which shows the progress of the tasks that affect update approval. When the approval process is complete, click **Close**.

## <a name=BKM_3.2.a.></a>3.2. Configure auto-approval rules
Automatic Approvals enables you to specify how to automatically approve installation of updates for selected groups, and how to approve revisions to existing updates.

#### To configure Automatic Approvals

1.  In the WSUS Administration Console, under **Update Services**, expand the WSUS server, and then click **Options**. The **Options** window opens.

2.  In **Options**, click **Automatic Approvals**. The Automatic Approvals dialog opens.

3.  In **Update Rules**, click **New Rule**. The **add Rule** dialog opens.

4.  In **add Rule**, in **Step 1: select Properties**, select any single option, or combination of options from the following:

    -   **When an update is in a specific classification**
        - When selecting the **Upgrades** classification, be aware that Windows feature updates that get published monthly are also classified as **Upgrades**. Automatically approving these updates could cause devices to upgrade their OS. For example, applicable Windows 10 devices could get upgraded to Windows 11. Additionally, feature updates would require additional disk space. For more information, see [UUP considerations when planning your WSUS deployment](../plan/plan-your-wsus-deployment.md#uup-considerations).
    -   **When an update is in a specific product**

    -   **Set a deadline for the approval**

5.  In **Step 2: edit the properties**, click each of the options listed, and then select the appropriate options for each.

6.  In  **Step 3: Specify a name**, type a name for your rule, and then click **OK**.

7.  Click **OK** to close the Automatic Approvals dialog.

## <a name=BKM_3.3.></a>3.3. Review installed updates with WSUS Reports
24 hours after you approve the updates, you can use the WSUS Reports feature to determine whether the updates were deployed to the test group computers. To check the status of an update, you can use the WSUS Reports feature as follows.

#### To review updates

1.  In the navigation pane of the WSUS Administration Console, click **Reports**.

2.  On the **Reports** page, click the **Update Status Summary** report. The **Updates Report** window appears.

3.  If you want to filter the list of updates, select the criteria that you want to use, for example, **Include updates in these classifications**, and then click **Run Report**.

4.  You will see the **Updates Report** pane. You can check the status of individual updates by selecting the update in the left section of the pane. The last section of the report pane shows the status summary of the update.

5.  You can save or print this report by clicking the applicable icon on the toolbar.

6.  After you test the updates, you can approve the updates for installation on the applicable computer groups in your organization.

## Next step

> [!div class="nextstepaction"]
> [Step 4: Configure Group Policy settings for automatic Updates](4-configure-group-policy-settings-for-automatic-updates.md)