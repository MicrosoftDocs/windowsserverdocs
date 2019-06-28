---
title: diskraid
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 20aef1e5-7641-47cf-b4eb-cda117f65b6e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# diskraid



DiskRAID is a command-line tool that enables you to configure and manage redundant array of independent (or inexpensive) disks (RAID) storage subsystems.

RAID is a method used to standardize and categorize fault-tolerant disk systems. RAID levels provide various mixes of performance, reliability, and cost. RAID is usually used on servers. Some servers provide three of the RAID levels: Level 0 (striping), Level 1 (mirroring), and Level 5 (striping with parity).

A hardware RAID subsystem distinguishes physically addressable storage units from one another by using a Logical Unit Number (LUN). A LUN object must have at least one plex, and can have any number of additional plexes. Each plex contains a copy of the data on the LUN object. Plexes can be added to and removed from a LUN object.

Most DiskRAID commands operate on a specific host bus adapter (HBA) port, initiator adapter, initiator portal, provider, subsystem, controller, port, drive, LUN, target portal, target, or target portal group. You use the SELECT command to select an object. The selected object is said to have focus. Focus simplifies common configuration tasks, such as creating multiple LUNs within the same subsystem.

> [!NOTE]
> The DiskRAID command-line tool works only with storage subsystems that support Virtual Disk Service (VDS).

## DiskRAID commands

