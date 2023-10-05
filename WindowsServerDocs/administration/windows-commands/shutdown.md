---
title: shutdown
description: Reference article for the shutdown command, which enables you to shut down or restart local or remote computers, one at a time.
ms.topic: reference
ms.assetid: c432f5cf-c5aa-4665-83af-0ec52c87112e
author: xelu86
ms.author: wscontent
ms.date: 10/04/2023
---

# shutdown

Enables you to shut down or restart local or remote computers, one at a time.

## Syntax

```
shutdown [/i | /l | /s | /sg | /r | /g | /a | /p | /h | /e | /o] [/hybrid] [/soft] [/fw] [/f] [/m \\computer][/t xxx][/d [p|u:]xx:yy [/c "comment"]]
```

### Parameters

| Parameter | Description |
|--|--|
| /i | Displays the **Remote Shutdown** box. The **/i** option must be the first parameter following the command. If **/i** is specified, all other options are ignored. |
| /l | Logs off the current user immediately, with no time-out period. You can't use **/l** with **/m** or **/t**. |
| /s | Shuts down the computer. |
| /sg | Shuts down the computer. On the next boot, if **Automatic Restart Sign-On** is enabled, the device automatically signs in and locks based on the last interactive user. After sign in, it restarts any registered applications. |
| /r | Restarts the computer after shutdown. |
| /g | Fully shuts down and restarts the computer. On restart, if **Automatic Restart Sign-On** is enabled, the device automatically signs in and locks based on the last interactive user. After sign in, it restarts any registered applications. |
| /a | Aborts a system shutdown. Can only be used during the time-out period. Combine with /fw to clear any pending boots to firmware. |
| /p | Turns off the local computer only (not a remote computer)—with no time-out period or warning. You can use **/p** only with **/d** or **/f**. If your computer doesn't support power-off functionality, it shuts down when you use **/p**, but the power to the computer remains on. |
| /h | Puts the local computer into hibernation, if hibernation is enabled. The **/f** switch can be used with the **/h** switch. |
| /hybrid | Shuts down the device and prepares it for fast startup. This option must be used with the **/s** option. |
| /soft | Allows running processes and applications to gracefully close instead of forcibly terminating. |
| /fw | Combining this option with a shutdown option causes the next restart to go to the firmware user interface. |
| /e | Enables you to document the reason for an unexpected shutdown of a computer in the [Shutdown Event Tracker](/troubleshoot/windows-server/application-management/description-shutdown-event-tracker). |
| /o | Goes to the **Advanced boot options** menu and restarts the device. This option must be used with the **/r** option. |
| /f | Forces running applications to close without warning users.<br>**Caution:** Using the **/f** option might result in loss of unsaved data. |
| /m `\\<computername>` | Specifies the target computer. Can't be used with the **/l** option. |
| /t `<xxx>` | Sets the time-out period before shutdown to *xxx* seconds. The valid range is 0-315360000 (10 years), with a default of 30. If the timeout period is greater than 0, the **/f** parameter is implied. |
| /d `[p \| u:]<xx>:<yy>` | Lists the reason for the system restart or shutdown. The supported parameter values are:<br><ul><li>**P** - Indicates that the restart or shutdown is planned.</li><li>**U** - Indicates that the reason is user-defined.<br>If **p** or **u** aren't specified, the restart or shutdown is unplanned.</li><br><li>*xx* - Specifies the major reason number (a positive integer, less than 256).</li><li>*yy* Specifies the minor reason number (a positive integer, less than 65536).</li></ul> |
| /c `<comment>` | Enables you to create a custom reason for the system shutdown or restart, which must be enclosed in double quotation marks. You can use a maximum of 512 characters. Can also be used with the **/d** parameter. |
| /? | Displays help at the command prompt, including a list of the major and minor reasons that are defined on your local computer. |

#### Remarks

- Users must be assigned the **Shut down the system** user right to shut down a local or remotely administered computer that is using the **shutdown** command.

