---
title: Editing Software Settings Using GPMC
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3641488e-c0a6-469c-8d3e-5e47e75d7827
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---


# Editing Software Settings Using GPMC
This topic contains procedures for using the GPMC tool to edit Group Policy Software Settings.

Group Policy Software Installation enables you to provide on-demand software installation and automatic repair of applications. Group Policy offers a convenient method for delivering software, especially if you are already using Group Policy for other purposes such as securing your client and server computers.

## How to open Group Policy Software Installation

#### To open Group Policy Software Installation

1.  Open the **Group Policy Management Console**. Right-click the Group Policy object you want to edit and then click **Edit**.

2.  To assign software applications to computers, in the console tree expand **Computer Configuration\Policies**. To assign or publish software applications to users, in the console tree expand **User Configuration\Policies**.

3.  Expand **Software Settings**, and then click **Software installation**.

## How to set Options for Group Policy Software Installation
To add software installation packages to user settings, you can either publish or assign them. Published packages are available for installation by users in the selected site, domain, or organizational unit by using either Add or Remove Programs in Control Panel or file activation. Users in the selected site, domain, or organizational unit receive assigned packages the next time they log on (for assignment to users) or when the computer restarts (for assignment to computers).

#### To set Group Policy Software Installation defaults

1.  Open Group Policy Software Installation. (In the console tree, right-click **Software installation**.)

2.  Click **Properties**, and on the **General** tab specify the following options:

    -   In **Default package location**, specify the default software distribution point.

    -   In **New packages**, specify how to add new packages to user settings. By default, packages can either be published or assigned. (To computers, they can only be assigned). If you want to select these options for each package, click **Display the Deploy Software** dialog box. For even more control on a per-package basis, click **Advanced**.

    -   In **Installation user interface options**, click **Basic** or **Maximum**, depending on how apparent you want the installation process to be to users.

#### To specify automatic installation options based on file name extension

1.  Open Group Policy Software Installation. (In the console tree, right-click **Software installation**.)

2.  In the console tree, right-click **Software installation**.

3.  Click **Properties**, and then click the **File Extensions** tab.

4.  On the **File Extensions** tab, specify the following options:

    -   **Select file extension:** Displays a list of all available file name extensions for the managed software. When an extension is selected, all applications in Active Directory that are associated with the selected file name extension are displayed in the **Application precedence** list box. For example, many applications can be associated with the .htm file extension, such as Microsoft Word, Microsoft Internet Explorer, and Netscape Communicator.

    -   **Application precedence:** Lists all the applications that are associated with the selected file name extension. You can determine precedence by using the **Up** and **Down** buttons to set the order of the applications.

    -   **Up:** Moves the selected application higher in the precedence list. The application at the top of the list is automatically installed if a document with the selected file name extension is invoked before the application has been installed. The **Up** button is unavailable when the selected application is at the top of the precedence list.

    -   **Down:** Moves the selected application lower in the priority list. The **Down** button is unavailable when the selected application is at the bottom of the precedence list.

    **Additional considerations**

    -   When you upgrade an application, turn off automatic installation for the older version.

#### To specify categories in which to manage applications

1.  Open Group Policy Software Installation.

2.  In the console tree, right-click **Software installation**.

3.  Click **Properties**, and then click the **Categories** tab.

4.  To create or change the list of categories under which programs appear in **Add or Remove Programs** in **Control Panel**, do any of the following:

    -   To create a new category, click **Add**, and then type the new category name. If you do not have permission to add categories, the **Add** button is unavailable.

    -   To modify an existing category, click the category that you want to modify, click **Modify**, and then change the text of the selected category. If you do not have permission to edit categories, the **Modify** button is unavailable.

    -   To remove a category from the **Categories** list, click the category name, and then click **Remove**. If you do not have permission to edit categories, the **Remove** button is unavailable.

    **Additional considerations**

    -   The changes that you make to the application categories apply throughout the domain in which this Group Policy object is stored.

## How to work with applications

#### To assign an application

1.  Open Group Policy Software Installation.

2.  In the console tree, right-click **Software installation**, point to **New**, and then click **Package**.

3.  In the **Open** dialog box, use the search boxes to find the application you want to deploy, click the Windows Installer package, and then click **Open**.

4.  In the **Deploy Software** dialog box, click **Assigned**, and then click **OK**.

    **Additional considerations**

    -   The **Open** dialog box shows the packages that are located at a software distribution point that you specify as the default.

    -   If the Windows Installer package is located on a different shared network directory, navigate to the correct software distribution point in the **Open** dialog box, click the package, and then click **Open**.

    -   Administrators are responsible for securing that location using technologies such as IPSEC and using file servers with mutual authentication such as Kerberos to prevent spoofing or tampering on the wire.

#### To publish an application

1.  Open Group Policy Software Installation.

2.  Right-click in the results pane, point to **New**, and then click **Package**.

