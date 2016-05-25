---
title: Step 2: Validate Preseeded Files for DFS Replication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04e1ddcb-ff13-4d18-8c1f-5d2d7b98121c
author: JasonGerend
---
# Step 2: Validate Preseeded Files for DFS Replication
After you preseed files on the destination server in preparation for setting up replication for Distributed File System \(DFS\) Replication \(also known as DFSR or DFS\-R\), you should confirm that the preseeding succeeded by using the tools included with Windows Server or the Remote Server Administration Tools \(RSAT\) client.  
  
These utilities perform a simulated file marshaling using the same hash computation function that the DFS Replication service uses, and they can guarantee that a file is identical on two servers for the purpose of replication.  
  
> [!CAUTION]  
> Do not use checksum comparison tools designed to calculate hashes for downloaded files. This includes Microsoft tools such as the Microsoft File Checksum Integrity Verifier and LogParser 2.2. Those tools do not calculate the security and alternate data stream portions of files as part of the hash.  
  
## Best practices for validating preseeded files  
By following these guidelines, you can get an accurate picture of the validity of your preseeded files efficiently and without affecting performance:  
  
-   When you compare files on the source and destination servers, do not attempt to validate every file hash. It is better to pick several locations within a preseeded data set and spot check the file hashes. If you preseeded millions of files, validating every file hash might take too long.  
  
    By selecting a handful of subfolders after preseeding, as well as the direct contents of the root folder, you can get a good picture of the validity of the file hashes without degrading performance. Typically, an incorrectly preseeded data set yields mismatched hashes for every file and folder; it is difficult to preseed with only partial success.  
  
-   If users are accessing files on the source server while you preseed data, some files probably will have differing hashes simply from user actions. If you see individual file hash mismatches, but most of the files have matching hashes, check the file size, last modified date and time, and permissions on each copy of the file to confirm that the difference is expected.  
  
-   Consider counting the replicated files and folders on the source and destination server to ensure that the destination server does not have a gross mismatch of fewer objects. This is not a precise test if you allowed users to create files on the source server during preseeding, but it provides another data point to consider.  
  
    For instance, you can use the following Windows PowerShell command on both the source server and the destination server, replacing the **–Path** value with the path that you want to check, to ensure that the file counts are similar:  
  
    ```powershell  
    (Get-ChildItem -Path h:\rf01 -Recurse -Force).count  
    ```  
  
## Two methods for validating preseeded files  
The following sections provide a detailed walkthrough of two validation techniques available to administrators who manage DFS Replication. You must decide which one works best for your environment.  
  
-   [Get\-DfsrFileHash method](#BKMK_Get-DFSRFileHashMethod)  
  
-   [Dfsrdiag method](#BKMK_DfsrdiagMethod)  
  
### <a name="BKMK_Get-DFSRFileHashMethod"></a>Get\-DfsrFileHash method  
The DFSR module of Windows PowerShell, which is provided with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], includes the **Get\-DfsrFileHash** cmdlet, which you can use to calculate file hashes on local or remote computers. The cmdlet has only one parameter, **\-Path**, which accepts UNC paths, mapped drives, and local volumes. The cmdlet does not require that the DFS Replication service be installed or that replication be configured on the server. You can run the cmdlet against any target operating system. If you have a single computer running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], you can retrieve any file hashes on any Windows operating system.  
  
