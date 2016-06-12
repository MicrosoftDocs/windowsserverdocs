---
title: Windows Commands
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c703d07c-8227-4e86-94a6-8ef390f94cdc
---
# Windows Commands
Use this topic to find the documentation resources and other technical information that you need to learn about the command shell, and to automate command\-line tasks by using scripts or scripting tools.

To read introductory information about the command shell and command\-line tools, see [Feature description](Command-Line-Reference_1.md#BKMK_Over). To see a listing of new and deprecated command\-line tools see [New and deprecated functionality](Command-Line-Reference_1.md#BKMK_NEW).

To find information about a specific command, in the following A\-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) | [B](#BKMK_b) | [C](#BKMK_c) | [D](#BKMK_d) | [E](#BKMK_e) | [F](#BKMK_f) | [G](#BKMK_g) | [H](#BKMK_h) | [I](#BKMK_i) | [J](Command-Line-Reference_1.md#BKMK_j)| [K](Command-Line-Reference_1.md#BKMK_k) | [L](#BKMK_l) | [M](#BKMK_m) | [N](#BKMK_n) | [O](#BKMK_o) | [P](#BKMK_p) | [Q](#BKMK_q) | [R](#BKMK_r) | [S](#BKMK_s) | [T](#BKMK_t) | [U](#bkmk_u) | [V](#bkmk_v) | [W](#bkmk_w) | [X](#bkmk_x) | [Y](Command-Line-Reference_1.md#BKMK_y) | [Z](Command-Line-Reference_1.md#BKMK_z)

## <a name="BKMK_PREREQ"></a>Prerequisites
The information that is contained in this overview applies to:

-    Windows Server 2012 

-   Windows Server 2008 R2

-   Windows Server 2008

-   Windows Server 2003 R2

-   Windows Server 2003

-   Windows 8

-    Windows 7 

-   Windows Vista

-   Windows XP

## <a name="BKMK_Over"></a>Feature description

### <a name="BKMK_NEW"></a>New and deprecated functionality

|Feature\/functionality|New or Deprecated?|Description|
|--------------------------|----------------------|---------------|
|[Cluster](assetId:///cb6ab0dd-7bc6-40de-9112-923656851150)|Deprecated|create a new cluster or configure an existing cluster.|
|[dfscmd](assetId:///346841cd-98a1-4bda-9eda-5a5c00027e52)|Deprecated|Configure DFS folders and folder targets in a DFS namespace.|
|[dirquota](assetId:///e184296d-68b2-4b10-8303-7a7456f2675c)|Deprecated|creates and manages File Server Resource manager quotas.|
|[Filescrn](assetId:///8f11ef55-da52-46fa-807a-33782837a80e)|Deprecated|create and manage file groups, file screens, file screen exceptions, and file screen templates that are used to configure general administrative options for screening files.|
|[fondue]()|New|Enable optional features in Windows by downloading required files from Windows Update or a source that Group Policy specifies.|
|[powershell-ise]()|New|Read, write, run, debug, and test Windows powershell scripts and modules in a friendly, graphic\-assisted environment.|
|[servermanagercmd]()|Deprecated|Install or remove roles, role services, and features.|
|[shadow]()|Deprecated|Monitor an rd Session Host session.|
|[Storrept](assetId:///4433454c-daa9-4b7a-befd-9b11d46daffa)|Deprecated|create and manage storage reports and storage report tasks, and configure general administrative options for File Server Resource manager.|

### <a name="BKMK_OVR"></a>Command shell overview
The command shell is a software program that provides direct communication between the user and the operating system. The non\-graphical, command shell user interface provides the environment in which you run character\-based applications and utilities. The command shell executes programs and displays their output on the screen by using individual characters similar to the MS\-DOS command interpreter, Command.com. The command shell in the Windows Server operating system uses the command interpreter, cmd.exe. cmd.exe loads applications, directs the flow of information between applications, and translates user input into a form that the operating system understands.

You can use the command shell to create and edit scripts to automate routine tasks. for example, you can create simple scripts in batch \(.bat\) files to automate the management of user accounts or nightly backups. You can also use the command\-line version of Windows Script Host to run more sophisticated scripts in the command shell. for more information, see [cscript]() or [wscript](). You can perform operations more efficiently by using scripts than you can by using the user interface. Scripts accept all commands that are available at the command line.

### <a name="BKMK_Custom"></a>Customize the Command prompt window
You can change the properties for the Command prompt window.

##### To configure the Command prompt window

1.  Open a Command prompt window, click the upper\-left corner of the Command prompt window, and then click **Properties**. \(Or to open **Command prompt Properties** from the keyboard, press ALT\+SPACEBAR\+P.\)

2.  Click the **Options** tab.

3.  In **Command History**, type or select **999** in **Buffer Size**, and then type or select **5** in **Number of Buffers**. By increasing the screen buffer size to 999, you enable scrolling through the Command prompt window. By increasing the number of buffers to five, you increase the number of lines in the Command prompt window to 5000.

4.  In **edit Options**, select the **Quick edit mode** and **Insert mode** check boxes.

5.  Click the **Layout** tab.

6.  In **Screen Buffer Size**, type or select **2500** in **Height**.

7.  To further customize your Command prompt window settings, perform any of the following optional tasks:

    -   In **Screen Buffer Size**, increase **Width**.

    -   In **Window Size**, increase **Height**.

    -   In **Window Size**, increase **Width**.

    -   Clear the **Let system position window** check box, and then, in **Window Position**, change the values in **Left** and **Top**.

8.  In the **Apply Properties** dialog box, click **Save properties for future windows with same title**.

> [!NOTE]
> To enable or disable file and directory name completion on a computer or user logon session, run **regedit.exe** and set the following **reg\_DWOrd value**:
> 
> HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Command Processor\\completionChar\\reg\_DWOrd
> 
> To set the **reg\_DWOrd** value, use the hexadecimal value of a control character for a particular function \(for example, **0×9** is Tab and **0×08** is Backspace\). User\-specified settings take precedence over computer settings, and command\-line options take precedence over registry settings.

> [!CAUTION]
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

## <a name="BKMK_cmdRef"></a>Command\-line reference A\-Z
To find information about a specific command, in the following A\-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) | [B](#BKMK_b) | [C](#BKMK_c) | [D](#BKMK_d) | [E](#BKMK_e) | [F](#BKMK_f) | [G](#BKMK_g) | [H](#BKMK_h) | [I](#BKMK_i) | [J](#BKMK_j) | [K](#BKMK_k) | [L](#BKMK_l) | [M](#BKMK_m) | [N](#BKMK_n) | [O](#BKMK_o) | [P](#BKMK_p) | [Q](#BKMK_q) | [R](#BKMK_r) | [S](#BKMK_s) | [T](#BKMK_t) | [U](#bkmk_u) | [V](#bkmk_v) | [W](#bkmk_w) | [X](#bkmk_x) | [Y](Command-Line-Reference_1.md#BKMK_y) | [Z](Command-Line-Reference_1.md#BKMK_z)

> [!NOTE]
> Each command\-line tool topic displays the version of Windows that is supported by the command\-line tool.

### <a name="bkmk_a"></a>A

-   [Adprep](assetId:///aa923ebf-de47-494b-a60a-9fce083d2f69)

-   [append]()

-   [arp]()

-   [assoc]()

-   [at]()

-   [atmadm]()

-   [attrib]()

-   [auditpol]()

-   [autochk]()

-   [autoconv]()

-   [autofmt](autofmt.md)

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_b"></a>B

-   [bcdboot]()

-   [bcdedit]()

-   [bdehdcfg]()

-   [bitsadmin]()

-   [bootcfg]()

-   [break]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_c"></a>C

-   [cacls]()

-   [call]()

-   [cd]()

-   [certreq-old]()

-   [certutil]()

-   [change]()

-   [chcp]()

-   [chdir]()

-   [chglogon]()

-   [chgport]()

-   [chgusr]()

-   [Chkdsk]()

-   [chkntfs]()

-   [choice]()

-   [cipher]()

-   [clip]()

-   [cls]()

-   [Cluadmin](assetId:///8b0b67ee-3ea8-4f7b-bb35-bec9da5546e3)

-   [Cluster](assetId:///cb6ab0dd-7bc6-40de-9112-923656851150)

-   [cmd](cmd.md)

-   [cmdkey]()

-   [cmstp]()

-   [color]()

-   [comp]()

-   [compact]()

-   [convert]()

-   [copy]()

-   [cprofile]()

-   [cscript]()

-   [Csvde](assetId:///bd5e4f88-c30a-47a8-b3d2-026e4497275c)

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_d"></a>D

-   [date]()

-   [Dcdiag](assetId:///b9dbd69d-f96f-40f8-8ca5-1d96cf16f908)

-   [dcgpofix]()

-   [Dcpromo](assetId:///d660e761-9ee7-4382-822a-06fc2365a1d2)

-   [defrag](defrag.md)

-   [del]()

-   [dfscmd](assetId:///346841cd-98a1-4bda-9eda-5a5c00027e52)

-   [dfsrmig](dfsrmig.md)

-   [diantz]()

-   [dir]()

-   [dirquota](assetId:///e184296d-68b2-4b10-8303-7a7456f2675c)

-   [diskcomp]()

-   [diskcopy]()

-   [Diskedit](assetId:///e96f8ffc-3899-43e4-8f5d-9374c0d514bb)

-   [Diskpart](assetId:///26a4a166-95fa-4faf-95bc-2d5345f4a57a)

-   [diskperf]()

-   [diskraid]()

-   [Diskshadow]()

-   [dispdiag]()

-   [Djoin](assetId:///57b936e6-d949-4d79-84c1-f45825d4719e)

-   [dnscmd]()

-   [doskey]()

-   [driverquery]()

-   [Dsacls](assetId:///35307959-7018-46a4-944a-08cec765c88d)

-   [Dsadd](assetId:///54b05f1b-d288-432f-bfb5-2f4090704624)

-   [Dsamain](assetId:///e95b5148-aa86-44ea-87e9-43c8ce6cfdbe)

-   [Dsdbutil](assetId:///0c7f4cee-53cb-443c-b194-524c9360deac)

-   [Dsget](assetId:///ef0beb94-3e59-47e7-8193-d4c5c9dcf099)

-   [Dsmgmt](assetId:///c525f20d-fdcf-4da8-8450-cce9988bc811)

-   [Dsmod](assetId:///c25f43ea-d9d4-47fa-b7a9-70ea76b34cb1)

-   [Dsmove](assetId:///9af7dc97-4f13-4cfc-ab49-a34eea48a55c)

-   [Dsquery](assetId:///d9ded34b-7ed0-4280-b524-a55c9c6c7b69)

-   [Dsrm](assetId:///ae1694e1-c091-485e-8f0d-a0cd5b4a2c72)

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_e"></a>E

-   [echo]()

-   [edit]()

-   [endlocal]()

-   [erase]()

-   [eventcreate]()

-   [eventqueryvbs]()

-   [eventtriggers]()

-   [evntcmd]()

-   [exit]()

-   [expand]()

-   [extract]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_f"></a>F

-   [fc]()

-   [Filescrn](assetId:///8f11ef55-da52-46fa-807a-33782837a80e)

-   [find]()

-   [findstr]()

-   [finger]()

-   [flattemp]()

-   [fondue]()

-   [for]()

-   [forfiles]()

-   [format](format.md)

-   [freedisk]()

-   [Fsutil]()

-   [ftp](ftp.md)

-   [ftype]()

-   [fveupdate]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_g"></a>G

-   [getmac]()

-   [gettype]()

-   [goto]()

-   [gpfixup]()

-   [gpresult]()

-   [gpupdate]()

-   [graftabl]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_h"></a>H

-   [Hashgen](assetId:///c8beaf08-2ce4-493b-b809-727fb7ff9e2c)

-   [help]()

-   [helpctr]()

-   [hostname]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_i"></a>I

-   [icacls]()

-   [if]()

-   [inuse]()

-   [ipconfig]()

-   [ipxroute]()

-   [Irftp]()

-   [Ismserv](assetId:///cb8357b0-9eee-454b-ab62-d2c738bca16c)

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_j"></a>J

-   [jetpack]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_k"></a>K

-   [klist]()

-   [ksetup]()

-   [ktmutil]()

-   [ktpass]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_l"></a>L

-   [label]()

-   [Ldifde](assetId:///8fe5b815-f89d-48c0-8b2c-a9cd1d698652)

-   [Ldp](assetId:///319a46f2-7a37-4274-9e24-c7558ce663e0)

-   [lodctr]()

-   [logman]()

-   [logoff]()

-   [lpq](lpq.md)

-   [lpr]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_m"></a>M

-   [macfile]()

-   [makecab]()

-   [manage-bde]()

-   [mapadmin]()

-   [md]()

-   [mkdir]()

-   [mklink]()

-   [mmc]()

-   [mode]()

-   [more]()

-   [mount]()

-   [mountvol]()

-   [move]()

-   [mqbkup]()

-   [mqsvc]()

-   [mqtgsvc]()

-   [Msdt](Msdt.md)

-   [msg]()

-   [msiexec]()

-   [msinfo32]()

-   [mstsc]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_n"></a>N

-   [Nbtstat](Nbtstat.md)

-   [Netcfg]()

-   [Netdiag](assetId:///9fe8f3da-70dd-46ae-93ca-34d73d122db3)

-   [Netdom](assetId:///ecaf5d86-3d1d-4db1-a3c4-cf4c458f9423)

-   [netsh]()

-   [netstat]()

-   [Net computer](assetId:///8d9cab7a-bf88-4e0a-a406-33dc7823194c)

-   [Net group](assetId:///5be322dc-e214-4ab2-a319-e89e3d480694)

-   [Net localgroup](assetId:///27ed153a-b08a-4a48-8e31-2d63d759fdba)

-   [Net print]()

-   [Net session](assetId:///8fc5af08-258a-4d84-8c4f-cbc01c9c4b5b)

-   [Net share](assetId:///0d58c146-4033-42a5-add0-eb2a0984109a)

-   [Net use](assetId:///5f4f2753-b376-4d09-ba20-f3cfaaba1753)

-   [Net user](assetId:///8935e4a8-3624-46a1-b47a-c7735802b456)

-   [Net view](assetId:///7140de2e-1d67-4ce7-9688-dbfae46e3fca)

-   [Nfsadmin]()

-   [nfsshare](nfsshare.md)

-   [nfsstat](nfsstat.md)

-   [Nlb](assetId:///7d4bba93-2bb5-4c71-92c2-570468ac25da)

-   [nlbmgr]()

-   [Nltest](assetId:///aff1e7ff-5d77-4891-94a2-92cb0e5aee53)

-   [Nslookup]()

-   [ntbackup]()

-   [ntcmdprompt]()

-   [Ntdsutil](assetId:///199cebb9-967c-4307-a9d7-1c0bb50dc75b)

-   [Ntfrsutl]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_o"></a>O

-   [openfiles]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_p"></a>P

-   [pagefileconfigvbs]()

-   [path]()

-   [pathping]()

-   [pause]()

-   [pbadmin]()

-   [pentnt]()

-   [perfmon]()

-   [ping]()

-   [pnpunattend]()

-   [pnputil]()

-   [popd]()

-   [Powercfg](assetId:///34bab092-0186-4626-a123-6d0afa9bf696)

-   [powershell]()

-   [powershell-ise]()

-   [print]()

-   [prncnfgvbs]()

-   [prndrvrvbs]()

-   [prnjobsvbs]()

-   [prnmngrvbs]()

-   [prnportvbs]()

-   [prnqctlvbs]()

-   [prompt]()

-   [pubprnvbs]()

-   [pushd]()

-   [pushprinterconnections]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_q"></a>Q

-   [qappsrv]()

-   [qprocess]()

-   [query]()

-   [quser]()

-   [qwinsta]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_r"></a>R

-   [Rasdial](assetId:///ed300a38-97e7-4373-a2cc-fa7079cd259e)

-   [Rcp]()

-   [rd]()

-   [rdpsign]()

-   [Reagentc](assetId:///83b29f78-269e-4ab8-9870-7fc08d34fb43)

-   [recover](recover.md)

-   [Redircmp](assetId:///13debf34-0ddf-4b56-9ebf-4ddc97533a65)

-   [Redirusr](assetId:///74559785-04cf-4b73-abfb-f6b89fba200d)

-   [reg]()

-   [regini]()

-   [regsvr32]()

-   [relog]()

-   [rem]()

-   [ren]()

-   [rename]()

-   [rendom](assetId:///b2b67fb7-1f41-468a-a9c3-19b47cc2462b)

-   [Repadmin](assetId:///24cf60ff-6fae-428e-967a-5c24f5f80d31)

-   [repairbde]()

-   [replace]()

-   [reset session]()

-   [rexec]()

-   [risetup]()

-   [rmdir]()

-   [robocopy]()

-   [route-ws2008]()

-   [rpcinfo]()

-   [rpcping]()

-   [Rsh]()

-   [Rsm](assetId:///96874886-d9a9-4702-a3cc-457e6a5d2c32)

-   [Rss](assetId:///370ee31b-46f8-44e9-9ba2-e89949f636c8)

-   [Runas](assetId:///7b710f79-d28a-4297-b5fc-0c1868d236fc)

-   [rundll32]()

-   [rwinsta]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_s"></a>S

-   [Sc](assetId:///807191da-4a33-4149-addf-c11ded938b5f)

-   [schtasks]()

-   [scwcmd]()

-   [secedit]()

-   [serverceipoptin]()

-   [servermanagercmd]()

-   [serverweroptin]()

-   [set]()

-   [setlocal]()

-   [Setspn](assetId:///9341c753-11ff-4acc-993c-b05d50f32330)

-   [setx]()

-   [sfc]()

-   [shadow]()

-   [shift]()

-   [Showmount]()

-   [shutdown]()

-   [sort]()

-   [start]()

-   [Storrept](assetId:///4433454c-daa9-4b7a-befd-9b11d46daffa)

-   [subst]()

-   [sxstrace]()

-   [sysocmgr]()

-   [systeminfo]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_t"></a>T

-   [takeown]()

-   [tapicfg]()

-   [taskkill]()

-   [tasklist]()

-   [tcmsetup]()

-   [telnet](telnet.md)

-   [Tftp]()

-   [time]()

-   [timeout]()

-   [title]()

-   [Tlntadmn]()

-   [tpmvscmgr]()

-   [tracerpt]()

-   [tracert]()

-   [tree]()

-   [tscon]()

-   [tsdiscon]()

-   [tsecimp]()

-   [tskill]()

-   [tsprof]()

-   [type]()

-   [typeperf]()

-   [tzutil]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="bkmk_u"></a>U

-   [Uddiconfig](assetId:///ffadff0f-51b3-45f5-83af-0946effd043f)

-   [Umount](assetId:///0726324c-c45a-444d-a753-99daf5e1c83a)

-   [unlodctr]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="bkmk_v"></a>V

-   [ver]()

-   [verifier]()

-   [verify]()

-   [vol]()

-   [Vssadmin](assetId:///df7eb505-43c6-42af-ab42-3095f96ffc27)

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="bkmk_w"></a>W

-   [W32tm](assetId:///04cf7d3a-b787-4dfe-ac57-53e9000fbc6b)

-   [waitfor]()

-   [wbadmin]()

-   [wdsutil]()

-   [wecutil]()

-   [wevtutil](wevtutil.md)

-   [where]()

-   [whoami]()

-   [winnt]()

-   [winnt32]()

-   [winpop]()

-   [winrs]()

-   [winsat](assetId:///11b0e51f-fe58-4553-9e7c-a562e5385fbb)

-   [wlbs]()

-   [wmic]()

-   [wscript]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="bkmk_x"></a>X

-   [xcopy]()

[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_y"></a>Y
[Command-line reference A-Z](#BKMK_cmdRef)

### <a name="BKMK_z"></a>Z
[Command-line reference A-Z](#BKMK_cmdRef)


