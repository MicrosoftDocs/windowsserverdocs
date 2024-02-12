---
title: prnport
description: Reference article for the prnport command, which creates, deletes, and lists standard TCP/IP printer ports, in addition to displaying and changing port configuration.
ms.topic: reference
ms.assetid: 6a0ec638-a21e-4a34-be5c-bd0f7ca89ffe
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# prnport

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creates, deletes, and lists standard TCP/IP printer ports, in addition to displaying and changing port configuration. This command is a Visual Basic script located in the `%WINdir%\System32\printing_Admin_Scripts\<language>` directory. To use this command at a command prompt, type **cscript** followed by the full path to the prnport file, or change directories to the appropriate folder. For example: `cscript %WINdir%\System32\printing_Admin_Scripts\en-US\prnport`.

## Syntax

```
cscript prnport {-a | -d | -l | -g | -t | -?} [-r <portname>] [-s <Servername>] [-u <Username>] [-w <password>] [-o {raw | lpr}] [-h <Hostaddress>] [-q <Queuename>] [-n <portnumber>] -m{e | d} [-i <SNMPindex>] [-y <communityname>] -2{e | -d}
```

### Parameters

| Parameter | Description |
|--|--|
| -a | Creates a standard TCP/IP printer port. |
| -d | Deletes a standard TCP/IP printer port. |
| -l | Lists all standard TCP/IP printer ports on the computer specified by the **-s** parameter. |
| -g | Displays the configuration of a standard TCP/IP printer port. |
| -t | Configures the port settings for a standard TCP/IP printer port. |
| -r `<portname>` | Specifies the port to which the printer is connected. |
| -s `<Servername>` | Specifies the name of the remote computer that hosts the printer that you want to manage. If you don't specify a computer, the local computer is used. |
| -u `<Username>` -w `<password>` | Specifies an account with permissions to connect to the computer that hosts the printer that you want to manage. All members of the target computer's local Administrators group have these permissions, but the permissions can also be granted to other users. If you don't specify an account, you must be logged on under an account with these permissions for the command to work. |
| -o `{raw|lpr}` | Specifies which protocol the port uses: TCP raw or TCP lpr. The TCP raw protocol is a higher performance protocol on Windows than the lpr protocol. If you use TCP raw, you can optionally specify the port number by using the **-n** parameter. The default port number is 9100. |
| -h `<Hostaddress>` | Specifies (by IP address) the printer for which you want to configure the port. |
| -q `<Queuename>` | Specifies the queue name for a TCP raw port. |
| -n `<portnumber>` | Specifies the port number for a TCP raw port. The default port number is 9100. |
| -m`{e|d}` | Specifies whether SNMP is enabled. The parameter **e** enables SNMP. The parameter **d** disables SNMP. |
| -i `<SNMPindex` | Specifies the SNMP index, if SNMP is enabled. For more information, see **Rfc 1759** at the [Rfc editor website](https://www.ietf.org/rfc/rfc1759.txt?number=1759). |
| -y `<communityname>` | Specifies the SNMP community name, if SNMP is enabled. |
| -2`{e|-d}` | Specifies whether double spools (also known as respooling) are enabled for TCP lpr ports. Double spools are necessary because TCP lpr must include an accurate byte count in the control file that is sent to the printer, but the protocol cannot get the count from the local print provider. Therefore, when a file is spooled to a TCP lpr print queue, it is also spooled as a temporary file in the system32 directory. TCP lpr determines the size of the temporary file and sends the size to the server running LPD. The parameter **e** enables double spools. The parameter **d** disables double spools. |
| /? | Displays help at the command prompt. |

#### Remarks

- If the information that you supply contains spaces, use quotation marks around the text (for example, "Computer Name").

### Examples

To display all standard TCP/IP printing ports on the server \\Server1, type:

```
cscript prnport -l -s Server1
```

To delete the standard TCP/IP printing port on the server \\Server1 that connects to a network printer at 10.2.3.4, type:

```
cscript prnport -d -s Server1 -r IP_10.2.3.4
```

To add a standard TCP/IP printing port on the server \\Server1 that connects to a network printer at 10.2.3.4 and uses the TCP raw protocol on port 9100, type:

```
cscript prnport -a -s Server1 -r IP_10.2.3.4 -h 10.2.3.4 -o raw -n 9100
```

To enable SNMP, specify the "public" community name and set the SNMP index to 1 on a network printer at 10.2.3.4 shared by the server \\Server1, type:

```
cscript prnport -t -s Server1 -r IP_10.2.3.4 -me -y public -i 1 -n 9100
```

To add a standard TCP/IP printing port on the local computer that connects to a network printer at 10.2.3.4 and automatically get the device settings from the printer, type:

```
cscript prnport -a -r IP_10.2.3.4 -h 10.2.3.4
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Print Command Reference](print-command-reference.md)