3.  In the **Open** dialog box, use the search boxes to find the package you want to publish, click the Windows Installer package to be published, and then click **Open**.

4.  In the **Deploy Software** dialog box, click **Published**.

    **Additional considerations**

    -   Packages can be published only to users, not to computers.

    -   The **Open** dialog box shows the packages that are located at a software distribution point that you specify as the default.

    -   If the Windows Installer package is located on a different shared network directory, navigate to the correct software distribution point in the **Open** dialog box, click the package, and then click **Open**.

    -   Administrators are responsible for securing that location using technologies such as IPSEC and using file servers with mutual authentication such as Kerberos to prevent spoofing or tampering on the wire.

    -   The application is available for users to install either by using **Add or Remove Programs** in **Control Panel** or by opening a file with a file name extension that you have associated with the application.

#### To upgrade an application

1.  Open Group Policy Software Installation.

2.  In the results pane, right-click the new Windows Installer upgrade package (that is, not the package to be upgraded).

3.  Click **Properties**, and then click the **Upgrades** tab.

4.  Click **Add** to create or add to the list of packages that you want to upgrade with the new upgrade package.

5.  In the **Add Upgrade Package** dialog box, under **Choose a package from**, do one of the following:

    -   Click **Current Group Policy object**.

    -   Click **A specific GPO**, click **Browse**, and then click the Group Policy object (GPO) that you want to upgrade.

6.  Review the list of packages under **Package to upgrade**, which lists all of the other packages that are assigned or published within the selected GPO.

7.  Click the package that you want to upgrade, and then do one of the following:

    -   To replace an application with a completely different application (perhaps an application from a different vendor), click **Uninstall the existing package, then install the upgrade package**.

    -   To install a newer version of the same product while retaining the user's application preferences, document type associations, and the like, click **Package can upgrade over the existing package**.

8.  (Optional) To make the upgrade mandatory, on the **Upgrades** tab, select the **Required upgrade for existing packages** check box.

    **Additional considerations**

    -   Before you can perform this procedure, you must first assign or publish the upgrade package.

    -   Depending on the GPO, the list of packages under **Package to upgrade** might have zero or more entries. If this is an upgrade under **Computer Configuration** in the Group Policy console tree, the **Required upgrade for existing packages** check box is selected and unavailable because packages can only be assigned to computersâ€�?they cannot be published.

#### To remove a managed application

1.  Open Group Policy Software Installation.

2.  In the results pane, right-click the application that you want to remove, point to **All Tasks**, and then click **Remove**.

3.  In the **Remove Software** dialog box, click one of the following removal methods:

    -   To specify that the application should be removed the next time a user logs on or restarts the computer, click **Immediately uninstall the software from users and computers**.

    -   To specify that users can continue to use the application if they have already installed it, click **Allow users to continue to use the software, but prevent new installations**. If users have removed the application or if they have never installed it, they will not be able to install it.

## How to set application properties

#### To edit installation options for applications

1.  Open Group Policy Software Installation.

2.  In the results pane, right-click the application for which you want to edit installation options, and then click **Properties**.

3.  In the **Properties** dialog box for the application, click the **Deployment** tab.

4.  On the **Deployment** tab, click one of the following options under **Deployment type**:

    -   **Published**: Users in the selected site, domain, or organizational unit can install the application by using either **Add or Remove Programs** in **Control Panel** or file activation.

    -   **Assigned**: Users in the selected site, domain, or organizational unit receive this application the next time they log on (for assignment to users) or when the computer restarts (for assignment to computers).

5.  Under **Deployment options**, select the check boxes for the following options that you want:

    -   **Autoinstall this application by file extension activation**: Select this option if you want to use the application precedence for the file name extension as it is determined on the **File Extensions** tab in the **Software installation properties** dialog box. If the application is not already installed, selecting this option causes the application to be installed when the user opens a file with this file association (for example, by double-clicking the file).

    -   **Uninstall this application when it falls out of the scope of management**: Select this option if you want the application to be removed when users log on, or when computers start up, if they have moved to a site, domain, or organizational unit for which the application is not deployed.

    -   **Do not display this package in Add or Remove Programs in Control Panel**: This option removes the most obvious method for users to uninstall the application. This option may be useful from time to time during the software life cycle.

    -   **Install this application at logon**: This option fully installs the application, using the package defaults. Note that the package defaults themselves might call for installation of all features or of only some features.

6.  Under **Installation user interface options**, click one of the following options:

    -   **Basic**: Only progress bars and errors are displayed.

    -   **Maximum**: The entire user interface that is supported by the package is displayed.

