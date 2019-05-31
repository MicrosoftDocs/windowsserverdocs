---
title: mode
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b59b04f2-b41d-42df-b5be-19c3721445b1

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# mode



Displays system status, changes system settings, or reconfigures ports or devices. If used without parameters, **mode** displays all the controllable attributes of the console and the available COM devices.

You can use **mode** to perform the following tasks—each task uses a different syntax:
-   [To configure a serial communications port](#BKMK_1)
-   [To display the status of all devices or of a single device](#BKMK_2)
-   [To redirect output from a parallel port to a serial communications port](#BKMK_3)
-   [To select, refresh, or display the numbers of the code pages for the console](#BKMK_4)
-   [To change the size of the command prompt screen buffer](#BKMK_5)
-   [To set the keyboard typematic rate](#BKMK_6)

## <a name="BKMK_1"></a>To configure a serial communications port

### Syntax

```
mode com<M>[:] [baud=<B>] [parity=<P>] [data=<D>] [stop=<S>] [to={on|off}] [xon={on|off}] [odsr={on|off}] [octs={on|off}] [dtr={on|off|hs}] [rts={on|off|hs|tg}] [idsr={on|off}]
```

### Parameters

|  Parameter  |                                                                                                                                                                                     Description                                                                                                                                                                                     |
|-------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Com\<M>[:]  |                                                                                                                                                      Specifies the number of the async Prncnfg.vbshronous communications port.                                                                                                                                                      |
|  baud=\<B>  | Specifies the transmission rate in bits per second. The following table lists valid abbreviations for *B* and their related rates.</br>-   **11** = 110 baud</br>-   **15** = 150 baud</br>-   **30** = 300 baud</br>-   **60** = 600 baud</br>-   **12** = 1200 baud</br>-   **24** = 2400 baud</br>-   **48** = 4800 baud</br>-   **96** = 9600 baud</br>-   **19** = 19,200 baud |
| parity=\<P> |                              Specifies how the system uses the parity bit to check for transmission errors. The following table lists valid values for *P*. The default value is **e**. Not all computers support the values **m** and **s**.</br>-   **n** = none</br>-   **e** = even</br>-   **o** = odd</br>-   **m** = mark</br>-   **s** = space                              |
|  data=\<D>  |                                                                                                    Specifies the number of data bits in a character. Valid values for **d** are in the range 5 through 8. The default value is 7. Not all computers support the values 5 and 6.                                                                                                     |
|  stop=\<S>  |                                                                                  Specifies the number of stop bits that define the end of a character: 1, 1.5, or 2. If the baud rate is 110, the default value is 2. Otherwise, the default value is 1. Not all computers support the value 1.5.                                                                                   |
|   to={on    |                                                                                                                                                                                        off}                                                                                                                                                                                         |
|   xon={on   |                                                                                                                                                                                        off}                                                                                                                                                                                         |
|  odsr={on   |                                                                                                                                                                                        off}                                                                                                                                                                                         |
|  octs={on   |                                                                                                                                                                                        off}                                                                                                                                                                                         |
|   dtr={on   |                                                                                                                                                                                         off                                                                                                                                                                                         |
|   rts={on   |                                                                                                                                                                                         off                                                                                                                                                                                         |
|  idsr={on   |                                                                                                                                                                                        off}                                                                                                                                                                                         |
|     /?      |                                                                                                                                                                        Displays help at the command prompt.                                                                                                                                                                         |

## <a name="BKMK_2"></a>To display the status of all devices or of a single device

### Syntax

```
mode [<Device>] [/status]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<Device>|Specifies the name of the device for which you want to display the status.|
|/status|Requests the status of any redirected parallel printers. You can abbreviate the **/status** command-line option as **/sta**.|
|/?|Displays help at the command prompt.|

### Remarks

If used without parameters, **mode** displays the status of all devices that are installed on your system.

## <a name="BKMK_3"></a>To redirect output from a parallel port to a serial communications port

### Syntax

```
mode lpt<N>[:]=com<M>[:]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|lpt\<N>[:]|Required. Specifies the parallel port. Valid values for *N* are in the range 1 through 3.|
|com\<M>[:]|Required. Specifies the serial port. Valid values for *M* are in the range 1 through 4.|
|/?|Displays help at the command prompt.|

### Remarks

You must be a member of the Administrators group to redirect printing.

### Examples

To set up your system so that it sends parallel printer output to a serial printer, you must use the **mode** command twice. The first time, use **mode** to configure the serial port. The second time, use **mode** to redirect parallel printer output to the serial port you specified in the first **mode** command.

For example, if your serial printer operates at 4800 baud with even parity, and it is connected to the COM1 port (the first serial connection on your computer), type:
```
mode com1 48,e,,,b
mode lpt1=com1
```
If you redirect parallel printer output from LPT1 to COM1, but then you decide that you want to print a file by using LPT1, type the following command before you print the file:
```
mode lpt1
```
This command prevents the redirection the file from LPT1 to COM1.

## <a name="BKMK_4"></a>To select, refresh, or display the numbers of the code pages for the console

### Syntax

```
mode <Device> codepage select=<YYY>
mode <Device> codepage [/status]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<Device>|Required. Specifies the device for which you want to select a code page. CON is the only valid name for a device.|
|codepage select=|Required. Specifies which code page to use with the specified device. You can abbreviate **codepage** **select** as **cp** **sel**.|
|\<YYY>|Required. Specifies the number of the code page to select. The following list shows each code page that is supported and its country/region or language.</br>437: United States</br>850: Multilingual (Latin I)</br>852: Slavic (Latin II)</br>855: Cyrillic (Russian)</br>857: Turkish</br>860: Portuguese</br>861: Icelandic</br>863: Canadian-French</br>865: Nordic</br>866: Russian</br>869: Modern Greek|
|codepage|Required. Displays the numbers of the code pages (if any) that are selected for the specified device.|
|/status|Displays the numbers of the current code pages selected for the specified device. You can abbreviate **/status** to **/sta**. Whether or not you specify **/status**, **mode codepage** displays the numbers of the code pages that are selected for the specified device.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_5"></a>To change the size of the command prompt screen buffer

### Syntax

```
mode con[:] [cols=<C>] [lines=<N>]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|con[:]|Required. Indicates that the change applies to the Command Prompt window.|
|cols=\<C>|Specifies the number of columns in the command prompt screen buffer.|
|lines=\<N>|Specifies the number of lines in the command prompt screen buffer.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_6"></a>To set the keyboard typematic rate

### Syntax

```
mode con[:] [rate=<R> delay=<D>]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|con[:]|Required. Refers to the keyboard.|
|rate=\<R>|Specifies the rate at which a character is repeated on the screen when you hold down a key.|
|delay=\<D>|Specifies the amount of time that will elapse after you press and hold down a key before the character output repeats.|
|/?|Displays help at the command prompt.|

### Remarks

- The typematic rate is the rate at which a character repeats when you hold down the key for that character. The typematic rate has two components, the rate and the delay. Some keyboards do not recognize this command.
- Using **rate=**<em>R</em>

  Valid values are in the range 1 through 32. These values are equal to approximately 2 to 30 characters per second. The default value is 20 for IBM AT-compatible keyboards, and 21 for IBM PS/2-compatible keyboards. If you set the rate, you must also set the delay.
- Using **delay**=*D*

  Valid values for *D* are 1, 2, 3, and 4 (representing 0.25, 0.50, 0.75, and 1 second). The default value is 2. If you set the delay, you must also set the rate.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)