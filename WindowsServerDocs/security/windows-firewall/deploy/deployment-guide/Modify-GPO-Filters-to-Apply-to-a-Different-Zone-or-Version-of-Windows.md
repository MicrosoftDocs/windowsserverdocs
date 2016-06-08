---
title: Modify GPO Filters to Apply to a Different Zone or Version of Windows
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7b39f290-e7fb-4a75-b4de-5c87b82558d9
---
# Modify GPO Filters to Apply to a Different Zone or Version of Windows
You must reconfigure your copied GPO so that it contains the correct security group and WMI filters for its new role. If you are creating the GPO for the isolated domain, use the [Block members of a group from applying a GPO](#bkmk_TopreventmembersofgroupfromapplyingaGPO) procedure to prevent members of the boundary and encryption zones from incorrectly applying the GPOs for the main isolated domain.

**Administrative credentials**

To complete these procedures, you must be a member of the Domain Administrators group, or otherwise be delegated permissions to modify the GPOs.

In this topic:

-   [Change the security group filter for a GPO](#bkmk_ToallowmembersofagrouptoapplyaGPO)

-   [Block members of a group from applying a GPO](#bkmk_TopreventmembersofgroupfromapplyingaGPO)

-   [Remove a block for members of a group from applying a GPO](#bkmk_ToremoveablockformembersofgroupfromapplyingaGPO)

## <a name="bkmk_ToallowmembersofagrouptoapplyaGPO"></a>Use the following procedure to change a group to the security filter on the GPO that allows group members to apply the GPO. You must remove the reference to the original group, and add the group appropriate for this GPO.

#### To change the security group filter for a GPO

1.  On a computer that has the Group Policy Management feature installed, click the **Start** charm, and then click the **Group Policy Management** tile.

2.  In the navigation pane, find and then click the GPO that you want to modify.

3.  In the details pane, under **Security Filtering**, click the currently assigned security group, and then click **Remove**.

4.  Now you can add the appropriate security group to this GPO. Under **Security Filtering**, click **Add**.

5.  In the **Select User, Computer, or Group** dialog box, type the name of the group whose members are to apply the GPO, and then click **OK**. If you do not know the name, you can click **Advanced** to browse the list of groups available in the domain.

## <a name="bkmk_TopreventmembersofgroupfromapplyingaGPO"></a>Use the following procedure if you need to add a group to the security filter on the GPO that blocks group members from applying the GPO. This can be used on the GPOs for the main isolated domain to prevent members of the boundary and encryption zones from incorrectly applying the GPOs for the main isolated domain.

#### To block members of group from applying a GPO

1.  On a computer that has the Group Policy Management feature installed, click the **Start** charm, and then click the **Group Policy Management** tile.

2.  In the navigation pane, find and then click the GPO that you want to modify.

3.  In the details pane, click the **Delegation** tab.

4.  Click **Advanced**.

5.  Under the **Group or user names** list, click **Add**.

6.  In the **Select User, Computer, or Group** dialog box, type the name of the group whose members are to be prevented from applying the GPO, and then click **OK**. If you do not know the name, you can click **Advanced** to browse the list of groups available in the domain.

7.  Select the group in the **Group or user names** list, and then select the boxes in the **Deny** column for both **Read** and **Apply group policy**.

8.  Click **OK**, and then in the **Windows Security** dialog box, click **Yes**.

9. The group appears in the list with custom permissions.

## <a name="bkmk_ToremoveablockformembersofgroupfromapplyingaGPO"></a>
#### To remove a block for members of group from applying a GPO

1.  On a computer that has the Group Policy Management feature installed, click the **Start** charm, and then click the **Group Policy Management** tile.

2.  In the navigation pane, find and then click the GPO that you want to modify.

3.  In the details pane, click the **Delegation** tab.

4.  In the **Groups and users** list, select the group that should no longer be blocked, and then click **Remove**.

5.  In the message box, click **OK**.

If you arrived at this page by clicking a link in a checklist, use your browser’s **Back** button to return to the checklist.


