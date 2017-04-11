---
title: call
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d34a41dc-e6c7-4467-bf6a-15cec704833e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# call

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

calls one batch program from another without stopping the parent batch program. The **call** command accepts labels as the target of the call.
> [!NOTE]
> **call** has no effect at the command prompt when it is used outside of a script or batch file.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
call [Drive:][path]<FileName> [<BatchParameters>] [:<label> [<Arguments>]]
```
## Parameters
|Parameter|Description|
|-------|--------|
|[<Drive>:][<path>]<FileName>|Specifies the location and name of the batch program that you want to call. The *FileName* parameter is required, and it must have a .bat or .cmd extension.|
|<BatchParameters>|Specifies any command-line information required by the batch program.|
|:<label>|Specifies the label that you want a batch program control to jump to.|
|<Arguments>|Specifies the command-line information to be passed to the new instance of the batch program, beginning at *:label.*|
|/?|Displays help at the command prompt.|
## Batch parameters
The batch script argument references (**%0**, **%1**, ...) are listed in the following tables.
**%\*** in a batch script refers to all the arguments (for example, **%1**, **%2**, **%3**...)
You can use the following optional syntaxes as substitutions for batch parameters (**%n**):
|Batch Parameter|Description|
|----------|--------|
|%~1|expands **%1** and removes surrounding quotation marks (" ").|
|%~f1|expands **%1** to a fully qualified path.|
|%~d1|expands **%1** to a drive letter only.|
|%~p1|expands **%1** to a path only.|
|%~n1|expands **%1** to a file name only.|
|%~x1|expands **%1** to a file name extension only.|
|%~s1|expands **%1** to a fully qualified path that contains short names only.|
|%~a1|expands **%1** to the file attributes.|
|%~t1|expands **%1** to the date and time of file.|
|%~z1|expands **%1** to the size of the file.|
|%~$path:1|Searches the directories listed in the path environment variable, and expands **%1** to the fully qualified name of the first directory found. If the environment variable name is not defined or the file is not found by the search, then this modifier expands to the empty string.|
The following table shows how you can combine modifiers with the batch parameters for compound results:
|Batch Parameter with Modifier|Description|
|-----------------|--------|
|%~dp1|expands **%1** to a drive letter and path only.|
|%~nx1|expands **%1** to a file name and extension only.|
|%~dp$path:1|Searches the directories listed in the path environment variable for **%1**, and then expands to the drive letter and path of the first directory found.|
|%~ftza1|expands **%1** to display output similar to the **dir** command.|
In the above examples, **%1** and path can be replaced by other valid values. The **%~** syntax is terminated by a valid argument number. The **%~** modifiers cannot be used with **%\***.
## remarks
-   Using batch parameters
    Batch parameters can contain any information that you can pass to a batch program, including command-line options, file names, the batch parameters **%0** through **%9**, and variables (for example, **%baud%**).
-   Using the *label* parameter
    By using **call** with the *label* parameter, you create a new batch file context and pass control to the statement after the specified label. The first time the end of the batch file is encountered (that is, after jumping to the label), control returns to the statement after the **call** statement. The second time the end of the batch file is encountered, the batch script is exited.
-   Using pipes and redirection symbols
    Do not use pipes (**|**) and redirection symbols (**<** or **>**) with **call**.
-   Making a recursive call
    You can create a batch program that calls itself. However, you must provide an exit condition. Otherwise, the parent and child batch programs can loop endlessly.
-   Working with command extensions
    if command extensions are enabled, **call** accepts *label* as the target of the call. The correct syntax is as follows:
    `call :<label> <Arguments>`
## <a name="BKMK_examples"></a>Examples
To run the Checknew.bat program from another batch program, type the following command in the parent batch program:
```
call checknew
```
if the parent batch program accepts two batch parameters and you want it to pass those parameters to Checknew.bat, type the following command in the parent batch program:
```
call checknew %1 %2
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
