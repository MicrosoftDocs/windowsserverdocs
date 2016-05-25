---
title: Issues with Client Computer Self-Update
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e9c0f6a-1039-4673-b5ac-ba5da88ea1d1
author: britw
---
# Issues with Client Computer Self-Update
WSUS uses IIS to update most computers to the WSUS\-compatible Automatic Update. This process is called *client self\-update*. To accomplish client self\-update, WSUS Setup creates a virtual directory under the WSUS website named **Selfupdate**. This virtual directory holds the WSUS\-compatible Automatic Updates. This is called the *self\-update tree*.  
  
Using Group Policy to point client computers to your WSUS server should eventually cause an Automatic Updates detection and client self\-update. For more information about this process, see the [WSUS Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=139832).  
  
## Troubleshooting client self\-update issues  
If the client self\-update does not work automatically, use the following suggestions to troubleshoot the problem.  
  
#### Differentiate between the SUS client and WSUS client  
Use the Automatic Updates user interface to differentiate between the SUS and WSUS clients. The following images show the user interfaces of SUS and WSUS client computers.  
  
![](../Image/19d55cf9-544b-4fcf-8628-82c9e4bee345.gif)  
  
![](../Image/eb4d8b30-b0f5-46ee-afec-e333e2e28f74.gif)  
  
![](../Image/de118e9d-7163-4550-a2c9-e181e6cc93e5.gif)  
  
#### Verify that the client computer software in your organization can self\-update  
Some computers might already have the WSUS client installed. Other computers might have a version of Automatic Updates that is incapable of performing self\-update. For more information, see the [Windows Server Update Services 3.0 SP2 Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=139832).  
  
#### Verify that SUS clients are pointed to the WSUS server  
If you have the WSUS client installed but the client computer is pointed to a SUS server, Automatic Updates falls into legacy mode and the client computer uses the SUS client user interface. In this case you need to redirect the computer away from the SUS server to get the WSUS client to function. When you point Automatic Updates to a WSUS server, the WSUS client user interface appears.  
  
#### Check for the self\-update tree on the WSUS server  
WSUS Setup creates a virtual directory named **Selfupdate** under the website running on port 80 of the computer where you install WSUS. This virtual directory, called the *self\-update tree*, holds the latest WSUS client. For this reason, you must have a website running on port 80, even if you put the WSUS website on a custom port. The website on port 80 does not have to be dedicated to WSUS. WSUS uses the site on port 80 only to host the self\-update tree.  
  
To ensure that the self\-update tree is working properly, make sure that there is a website set up on port 80 of the WSUS server. After that, run the WSUS script that ensures a proper configuration of self\-update on port 80. Open a Command Prompt window on the WSUS server and type the following:  
  
**cscript** *WSUSInstallDirectory***\\setup\\installselfupdateonport80.vbs**  
  
where *WSUSInstallDirectory* is the directory in which WSUS is installed. If the script is successful, you should see the following output:  
  
```  
Microsoft (R) Windows Script Host Version 5.6  
Copyright (C) Microsoft Corporation 1996-2001. All rights reserved.  
  
SetupSelfupdateTree: Finding the index of the Web site on which WUS is installed...  
SetupSelfupdateTree: Leaving GetWUSWebSiteIndex.  
SetupSelfupdateTree: Finding the index of the web site bound to port 80...  
SetupSelfupdateTree: iWebSiteIndex: 1 ServerBindings: :80:index: 0  
SetupSelfupdateTree: Found the index of site on Port 80: 1  
SetupSelfupdateTree: rootMetabasePath: IIS://LocalHost/W3SVC/1/ROOT  
SetupSelfupdateTree: szPort80RootPath=c:\inetpub\wwwroot  
SetupSelfupdateTree: iWusWebSiteIndex=1 iPort80WebSiteIndex=1  
SetupSelfupdateTree: Warning: This is standalone WUS install. No need to do configuration for SxS install.  
Success: InstallSelfupdateOnPort80 succeeded.  
```  
  
#### Check IIS logs on the WSUS server  
IIS logs are typically located in *%windir%*\\system32\\LogFiles\\W3SVC1 for the default website. Typical errors might be 404 \(file not found\) 401\/403 \(authentication\/access\), and 500 \(internal server error\). Use IIS Help to troubleshoot any problems found in the IIS logs.  
  
