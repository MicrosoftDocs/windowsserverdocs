---
title: Deploy Always On VPN profile to Windows 10+ clients with Microsoft Configuration Manager
description:  Learn how to deploy Always On VPN profile to Windows clients with Microsoft Endpoint Configuration Manager.
ms.topic: article
ms.date:  03/14/2023
ms.author: anaharris
author: anaharris-ms
---


# Deploy Always On VPN profile to Windows 10+ clients with Microsoft Configuration Manager

In this how-to article, we'll show you how to use Configuration Manager deploy Always On VPN profiles using a ProfileXML PowerShell configuration PowerShell script.

## Prerequisites

- You should have Configuration Manager installed and configured. To learn how to install Configuration Manager, see [Set up a Configuration Manager lab](/mem/configmgr/core/get-started/set-up-your-lab).

- You should have already created a ProfileXML PowerShell configuration script. If you don't know how to create a ProfileXML configuration script, see [Tutorial: Deploy Always On VPN - Configure Always On VPN client connections](tutorial-aovpn-deploy-configure-client.md).

### Create a user collection

To use Configuration Manager to deploy an Always On VPN profile to Windows 10  or newer client computers, you'll need to create a group of machines or users to whom you'll deploy the profile.

1. In the Configuration Manager console, go to the **Assets and Compliance** workspace.

1. On the **Home** ribbon, in the **Create** group, select **Create User Collection**.

1. On the General page, complete the following steps:

    1. In **Name**, type **VPN Users**.

    1. Select **Browse**, select **All Users** and select **OK**.

    1. Select **Next**.

1. On the Membership Rules page, complete the following steps:

    1. In **Membership rules**, select **Add Rule**, and select **Direct Rule**.

    1. On the **Welcome** page, select **Next**.

    1. On the Search for Resources page, in **Value**, type the name of the user you want to add or, if you are adding users to this collection dynamically for a larger-scale deployment, use a query rule to add users. The resource name includes the user's domain. To include results based on a partial match, insert the **%** character at either end of your search criterion. For example, to find all users containing the string "lori," type **%lori%**. Select **Next**.

    1. On the Select Resources page, select the users you want to add to the group, and select **Next**.

    1. On the Summary page, select **Next**.

    1. On the Completion page, select **Close**.

1. Back on the Membership Rules page of the Create User Collection Wizard, select **Next**.

1. On the Summary page, select **Next**.

1. On the Completion page, select **Close**.

After you create the user group to receive the VPN profile, you can create a package and program to deploy your Windows PowerShell ProfileXML configuration script.

### Create a package containing a ProfileXML configuration script

1. Host the ProfileXML configuration script on a network share that the site server computer account can access.

1. In the Configuration Manager console, go to the **Software Library** workspace, expand **Application Management**, and select the **Packages** node.

1. In the **Home** tab of the ribbon, in the **Create** group, select **Create Package**.

1. On the Package page, complete the following steps:

    1. In **Name**, type a name,  such as **Windows client Always On VPN Profile**.

    1. Select the **This package contains source files** check box, and select **Browse**.

    1. In the Set Source Folder dialog box, select **Browse**, select the file share containing the ProfileXML script, and select **OK**.
        Make sure you select a network path, not a local path. In other words, the path should be something like *\\fileserver\\vpnscript*, not *c:\\vpnscript*.

1. Select **Next**.

1. On the Program Type page, select **Next**.

1. On the Standard Program page, complete the following steps:

    1. In **Name**, type **VPN Profile Script**.

    1. In **Command line**, type `PowerShell.exe -ExecutionPolicy Bypass -File        "{your-script-name.ps1}"`.

    1. In **Run mode**, select **Run with administrative rights**.

    1. Select **Next**.

1. On the Requirements page, complete the following steps:

    1. Select **This program can run only on specified platforms**.

    1. Select the **All Windows 10 (32-bit)** and **All Windows 10 (64-bit)** check boxes.

    1. In **Estimated disk space**, type **1**.

    1. In **Maximum allowed run time (minutes)**, type **15**.

    1. Select **Next**.

1. On the Summary page, select **Next**.

1. On the Completion page, select **Close**.

With the package and program created, you are now ready to deploy it to the **VPN Users** group.

### Deploy the ProfileXML configuration package

1. In the Configuration Manager console, open Software Library\\Application Management\\Packages.

1. In **Packages**, select **Windows client Always On VPN Profile**.

1. On the **Programs** tab, at the bottom of the details pane, right-select **VPN Profile Script**, select **Properties**, and complete the following steps:

    a.  On the **Advanced** tab, in **When this program is assigned to a computer**, select **Once for every user who logs on**.

    b.  Select **OK**.

1. Right-click **VPN Profile Script** and select **Deploy** to start the Deploy Software Wizard.

1. On the General page, complete the following steps:

    a.  Beside **Collection**, select **Browse**.

    b.  In the **Collection Types** list (top left), select **User Collections**.

    c.  Select **VPN Users**, and select **OK**.

    d.  Select **Next**.

1. On the Content page, complete the following steps:

    a.  Select **Add**, and select **Distribution Point**.

    b.  In **Available distribution points**, select the distribution points to which you want to distribute the ProfileXML configuration script, and select **OK**.

    c.  Select **Next**.

1. On the Deployment settings page, select **Next**.

1. On the Scheduling page, complete the following steps:

    a.  Select **New** to open the Assignment Schedule dialog box.

    b.  Select **Assign immediately after this event**, and select **OK**.

    c.  Select **Next**.

1. On the User Experience page, complete the following steps:

    1. Select the **Software Installation** check box.

    2. Select **Summary**.

1. On the Summary page, select **Next**.

1. On the Completion page, select **Close**.

With the ProfileXML configuration script deployed, sign in to a Windows client computer with the user account you selected when you built the user collection. Verify the configuration of the VPN client.

### Verify the configuration of the VPN client

1. In Control Panel, under **System > Security**, select **Configuration Manager**.

1. In the Configuration Manager Properties dialog, on the **Actions** tab, complete the following steps:

    a.  Select **Machine Policy Retrieval & Evaluation Cycle**, select **Run Now**, and select **OK**.

    b.  Select **User Policy Retrieval & Evaluation Cycle**, select **Run Now**, and select **OK**.

    c.  Select **OK**.

1. Close the Control Panel.

You should see the new VPN profile shortly.

## Next Steps

- For an in depth tutorial on how to set up Always On VPN, see [Tutorial: Setup infrastructure for Always On VPN](tutorial-aovpn-deploy-setup.md).

- To learn how to configure Always On VPN profiles with Microsoft Intune, see [Deploy Always On VPN profile to Windows clients with Microsoft Intune](how-to-aovpn-client-intune.md)

- For more detailed information on Always on VPN configuration options for the configuration service provider (CSP), see [VPNv2 configuration service provider](/windows/client-management/mdm/vpnv2-csp).
