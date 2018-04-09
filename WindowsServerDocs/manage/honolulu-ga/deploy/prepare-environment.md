---
title: Prepare your environment for Windows Admin Center
description: Prepare your environment for Windows Admin Center (Project Honolulu)
ms.technology: manage
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.date: 04/05/2018
ms.localizationpriority: low
ms.prod: windows-server-threshold
---

# Prepare your environment for Windows Admin Center

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

There are some Server versions that need additional preparation before they are ready to manage with Windows Admin Center:

- [Windows Server 2012 and 2012 R2](#Prepare2012)
- [Microsoft Hyper-V Server 2016](#PrepareHyperV2016)
- [Microsoft Hyper-V Server 2012 R2](#PrepareHyperV2012R2)

## <a id="Prepare2012"></a>Prepare Windows Server 2012 and 2012 R2

>Applies To: Windows Server 2012 and Windows Server 2012 R2

### Install WMF version 5.0 or higher 

Windows Admin Center requires PowerShell features that are not included by default in Windows Server 2012 and 2012 R2. To manage Windows Server 2012 or 2012 R2 with Windows Admin Center, you will need to install WMF version 5.0 or higher on those servers. 

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.0 or higher. 

If it is not installed, you can [download and install WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

## <a id="PrepareHyperV2016"></a>Prepare Microsoft Hyper-V Server 2016

>Applies To: Microsoft Hyper-V Server 2016

To manage Microsoft Hyper-V Server 2016 with Windows Admin Center, there are some Server roles you'll need to enable before you can do so.

### To manage Microsoft Hyper-V Server 2016 with Windows Admin Center:

1. Enable Remote Management.
2. Enable File Server Role.
3. Enable Hyper-V Module for PowerShell.

### **Step 1:** Enable Remote Management

To enable remote management in Hyper-V Server:

1. Log into Hyper-V Server.
2. At the **Server Configuration** (SCONFIG) tool, type **4** to configure remote management.
3. Type **1** to enable Remote Management.
4. Type **4** to return to the main menu.

### **Step 2:** Enable File Server Role

To enable File Server Role for basic file sharing and remote management:

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **File and Storage Services**, and check **File and iSCSI Services** and **File Server**:

![](../../media/honolulu/c6c30b812d96afcc1edcdb6f52f0e13c.png)

### **Step 3:** Enable Hyper-V Module for PowerShell

To enable Hyper-V Module for PowerShell features:

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![](../../media/honolulu/7ab0999602b7083733525bd0c1ba2747.png)

Microsoft Hyper-V Server 2016 is now ready for management with Windows Admin Center.

## <a id="PrepareHyperV2012R2"></a>Prepare Microsoft Hyper-V Server 2012 R2

>Applies To: Microsoft Hyper-V Server 2012 R2

To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center, there are some Server roles you'll need to enable before you can do so.  In addition, you will need to install WMF verion 5.0 or higher.

### To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center:

1. Install Windows Management Framework (WMF) version 5.0 or higher
2. Enable Remote Management
3. Enable File Server Role
4. Enable Hyper-V Module for PowerShell

### **Step 1:** Install Windows Management Framework 5.1

Windows Admin Center requires PowerShell features that are not included by default in Microsoft Hyper-V Server 2012 R2. To manage Microsoft Hyper-V Server 2012 R2 with Windows Admin Center, you will need to install WMF version 5.0 or higher.

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.0 or higher. 

If it is not installed, you can [download WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

### **Step 2:** Enable Remote Management 

To enable Hyper-V Server remote management:

1. Log into Hyper-V Server.
2. At the **Server Configuration** (SCONFIG) tool, type **4** to configure remote management.
3. Type **1** to enable remote management.
4. Type **4** to return to the main menu.

### Step 3: Enable File Server Role

To enable File Server Role for basic file sharing and remote management:

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **File and Storage Services** and check **File and iSCSI Services** and **File Server**:

![](../../media/honolulu/c6c30b812d96afcc1edcdb6f52f0e13c.png)

### Step 4: Enable Hyper-V Module for PowerShell ##

To enable Hyper-V Module for PowerShell features:

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![](../../media/honolulu/7ab0999602b7083733525bd0c1ba2747.png)

Microsoft Hyper-V Server 2012 R2 is now ready for management with Windows Admin Center.
