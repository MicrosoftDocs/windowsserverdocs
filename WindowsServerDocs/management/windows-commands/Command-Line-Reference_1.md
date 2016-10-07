---
title: Command-Line Reference_1
description: "Windows Commands"
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

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Use this topic to find the documentation resources and other technical information that you need to learn about the command shell, and to automate command\-line tasks by using scripts or scripting tools.

To read introductory information about the command shell and command\-line tools, see [Feature description](Command-Line-Reference_1.md#BKMK_OVER).

To find information about a specific command, in the following A\-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) | [B](#BKMK_b) | [C](#BKMK_c) | [D](#BKMK_d) | [E](#BKMK_e) | [F](#BKMK_f) | [G](#BKMK_g) | [H](#BKMK_h) | [I](#BKMK_i) | [J](Command-Line-Reference_1.md#BKMK_j)| [K](Command-Line-Reference_1.md#BKMK_k) | [L](#BKMK_l) | [M](#BKMK_m) | [N](#BKMK_n) | [O](#BKMK_o) | [P](#BKMK_p) | [Q](#BKMK_q) | [R](#BKMK_r) | [S](#BKMK_s) | [T](#BKMK_t) | [U](#bkmk_u) | [V](#bkmk_v) | [W](#bkmk_w) | [X](#bkmk_x) | [Y](Command-Line-Reference_1.md#BKMK_y) | [Z](Command-Line-Reference_1.md#BKMK_z)

## <a name="BKMK_PREREQ"></a>Prerequisites
The information that is contained in this overview applies to:

-   Windows Server 2016

-   Windows Server 2012 R2

-   Windows Server 2012

-   Windows Server 2008 R2

-   Windows Server 2008

-   Windows Server 2003 R2

-   Windows Server 2003

-   Windows 8

-   Windows 7

-   Windows Vista

-   Windows XP

## <a name="BKMK_OVER"></a>Feature description
### <a name="BKMK_OVR"></a>Command shell overview
The command shell is a software program that provides direct communication between the user and the operating system. The non\-graphical, command shell user interface provides the environment in which you run character\-based applications and utilities. The command shell executes programs and displays their output on the screen by using individual characters similar to the MS\-DOS command interpreter, Command.com. The command shell in the Windows Server operating system uses the command interpreter, Cmd.exe. Cmd.exe loads applications, directs the flow of information between applications, and translates user input into a form that the operating system understands.

You can use the command shell to create and edit scripts to automate routine tasks. For example, you can create simple scripts in batch \(.bat\) files to automate the management of user accounts or nightly backups. You can also use the command\-line version of Windows Script Host to run more sophisticated scripts in the command shell. For more information, see [Cscript](Cscript.md) or [Wscript](Wscript.md). You can perform operations more efficiently by using scripts than you can by using the user interface. Scripts accept all commands that are available at the command line.

### <a name="BKMK_Custom"></a>Customize the Command Prompt window
You can change the properties for the Command Prompt window.

##### To configure the Command Prompt window

1.  Open a Command Prompt window, click the upper\-left corner of the Command Prompt window, and then click **Properties**. \(Or to open **Command Prompt Properties** from the keyboard, press ALT\+SPACEBAR\+P.\)

2.  Click the **Options** tab.

3.  In **Command History**, type or select **999** in **Buffer Size**, and then type or select **5** in **Number of Buffers**. By increasing the screen buffer size to 999, you enable scrolling through the Command Prompt window. By increasing the number of buffers to five, you increase the number of lines in the Command Prompt window to 5000.

4.  In **Edit Options**, select the **Quick Edit Mode** and **Insert Mode** check boxes.

5.  Click the **Layout** tab.

6.  In **Screen Buffer Size**, type or select **2500** in **Height**.

7.  To further customize your Command Prompt window settings, perform any of the following optional tasks:

    -   In **Screen Buffer Size**, increase **Width**.

    -   In **Window Size**, increase **Height**.

    -   In **Window Size**, increase **Width**.

    -   Clear the **Let system position window** check box, and then, in **Window Position**, change the values in **Left** and **Top**.

8.  In the **Apply Properties** dialog box, click **Save properties for future windows with same title**.

> [!NOTE]
> To enable or disable file and directory name completion on a computer or user logon session, run **Regedit.exe** and set the following **REG\_DWORD value**:
> 
> HKEY\_LOCAL\_MACHINE\\Software\\Microsoft\\Command Processor\\CompletionChar\\REG\_DWORD
> 
> To set the **REG\_DWORD** value, use the hexadecimal value of a control character for a particular function \(for example, **0×9** is Tab and **0×08** is Backspace\). User\-specified settings take precedence over computer settings, and command\-line options take precedence over registry settings.

> [!CAUTION]
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

## <a name="BKMK_CmdRef"></a>Command\-line reference A\-Z
To find information about a specific command, in the following A\-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) | [B](#BKMK_b) | [C](#BKMK_c) | [D](#BKMK_d) | [E](#BKMK_e) | [F](#BKMK_f) | [G](#BKMK_g) | [H](#BKMK_h) | [I](#BKMK_i) | [J](#BKMK_j) | [K](#BKMK_k) | [L](#BKMK_l) | [M](#BKMK_m) | [N](#BKMK_n) | [O](#BKMK_o) | [P](#BKMK_p) | [Q](#BKMK_q) | [R](#BKMK_r) | [S](#BKMK_s) | [T](#BKMK_t) | [U](#bkmk_u) | [V](#bkmk_v) | [W](#bkmk_w) | [X](#bkmk_x) | [Y](Command-Line-Reference_1.md#BKMK_y) | [Z](Command-Line-Reference_1.md#BKMK_z)

> [!NOTE]
> Each command\-line tool topic displays the version of Windows that is supported by the command\-line tool.

### <a name="bkmk_a"></a>A

-   [Append](Append.md)

-   [Arp](Arp.md)

-   [Assoc](Assoc.md)

-   [At](At.md)

-   [Atmadm](Atmadm.md)

-   [Attrib](Attrib.md)

-   [Auditpol](Auditpol.md)

-   [Autochk](Autochk.md)

-   [Autoconv](Autoconv.md)

-   [Autofmt](Autofmt.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_b"></a>B

-   [Bcdboot](Bcdboot.md)

-   [Bcdedit](Bcdedit.md)

-   [Bdehdcfg](Bdehdcfg.md)

-   [Bitsadmin](Bitsadmin.md)

-   [Bootcfg](Bootcfg.md)

-   [Break_1](Break_1.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_c"></a>C

-   [Cacls_1](Cacls_1.md)

-   [Call](Call.md)

-   [Cd](Cd.md)

-   [Certreq_OLD](Certreq_OLD.md)

-   [Certutil](Certutil.md)

-   [Change](Change.md)

-   [Chcp](Chcp.md)

-   [Chdir_1](Chdir_1.md)

-   [Chglogon](Chglogon.md)

-   [Chgport](Chgport.md)

-   [Chgusr](Chgusr.md)

-   [Chkdsk](Chkdsk.md)

-   [Chkntfs](Chkntfs.md)

-   [Choice](Choice.md)

-   [Cipher](Cipher.md)

-   [Clip](Clip.md)

-   [Cls](Cls.md)


-   [Cmd](Cmd.md)

-   [Cmdkey](Cmdkey.md)

-   [Cmstp](Cmstp.md)

-   [Color](Color.md)

-   [Comp](Comp.md)

-   [Compact](Compact.md)

-   [Convert](Convert.md)

-   [Copy](Copy.md)

-   [Cprofile](Cprofile.md)

-   [Cscript](Cscript.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_d"></a>D

-   [Date](Date.md)

-   [Dcgpofix](Dcgpofix.md)

-   [Defrag](Defrag.md)

-   [Del](Del.md)

-   [Dfsrmig](Dfsrmig.md)

-   [Diantz](Diantz.md)

-   [Dir](Dir.md)

-   [Diskcomp](Diskcomp.md)

-   [Diskcopy](Diskcopy.md)

-   [Diskperf](Diskperf.md)

-   [DiskRAID](DiskRAID.md)

-   [Diskshadow](Diskshadow.md)

-   [Dispdiag](Dispdiag.md)

-   [Dnscmd](Dnscmd.md)

-   [Doskey](Doskey.md)

-   [Driverquery](Driverquery.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_e"></a>E

-   [Echo](Echo.md)

-   [Edit](Edit.md)

-   [Endlocal](Endlocal.md)

-   [Erase](Erase.md)

-   [Eventcreate](Eventcreate.md)

-   [Eventquery.vbs](Eventquery.vbs.md)

-   [Eventtriggers](Eventtriggers.md)

-   [Evntcmd](Evntcmd.md)

-   [Exit_2](Exit_2.md)

-   [Expand](Expand.md)

-   [Extract](Extract.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_f"></a>F

-   [Fc](Fc.md)

-   [Find](Find.md)

-   [Findstr](Findstr.md)

-   [Finger](Finger.md)

-   [Flattemp](Flattemp.md)

-   [Fondue](Fondue.md)

-   [For](For.md)

-   [Forfiles](Forfiles.md)

-   [Format_](Format_.md)

-   [Freedisk](Freedisk.md)

-   [Fsutil](Fsutil.md)

-   [Ftp](Ftp.md)

-   [Ftype](Ftype.md)

-   [Fveupdate](Fveupdate.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_g"></a>G

-   [Getmac](Getmac.md)

-   [Gettype](Gettype.md)

-   [Goto](Goto.md)

-   [Gpfixup](Gpfixup.md)

-   [Gpresult](Gpresult.md)

-   [Gpupdate](Gpupdate.md)

-   [Graftabl](Graftabl.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_h"></a>H

-   [Help](Help.md)

-   [Helpctr](Helpctr.md)

-   [Hostname](Hostname.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_i"></a>I

-   [Icacls](Icacls.md)

-   [If](If.md)

-   [Inuse](Inuse.md)

-   [Ipconfig](Ipconfig.md)

-   [Ipxroute](Ipxroute.md)

-   [Irftp](Irftp.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_j"></a>J

-   [Jetpack](Jetpack.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_k"></a>K

-   [Klist](Klist.md)

-   [Ksetup](Ksetup.md)

-   [Ktmutil](Ktmutil.md)

-   [Ktpass](Ktpass.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_l"></a>L

-   [Label](Label.md)

-   [Lodctr](Lodctr.md)

-   [Logman](Logman.md)

-   [Logoff](Logoff.md)

-   [Lpq](Lpq.md)

-   [Lpr](Lpr.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_m"></a>M

-   [Macfile](Macfile.md)

-   [Makecab](Makecab.md)

-   [Manage-bde](Manage-bde.md)

-   [mapadmin](mapadmin.md)

-   [Md](Md.md)

-   [Mkdir](Mkdir.md)

-   [Mklink](Mklink.md)

-   [Mmc](Mmc.md)

-   [Mode](Mode.md)

-   [More](More.md)

-   [Mount](Mount.md)

-   [Mountvol](Mountvol.md)

-   [Move](Move.md)

-   [Mqbkup](Mqbkup.md)

-   [Mqsvc](Mqsvc.md)

-   [Mqtgsvc](Mqtgsvc.md)

-   [Msdt](Msdt.md)

-   [Msg](Msg.md)

-   [Msiexec](Msiexec.md)

-   [Msinfo32](Msinfo32.md)

-   [Mstsc](Mstsc.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_n"></a>N

-   [Nbtstat](Nbtstat.md)

-   [Netcfg](Netcfg.md)

-   [Netsh](Netsh.md)

-   [Netstat](Netstat.md)

-   [Net print](Net-print.md)

-   [Nfsadmin](Nfsadmin.md)

-   [Nfsshare](Nfsshare.md)

-   [Nfsstat](Nfsstat.md)

-   [Nlbmgr](Nlbmgr.md)

-   [Nslookup](Nslookup.md)

-   [Ntbackup](Ntbackup.md)

-   [Ntcmdprompt](Ntcmdprompt.md)

-   [Ntfrsutl](Ntfrsutl.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_o"></a>O

-   [Openfiles](Openfiles.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_p"></a>P

-   [Pagefileconfig.vbs](Pagefileconfig.vbs.md)

-   [Path](Path.md)

-   [Pathping](Pathping.md)

-   [Pause](Pause.md)

-   [Pbadmin](Pbadmin.md)

-   [Pentnt](Pentnt.md)

-   [Perfmon](Perfmon.md)

-   [Ping](Ping.md)

-   [Pnpunattend](Pnpunattend.md)

-   [Pnputil](Pnputil.md)

-   [Popd](Popd.md)


-   [PowerShell](PowerShell.md)

-   [PowerShell_Ise](PowerShell_Ise.md)

-   [Print](Print.md)

-   [Prncnfg.vbs](Prncnfg.vbs.md)

-   [Prndrvr.vbs](Prndrvr.vbs.md)

-   [Prnjobs.vbs](Prnjobs.vbs.md)

-   [Prnmngr.vbs](Prnmngr.vbs.md)

-   [Prnport.vbs](Prnport.vbs.md)

-   [Prnqctl.vbs](Prnqctl.vbs.md)

-   [Prompt](Prompt.md)

-   [Pubprn.vbs](Pubprn.vbs.md)

-   [Pushd](Pushd.md)

-   [Pushprinterconnections](Pushprinterconnections.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_q"></a>Q

-   [Qappsrv](Qappsrv.md)

-   [Qprocess](Qprocess.md)

-   [Query](Query.md)

-   [Quser](Quser.md)

-   [Qwinsta](Qwinsta.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_r"></a>R

-   [Rcp](Rcp.md)

-   [Rd](Rd.md)

-   [Rdpsign](Rdpsign.md)

-   [Recover](Recover.md)

-   [Reg](Reg.md)

-   [Regini](Regini.md)

-   [Regsvr32](Regsvr32.md)

-   [Relog](Relog.md)

-   [Rem](Rem.md)

-   [Ren](Ren.md)

-   [Rename](Rename.md)

-   [Repair-bde](Repair-bde.md)

-   [Replace](Replace.md)

-   [Reset session](Reset-session.md)

-   [Rexec](Rexec.md)

-   [Risetup](Risetup.md)

-   [Rmdir](Rmdir.md)

-   [Robocopy](Robocopy.md)

-   [Route_WS2008](Route_WS2008.md)

-   [Rpcinfo](Rpcinfo.md)

-   [Rpcping](Rpcping.md)

-   [Rsh](Rsh.md)

-   [Rundll32](Rundll32.md)

-   [Rwinsta](Rwinsta.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_s"></a>S

-   [Schtasks](Schtasks.md)

-   [Scwcmd](Scwcmd.md)

-   [Secedit](Secedit.md)

-   [Serverceipoptin](Serverceipoptin.md)

-   [Servermanagercmd](Servermanagercmd.md)

-   [Serverweroptin](Serverweroptin.md)

-   [Set_1](Set_1.md)

-   [Setlocal](Setlocal.md)


-   [Setx](Setx.md)

-   [Sfc](Sfc.md)

-   [Shadow](Shadow.md)

-   [Shift](Shift.md)

-   [Showmount](Showmount.md)

-   [Shutdown](Shutdown.md)

-   [Sort](Sort.md)

-   [Start](Start.md)

-   [Subst](Subst.md)

-   [Sxstrace](Sxstrace.md)

-   [Sysocmgr](Sysocmgr.md)

-   [Systeminfo](Systeminfo.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_t"></a>T

-   [Takeown](Takeown.md)

-   [Tapicfg](Tapicfg.md)

-   [Taskkill](Taskkill.md)

-   [Tasklist](Tasklist.md)

-   [Tcmsetup](Tcmsetup.md)

-   [Telnet](Telnet.md)

-   [Tftp](Tftp.md)

-   [Time](Time.md)

-   [Timeout_1](Timeout_1.md)

-   [Title_1](Title_1.md)

-   [Tlntadmn](Tlntadmn.md)

-   [Tpmvscmgr](Tpmvscmgr.md)

-   [Tracerpt_1](Tracerpt_1.md)

-   [Tracert](Tracert.md)

-   [Tree](Tree.md)

-   [Tscon](Tscon.md)

-   [Tsdiscon](Tsdiscon.md)

-   [Tsecimp_1](Tsecimp_1.md)

-   [Tskill](Tskill.md)

-   [Tsprof](Tsprof.md)

-   [Type](Type.md)

-   [Typeperf](Typeperf.md)

-   [Tzutil](Tzutil.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_u"></a>U


-   [Unlodctr_1](Unlodctr_1.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_v"></a>V

-   [Ver](Ver.md)

-   [Verifier](Verifier.md)

-   [Verify_1](Verify_1.md)

-   [Vol](Vol.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_w"></a>W

-   [Waitfor](Waitfor.md)

-   [Wbadmin](Wbadmin.md)

-   [Wdsutil](Wdsutil.md)

-   [Wecutil](Wecutil.md)

-   [Wevtutil](Wevtutil.md)

-   [Where_1](Where_1.md)

-   [Whoami](Whoami.md)

-   [Winnt](Winnt.md)

-   [Winnt32](Winnt32.md)

-   [Winpop](Winpop.md)

-   [Winrs](Winrs.md)

-   [Wlbs_1](Wlbs_1.md)

-   [Wmic](Wmic.md)

-   [Wscript](Wscript.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="bkmk_x"></a>X

-   [Xcopy](Xcopy.md)

[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_y"></a>Y
[Command-line reference A-Z](#BKMK_CmdRef)

### <a name="BKMK_z"></a>Z
[Command-line reference A-Z](#BKMK_CmdRef)


