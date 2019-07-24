---
title: Configure memory dump files for Server Core installation
description: Learn how to configure memory dump files for a Server Core installation of Windows Server
ms.prod: windows-server-threshold
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: medium
ms.date: 10/17/2017
---
# Configure memory dump files for Server Core installation

>Applies to: Windows Server 2019, Windows Server 2016, and Windows Server (Semi-Annual Channel)

Use the following steps to configure a memory dump for your Server Core installation. 

## Step 1: Disable the automatic system page file management

The first step is to manually configure your system failure and recovery options. This is required to complete the remaining steps.

Run the following command: 

```
wmic computersystem set AutomaticManagedPagefile=False
```
 
## Step 2: Configure the destination path for a memory dump

You don't have to have the page file on the partition where the operating system is installed. To put the page file on another partition, you must create a new registry entry named **DedicatedDumpFile**. You can define the size of the paging file by using the **DumpFileSize** registry entry. To create the DedicatedDumpFile and DumpFileSize registry entries, follow these steps: 

1. At the command prompt, run the **regedit** command to open the Registry Editor.
2. Locate and then click the following registry subkey: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl
3. Click **Edit > New > String Value**.
4. Name the new value **DedicatedDumpFile**, and then press ENTER.
5. Right-click **DedicatedDumpFile**, and then click **Modify**.
6. In **Value data** type **\<Drive\>:\\\<Dedicateddumpfile.sys\>**, and then click **OK**.

   >[!NOTE] 
   > Replace \<Drive\> with a drive that has enough disk space for the paging file, and replace \<Dedicateddumpfile.dmp\> with the full path to the dedicated file.
 
7. Click **Edit > New > DWORD Value**.
8. Type **DumpFileSize**, and then press ENTER.
9. Right-click **DumpFileSize**, and then click **Modify**.
10. In **Edit DWORD Value**, under **Base**, click **Decimal**.
11. In **Value data**, type the appropriate value, and then click **OK**.
    >[!NOTE]
    > The size of the dump file is in megabytes (MB).
12. Exit the Registry Editor.

After you determine the partition location of the memory dump, configure the destination path for the page file. To view the current destination path for the page file, run the following command:

```
wmic RECOVEROS get DebugFilePath
```

The default destination for **DebugFilePath** is %systemroot%\memory.dmp. To change the current destination path, run the following command:

```
wmic RECOVEROS set DebugFilePath = <FilePath>
```

Set \<FilePath\> to the destination path. For example, the following command sets the memory dump destination path to C:\WINDOWS\MEMORY.DMP: 

```
wmic RECOVEROS set DebugFilePath = C:\WINDOWS\MEMORY.DMP
```
 
## Step 3: Set the type of memory dump

Determine the type of memory dump to configure for your server. To view the current memory dump type, run the following command:

```
wmic RECOVEROS get DebugInfoType
```

To change the current memory dump type, run the following command: 

```
wmic RECOVEROS set DebugInfoType = <Value>
```

\<Value\> can be 0, 1, 2, or 3, as defined below.

- 0: Disable the removal of a memory dump.
- 1: Full memory dump. Records all of the contents of system memory when your computer stops unexpectedly. A full memory dump may contain data from processes that were running when the memory dump was collected.
- 2: Kernel memory dump (default). Records only the kernel memory. This speeds up the process of recording information in a log file when your computer stops unexpectedly.
- 3: Small memory dump. Records the smallest set of useful information that may help identify why your computer stopped unexpectedly.

## Step 4: Configure the server to restart automatically after generating a memory dump

By default, the server automatically restarts after it generates a memory dump. To view the current configuration, run the following command:

```
wmic RECOVEROS get AutoReboot
```

If the value for **AutoReboot** is TRUE, the server will restart automatically after generating a memory dump. No configuration is needed and you can proceed to the next step.

If the value for **AutoReboot** is FALSE, the server will not restart automatically. Run the following command to change the value:

```
wmic RECOVEROS set AutoReboot = true
```
 
## Step 5: Configure the server to overwrite the existing memory dump file

By default, the server overwrites the existing memory dump file when a new one is created. To determine if existing memory dump files are already configured to be overwritten, run the following command:

```
wmic RECOVEROS get OverwriteExistingDebugFile
```

If the value is 1, the server will overwrite the existing memory dump file. No configuration is needed, and you can proceed to the next step.

If the value is 0, the server won't overwrite the existing memory dump file. Run the following command to change the value: 

```
wmic RECOVEROS set OverwriteExistingDebugFile = 1
```
 
## Step 6: Set an administrative alert

Determine whether an administrative alert is appropriate and set **SendAdminAlert** accordingly. To view the current value for SendAdminAlert, run the following command:

```
wmic RECOVEROS get SendAdminAlert
```

The possible values for SendAdminAlert are TRUE or FALSE. To modify the existing SendAdminAlert value to true, run the following command: 

```
wmic RECOVEROS set SendAdminAlert = true
```
 
## Step 7: Set the memory dump's page file size

To check the current page file settings, run one of the following commands:

   ```
   wmic.exe pagefile
   ```

   or

   ```
   wmic.exe pagefile list /format:list
   ```

For example, run the following command to configure the initial and maximum sizes of your page file:

```
wmic pagefileset where name="c:\\pagefile.sys" set InitialSize=1000,MaximumSize=5000
```

## Step 8: Configure the server to generate a manual memory dump

You can manually generate a memory dump by using a PS/2 keyboard. This feature is disabled by default, and it is not available for Universal Serial Bus (USB) keyboards.

To enable manual memory dumps by using a PS/2 keyboard, run the following command:

```
reg add HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters /v CrashOnCtrlScroll /t REG_DWORD /d 1 /f
```

To determine if the feature has been enabled properly, run the following command:

```
Reg query HKEY_LOCAL_MACHINE \ SYSTEM \ CurrentControlSet \ Services \ i8042prt \ Parameters / v CrashOnCtrlScroll
```

You must restart the server for the changes to take effect. You can restart the server by running the following command:

```
Shutdown / r / t 0
```

You can generate manual memory dumps with a PS/2 keyboard that is connected to your server by holding the RIGHT CTRL key while pressing the SCROLL LOCK key two times. This makes the computer bug check with error code 0xE2. After you restart the server, a new dump file appears in the destination path that you established in step 2.

## Step 9: Verify that memory dump files are being created correctly

You can use the dumpchk.exe utlity to verify that the memory dump files are being created correctly. The dumpchk.exe utility isn't installed with the Server Core installation option, so you'll have to run it from a server with the Desktop Experience or from Windows 10. Additionally, the debugging tools for Windows products must be installed.  

The dumpchk.exe utility lets you transfer the memory dump file from your Server Core installation of Windows Server 2008 to the other computer by using the medium of your choice.

> [!WARNING]
> Page files can be very large, so carefully consider the transfer method and the resources that method requires.
 

Additional References

For general information about using memory dump files, see [Overview of memory dump file options for Windows](https://support.microsoft.com/help/254649/overview-of-memory-dump-file-options-for-windows).

For more information about dedicated dump files, see [How to use the DedicatedDeumpFile registry value to overcome space limitations on the system drive while capturing a system memory dump](https://blogs.msdn.microsoft.com/ntdebugging/2010/04/02/how-to-use-the-dedicateddumpfile-registry-value-to-overcome-space-limitations-on-the-system-drive-when-capturing-a-system-memory-dump/).



