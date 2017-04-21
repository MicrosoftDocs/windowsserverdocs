---
title: start
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0173f9b3-5cd7-4edb-b01e-d02193b4fadc

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# start

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

starts a separate Command prompt window to run a specified program or command.  
for examples of how to use this command, see [Examples](#BKMK_examples).  
## Syntax  
```  
start ["<Title>"] [/d <path>] [/i] [{/min | /max}] [{/separate | /shared}] [{/low | /normal | /high | /realtime | /abovenormal | belownormal}] [/affinity <HexAffinity>] [/wait] [/b {<Command> | <Program>} [<Parameters>]]  
```  
## Parameters  
|Parameter|Description|  
|-------|--------|  
|"<Title>"|Specifies the title to display in the Command prompt window title bar.|  
|/d <path>|Specifies the startup directory.|  
|/i|Passes the Cmd.exe startup environment to the new Command prompt window. If **/i** is not specified, the current environment is used.|  
|{/min &#124; /max}|Specifies to minimize (**/min**) or maximize (**/max**) the new Command prompt window.|  
|{/separate &#124; /shared}|starts 16-bit programs in a separate memory space (**/separate**) or shared memory space (**/shared**). These options are not supported on 64-bit platforms.|  
|{/low &#124; /normal &#124; /high &#124; /realtime &#124; /abovenormal &#124; /belownormal}|starts an application in the specified priority class. Valid priority class values are **/low**, **/normal**, **/high**, **/realtime**, **/abovenormal**, and **/belownormal**.|  
|/affinity <HexAffinity>|Applies the specified processor affinity mask (expressed as a hexadecimal number) to the new application.|  
|/wait|starts an application and waits for it to end.|  
|/b|starts an application without opening a new Command prompt window. CTRL+C handling is ignored unless the application enables CTRL+C processing. Use CTRL+break to interrupt the application.|  
|/b {<Command> &#124; <Program>}|Specifies the command or program to start.|  
|<Parameters>|Specifies parameters to pass to the command or program.|  
|/?|Displays help at the command prompt.|  
## remarks  
-   You can run nonexecutable files through their file association by typing the name of the file as a command.  
-   When you run a command that contains the string "CMD" as the first token without an extension or path qualifier, "CMD" is replaced with the value of the COMSPEC variable. This prevents users from picking up **cmd** from the current directory.  
-   When you run a 32-bit graphical user interface (GUI) application, **cmd** does not wait for the application to quit before returning to the command prompt. This behavior does not occur if you run the application from a command script.  
-   When you run a command that uses a first token that does not contain an extension, Cmd.exe uses the value of the pathEXT environment variable to determine which extensions to look for and in what order. The default value for the pathEXT variable is:  
    ```  
    .COM;.EXE;.Bat;.CMD   
    ```  
    Note that the syntax is the same as the path variable, with semicolons separating each extension.  
-   When it searches for an executable file, if there is no match on any extension, **start** checks to see if the name matches a directory name. If it does, **start** opens Explorer.exe on that path.  
## <a name="BKMK_examples"></a>Examples  
To start the Myapp program at the command prompt and retain use of the current Command prompt window, type:  
```  
start myapp   
```  
To view the **start** command-line help topic in a separate maximized Command prompt window, type:  
```  
start /max start /?  
```  
#### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