7.  If you want to set the following advanced options, click **Advanced**:

    -   **Ignore language when deploying this package**: Select this check box if you are installing an application whose language differs from the language of the operating system.

    -   **Remove existing installs of this product for users, if the product was not installed by Group Policyâ€“based Software Installation**: This option might be useful, for example, if company policy does not allow users to install applications from their own compact discs.

    -   **Make this 32-bit X86 application available to Win64 machines**: Specifies whether the 32-bit application should be assigned or published to 64-bit computers.

    -   **Include OLE class and product information**: Specifies whether to deploy information about COM components with the package so that software on the client can install them from Active Directory as needed, in a manner similar to activation by file extension.

    **Additional considerations**

    -   The **Advanced Deployment Options** dialog box, which appears when you click **Advanced**, provides advanced diagnostic information that can be useful for troubleshooting. The following table lists and describes this information.

    |Field|Data|
    |---------|--------|
    |Product code|A globally unique identifier (GUID) representing the product|
    |Deployment count|The number of times the package has been deployed in this Group Policy object|
    |Script name|The full network path, including GUIDs, to the application assignment script (.aas file)|

#### To specify application categories for Add or Remove Programs in Control Panel

1.  Open Group Policy Software Installation.

2.  In the results pane, right-click the managed application for which you want to set categories, and then click **Properties**.

3.  In the **Properties** dialog box for the application, click the **Categories** tab.

4.  On the **Categories** tab, do either of the following:

    -   To associate an application category that has been defined for your organization with this application, click a category in the **Available Categories** list, and then click **Select**.

    -   To remove a category that is associated with this application, click a category in the **Selected categories** list, and then click **Remove**.

    **Additional considerations**

    -   Because assigned applications do not appear in **Add or Remove Programs** in **Control Panel**, the categories that you set in this dialog box generally pertain to published applications only. The application appears in the selected categories in **Add or Remove Programs**, which the user can use to install the application.

    -   Do not use this procedure to create or remove categories. Use this procedure to associate applications with existing categories.

#### To set the autoinstall option for an application

1.  Open Group Policy Software Installation.

2.  In the console tree, click **Software installation**.

3.  In the results pane, right-click the application that you want to be installed automatically when the user tries to open a file with the associated extension.

4.  Click **Properties**, and then click the **Deployment** tab.

5.  Under **Deployment options**, select the **Auto-install this application by file extension activation** check box, and then click **OK**. This option is recommended, and it is selected by default.

    **Additional considerations**

    -   The autoinstall option will only apply if there is not currently an application for the associated extension.

#### To set permissions for Group Policy Software Installation

1.  Open the Group Policy object (GPO) that you want to edit.

2.  In the console tree, right-click the icon or name of the GPO, and then click **Properties**.

3.  Click the **Security** tab, and in the **Group or user names** box, click the security group for which you want to set permissions.

4.  Do any of the following:

    -   To change the set of security groups that has permissions on this GPO, click **Add** or **Remove** to add or remove security groups.

    -   If the security group represents administrators (who manage software for users and computers in the organization), in the **Permissions** box for the selected security group, select the **Allow** check box for Full Control, and then click **OK**.

    -   If the security group represents users (who use software that is assigned or published by an administrator), in the **Permissions** box for the selected security group, select the **Allow** check box for both **Apply Group Policy** and **Read**, and then click **OK**.

    **Additional considerations**

    -   The permissions that you set in this procedure pertain only to the GPO. In addition, the network must have a shared folder (a software distribution point) containing the packages to be installed. Administrators must have Full Control of the software distribution point, and users must have Read permission.

## How to work with modifications for an application package

#### To add or remove modifications for an application package

1.  Open Group Policy Software Installation.

2.  In the console tree, right-click **Software installation**, point to **New**, and then click **Package**.

3.  In the **Open** dialog box, click the Windows Installer package, and then click **Open**.

4.  In the **Deploy Software** dialog box, click **Advanced**, and then click **OK**.

5.  In the **Properties** dialog box for the package, click the **Modifications** tab.

6.  Do any of the following:

    -   To add modifications, click **Add**. In the **Open** dialog box, browse to the transform file (.mst), and then click **Open**.

    -   To remove modifications, on the **Modifications** tab, click the modification that you want to remove, and then click **Remove**. Repeat this step until you have removed each modification that you do not want.

7.  When you are sure that the modifications are configured the way you want them, click **OK**.

    > [!IMPORTANT]
    > Do not click **OK** until you have finished configuring the modifications. When you click **OK**, the package is assigned or published immediately. If the modifications are not properly configured, you will have to uninstall the package or upgrade the package with a correctly configured version.

**Additional considerations**

-   The **Open** dialog box shows the packages that are located at a software distribution point that you specify as the default.

-   If the Windows Installer package is located on a different shared network directory, navigate to the correct software distribution point in the **Open** dialog box, click the package, and then click **Open**.

-   Modifications (.mst files) are applied to Windows Installer packages (which have the .msi extension) in an order that you specify. This order must be determined before the application is assigned or published.

-   You can add multiple modifications, which are also called transforms. The transforms are applied in the order that you specify in the **Modifications** list, from top to bottom. To rearrange the list, click a transform in the list, and then click **Move Up** or **Move Down**.


