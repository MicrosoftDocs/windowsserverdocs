---
title: telnet set
description: Reference article for the telnet set command, which sets options.
ms.topic: reference
ms.assetid: 67316b5f-9c6f-43e3-86d5-dcff9ae2ac3e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# telnet: set

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Sets options. You can use the [telnet unset command](telnet-unset.md) to turn off an option that was previously set.

## Syntax

```
set [bsasdel] [crlf] [delasbs] [escape <char>] [localecho] [logfile <filename>] [logging] [mode {console | stream}] [ntlm] [term {ansi | vt100 | vt52 | vtnt}] [?]
```

### Parameters

| Parameter | Description |
|--|--|
| bsasdel | Sends **backspace** as a **delete**. |
| crlf | Sends CR & LF (0x0D, 0x 0A) when the **Enter** key is pressed. Known as **New line mode**. |
| delasbs | Sends **delete** as a **backspace**. |
| escape `<character>` | Sets the escape character used to enter the telnet client prompt. The escape character can be a single character, or it can be a combination of the **CTRL** key plus a character. To set a control-key combination, hold down the **CTRL** key while you type the character that you want to assign. |
| localecho | Turns on local echo. |
| logfile `<filename>` | Logs the current telnet session to the local file. Logging begins automatically when you set this option. |
| logging | Turns on logging. If no log file is set, an error message appears. |
| mode `{console | stream}` | Sets the operation mode. |
| ntlm | Turns on NTLM authentication. |
| term `{ansi | vt100 | vt52 | vtnt}` | Sets the terminal type. |
| ? | Displays help for this command. |

#### Remarks

- On non-English versions of telnet, the **codeset** `<option>` is available. **Codeset** `<option>` sets the current code set to an option, which can be any one of the following: **shift JIS**, **Japanese EUC**, **JIS Kanji**, **JIS Kanji (78)**, **DEC Kanji**, **NEC Kanji**. You should set the same code set on the remote computer.

## Example

To set the log file and to begin logging to the local file *tnlog.txt*, type:

```
set logfile tnlog.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
