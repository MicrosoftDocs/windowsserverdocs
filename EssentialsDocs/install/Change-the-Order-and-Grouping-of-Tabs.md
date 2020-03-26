---
title: "Change the Order and Grouping of Tabs"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 79a417fd-1b3e-47ab-ae33-bb1faf95c86d
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Change the Order and Grouping of Tabs

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can change the order of tabs in the Dashboard so that your tab is the first one (on the left) in the row of tabs. To do this you add an entry to the registry. You can also affect the grouping of tabs by adding entries to the registry. The order of the tabs can be your main tab followed by Microsoft built-in tabs, followed by any of your additional tabs, and then followed by third-party tabs.  
  
## Change the order of the tabs in the Dashboard  
 You must add the identifier of the add-in that displays your tab to the registry to define the order.  
  
#### To display your tab first in the list of tabs  
  
1.  On the reference computer, click **Start**, enter **regedit**, and then press **Enter**.  
  
2.  In the left pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, and then expand **Windows Server**. If the **OEM** key does not exist, you must complete the following steps to create it:  
  
    1.  Right-click **Windows Server**, point to **New**, and then click **Key**.  
  
    2.  Type **OEM** for the name of the key.  
  
3.  Right-click **OEM**, point to **New**, and then click **String Value**.  
  
4.  Type **DashboardMainTabID** as the string name, and then press **Enter**.  
  
5.  Right-click the new string in the right pane, and then click **Modify**.  
  
6.  Type the GUID that was defined for the top-level tab, and then press **Enter**.  
  
     For more information about creating and identifying top-level tabs, see [Create a Top-Level Tab](https://msdn.microsoft.com/library/gg513957) in the Windows Server Solutions SDK.  
  
7.  Save the changes to the registry.  
  
8.  You must also include the GUID for your main top-level tab in the list of identifiers for grouping tabs. To do this, perform the steps listed in **Change the grouping of tabs in the Dashboard**.  
  
## Change the grouping of tabs in the Dashboard  
 You can ensure that your tabs are grouped together and included in the list of built-in Microsoft tabs, by adding the identifiers to the registry.  
  
#### To change the grouping of tabs  
  
1.  If regedit is not open, click **Start**, enter **regedit**, and then press **Enter**.  
  
2.  In the left pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, and then expand **Windows Server**.  
  
3.  Right-click **OEM**, point to **New**, and then click **Key**.  
  
4.  Type **DashboardAddins** as the key name, and then press **Enter**.  
  
5.  Right-click **DashboardAddins**, point to **New**, and then click **String Value**.  
  
6.  Type the GUID identifier for your tab as the string name. A value is not needed.  
  
7.  Repeat steps 5 and 6 for each of your tabs and sub-tabs.  
  
8.  Save the registry changes.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)