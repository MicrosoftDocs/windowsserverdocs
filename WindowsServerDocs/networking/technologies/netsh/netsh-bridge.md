---
title: Netsh Commands for a network bridge of different network adapters.
description: Use netsh bridge commands to create and manage a bridge of network adapters for sharing connectivity.
author: Windows Mobile Connectivity / NetworkUX Team
ms.author: Windows Mobile Connectivity / NetworkUX Team
ms.service: #Required; service per approved list. slug assigned by ACOM.
ms.topic: how-to article 
ms.date: 09/09/2022.
ms.custom: template-how-to #Required; leave this attribute/value as-is.
---

# Netsh bridge commands

Use **netsh bridge** commands to create and manage a network bridge of at least two network adapters to share network connectivity and resources of one network adapter to another.

>[!TIP]
>If you are using Windows PowerShell on a computer running Windows Server or Windows 10, type **netsh** and press Enter. At the netsh prompt, type **bridge** and press Enter to get the netsh bridge prompt.
>
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;netsh bridge\>

<!-- netsh bridge <command> help -->
## display help
Command provides more detailed information about the supported **netsh bridge** commands.

**Syntax**
```powershell
netsh bridge [command] [help | ?]
```

**Parameters**

|Parameter|Description|Requirement|
|---------|--------------------------------------------------------------------------------------------------------------------------|----------|
| **command** | List of supported commands that can be shown with command **netsh bridge help**. | Optional |

---

**Examples**

The following is an example of the command to show all supported netsh bridge commands and its expected result:

> ```
> C:\Windows\system32> netsh bridge help
> 
> The following commands are available:
>
> Commands in this context:
> ?       - Display a list of commands
> help    - Display a list of commands
> list    - Display all available created bridges.
> show    - Displays information (i.e. adapter).
> add     - Add a network adapter onto an existing bridge
> create  - Create a bridge with two user-provided network adapters.
> destroy - Remove ALL bridged network adapters from the existing bridge and destroy the bridge.
> remove  - Remove network adapter from a bridge, and destroy the bridge automatically when all network adapters are removed.
> dump    - Displays a configuration script.
> set     - Sets configuration information
> ```

<!-- "netsh bridge list" command section -->
## list bridge
Command lists all available created bridges, identified by their unique bridge GUIDs.

**Syntax**
```powershell
netsh bridge list
```

**Examples**

The following is an example of this command and its expected result:

> ```
> C:\Windows\system32> netsh bridge list
> -------------------------------------------------------------
> GUID                                Bridge Name
> -------------------------------------------------------------
> {Uniquely generated Bridge GUID}    Network Bridge
> -------------------------------------------------------------
> ```

<!-- "netsh bridge show adapters" command section -->
## show adapter
Command shows the bridgeable network adapters and the network adapters already configured as a single bridge.
Each adapter is identified by its unique ID, which can be adapter GUID or interface index (namely, IfIndex) or Adapter Name.

**Syntax**
```powershell
netsh bridge show adapter
```

**Examples**

The following is an example of this command and its expected result:

> ```
> C:\Windows\system32> netsh bridge show adapter
> ------------------------------------------------------------------------------------------
> IfIndex GUID                        Adapter Name        IsBridged Bridgeable Compatibility
> ------------------------------------------------------------------------------------------
> 1       <Wi-Fi Interface GUID>      Wi-Fi                   No        Yes      disabled
> 4       <Ethernet Interface GUID>   Ethernet                No        Yes      disabled
> ------------------------------------------------------------------------------------------
> ```

<!-- "netsh bridge create bridge <Adapter ID#1> <AdapterID#2>" command section -->
## create bridge
Command creates a bridge of at least two network adapters joining onto the bridge. The two network adapters are required parameters. A successfully created bridge is identified by its unique bridge GUID and can be acquired 
from command **netsh bridge list**.

**Syntax**
```powershell
netsh bridge create [<Adapter ID#1> <Adapter ID#2>]
```

**Parameters**

|Parameter|Description|Requirement|
|---------|--------------------------------------------------------------------------------------------------------------------------|----------|
| **Adapter ID** | Uniquely identifies a network adapter that can join a bridge, and can be acquired from command **netsh bridge show adapters**. An adapter ID can be either of followings: **GUID** or **Adapter Name**, or **IfIndex**  | Required |

---

**Examples**