> [!NOTE]  
> The DFSR module for Windows PowerShell also is provided with the [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] Remote Server Administration Tools \(RSAT\). For download information, see [Remote Server Administration Tools for Windows 8.1](http://go.microsoft.com/fwlink/?LinkID=304145).  
  
#### Compare a file hash for a single file  
The following example code uses **Get\-DfsrFileHash** to retrieve the hash of the file rascfg.dll on both the source server and the destination server. In this example, the file hash on the local server is not a match for the file hash on the remote server \(named SRV02\), which indicates that preseeding was not successful.  
  
```powershell  
PS C:\> Get-DfsrFileHash -Path 'C:\rf03\rascfg.dll' | Format-Table -Auto -Wrap  
Path               FileHash  
----               --------  
C:\rf03\rascfg.dll 04D164A0-ADEB6583-7DB21B5B-22AF572C  
  
PS C:\> Get-DfsrFileHash –Path '\\srv02\c$\rf03\rascfg.dll' | Format-Table -Auto -Wrap  
Path                          FileHash  
----                          --------  
\\srv02\c$\rf03\rascfg.dll    D7F1EF42-5FEF2DDE-2F3ECDF0-AD26F343  
```  
  
#### Compare file hashes for a folder’s immediate contents  
The following sample code uses **Get\-DfsrFileHash** retrieve the files hashes for all files in direct child folders on both the source server and the destination server for the preseeded data set. In this example, all files hatches match for files on the local server and the remote server \(named SRV02\).  
  
```powershell  
PS C:\> Get-DfsrFileHash -Path 'C:\rf03\*' | Format-Table -Auto -Wrap  
  
Path                 FileHash  
----                 --------  
C:\rf03\app1         DF896CD6-23100551-A2D4F4D7-7BBCA290  
C:\rf03\canary       DF896CD6-23100551-A2D4F4D7-7BBCA290  
C:\rf03\doc2         DF896CD6-23100551-A2D4F4D7-7BBCA290  
C:\rf03\rasauto.dll  E725F26C-9A62CDD9-9A4E47D3-93F61FD9  
C:\rf03\rasautou.exe 1C42D753-48E566B2-7FCFDC9D-2F2C1FF2  
C:\rf03\rascfg.dll   04D164A0-ADEB6583-7DB21B5B-22AF572C  
  
PS C:\> Get-DfsrFileHash -Path '\\srv02\c$\rf03\*' | Format-Table -Auto -Wrap  
  
Path                         FileHash  
----                         --------  
\\srv02\c$\rf03\app1         DF896CD6-23100551-A2D4F4D7-7BBCA290  
\\srv02\c$\rf03\canary       DF896CD6-23100551-A2D4F4D7-7BBCA290  
\\srv02\c$\rf03\doc2         DF896CD6-23100551-A2D4F4D7-7BBCA290  
\\srv02\c$\rf03\rasauto.dll  E725F26C-9A62CDD9-9A4E47D3-93F61FD9  
\\srv02\c$\rf03\rasautou.exe 1C42D753-48E566B2-7FCFDC9D-2F2C1FF2  
\\srv02\c$\rf03\rascfg.dll   04D164A0-ADEB6583-7DB21B5B-22AF572C  
```  
  
> [!NOTE]  
> A simple method for comparing hashes between servers is to use a Windows PowerShell pipeline to send the output to a file \(for example, use **Export\-CSV**\), and then open the file in Microsoft Excel. You can then compare the results of each server’s output.  
  
**Get\-DfsrFileHash** \(like **Get\-Item**\) does not return hidden files when wildcards are used. **Get\-DfsrFileHash** also does not retrieve file hashes recursively for deeper folders and files. Both of these behaviors are by design. Searching recursively and for every hidden file typically is not necessary and can be inefficient when your goal is to spot check preseeding results.  
  
If you want to retrieve nested hashes and hashes for hidden files and folders, you can use the **Get\-ChildItem** cmdlet with the following parameters, substituting your own paths:  
  
```powershell  
Get-DfsrFileHash -Path (Get-ChildItem -Path c:\Rf01\subfolder1\subfolder2 –Recurse -Force).fullname  
```  
  
> [!IMPORTANT]  
> Use care with this approach to hash retrieval: on large data sets, returning the data takes significant time. If you specify the root of the replicated folder, **Get\-ChildItem** by default also returns the hidden DfsrPrivate folder. If you do not want to retrieve hash data for the DfsrPrivate folder, use the **–Exclude** parameter to exclude it.  
  
#### Compare file hashes between two servers by using Compare\-Object  
To retrieve the hash of all direct child files and folders in a replicated folder on both the source server and the destination server, and then compare those hashes automatically, you can leverage mapped drives and the **Compare\-Object** cmdlet.  
  
The following code sample includes a series of commands that perform the following tasks:  
  
1.  Map a drive to the source server.  
  
2.  Save the file hashes to a file.  
  
3.  Delete the drive on the source server.  
  
4.  Map a drive to a relative path on the destination server.  
  
5.  Save file hashes for that drive to a file.  
  
6.  Compare the two files.  
  
The file comparison that is returned shows both equal and unequal results. Each difference is identified by a \=> or <\= marker. In this case, most files and folders match, but the hashes for rascfg.dll differ.  
  
```  
PS C:\> net use x: \\Srv01\c$\Rf03  
PS C:\> Get-DfsrFileHash x:\* | Out-File c:\Srv01.txt  
PS C:\> net use x: /d  
PS C:\> net use x: \\Srv02\c$\rf03  
PS C:\> Get-DfsrFileHash x:\* | Out-File c:\Srv02.txt  
PS C:\> net use x: /d  
PS C:\> Compare-Object -ReferenceObject (Get-Content C:\Srv01.txt) -DifferenceObject (Get-Content C:\Srv02.txt) -IncludeEqual   
  
InputObject                      SideIndicator  
-----------                      -------------  
                                 ==  
Path                             ... ==  
----                             ... ==  
x:\app1                          ... ==  
x:\canary                        ... ==  
x:\doc2                          ... ==  
x:\rasauto.dll                   ... ==  
                                 ==  
                                 ==  
x:\rascfg.dll                    ... =>  
x:\rascfg.dll                    ... <=  
```  
  
### <a name="BKMK_DfsrdiagMethod"></a>Dfsrdiag method  
As an alternative to the **Get\-DfsrFileHash** cmdlet, you can use the older **DFSRdiag.exe** tool with the FILEHASH option to calculate file hashes on local or remote computers. This updated tool is included with [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. Like **Get\-DfsrFileHash**, this tool accepts UNC paths, mapped drives, and local volumes. It does not require that the DFS Replication service be installed or that replication be configured. And **Dfsrdiag.exe** can run against any target operating system. If you have a single computer running [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or later, you can retrieve any file hashes on any Windows operating system.  
  
However, this older tool can only return one file or folder at a time. For this reason, the **Get\-DfsrFileHash** cmdlet is the recommended tool for comparing file hashes after preseeding files.  
  
#### Compare a file hash for a single file  
The following example code uses **Dfsrdiag.exe** to retrieve the hash of the file rascfg.dll on both the source and destination server. In this example, the file on the local server matches the file on SRV02.  
  
```ms-dos  
C:\> dfsrdiag filehash /path:f:\rf01\rascfg.dll  
   File Hash: A35BA042-F0DC3008-A5863965-F5010326  
Operation Succeeded  
  
C:\> dfsrdiag filehash /path:\\srv02\g$\rf01\rascfg.dll  
   File Hash: A35BA042-F0DC3008-A5863965-F5010326  
Operation Succeeded  
```  
  
> [!NOTE]  
> TechNet offers an unsupported sample script that automates **Dfsrdiag**, provides source and destination comparison, and allows you to select random files. For more information, see [PowerShell Script to Calculate and compare filehashes for DFSR Pre\-Staging](http://gallery.technet.microsoft.com/scriptcenter/1de44cc1-ce79-4e98-9283-92548fc02af9).  
  
## Related resources  
  
-   [Troubleshoot Preseeding for Initial Synchronization in DFS Replication](../Topic/Troubleshoot-Preseeding-for-Initial-Synchronization-in-DFS-Replication.md)  
  
-   [DFS Replication: Copying Files to Preseed or Stage Initial Synchronization](../Topic/DFS-Replication--Copying-Files-to-Preseed-or-Stage-Initial-Synchronization.md)  
  
-   [Step 1: Preseed Files for DFS Replication](../Topic/Step-1--Preseed-Files-for-DFS-Replication.md)  
  
