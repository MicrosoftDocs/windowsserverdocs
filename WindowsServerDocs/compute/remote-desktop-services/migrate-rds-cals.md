---
title:
description: This article describes how to migrate your Remote Desktop Services Client Access Licenses to new Windows Server 2016 license servers.
ms.custom: na
ms.prod: windows-server-threshold
msreviewer:
nams.suite:
nams.technology: remote-desktop-services
ms.author: chrimo
ms.date: 11/01/2016
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 
author: christianmontoya
manager: scottman
---
# Migrate your Remote Desktop Services Client Access Licenses

There are three methods to migrate RDS CALS:
1. Automatic connection method: This recommended method does not directly require full internet connectivity on the RD license server, as it directly communicates to the Microsoft Clearinghouse outbound over TCP port 443.
2. Using a web browser: This method allows migration when the server running the Remote Desktop Licensing Manager tool does not have internet connectivity, but the administrator has internet connectivity on a separate device. The URL for the Web migration method is displayed in the Manage RDS CALs Wizard. 
3. Using a telephone: This method allows the administrator to complete the migration process over the phone with a Microsoft representative. The appropriate telephone number is determined by the country/region that you chose in the Activate Server Wizard and is displayed in the Manage RDS CALs Wizard.

In this article, the [Establish RDS CAL migration method](#establish-RDS-CAL-migration-method) highlights the general steps common across any RDS CAL migration method, while [migrate RDS CALs](#migrate-RDS-CALs) highlights the steps specific each migration method.

Regardless of migration method, the logged-in user performing these actions must (at a minimum) be a member of the local Administrators group.


## Establish RDS CAL migration method
1. On the license server, open **Remote Desktop Licensing Manager**. To open **Remote Desktop Licensing Manager**, launch the start menu, select **Administrative Tools**, enter the **Remote Desktop Services** directory, and launch **Remote Desktop Licensing Manager**.
2. Verify the connection method for the Remote Desktop license server by right-clicking the license server onto which you want to migrate the RDS CALs, and then selecting **Properties**. On the **Connection Method** tab, verify the **Connection method** and change if necessary by using the dropdown menu, and then select **OK**.
3. Right-click the license server onto which you want to migrate the RDS CALs, and select **Manage RDS CALs**.
4. Advance to the **Action Selection** page by selecting **Next** on the **Welcome to the Manage RDS CALs** Wizard page.
5. Select **Migrate RDS CALs from another license server to this license server**.
6. Select the reason for migrating the RDS CALs, then select **Next**. You can select either of the following:
    - The source license server is being replaced by this license server.
    - The source license server is no longer functioning.
7. The page that appears in the wizard depends on the reason that you selected on the previous page.
    - If you selected **The source license server is being replaced by this license server** as the reason for migrating the RDS CALs, the **Source License Server Information** page appears.

    On the Source License Server Information page, enter the name or IP address of the source license server.

    If the source license server is available on the network, click Next. The wizard contacts the source license server. If the source license server is running an operating system earlier than Windows Server 2008 R2 or the source license server is deactivated, you are reminded that you must remove the RDS CALs manually from the source license server after the wizard has completed. After you confirm that you understand this requirement, the Obtain Client License Key Pack page appears.

    If the source license server is not available on the network, select the The specified source license server is not available on the network check box. If the source license server is not available on the network, you need to specify the operating system that the source license server is running and provide the license server ID for the source license server. After you click Next, you are reminded that you must remove the RDS CALs manually from the source license server after the wizard has completed. After you confirm that you understand this requirement, the Obtain Client License Key Pack page appears.

    If you selected The source license server is no longer functioning as the reason for migrating the RDS CALs, you are reminded that you must remove the RDS CALs manually from the source license server after the wizard has completed. After you confirm that you understand this requirement, the Obtain Client License Key Pack page appears.

## Migrate RDS CALs
There are three mechanisms to migrate licenses to the destination license server; continue the steps corresponding to the **Connection method** verified in Step 2:
  - [Automatic connection method](#Automatic-connection-method)
  - [Using a web browser](#Using-a-web-browser)
  - [Using a telephone](#Using-a-telephone)

### Automatic connection method
8. On the **License Program** page, select the appropriate program through which you purchased your RDS CALs, then select **Next**.
9. Enter the required information (typically a license code or an agreement number, depending on the selected **License program**) and select **Next**. Consult the documentation provided when you purchased your RDS CALs.
10. After you have entered the required information, click Next.
11. On the Product Version and License Type page, select the appropriate product version, license type, and quantity of RDS CALs for your environment based on your RDS CAL purchase agreement, and then click Next.
12. The Microsoft Clearinghouse is automatically contacted and processes your request. The RDS CALs are then migrated onto the license server.
13. On the **Completing the Manage RDS CALs Wizard page**, select **Finish** to complete the RDS CAL migration process.

### Using a web browser
8. On the **Obtain Client License Key Pack** page, click the hyperlink to connect to the Remote Desktop Services Licensing Web site.
If you are running Remote Desktop Licensing Manager on a computer that does not have Internet connectivity, note the address for the Remote Desktop Services Licensing Web site, and then connect to the Web site from a computer that has Internet connectivity. 
9. On the Remote Desktop Services Licensing Web page, under **Select Option**, select **Manage CALs**, and then select **Next**.
10. Provide the following required information, then select **Next**:
    - Target License Server ID   A 35-digit number, in groups of 5 numerals, which is displayed on the **Obtain Client License Key Pack** page in the Manage RDS CALs Wizard.

    - Reason for recovery   Select the reason for migrating the RDS CALs.

    - License Program   Select the appropriate program through which you purchased your RDS CALs.
11. Provide the following required information, then select **Next**:
    - Last name or surname

    - First name or given name

    - Company name

    - Country/region

    You can also provide the optional information requested, such as company address, e-mail address, and phone number. In the organizational unit field, you can describe the unit within your organization that this license server serves.

12. The License Program that you selected on the previous page determines what information you need to provide on this page. In most cases, you must provide either a license code or an agreement number. Consult the documentation provided when you purchased your RDS CALs. In addition, you need to specify which type of RDS CAL and the quantity that you want to migrate to the license server.
13. After you have entered the required information, click Next.
14. Verify that all of the information that you have entered is correct, then select **Next** to submit your request to the Microsoft Clearinghouse. The web page then displays a license key pack ID generated by the Microsoft Clearinghouse.
    > [!IMPORTANT] 
    > Retain a copy of the license key pack ID. Having this information with you facilitates communications with the Microsoft Clearinghouse, should you need assistance with recovering RDS CALs.


15. On the same **Obtain Client License Key Pack** page, enter the license key pack ID in the boxes provided, and then select **Next** to migrate the RDS CALs to your license server.
16. On the **Completing the Manage RDS CALs Wizard page**, select **Finish** to complete the RDS CAL migration process.

### Using a telephone
8. On the **Obtain Client License Key Pack** page, use the telephone number that is displayed to call the Microsoft Clearinghouse, and give the representative your Remote Desktop license server ID and the required information for the licensing program through which you purchased your RDS CALs. The representative then processes your request to migrate the RDS CALs, and gives you a unique ID for the RDS CALs. This unique ID is referred to as the license key pack ID.
    > [!IMPORTANT]
    > Retain a copy of the license key pack ID. Having this information with you facilitates communications with the Microsoft Clearinghouse should you need assistance with recovering RDS CALs.


9. On the same **Obtain Client License Key Pack** page, enter the license key pack ID in the boxes provided, and then select **Next** to migrate the RDS CALs to your license server.
10. On the **Completing the Manage RDS CALs** Wizard page, select **Finish** to complete the RDS CAL migration process.