#### Configure Windows SharePoint Services on the default website in IIS to coexist with Self\-update  
If you have installed Windows SharePoint Services on the same server that is running WSUS, you might see the following issues:  
  
-   An "Access denied" message appears when Automatic Updates tries to update itself, and the latest Automatic Updates will not be running.  
  
-   A message appears that warns you the SelfUpdate service is not available.  
  
###### To enable client computers that are not running the WSUS\-compatible version of Automatic Updates to receive updates through WSUS  
  
1.  Grant Anonymous access \(Anonymous Auth\) to the default website, ClientWebService, and Selfupdate v\-roots in IIS.  
  
    For more information, see [Enable Anonymous Authentication \(IIS 7\)](http://go.microsoft.com/fwlink/?LinkID=202103) or [Enabling Anonymous Authentication \(IIS 6.0\)](http://go.microsoft.com/fwlink/?LinkID=211391)  
  
2.  Exclude specific requests from being intercepted by the Windows SharePoint Services ISAPI DLL as follows:  
  
    1.  Open the Windows SharePoint Services Central Administration site. \(Click **Start**, point to **Administrative Tools**, and then click **Sharepoint Central Administration**\).  
  
    2.  Click **Virtual Server Configuration**, and then click **Configure Virtual Server Settings**.  
  
    3.  Click **Default Web Site**.  
  
    4.  Click **Virtual Server Management**, and then click **Define managed paths**.  
  
    5.  In the **Add a new path** box, set the type to **Excluded Path**. Under **Path**, type the following:  
  
    -   **\/iuident.cab**  
  
    -   **\/clientwebservice**  
  
    -   **\/Selfupdate**  
  
For more information, see [article 828810](http://go.microsoft.com/fwlink/?LinkId=81417) in the Microsoft Knowledge Base.  
  
#### Check if the Content and Selfupdate websites have different authentication levels  
If the Content site is configured for **Enable anonymous access** and Selfupdate site is configured for **Authenticated access \- Integrated Windows Authentication**, the client computer will fail to update.  
  
###### To enable anonymous access  for the Selfupdate site  
  
1.  On the **Start** menu, point to **Programs,** point to **Administrative Tools**, and then click **Internet Information Services** \(IIS\) Manager.  
  
2.  Expand the local computer node.  
  
3.  Expand the WSUS website node.  
  
4.  Right\-click **Selfupdate**, and then click **Properties**.  
  
5.  On the **Directory Security** tab, under **Authentication and access control**, click **Edit**.  
  
6.  In the **Authentication Methods** dialog box, select the **Enable anonymous access** check box, and then clear all the buttons that follow if they are selected. The **User name** and **Password** dialog boxes should be prepopulated.  
  
7.  Click **OK** twice.  
  
#### Check network connectivity on the WSUS client computer  
Use Internet Explorer to determine whether self\-update files on the WSUS server are accessible to the client computer. If you perform the following procedure, and you are prompted to download or open the files, you have verified network connectivity. If you do not have access to these files, there are problems with network connectivity between the WSUS server and the client computer.  
  
###### To check network connectivity on the WSUS client computer  
  
1.  Open Internet Explorer, and in the address bar, type:  
  
    **http:\/\/***WSUSServerName***\/selfupdate\/wuident.cab**  
  
    where *WSUSServerName* is the name of the WSUS server. You should be prompted to download or open wuident.cab. This verifies network connectivity from the WSUS client and the availability of the wuident.cab file on the WSUS server. If you do not have connectivity or the website is not configured correctly, you will get an HTTP error message. Check the network settings of the WSUS server and any proxy servers.  
  
2.  If there are any boxes prompting you to download or save, click **Cancel**.  
  
If you are prompted to save or download both of these files, check logs on the client computer as follows.  
  
#### Check logs on the WSUS client computer  
Check the *%windir%*\\WindowsUpdate.log on the client computer to see if there has been any activity or any attempts to contact the server, such as cached server pingbacks. If you can find no problem with the logs on the WSUS client, manipulate registry settings as follows.  
  
#### Manipulate registry settings on the WSUS client computer  
If all else has failed, you can attempt to manually manipulate registry settings to get the client computer to self\-update to the WSUS client.  
  
###### To manually manipulate registry settings on the SUS client computer  
  
1.  Click **Start**, then **Run**, and type **regedit**, and then click **OK**.  
  
2.  In Registry Editor, navigate to the **WindowsUpdate** key by expanding the following:  
  
    **HKEY\_LOCAL\_MACHINE\\Software\\Policies\\Microsoft\\Windows\\**  
  
    If the **WindowsUpdate** key does not exist, you need to add it as follows.  
  
3.  On the menu, click **Edit**, point to **New**, and then click **Key**.  
  
4.  Type **WindowsUpdate** as the name for the new key.  
  
5.  Double\-click the **WUServer** setting, type the URL to your WSUS server, and then press ENTER.  
  
    If the **WUServer** setting does not exist, you need to add it as follows.  
  
    On the menu, click **Edit**, point to **New**, and then click **String Value**.  
  
6.  Type **WUServer** as the setting name.  
  
7.  Double\-click the **WUStatusServer** setting, type the URL to your WSUS server, and then press ENTER.  
  
    If the **WUStatusServer** setting does not exist, do the following:  
  
    On the menu, click **Edit**, point to **New**, and then click **String Value**.  
  
8.  Type **WUStatusServer** as the setting name.  
  
9. Navigate to the following:  
  
    **HKEY\_LOCAL\_MACHINE\\Software\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU**  
  
    If the **AU** key does not exist, do the following:  
  
    On the menu, click **Edit**, point to **New**, and then click **Key**.  
  
10. Type **AU** as the name for the new key.  
  
11. Verify that the **UseWUServer** setting has a value of 1 \(0x1\). If it does not, modify it by double\-clicking the setting and then changing the value.  
  
    If the **UseWUServer** setting does not exist, do the following:  
  
    On the menu, click **Edit**, point to **New**, and then click **DWORD Value**.  
  
12. Type **UseWUServer** for the setting name.  
  
13. Navigate to the following:  
  
    **HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\WindowsUpdate\\Auto Update**  
  
14. Enable and configure Automatic Updates through Control Panel:  
  
    Click **Start**, click **Control Panel**, and then double\-click **Automatic Updates**.  
  
15. In the **Automatic Updates** dialog box, specify download and installation options, and then click **OK**. Make sure that **Turn off Automatic Updates** is not selected.  
  
16. Ensure that the **AUState** setting has a value of 2 \(0x2\). If it does not, modify it by double\-clicking and changing the value.  
  
17. If the **LastWaitTimeout** setting exists, delete it.  
  
18. If the **DetectionStartTime** setting exists, delete it.  
  
19. Close the Registry Editor.  
  
###### To force the WSUS client computer to check with the WSUS server  
  
1.  At the command prompt, stop the Automatic Updates service by typing the following, and then pressing ENTER:  
  
    **net stop wuauserv**  
  
2.  At the command prompt, restart the Automatic Updates service by typing the following, and then pressing ENTER:  
  
    **net start wuauserv**  
  
3.  The self\-update should occur in six to ten minutes.  
  
4.  Wait approximately one minute, and then refresh the registry. You should now see the following settings and values:  
  
    -   **DetectionStartTime \(REG\_SZ\) YYYY.MM.DD HH.MM.SS**. The **DetectionStartTime** value is written in local time, but the detection actually occurs five minutes after the time noted.  
  
    -   **LastWaitTimeout \(REG\_SZ\) YYYY.MM.DD HH.MM.SS**. The **LastWaitTimeout** value is written in GMT or Universal Time, and represents the actual time that the detection occurs.  
  
Although these values refer to the time that the detection is going to start, the first phase of detection is the process of checking whether a self\-update is necessary. Therefore, these values actually refer to the time that the self\-update from the SUS client to the WSUS client should occur.  
  
If the client software has not self\-updated after ten minutes, refresh the **\\Auto Update** registry key. If the **LastWaitTimeout** value has changed and is now 24 hours later than its previous value, that indicates that Automatic Updates was not able to contact the server URL that you specified in the **WUServer** value.  
  
You should also check the functioning of the Client Web Service. For more information, see [Issues with WSUS 3.0 Services](../Topic/Issues-with-WSUS-3.0-Services.md).  
  
