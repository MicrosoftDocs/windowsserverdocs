---
title: Command-Line Reference_1
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 69baa34b-d4b3-40ec-bd2f-12d98f7802d5
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Command-Line Reference_1

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Use this topic to find the documentation resources and other technical information that you need to learn about the command shell, and to automate command\-line tasks by using scripts or scripting tools.

To read introductory information about the command shell and command\-line tools, see [Feature description](command-line-reference_1.md#BKMK_Over).

To find information about a specific command, in the following A\-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) | [B](#BKMK_b) | [C](#BKMK_c) | [D](#BKMK_d) | [E](#BKMK_e) | [F](#BKMK_f) | [G](#BKMK_g) | [H](#BKMK_h) | [I](#BKMK_i) | [J](command-line-reference_1.md#BKMK_j)| [K](command-line-reference_1.md#BKMK_k) | [L](#BKMK_l) | [M](#BKMK_m) | [N](#BKMK_n) | [O](#BKMK_o) | [P](#BKMK_p) | [Q](#BKMK_q) | [R](#BKMK_r) | [S](#BKMK_s) | [T](#BKMK_t) | [U](#bkmk_u) | [V](#bkmk_v) | [W](#bkmk_w) | [X](#bkmk_x) | [Y](command-line-reference_1.md#BKMK_y) | [Z](command-line-reference_1.md#BKMK_z)

## <a name="BKMK_PREREQ"></a>Prerequisites
The information that is contained in this overview applies to:

-   Windows Server 2016

-   Windows Server 2012 R2

-   Windows Server 2012

-   Windows Server 2008 R2

-   Windows Server 2008

-   Windows Server 2003 R2

-   Windows Server 2003

-   Windows 8

-   Windows 7

-   Windows Vista

-   Windows XP

## <a name="BKMK_Over"></a>Feature description
### <a name="BKMK_OVR"></a>Command shell overview
The command shell is a software program that provides direct communication between the user and the operating system. The non\-graphical, command shell user interface provides the environment in which you run character\-based applications and utilities. The command shell executes programs and displays their output on the screen by using individual characters similar to the MS\-DOS command interpreter, Command.com. The command shell in the Windows Server operating system uses the command interpreter, Cmd.exe. Cmd.exe loads applications, directs the flow of information between applications, and translates user input into a form that the operating system understands.

You can use the command shell to create and edit scripts to automate routine tasks. For example, you can create simple scripts in batch \(.bat\) files to automate the management of user accounts or nightly backups. You can also use the command\-line version of Windows Script Host to run more sophisticated scripts in the command shell. For more information, see [cscript](cscript.md) or [wscript](wscript.md). You can perform operations more efficiently by using scripts than you can by using the user interface. Scripts accept all commands that are available at the command line.

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
> To set the **reg\_DWOrd** value, use the hexadecimal value of a control character for a particular function \(for example, **0 9** is Tab and **0 08** is Backspace\). User\-specified settings take precedence over computer settings, and command\-line options take precedence over registry settings.

> [!CAUTION]
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

## <a name="BKMK_CmdRef"></a>Command\-line reference A\-Z
To find information about a specific command, in the following A\-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) | [B](#BKMK_b) | [C](#BKMK_c) | [D](#BKMK_d) | [E](#BKMK_e) | [F](#BKMK_f) | [G](#BKMK_g) | [H](#BKMK_h) | [I](#BKMK_i) | [J](#BKMK_j) | [K](#BKMK_k) | [L](#BKMK_l) | [M](#BKMK_m) | [N](#BKMK_n) | [O](#BKMK_o) | [P](#BKMK_p) | [Q](#BKMK_q) | [R](#BKMK_r) | [S](#BKMK_s) | [T](#BKMK_t) | [U](#bkmk_u) | [V](#bkmk_v) | [W](#bkmk_w) | [X](#bkmk_x) | [Y](command-line-reference_1.md#BKMK_y) | [Z](command-line-reference_1.md#BKMK_z)

> [!NOTE]
> Each command\-line tool topic displays the version of Windows that is supported by the command\-line tool.

### <a name="bkmk_a"></a>A

-   [append](append.md)

-   [arp](arp.md)

-   [assoc](assoc.md)

-   [at](at.md)

-   [atmadm](atmadm.md)

-   [attrib](attrib.md)

-   [auditpol](auditpol.md)

-   [autochk](autochk.md)

-   [autoconv](autoconv.md)

-   [autofmt](autofmt.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_b"></a>B

-   [bcdboot](bcdboot.md)

-   [bcdedit](bcdedit.md)

-   [bdehdcfg](bdehdcfg.md)

-   [bitsadmin](bitsadmin.md)

-   [bootcfg](bootcfg.md)

-   [break_1](break_1.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_c"></a>C

-   [cacls_1](cacls_1.md)

-   [call](call.md)

-   [cd](cd.md)

-   [certreq_old](certreq_old.md)

-   [certutil](certutil.md)

-   [change](change.md)

-   [chcp](chcp.md)

-   [chdir_1](chdir_1.md)

-   [chglogon](chglogon.md)

-   [chgport](chgport.md)

-   [chgusr](chgusr.md)

-   [chkdsk](chkdsk.md)

-   [chkntfs](chkntfs.md)

-   [choice](choice.md)

-   [cipher](cipher.md)

-   [clip](clip.md)

-   [cls](cls.md)


-   [Cmd](Cmd.md)

-   [cmdkey](cmdkey.md)

-   [cmstp](cmstp.md)

-   [color](color.md)

-   [comp](comp.md)

-   [compact](compact.md)

-   [convert](convert.md)

-   [copy](copy.md)

-   [cprofile](cprofile.md)

-   [cscript](cscript.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_d"></a>D

-   [date](date.md)

-   [dcgpofix](dcgpofix.md)

-   [defrag](defrag.md)

-   [del](del.md)

-   [dfsrmig](dfsrmig.md)

-   [diantz](diantz.md)

-   [dir](dir.md)

-   [diskcomp](diskcomp.md)

-   [diskcopy](diskcopy.md)

-   [diskperf](diskperf.md)

-   [diskraid](diskraid.md)

-   [diskshadow](diskshadow.md)

-   [dispdiag](dispdiag.md)

-   [Dnscmd](Dnscmd.md)

-   [doskey](doskey.md)

-   [driverquery](driverquery.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_e"></a>E

-   [echo](echo.md)

-   [edit](edit.md)

-   [endlocal](endlocal.md)

-   [erase](erase.md)

-   [eventcreate](eventcreate.md)

-   [eventquery](eventquery.md)

-   [eventtriggers](eventtriggers.md)

-   [Evntcmd](Evntcmd.md)

-   [exit_2](exit_2.md)

-   [expand](expand.md)

-   [extract](extract.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_f"></a>F

-   [fc](fc.md)

-   [find](find.md)

-   [findstr](findstr.md)

-   [finger](finger.md)

-   [flattemp](flattemp.md)

-   [fondue](fondue.md)

-   [for](for.md)

-   [forfiles](forfiles.md)

-   [format](format.md)

-   [freedisk](freedisk.md)

-   [fsutil](fsutil.md)

-   [ftp](ftp.md)

-   [ftype](ftype.md)

-   [fveupdate](fveupdate.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_g"></a>G

-   [getmac](getmac.md)

-   [gettype](gettype.md)

-   [goto](goto.md)

-   [gpfixup](gpfixup.md)

-   [gpresult](gpresult.md)

-   [gpupdate](gpupdate.md)

-   [graftabl](graftabl.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_h"></a>H

-   [help](help.md)

-   [helpctr](helpctr.md)

-   [hostname](hostname.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_i"></a>I

-   [icacls](icacls.md)

-   [if](if.md)

-   [inuse](inuse.md)

-   [ipconfig](ipconfig.md)

-   [ipxroute](ipxroute.md)

-   [irftp](irftp.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_j"></a>J

-   [jetpack](jetpack.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_k"></a>K

-   [klist](klist.md)

-   [ksetup](ksetup.md)

-   [ktmutil](ktmutil.md)

-   [ktpass](ktpass.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_l"></a>L

-   [label](label.md)

-   [lodctr](lodctr.md)

-   [logman](logman.md)

-   [logoff](logoff.md)

-   [lpq](lpq.md)

-   [lpr](lpr.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_m"></a>M

-   [macfile](macfile.md)

-   [makecab](makecab.md)

-   [manage-bde](manage-bde.md)

-   [mapadmin](mapadmin.md)

-   [Md](Md.md)

-   [mkdir](mkdir.md)

-   [mklink](mklink.md)

-   [mmc](mmc.md)

-   [mode](mode.md)

-   [more](more.md)

-   [mount](mount.md)

-   [mountvol](mountvol.md)

-   [move](move.md)

-   [mqbkup](mqbkup.md)

-   [mqsvc](mqsvc.md)

-   [mqtgsvc](mqtgsvc.md)

-   [msdt](msdt.md)

-   [msg](msg.md)

-   [msiexec](msiexec.md)

-   [msinfo32](msinfo32.md)

-   [mstsc](mstsc.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_n"></a>N

-   [nbtstat](nbtstat.md)

-   [netcfg](netcfg.md)

-   [netsh](netsh.md)

-   [netstat](netstat.md)

-   [Net print](net-print.md)

-   [nfsadmin](nfsadmin.md)

-   [nfsshare](nfsshare.md)

-   [nfsstat](nfsstat.md)

-   [nlbmgr](nlbmgr.md)

-   [nslookup](nslookup.md)

-   [ntbackup](ntbackup.md)

-   [ntcmdprompt](ntcmdprompt.md)

-   [ntfrsutl](ntfrsutl.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_o"></a>O

-   [openfiles](openfiles.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_p"></a>P

-   [pagefileconfig](pagefileconfig.md)

-   [path](path.md)

-   [pathping](pathping.md)

-   [pause](pause.md)

-   [pbadmin](pbadmin.md)

-   [pentnt](pentnt.md)

-   [perfmon](perfmon.md)

-   [ping](ping.md)

-   [pnpunattend](pnpunattend.md)

-   [pnputil](pnputil.md)

-   [popd](popd.md)


-   [PowerShell](PowerShell.md)

-   [PowerShell_ise](PowerShell_ise.md)

-   [print](print.md)

-   [prncnfg](prncnfg.md)

-   [prndrvr](prndrvr.md)

-   [prnjobs](prnjobs.md)

-   [prnmngr](prnmngr.md)

-   [prnport](prnport.md)

-   [prnqctl](prnqctl.md)

-   [prompt](prompt.md)

-   [pubprn](pubprn.md)

-   [pushd](pushd.md)

-   [pushprinterconnections](pushprinterconnections.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_q"></a>Q

-   [qappsrv](qappsrv.md)

-   [qprocess](qprocess.md)

-   [query](query.md)

-   [quser](quser.md)

-   [qwinsta](qwinsta.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_r"></a>R

-   [rcp](rcp.md)

-   [rd](rd.md)

-   [rdpsign](rdpsign.md)

-   [recover](recover.md)

-   [reg](reg.md)

-   [regini](regini.md)

-   [regsvr32](regsvr32.md)

-   [relog](relog.md)

-   [rem](rem.md)

-   [ren](ren.md)

-   [rename](rename.md)

-   [repair-bde](repair-bde.md)

-   [replace](replace.md)

-   [reset session](reset-session.md)

-   [rexec](rexec.md)

-   [risetup](risetup.md)

-   [rmdir](rmdir.md)

-   [robocopy](robocopy.md)

-   [route_ws2008](route_ws2008.md)

-   [rpcinfo](rpcinfo.md)

-   [rpcping](rpcping.md)

-   [rsh](rsh.md)

-   [rundll32](rundll32.md)

-   [rwinsta](rwinsta.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_s"></a>S

-   [schtasks](schtasks.md)

-   [Scwcmd](Scwcmd.md)

-   [secedit](secedit.md)

-   [serverceipoptin](serverceipoptin.md)

-   [Servermanagercmd](Servermanagercmd.md)

-   [serverweroptin](serverweroptin.md)

-   [set_1](set_1.md)

-   [setlocal](setlocal.md)


-   [setx](setx.md)

-   [sfc](sfc.md)

-   [shadow](shadow.md)

-   [shift](shift.md)

-   [showmount](showmount.md)

-   [shutdown](shutdown.md)

-   [sort](sort.md)

-   [start](start.md)

-   [subst](subst.md)

-   [sxstrace](sxstrace.md)

-   [sysocmgr](sysocmgr.md)

-   [systeminfo](systeminfo.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_t"></a>T

-   [takeown](takeown.md)

-   [tapicfg](tapicfg.md)

-   [taskkill](taskkill.md)

-   [tasklist](tasklist.md)

-   [tcmsetup](tcmsetup.md)

-   [telnet](telnet.md)

-   [tftp](tftp.md)

-   [time](time.md)

-   [timeout_1](timeout_1.md)

-   [title_1](title_1.md)

-   [tlntadmn](tlntadmn.md)

-   [tpmvscmgr](tpmvscmgr.md)

-   [tracerpt_1](tracerpt_1.md)

-   [tracert](tracert.md)

-   [tree](tree.md)

-   [tscon](tscon.md)

-   [tsdiscon](tsdiscon.md)

-   [tsecimp_1](tsecimp_1.md)

-   [tskill](tskill.md)

-   [tsprof](tsprof.md)

-   [type](type.md)

-   [typeperf](typeperf.md)

-   [tzutil](tzutil.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_u"></a>U


-   [unlodctr_1](unlodctr_1.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_v"></a>V

-   [ver](ver.md)

-   [verifier](verifier.md)

-   [verify_1](verify_1.md)

-   [vol](vol.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_w"></a>W

-   [waitfor](waitfor.md)

-   [wbadmin](wbadmin.md)

-   [wdsutil](wdsutil.md)

-   [wecutil](wecutil.md)

-   [wevtutil](wevtutil.md)

-   [where_1](where_1.md)

-   [whoami](whoami.md)

-   [winnt](winnt.md)

-   [winnt32](winnt32.md)

-   [winpop](winpop.md)

-   [winrs](winrs.md)

-   [wlbs_1](wlbs_1.md)

-   [wmic](wmic.md)

-   [wscript](wscript.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_x"></a>X

-   [xcopy](xcopy.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_y"></a>Y
[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_z"></a>Z
[Command-line reference A-Z](#BKMK_CmdRef)


