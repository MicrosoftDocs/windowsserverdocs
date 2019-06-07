---
title: "Install and Configure Windows Server Essentials or Windows Server Essentials Experience"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 48ea6cd4-3955-4aaf-9236-2515a6c3e730
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Install and Configure Windows Server Essentials or Windows Server Essentials Experience

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Windows Server Essentials is an ideal first server for small businesses with up to 25 users and 50 devices. For organizations with up to 100 users and 200 devices, you can now use  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed. This topic addresses both scenarios.  
  
Windows Server Essentials Experience is a role in Windows Server 2016 that enables you to take advantage of all the features (such as Remote Web Access and PC backup) that are available to you in  Windows Server Essentials without the locks and limits that are enforced in  Windows Server Essentials. This server role is also available in  Windows Server Essentials and is enabled by default.
  
Before you install Windows Server Essentials or the Essentials Experience role, note the following limitations.  
  
|Windows Server Essentials Experience in Windows Server Essentials|Windows Server Essentials Experience in Windows Server 2016
|----|----|
|- Must be the domain controller at the root of the forest and domain, and must hold all the FSMO roles.<br /><br /> - Cannot be installed in an environment with a pre-existing Active Directory domain (however, there is a grace period of 21 days for performing migrations).|- Does not have to be a domain controller if it is installed in an environment with a pre-existing Active Directory domain.<br /><br /> - If an Active Directory domain does not exist, installing the role will create an Active Directory domain, and the server will become the domain controller at the root of the forest and domain, holding all the FSMO roles.  
|Can only be deployed into a single domain.|Can only be deployed into a single domain.  
|A read-only domain controller cannot exist in your domain.|A read-only domain controller cannot exist in your domain.

