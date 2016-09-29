---
title: Using the File Server Capacity Tool (FSCT)
description: Using the File Server Capacity Tool (FSCT)
---

# Using the File Server Capacity Tool (FSCT)


File Server Capacity Tool (FSCT) is a file server capacity planning tool that measures how many users a file server can support. FSCT creates many users that connect to the server and perform typical operations such as downloading files, uploading files, browsing directories, and opening files. FSCT gives a throughput score for each user count and evaluates if the server is overloaded with that many users. The highest user count without overload is the maximum number of users that the server can support under this workload.

**In this topic:**

-   [Tuning for servers](#servers)

-   [Tuning for clients](#clients)

## <a href="" id="servers"></a>Tuning for servers


The following REG\_DWORD registry settings can affect the performance of file servers:

-   **NtfsDisable8dot3NameCreation**

    ``` syntax
    HKLM\System\CurrentControlSet\Control\FileSystem\NtfsDisable8dot3NameCreation
    ```

    The default in Windows Server 2012 R2 and Windows Server 2012 is 2, and in previous releases it is 0. This parameter determines whether NTFS generates a short name in the 8dot3 (MSDOS) naming convention for long file names and for file names that contain characters from the extended character set. If the value of this entry is 0, files can have two names: the name that the user specifies and the short name that NTFS generates. If the user-specified name follows the 8dot3 naming convention, NTFS does not generate a short name. A value of 2 means that this parameter can be configured per volume.

    **Note**  
    The system volume will have 8dot3 enabled, whereas other volumes will have it disabled by default in Windows Server 2012 and Windows Server 2012 R2.

     

    Changing this value does not change the contents of a file, but it avoids the short-name attribute creation for the file, which also changes how NTFS displays and manages the file. For most SMB file servers, the recommended setting is 1 (disabled). For example, you would want to disable the setting if you have a clustered file server.

    In Windows Server 2012 R2, Windows Server 2012, and Windows Server 2008 R2, you can disable 8dot3 name creation on a per-volume basis without using the global NtfsDisable8dot3NameCreation setting. You can do this by using fsutil. For example, to disable 8dot3 name creation on volume D, run **fsutil 8dot3name set d: 1** from an elevated command prompt. If you are disabling new 8dot3 name creation on a volume that has existing data, consider stripping existing 8dot3 names from the volume by using fsutil. For example, to strip existing 8dot3 names on volume D and log the changes made, run **fsutil 8dot3name strip /l 8dot3\_removal\_log.log /s d:\\**.

-   **TreatHostAsStableStorage**

    ``` syntax
    HKLM\System\CurrentControlSet\Services\LanmanServer\Parameters\TreatHostAsStableStorage
    ```

    The default is 0. This parameter disables processing write flush commands from clients. If the registry entry is 1, the server performance and client latency can improve but there’s potential risk of data loss. Workloads that resemble the NetBench file server benchmark benefit from this behavior.

## <a href="" id="clients"></a>Tuning for clients


The following REG\_DWORD registry settings can affect the performance of client computers:

-   **DormantFileLimit**

    ``` syntax
    HKLM\system\CurrentControlSet\Services\LanmanWorkstation\Parameters\DormantFileLimit
    ```

    This settings applies to Windows XP, Windows Vista, Windows 7, or Windows 8 only

    The default is 1023. This parameter specifies the maximum number of files that should be left open on a shared resource after the application has closed the file.

## Related topics


[Performance Tuning for Workloads](performance-tuning-for-workloads.md)

[Performance Tuning for File Servers](performance-tuning-for-file-servers.md)
