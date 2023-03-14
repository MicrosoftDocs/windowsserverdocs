---
title: net print
description: Reference article for the net print command. This command has been deprecated and isn't guaranteed to be supported in future releases of Windows.
ms.topic: reference
ms.assetid: f59b2015-4698-415d-9a74-09566c466f40
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# net print

> [!IMPORTANT]
> This command has been deprecated. However, you can perform many of the same tasks using the [prnjobs command](prnjobs.md), [Windows Management Instrumentation (WMI)](/windows/win32/wmisdk/wmi-start-page), [PrintManagement in Powershell](/powershell/module/printmanagement), or [Script resources for IT professionals](https://gallery.technet.microsoft.com/ScriptCenter/site/search?f%5B0%5D.Type=RootCategory&f%5B0%5D.Value=printing&f%5B0%5D.Text=Printing).

Displays information about a specified printer queue or a specified print job, or controls a specified print job.

## Syntax

```
net print {\\<computername>\<sharename> | \\<computername> <jobnumber> [/hold | /release | /delete]} [help]
```

### Parameters

| Parameters | Description |
| ---------- | ----------- |
| `\\<computername>\<sharename>` | Specifies (by name) the computer and print queue about which you want to display information. |
| `\\<computername>` | Specifies (by name) the computer that hosts the print job you want to control. If you do not specify a computer, the local computer is assumed. Requires the `<jobnumber>` parameter. |
| `<jobnumber>` | Specifies the number of the print job you want to control. This number is assigned by the computer that hosts the print queue where the print job is sent. After a computer assigns a number to a print job, that number is not assigned to any other print jobs in any queue hosted by that computer. Required when using the `\\<computername>` parameter. |
| `[/hold | /release | /delete]` | Specifies the action to take with the print job. If you specify a job number, but don't specify any action, information about the print job is displayed.<ul><li>**/hold** - Delays the job, allowing other print jobs to bypass it until it is released.</li><li>**/release** - Releases a print job that has been delayed.</li><li>**/delete** - Removes a print job from a print queue.</li></ul> |
| help | Displays help at the command prompt. |

#### Remarks

- The `net print\\<computername>` command displays information about print jobs in a shared printer queue. The following is an example of a report for all print jobs in a queue for a shared printer named *LASER*:

    ```
    printers at \\PRODUCTION
    Name              Job #      Size      Status
    -----------------------------
    LASER Queue       3 jobs               *printer active*
    USER1          84        93844      printing
    USER2          85        12555      Waiting
    USER3          86        10222      Waiting
    ```

- The following is an example of a report for a print job:

    ```
    Job #            35
    Status           Waiting
    Size             3096
    remark
    Submitting user  USER2
    Notify           USER2
    Job data type
    Job parameters
    additional info
    ```

### Examples

To list the contents of the *Dotmatrix* print queue on the *\\Production* computer, type:

```
net print \\Production\Dotmatrix
```

To display information about job number *35* on the *\\Production* computer, type:

```
net print \\Production 35
```

To delay job number *263* on the *\\Production* computer, type:

```
net print \\Production 263 /hold
```

To release job number *263* on the *\\Production* computer, type:

```
net print \\Production 263 /release
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [print command reference](print-command-reference.md)

- [prnjobs command](prnjobs.md)

- [Windows Management Instrumentation (WMI)](/windows/win32/wmisdk/wmi-start-page)

- [PrintManagement in Powershell](/powershell/module/printmanagement)

- [Script resources for IT professionals](https://gallery.technet.microsoft.com/ScriptCenter/site/search?f%5B0%5D.Type=RootCategory&f%5B0%5D.Value=printing&f%5B0%5D.Text=Printing)
