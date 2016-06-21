---
title: Automatic exclusions for Windows Defender
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cbf1e025-73a5-4576-a280-b697bb9aaead
manager: dongill
author: coreyp-at-msft
---
# Automatic exclusions for Windows Defender
This topic introduces automatic exclusions for Windows Defender on Windows Server® 2016 Technical Preview.

Are you looking for information about Windows Defender on Windows® 8 or Windows® 8.1? If so, see the information [Using Windows Defender](http://windows.microsoft.com/windows/using-defender).

## About Windows Defender automatic exclusions
Windows Server 2016 Technical Preview includes Windows Defender. To help ensure security and performance, certain exclusions are needed based on the roles and features you install.

Windows Defender delivers automatic exclusions for Windows Server 2016 Technical Preview roles via the regularly scheduled definition update process. Definitions are published 3 times a day, 7 days a week. The automatic exclusions are used only by real\-time protection scans when a process accesses a file or folder. Scheduled scans and full scans scan all locations.

Automatic exclusions do not appear in the Windows Defender exclusions list. You can create custom exclusions in addition to the automatic exclusions. Custom exclusions take precedence over the automatic exclusions.

Windows Defender uses the Deployment Image Servicing and Management \(DSIM\) tools to determine which roles are installed on your computer.

### Opting out of automatic exclusions
In Windows Server 2016 Technical Preview the predefined exclusions delivered by definition updates only exclude the default paths for a role or feature. If you installed a role or feature in a custom path, or you want to manually control the set of exclusions, you need to opt\-out of the automatic exclusions delivered in definition updates.

> [!WARNING]
> Opting out of automatic exclusions may adversely impact performance, or result in data corruption. The exclusions that are delivered automatically are optimized for Windows Server 2016 Technical Preview roles.

To opt out of automatic exclusions, start a Windows PowerShell console as an administrator, and run the following command:

`Set-MpPreference –DisableAutoExclusions $true`

## Automatic exclusions
The following sections contain the exclusions that are delivered with automatic exclusions file paths and file types.

### Default exclusions for all roles
This section lists the default exclusions for all Windows Server 2016 Technical Preview roles.

-   Windows "temp.edb" files:

    -   *%windir%*\\SoftwareDistribution\\Datastore\\\*\\tmp.edb

    -   *%ProgramData%*\\Microsoft\\Search\\Data\\Applications\\Windows\\\*\\\*.log

-   Windows Update files or Automatic Update files:

    -   *%windir%*\\SoftwareDistribution\\Datastore\\\*\\Datastore.edb

    -   *%windir%*\\SoftwareDistribution\\Datastore\\\*\\edb.chk

    -   *%windir%*\\SoftwareDistribution\\Datastore\\\*\\edb\*.log

    -   *%windir%*\\SoftwareDistribution\\Datastore\\\*\\Edb\*.jrs

    -   *%windir%*\\SoftwareDistribution\\Datastore\\\*\\Res\*.log

-   Windows Security files:

    -   *%windir%*\\Security\\database\\\*.chk

    -   *%windir%*\\Security\\database\\\*.edb

    -   *%windir%*\\Security\\database\\\*.jrs

    -   *%windir%*\\Security\\database\\\*.log

    -   *%windir%*\\Security\\database\\\*.sdb

-   Group Policy files:

    -   *%allusersprofile%*\\NTUser.pol

    -   *%SystemRoot%*\\System32\\GroupPolicy\\Machine\\registry.pol

    -   *%SystemRoot%*\\System32\\GroupPolicy\\User\\registry.pol

-   WINS files:

    -   *%systemroot%*\\System32\\Wins\\\*\\\*.chk

    -   *%systemroot%*\\System32\\Wins\\\*\\\*.log

    -   *%systemroot%*\\System32\\Wins\\\*\\\*.mdb

    -   *%systemroot%*\\System32\\LogFiles\\

    -   *%systemroot%*\\SysWow64\\LogFiles\\

-   File Replication Service \(FRS\) exclusions:

    -   Files in the File Replication Service \(FRS\) working folder. The FRS working folder is specified in the registry key `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NtFrs\Parameters\Working Directory`.

        -   *%windir%*\\Ntfrs\\jet\\sys\\\*\\edb.chk

        -   *%windir%*\\Ntfrs\\jet\\\*\\Ntfrs.jdb

        -   *%windir%*\\Ntfrs\\jet\\log\\\*\\\*.log

    -   FRS Database log files. The FRS Database log file folder is specified in the registry key `HKEY_LOCAL_MACHINE\System\Currentcontrolset\Services\Ntfrs\Parameters\DB Log File Directory`.

        -   *%windir%*\\Ntfrs\\\*\\Edb\*.log

    -   The FRS staging folder. The staging folder is specified in the registry key `HKEY_LOCAL_MACHINE\System\Currentcontrolset\Services\NtFrs\Parameters\Replica Sets\GUID\Replica Set Stage`

        -   *%systemroot%*\\Sysvol\\\*\\Nntfrs\_cmp\*\\

    -   The FRS preinstall folder. This folder is specified by the folder `Replica_root\DO_NOT_REMOVE_NtFrs_PreInstall_Directory`.

        -   *%systemroot%*\\SYSVOL\\domain\\DO\_NOT\_REMOVE\_NtFrs\_PreInstall\_Directory\\\*\\Ntfrs\*\\

    -   The Distributed File System Replication \(DFSR\) database and working folders. These folders are specified by the registry key `HKEY_LOCAL_MACHINE\System\Currentcontrolset\Services\DFSR\Parameters\Replication Groups\GUID\Replica Set Configuration File`.

        -   *%systemdrive%*\\System Volume Information\\DFSR\\$db\_normal$

        -   *%systemdrive%*\\System Volume Information\\DFSR\\FileIDTable\_\*

        -   *%systemdrive%*\\System Volume Information\\DFSR\\SimilarityTable\_\*

        -   *%systemdrive%*\\System Volume Information\\DFSR\\\*.XML

        -   *%systemdrive%*\\System Volume Information\\DFSR\\$db\_dirty$

        -   *%systemdrive%*\\System Volume Information\\DFSR\\$db\_clean$

        -   *%systemdrive%*\\System Volume Information\\DFSR\\$db\_lostl$

        -   *%systemdrive%*\\System Volume Information\\DFSR\\Dfsr.db

        -   *%systemdrive%*\\System Volume Information\\DFSR\\\*.frx

        -   *%systemdrive%*\\System Volume Information\\DFSR\\\*.log

        -   *%systemdrive%*\\System Volume Information\\DFSR\\Fsr\*.jrs

        -   *%systemdrive%*\\System Volume Information\\DFSR\\Tmp.edb

-   Process exclusions

    -   *%systemroot%*\\System32\\dfsr.exe

    -   *%systemroot%*\\System32\\dfsrs.exe

-   Hyper\-V exclusions:

    -   This section lists the file type exclusions, folder exclusions, and process exclusions that are delivered automatically when you install the Hyper\-V role.

        -   File type exclusions:

            -   \*.vhd

            -   \*.vhdx

            -   \*.avhd

            -   \*.avhdx

            -   \*.vsv

            -   \*.iso

            -   \*.rct

            -   \*.vmcx

            -   \*.vmrs

        -   Folder exclusions:

            -   *%ProgramData%*\\Microsoft\\Windows\\Hyper\-V

            -   *%ProgramFiles%*\\Hyper\-V

            -   *%SystemDrive%*\\ProgramData\\Microsoft\\Windows\\Hyper\-V\\Snapshots

            -   *%Public%*\\Documents\\Hyper\-V\\Virtual Hard Disks

        -   Process exclusions:

            -   *%systemroot%*\\System32\\Vmms.exe

            -   *%systemroot%*\\System32\\Vmwp.exe

-   SYSVOL files:

    -   *%systemroot%*\\Sysvol\\Domain\\\*.adm

    -   *%systemroot%*\\Sysvol\\Domain\\\*.admx

    -   *%systemroot%*\\Sysvol\\Domain\\\*.adml

    -   *%systemroot%*\\Sysvol\\Domain\\Registry.pol

    -   *%systemroot%*\\Sysvol\\Domain\\\*.aas

    -   *%systemroot%*\\Sysvol\\Domain\\\*.inf

    -   *%systemroot%*\\Sysvol\\Domain\\\*.Scripts.ini

    -   *%systemroot%*\\Sysvol\\Domain\\\*.ins

    -   *%systemroot%*\\Sysvol\\Domain\\Oscfilter.ini

### Active Directory exclusions
This section lists the exclusions that are delivered automatically when you install Active Directory® Domain Services.

-   NTDS database files. The database files are specified in the registry key `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\DSA Database File`.

    -   %windir%\\Ntds\\ntds.dit

    -   %windir%\\Ntds\\ntds.pat

-   The AD DS transaction log files. The transaction log files are specified in the registry key `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\Database Log Files`.

    -   %windir%\\Ntds\\EDB\*.log

    -   %windir%\\Ntds\\Res\*.log

    -   %windir%\\Ntds\\Edb\*.jrs

    -   %windir%\\Ntds\\Ntds\*.pat

    -   %windir%\\Ntds\\EDB\*.log

    -   %windir%\\Ntds\\TEMP.edb

-   The NTDS working folder. This folder is specified in the registry key `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\NTDS\Parameters\DSA Working Directory`.

    -   %windir%\\Ntds\\Temp.edb

    -   %windir%\\Ntds\\Edb.chk

-   Process exclusions for AD DS and AD DS\-related support files:

    -   %systemroot%\\System32\\ntfrs.exe

    -   %systemroot%\\System32\\lsass.exe

### DHCP Server exclusions
This section lists the exclusions that are delivered automatically when you install the DHCP Server role. The DHCP Server file locations are specified by the *DatabasePath*, *DhcpLogFilePath*, and *BackupDatabasePath* parameters in the registry key `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\DHCPServer\Parameters`

-   *%systemroot%*\\System32\\DHCP\\\*\\\*.mdb

-   *%systemroot%*\\System32\\DHCP\\\*\\\*.pat

-   *%systemroot%*\\System32\\DHCP\\\*\\\*.log

-   *%systemroot%*\\System32\\DHCP\\\*\\\*.chk

-   *%systemroot%*\\System32\\DHCP\\\*\\\*.edb

### DNS Server exclusions
This section lists the file and folder exclusions and the process exclusions that are delivered automatically when you install the DNS Server role.

-   File and folder exclusions for the DNS Server role:

    -   *%systemroot%*\\System32\\Dns\\\*\\\*.log

    -   *%systemroot%*\\System32\\Dns\\\*\\\*.dns

    -   *%systemroot%*\\System32\\Dns\\\*\\\*.scc

    -   *%systemroot%*\\System32\\Dns\\\*\\BOOT

-   Process exclusions for the DNS Server role:

    -   *%systemroot%*\\System32\\dns.exe

### File and Storage Services exclusions
This section lists the file and folder exclusions that are delivered automatically when you install the File and Storage Services role. The exclusions listed below do not include exclusions for the Clustering role.

-   *%SystemDrive%*\\ClusterStorage

-   *%clusterserviceaccount%*\\Local Settings\\Temp

-   *%SystemDrive%*\\mscs

### Print Server exclusions
This section lists the file type exclusions, folder exclusions, and the process exclusions that are delivered automatically when you install the Print Server role.

-   File type exclusions:

    -   \*.shd

    -   \*.spl

-   Folder exclusions. This folder is specified in the registry key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Print\Printers\DefaultSpoolDirectory`:

    -   *%system32%*\\spool\\printers\\\*

-   Process exclusions:

    -   spoolsv.exe

### Web Server exclusions
This section lists the folder exclusions and the process exclusions that are delivered automatically when you install the Web Server role.

-   Folder exclusions:

    -   *%SystemRoot%*\\IIS Temporary Compressed Files

    -   *%SystemDrive%*\\inetpub\\temp\\IIS Temporary Compressed Files

    -   *%SystemDrive%*\\inetpub\\temp\\ASP Compiled Templates

    -   *%systemDrive%*\\inetpub\\logs

    -   *%systemDrive%*\\inetpub\\wwwroot

-   Process exclusions:

    -   *%SystemRoot%*\\system32\\inetsrv\\w3wp.exe

    -   *%SystemRoot%*\\SysWOW64\\inetsrv\\w3wp.exe

    -   *%SystemDrive%*\\PHP5433\\php\-cgi.exe

### Windows Server Update Services exclusions
This section lists the folder exclusions that are delivered automatically when you install the Windows Server Update Services \(WSUS\) role. The WSUS folder is specified in the registry key `HKEY_LOCAL_MACHINE\Software\Microsoft\Update Services\Server\Setup`.

-   *%systemroot%*\\WSUS\\WSUSContent

-   *%systemroot%*\\WSUS\\UpdateServicesDBFiles

-   *%systemroot%*\\SoftwareDistribution\\Datastore

-   *%systemroot%*\\SoftwareDistribution\\Download

## See Also
[Windows Defender Overview for Windows Server Technical Preview](windows-defender\Windows-Defender-Overview-for-Windows-Server-Technical-Preview.md)
[Windows Defender Events](windows-defender\Windows-Defender-Events.md)
[Windows Defender Cmdlets](http://technet.microsoft.com/library/dn433280.aspx)


