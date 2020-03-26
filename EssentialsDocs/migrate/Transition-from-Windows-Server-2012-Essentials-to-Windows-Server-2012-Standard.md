---
title: "Transition from Windows Server Essentials to Windows Server 2012 Standard"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 51bcf124-c215-4e9d-9fa8-a90fa2c2fa22
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Transition from Windows Server Essentials to Windows Server 2012 Standard

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

 Windows Server® 2012 Essentials supports up to 25 users and 50 devices. When your business needs exceed the limit, you can perform an in-place license transition from  Windows Server Essentials to  Windows Server 2012 Standard to remain license compliant.  
  
## How the transition affects user and device limits  
 After you transition to  Windows Server 2012 Standard, the user account and devices limits are removed, but the features that are unique to Windows Server Essentials (such as the Dashboard, Remote Web Access, and client computer backup), still remain available. However, technical limitations for these features support a maximum of 75 user accounts and 75 devices. If it becomes necessary to add more than 75 user accounts or devices, you should turn off the  Windows Server Essentials features and use the  Windows Server 2012 Standard native tools to manage user accounts and devices.  
  
> [!IMPORTANT]
>   Windows Server 2012 Standard requires a Client Access License (CAL) for each user or device in your environment. This is different from  Windows Server Essentials, which does not use the CAL model and does not come with any CALs.  When transitioning from  Windows Server Essentials to  Windows Server 2012 Standard, you will need to purchase the appropriate number and type of CALs for your environment (most customers purchase user CALs).  
  
## Before the transition  
  
-   Before transitioning from  Windows Server Essentials to  Windows Server 2012 Standard, you should fully back up the server data.  
  
    > [!IMPORTANT]
    >  Without a full backup of the server, you cannot restore the server to the state that it was in prior to the transition.  
  
-   In addition, make sure that you read and understand the End User License Agreement (EULA) for  Windows Server 2012 Standard. To view the EULA:  
  
    1.  Open a command window as Administrator.  
  
    2.  Run the following command:  
  
         **dism /online /set-edition:ServerStandard /geteula: eula path**  
  
         Where **eula path** represents the location to which you want to save the EULA file. For example;  C:\ws8std_eula.rtf.  Be sure to use .rtf as the file name extension.  
  
    3.  Open the location where you saved the file, and then double-click the file to open it.  
  
## Transition to  Windows Server 2012 Standard  
 After you have decided to transition from  Windows Server Essentials to  Windows Server 2012 Standard, complete these two steps:  
  
1. Purchase a license for  Windows Server 2012 Standard and the appropriate number of user and/or device Client Access Licenses for your environment.  
  
    You can purchase a license for  Windows Server 2012 Standard from a Retail Outlet, a Distributor, or with the help of a [Microsoft Partner](https://pinpoint.microsoft.com/SelectCulture.aspx).  
  
   > [!NOTE]
   >  If you purchased  Windows Server 2012 Standard initially and exercised your downgrade rights to install one of your two virtual instances as  Windows Server Essentials, you do not need to purchase anything additional.  
   >   
   >  If you purchase  Windows Server 2012 Standard through the Volume Licensing channel, you can download an ISO image and a product key for  Windows Server 2012 Standard from the Volume Licensing Service Center (VLSC).  
   >   
   >  If you purchase  Windows Server 2012 Standard from all other channels can download an ISO image and an evaluation product key for  Windows Server Essentials from the [TechNet Evaluation Center](https://technet.microsoft.com/evalcenter/jj659306.aspx). Performing the transition as described in the next step will convert the evaluation product to a fully licensed and supported product.  
  
2. Open Windows PowerShell as Administrator, and then run the following command.  
  
    **dism /online /set-edition:ServerStandard /accepteula /productkey:** *Product Key*  
  
    Where *Product Key* is the product key for your copy of  Windows Server 2012 Standard.  
  
    The server restarts to finish the transition process.  
  
   After the transition, the  Windows Server Essentials features remain on the server and are supported for up to 75 users and 75 devices. If you exceed either of these limits, you should use the  Windows Server 2012 Standard native tools to manage user accounts and devices.  
  
   Additionally, after you transition to  Windows Server 2012 Standard, the Media features of  Windows Server Essentials are no longer available. This includes the Media features of Remote Web Access, and the Media Settings on the Dashboard.  
  
## Turn off  Windows Server Essentials features  
 If you no longer need the  Windows Server Essentials Dashboard or other value-add features to manage the server, you can turn the features off and remove them from your server.  
  
 The **Turn off Windows Server Essentials Features Wizard** helps you uninstall the features. It also cleans the server of files that were created by the  Windows Server Essentials server software.  Some cleaning operations are performed immediately, while others are initiated after the server restarts.  
  
 The **Turn off Windows Server Essentials Features Wizard** requires that you manually uninstall all add-ins before you can complete the wizard. To view a list of installed add-ins, open the Application page in the Dashboard. The wizard will alert you if it detects installed add-ins, and prompts you to uninstall them.  
  
 The **Turn off Windows Server Essentials Features Wizard** allows you to choose whether to keep backup files for client computers after turning off the  Windows Server Essentials features.  
  
 There are two ways to run the **Turn off Windows Server Essentials Features Wizard** from the Dashboard:  
  
#### From the alert  
  
1.  From the Dashboard, open the Alert Viewer.  
  
2.  In Organize list, select the alert that reports information about turning off  Windows Server Essentials features after transition.  
  
3.  In the alert, click **Turn off Windows Server Essentials Features**.  
  
#### From the Get Help and Support pane  
  
1. On the Home page, Click Get Help and Support.  
  
2. Click **Turn off Windows Server Essentials Features Wizard**.  
  
   It is possible that some tasks performed by the **Turn off Windows Server Essentials Features Wizard** will not complete successfully. In some cases, this can prevent the Dashboard from running. If this occurs, you can start the wizard manually by running the file:  
  
   **%systemdrive%\Program Files\Windows Server\Bin\TurnOffFeaturesWizard.exe**  
  
## See also  
  

-   [Transition to Windows Server 2012 R2 Standard](Transition-from-Windows-Server-2012-R2-Essentials-to-Windows-Server-2012-R2-Standard.md)  
  
-   [Migrate Server Data to Windows Server Essentials](Migrate-Server-Data-to-Windows-Server-Essentials.md)

-   [Transition to Windows Server 2012 R2 Standard](../migrate/Transition-from-Windows-Server-2012-R2-Essentials-to-Windows-Server-2012-R2-Standard.md)  
  
-   [Migrate Server Data to Windows Server Essentials](../migrate/Migrate-Server-Data-to-Windows-Server-Essentials.md)