- Users must be members of the **Administrators** group to annotate an unexpected shutdown of a local or remotely administered computer. If the target computer is joined to a domain, members of the **Domain Admins** group might be able to perform this procedure. For more information, see:

  - [Default local groups](/previous-versions/windows/it-pro/windows-server-2003/cc785098(v=ws.10))

  - [Default groups](/previous-versions/windows/it-pro/windows-server-2003/cc756898(v=ws.10))

- If you want to shut down more than one computer at a time, you can call **shutdown** for each computer by using a script, or you can use **shutdown** **/i** to display the **Remote Shutdown** box.

- If you specify major and minor reason codes, you must first define these reason codes on each computer where you plan to use the reasons. If the reason codes aren't defined on the target computer, Shutdown Event Tracker can't log the correct reason text.

- Remember to indicate that a shutdown is planned by using the **/p** parameter. Not using the **/p** parameter, indicates that the shutdown was unplanned.

  - Using the **/p** parameter, along the reason code for an unplanned shutdown, causes the shutdown to fail.

  - Not using the **/p** parameter, and only providing the reason code for a planned shutdown, also causes the shutdown to fail.

The shutdown or restart reasons uses the following legend:

- **E**: Expected - An expected shutdown or restart that is planned and communicated in advance.
- **U**: Unexpected - An unexpected shutdown or restart occurs where the system stops working due to an error, such as a system crash, power failure or other.
- **P**: Planned - A planned shutdown or restart scheduled in advance, such as system maintenance, software installation or other.
- **C**: Customer Defined - Specify a custom reason for the system shutdown or restart.

|Reason type|Major|Minor|Description|
|-|-|-|-|
|U|0|0|Other (Unplanned)|
|E|0|0|Other (Unplanned)|
|E or P|0|0|Other (Planned)|
|U|0|5|Other Failure: System Unresponsive|
|E|1|1|Hardware: Maintenance (Unplanned)|
|E or P|1|1|Hardware: Maintenance (Planned)|
|E|1|2|Hardware: Installation (Unplanned)|
|E or P|1|2|Hardware: Installation (Planned)|
|E|2|2|Operating System: Recovery (Unplanned)|
|E or P|2|2|Operating System: Recovery (Planned)|
|P|2|3|Operating System: Upgrade (Planned)|
|E|2|4|Operating System: Reconfiguration (Unplanned)|
|E or P|2|4|Operating System: Reconfiguration (Planned)|
|P|2|16|Operating System: Service pack (Planned)|
||2|17|Operating System: Hot fix (Unplanned)|
|P|2|17|Operating System: Hot fix (Planned)|
||2|18|Operating System: Security fix (Unplanned)|
|P|2|18|Operating System: Security fix (Planned)|
|E|4|1|Application: Maintenance (Unplanned)|
|E or P|4|1|Application: Maintenance (Planned)|
|E or P|4|2|Application: Installation (Planned)|
|E|4|5|Application: Unresponsive|
|E|4|6|Application: Unstable|
|U|5|15|System Failure: Stop error|
|U|5|19|Security issue (Unplanned)|
|E|5|19|Security issue (Unplanned)|
|E or P|5|19|Security issue (Planned)|
|E|5|20|Loss of network connectivity (Unplanned)|
|U|6|11|Power Failure: Cord Unplugged|
|U|6|12|Power Failure: Environment|
|P|7|0|Legacy API shutdown|

## Examples

To force apps to close and to restart the local computer after a one-minute delay, with the reason *Application: Maintenance (Planned)* and the comment "Reconfiguring myapp.exe", type:

```
shutdown /r /t 60 /c "Reconfiguring myapp.exe" /f /d p:4:1
```

To restart the remote computer *myremoteserver* with the same parameters as the previous example, type:

```
shutdown /r /m \\myremoteserver /t 60 /c "Reconfiguring myapp.exe" /f /d p:4:1
```

To restart the remote computer *myremoteserver* in 5 minutes due to a security update and include a custom reason in the shutdown event tracker, type:

```
shutdown /r /t 300 /e /c "Security Update" /m \\myremoteserver
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