1. The following is an example of this command providing **IfIndex** parameters, and its expected result:

    > ```
    > C:\Windows\system32> netsh bridge create 1 4
    > Successfully added adapter 1 onto the bridge.
    > Successfully added adapter 4 onto the bridge.
    > ```

2. The following is an example of this command providing **Adapter GUID** parameters, and its expected result:

    > ```
    > C:\Windows\system32> netsh bridge create [<Wi-Fi Interface GUID>] [<Ethernet Interface GUID>]
    > Successfully added adapter <Wi-Fi Interface GUID> onto the bridge.
    > Successfully added adapter <Ethernet Interface GUID> onto the bridge.
    > ```

3. The following is an example of this command providing **Adapter Name** parameters, and its expected result:

    > ```
    > C:\Windows\system32> netsh bridge create "Wi-Fi" "Ethernet"
    > Successfully added adapter Wi-Fi onto the bridge.
    > Successfully added adapter Ethernet onto the bridge.
    > ```

<!-- "netsh bridge add <Adapter ID> to <Bridge GUID>" command section -->
## add adapter to bridge
Command adds a bridgeable network adapter onto an existing bridge.

**Syntax**
```powershell
netsh bridge add [<Adapter ID>] to [<Bridge GUID>]
```

**Parameters**

|Parameter|Description|Requirement|
|---------|--------------------------------------------------------------------------------------------------------------------------|----------|
| **Adapter ID** | Uniquely identifies a network adapter that can join a bridge, and can be acquired from command **netsh bridge show adapters**. An adapter ID can be either of followings: **Adapter GUID** or **Adapter Name**, or **IfIndex**  | Required |
| **Bridge GUID** | GUID uniquely identifies the bridge acquired from command **netsh bridge list**. | Required |

---

**Examples**

The following is an example of this command and its expected result:

> ```
> C:\Windows\system32> netsh bridge add [<Adapter ID>] to [<Bridge GUID>]
> Successfully added adapter <Adapter ID> to <Bridge GUID>
> ```

<!-- "netsh bridge remove <Adapter ID> from <Bridge GUID>" command section -->
## remove adapter from bridge
Command removes a bridged network adapter from an existing bridge.

**Syntax**
```powershell
netsh bridge remove [<Adapter ID>] from [<Bridge GUID>]
```

**Parameters**

|Parameter|Description|Requirement|
|---------|--------------------------------------------------------------------------------------------------------------------------|----------|
| **Adapter ID** | Uniquely identifies a network adapter that can join a bridge, and can be acquired from command netsh bridge show adapters. An adapter ID can be either of followings: **GUID** or **Adapter Name**, or **IfIndex**  | Required |
| **Bridge GUID** | GUID uniquely identifies the bridge acquired from command **netsh bridge list**. | Required |

---

**Examples**

The following is an example of this command and its expected result:

> ```
> C:\Windows\system32> netsh bridge remove [<Adapter ID>] from [<Bridge GUID>]
> Successfully removed adapter <Adapter ID> from bridge.
> ```

<!-- "netsh bridge remove all from <Bridge GUID>" command section -->
## remove all adapters
Command removes all bridged network adapters from an existing bridge and then destroys the bridge.

**Syntax**
```powershell
netsh bridge remove all from [<Bridge GUID>]
```

**Parameters**

|Parameter|Description|Requirement|
|---------|--------------------------------------------------------------------------------------------------------------------------|----------|
| **Bridge GUID** | GUID uniquely identifies the bridge acquired from command **netsh bridge list**. | Required |

---

**Examples**

The following is an example of this command and its expected result:

> ```
> C:\Windows\system32> netsh bridge remove all from [<Bridge GUID>]
> Successfully destroyed bridge <Bridge GUID>.
> ```

<!-- "netsh bridge destroy <Bridge GUID>" command section -->
## destroy bridge
Command removes all bridged network adapters from an existing bridge and then destroys the bridge.

**Syntax**
```powershell
netsh bridge destroy [<Bridge GUID>]
```

**Parameters**

|Parameter|Description|Requirement|
|---------|--------------------------------------------------------------------------------------------------------------------------|----------|
| **Bridge GUID** | GUID uniquely identifies the bridge acquired from command **netsh bridge list**. | Required |

---

**Examples**

The following is an example of this command and its expected result:

> ```
> C:\Windows\system32> netsh bridge destroy [<Bridge GUID>]
> Successfully destroyed bridge <Bridge GUID>.
> ```

---