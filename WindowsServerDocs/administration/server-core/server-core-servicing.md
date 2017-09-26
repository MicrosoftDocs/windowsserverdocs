---
title: Servicing Server Core
description: Learn how to service a Server Core installation of Windows Server
ms.prod: windows-server-threshold
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 09/18/2017
---
# Servicing a Server Core installation

> Applies to: Windows Server, Windows Server 2016

You can service a server running Server Core installation in the following ways:
Using Windows Update automatically or with WSUS. By using Windows Update, either automatically or with command-line tools, or Windows Server Update Services (WSUS), you can service servers running a Server Core installation.

Manually. Even in organizations that do not use Windows update or WSUS, you can apply updates manually.

Prerequisites for servicing a server running Server Core installation

To service a server running a Server Core installation, you need:
A computer that has a Server Core installation of Windows Server 2008 or Windows Server 2008 R2 installed and configured.

An administrator user account and password for a server running a Server Core installation.

Known issues for servicing a server running a Server Core installation

There are no known issues for servicing a Server Core computer at this time.
Steps for servicing a Server Core installation

The following procedures explain methods for managing updates on a server running a Server Core installation, including:
Servicing the server automatically with Windows Update

Servicing the server with WSUS

Servicing the server manually


To service the server automatically with Windows Update

To verify the current Windows Update setting, at a command prompt, run the following command:
Cscript scregedit.wsf /AU /v 
To enable automatic updates, run the following commands:
Net stop wsuaserv 
Cscript scregedit.wsf /AU 4 
Net start wsuaserv 
To disable automatic updates, run the following commands:
Net stop wsuaserv 
Cscript scregedit.wsf /AU 1 
Net start wsuaserv 
If the server is a member of a domain, you can also configure Windows Update using Group Policy. For more information, see http://go.microsoft.com/fwlink/?LinkId=192470. However, when you use this method, only option 4 (“Auto download and schedule the install”) is relevant to Server Core installations because of the lack of a graphical interface. For more control over which updates are installed and when, you can use a script which provides a command-line equivalent of most of the Windows Update graphical interface. For information about the script, see http://go.microsoft.com/fwlink/?LinkId=192471.
To force Windows Update to immediately detect and install any available updates, run the following command:
Wuauclt /detectnow 
Depending on the updates that are installed, you may need to restart the computer, although the system will not notify you of this. To determine if the installation process has completed, use Task Manager to verify that the Wuauclt or Trusted Installer processes are not actively running. You can also use the methods in the “Viewing installed updates” section to check the list of installed updates.
To service the server with WSUS 
If the Server Core server is a member of a domain, you can configure it to use a WSUS server with Group Policy. For more information, see http://go.microsoft.com/fwlink/?LinkId=192472.
If the server is not a member of a domain, edit the Registry to configure it to use a WSUS server. For more information, see http://go.microsoft.com/fwlink/?LinkId=192473.
Whenever you configure WSUS settings, be sure to select options that are valid for Server Core installations. For example, since there is no graphical interface, there is no way to receive WSUS notifications. For more control over which updates are installed and when, you can use a script which provides a command-line equivalent of most of the Windows Update graphical interface. For information about the script, see http://go.microsoft.com/fwlink/?LinkId=192471.
To service the server manually

Download the update and make it available to the Server Core installation.
At a command prompt, run the following command:
Wusa <update>.msu /quiet 
Depending on the updates that are installed, you may need to restart the computer, although the system will not notify you of this.
To uninstall an update manually

Download the update and make it available to the Server Core installation.
At a command prompt, run the following command:
Wusa /uninstall <update>.msu /quiet 
Depending on the updates that are installed, you may need to restart the computer, although the system will not notify you of this.
To view installed updates 
At a command prompt, run either of these commands:
systeminfo 
wmic qfe list 