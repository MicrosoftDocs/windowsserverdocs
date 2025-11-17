---
title: Step 1 - Install the WSUS Server Role
description: Windows Server Update Service (WSUS) topic - Describes how to install the server role using Server Manager
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 05/03/2025
# freshness notes: Other than specific feedback, this article should be evergreen as of 5/02/2025 until the next version released or the end of support. The content is still relevant and accurate, and the links are still valid. The article is not time-sensitive and does not require any updates or changes at this time.
---
# Step 1: Install the WSUS Server Role

The next step in the deployment of your WSUS server is to install the WSUS server role.

# [Server Manager](#tab/server-manager)

The following procedure describes how to install the WSUS server role by using Server Manager.

1.  Log on to the server on which you plan to install the WSUS server role by using an account that is a member of the Local Administrators group.

2.  In **Server Manager**, click **Manage**, and then click **add Roles and Features**.

3.  On the **Before you begin** page, click **Next**.

4.  In the **select installation type** page, confirm that **Role-based or feature-based installation** option is selected and click **Next**.

5.  On the **select destination server** page, choose where the server is located (from a server pool or from a virtual hard disk). After you select the location, choose the server on which you want to install the WSUS server role, and then click **Next**.

6.  On the **select server roles** page, select **Windows Server Update Services**.  **Add features that are required for Windows Server Update Services** opens. Click **Add Features**, and then click **Next**.

7.  On the **select features** page, retain the default selections, and then click **Next**.

    > [!IMPORTANT]
    > WSUS only requires the default Web Server role configuration. If you are prompted for additional Web Server role configuration while setting up WSUS you can safely accept the default values and continue setting up WSUS.

8.  On the **Windows Server Update Services** page, click **Next**.

9. On the **Select Role Services** page, leave the default selections, and then click **Next**.

    > [!TIP]
    > You must select one Database type. If the database options are all cleared (not selected), post installation tasks will fail.

10. On the **Content location selection** page, type a valid location to store the updates. For example, you can create a folder named WSUS_database at the root of drive K specifically for this purpose, and type **k:\WSUS_database** as the valid location.

11. Click **Next**. The **Web Server Role (IIS)** page opens. Review the information, and then click **Next**. In **select the role services to install for Web Server (IIS)**, retain the defaults, and then click **Next**.

12. On the **Confirm installation selections** page, review the selected options, and then click **Install**. The WSUS installation wizard runs. This might take several minutes to complete.

13. Once WSUS installation is complete, in the summary window on the **Installation progress** page, click **Launch Post-Installation tasks**. The text changes, requesting: **Please wait while your server is configured**. When the task has finished, the text changes to: **Configuration successfully completed**. Click **Close**.

14. In **Server Manager**, verify if a notification appears to inform you that a restart is required. This can vary according to the installed server role. If it requires a restart make sure to restart the server to complete the installation.

# [PowerShell](#tab/powershell)

The following procedure describes how to install the WSUS server role by using Windows PowerShell.

1. Log on to the server on which you plan to install the WSUS server role by using an account that is a member of the Local Administrators group.
2. Open a Windows PowerShell command prompt. To do this, click **Start**, type **Windows PowerShell**, and then press **Enter**.
3. Type the following command, and then press **Enter**:

    ```powershell
    Install-WindowsFeature -Name UpdateServices -IncludeManagementTools -Restart
    ```

    The **-IncludeManagementTools** parameter installs the WSUS management console. The **-Restart** parameter restarts the server if required.

---

## Next step

> [!div class="nextstepaction"]
> [Step 2: Configure WSUS](2-configure-wsus.md)
