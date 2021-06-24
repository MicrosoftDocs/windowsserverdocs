---
title: shutdown
description: Reference article for the shutdown command, which enables you to shut down or restart local or remote computers, one at a time.
ms.topic: reference
ms.assetid: c432f5cf-c5aa-4665-83af-0ec52c87112e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# shutdown

Enables you to shut down or restart local or remote computers, one at a time.

## Syntax

```
shutdown [/i | /l | /s | /sg | /r | /g | /a | /p | /h | /e | /o] [/hybrid] [/fw] [/f] [/m \\computer][/t xxx][/d [p|u:]xx:yy [/c "comment"]]
```

### Parameters

| Parameter | Description |
|--|--|
| /i | Displays the **Remote Shutdown** box. The **/i** option must be the first parameter following the command. If **/i** is specified, all other options are ignored. |
| /l | Logs off the current user immediately, with no time-out period. You cannot use **/l** with **/m** or **/t**. |
| /s | Shuts down the computer. |
| /sg | Shuts down the computer. On the next boot, if **Automatic Restart Sign-On** is enabled, the device automatically signs in and locks based on the last interactive user. After sign in, it restarts any registered applications. |
| /r | Restarts the computer after shutdown. |
| /g | Shuts down the computer. On the next restart, if **Automatic Restart Sign-On** is enabled, the device automatically signs in and locks based on the last interactive user. After sign in, it restarts any registered applications. |
| /a | Aborts a system shutdown. Effective only during the time-out period. To use **/a**, you must also use the **/m** option. |
| /p | Turns off the local computer only (not a remote computer)—with no time-out period or warning. You can use **/p** only with **/d** or **/f**. If your computer doesn't support power-off functionality, it will shut down when you use **/p**, but the power to the computer will remain on. |
| /h | Puts the local computer into hibernation, if hibernation is enabled. You can use **/h** only with **/f**. |
| hybrid | Shuts down the device and prepares it for fast startup. This option must be used with the **/s** option. |
| /fw | Combining this option with a shutdown option causes the next restart to go to the firmware user interface. |
| /e | Enables you to document the reason for the unexpected shutdown on the target computer. |
| /o | Goes to the **Advanced boot options** menu and restarts the device. This option must be used with the **/r** option. |
| /f | Forces running applications to close without warning users.<br>**Caution:** Using the **/f** option might result in loss of unsaved data. |
| /m `\\<computername>` | Specifies the target computer. Can't be used with the **/l** option. |
| /t `<xxx>` | Sets the time-out period before shutdown to *xxx* seconds. The valid range is 0-315360000 (10 years), with a default of 30. If the timeout period is greater than 0, the **/f** parameter is implied. |
| /d `[p | u:]<XX>:<YY>` | Lists the reason for the system restart or shutdown. The supported parameter values are:<ul><li>**p** - Indicates that the restart or shutdown is planned.</li><li>**u** - Indicates that the reason is user-defined.<p>**NOTE**<br>If **p** or **u** aren't specified, the restart or shutdown is unplanned.</li><li>*xx* - Specifies the major reason number (a positive integer, less than 256).</li><li>*yy* Specifies the minor reason number (a positive integer, less than 65536).</li></ul> |
| /c `<comment>` | Enables you to comment in detail about the reason for the shutdown. You must first provide a reason by using the **/d** option and you must enclose your comments in quotation marks. You can use a maximum of 511 characters. |
| /? | Displays help at the command prompt, including a list of the major and minor reasons that are defined on your local computer. |

#### Remarks

- Users must be assigned the **Shut down the system** user right to shut down a local or remotely administered computer that is using the **shutdown** command.

- Users must be members of the **Administrators** group to annotate an unexpected shutdown of a local or remotely administered computer. If the target computer is joined to a domain, members of the **Domain Admins** group might be able to perform this procedure. For more information, see:

  - [Default local groups](/previous-versions/windows/it-pro/windows-server-2003/cc785098(v=ws.10))

  - [Default groups](/previous-versions/windows/it-pro/windows-server-2003/cc756898(v=ws.10))

- If you want to shut down more than one computer at a time, you can call **shutdown** for each computer by using a script, or you can use **shutdown** **/i** to display the **Remote Shutdown** box.

- If you specify major and minor reason codes, you must first define these reason codes on each computer where you plan to use the reasons. If the reason codes aren't defined on the target computer, Shutdown Event Tracker can't log the correct reason text.

- Remember to indicate that a shutdown is planned by using the **p** parameter. Not using the **p** parameter, indicates that the shutdown was unplanned.

  - Using the **p** parameter, along the reason code for an unplanned shutdown, causes the shutdown to fail.

  - Not using the **p** parameter, and only providing the reason code for an planned shutdown, also causes the shutdown to fail

## Examples

To force apps to close and to restart the local computer after a one-minute delay, with the reason *Application: Maintenance (Planned)* and the comment "Reconfiguring myapp.exe", type:

```
shutdown /r /t 60 /c "Reconfiguring myapp.exe" /f /d p:4:1
```

To restart the remote computer *myremoteserver* with the same parameters as the previous example, type:

```
shutdown /r /m \\myremoteserver /t 60 /c "Reconfiguring myapp.exe" /f /d p:4:1
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
