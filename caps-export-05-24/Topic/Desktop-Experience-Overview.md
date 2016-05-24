---
title: Desktop Experience Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1e5b724e-1f99-476b-a98d-16fc4ee0c767
author: jaimeo
---
# Desktop Experience Overview
This topic includes information about Graphical Management Tools and Infrastructure, Server Graphical Shell, Desktop Experience, and Media Foundation.  
  
Graphical Management Tools and Infrastructure is the set of features that comprises the difference between a Server Core installation and the Minimal Server Interface option of a Full server installation. Uninstalling this feature will convert a Full server installation to a Server Core installation.  
  
Server Graphical Shell is the same user interface that is installed by default when you choose the “Server with GUI” installation option during Setup. To decrease the servicing requirements of your server while still being able to use Microsoft Management Console \(MMC\) locally, you can uninstall the Server Graphical Shell using Server Manager, which leaves you with the Minimal Server Interface. The Minimal Server Interface requires Graphical Management Tools and Infrastructure to be installed. For more information about the server installation options, what is included with each, and how to switch between them \(as well as information about the Minimal Server Interface and Features on Demand\), see [Windows Server Installation Options](http://go.microsoft.com/fwlink/?LinkId=242140).  
  
The Desktop Experience feature allows you to install a variety of applications and features that are provided in the Windows client operating system on your server that is running a Windows Server operating system. If you are running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the following [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] features are installed when you install Desktop Experience:  
  
-   Windows Media Player  
  
-   Video for Windows \(AVI support\)  
  
-   Windows SideShow  
  
-   Disk Cleanup  
  
-   Sync Center  
  
-   Sound Recorder  
  
-   Character Map  
  
-   Snipping Tool  
  
-   Support for desktop apps  
  
-   Windows Store  
  
If you are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the following [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] features are installed when you install Desktop Experience:  
  
-   Windows Media Player  
  
-   Video for Windows \(AVI support\)  
  
-   Windows SideShow  
  
-   Disk Cleanup  
  
-   Sync Center  
  
-   Sound Recorder  
  
-   Character Map  
  
-   Snipping Tool  
  
-   Support for desktop apps  
  
-   Windows Store  
  
-   PC settings \(adds **Change PC settings** to the Settings charm\)  
  
-   The ability to play a slide show on your lock screen  
  
-   Integrated search \(searches through the Search charm integrate results from the local computer and the Internet through Bing\)  
  
> [!IMPORTANT]  
> When you install Desktop Experience in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the integrated search is on by default. This feature sends information to Microsoft. You can turn off the integrated search feature with the following steps:  
  
### To turn off integrated search  
  
1.  Open the Windows charm bar \(WINDOWS\+C\)  
  
2.  Click **Settings**, click **Change PC Settings**, and then click **Search & Apps**.  
  
3.  In the **Use Bing to search online** section, move the slider to **Off**. Alternately, in the **Your Search Experience** section, select **Don’t get personalized results from Bing**.  
  
> [!NOTE]  
> The Desktop Experience feature requires that you also install the Graphical Management Tools and Infrastructure and Server Graphical Shell features.  
  
Media Foundation, which includes Windows Media Foundation, the Windows Media Format SDK, and a server subset of DirectShow, provides the infrastructure required for applications and services to transcode, analyze, and generate thumbnails for media files. You can install Media Foundation separately with Server Manager—but if you install the Desktop Experience feature, you must install the Media Foundation feature as well.  
  
## Requirements for running Desktop Experience, Media Foundation, or Server Graphical Shell  
There are no special hardware or software requirements for using these features.  
  
> [!NOTE]  
> The following server features and roles require the Server Graphical Shell—they will automatically be disabled if you uninstall the Server Graphical Shell:  
>   
> -   Fax Server  
> -   Internet Printing user interface  
> -   Remote Desktop Session Host  
> -   Windows Deployment Services  
>   
> Remote Desktop for Administration is supported with or without the Server Graphical Shell.  
>   
> There is only partial functionality if the Server Graphical Shell is not installed:  
>   
> -   Help content is not available.  
> -   In Event Viewer, the Details view is not available.  
> -   Graphical management tools for Windows Firewall are not available.  
> -   BitLocker Drive Encryption must be managed from the command line.  
  
## Running Desktop Experience, Media Foundation, or Server Graphical Shell  
  
### How do I deploy and configure these features by using Windows PowerShell?  
To install Graphical Management Tools and Infrastructure with Windows PowerShell, use the following commands:  
  
<pre>Import-Module ServerManager  
Install-WindowsFeature Server-Gui-Mgmt-Infra</pre>  
  
To install the Server Graphical Shell with Windows PowerShell, use the following commands:  
  
<pre>Import-Module ServerManager  
Install-WindowsFeature Server-Gui-Shell</pre>  
  
To install Desktop Experience with Windows PowerShell, use the following commands:  
  
<pre>Import-Module ServerManager  
Install-WindowsFeature Desktop-Experience</pre>  
  
To install Media Foundation with Windows PowerShell, use the following commands:  
  
<pre>Import-Module ServerManager  
Install-WindowsFeature Server-Media-Foundation</pre>  
  
To uninstall the Server Graphical Shell with Windows PowerShell, use the following commands:  
  
<pre>Import-Module ServerManager  
Uninstall-WindowsFeature Server-Gui-Shell</pre>  
  
### How do I deploy and configure these features in a multiserver environment?  
All of these features are relevant to a single server at a time.  
  
### Can I run these features on virtual machines?  
These features function normally on virtual machines with no changes required.  
  
### Can I run these features in a clustered environment?  
It is possible to run any of these features in a clustered environment, but it is not recommended.  
  
### Security considerations for running these features  
After installation, these features are designed to be secure by default.  
  
### Special considerations for managing these features on the Server Core installation option  
These features are not supported on Server Core installations.  
  
### See also  
  
-   [Server Roles and Technologies](http://technet.microsoft.com/library/hh831669.aspx)  
  
