---
title: ftp
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 758335e1-fd8d-448c-a654-993126239dd9
---
# ftp
Transfers files to and from a computer running a File Transfer Protocol \(ftp\) server service. **ftp** can be used interactively or in batch mode by processing ASCII text files. for examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
ftp [-v] [-d] [-i] [-n] [-g] [-s:<FileName>] [-a] [-A] [-x:<SendBuffer>] [-r:<RecvBuffer>] [-b:<AsyncBuffers>][-w:<WindowsSize>]  [-?] [<Host>]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\-v|Suppresses display of remote server responses.|
|\-n|Suppresses auto\-login upon initial connection.|
|\-g|Disables file name globbing.  **Glob** permits the use of the asterisk \(\*\) and question mark \(?\) as wildcard characters in local file and path names. for more information, see [additional references](ftp.md#BKMK_additionalRef).|
|\-s:<FileName>|Specifies a text file that contains **ftp** commands. These commands run automatically after **ftp** starts. This parameter allows no spaces. Use this parameter instead of redirection \(**<**\). **Note:** In Windows 8 and  Windows Server 2012  or later operating systems, the text file must be written in UTF\-8.|
|\-a|Specifies that any local interface can be used when binding the ftp data connection.|
|\-A|Logs onto the ftp server as anonymous.|
|\-x:<SendBuffer>|Overrides the default SO\_SNDBUF size of 8192.|
|\-r:<RecvBuffer>|Overrides the default SO\_RCVBUF size of 8192.|
|\-b:<AsyncBuffers>|Overrides the default async buffer count of 3.|
|\-w:<WindowsSize>|Specifies the size of the transfer buffer. The default window size is 4096 bytes.|
|\-?|Displays help at the command prompt.|
|<host>|Specifies the computer name, IP address, or IPv6 address of the ftp server to which to connect. The host name or address, if specified, must be the last parameter on the line.|

## remarks

-   for more information about **ftp** commands on Windows Server 2003, see [ftp](https://technet.microsoft.com/library/cc756013(v=ws.10).aspx).

-   **ftp** command\-line parameters are case\-sensitive.

-   This command is available only if the **Internet Protocol \(TCP\/IP\)** protocol is installed as a component in the properties of a network adapter in Network Connections.

-   **ftp** can be used interactively. After it is started, **ftp** creates a sub\-environment in which you can use **ftp** commands. You can return to the command prompt by typing the **quit** command. When the **ftp** sub\-environment is running, it is indicated by the **ftp >** command prompt. for more information see the **ftp** commands.

-   **ftp** supports the use of IPv6 when the IPv6 protocol is installed. for more information, see [additional references](ftp.md#BKMK_additionalRef).

## <a name="BKMK_Examples"></a>Examples
To log on to the ftp server named ftp.example.microsoft.com, type:

```
ftp ftp.example.microsoft.com
```

To log on to the ftp server named ftp.example.microsoft.com and run the **ftp** commands contained in a file named resync.txt, type:

```
ftp -s:resync.txt ftp.example.microsoft.com
```

## <a name="BKMK_additionalRef"></a>additional references

-   [IP version 6](https://technet.microsoft.com/library/cc738636(v=ws.10).aspx)

-   [IPv6 applications](https://technet.microsoft.com/library/cc782509(v=ws.10).aspx)

-   [Command-Line Syntax Key](commandline-syntax-key.md)


