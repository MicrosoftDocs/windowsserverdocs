---
title: Network shell (netsh)
description: Overview of Network shell (netsh), a command-line utility for displaying or modifying the network configuration of a local or remote Windows computer.
ms.topic: overview
ms.author: alalve
author: xelu86
ms.date: 07/23/2025
---

# Network shell (netsh)

Network shell (netsh) is a command-line utility that allows you to configure and display the status of various network communications server roles and components after they're installed on computers running Windows Server.

Some client technologies, such as Dynamic Host Configuration Protocol (DHCP) client and BranchCache, also provide netsh commands that allow you to configure client computers that are running Windows 10.

In most cases, netsh commands provide the same functionality that is available when you use the Microsoft Management Console (MMC) snap-in for each networking server role or networking feature. For example, you can configure Network Policy Server (NPS) by using either the NPS MMC snap-in or the netsh commands in the `netsh nps` context.

In addition, there are netsh commands for network technologies, such as for IPv6, network bridge, and Remote Procedure Call (RPC), that aren't available in Windows Server as an MMC snap-in.

> [!IMPORTANT]
> It's recommended that you use Windows PowerShell to manage networking technologies in Windows and Windows Server rather than `netsh`.

## Example syntax

```
netsh [-a <Aliasfile>][-c <Context>][-r <Remotecomputer>][-u [<domainname>\<username>][-p <Password> | [{<NetshCommand> | -f <scriptfile>}]
```

The following parameters are optional.

| Parameter | Description |
| --------- | ----------- |
|:::no-loc text="-a":::|Specifies that you want to return to the netsh shell after running `AliasFile`.|
|`AliasFile`|Specifies the name of the text file that contains one or more netsh commands.|
|:::no-loc text="-c":::|Specifies that netsh enters the specified netsh context.|
|`Context`|Specifies the netsh context that you want to enter.|
|:::no-loc text="-r":::|Specifies that you want the command to run on a remote computer. The Remote Registry service must be running on the remote computer. If it's not running, Windows displays a "Network Path Not Found" error message.|
|`RemoteComputer`|Specifies the remote computer that you want to configure.|
|:::no-loc text="-u":::|Specifies that you want to run the netsh command under a user account.|
|`DomainName\`|Specifies the domain where the user account is located. The default is the local domain if *DomainName\\* isn't specified.|
|`UserName`|Specifies the user account name.|
|:::no-loc text="-p":::|Specifies that you want to provide a password for the user account.|
|`Password`|Specifies the password for the user account that you specified with `-u` *UserName*.|
|`Command`|Specifies the netsh command that you want to run.|
|:::no-loc text="-f":::|Specifies that you want to exit netsh after it runs the script that you designate with *ScriptFile*.|
|`ScriptFile`|Specifies the script that you want to run.|

If you specify `-r` followed by another command, netsh runs the command on the remote computer and then returns to the command prompt. If you specify `-r` without another command, netsh opens in remote mode. The process is similar to using `set machine` at the netsh command shell. When you use `-r`, you set the target computer for the current instance of netsh only.

If your string value contains spaces between characters, you must enclose the string value in quotation marks. For example, `-r "contoso remote device"`. After you exit and reenter `netsh`, the target computer is reset as the local computer. You can run netsh commands on a remote computer by specifying a computer name stored in WINS, a UNC name, an internet name to be resolved by the DNS server, or an IP address.

> [!NOTE]
> To use certain netsh commands, such as the `netsh firewall` commands remotely on another computer by using the netsh `–r` parameter, the **Remote Registry** service must be running on the remote computer. If this service isn't running, you might receive a network communication error message.

## Running netsh commands

Running `netsh` commands can be performed using an elevated command prompt or PowerShell window. You can change to the context that contains the command you want to use depending on the networking components that are installed.

For example, if you type `netsh`, you're taken directly into the network shell. Once here, if you type `dhcp` and press **Enter**, you're taken into the context menu for `dhcpclient` commands.

### Command contexts

Netsh interacts with other operating system components by using dynamic-link library (DLL) files. Each netsh helper DLL provides an extensive set of features called a *context*, which is a group of commands that's specific to a networking server role or feature. These contexts extend the functionality of netsh by providing configuration and monitoring support for one or more services, utilities, or protocols.

For example, dhcpmon.dll provides netsh with the context and set of commands necessary to configure and manage DHCP servers.

You can obtain a list of netsh contexts by running `netsh ?` or `netsh help` and pressing **Enter**.

Here's an example output:

```
The following commands are available:

