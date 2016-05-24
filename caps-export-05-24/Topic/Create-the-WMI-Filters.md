---
title: Create the WMI Filters
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 525bee89-a01c-483c-b9d4-03ca2c942b85
author: jaimeo
---
# Create the WMI Filters
Use this procedure to create the WMI filters that are used to restrict the application of a GPO to the computers in the membership group that are running the version of Windows for which the GPO is intended.  
  
Membership in **Domain Admins** is the minimum required to complete this procedure.  
  
## Create WMI Filters  
  
#### To create the WMI filters  
  
1.  On AD\-DNS\-01, in Server Manager, click **Tools**, and then click **Group Policy Management**. The Group Policy Management Console \(GPMC\) opens.  
  
2.  In the GPMC navigation pane, expand **Features**, expand **Group Policy Management**, expand **Forest:** *your forest name*, expand **Domains**, expand your domain, and then click **WMI Filters**.  
  
3.  Click **Action**, and then click **New**.  
  
4.  In the **New WMI Filter** dialog box, in **Name**, type the name of the filter. Use a name that indicates the target group \(for example, **Windows Server 2012**\).  
  
5.  In **Description**, type the purpose of the filter.  
  
6.  Click **Add**.  
  
    The **WMI Query** dialog box appears.  
  
7.  In **Query**, type the WMI Query Language \(WQL\) string that returns **TRUE** when applied to the correct version of Windows. For example, for [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] type:  
  
    ```  
    select * from Win32_OperatingSystem where Version like "6.2%" and ProductType = "3"  
    ```  
  
    Both [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] return version numbers that begin with `6.2`. To differentiate between the client and server versions, include the clause to check the **ProductType** field. This value returns **1** for client versions of Windows such as [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], **2** for server versions of Windows operating as domain controllers, and **3** for server versions of Windows that are not operating as domain controllers.  
  
8.  Repeat step 8 for each of the other versions of Windows. The following table shows sample query statements for each version.  
  
    |WMI Filter Name|WQL Query Statement|  
    |-------------------|-----------------------|  
    |Windows Server 2012|`select * from Win32_OperatingSystem where Version like "6.2%" and ProductType = "3"`|  
    |Windows 8|`select * from Win32_OperatingSystem where Version like "6.2%" and ProductType = "1"`|  
    |Windows Server 2008 R2|`select * from Win32_OperatingSystem where Version like "6.1%" and ProductType = "3"`|  
    |Windows 7|`select * from Win32_OperatingSystem where Version like "6.1%" and ProductType = "1"`|  
    |Windows Server 2008|`select * from Win32_OperatingSystem where Version like "6.0%" and ProductType = "3"`|  
    |Windows Vista|`select * from Win32_OperatingSystem where Version like "6.0%" and ProductType = "1"`|  
    |Windows Server 2003|`select * from Win32_OperatingSystem where Version like "5.2%" and ProductType = "3"`|  
    |Windows XP|`select * from Win32_OperatingSystem where (Version like "5.1%" or Version like "5.2%") and ProductType = "1"`|  
  
    > [!NOTE]  
    > The filter for Windows 2000 is used to prevent computers that are running later versions of Windows from applying the GPO. You cannot use a WMI filter to apply a GPO to computers that are running Windows 2000 because that version of the operating system does not support WMI filters.  
  
    You can also create combination filters when required by your design. The following table shows query statements for common operating system combinations.  
  
    |WMI Filter Name|WQL Query Statement|  
    |-------------------|-----------------------|  
    |Windows Vista and Windows Server 2008|`select * from Win32_OperatingSystem where Version like "6.0%" and ProductType<>"2"`|  
    |Windows Server 2003 and Windows Server 2008|`select * from Win32_OperatingSystem where (Version like "5.2%" or Version like "6.0%") and ProductType="3"`|  
    |Windows 2000, XP and 2003|`select * from Win32_OperatingSystem where Version like "5.%" and ProductType<>"2"`|  
  
