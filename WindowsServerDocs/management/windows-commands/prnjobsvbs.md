---
title: prnjobsvbs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5ad34199-7a5a-40c1-8053-bccd5929df43
---
# prnjobsvbs
pauses, resumes, cancels, and lists print jobs.

for examples of how this command can be used, see [Examples](#BKMK_examples).

## Syntax

```
cscript Prnjobs {-z | -m | -x | -l | -?} [-s <ServerName>] 
[-p <printerName>] [-j <JobID>] [-u <UserName>] [-w <Password>]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\-z|pauses the print job specified with the **\-j** parameter.|
|\-m|Resumes the print job specified with the **\-j** parameter.|
|\-x|Cancels the print job specified with the **\-j** parameter.|
|\-l|lists all the print jobs in a print queue.|
|\-s <ServerName>|Specifies the name of the remote computer that hosts the printer that you want to manage. if you do not specify a computer, the local computer is used.|
|\-p <printerName>|Specifies the name of the printer that you want to manage. Required.|
|\-j <JobID>|Specifies \(by ID number\) the print job you want to cancel.|
|\-u <UserName> \-w <Password>|Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. if you do not specify an account, you must be logged on under an account with these permissions for the command to work.|
|\/?|Displays help at the command prompt.|

## remarks

-   The **prnjobsvbs** command is a Visual Basic script located in the %WINdir%\\System32\\printing\_Admin\_Scripts\\<language> directory. To use this command, at a command prompt, type **cscript** followed by the full path to the prnjobsvbs file, or change directories to the appropriate folder. for example:

    ```
    cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnjobsvbs
    ```

-   if the information that you supply contains spaces, use quotation marks around the text \(for example, `"computer Name"`\).

## <a name="BKMK_examples"></a>Examples
To pause a print job with a job ID of 27 sent to the remote computer named HRServer for printing on the printer named colorprinter, type:

```
cscript prnjobsvbs -z -s HRServer -p colorprinter -j 27
```

To list all current print jobs in the queue for the local printer named colorprinter\_2, type:

```
cscript prnjobsvbs -l -p colorprinter_2
```

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[print Command Reference](commands-by-server-role/print-command-reference.md)


