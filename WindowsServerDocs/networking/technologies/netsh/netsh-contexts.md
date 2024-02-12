---
title: Netsh Command Syntax, Contexts, and Formatting
description: Learn about netsh contexts, subcontexts, netsh syntax, and how to run netsh commands on local and remote computers running Windows Server or Windows Client.
ms.topic: article
ms.assetid: 8cb9b59f-0255-4261-b49a-562c5ea50ee0
ms.author: wscontent
author: xelu86
ms.date: 10/02/2023
---

# Netsh command syntax, contexts, and formatting

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Azure Stack HCI, versions 21H2 and 20H2

You can use this article to learn how to enter netsh contexts and subcontexts, understand netsh syntax and command formatting, and how to run netsh commands on local and remote computers.

Netsh is a command-line scripting utility that allows you to display or modify the network configuration of a computer that is currently running. Netsh commands can be run by typing commands at the netsh shell and be used in batch files or scripts. Remote computers and the local computer can be configured by using netsh commands.

Netsh also provides a scripting feature that allows you to run a group of commands in batch mode against a specified computer. With netsh, you can save a configuration script in a text file for archival purposes or to help you configure other computers.

## Syntax

```
netsh
netsh [-a AliasFile] [-c Context] [-r RemoteMachine] [-u [DomainName\]UserName] [-p Password | *] [Command | -f ScriptFile]
```

The following parameters are considered optional.

|Parameter|Description|
|--|--|
|-a|Specifies that you're returned to the **netsh** shell after running **AliasFile**.|
|`AliasFile`|Specifies the name of the text file that contains one or more **netsh** commands.|
|-c|Specifies that netsh enters the specified **netsh** context.|
|`Context`|Specifies the **netsh** context that you want to enter.|
|-r|Specifies that you want the command to run on a remote computer. The **Remote Registry** service must be running on the remote computer. If it's not running, Windows displays a “Network Path Not Found” error message.|
|`RemoteComputer`|Specifies the remote computer that you want to configure.|
|-u|Specifies that you want to run the netsh command under a user account.|
|`DomainName\`|Specifies the domain where the user account is located. The default is the local domain if *DomainName\\* isn't specified.|
|`UserName`|Specifies the user account name.|
|-p|Specifies that you want to provide a password for the user account.|
|`Password`|Specifies the password for the user account that you specified with **-u** *UserName*.|
|`Command`|Specifies the **netsh** command that you want to run.|
|-f|Exits **netsh** after running the script that you designate with *ScriptFile*.|
|`ScriptFile`|Specifies the script that you want to run.|

> [!NOTE]
> If you specify `-r` followed by another command, **netsh** runs the command on the remote computer and then returns to the command prompt. If you specify `-r` without another command, **netsh** opens in remote mode. The process is similar to using **set machine** at the netsh command shell. When you use `-r`, you set the target computer for the current instance of **netsh** only. After you exit and reenter **netsh**, the target computer is reset as the local computer. You can run **netsh** commands on a remote computer by specifying a computer name stored in WINS, a UNC name, an Internet name to be resolved by the DNS server, or an IP address.

## Running netsh commands

To run a netsh command, you must start netsh from the command prompt or PowerShell by typing **netsh** and then pressing ENTER. Next, you can change to the context that contains the command you want to use. The contexts that are available depend on the networking components that you have installed.

For example, if you type **dhcp** in the netsh shell and press ENTER, netsh changes to the DHCP server context. If you don't have the DHCP Server role installed, the following message appears:

```
The following command was not found: dhcp.
```

## Netsh contexts

Netsh interacts with other operating system components by using dynamic-link library (DLL) files.

Each netsh helper DLL provides an extensive set of features called a *context*, which is a group of commands specific to a networking server role or feature. These contexts extend the functionality of netsh by providing configuration and monitoring support for one or more services, utilities, or protocols.

For example, Dhcpmon.dll provides netsh with the context and set of commands necessary to configure and manage DHCP servers.

You can obtain a list of netsh contexts by opening either the command prompt or Windows PowerShell, then type **netsh /?** or **netsh help** and press ENTER.

The following is an example output:

>    ```
>    The following commands are available:
>
>    Commands in this context:
>    ..            - Goes up one context level.
>    ?             - Displays a list of commands.
>    abort         - Discards changes made while in offline mode.
>    add           - Adds a configuration entry to a list of entries.
>    advfirewall   - Changes to the `netsh advfirewall' context.
>    alias         - Adds an alias.
>    branchcache   - Changes to the `netsh branchcache' context.
>    bridge        - Changes to the `netsh bridge' context.
>    bye           - Exits the program.
>    commit        - Commits changes made while in offline mode.
>    delete        - Deletes a configuration entry from a list of entries.
>    dhcpclient    - Changes to the `netsh dhcpclient' context.
>    dnsclient     - Changes to the `netsh dnsclient' context.
>    dump          - Displays a configuration script.
>    exec          - Runs a script file.
>    exit          - Exits the program.
>    firewall      - Changes to the `netsh firewall' context.
>    help          - Displays a list of commands.
>    http          - Changes to the `netsh http' context.
>    interface     - Changes to the `netsh interface' context.
>    ipsec         - Changes to the `netsh ipsec' context.
>    ipsecdosprotection - Changes to the `netsh ipsecdosprotection' context.
>    lan           - Changes to the `netsh lan' context.
>    namespace     - Changes to the `netsh namespace' context.
>    netio         - Changes to the `netsh netio' context.
>    offline       - Sets the current mode to offline.
>    online        - Sets the current mode to online.
>    popd          - Pops a context from the stack.
>    pushd         - Pushes current context on stack.
>    quit          - Exits the program.
>    ras           - Changes to the `netsh ras' context.
>    rpc           - Changes to the `netsh rpc' context.
>    set           - Updates configuration settings.
>    show          - Displays information.
>    trace         - Changes to the `netsh trace' context.
>    unalias       - Deletes an alias.
>    wfp           - Changes to the `netsh wfp' context.
>    winhttp       - Changes to the `netsh winhttp' context.
>    winsock       - Changes to the `netsh winsock' context.
>
>    The following sub-contexts are available:
>    advfirewall branchcache bridge dhcpclient dnsclient firewall http interface ipsec ipsecdosprotection lan namespace netio ras rpc trace wfp winhttp winsock
>
>    To view help for a command, type the command, followed by a space, and then type ?.
>    ```

