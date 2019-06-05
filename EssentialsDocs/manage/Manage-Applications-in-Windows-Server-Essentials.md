---
title: "Manage Applications in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ae89c46a-0afd-4858-9150-ec97650f45a4
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Manage Applications in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
 
 The server Dashboard in Windows Server Essentials and  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed makes it possible to perform common administrative tasks. To perform these tasks, see the following:  
  
-   [Application management tasks in the Dashboard](Manage-Applications-in-Windows-Server-Essentials.md#BKMK_1)  
  
-   [Install or remove add-ins using the Dashboard](Manage-Applications-in-Windows-Server-Essentials.md#BKMK_2)  
  
##  <a name="BKMK_1"></a> Application management tasks in the Dashboard  
 The **Applications** management page of the Dashboard provides:  
  
- A list of installed add-ins, which displays:  
  
  -   The name of the online service or add-in  
  
  -   The update status of the add-in  
  
  -   The subscription status of the add-in  
  
  -   The name of the company or publisher that is making the add-in available  
  
- A tasks pane that includes a set of tasks for managing a selected add-in  
  
- A list of add-ins that are available to download and install from Microsoft Pinpoint  
  
  The following table describes the various add-in management tasks that are available in the server Dashboard. Some of the tasks are add-in specific, so they are only visible when you select an add-in in the list.  
  
|Task name|Description|  
|---------------|-----------------|  
|Remove the add-in|Removes the selected add-in from the server and from all other computers in the network.|  
|Install the add-in on network computers|Helps you schedule installation of the selected add-in on all other computers in the network.|  
|Get help with the add-in|Opens your Internet browser to a website from which you can search for solutions to problems and learn more about a selected add-in.|  
|Update the add-in|Helps you download and install updates for the add-ins that are installed on your server and network computers.|  
|Renew the add-in subscription|Opens your Internet browser to a website from which you can renew your add-in subscription.|  
|Read the privacy statement for the add-in|Opens your Internet browser to a website from which you can view the privacy statement.|  
|How do I install or remove add-ins?|Opens your Internet browser to a web page that displays the subject Help topic.|  
  
##  <a name="BKMK_2"></a> Install or remove add-ins using the Dashboard  
 An add-in is a software application that provides additional features and functionality for your server. A growing number of add-ins are available from Microsoft and other Independent Software Vendors (ISVs).  
  
 Before you can take advantage of the extended functionality that an add-in provides, you must first install the add-in on the server.  
  
#### To install an add-in from Microsoft Pinpoint  
  
1.  In the server Dashboard, click **Applications**, and then click the **Microsoft Pinpoint** tab.  A list of available add-ins appear.  
  
2.  Click the add-in that you want to install. The add-in information page appears.  
  
3.  On the add-in information page, click Download, and follow the onscreen instructions to download and install the add-in.  
  
4.  Follow the instructions in the wizard to install the add-in.  
  
5.  When the installation is finished, restart the Dashboard, open the **Applications** page of the server Dashboard, and verify that the add-in appears in the list view.  
  
#### To install an add-in from another provider  
  
1.  Open Windows Explorer and browse to the location of the add-in installation file.  
  
2.  Double-click the file to run the installation wizard.  
  
3.  Follow the instructions in the wizard to install the add-in.  
  
4.  When the installation is finished, restart the Dashboard, open the **Applications** page, and then verify that the add-in appears in the list view.  
  
#### To remove an add-in  
  
1.  Open the server Dashboard.  
  
2.  Click the **Applications** tab.  
  
3.  On the **Add-ins** tab, select the add-in that you want to remove, and then click **Remove the add-in**.  
  
4.  In the **Remove Add-in** window, click **Remove**.  
  
    > [!NOTE]
    >  You might need to restart the Dashboard to completely remove the add-in.  
  
## See also  
  
-   [Dashboard Overview](Overview-of-the-Dashboard-in-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
