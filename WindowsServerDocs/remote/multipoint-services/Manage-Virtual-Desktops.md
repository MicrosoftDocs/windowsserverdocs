---
title: Manage Virtual Desktops
description: Learn how to manage virtual desktops (VDI) in MultiPoint Services
ms.custom: na
ms.prod: windows-server
ms.technology: multipoint-services
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fa9ac0ed-47cb-4811-91ff-4fcb62d7858b
author: lizap
manager: dongill
ms.author: elizapo
ms.date: 08/04/2016
---
# Manage Virtual Desktops
Single computer VDI allows you to configure each *local* MultiPoint Services station to connect to a Windows 10 Enterprise guest operating system running in a Hyper-V virtual machine (VM) on the same MultiPoint Services computer as the station. These virtual desktop stations can be customized with application which cannot be installed on a Windows server version.  
  
## Enable the virtual desktop feature  
  
1.  Open MultiPoint Manager, and then click the **Virtual Desktops** tab.  
  
2.  Under **VDI Tasks**, click **Create virtual desktop**, and then browse your Windows 10 Enterprise .iso or VHD.  
  
The system is restarted, which could take several minutes.  
  
## Create a virtual desktop template  
  
1.  Open MultiPoint Manager, and then click the **Virtual Desktops** tab.  
  
2.  Under **VDI Tasks**, click **Create virtual desktop**, and then browse to your Windows 10 Enterprise .iso or VHD.  
  
    If using the DVD, the program automatically finds the Windows 10 Enterprise .wim file. Otherwise, click **Browse**, and then navigate to the Windows 10 Enterprise .iso or VHD.  
  
    Modify the prefix if desired. It will default to the host computer name.  
  
    > [!NOTE]  
    > The prefix is used to name the template and the virtual desktop stations. The template is named prefix \-t. The virtual desktop stations will be named prefix \-*n*, where *n* is the station ID.  
  
4.  Enter a name and password for the local administrator account that will be used to log on to all virtual station desktops that are created from the template, and then click **OK**.  
  
    The template creation takes several minutes to complete.  
      
    Next, learn how to customize the virtual desk template.  
      
    > [!NOTE]  
    > If the MultiPoint server is domain-joined, the dialog populates an additional field which allows you to say whether the virtual machines that were created from the template should be joined to a domain.   
  
## Import a virtual desktop template  
In the case where you have created a virtual desktop template on another MultiPoint server, you can import that template using the following steps.  

1.	Open MultiPoint Manager, and then click the **Virtual Desktops** tab.  
  
2.	Under the VDI tasks, click **Import Virtual desktop template**.  
  
3.	Locate the template and define path and prefix for the imported template.  
  
## Customize the virtual desktop template  
After you have created the virtual desktop template, you can customize it with applications, software updates and configure system settings.   

1. Open MultiPoint Manager, and then click the **Virtual Desktops** tab.  
2. Choose the virtual desktop template, and then click **Customize virtual desktop template**.  
The template opens in a separate window, and additional instructions are presented that highlight the most important steps for customizing the virtual template. Carefully review those instructions.  
  
## Create virtual desktop stations  
  
1.  Open MultiPoint Manager in station mode, and then click the **Virtual Desktops** tab.  
  
    > [!NOTE]  
    > If the MultiPoint Services system is not running in station mode, restart it before completing this procedure.  
  
2.  Select the virtual desktop template in the left\-hand pane. It is named <prefix –t>.  
  
3.  Under template Tasks, click **Create virtual desktop stations**, and then click **OK**.  
  
    The virtual desktop station creation process takes several minutes.  
  
    > [!NOTE]  
    > If any of the local stations are currently connected to a session\-based virtual desktop, you must log off of those stations in order for them to connect to one of the newly created virtual desktop stations.  
  
### Validate the newly created customized virtual station desktops  
  
You can validate your customized virtual station desktops by logging on to one or more of the virtual desktop stations using either a local administrator account or a domain account, and then verify that the new VM\-based virtual desktops are working properly.  
  
## Disable Virtual Desktops  
  
When disabling virtual desktops the Hyper-V feature will be turned off. All users will be logged off and the system will be restarted. All virtual stations are assigned to MultiPoint local sessions after restart of the system.  

1. Open MultiPoint Manager in station mode, and then click the **Virtual Desktops** tab.  
  
2. Under the VDI Tasks click **Disable virtual desktops**. 