---
title: Adprep
no-loc: [Adprep]
description: Learn about adprep command line tool to prepare a forest and domain for a domain controller for Windows Server.
ms.topic: reference
author: dknappettmsft
ms.author: daknappe
ms.date: 04/22/2024

---

# Adprep

Applies to: Windows Server (All supported versions)

The adprep command extends the Active Directory schema and updates permissions as necessary to prepare a forest and domain for a domain controller that runs Windows Server.

`Adprep.exe` is a command-line tool available in Windows Server. You must run **adprep** from an elevated command prompt. To open an elevated command prompt, select **Start**, right-select **Command Prompt**, and then select **Run as administrator**.

Adprep is available in a 32-bit version and a 64-bit version. The 64-bit version runs by default. If you need to run Adprep on a 32-bit computer, run the 32-bit version (Adprep32.exe).

For more information about running `Adprep.exe` and how to resolve errors that can occur when you run it, see [Running Adprep.exe](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd464018(v=ws.10)).

For examples of how this command can be used, see [Examples](#examples).

For more information about running `adprep /forestprep`, see [Prepare a Windows 2000 or Windows Server 2003 Forest Schema for a Domain Controller that Runs Windows Server 2008 or Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753437(v=ws.10)).

For more information about running `adprep /domainprep /gpprep`, see [Prepare a Windows 2000 or Windows Server 2003 Domain for a Domain Controller That Runs Windows Server 2008 or Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754670(v=ws.10)).

For more information about running `adprep /rodcprep`, see [Prepare a Forest for a Read-Only Domain Controller](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771055(v=ws.10)).

## Syntax

adprep {/forestprep | /domainprep | /domainprep /gpprep | /rodcprep | /wssg | /silent }

## Parameters


| Parameter | Description |
|---|---|
| /forestprep | <p>Prepares a forest for the introduction of a domain controller that runs Windows Server. You run this command only once in the forest. You must run this command on the domain controller that holds the schema operations master role (also known as flexible single master operations or FSMO) for the forest. You must be a member of all the following groups to run this command:</p><p><ul><li>The Enterprise Admins group</li><li>The Schema Admins group</li><li>The Domain Admins group of the domain that hosts the schema master</li></ul></p> |
| /domainprep | <p>Prepares a domain for the introduction of a domain controller that runs Windows Server. You run this command after the **forestprep** command finishes and after the changes replicate to all the domain controllers in the forest.</p><p>Run this command in each domain where you plan to add a domain controller that runs Windows Server. You must run this command on the domain controller that holds the infrastructure operations master role for the domain. You must be a member of the Domain Admins group to run this command.</p> |
| <p>/domainprep <p>/gpprep | <p>Performs similar updates to **domainprep**. However, this command also provides updates that are necessary to enable the Resultant Set of Policy (RSOP) Planning Mode functionality. <p>In Active Directory environments that run Microsoft Windows, this command performs updates during off-peak hours. Replicating updates to file system permissions and Active Directory permissions on existing Group Policy objects (GPOs) during off-peak hours minimizes replication traffic. <p>Run this command after the **forestprep** command finishes and after the changes replicate to all domain controllers in the forest. You must run this command on the infrastructure master for the domain. For more information about running this command in Windows Active Directory environments, see [Prepare Your Infrastructure for Upgrade](/previous-versions/windows/it-pro/windows-server-2003/cc783495(v=ws.10)). |
| /rodcprep | This parameter updates permissions on the application directory partitions to enable replication of the partitions to read-only domain controllers (RODCs). This operation runs remotely; it contacts the infrastructure master in each domain to update the permissions. You need to run this command only once in the forest. However, you can rerun this command anytime if it fails to complete successfully because an infrastructure master isn't available. You can run this command on any computer in the forest. You must be a member of the Enterprise Admins group to run this command. |
| /wssg | Returns an expanded set of exit codes, instead of just 0 (Success) and 1 (Failure). |
| /silent | Specifies that no standard output is returned from an operation. This parameter can be used only if /wssg is also used. |
| quit | Returns to the prior menu. |
| Help | Displays Help for this command. |
| ? | Displays Help for this command. |

## Remarks

- To prepare an existing Windows or Windows Server Active Directory environment for a Windows Server domain controller, run the version of adprep included in the Windows Server installation media.

- You can also perform verification steps before and after you run the **adprep** command to help ensure that the operations complete successfully. For more information, see [Steps for Extending the Schema](/previous-versions/windows/it-pro/windows-server-2003/cc773360(v=ws.10)).

## Exit Codes

The following table lists exit codes that Adprep can return after an operation completes.

| Return Code | Description |
|---|---|
| 1 | Failure |
| 2 | Schema conflict error |
| 3 | FSMO role error |
| 4 | Connection error |
| 5 | Schema upgrade error |
| 6 | Unable to modify error |
| 7 | Server busy error |
| 8 | Permission error |
| 9 | Unable to initialize log file error |
| 10 | Not a domain controller |
| 11 | In nonnative mode |
| 12 | Need to run forest update first |
| 13 | Forest update already done |
| 14 | Domain update already done |
| 15 | GPO update already done |
| 16 | Forest update wait replication |

## Examples

The following example prepares a forest for a domain controller that runs Windows Server:

```cli
adprep /forestprep
```

The following example prepares a domain for a domain controller that runs Windows Server:

```cli
adprep /domainprep
```

The following example prepares a domain for an RODC:

```cli
adprep /rodcprep
```

## See also

[Command-Line Syntax Key](/dotnet/standard/commandline/syntax)
