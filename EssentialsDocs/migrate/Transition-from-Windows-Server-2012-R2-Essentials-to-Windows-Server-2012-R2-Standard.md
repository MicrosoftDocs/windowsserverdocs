---
title: "Transition from Windows Server Essentials to Windows Server 2012 R2 Standard"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a14689e3-2310-4229-bd3e-dafc0e739e02
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Transition from Windows Server Essentials to Windows Server 2012 R2 Standard

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Windows Server 2016 is the cloud-ready operating system that supports your current workloads while introducing new technologies that make it easy to transition to cloud computing. Windows Server 2016 content helps get you ready.

 Windows Server Essentials supports up to 25 users and 50 devices. When your business needs exceed the limit, you can perform an in-place license transition from  Windows Server Essentials to  Windows Server 2012 R2 Standard to remain license compliant.  
  
 After you transition to  Windows Server 2012 R2 Standard, the user account and devices limits are removed, but the features that are unique to  Windows Server Essentials (such as the Dashboard, Remote Web Access, and client computer backup) still remain available. However, technical limitations for these features support a maximum of 100 user accounts and 200 devices. The client computer backup functionality will support backup of up to 75 devices.  
  
> [!IMPORTANT]
>   Windows Server 2012 R2 Standard requires a client access license (CAL) for each user or device in your environment. This is different from  Windows Server Essentials, which does not use the CAL model and does not come with any CALs. When transitioning from  Windows Server Essentials to  Windows Server 2012 R2 Standard, you will need to purchase the appropriate number and type of CALs for your environment (most customers purchase user CALs).  
  
## Before the transition  
  
-   Before transitioning from  Windows Server Essentials to  Windows Server 2012 R2 Standard, you should fully back up the server data.  
  
    > [!IMPORTANT]
    >  Without a full backup of the server, you cannot restore the server to the state that it was in prior to the transition.  
  
-   In addition, make sure that you read and understand the End User License Agreement (EULA) for  Windows Server 2012 R2 Standard. To view the EULA:  
  
    1.  Open a command window as Administrator.  
  
    2.  Run the following command:  
  
         **dism /online /set-edition:ServerStandard /geteula:** *eula path* (where *eula path* represents the location to which you want to save the EULA file; for example: C:\ws8std_eula.rtf). Be sure to use .rtf as the file name extension.  
  
    3.  Open the location where you saved the file, and then double-click the file to open it.  
  
## Transition to  Windows Server 2012 R2 Standard  
 After you have decided to transition from  Windows Server Essentials to  Windows Server 2012 R2 Standard, complete these two steps:  
  
1. Purchase a license for  Windows Server 2012 R2 Standard and the appropriate number of user and/or device client access licenses for your environment.  
  
    You can purchase a license for  Windows Server 2012 R2 Standard from a Retail Outlet, a Distributor, or with the help of a [Microsoft Partner](https://pinpoint.microsoft.com/SelectCulture.aspx).  
  
   > [!NOTE]
   >  If you purchased  Windows Server 2012 R2 Standard initially and exercised your downgrade rights to install one of your two virtual instances as  Windows Server Essentials, you do not need to purchase anything additional.  
   >   
   >  If you purchase  Windows Server 2012 R2 Standard through the Volume Licensing channel, you can download an ISO image and a product key for  Windows Server 2012 R2 Standard from the Volume Licensing Service Center (VLSC).  
   >   
   >  If you purchase  Windows Server 2012 R2 Standard from any other channel, you can download an ISO image and an evaluation product key for  Windows Server Essentials from the [TechNet Evaluation Center](https://technet.microsoft.com/evalcenter/jj659306.aspx). Performing the transition as described in the next step will convert the evaluation product to a fully licensed and supported product.  
  
2. Open Windows PowerShell as Administrator, and then run the following command:  
  
    **dism /online /set-edition:ServerStandard /accepteula /productkey:** *Product Key* (where *Product Key* is the product key for your copy of  Windows Server 2012 R2 Standard).  
  
    The server restarts to finish the transition process.  
  
   After the transition, the  Windows Server Essentials features remain on the server and are supported for up to 100 users and 200 devices.  
  
## See also  
  

-   [Migrate Server Data to Windows Server Essentials](Migrate-Server-Data-to-Windows-Server-Essentials.md)

-   [Migrate Server Data to Windows Server Essentials](../migrate/Migrate-Server-Data-to-Windows-Server-Essentials.md)

