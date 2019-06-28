---
title: Migrate your Remote Desktop Services Client Access Licenses (RDS CALs)
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
ms.assetid: 91bdedce-6145-469f-b72e-7e113c4391e9
author: christianmontoya
manager: scottman
---
# Migrate your Remote Desktop Services Client Access Licenses (RDS CALs)

You have three options to migrate your RDS CALs:
1. Automatic connection method: This recommended method communicates via internet directly to the Microsoft Clearinghouse outbound over TCP port 443.  
2. Using a web browser: This method allows migration when the server running the Remote Desktop Licensing Manager tool does not have internet connectivity, but the administrator has internet connectivity on a separate device. The URL for the Web migration method is displayed in the Manage RDS CALs Wizard. 
3. Using a telephone: This method allows the administrator to complete the migration process over the phone with a Microsoft representative. The appropriate telephone number is determined by the country/region that you chose in the Activate Server Wizard and is displayed in the Manage RDS CALs Wizard.

In this article, the [Establish RDS CAL migration method](#establish-rds-cal-migration-method) highlights the general steps common across any RDS CAL migration method, while [Migrate RDS CALs](#migrate-rds-cals) highlights the steps specific to each migration method.

Regardless of migration method, you must, at a minimum, be a member of the local Administrators group to perform the migration steps.

## Establish RDS CAL migration method

1. On the license server, open **Remote Desktop Licensing Manager**. (Click **Start > Administrative Tools**. Enter the **Remote Desktop Services** directory, and launch **Remote Desktop Licensing Manager**.)
2. Verify the connection method for the Remote Desktop license server: right-click the license server to which you want to migrate the RDS CALs, and then click **Properties**. On the **Connection Method** tab, verify the **Connection method** - you can change it in the dropdown menu. Click **OK**.
3. Right-click the license server to which you want to migrate the RDS CALs, and then click **Manage RDS CALs**.
4. Follow the steps in the wizard to the **Action Selection** page. Click **Migrate RDS CALs from another license server to this license server**.
6. Choose the reason for migrating the RDS CALs, and then click **Next**. You have the following choices:
    - The source license server is being replaced by this license server.
    - The source license server is no longer functioning.
7. The next page in the wizard depends on the migration reason that you chose.
    - If you chose **The source license server is being replaced by this license server** as the reason for migrating the RDS CALs, the **Source License Server Information** page is displayed.
    
       On the Source License Server Information page, enter the name or IP address of the source license server.

       If the source license server is available on the network, click **Next**. The wizard contacts the source license server. If the source license server is running an operating system earlier than Windows Server 2008 R2 or the source license server is deactivated, you are reminded that you must remove the RDS CALs manually from the source license server after the wizard has completed. After you confirm that you understand this requirement, the **Obtain Client License Key Pack** page appears.

       If the source license server is not available on the network, select **The specified source license server is not available on the network**. Specify the operating system that the source license server is running, and then provide the license server ID for the source license server. After you click **Next**, you are reminded that you must remove the RDS CALs manually from the source license server after the wizard has completed. After you confirm that you understand this requirement, the **Obtain Client License Key Pack** page appears.

    - If you chose **The source license server is no longer functioning** as the reason for migrating the RDS CALs, you are reminded that you must remove the RDS CALs manually from the source license server after the wizard has completed. After you confirm that you understand this requirement, the **Obtain Client License Key Pack** page appears.

The next step is to migrate the CALs - use the information below to complete the wizard. Note that what you see in the wizard depends on the connection method you identified in Step 2 above.

## Migrate RDS CALs

There are three mechanisms to migrate licenses to the destination license server; continue the steps corresponding to the **Connection method** verified in Step 2:
  - [Automatic connection method](#automatic-connection-method)
  - [Using a web browser](#using-a-web-browser)
  - [Using a telephone](#using-a-telephone)

### Automatic connection method

1. On the **License Program** page, select the appropriate program through which you purchased your RDS CALs, then click **Next**.
2. Enter the required information (typically a license code or an agreement number, depending on the **License program**), and then click **Next**. Consult the documentation provided when you purchased your RDS CALs.
4. Select the appropriate product version, license type, and quantity of RDS CALs for your environment based on your RDS CAL purchase agreement, and then click **Next**.
5. The Microsoft Clearinghouse is automatically contacted and processes your request. The RDS CALs are then migrated onto the license server.
6. Click **Finish** to complete the RDS CAL migration process.

### Using a web browser
1. On the **Obtain Client License Key Pack** page, click the hyperlink to connect to the Remote Desktop Services Licensing Web site.
   If you are running Remote Desktop Licensing Manager on a computer that does not have Internet connectivity, note the address for the Remote Desktop Services Licensing Web site, and then connect to the Web site from a computer that has Internet connectivity. 
2. On the Remote Desktop Services Licensing Web page, under **Select Option**, select **Manage CALs**, and then click **Next**.
3. Provide the following required information, then click **Next**:
    - **Target License Server ID**: A 35-digit number, in groups of 5 numerals, which is displayed on the **Obtain Client License Key Pack** page in the Manage RDS CALs Wizard.
    - **Reason for recovery**: Choose the reason for migrating the RDS CALs.
    - **License Program**: Choose the program through which you purchased your RDS CALs.
4. Provide the following required information, then click **Next**:
   - Last name or surname
   - First name or given name
   - Company name
   - Country/region

     You can also provide the optional information requested, such as company address, e-mail address, and phone number. In the organizational unit field, you can describe the unit within your organization that this license server serves.

5. The License Program that you selected on the previous page determines what information you need to provide on the next page. In most cases, you must provide either a license code or an agreement number. Consult the documentation provided when you purchased your RDS CALs. In addition, you need to specify which type of RDS CAL and the quantity that you want to migrate to the license server.
6. After you have entered the required information, click **Next**.
7. Verify that all of the information that you have entered is correct, then click **Next** to submit your request to the Microsoft Clearinghouse. The web page then displays a license key pack ID generated by the Microsoft Clearinghouse.

   > [!IMPORTANT] 
   > Keep a copy of the license key pack ID. Having this information with you facilitates communications with the Microsoft Clearinghouse, should you need assistance with recovering RDS CALs.

8. On the same **Obtain Client License Key Pack** page, enter the license key pack ID, and then click **Next** to migrate the RDS CALs to your license server.
9. Click **Finish** to complete the RDS CAL migration process.

### Using a telephone
1. On the **Obtain Client License Key Pack** page, use the displayed telephone number to call the Microsoft Clearinghouse. Give the representative your Remote Desktop license server ID and the required information for the licensing program through which you purchased your RDS CALs. The representative then processes your request to migrate the RDS CALs, and gives you a unique ID for the RDS CALs. This unique ID is referred to as the **license key pack ID**.

   > [!IMPORTANT]
   > Keep a copy of the license key pack ID. Having this information with you facilitates communications with the Microsoft Clearinghouse should you need assistance with recovering RDS CALs.

2. On the same **Obtain Client License Key Pack** page, enter the license key pack ID, and then click **Next** to migrate the RDS CALs to your license server.
3. Click **Finish** to complete the RDS CAL migration process.