## Netsh subcontexts

Netsh contexts can contain both commands and additional contexts, called *subcontexts*. For example, within the *interface* context, you can change to the IPv4 and IPv6 subcontexts.

To display a list of commands and subcontexts that you can use within a context, at the netsh shell, type the subcontext name, and then type either **?** or **help**. For example:

> ```
> netsh> interface help
>
> The following commands are available:
>
> Commands in this context:
> 6to4           - Changes to the `netsh interface 6to4' context.
> ?              - Displays a list of commands.
> dump           - Displays a configuration script.
> help           - Displays a list of commands.
> httpstunnel    - Changes to the `netsh interface httpstunnel' context.
> ipv4           - Changes to the `netsh interface ipv4' context.
> ipv6           - Changes to the `netsh interface ipv6' context.
> isatap         - Changes to the `netsh interface isatap' context.
> portproxy      - Changes to the `netsh interface portproxy' context.
> set            - Sets configuration information.
> show           - Displays information.
> tcp            - Changes to the `netsh interface tcp' context.
> teredo         - Changes to the `netsh interface teredo' context.
> udp            - Changes to the `netsh interface udp' context.
>
> The following sub-contexts are available:
> 6to4 httpstunnel ipv4 ipv6 isatap portproxy tcp teredo udp
>
> To view help for a command, type the command, followed by a space, and then type ?.
> ```

To perform tasks in another context without changing from your current context, type the context path of the command you want to use at the netsh shell. For example, to add a static IPv4 address for "NetLAN1" and specify both the subnet mask and gateway, type:

```
netsh interface ipv4 set address "NetLAN1" static <IP_Address> <Subnet_Mask> <Gateway>
```

## Formatting legend

You can use the following formatting legend to interpret and use correct netsh command syntax when you run the command at the netsh shell, in a batch file or script.

- Text in *Italic* is information that you must supply while you type the command. For example, if a command has a parameter named -*UserName*, you must type the actual user name.
- Text in **Bold** is information that you must type exactly as shown while you type the command.
- Text followed by an ellipsis (**...**) is a parameter that can be repeated several times in a command line.
- Text that is between brackets [&nbsp;] is an optional item.
- Text that is between braces {&nbsp;} with choices separated by a pipe provides a set of choices from which you must select only one, such as `{enable|disable}`.
- Text that is formatted with the Courier font is code or program output.

## String values for netsh commands

There are commands that contain parameters for which a string value is required. In the case where a string value contains spaces between characters, it's required that you enclose the string value in double quotation marks.

When setting the **interface** parameter for IPv4 networks with a string value of **Wireless Network Connection** to DHCP, use double quotation marks around the string value. For example:

```
netsh interface ipv4>set address name="Wireless Network Connection" dhcp
```

Alternatively, for network interfaces, the index number can be used in place of the name associated to it. For example:

```
netsh interface ipv4>set address name=15 dhcp
```

To find the name or index of the connected interfaces, you must be in the IPv4 or IPv6 interface subcontext and type **show interfaces**. For example:

```
netsh interface ipv4>show interfaces
```

```
netsh interface ipv6>show interfaces
```

## See also

- [Netsh Command Reference](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754516(v=ws.10))
