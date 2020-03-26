---
title: "Customize Shared Folders"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47bc4986-14eb-4a29-9930-83a25704a3a0
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Customize Shared Folders

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

By default, the server folders are created on the largest data partition on Disk 0. Partners can customize the location and specify additional server folders by using the following steps:  
  
1. Using a custom partition configuration, create the factory image, and then create a new Storage registry key before you use sysprep. During Initial Configuration (IC), the storage IC task checks for this registry key. If it exists, the default server folders are created in the C:\ServerFolders directory.  
  
   #### To create a new Storage registry key  
  
   1.  On the server, move your mouse to the upper right corner of the screen, and click **Search**.  
  
   2.  In the Search box, type **regedit**, and then click the **Regedit** application.  
  
   3.  In the navigation pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, and then expand **Microsoft**.  
  
   4.  Right-click **Windows Server**, click **New**, and then click **Key**.  
  
   5.  Name the key **Storage**.  
  
   6.  In the navigation pane, right-click the new Storage registry key, click **New**, and then click **DWORD (32-bit) Value**.  
  
   7.  Name the string **CreateFoldersOnSystem**.  
  
   8.  Right-click **CreateFoldersOnSystem**, and then click **Modify**. The **Edit String** dialog box appears.  
  
   9. Set the value of this new key to **1**, and then click **OK**.  
  
2. Use the PostIC.cmd script to move the folders to a different location or to create additional folders. See the following example: [Example 1: Create a custom folder and move the default folders to a new location from PostIC.cmd by using Windows PowerShell](Customize-Shared-Folders.md#BKMK_Example1).  
  
3. Use the Windows Server Solutions SDK to move the folders to a different location or to create additional folders. See the following example: [Example 2: Create a custom folder and move an existing folder by using the Windows Server Solutions SDK](Customize-Shared-Folders.md#BKMK_Example2).  
  
   Optionally, partners can leave the data folders on drive C. This allows the end user or reseller to determine the layout of the data folders on the data drives.  
  
###  <a name="BKMK_Example1"></a> Example 1: Create a custom folder and move the default folders to a new location from PostIC.cmd by using Windows PowerShell  
  
1.  Create a PostIC.cmd file for running post Initial Configuration tasks as detailed in the [Create the PostIC.cmd File for Running Post Initial Configuration Tasks](Create-the-PostIC.cmd-File-for-Running-Post-Initial-Configuration-Tasks.md) section.  
  
2.  Using Notepad, create a file named **customizefolders.ps1** in the C:\Windows\Setup\Scripts folder, and then paste the following Windows PowerShell® commands into the file (unmark appropriate lines depending on the desired behavior).  
  
    ```  
    # Move the Documents folder to D:\ServerFolders  
    #Get-WssFolder -name Documents| Move-WssFolder - NewDrive D:\ -Force  
  
    # Check for last error. If last error is not null, exit with return code 1  
    #If ($error[0] -ne $null) { exit 1}   
  
    # Move all folders to D:\ServerFolders  
    #foreach( $folder in Get-WssFolder )  
    #{  
    #    Move-WssFolder $folder -NewDrive D:\ -Force  
    #}  
  
    # Check for last error. If last error is not null, exit with return code 1  
    #If ($error[0] -ne $null) { exit 1}   
  
    # Create a custom folder named Custom Folder  
    #Add-WssFolder -Name CustomFolder -Path D:\ServerFolders\CustomFolder -Description "Custom Folder"  
  
    # Check for last error. If last error is not null, exit with return code 1  
    #If ($error[0] -ne $null) { exit 1}   
  
    exit 0  
    ```  
  
3.  Add the following line to the PostIC.cmd file to run this script.  
  
    ```  
    REM Lower the execution policy  
    "%programfiles%\Windows Server\bin\WssPowershell.exe" "Set-ExecutionPolicy RemoteSigned"  
  
    REM Execute the folder customization script  
    "%programfiles%\Windows Server\bin\WssPowershell.exe" -NoProfile -Noninteractive -command ". %windir%\setup\scripts\customizefolders.ps1;exit $LASTEXITCODE"  
    Set error_level=%ERRORLEVEL%  
  
    REM Restore the execution policy to default  
    "%programfiles%\Windows Server\bin\WssPowershell.exe" "Set-ExecutionPolicy Restricted"  
    Set ERRORLEVEL=%error_level%  
    ```  
  
###  <a name="BKMK_Example2"></a> Example 2: Create a custom folder and move an existing folder by using the Windows Server Solutions SDK  
 The code that you create can be complied as an executable, and then called from the PostIC.cmd file or called directly from an installed add-in.  
  
```  
static void Main(string[] args)  
{  
 StorageManager storageManager = new StorageManager();  
 //Connect to the StorageManager  
 storageManager.Connect();  
  
 //Move the Documents folder to D:\ServerFolders  
 Folder targetFolder = storageManager.Folders.First(folder => folder.Name == "Documents");  
  
 MoveFolderRequest moveRequest = targetFolder.GetMoveRequest(@"D:\");  
 moveRequest.MoveFolder();  
  
 //Verify operation was successful, if so print result  
 if (moveRequest.Status == OperationStatus.Succeeded)  
 {  
  Console.WriteLine("Folder {0} now located at {1}", targetFolder.Name, targetFolder.Path);  
 }  
  
 string newFolderName = "New Custom Folder";  
 string newFolderLocation = @"C:\ServerFolders\New Custom Folder";  
  
 //Create add request based with specific name and location  
 CreateFolderRequest request = storageManager.GetCreateFolderRequest(newFolderName, newFolderLocation);  
  
 //Give Guest user read only permission to folder  
 request.PermissionsByName.Add(new NamePermission("Guest", Permission.ReadOnly));  
  
 //Create the new folders  
 request.CreateFolder();  
  
 //Verify operation was successful, if so print result  
 if( request.Status == OperationStatus.Succeeded)  
 {  
  Folder newFolder = storageManager.Folders.First(folder => folder.Path == newFolderLocation);  
  
  Console.WriteLine("Folder {0} created at {1}", newFolder.Name, newFolder.Path);  
 }  
}  
```  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)
