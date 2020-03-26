---
title: Netsh Command Syntax, Contexts, and Formatting
description: You can use this topic to learn how to enter netsh contexts and subcontexts, understand netsh syntax and command formatting, and how to run netsh commands on local and remote computers that are running Windows Server 2016 or Windows 10.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 8cb9b59f-0255-4261-b49a-562c5ea50ee0
manager: brianlic
ms.author: lizross
author: eross-msft
---

# Netsh Command Syntax, Contexts, and Formatting

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn how to enter netsh contexts and subcontexts, understand netsh syntax and command formatting, and how to run netsh commands on local and remote computers.

Netsh is a command-line scripting utility that allows you to display or modify the network configuration of a computer that is currently running. Netsh commands can be run by typing commands at the netsh prompt and they can be used in batch files or scripts. Remote computers and the local computer can be configured by using netsh commands.

Netsh also provides a scripting feature that allows you to run a group of commands in batch mode against a specified computer. With netsh, you can save a configuration script in a text file for archival purposes or to help you configure other computers.

## Netsh contexts

Netsh interacts with other operating system components by using dynamic\-link library \(DLL\) files. 

Each netsh helper DLL provides an extensive set of features called a *context*, which is a group of commands specific to a networking server role or feature. These contexts extend the functionality of netsh by providing configuration and monitoring support for one or more services, utilities, or protocols. For example, Dhcpmon.dll provides netsh with the context and set of commands necessary to configure and manage DHCP servers.

### Obtain a list of contexts

You can obtain a list of netsh contexts by opening either command prompt or Windows PowerShell on a computer running Windows Server 2016 or Windows 10. Type the command   **netsh** and press ENTER. Type **/?**, and then press ENTER.

Following is example output for these commands on a computer running Windows Server 2016 Datacenter.

>    ```
>   PS C:\Windows\system32> netsh
>   netsh>/?
>    
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
>     advfirewall branchcache bridge dhcpclient dnsclient firewall http interface ipsec ipsecdosprotection lan namespace netio ras rpc trace wfp winhttp winsock
>    
>    To view help for a command, type the command, followed by a space, and then type ?.
>    ```

### Subcontexts

Netsh contexts can contain both commands and additional contexts, called *subcontexts*. For example, within the Routing context, you can change to the IP and IPv6 subcontexts.

To display a list of commands and subcontexts that you can use within a context, at the netsh prompt, type the context name, and then type either **/?** or **help**. For example, to display a list of subcontexts and commands that you can use in the Routing context, at the netsh prompt \(that is, **netsh&gt;**\), type one of the following:

**routing /?**

**routing help**

To perform tasks in another context without changing from your current context, type the context path of the command you want to use at the netsh prompt. For example, to add an interface named "Local Area Connection" in the IGMP context without first changing to the IGMP context, at the netsh prompt, type:

**routing ip igmp add interface "Local Area Connection" startupqueryinterval=21**

## Running netsh commands

To run a netsh command, you must start netsh from the command prompt by typing **netsh** and then pressing ENTER. Next, you can change to the context that contains the command you want to use. The contexts that are available depend on the networking components that you have installed. For example, if you type **dhcp** at the netsh prompt and press ENTER, netsh changes to the DHCP server context. If you do not have DHCP installed, however, the following message appears:

**The following command was not found: dhcp.**

## Formatting Legend

You can use the following formatting legend to  interpret and use correct netsh command syntax when you run the command at the netsh prompt or in a batch file or script.

- Text in *Italic* is information that you must supply while you type the command. For example, if a command has a parameter named -*UserName*, you must type the actual user name.
- Text in **Bold** is information that you must type exactly as shown while you type the command.
- Text followed by an ellipsis \(...\) is a parameter that can be repeated several times in a command line.
- Text that is between brackets [&nbsp;] is an optional item.
- Text that is between braces {&nbsp;} with choices separated by a pipe provides a set of choices from which you must select only one, such as `{enable|disable}`.
- Text that is formatted with the Courier font is code or program output.

## Running Netsh commands from the command prompt or Windows PowerShell

To start Network Shell and enter netsh at the command prompt or in Windows PowerShell, you can use the following command.

### netsh

Netsh is a command-line scripting utility that allows you to, either locally or remotely, display or modify the network configuration of a currently running computer. Used without parameters, **netsh** opens the Netsh.exe command prompt \(that is, **netsh&gt;**\).

#### Syntax

**netsh**\[ **-a**&nbsp;*AliasFile*\] \[ **-c**&nbsp;*Context* \] \[**-r**&nbsp;*RemoteComputer*\] \[ **-u** \[ *DomainName\\* \] *UserName* \] \[ **-p**&nbsp;*Password* | \*\] \[{*NetshCommand* | **-f**&nbsp;*ScriptFile*}\]

#### Parameters

**`-a`**

Optional. Specifies that you are returned to the **netsh** prompt after running *AliasFile*.

**`AliasFile`**

Optional. Specifies the name of the text file that contains one or more **netsh** commands.

**`-c`**

Optional. Specifies that netsh enters the specified **netsh** context.

**`Context`**

Optional. Specifies the **netsh** context that you want to enter. 

**`-r`**

Optional. Specifies that you want the command to run on a remote computer.

> [!IMPORTANT]
> When you use some netsh commands remotely on another computer with the **netsh –r** parameter, the Remote Registry service must be running on the remote computer. If it is not running, Windows displays a “Network Path Not Found” error message.

***`RemoteComputer`***

Optional. Specifies the remote computer that you want to configure.

**`-u`**

Optional. Specifies that you want to run the netsh command under a user account.

***`DomainName\\`***

Optional. Specifies the domain where the user account is located. The default is the local domain if *DomainName\\* is not specified.

***`UserName`***

Optional. Specifies the user account name.

**`-p`**

Optional. Specifies that you want to provide a password for the user account.

***`Password`***

Optional. Specifies the password for the user account that you specified with **-u** *UserName*.

***`NetshCommand`***

Optional. Specifies the **netsh** command that you want to run.

**`-f`**

Optional. Exits **netsh** after running the script that you designate with *ScriptFile*.

***`ScriptFile`***

Optional. Specifies the script that you want to run.

**`/?`**

Optional. Displays help at the netsh prompt.

> [!NOTE]
> If you specify **`-r`** followed by another command, **netsh** runs the command on the remote computer and then returns to the Cmd.exe command prompt. If you specify **`-r`** without another command, **netsh** opens in remote mode. The process is similar to using **set machine** at the Netsh command prompt. When you use **`-r`**, you set the target computer for the current instance of **netsh** only. After you exit and reenter **netsh**, the target computer is reset as the local computer. You can run **netsh** commands on a remote computer by specifying a computer name stored in WINS, a UNC name, an Internet name to be resolved by the DNS server, or an IP address.

**Typing parameter string values for netsh commands**

Throughout the Netsh command reference there are commands that contain parameters for which a string value is required.

In the case where a string value contains spaces between characters, such as string values that consist of more than one word, it is required that you enclose the string value in quotation marks. For example, for a parameter named **interface** with a string value of **Wireless Network Connection**, use quotation marks around the string value:

**`interface="Wireless Network Connection"`**

