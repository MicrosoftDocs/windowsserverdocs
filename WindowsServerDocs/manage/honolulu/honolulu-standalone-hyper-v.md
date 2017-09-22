---
title: Configure Microsoft Hyper-V Server for management by Project Honolulu
description: "How to Configure Microsoft Hyper-V Server (standalone) to be managed by Project Honolulu"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: Honolulu
ms.tgt_pltfrm: na
ms.topic:
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 09/21/2017
---
# Configure Microsoft Hyper-V Server for management by Project Honolulu

>Applies To: Microsoft Hyper-V Server 2016 and Microsoft Hyper-V Server 2012 R2

If you are going to manage the standalone version of Windows Microsoft Hyper-V Server, there are some Server roles you'll need to enable before you can do so.

## Configure Windows Server 2016 standalone Hyper-V Server for management by Honolulu

**To manage Windows Server 2016 Hyper-V with Honolulu**

1. Enable Remote Management.
2. Enable File Server Role.
3. Enable Hyper-V Module for PowerShell.

### Step 1: Enable Remote Management

**To enable remote management in Hyper-V Server**

1. Log into Hyper-V Server.
2. At the **Server Configuration** (SCONFIG) tool, type **4** to configure remote management.
3. Type **1** to enable Remote Management.
4. Type **4** to return to the main menu.

### Step 2: Enable File Server Role

**To enable File Server Role for basic file sharing and remote management**

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **File and Storage Services**, and check **File and iSCSI Services** and **File Server**:

![](../media/honolulu/c6c30b812d96afcc1edcdb6f52f0e13c.png)

### Step 3: Enable Hyper-V Module for PowerShell ##

**To enable Hyper-V Module for PowerShell features**

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![](../media/honolulu/7ab0999602b7083733525bd0c1ba2747.png)

## Configure Windows Server 2012 R2 standalone Hyper-V Server for management by Honolulu 

**To manage Windows Server 2012 R2 Hyper-V with Honolulu**

1. Install Windows Management Framework (WMF) version 5.0 or higher
2. Enable Remote Management
3. Enable File Server Role
4. Enable Hyper-V Module for PowerShell

### Step 1: Install Windows Management Framework 5.1 ##

Project Honolulu requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you install on, or will manage, Windows Server 2012 or 2012 R2 with Honolulu, you will need to install WMF version 5.0 or higher on those servers.

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.0 or higher. 

If it is not installed, you can [download WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

### Step 2: Enable Remote Management 

**To enable Hyper-V Server remote management**

1. Log into Hyper-V Server.
2. At the **Server Configuration** (SCONFIG) tool, type **4** to configure remote management.
3. Type **1** to enable remote management.
4. Type **4** to return to the main menu.

### Step 3: Enable File Server Role

**To enable File Server Role for basic file sharing and remote management**

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **File and Storage Services** and check **File and iSCSI Services** and **File Server**:

![](../media/honolulu/c6c30b812d96afcc1edcdb6f52f0e13c.png)

### Step 4: Enable Hyper-V Module for PowerShell ##

**To enable Hyper-V Module for PowerShell features**

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![](../media/honolulu/7ab0999602b7083733525bd0c1ba2747.png)



