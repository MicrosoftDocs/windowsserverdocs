---
title: Step 2 - Install the WSUS Server Role
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fabc8619-350e-403b-96f8-116424931300
---
# Step 2: Install the WSUS Server Role

>Applies To: Windows Server Technical Preview

The next step in the deployment of your WSUS server is to install the WSUS server role. The following procedure describes how to install the WSUS server role by using Server Manager.

> [!IMPORTANT]
> This installation procedure only covers how to install WSUS using Windows Internal Database (WID). The procedures to install WSUS using Microsoft SQL Server are documented in [this article](http://social.technet.microsoft.com/wiki/contents/articles/10020.installing-wsus-server-role-on-windows-server-2012-with-microsoft-sql-database.aspx).

### To install the WSUS server role

1.  Log on to the server on which you plan to install the WSUS server role by using an account that is a member of the Local Administrators group.

2.  In **Server Manager**, click **Manage**, and then click **Add Roles and Features**.

3.  On the **Before you begin** page, click **Next**.

4.  In the **Select installation type** page, confirm that **Role-based or feature-based installation** option is selected and click **Next**.

5.  On the **Select destination server** page, choose where the server is located (from a server pool or from a virtual hard disk). After you select the location, choose the server on which you want to install the WSUS server role, and then click **Next**.

6.  On the **Select server roles** page, select **Windows Server Update Services**.  **Add features that are required for Windows Server Update Services** opens. Click **Add Features**, and then click **Next**.

7.  On the **Select features**page. Retain the default selections, and then click **Next**.

    > [!IMPORTANT]
    > WSUS only requires the default Web Server role configuration. If you are prompted for additional Web Server role configuration while setting up WSUS you can safely accept the default values and continue setting up WSUS.

8.  On the **Windows Server Update Services** page, click **Next**.

9. On the **Select Role Services** page, leave the default selections, and then click **Next**.

    > [!TIP]
    > You must select one Database type. If the database options are all cleared (not selected), post installation tasks will fail.

10. On the **Content location selection** page, type a valid location to store the updates. For example, you can create a folder named WSUS_database at the root of drive K specifically for this purpose, and type **k:\WSUS_database** as the valid location.

11. Click **Next**. The **Web Server Role (IIS)** page opens. Review the information, and then click **Next**. In **Select the role services to install for Web Server (IIS)**, retain the defaults, and then click **Next**.

12. On the **Confirm installation selections** page, review the selected options, and then click **Install**. The WSUS installation wizard runs. This might take several minutes to complete.

13. Once WSUS installation is complete, in the summary window on the **Installation progress** page, click **Launch Post-Installation tasks**. The text changes, requesting: **Please wait while your server is configured**. When the task has finished, the text changes to: **Configuration successfully completed**. Click **Close**.

14. In **Server Manager**, verify if a notification appears to inform you that a restart is required. This can vary according to the installed server role. If it requires a restart make sure to restart the server to complete the installation.

> [!IMPORTANT]
> At this point the installation process is finished, however for WSUS to be functional you need to proceed to [Step 3: Configure WSUS](Step-3--Configure-WSUS.md).

## <a name="BKMK_Links"></a>See also

-   [Step 3: Configure WSUS](Step-3--Configure-WSUS.md)

-   [Step 1: Prepare for Your WSUS Deployment](Step-1--Prepare-for-Your-WSUS-Deployment.md)

-   [Deploy Windows Server Update Services](Deploy-Windows-Server-Update-Services.md)
