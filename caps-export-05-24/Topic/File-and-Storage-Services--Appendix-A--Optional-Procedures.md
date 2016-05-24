---
title: File and Storage Services: Appendix A: Optional Procedures
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ba25dc5d-8e39-47ba-8041-2571c6b854e2
---
# File and Storage Services: Appendix A: Optional Procedures
  
## Opening ports in Windows Firewall  
The following instructions are for opening ports in Windows Firewall. If you have a non\-Microsoft firewall installed, consult the guide for that firewall about how to open ports. Opening ports in Windows Firewall can be done through the command line.  
  
> [!IMPORTANT]  
> Opening ports in your firewall can leave your server exposed to malicious attacks. Make sure that you understand firewall systems before you open ports.  
  
#### To open Windows Firewall ports by using the command line \(do one of the following\):  
  
1.  Open a Command Prompt window with elevated user rights, type the following, and then press Enter.  
  
    -   On computers that are running Windows Server 2003, type:  
  
        ```  
        netsh firewall add allowedprogram program=%windir%\System32\WindowsPowerShell\v1.0\powershell.exe name="ServerMigration" mode=ENABLE  
        ```  
  
    -   On computers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], type the following commands in order, and press Enter after each command.  
  
        1.  ```  
            netsh advfirewall firewall add rule name=ServerMigration(TCP-In) dir=in program=%windir%\System32\WindowsPowerShell\v1.0\powershell.exe action=allow protocol=TCP localport=7000  
            ```  
  
        2.  ```  
            netsh advfirewall firewall add rule name=ServerMigration(UDP-In) dir=in program=%windir%\System32\WindowsPowerShell\v1.0\powershell.exe action=allow protocol=UDP localport=7000  
            ```  
  
2.  If you have changed the default behavior of Windows Firewall to block all outbound traffic on computers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you must explicitly allow outbound traffic on UDP port 7000. To do this, open a Command Prompt window with elevated user rights, type the following, and then press Enter.  
  
    ```  
    netsh advfirewall firewall add rule name=ServerMigration(UDP-Out) dir=out program=%windir%\System32\WindowsPowerShell\v1.0\powershell.exe action=allow protocol=UDP localport=7000  
    ```  
  
## Closing ports in Windows Firewall  
As a best practice, we recommend that you close Windows Firewall ports after the data transfer operation is completed.  
  
#### To close Windows Firewall ports by using the command line  
  
-   Do one of the following:  
  
    -   On computers that are running Windows Server 2003, open a Command Prompt window, type the following, and then press Enter.  
  
        ```  
        netsh firewall delete allowedprogram program=%windir%\System32\WindowsPowerShell\v1.0\powershell.exe  
        ```  
  
    -   On computers that are running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], open a Command Prompt window with elevated user rights, type the following two commands, and press Enter after each command.  
  
        ```  
        netsh advfirewall firewall delete rule name=ServerMigration(TCP-In)  
        ```  
  
        ```  
        netsh advfirewall firewall delete rule name=ServerMigration(UDP-Out)  
        ```  
  
## Detect reparse points and hard links  
The following commands can be used to detect reparse points and mounted volumes in any folder and its subfolders. Open a Command Prompt window, type the following commands to detect reparse points, in which **D:\\Test** represents the hard disk drive and folder that you want to search, and then press Enter.  
  
```  
dir D:\Test\* /S /A:L  
```  
  
The option **\/A:L** specifies that only reparse points need to be enumerated. The output is similar to the following:  
  
```  
Volume in drive D has no label.  
Volume Serial Number is 3AE4-E412  
  
Directory of D:\Test\Links  
  
10/07/2008  03:44 PM    <JUNCTION>     JunctionMSIT [d:\test\targets\msit]  
10/07/2008  03:42 PM    <SYMLINK>      LinkMSIT [d:\test\targets\msit]  
10/07/2008  03:41 PM    <SYMLINKD>     SymLinkMSIT [d:\test\targets\msit]  
1 File(s)              0 bytes  
  
Directory of D:\Test\Targets  
  
10/07/2008  05:35 PM    <JUNCTION>     Volume [\??\Volume{0674413f-760d-11dd-beb3-806e6f6e6963}\]  
0 File(s)              0 bytes  
  
Total Files Listed:  
1 File(s)              0 bytes  
3 Dir(s)  17,918,840,832 bytes free  
```  
  
To enumerate hard links on a file on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], open a Command Prompt window with elevated user rights, type the following command, and then press Enter.  
  
```  
fsutil hardlink list D:\Test\File.txt  
```  
  
To enumerate hard links on all files in a folder on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], run the following command in a Windows PowerShell session that has been opened with elevated user rights:  
  
```  
Get-ChildItem D:\* | %{'Links for: ' + $_.FullName; fsutil hardlink list $_.FullName; ""}  
```  
  
For more information about enumerating hard links on computers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003, see [FindFirstFileNameW function](http://go.microsoft.com/fwlink/?LinkId=147392) on MSDN.  
  
## Migrated and nonmigrated attributes for local users and groups  
For more information about the attributes of local users and groups that can be migrated, see the [Local User and Group Migration Guide](http://go.microsoft.com/fwlink/?LinkID=128751).  
  
## See Also  
[Migrate File and Storage Services to Windows Server 2012 R2](../Topic/Migrate-File-and-Storage-Services-to-Windows-Server-2012-R2.md)  
[File and Storage Services: Prepare to Migrate](../Topic/File-and-Storage-Services--Prepare-to-Migrate.md)  
[File and Storage Services: Migrate the File and Storage Services Role](../Topic/File-and-Storage-Services--Migrate-the-File-and-Storage-Services-Role.md)  
[File and Storage Services: Verify the Migration](../Topic/File-and-Storage-Services--Verify-the-Migration.md)  
[File and Storage Services: Migrate an iSCSI Software Target](../Topic/File-and-Storage-Services--Migrate-an-iSCSI-Software-Target.md)  
[File and Storage Services: Migrate Network File System](../Topic/File-and-Storage-Services--Migrate-Network-File-System.md)  
[File and Storage Services: Post-Migration Tasks](../Topic/File-and-Storage-Services--Post-Migration-Tasks.md)  
[File and Storage Services: Appendix B: Migration Data Collection Worksheets](../Topic/File-and-Storage-Services--Appendix-B--Migration-Data-Collection-Worksheets.md)  
  