> [!NOTE]
>  To download evaluation versions of the operating systems, visit the TechNet Evaluation Center:  
>   
>  [Download Windows Server 2016](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016)  
>   
>  [Download Windows Server Essentials](https://www.microsoft.com/evalcenter/evaluate-windows-server-2016-essentials)
  
## Installation options  
 This document provides step-by-step instructions for installing and configuring Windows Server Essentials. Depending on your network environment, you have the following installation options available to you:  
  
-    Windows Server Essentials (with the Windows Server Essentials Experience role enabled by default)  
  
-    Windows Server 2016 with the Windows Server Essentials Experience role installed  
 
|Deployment environment|Description|Related section|  
|----------------------------|-----------------|---------------------|  
|New Active Directory environment|You can install Windows Server Essentials to create a new Active Directory environment.|[Deploy Windows Server Essentials to set up a new Active Directory environment](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_NewAD)|  
|Existing Active Directory environment|You can install Windows Server Essentials in an existing Active Directory environment.|[Deploy Windows Server Essentials in an existing Active Directory environment](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_ExistingAD)|  
|Virtual environment|You can deploy Windows Server Essentials as a virtual machine.|[Virtualize your environment](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_VirtualWSE)|  
|Automated deployment|You can automate deployment of Windows Server Essentials by using Windows PowerShell.|[Install and configure Windows Server Essentials by using Windows PowerShell](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_PowerShell)|  
  
## Before you begin  
 Before you begin the installation, review the following documentation:  
  
-   [Windows Server Essentials Product Overview](https://www.microsoft.com/server-cloud/windows-server-essentials/windows-server-2012-r2-essentials.aspx)  
  

-   [System Requirements for Windows Server Essentials](../get-started/system-requirements.md)   

  
##  <a name="BKMK_NewAD"></a> Deploy Windows Server Essentials to set up a new Active Directory environment  
 Windows Server Essentials provides a way for you to quickly set up an Active Directory environment and related server features.  
  
###  <a name="BKMK_WSEDeploy"></a> Deploying Windows Server Essentials  
 If you are using  Windows Server Essentials,  Windows Server Essentials Experience is already enabled. However, you must complete some steps to configure your server.  
  
##### To configure Windows Server Essentials on a physical server  
  
1. After the Windows **Welcome** page, the **Configure Windows Server Essentials Wizard** is visible on your desktop.  
  
2. Follow the instructions to complete the wizard as follows:  
  
   1.  On the **Configure Windows Server Essentials** page, click **Next**.  
  
   2.  In **Time settings**, make sure your date, time, and time zone are correct, and then click **Next**.  
  
   3.  In **Company Information**, type your company name, such as **Contoso,Ltd.**, and then click **Next**. Optionally, you can change the internal domain name and server name.  
  
   4.  In **Create network admin**, type a new administrator account name and password.  
  
       > [!NOTE]
       >  Do not use the default **Administrator** account name and password.  
  
   5.  Click **Configure**.  
  
3. The server will restart multiple times during the configuration process, and your logons will be automatic until the configuration is finished. This process takes about 20 minutes.  
  
4. On the desktop, click the Dashboard icon to start the server Dashboard. On the **Home** page, complete the **Getting Started** tasks listed on the **Setup** tab.  
  
   After you have completed the server configuration, the server that is running Windows Server Essentials will be set up as a domain controller.  
  
###  <a name="BKMK_DeployWSERole"></a> Deploying the Windows Server Essentials Experience role in Windows Server 2012 R2 Standard and Datacenter  
 You can use Server Manager to enable and configure the  Windows Server Essentials Experience role in  Windows Server 2012 R2 Standard or  Windows Server 2012 R2 Datacenter by using the following procedure.  
  
##### To deploy the Windows Server Essentials Experience role in Windows Server 2012 R2  
  
1.  Log on to your server as a local administrator.  
  
2.  Open **Server Manager**, and then click **Add Roles and Features**.  
  
3.  In **Select server roles**, select the **Windows Server Essentials Experience** role. In the dialog box, click **Add Features**, and then click **Next**.  
  
4.  In **Features**, click **Next**.  
  
5.  Review the **Windows Server Essentials Experience** role description, and then click **Next**.  
  
6.  In the pages that follow, click **Next**, and then on the confirmation page, click **Install**.  
  
7.  After the installation is complete,  Windows Server Essentials Experience should be listed as a server role in Server Manager.  
  
8.  In the flag notification area in Server Manager, click the flag, and then click **Configure Windows Server Essentials**.  
  
9. (Optional) Change the server name if needed.  
  
    > [!IMPORTANT]
    >  You cannot change the server name after you have configured Windows Server Essentials.  
  

10. Follow the wizard to configure Windows Server Essentials as described earlier in the [Deploying Windows Server Essentials](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_WSEDeploy) section.  

10. Follow the wizard to configure Windows Server Essentials as described earlier in the [Deploying Windows Server Essentials](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_WSEDeploy) section.  

  
##  <a name="BKMK_ExistingAD"></a> Deploy Windows Server Essentials in an existing Active Directory environment  
 You can also deploy Windows Server Essentials if your organization already has an existing Active Directory environment. In addition, you can choose if you want to deploy Windows Server Essentials as a domain controller.  
  
> [!IMPORTANT]
>  This option is only available if you deploy the  Windows Server Essentials Experience role in  Windows Server 2012 R2 Standard or  Windows Server 2012 R2 Datacenter.  
  
#### To deploy Windows Server Essentials in an existing Active Directory environment  
  
1.  (Optional) Change the server name if needed.  
  
    > [!IMPORTANT]
    >  You cannot change the server name after you have configured Windows Server Essentials.  
  
2.  Join your server running Windows Server Essentials to an existing domain as follows:  
  
    1.  If you want this server to be a domain controller, set up the server as a replica domain controller.  
  
    2.  If you do not want this server to be a domain controller, join this server to your domain by using the Windows native tools.  
  
3.  Restart your server and log on to the server as a domain administrator.  
  
4.  Open Server Manager, and then click **Add Roles and Features**.  
  
5.  On the pages that follow, click **Next**.  
  
6.  In **Select Server Roles**, select **Windows Server Essentials Experience**. In the dialog box, click **Add Features**, and then click **Next**.  
  
7.  In **Features**, click **Next**.  
  
8.  Review the **Windows Server Essentials Experience** description, and then click **Next**.  
  
9. In the pages that follow, click **Next**, and then on the confirmation page, click **Install**.  
  
10. After the installation is complete,  Windows Server Essentials Experience will be listed as a server role in Server Manager.  
  
11. In the flag notification area in **Server Manager**, click the flag, and then click **Configure Windows Server Essentials**.  
  
12. Follow the wizard to configure Windows Server Essentials. Depending on your Active Directory configuration, you will be informed whether you are configuring Windows Server Essentials on a domain controller or as a domain member. Click **Configure** to begin the configuration. The configuration process takes approximately 10 minutes to complete.  
  
##  <a name="BKMK_VirtualWSE"></a> Virtualize your environment  
  Windows Server Essentials,   Windows Server 2012 R2 Standard, and  Windows Server 2012 R2 Datacenter can be run as virtual machines. You run virtual machines by using the Hyper-V management tools on a server running Hyper-V. From a licensing perspective,  Windows Server Essentials allows you to set up the Hyper-V role and virtualize your environment. The license allows you to set up another guest operating system that is running  Windows Server Essentials. Depending on your system provider „¢s configuration,  Windows Server Essentials enables you to set up a virtualized environment seamlessly.  
  
#### To deploy Windows Server Essentials as a virtual machine  
  
1.  After the Windows Welcome page (depending on your system provider „¢s configuration), the **Before you begin** page provides an option to set up Windows Server Essentials as a virtual instance or on physical hardware. The availability of these options is predefined by your system provider and both options may not always be available. To install  Windows Server Essentials as a virtual machine, in **Install Windows Server Essentials**, select **Install as virtual instance**, and then click **Configure**.  
  
2.  The wizard will provision a virtual machine which takes about five minutes.  
  

3.  Next, configure Windows Server Essentials as described earlier in the [Deploying Windows Server Essentials](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_WSEDeploy) section.  

3.  Next, configure Windows Server Essentials as described earlier in the [Deploying Windows Server Essentials](Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md#BKMK_WSEDeploy) section.  

  
##  <a name="BKMK_PowerShell"></a> Install and configure Windows Server Essentials by using Windows PowerShell  
 You can automate the installation of Windows Server Essentials by using Windows PowerShell cmdlets.  
  
#### To install Windows Server Essentials by using Windows PowerShell  
  
1.  Open the Windows PowerShell console from an elevated command prompt.  
  
2.  Install the  Windows Server Essentials Experience role by using the following command:  
  
    ```  
    Add-WindowsFeature ServerEssentialsRole  
    ```  
  
3.  Run `Get-Help Start-WssConfigurationService`.  
  
    1.  Run the following command to start the configuration to set up Windows Server Essentials as a domain controller:  
  
        ```  
        Start-WssConfigurationService -CompanyName "ContosoTest" -DNSName "ContosoTest.com" -NetBiosName "ContosoTest" -ComputerName "YourServerName  œNewAdminCredential $cred  
        ```  
  
    2.  Run the following command to start the configuration to set up Windows Server Essentials as an existing domain member. You must be a member of the Enterprise Admin group and Domain Admin group in Active Directory to perform this task:  
  
        ```  
        Start-WssConfigurationService  œCredential <Your Credential>  
  
        ```  
  
4.  Monitor the progress of the installation by using the following commands:  
  
    -   To have installation status displayed on the progress bar, run `Get-WssConfigurationStatus  œShowProgress`.  
  
    -   To get the immediate progress without the progress bar, run `Get-WssConfigurationStatus`.  
  
## See also  
  
-   [What's New in Windows Server Essentials](../get-started/what-s-new.md)  
  
-   [Install Windows Server Essentials](Install-Windows-Server-Essentials.md)  
  
-   [Get Started with Windows Server Essentials](../get-started/get-started.md)
