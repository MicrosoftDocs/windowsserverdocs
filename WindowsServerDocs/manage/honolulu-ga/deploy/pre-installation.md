---
title: Windows Admin Center Pre-Installation Tasks
description: "Windows Admin Center Pre-Installation Tasks"
ms.technology: Windows Admin Center
ms.topic: article
author: nwashburn-ms
ms.author: niwashbu
ms.manager: samli
ms.date: 03/30/2018
---


# Windows Admin Center Pre-Installation Tasks

[Content goes here]

[TODO:legacy-content-begin]

## Supported operating systems ##

You can *install* Honolulu on the following Windows operating systems:

| **Version** | **Installation Mode** |
|-------------|-----------------------|
|Windows 10   | Desktop mode |
|Windows Server, version 1709 | Gateway mode |
|Windows Server 2016 | Gateway mode |

**Desktop Mode:** Connect to the Honolulu gateway from the same computer on which it's installed (i.e. `http://localhost:[port]`)

**Gateway Mode:** Connect to the Honolulu  gateway from a client browser on a different machine (i.e. `https://servername`)

## Prerequisite: Install WMF version 5.0 or higher on Windows Server 2012 and 2012 R2 ##

Project Honolulu requires PowerShell features that are not included in Windows Server 2012 and 2012 R2. If you will manage Windows Server 2012 or 2012 R2 with Honolulu, you will need to install WMF version 5.0 or higher on those servers. 

Type `$PSVersiontable` in PowerShell to verify that WMF is installed,
and that the version is 5.0 or higher. 

If it is not installed, you can [download and install WMF 5.1](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

# Configure Microsoft Hyper-V Server for management by Project Honolulu

>Applies To: Microsoft Hyper-V Server 2016 and Microsoft Hyper-V Server 2012 R2

If you are going to manage Microsoft Hyper-V Server, there are some Server roles you'll need to enable before you can do so.

## Configure Microsoft Hyper-V Server 2016 for management by Honolulu

**To manage Microsoft Hyper-V Server 2016 with Honolulu**

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

![](../../media/honolulu/c6c30b812d96afcc1edcdb6f52f0e13c.png)

### Step 3: Enable Hyper-V Module for PowerShell ##

**To enable Hyper-V Module for PowerShell features**

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![](../../media/honolulu/7ab0999602b7083733525bd0c1ba2747.png)

## Configure Microsoft Hyper-V Server 2012 R2 for management by Honolulu 

**To manage Microsoft Hyper-V Server 2012 R2 with Honolulu**

1. Install Windows Management Framework (WMF) version 5.0 or higher
2. Enable Remote Management
3. Enable File Server Role
4. Enable Hyper-V Module for PowerShell

### Step 1: Install Windows Management Framework 5.1 ##

Project Honolulu requires PowerShell features that are not included in Microsoft Hyper-V Server 2012 R2. If you  will manage, Microsoft Hyper-V Server 2012 R2 with Honolulu, you will need to install WMF version 5.0 or higher on those servers.

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

![](../../media/honolulu/c6c30b812d96afcc1edcdb6f52f0e13c.png)

### Step 4: Enable Hyper-V Module for PowerShell ##

**To enable Hyper-V Module for PowerShell features**

1.  Click **Roles and Features** in the **Tools** menu.
2.  In **Roles and Features**, find **Remote Server Administration Tools** and check **Role Administration Tools** and **Hyper-V Module for PowerShell**:

![](../../media/honolulu/7ab0999602b7083733525bd0c1ba2747.png)

[TODO:legacy-content-end]
