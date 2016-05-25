---
title: WDS: Managing and Deploying Driver Packages
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 88541bde-edd9-43c1-94a1-b2d20e879e45
---
# WDS: Managing and Deploying Driver Packages
You can use Windows Deployment Services to add driver packages to the server and configure them to be deployed to client computers along with the install image. The following sections will guide you through this process:  
  
-   [Terminology reference](#term)  
  
-   [Choosing a scenario](#choosing)  
  
-   [Prerequisites](#pre)  
  
-   [Scenario 1: Deploy Driver Packages Based on the Plug and Play Hardware of the Client](#scen1)  
  
-   [Scenario 2: Deploy Driver Packages Using Filters to Define Which Clients Have Access to Each Driver Group](#scen2)  
  
-   [Scenario 3: Deploy All Driver Packages in a Driver Group to Clients](#scen3)  
  
-   [Managing Driver Groups and Driver Packages](#scen4)  
  
-   [Adding Driver Packages to Boot Images](#boot)  
  
## <a name="term"></a>Terminology reference  
  
|Term|Definition|  
|--------|--------------|  
|Driver group|A driver group is a collection of driver packages. You can add filters to a driver group to make the packages in the group available to a select group of client computers. Alternatively, if there are no filters on a driver group, then the packages will be available to all clients that have matching hardware. You can define whether clients that have access to the driver group install either 1\) all the packages in the group, or 2\) only those packages that match the hardware that is connected to or installed on the client \(that is, Plug and Play hardware\).|  
|Filters|Filters enable you to map the packages in a driver group to specific client computers. The filters define which clients have access to the packages. There are two types of filters: filters based on the hardware of the client \(for example, manufacturer and BIOS vendor\) and filters based on the attributes of the install image that is selected on the client \(for example, the version or edition of the image\).|  
|Plug and Play hardware|Plug and Play functionality provides automatic configuration of hardware and devices for Windows operating systems.|  
  
## <a name="choosing"></a>Choosing a Scenario  
You can configure the driver packages to be deployed to clients in three ways. The following table describes each of these methods and describes when you should use each.  
  
|Scenario|Description|When To Use This Scenario|  
|------------|---------------|-----------------------------|  
|Scenario 1: Deploy driver packages to clients based on the Plug and Play hardware of the client|In this scenario, you make all packages available to all clients \(that is, you do not add filters to your driver groups\), and you configure the groups so that only those packages that match the hardware on the computer will be installed.|This is the simplest scenario to configure, and most companies should try this scenario first. However, if you encounter problems because incompatible packages are installed simultaneously on a computer \(for example, if you have computers that cannot boot, or hardware that does not work correctly\), then you will need to add filters to your driver groups as defined in Scenario 2.|  
|Scenario 2: Deploy driver packages using filters to define which clients have access to each driver group|In this scenario, you organize your packages into driver groups, and then map each group to computers using filters. The filters define which computers have access to the driver group based on the hardware of the computer and\/or the attributes of the selected install image. You can still configure the packages to be installed based on Plug and Play hardware, but you can use the filters to further define which clients will have access to the packages.|You should consider using this scenario if:<br /><br />-   Scenario 1 is resulting in hardware that does not work correctly on a computer.<br />-   You have a complex environment including computers with various hardware and software configurations.<br />-   You need to install specific driver packages on certain computers \(for example, computers with different languages or versions of an install image\).|  
|Scenario 3: Deploy all driver packages in a driver group to clients|In this scenario, you deploy all of the driver packages in a driver group to a client computer \(not just those that match the Plug and Play hardware on the client\). After the installation, when you connect the hardware to the client, the device driver will be installed automatically.|Use this option if you have hardware that is disconnected from the computer \(for example, a printer or scanner\) and you want to force all of the packages in a driver group to be installed on the client. Typically, you should use this scenario in combination with either Scenario 1 or 2.|  
  
## <a name="pre"></a>Prerequisites  
The following are prerequisites for all three of the scenarios:  
  
-   A Windows Deployment Services server configured with the following:  
  
    -   The boot image from either [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] Windows 7 or Windows Server 2008 R2 \(from \\Sources\\Boot.wim on the DVD\).  
  
    -   Install images for [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Windows Server 2008, Windows 7, or Windows Server 2008 R2.  
  
-   Driver packages for the hardware that you want to deploy. Note that these packages must be extracted \(that is, the package cannot be a .msi or .exe file\).  
  
## <a name="scen1"></a>Scenario 1: Deploy Drivers Based on the Plug and Play Hardware of the Client  
In this scenario, you make all packages available to all clients \(that is, you do not add filters to your driver groups\) and you configure the groups so that only those packages that match the hardware on the computer will be installed.  
  
> [!IMPORTANT]  
> You should thoroughly test this scenario before implementing it across your organization.  
  
### Known issues  
  
-   Depending on the driver packages on the server and the hardware of the client, this scenario could result in a computer that will not boot. If this happens, you will need to figure out which driver packages are causing the problem and either remove them from the server, or restrict them using filters as outlined in Scenario 2.  
  
##### To add packages and configure the server  
  
1.  Open the Windows Deployment Services MMC snap\-in.  
  
2.  Expand the **Servers** node and the node for your Windows Deployment Services server.  
  
3.  Right\-click the **Drivers** node and click **Add Driver Package**.  
  
4.  Follow the instructions in the wizard to add the driver packages. When asked which driver group to add the packages to, click **Select an existing driver group**, and ensure that **DriverGroup1** is selected. This driver group \(by default\) is configured as follows: 1\) it has no filters so all clients will have access to the packages in this group and 2\) only packages that match the client’s hardware will be installed. To view these settings, right\-click **DriverGroup1**, and click **Properties**.  
  
5.  On the last page of the wizard, do not select the check box to modify the filters for the group, and click **Finish**.  
  
6.  Repeat steps 3\-5 until you have added all of your driver packages to **DriverGroup1**.  
  
    > [!NOTE]  
    > If you would prefer to organize your packages into different driver groups, you can create driver groups when adding packages. However, you should not add any filters to them for this scenario.  
  
    The server is now configured, so all computers that install a supported image will have access to this driver group. However, computers will only install those packages that match the Plug and Play hardware. You can now install an image as described in the next procedure.  
  
##### To install the driver packages and an install image  
  
1.  Ensure that all hardware \(for which you want packages to be installed\) is connected to client computers.  
  
2.  Boot a client computer and install an image.  
  
3.  When the installation is complete, open **Device Manager** on the client computer and verify that the device drivers for all connected hardware were installed.  
  
## <a name="scen2"></a>Scenario 2: Deploy Drivers Using Filters to Define Which Clients Have Access to Each Driver Group  
This scenario is not as simple as Scenario 1 in that it will require you to test your configuration until the filters are configured appropriately for your environment. You may need to create many driver groups with different filter combinations before you find a configuration that works for you. In general, the more complex your environment is, the more complex your configuration will need to be.  
  
### Known issues  
  
-   The filter value must exactly match the client hardware or the install image specifications. The two available operators for most filters are **Equal to** or **Not equal to**. Therefore, if the value you specify is one character off \(for example, if you omit a period\) the filters will not filter the clients as intended. For this reason, we recommend that you create multiple filters to account for all cases. For example, create filters for **Fabrikam, Inc.**  and **Fabrikam** and so on.  
  
-   When searching through the packages using the MMC snap\-in to perform a task \(for example, to delete a package\), the dialog may be briefly unresponsive if you have hundreds of packages on your server. In these cases, note that you should continue to wait because the server is working on your request. For this reason we recommend that you add no more than 2000 driver packages to a group at time \(although there is not an enforced limit\).  
  
### Steps for deploying driver packages using filters  
The first step in this scenario is to create driver groups that have filters. The filters define which computers should have access to the driver packages in that group. You can configure packages to be installed based on the hardware of the client \(for example, the manufacturer or BIOS vendor\) and the attributes of the Windows image that is selected during the installation \(for example, the version or edition\). For example, you could specify that the only client computers that should have access to a group are those that 1\) are manufactured by Fabrikam, Inc. and 2\) select a Windows 8 image during the installation. Once you have your driver groups configured, you will add packages to them, and then you will be ready to boot a computer and install an operating system.  
  
##### To create driver groups with filters  
  
1.  Open the Windows Deployment Services MMC snap\-in.  
  
2.  Expand the **Servers** node and the node for your Windows Deployment Services server.  
  
3.  Right\-click **DriverGroup1** and click **Disable**. You must disable DriverGroup1 because \(by default\) it does not have filters on it and therefore, it will deploy all packages to all clients.  
  
4.  Right\-click the **Drivers** node and click **Add Driver Group**.  
  
5.  Type a name for the group, click **Next**, and follow the instructions to add filters as appropriate for your organization. For a list of filters, see Driver Group Filters \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=155158](http://go.microsoft.com/fwlink/?LinkID=155158)\).  
  
6.  On the **Packages to Install** screen, select **Install only the driver packages that match a client’s hardware**.  
  
7.  Click **Next** and then click **Finish**.  
  
8.  Repeat steps 3\-6 until you have created and configured all desired driver groups.  
  
Now that you have configured your driver groups, you are ready to add driver packages to them as described in the next procedure.  
  
##### To add driver packages to the driver groups  
  
1.  For packages that you have not already added to the server, right\-click the **Drivers** node, click **Add Driver Package**, and follow the instructions to add the package to one of the groups that you created in the previous procedure.  
  
2.  For packages that are already on the server but are not in the correct group, right\-click the desired driver group, and click **Add Driver Packages to this Group**.  
  
3.  Use the search attributes to search through the packages that are on the server, and then click **Add** to add them to the group.  
  
    > [!NOTE]  
    > To add a specific package to a group, you can also right\-click the package and click **Add or Remove from Groups**. In the dialog, configure the driver package using the arrows, and then click **Apply**.  
  
4.  Repeat steps 1\-3 until you have added all the packages that you want, and click **Close**.  
  
5.  If you need to remove a package from a group, click the group, right\-click the specific driver package in the right pane. Then you can click **Add or Remove from Groups** to see a list of groups that you can add it to or remove it from. You can also click **Remove from this Group** to remove it instantly. To delete the package from the server, right\-click the package and click **Delete**.  
  
Now that you have configured driver groups and added packages to them, you are ready to boot a client as described in the following procedure.  
  
##### To install the driver packages and an install image  
  
1.  Ensure that all hardware \(that you want the driver packages to be installed for\) is connected to client computers.  
  
2.  Boot a computer and install an image.  
  
3.  When the installation is complete, open **Device Manager** on the client computer from the Control Panel and verify that the appropriate device drivers were installed.  
  
## <a name="scen3"></a>Scenario 3: Deploy All Driver Packages in a Driver Group to Clients  
You can configure any driver group so that *all* of the packages within it will be deployed to applicable clients—not only those for which hardware is connected to the client. To configure a driver group in this way, use the following procedure.  
  
> [!IMPORTANT]  
> Depending on the driver packages on the server and the hardware of the client, this scenario could result in a computer that will not boot. If this happens, you will need to figure out which driver packages are causing the problem and either remove them from the server, or restrict them using filters as outlined in Scenario 2.  
  
#### To install all packages to applicable clients  
  
1.  Open the Windows Deployment Services MMC snap\-in.  
  
2.  Right\-click the driver group, and click **Properties**.  
  
3.  Under **Applicability**, select **All driver packages in the group** from the drop\-down menu.  
  
4.  Boot a client computer and install an image.  
  
5.  When the installation is complete, connect the Plug and Play hardware to the client computer and verify that Windows finds the device driver for it.  
  
## <a name="scen4"></a>Managing Driver Groups and Driver Packages  
In general, you can manage your driver groups and packages by right\-clicking the **Drivers** node, a driver group, or a specific package. Then, you can select one of the available tasks such as adding, deleting, or enabling the item. For a list of the attribute you use to perform these tasks, see Driver Package Attributes \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=155167](http://go.microsoft.com/fwlink/?LinkId=155167)\).  
  
## <a name="boot"></a>Adding Driver Packages to Boot Images  
You can use Windows Deployment Services to add driver packages \(such as network adapter drivers, mass storage drivers, and bus drivers\) to your [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] boot images. This means that you do not have to export the image, use the tools in the Windows Automated Installation Kit to add driver packages manually, and then add the updated boot image.  
  
### Known issues  
  
-   You should only add *necessary* driver packages to boot images \(that is, network adapter drivers, mass storage drivers, and system bus drivers\). We recommend this because it will reduce the size of the image, and also to reduce the chances that drivers collide with each other.  
  
##### To add driver packages to a boot image using the Windows interface  
  
1.  Add the driver package to the server.  
  
2.  In the Windows Deployment Services MMC snap\-in, expand the **Boot Images** node. It is okay if the image that you are updating is currently being downloaded to a client when you perform this procedure. Windows Deployment Services ensures that the client will get a consistent copy of the file.  
  
3.  Right\-click the image that you want to add the driver to, and click **Add Driver Packages to Image**.  
  
4.  Follow the instructions in the wizard to search for the package and then add it to the image.  
  
> [!NOTE]  
> When adding driver packages to boot images using WDSUTIL, you must specify **\/filtertype:packagearchitecture \/operator:equal \/value:<arch>** where <arch> matches the architecture of the boot image. For example, run **WDSUTIL \/verbose \/progress \/add\-imagedriverpackages \/image:"Microsoft Windows Setup \(x64\)" \/imagetype:boot \/architecture:x64 \/filtertype:packagearchitecture \/operator:equal \/value:x64**. If you do not specify this command and the package contains packages that do not match the architecture of the image, the command will fail.  
  
