---
title: Transition from Windows Server 2012 R2 Essentials to Windows Server 2012 R2 Standard
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a14689e3-2310-4229-bd3e-dafc0e739e02
---
# Transition from Windows Server 2012 R2 Essentials to Windows Server 2012 R2 Standard
[!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] supports up to 25 users and 50 devices. When your business needs exceed the limit, you can perform an in\-place license transition from [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] to [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] to remain license compliant.  
  
After you transition to [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)], the user account and devices limits are removed, but the features that are unique to [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] \(such as the Dashboard, Remote Web Access, and client computer backup\) still remain available. However, technical limitations for these features support a maximum of 100 user accounts and 200 devices. The client computer backup functionality will support backup of up to 75 devices.  
  
> [!IMPORTANT]  
> [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] requires a client access license \(CAL\) for each user or device in your environment. This is different from [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)], which does not use the CAL model and does not come with any CALs. When transitioning from [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] to [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)], you will need to purchase the appropriate number and type of CALs for your environment \(most customers purchase user CALs\).  
  
## Before the transition  
  
-   Before transitioning from [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] to [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)], you should fully back up the server data.  
  
    > [!IMPORTANT]  
    > Without a full backup of the server, you cannot restore the server to the state that it was in prior to the transition.  
  
-   In addition, make sure that you read and understand the End User License Agreement \(EULA\) for [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)]. To view the EULA:  
  
    1.  Open a command window as Administrator.  
  
    2.  Run the following command:  
  
        **dism \/online \/set\-edition:ServerStandard \/geteula:***eula path* \(where *eula path* represents the location to which you want to save the EULA file; for example: C:\\ws8std\_eula.rtf\). Be sure to use .rtf as the file name extension.  
  
    3.  Open the location where you saved the file, and then double\-click the file to open it.  
  
## Transition to [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)]  
After you have decided to transition from [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] to [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)], complete these two steps:  
  
1.  Purchase a license for [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] and the appropriate number of user and\/or device client access licenses for your environment.  
  
    You can purchase a license for [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] from a Retail Outlet, a Distributor, or with the help of a [Microsoft Partner](http://pinpoint.microsoft.com/SelectCulture.aspx).  
  
    > [!NOTE]  
    > If you purchased [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] initially and exercised your downgrade rights to install one of your two virtual instances as [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)], you do not need to purchase anything additional.  
    >   
    > If you purchase [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] through the Volume Licensing channel, you can download an ISO image and a product key for [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] from the Volume Licensing Service Center \(VLSC\).  
    >   
    > If you purchase [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)] from any other channel, you can download an ISO image and an evaluation product key for [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] from the [TechNet Evaluation Center](http://technet.microsoft.com/evalcenter/jj659306.aspx). Performing the transition as described in the next step will convert the evaluation product to a fully licensed and supported product.  
  
2.  Open Windows PowerShell as Administrator, and then run the following command:  
  
    **dism \/online \/set\-edition:ServerStandard \/accepteula \/productkey:***Product Key* \(where *Product Key* is the product key for your copy of [!INCLUDE[winblue_server_standard_2](../Token/winblue_server_standard_2_md.md)]\).  
  
    The server restarts to finish the transition process.  
  
After the transition, the [!INCLUDE[wseblue_2](../Token/wseblue_2_md.md)] features remain on the server and are supported for up to 100 users and 200 devices.  
  
## See also  
  
-   [Migrate Server Data to Windows Server Essentials](../Topic/Migrate-Server-Data-to-Windows-Server-Essentials.md)  
  