To view the command syntax, click a command:
-   [add](#BKMK_1)
-   [associate](#BKMK_2)
-   [automagic](#BKMK_3)
-   [break](#BKMK_4)
-   [chap](#BKMK_5)
-   [create](#BKMK_6)
-   [delete](#BKMK_7)
-   [detail](#BKMK_8)
-   [dissociate](#BKMK_9)
-   [exit](#BKMK_10)
-   [extend](#BKMK_11)
-   [flushcache](#BKMK_12)
-   [help](#BKMK_13)
-   [importtarget](#BKMK_14)
-   [initiator](#BKMK_15)
-   [invalidatecache](#BKMK_16)
-   [lbpolicy](#BKMK_18)
-   [list](#BKMK_19)
-   [login](#BKMK_20)
-   [logout](#BKMK_21)
-   [maintenance](#BKMK_22)
-   [name](#BKMK_23)
-   [offline](#BKMK_24)
-   [online](#BKMK_25)
-   [recover](#BKMK_26)
-   [reenumerate](#BKMK_27)
-   [refresh](#BKMK_28)
-   [rem](#BKMK_29)
-   [remove](#BKMK_30)
-   [replace](#BKMK_31)
-   [reset](#BKMK_32)
-   [select](#BKMK_33)
-   [setflag](#BKMK_34)
-   [shrink](#BKMK_shrink)
-   [standby](#BKMK_35)
-   [unmask](#BKMK_36)

### <a name="BKMK_1"></a>add

Adds an existing LUN to the currently selected LUN, or adds an iSCSI target portal to the currently selected iSCSI target portal group.

#### Syntax

```
add plex lun=n [noerr]
add tpgroup tportal=n [noerr]
```

#### Parameters

**plex lun**=*n*

Specifies the LUN number to add as a plex to the currently selected LUN.

> [!CAUTION]
> All data on the LUN being added as a plex will be deleted.

**tpgroup tportal=**<em>n</em>

Specifies the iSCSI target portal number to add to the currently selected iSCSI target portal group.

**noerr**

Specifies that any failures that occur while performing this operation will be ignored. This is useful in script mode.

### <a name="BKMK_2"></a>associate

Sets the specified list of controller ports as active for the currently selected LUN (other controller ports are made inactive), or adds the specified controller ports to the list of existing active controller ports for the currently selected LUN, or associates the specified iSCSI target for the currently selected LUN.

#### Syntax

```
associate controllers [add] <n>[,<n> [,…]]
associate ports [add] <n-m>[,<n-m>[,…]]
associate targets [add] <n>[,<n> [,…]]
```

#### Parameters

**controllers**

For use with VDS 1.0 providers only. Adds to or replaces the list of controllers that are associated with the currently selected LUN.

**ports**

For use with VDS 1.1 providers only. Adds to or replaces the list of controller ports that are associated with the currently selected LUN.

**targets**

For use with VDS 1.1 providers only. Adds to or replaces the list of iSCSI targets that are associated with the currently selected LUN.

**add**

For VDS 1.0 providers, adds the specified controllers to the existing list of controllers associated with the LUN. If this parameter is not specified, the list of controllers replaces the existing list of controllers associated with this LUN.

For VDS 1.1 providers, adds the specified controller ports to the existing list of controller ports associated with the LUN. If this parameter is not specified, the list of controller ports replaces the existing list of controller ports associated with this LUN.
```
<n>[,<n> [, ...]]
```
For use with the **controllers** or **targets** parameter. Specifies the numbers of the controllers or iSCSI targets to set to active or associate.
```
<n-m>[,<n-m>[,…]]
```
For use with the **ports** parameter. Specifies the controller ports to set active using a controller number (*n*) and port number (*m*) pair.

#### Example

The following example shows how to associate and add ports to a LUN that uses a VDS 1.1 provider:
```
DISKRAID> SEL LUN 5
LUN 5 is now the selected LUN.

DISKRAID> ASSOCIATE PORTS 0-0,0-1
Controller port associations changed.
(Controller ports active after this command: Ctlr 0 Port 0, Ctlr 0 Port 1)

DISKRAID> ASSOCIATE PORTS ADD 1-1
Controller port associations changed.
(Controller ports active after this command: Ctlr 0 Port 0, Ctlr 0 Port 1, Ctlr 1 Port 1)
```

### <a name="BKMK_3"></a>automagic

Sets or clears flags that give hints to providers on how to configure a LUN. Used with no parameters, the **automagic** operation displays a list of flags.

#### Syntax

```
automagic {set | clear | apply} all <flag=value> [<flag=value> [...]]
```

#### Parameters

**set**

Sets the specified flags to the specified values.

**clear**

Clears the specified flags. The **all** keyword clears all the automagic flags.

**apply**

Applies the current flags to the selected LUN.

\<flag>

Flags are identified by three-letter acronyms.

|Flag|Description|
|----|-----------|
|FCR|Fast Crash Recovery Required|
|FTL|Fault Tolerant|
|MSR|Mostly Reads|
|MXD|Maximum Drives|
|MXS|Maximum Size Expected|
|ORA|Optimal Read Alignment|
|ORS|Optimal Read Size|
|OSR|Optimize For Sequential Reads|
|OSW|Optimize For Sequential Writes|
|OWA|Optimal Write Alignment|
|OWS|Optimal Write Size|
|RBP|Rebuild Priority|
|RBV|Read Back Verify Enabled|
|RMP|Remap Enabled|
|STS|Stripe Size|
|WTC|Write-Through Caching Enabled|
|YNK|Removable|

### <a name="BKMK_4"></a>break

Removes the plex from the currently selected LUN. The plex and the data it contained are not retained, and the drive extents may be reclaimed.

#### Syntax

```
break plex=<plex_number> [noerr]
```

#### Parameters

**plex**

Specifies the number of the plex to remove. The plex and the data it contained will not be retained, and the resources used by this plex will be reclaimed. The data contained on the LUN is not guaranteed to be consistent. If you want to retain this plex, use the Volume Shadow Copy Service (VSS).

**noerr**

Specifies that any failures that occur while performing this operation will be ignored. This is useful in script mode.

#### Remarks

> [!NOTE]
> You must first select a mirrored LUN before using the **break** command.

> [!CAUTION]
> All data on the plex will be deleted.

> [!CAUTION]
> All data contained on the original LUN is not guaranteed to be consistent.

### <a name="BKMK_5"></a>chap

Sets the Challenge Handshake Authentication Protocol (CHAP) shared secret so that iSCSI initiators and iSCSI targets can communicate with one another.

#### Syntax

```
chap initiator set secret=[<secret>] [target=<target>]
chap initiator remember secret=[<secret>] target=<target>
chap target set secret=[<secret>] [initiator=<initiatorname>]
chap target remember secret=[<secret>] initiator=<initiatorname>
```

#### Parameters

**initiator set**

Sets the shared secret in the local iSCSI initiator service used for mutual CHAP authentication when the initiator authenticates the target.

**initiator remember**

Communicates the CHAP secret of an iSCSI target to the local iSCSI initiator service so that the initiator service can use the secret in order to authenticate itself to the target during CHAP authentication.

**target set**

Sets the shared secret in the currently selected iSCSI target used for CHAP authentication when the target authenticates the initiator.

**target remember**

Communicates the CHAP secret of an iSCSI initiator to the current in-focus iSCSI target so that the target can use the secret in order to authenticate itself to the initiator during mutual CHAP authentication.

**secret**

Specifies the secret to use. If empty the secret will be cleared.

**target**

Specifies a target in the currently selected subsystem to associate with the secret. This is optional when setting a secret on the initiator and leaving it out indicates that the secret will be used for all targets that do not already have an associated secret.

**initiatorname**

Specifies an initiator iSCSI name to associate with the secret. This is optional when setting a secret on a target and leaving it out indicates that the secret will be used for all initiators that do not already have an associated secret.

### <a name="BKMK_6"></a>create

Creates a new LUN or iSCSI target on the currently selected subsystem, or creates a target portal group on the currently selected target. You can view the actual binding using the **DiskRAID list** command.

#### Syntax

```
create lun simple [size=<n>] [drives=<n>] [noerr]
create lun stripe [size=<n>] [drives=<n, n> [,...]]  [stripesize=<n>] [noerr]
create lun raid [size=<n>] [drives=<n, n> [,...]] [stripesize=<n>] [noerr]
create lun mirror [size=<n>] [drives=<n, n> [,...]] [stripesize=<n>] [noerr]
create lun automagic size=<n> [noerr]
create target name=<name> [iscsiname=<iscsiname>] [noerr]
create tpgroup [noerr]
```

#### Parameter

**simple**

Creates a simple LUN.

**stripe**

Creates a striped LUN.

**RAID**

Creates a striped LUN with parity.

**mirror**

Creates a mirrored LUN.

**automagic**

Creates a LUN using the *automagic* hints currently in effect. See the **automagic** sub-command for more information.

**size**=

Specifies the total LUN size in megabytes. If the **size=** parameter is not specified, the LUN created will be the largest possible size allowed by all the specified drives.

A provider typically creates a LUN at least as big as the requested size, but the provider may have to round up to the next largest size in some cases. For example, if size is specified as .99 GB and the provider can only allocate GB disk extents, the resulting LUN would be 1 GB.

To specify the size using other units, use one of the following recognized suffixes immediately after the size:
-   **B** for byte.
-   **KB** for kilobyte.
-   **MB** for megabyte.
-   **GB** for gigabyte.
-   **TB** for terabyte.
-   **PB** for petabyte.

**drives**=

Specifies the *drive_number* for the drives to use to create a LUN. If the **size=** parameter is not specified, the LUN created is the largest possible size allowed by all the specified drives. If the **size=** parameter is specified, providers will select drives from the specified drive list to create the LUN. Providers will attempt to use the drives in the order specified when possible.

**stripesize**=

Specifies the size in megabytes for a *stripe* or *RAID* LUN. The stripesize cannot be changed after the LUN is created.

To specify the size using other units, use one of the following recognized suffixes immediately after the size:
-   **B** for byte.
-   **KB** for kilobyte.
-   **MB** for megabyte.
-   **GB** for gigabyte.
-   **TB** for terabyte.
-   **PB** for petabyte.

**target**

Creates a new iSCSI target on the currently selected subsystem.

**name**

Supplies the friendly name for the target.

**iscsiname**

Supplies the iSCSI name for the target and can be omitted to have the provider generate a name.

**tpgroup**

Creates a new iSCSI target portal group on the currently selected target.

**noerr**

Specifies that any failures that occur while performing this operation will be ignored. This is useful in script mode.

#### Remarks

-   Either the **size**= or the **drives**= parameter must be specified. They can also be used together.
-   The stripe size for a LUN cannot be changed after creation.

### <a name="BKMK_7"></a>delete

Deletes the currently selected LUN, iSCSI target (as long as there are not any LUNs associated with the iSCSI target) or iSCSI target portal group.

#### Syntax

```
delete lun [uninstall] [noerr]
delete target [noerr]
delete tpgroup [noerr]
```

#### Parameters

**lun**

Deletes the currently selected LUN and all data on it.

**uninstall**

Specifies that the disk on the local system associated with the LUN will be cleaned up before the LUN is deleted.

**target**

Deletes the currently selected iSCSI target if no LUNs are associated with the target.

**tpgroup**

Deletes the currently selected iSCSI target portal group.

**noerr**

Specifies that any failures that occur while performing this operation will be ignored. This is useful in script mode.

### <a name="BKMK_8"></a>detail

Displays detailed information about the currently selected object of the specified type.

#### Syntax

```
Detail {hbaport | iadapter | iportal | provider | subsystem | controller | port | drive | lun | tportal | target | tpgroup} [verbose]
```

#### Parameters

**hbaport**

Lists detailed information about the currently selected host bus adapter (HBA) port.

**iadapter**

Lists detailed information about the currently selected iSCSI initiator adapter.

**iportal**

Lists detailed information about the currently selected iSCSI initiator portal.

**provider**

Lists detailed information about the currently selected provider.

**subsystem**

Lists detailed information about the currently selected subsystem.

**controller**

Lists detailed information about the currently selected controller.

**port**

Lists detailed information about the currently selected controller port.

**drive**

Lists detailed information about the currently selected drive, including the occupying LUNs.

**lun**

Lists detailed information about the currently selected LUN, including the contributing drives. The output differs slightly depending on whether the LUN is part of a Fibre Channel or iSCSI subsystem. If the Unmasked Hosts list contains only an asterisk, this means that the LUN is unmasked to all hosts.

**tportal**

Lists detailed information about the currently selected iSCSI target portal.

**target**

Lists detailed information about the currently selected iSCSI target.

**tpgroup**

Lists detailed information about the currently selected iSCSI target portal group.

**verbose**

For use only with the LUN parameter. Lists additional information, including its plexes.

### <a name="BKMK_9"></a>dissociate

Sets specified list of controller ports as inactive for the currently selected LUN (other controller ports are not affected), or dissociates the specified list of iSCSI targets for the currently selected LUN.

#### Syntax

```
dissociate controllers <n> [,<n> [,...]]
dissociate ports <n-m>[,<n-m>[,…]]
dissociate targets <n> [,<n> [,…]]
```

#### Parameter

**controllers**

For use with VDS 1.0 providers only. Removes controllers from the list of controllers that are associated with the currently selected LUN.

**ports**

For use with VDS 1.1 providers only. Removes controller ports from the list of controller ports that are associated with the currently selected LUN.

**targets**

For use with VDS 1.1 providers only. Removes targets from the list of iSCSI targets that are associated with the currently selected LUN.
```
<n> [,<n> [,…]]
```
For use with the **controllers** or **targets** parameter. Specifies the numbers of the controllers or iSCSI targets to set as inactive or dissociate.
```
<n-m>[,<n-m>[,…]]
```
For use with the **ports** parameter. Specifies the controller ports to set as inactive by using a controller number (*n*) and port number (*m*) pair.

#### Example

```
DISKRAID> SEL LUN 5
LUN 5 is now the selected LUN.

DISKRAID> ASSOCIATE PORTS 0-0,0-1
Controller port associations changed.
(Controller ports active after this command: Ctlr 0 Port 0, Ctlr 0 Port 1)

DISKRAID> ASSOCIATE PORTS ADD 1-1
Controller port associations changed.
(Controller ports active after this command: Ctlr 0 Port 0, Ctlr 0 Port 1, Ctlr 1 Port 1)

DISKRAID> DISSOCIATE PORTS 0-0,1-1
Controller port associations changed.
(Controller ports active after this command: Ctlr 0 Port 1)
```

### <a name="BKMK_10"></a>exit

Exits DiskRAID.

#### Syntax

```
exit
```

### <a name="BKMK_11"></a>extend

Extends the currently selected LUN by adding sectors to the end of the LUN. Not all providers support extending LUNs. Does not extend any volumes or file systems contained on the LUN. After you extend the LUN, you should extend the associated on-disk structures using the **DiskPart extend** command.

#### Syntax

```
extend lun [size=<LUN_size>] [drives=<drive_number>, [<drive_number>, ...]] [noerr]
```

#### Parameters

**size=**

Specifies the size in megabytes to extend the LUN. If the **size=** parameter is not specified, the LUN is extended by the largest possible size allowed by all the specified drives. If the **size=** parameter is specified, providers select drives from the list specified by the **drives=** parameter to create the LUN.

To specify the size using other units, use one of the following recognized suffixes immediately after the size:
-   **B** for byte.
-   **KB** for kilobyte.
-   **MB** for megabyte.
-   **GB** for gigabyte.
-   **TB** for terabyte
-   **PB** for petabyte

**drives=**

Specifies the \<drive_number> for the drives to use when creating a LUN. If the **size=** parameter is not specified, the LUN created is the largest possible size allowed by all the specified drives. Providers use the drives in the order specified when possible.

**noerr**

Specifies that any failures that occur while performing this operation should be ignored. This is useful in script mode.

#### Remarks

Either the *size* or the \<drive> parameter must be specified. They can also be used together.

### <a name="BKMK_12"></a>flushcache

Clears the cache on the currently selected controller.

#### Syntax

```
flushcache controller
```

### <a name="BKMK_13"></a>help

Displays a list of all DiskRAID commands.

#### Syntax

```
help
```

### <a name="BKMK_14"></a>importtarget

Retrieves or sets the current Volume Shadow Copy Service (VSS) import target that is set for the currently selected subsystem.

#### Syntax

```
importtarget subsystem [set target]
```

#### Parameter

**set target**

If specified, sets the currently selected target to the VSS import target for the currently selected subsystem. If not specified, the command retrieves the current VSS import target that is set for the currently selected subsystem.

### <a name="BKMK_15"></a>initiator

Retrieves information about the local iSCSI initiator.

#### Syntax

```
initiator
```

### <a name="BKMK_16"></a>invalidatecache

Invalidates the cache on the currently selected controller.

#### Syntax

```
invalidatecache controller
```

### <a name="BKMK_18"></a>lbpolicy

Sets the load balance policy on the currently selected LUN.

#### Syntax

```
lbpolicy set lun type=<type> [paths=<path>-{primary | <weight>}[,<path>-{primary | <weight>}[,…]]]
lbpolicy set lun paths=<path>-{primary | <weight>}[,<path>-{primary | <weight>}[,…]]
```

#### Parameters

**type**

Specifies the load balance policy. If the type is not specified, then the **path** parameter must be specified. Type can be one of the following:

**FAILOVER**: Uses one primary path with other paths being backup paths.

**ROUNDROBIN**: Uses all paths in round-robin fashion, which tries each path sequentially.

**SUBSETROUNDROBIN**: Uses all primary paths in round-robin fashion; backup paths are used only if all primary paths fail.

**DYNLQD**: Uses the path with the least number of active requests.

**WEIGHTED**: Uses the path with the least weight (each path must be assigned a weight).

**LEASTBLOCKS**: Uses the path with the least blocks.

**VENDORSPECIFIC**: Uses a vendor-specific policy.

**paths**

Specifies whether a path is **primary** or has a particular \<weight>. Any paths not specified are implicitly set as backup. Any paths listed must be one of the currently selected LUN’s paths.

### <a name="BKMK_19"></a>list

Displays a list of objects of the specified type.

#### Syntax

```
List {hbaports | iadapters | iportals | providers | subsystems | controllers | ports | drives | LUNs | tportals | targets | tpgroups}
```

#### Parameters

**hbaports**

Lists summary information about all HBA ports known to VDS. The currently selected HBA port is marked by an asterisk (*).

**iadapters**

Lists summary information about all iSCSI initiator adapters known to VDS. The currently selected initiator adapter is marked by an asterisk (*).

**iportals**

Lists summary information about all iSCSI initiator portals in the currently selected initiator adapter. The currently selected initiator portal is marked by an asterisk (*).

**providers**

Lists summary information about each provider known to VDS. The currently selected provider is marked by an asterisk (*).

**subsystems**

Lists summary information about each subsystem in the system. The currently selected subsystem is marked by an asterisk (*).

**controllers**

Lists summary information about each controller in the currently selected subsystem. The currently selected controller is marked by an asterisk (*).

**ports**

Lists summary information about each controller port in the currently selected controller. The currently selected port is marked by an asterisk (*).

**drives**

Lists summary information about each drive in the currently selected subsystem. The currently selected drive is marked by an asterisk (*).

**luns**

Lists summary information about each LUN in the currently selected subsystem. The currently selected LUN is marked by an asterisk (*).

**tportals**

Lists summary information about all iSCSI target portals in the currently selected subsystem. The currently selected target portal is marked by an asterisk (*).

**targets**

Lists summary information about all iSCSI targets in the currently selected subsystem. The currently selected target is marked by an asterisk (*).

**tpgroups**

Lists summary information about all iSCSI target portal groups in the currently selected target. The currently selected portal group is marked by an asterisk (*).

### <a name="BKMK_20"></a>login

Logs the specified iSCSI initiator adapter into the currently selected iSCSI target.

#### Syntax

```
login target iadapter=<iadapter> [type={manual | persistent | boot}] [chap={none | oneway | mutual}] [iportal=<iportal>] [tportal=<tportal>] [<flag> [<flag> […]]]
```

#### Parameters

**type**

Specifies the type of login to perform: **manual**, **persistent**, or **boot**. If unspecified, a manual login will be performed.

**manual** - Login manually.

**persistent** - Automatically use the same login when the computer is restarted.

**boot** - (This option is for future development and is not currently used<em>.</em>)

**chap**

Specifies the type of CHAP authentication to use: **none**, **oneway** CHAP, or **mutual** CHAP; if unspecified, no authentication will be used.

**tportal**

Specifies an optional target portal in the currently selected subsystem to use for the log in.

**iportal**

Specifies an optional initiator portal in the specified initiator adapter to use for the log in.

\<flag>

Identified by three letter acronyms:

**IPS**: Require IPsec

**EMP**: Enable multipath

**EHD**: Enable header digest

**EDD**: Enable data digest

### <a name="BKMK_21"></a>logout

Logs the specified iSCSI initiator adapter out of the currently selected iSCSI target.

#### Syntax

```
logout target iadapter= <iadapter>
```

#### Parameters

**iadapter**

Specifies the initiator adapter with a login session to logout from.

### <a name="BKMK_22"></a>maintenance

Performs maintenance operations on the currently selected object of the specified type.

#### Syntax

```
maintenance <object operation> [count=<iteration>]
```

#### Parameters

\<object>

Specifies the type of object on which to perform the operation. The *object* type can be a **subsystem**, **controller**, **port, drive** or **LUN**.

\<operation>

Specifies the maintenance operation to perform. The *operation* type can be **spinup**, **spindown**, **blink**, **beep** or **ping**. An *operation* must be specified.

**count=**

Specifies the number of times to repeat the *operation*. This is typically used with **blink**, **beep**,or **ping**.

### <a name="BKMK_23"></a>name

Sets the friendly name of the currently selected subsystem, LUN, or iSCSI target to the specified name.

#### Syntax

```
name {subsystem | lun | target} [<name>]
```

#### Parameter

\<name>

Specifies a name for the subsystem, LUN, or target. The name must be less than 64 characters in length. If no name is supplied, the existing name, if any, is deleted.

### <a name="BKMK_24"></a>offline

Sets the state of the currently selected object of the specified type to **offline**.

#### Syntax

```
offline <object>
```

#### Parameter

\<object>

Specifies the type of object on which to perform this operation. The \<object>

type can be **subsystem**, **controller**, **drive**, **LUN**, or **tportal**.

### <a name="BKMK_25"></a>online

Sets the state of the selected object of the specified type to **online**. If object is **hbaport**, changes the status of the paths to the currently selected HBA port to **online**.

#### Syntax

```
online <object> 
```

#### Parameter

\<object>

Specifies the type of object on which to perform this operation. The \<object>

type can be **hbaport**, **subsystem**, **controller**, **drive**, **LUN**, or **tportal**.

### <a name="BKMK_26"></a>recover

Performs operations necessary, such as resynchronization or hot sparing, to repair the currently selected fault-tolerant LUN. For example, RECOVER might cause a hot spare to be bound to a RAID set that has a failed disk or other disk extent reallocation.

#### Syntax

```
recover <lun>
```

### <a name="BKMK_27"></a>reenumerate

Reenumerates objects of the specified type. If you use the extend LUN command, you must use the refresh command to update the disk size before using the reenumerate command.

#### Syntax

```
reenumerate {subsystems | drives}
```

#### Parameters

**subsystems**

Queries the provider to discover any new subsystems that were added in the currently selected provider.

**drives**

Queries the internal I/O buses to discover any new drives that were added in the currently selected subsystem.

### <a name="BKMK_28"></a>refresh

Refreshes internal data for the currently selected provider.

#### Syntax

```
refresh provider
```

### <a name="BKMK_29"></a>rem

Used to comment scripts.

#### Syntax

```
Rem <comment>
```

### <a name="BKMK_30"></a>remove

Removes the specified iSCSI target portal from the currently selected target portal group.

#### Syntax

```
remove tpgroup tportal=<tportal> [noerr]
```

#### Parameter

**tpgroup tportal=** \<tportal>

Specifies the iSCSI target portal to remove.

**noerr**

Specifies that any failures that occur while performing this operation should be ignored. This is useful in script mode.

### <a name="BKMK_31"></a>replace

Replaces the specified drive with the currently selected drive.

#### Syntax

```
replace drive=<drive_number>
```

#### Parameter

**drive=**

Specifies the \<drive_number> for the drive to be replaced.

#### Remarks

-   The specified drive may not be the currently selected drive.

### <a name="BKMK_32"></a>reset

Resets the currently selected controller or port.

#### Syntax

```
Reset {controller | port}
```

#### Parameters

**controller**

Resets the controller.

**port**

Resets the port.

### <a name="BKMK_33"></a>select

Displays or changes the currently selected object.

#### Syntax

```
Select {hbaport | iadapter | iportal | provider | subsystem | controller | port | drive | lun | tportal | target | tpgroup } [<n>]
```

#### Parameters

**object**

Specifies the type of object to select. The \<object> type can be **provider**, **subsystem**, **controller**, **drive**, or **LUN**.

**hbaport** [\<n>]

Sets the focus to the specified local HBA port. If no HBA port is specified, the command displays the currently selected HBA port (if any). Specifying an invalid HBA port index results in no in-focus HBA port. Selecting an HBA port deselects any selected initiator adapters and initiator portals.

**iadapter** [\<n>]

Sets the focus to the specified local iSCSI initiator adapter. If no initiator adapter is specified, the command displays the currently selected initiator adapter (if any). Specifying an invalid initiator adapter index results in no in-focus initiator adapter. Selecting an initiator adapter deselects any selected HBA ports and initiator portals.

**iportal** [\<n>]

Sets the focus to the specified local iSCSI initiator portal within the selected iSCSI initiator adapter. If no initiator portal is specified, the command displays the currently selected initiator portal (if any). Specifying an invalid initiator portal index results in no selected initiator portal.

**provider** [\<n>]

Sets the focus to the specified provider. If no provider is specified, the command displays the currently selected provider (if any). Specifying an invalid provider index results in no in-focus provider.

**subsystem** [\<n>]

Sets the focus to the specified subsystem. If no subsystem is specified, the command displays the subsystem with focus (if any). Specifying an invalid subsystem index results in no in-focus subsystem. Selecting a subsystem implicitly selects its associated provider.

**controller** [\<n>]

Sets the focus to the specified controller within the currently selected subsystem. If no controller is specified, the command displays the currently selected controller (if any). Specifying an invalid controller index results in no in-focus controller. Selecting a controller deselects any selected controller ports, drives, LUNs, target portals, targets, and target portal groups.

**port** [\<n>]

Sets the focus to the specified controller port within the currently selected controller. If no port is specified, the command displays the currently selected port (if any). Specifying an invalid port index results in no selected port.

**drive** [\<n>]

Sets the focus to the specified drive, or physical spindle, within the currently selected subsystem. If no drive is specified, the command displays the currently selected drive (if any). Specifying an invalid drive index results in no in-focus drive. Selecting a drive deselects any selected controllers, controller ports, LUNs, target portals, targets, and target portal groups.

**lun** [\<n>]

Sets the focus to the specified LUN within the currently selected subsystem. If no LUN is specified, the command displays the currently selected LUN (if any). Specifying an invalid LUN index results in no selected LUN. Selecting a LUN deselects any selected controllers, controller ports, drives, target portals, targets, and target portal groups.

**tportal** [\<n>]

Sets the focus to the specified iSCSI target portal within the currently selected subsystem. If no target portal is specified, the command displays the currently selected target portal (if any). Specifying an invalid target portal index results in no selected target portal. Selecting a target portal deselects any controllers, controller ports, drives, LUNs, targets, and target portal groups.

**target** [\<n>]

Sets the focus to the specified iSCSI target within the currently selected subsystem. If no target is specified, the command displays the currently selected target (if any). Specifying an invalid target index results in no selected target. Selecting a target deselects any controllers, controller ports, drives, LUNs, target portals, and target portal groups.

**tpgroup** [\<n>]

Sets the focus to the specified iSCSI target portal group within the currently selected iSCSI target. If no target portal group is specified, the command displays the currently selected target portal group (if any). Specifying an invalid target portal group index results in no in-focus target portal group.

[\<n>]

Specifies the \<object number> to select. If the <object number> specified is not valid, any existing selections for objects of the specified type are cleared. If no <object number> is specified, the current object is displayed.

### <a name="BKMK_34"></a>setflag

Sets the currently selected drive as a hot spare.

#### Syntax

```
setflag drive hotspare={true | false}
```

#### Parameters

**true**

Selects the currently selected drive as a hot spare.

**false**

Unselects the currently selected drive as a hot spare.

#### Remarks

Hot spares cannot be used for ordinary LUN binding operations. They are reserved for fault handling only. The drive must not be currently bound to any existing LUN.

### <a name="BKMK_shrink"></a>shrink

Reduces the size of the selected LUN.

#### Syntax

```
shrink lun size=<n> [noerr]
```

#### Parameters

**size=**

Specifies the desired amount of space in megabytes (MB) to reduce the size of the LUN by. To specify the size using other units, use one of the recognized suffixes (B, KB, MB, GB, TB and PB) immediately after the size.

**noerr**

Specifies that any failures that occur while performing this operation will be ignored. This is useful in script mode.

### <a name="BKMK_35"></a>standby

Changes the status of the paths to the currently selected host bus adapter (HBA) port to STANDBY.

#### Syntax

```
standby hbaport
```

#### Parameters

**hbaport**

Changes the status of the paths to the currently selected host bus adapter (HBA) port to STANDBY.

### <a name="BKMK_36"></a>unmask

Makes the currently selected LUNs accessible from the specified hosts.

#### Syntax

```
unmask LUN {all | none | [add] wwn=<hexadecimal_number> [;<hexadecimal_number> [;…]] | [add] initiator=<initiator>[;<initiator>[;…]]} [uninstall]
```

#### Parameters

**all**

Specifies that the LUN should be made accessible from all hosts. However, you cannot unmask the LUN to all targets in an iSCSI subsystem.

> [!IMPORTANT]
> You must logout of the target before you run the UNMASK ALL command.

**none**

Specifies that the LUN should not be accessible to any host.

> [!IMPORTANT]
> You must logout of the target before you run the UNMASK LUN NONE command.

**add**

Specifies that the hosts specified must be added to the existing list of hosts that this LUN is accessible from. If this parameter is not specified, the list of hosts supplied replaces the existing list of hosts that this LUN is accessible from.

**WWN=**

Specifies a list of hexadecimal numbers representing world-wide names from which the LUN or hosts should be made accessible. To mask/unmask to a specific set of hosts in a Fibre Channel subsystem, you can type a semicolon-separated list of WWN’s for the ports on the host machines of interest.

**initiator=**

Specifies a list of iSCSI initiators to which the currently selected LUN should be made accessible. To mask/unmask to a specific set of hosts in an iSCSI subsystem, you can type a semicolon-separated list of iSCSI initiator names for the initiators on the host computers of interest.

**uninstall**

If specified, uninstalls the disk associated with the LUN on the local system before the LUN is masked.

## Scripting DiskRAID

DiskRAID can be scripted on any computer running Windows Server 2008 or Windows Server 2003 with an associated VDS hardware provider. To invoke a DiskRAID script, at the command prompt type:
```
diskraid /s <script.txt>
```
By default, DiskRAID stops processing commands and returns an error code if there is a problem in the script. To continue running the script and ignore errors, include the NOERR parameter on the command. This permits such useful practices as using a single script to delete all the LUNs in a subsystem regardless of the total number of LUNs. Not all commands support the NOERR parameter. Errors are always returned on command-syntax errors, regardless of whether you included the NOERR parameter,

### DiskRAID error codes

|Error Code|Error Description|
|----------|-----------------|
|0|No error occurred. The entire script ran without failure.|
|1|A fatal exception occurred.|
|2|The arguments specified on a DiskRAID command line were incorrect.|
|3|DiskRAID was unable to open the specified script or output file.|
|4|One of the services DiskRAID uses returned a failure.|
|5|A command syntax error occurred. The script failed because an object was improperly selected or was invalid for use with that command.|

## Example: Interactively View Status of Subsystem

If you want to view the status of subsystem 0 on your computer, type the following at the command line:
```
diskraid
```
Press ENTER. The following is displayed:
```
Microsoft Diskraid version 5.2.xxxx
Copyright (©) 2003 Microsoft Corporation
On computer: COMPUTER_NAME
```
To select subsystem 0, type the following at the DiskRAID prompt:
```
select subsystem 0
```
Press ENTER. Output similar to the following is displayed:
```
Subsystem 0 is now the selected subsystem.

DISKRAID> list drives

  Drive ###  Status      Health          Size      Free    Bus  Slot  Flags
  ---------  ----------  ------------  --------  --------  ---  ----  -----
  Drive 0    Online      Healthy         107 GB    107 GB    0     1
  Drive 1    Offline     Healthy          29 GB     29 GB    1     0
  Drive 2    Online      Healthy         107 GB    107 GB    0     2
  Drive 3    Not Ready   Healthy          19 GB     19 GB    1     1
```
To exit DiskRAID, type the following at the DiskRAID prompt:
```
exit
```