Commands in this context:
..            - Goes up one context level.
?             - Displays a list of commands.
abort         - Discards changes made while in offline mode.
add           - Adds a configuration entry to a list of entries.
advfirewall   - Changes to the 'netsh advfirewall' context.
alias         - Adds an alias.
branchcache   - Changes to the 'netsh branchcache' context.
bridge        - Changes to the 'netsh bridge' context.
bye           - Exits the program.
commit        - Commits changes made while in offline mode.
delete        - Deletes a configuration entry from a list of entries.
dhcpclient    - Changes to the 'netsh dhcpclient' context.
dnsclient     - Changes to the 'netsh dnsclient' context.
dump          - Displays a configuration script.
exec          - Runs a script file.
exit          - Exits the program.
firewall      - Changes to the 'netsh firewall' context.
help          - Displays a list of commands.
http          - Changes to the 'netsh http' context.
interface     - Changes to the 'netsh interface' context.
ipsec         - Changes to the 'netsh ipsec' context.
ipsecdosprotection - Changes to the 'netsh ipsecdosprotection' context.
lan           - Changes to the 'netsh lan' context.
namespace     - Changes to the 'netsh namespace' context.
netio         - Changes to the 'netsh netio' context.
offline       - Sets the current mode to offline.
online        - Sets the current mode to online.
popd          - Pops a context from the stack.
pushd         - Pushes current context on stack.
quit          - Exits the program.
ras           - Changes to the 'netsh ras' context.
rpc           - Changes to the 'netsh rpc' context.
set           - Updates configuration settings.
show          - Displays information.
trace         - Changes to the 'netsh trace' context.
unalias       - Deletes an alias.
wfp           - Changes to the 'netsh wfp' context.
winhttp       - Changes to the 'netsh winhttp' context.
winsock       - Changes to the 'netsh winsock' context.

The following sub-contexts are available:
advfirewall branchcache bridge dhcpclient dnsclient firewall http interface ipsec lan mbn namespace netio nlm ras rpc trace wcn wfp winhttp winsock wlan

To view help for a command, type the command, followed by a space, and then type ?.
```

## Command subcontexts

The contexts might also include both commands and nested contexts known as *subcontexts*. For instance, the *interface* context contains subcontexts such as *ipv4* and *ipv6*, which allow you to manage specific network interface settings. For example:

```
netsh> interface help

The following commands are available:

Commands in this context:
6to4           - Changes to the 'netsh interface 6to4' context.
?              - Displays a list of commands.
dump           - Displays a configuration script.
fl48           - Changes to the 'netsh interface fl48' context.
fl68           - Changes to the 'netsh interface fl68' context.
help           - Displays a list of commands.
httpstunnel    - Changes to the 'netsh interface httpstunnel' context.
ipv4           - Changes to the 'netsh interface ipv4' context.
ipv6           - Changes to the 'netsh interface ipv6' context.
isatap         - Changes to the 'netsh interface isatap' context.
portproxy      - Changes to the 'netsh interface portproxy' context.
set            - Sets configuration information.
show           - Displays information.
tcp            - Changes to the 'netsh interface tcp' context.
teredo         - Changes to the 'netsh interface teredo' context.
udp            - Changes to the 'netsh interface udp' context.

The following sub-contexts are available:
 6to4 fl48 fl68 httpstunnel ipv4 ipv6 isatap portproxy tcp teredo udp

To view help for a command, type the command, followed by a space, and then
 type ?.
```

To perform tasks in another context without changing from your current context, type the context path of the command you want to use at the netsh shell. For example, to add a static IPv4 address for "NetLAN1" and specify both the subnet mask and gateway, type:

```
netsh interface ipv4 set address "NetLAN1" static <IP_Address> <Subnet_Mask> <Gateway>
```

## Formatting legend

You can use the following formatting legend to interpret and use correct command syntax when running commands interactively, in a batch file, or a script.

- Text in *italic* is information that you must supply when you type the command. For example, if a command has a parameter named -*UserName*, you must type the actual user name.
- Text in **bold** is information that you must type exactly as shown when you type the command.
- Text followed by an ellipsis **...** is a parameter that can be repeated several times in a command line.
- Text that's between brackets **[ ]** is an optional item.
- Text that's between braces **{ }** with choices separated by a pipe provides a set of choices from which you must select only one, such as `{enable|disable}`.
- Text that's formatted with the Courier font is code or program output.

## String values for netsh commands

There are commands that contain parameters for which a string value is required. In the case where a string value contains spaces between characters, you're required to enclose the string value in double quotation marks.

When setting the `interface` parameter for IPv4 networks with a string value of **Wireless Network Connection** to DHCP, use double quotation marks around the string value. For example:

```
netsh interface ipv4>set address name="Wireless Network Connection" dhcp
```

Alternatively, for network interfaces, the index number can be used in place of the name associated to it. For example:

```
netsh interface ipv4>set address name=15 dhcp
```

To find the name or index of the connected interfaces, you must be in the IPv4 or IPv6 interface subcontext and type `show interfaces`. For example:

```
netsh interface ipv4>show interfaces
```

```
netsh interface ipv6>show interfaces
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
