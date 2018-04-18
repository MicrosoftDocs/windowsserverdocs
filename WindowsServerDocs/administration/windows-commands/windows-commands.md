---
title: Windows Commands
description: Windows Commands 
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c703d07c-8227-4e86-94a6-8ef390f94cdc
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
ms.prod: windows-server-threshold
---
# Windows Commands

Use this PDF to find the documentation resources and other technical information that you need to learn about the command shell, and to automate command-line tasks by using scripts or scripting tools.

To find information about a specific command, in the following A-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) |
[B](#BKMK_b) | 
[C](#BKMK_c) | 
[D](#BKMK_d) | 
[E](#BKMK_e) | 
[F](#BKMK_f) | 
[G](#BKMK_g) | 
[H](#BKMK_h) | 
[I](#BKMK_i) |
[J](#BKMK_j) | 
[K](#bkmk_k) | 
[L](#BKMK_l) | 
[M](#BKMK_m) | 
[N](#BKMK_n) | 
[O](#BKMK_o) | 
[P](#BKMK_p) | 
[Q](#BKMK_q) | 
[R](#BKMK_r) | 
[S](#BKMK_s) | 
[T](#BKMK_t) | 
[U](#bkmk_u) | 
[V](#bkmk_v) | 
[W](#bkmk_w) | 
[X](#bkmk_x) | 
[Y](#bkmk_y) | 
[Z](#bkmk_z)

## <a name="BKMK_PREREQ"></a>Prerequisites
The information that is contained in this PDF applies to:

-   Windows Server (Semi-Annual Channel)
-   Windows Server 2016
-   Windows Server 2012 R2
-   Windows Server 2012 
-   Windows Server 2008 R2
-   Windows Server 2008
-   Windows 10
-   Windows 8.1

### <a name="BKMK_OVR"></a>Command shell overview
The command shell is a software program that provides direct communication between the user and the operating system. The non-graphical, command shell user interface provides the environment in which you run character-based applications and utilities. The command shell executes programs and displays their output on the screen by using individual characters similar to the MS-DOS command interpreter, Command.com. The command shell in the Windows Server operating system uses the command interpreter, Cmd.exe. Cmd.exe loads applications, directs the flow of information between applications, and translates user input into a form that the operating system understands.

You can use the command shell to create and edit scripts to automate routine tasks. For example, you can create simple scripts in batch (.bat) files to automate the management of user accounts or nightly backups. You can also use the command-line version of Windows Script Host to run more sophisticated scripts in the command shell. For more information, see [cscript](cscript.md) or [wscript](wscript.md). You can perform operations more efficiently by using scripts than you can by using the user interface. Scripts accept all commands that are available at the command line.

### <a name="BKMK_Custom"></a>Customize the Command prompt window

You can change the properties for the Command prompt window.

##### To configure the Command prompt window
1.  Open a Command prompt window, click the upper-left corner of the Command prompt window, and then click **Properties**. (Or to open **Command prompt Properties** from the keyboard, press ALT+SPACEBAR+P.)
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
> To enable or disable file and directory name completion on a computer or user logon session, run **regedit.exe** and set the following **reg_DWOrd value**:
> 
> HKEY_LOCAL_MACHINE\Software\Microsoft\Command Processor\completionChar\reg_DWOrd
> 
> To set the **reg_DWOrd** value, use the hexadecimal value of a control character for a particular function (for example, **0 9** is Tab and **0 08** is Backspace). User-specified settings take precedence over computer settings, and command-line options take precedence over registry settings.

> [!CAUTION]
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.

## <a name="BKMK_CmdRef"></a>Command-line reference A-Z
To find information about a specific command, in the following A-Z menu, click the letter that the command starts with, and then click the command name.

[A](#bkmk_a) |
[B](#BKMK_b) | 
[C](#BKMK_c) | 
[D](#BKMK_d) | 
[E](#BKMK_e) | 
[F](#BKMK_f) | 
[G](#BKMK_g) | 
[H](#BKMK_h) | 
[I](#BKMK_i) |
[J](#BKMK_j) | 
[K](#bkmk_k) | 
[L](#BKMK_l) | 
[M](#BKMK_m) | 
[N](#BKMK_n) | 
[O](#BKMK_o) | 
[P](#BKMK_p) | 
[Q](#BKMK_q) | 
[R](#BKMK_r) | 
[S](#BKMK_s) | 
[T](#BKMK_t) | 
[U](#bkmk_u) | 
[V](#bkmk_v) | 
[W](#bkmk_w) | 
[X](#bkmk_x) | 
[Y](#bkmk_y) | 
[Z](#bkmk_z)

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

### <a name="BKMK_b"></a>B
-   [bcdboot](bcdboot.md)
-   [bcdedit](bcdedit.md)
-   [bdehdcfg](bdehdcfg.md)
-   [bitsadmin](bitsadmin.md)
  -   [bitsadmin addfile](bitsadmin-addfile.md)
  -   [bitsadmin addfileset](bitsadmin-addfileset.md)
  -   [bitsadmin addfilewithranges](bitsadmin-addfilewithranges.md)
  -   [bitsadmin cancel](bitsadmin-cancel.md)
  -   [bitsadmin complete](bitsadmin-complete.md)
  -   [bitsadmin create](bitsadmin-create.md)
  -   [bitsadmin getaclflags](bitsadmin-getaclflags.md)
  -   [bitsadmin getbytestotal](bitsadmin-getbytestotal.md)
  -   [bitsadmin getbytestransferred](bitsadmin-getbytestransferred.md)
  -   [bitsadmin getcompletiontime](bitsadmin-getcompletiontime.md)
  -   [bitsadmin getcreationtime](bitsadmin-getcreationtime.md)
  -   [bitsadmin getdescription](bitsadmin-getdescription.md)
  -   [bitsadmin getdisplayname](bitsadmin-getdisplayname.md)
  -   [bitsadmin geterror](bitsadmin-geterror.md)
  -   [bitsadmin geterrorcount](bitsadmin-geterrorcount.md)
  -   [bitsadmin getfilestotal](bitsadmin-getfilestotal.md)
  -   [bitsadmin getfilestransferred](bitsadmin-getfilestransferred.md)
  -   [bitsadmin getminretrydelay](bitsadmin-getminretrydelay.md)
  -   [bitsadmin getmodificationtime](bitsadmin-getmodificationtime.md)
  -   [bitsadmin getnoprogresstimeout](bitsadmin-getnoprogresstimeout.md)
  -   [bitsadmin getnotifycmdline](bitsadmin-getnotifycmdline.md)
  -   [bitsadmin getnotifyflags](bitsadmin-getnotifyflags.md)
  -   [bitsadmin getnotifyinterface](bitsadmin-getnotifyinterface.md)
  -   [bitsadmin getowner](bitsadmin-getowner.md)
  -   [bitsadmin get priority](bitsadmin-get-priority.md)
  -   [bitsadmin getproxybypasslist](bitsadmin-getproxybypasslist.md)
  -   [bitsadmin getproxylist](bitsadmin-getproxylist.md)
  -   [bitsadmin getproxyusage](bitsadmin-getproxyusage.md)
  -   [bitsadmin getreplydata](bitsadmin-getreplydata.md)
  -   [bitsadmin getreplyfilename](bitsadmin-getreplyfilename.md)
  -   [bitsadmin getreplyprogress](bitsadmin-getreplyprogress.md)
  -   [bitsadmin getstate](bitsadmin-getstate.md)
  -   [bitsadmin gettype](bitsadmin-gettype.md)
  -   [bitsadmin help](bitsadmin-help.md)
  -   [bitsadmin info](bitsadmin-info.md)
  -   [bitsadmin list](bitsadmin-list.md)
  -   [bitsadmin listfiles](bitsadmin-listfiles.md)
  -   [bitsadmin monitor](bitsadmin-monitor.md)
  -   [bitsadmin nowrap](bitsadmin-nowrap.md)
  -   [bitsadmin rawreturn](bitsadmin-rawreturn.md)
  -   [bitsadmin removecredentials](bitsadmin-removecredentials.md)
  -   [bitsadmin replaceremoteprefix](bitsadmin-replaceremoteprefix.md)
  -   [bitsadmin reset](bitsadmin-reset.md)
  -   [bitsadmin resume](bitsadmin-resume.md)
  -   [bitsadmin setaclflag](bitsadmin-setaclflag.md)
  -   [bitsadmin setcredentials](bitsadmin-setcredentials.md)
  -   [bitsadmin setdescription](bitsadmin-setdescription.md)
  -   [bitsadmin setdisplayname](bitsadmin-setdisplayname.md)
  -   [bitsadmin setminretrydelay](bitsadmin-setminretrydelay.md)
  -   [bitsadmin setnoprogresstimeout](bitsadmin-setnoprogresstimeout.md)
  -   [bitsadmin setnotifycmdline](bitsadmin-setnotifycmdline.md)
  -   [bitsadmin setnotifyflags](bitsadmin-setnotifyflags.md)
  -   [bitsadmin setpriority](bitsadmin-setpriority.md)
  -   [bitsadmin setproxysettings](bitsadmin-setproxysettings.md)
  -   [bitsadmin setreplyfilename](bitsadmin-setreplyfilename.md)
  -   [bitsadmin suspend](bitsadmin-suspend.md)
  -   [bitsadmin takeownership](bitsadmin-takeownership.md)
  -   [bitsadmin Transfer](bitsadmin-transfer.md)
  -   [bitsadmin util](bitsadmin-util.md)
  -   [bitsadmin wrap](bitsadmin-wrap.md)
-   [bootcfg](bootcfg.md)
  -   [bootcfg addsw](bootcfg-addsw.md)
  -   [bootcfg copy](bootcfg-copy.md)
  -   [bootcfg dbg1394](bootcfg-dbg1394.md)
  -   [bootcfg debug](bootcfg-debug.md)  
  -   [bootcfg default](bootcfg-default.md)
  -   [bootcfg delete](bootcfg-delete.md)
  -   [bootcfg ems](bootcfg-ems.md)
  -   [bootcfg query](bootcfg-query.md)
  -   [bootcfg raw](bootcfg-raw.md)
  -   [bootcfg rmsw](bootcfg-rmsw.md)
  -   [bootcfg timeout](bootcfg-timeout.md)
-   [break](break_1.md)

### <a name="BKMK_c"></a>C
-   [cacls](cacls_1.md)
-   [call](call.md)
-   [cd](cd.md)
-   [certreq](certreq_1.md)
-   [certutil](certutil.md)
-   [change](change.md)
  -   [change logon](change-logon.md)
  -   [change port](change-port.md)
  -   [change user](change-user.md)
-   [chcp](chcp.md)
-   [chdir](chdir_1.md)
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
-   [dnscmd](Dnscmd.md)
-   [doskey](doskey.md)
-   [driverquery](driverquery.md)

### <a name="BKMK_e"></a>E
-   [echo](echo.md)
-   [edit](edit.md)
-   [endlocal](endlocal.md)
-   [erase](erase.md)
-   [eventcreate](eventcreate.md)
-   [eventquery](eventquery.md)
-   [eventtriggers](eventtriggers.md)
-   [evntcmd](Evntcmd.md)
-   [exit](exit_2.md)
-   [expand](expand.md)
-   [extract](extract.md)

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
  -   [fsutil 8dot3name](fsutil-8dot3name.md) 
  -   [fsutil behavior](fsutil-behavior.md) 
  -   [fsutil file](fsutil-file.md)
  -   [fsutil fsinfo](fsutil-fsinfo.md)
  -   [fsutil hardlink](fsutil-hardlink.md)
  -   [fsutil objectid](fsutil-objectid.md)
  -   [fsutil quota](fsutil-quota.md)
  -   [fsutil repair](fsutil-repair.md)
  -   [fsutil reparsepoint](fsutil-reparsepoint.md)
  -   [fsutil resource](fsutil-resource.md)
  -   [fsutil sparse](fsutil-sparse.md)
  -   [fsutil tiering](fsutil-tiering.md)
  -   [fsutil transaction](fsutil-transaction.md)
  -   [fsutil usn](fsutil-usn.md)
  -   [fsutil volume](fsutil-volume.md)
  -   [fsutil wim](fsutil-wim.md)
-   [ftp](ftp.md)
-   [ftype](ftype.md)
-   [fveupdate](fveupdate.md)

### <a name="BKMK_g"></a>G
-   [getmac](getmac.md)
-   [gettype](gettype.md)
-   [goto](goto.md)
-   [gpfixup](gpfixup.md)
-   [gpresult](gpresult.md)
-   [gpupdate](gpupdate.md)
-   [graftabl](graftabl.md)

### <a name="BKMK_h"></a>H
-   [help](help.md)
-   [helpctr](helpctr.md)
-   [hostname](hostname.md)

### <a name="BKMK_i"></a>I
-   [icacls](icacls.md)
-   [if](if.md)
-   [inuse](inuse.md)
-   [ipconfig](ipconfig.md)
-   [ipxroute](ipxroute.md)
-   [irftp](irftp.md)

### <a name="BKMK_j"></a>J
-   [jetpack](jetpack.md)

### <a name="BKMK_k"></a>K
-   [klist](klist.md)
-   [ksetup](ksetup.md)
  -   [ksetup:setrealm](ksetup-setrealm.md)
  -   [ksetup:mapuser](ksetup-mapuser.md)
  -   [ksetup:addkdc](ksetup-addkdc.md)
  -   [ksetup:delkdc](ksetup-delkdc.md)
  -   [ksetup:addkpasswd](ksetup-addkpasswd.md)
  -   [ksetup:delkpasswd](ksetup-delkpasswd.md)
  -   [ksetup:server](ksetup-server.md)
  -   [ksetup:setcomputerpassword](ksetup-setcomputerpassword.md)
  -   [ksetup:removerealm](ksetup-removerealm.md)
  -   [ksetup:domain](ksetup-domain.md)
  -   [ksetup:changepassword](ksetup-changepassword.md)
  -   [ksetup:listrealmflags](ksetup-listrealmflags.md)
  -   [ksetup:setrealmflags](ksetup-setrealmflags.md)
  -   [ksetup:addrealmflags](ksetup-addrealmflags.md)
  -   [ksetup:delrealmflags](ksetup-delrealmflags.md)
  -   [ksetup:dumpstate](ksetup-dumpstate.md)
  -   [ksetup:addhosttorealmmap](ksetup-addhosttorealmmap.md)
  -   [ksetup:delhosttorealmmap](ksetup-delhosttorealmmap.md)
  -   [ksetup:setenctypeattr](ksetup-setenctypeattr.md)
  -   [ksetup:getenctypeattr](ksetup-getenctypeattr.md)
  -   [ksetup:addenctypeattr](ksetup-addenctypeattr.md)
  -   [ksetup:delenctypeattr](ksetup-delenctypeattr.md) 
-   [ktmutil](ktmutil.md)
-   [ktpass](ktpass.md)

### <a name="BKMK_l"></a>L
-   [label](label.md)
-   [lodctr](lodctr.md)
-   [logman](logman.md)
  -   [logman create](logman-create.md)
  -   [logman query](logman-query.md)
  -   [logman start &124; stop](logman-start-stop.md)
  -   [logman delete](logman-delete.md)
  -   [logman update](logman-update.md)
  -   [logman import &124; export](logman-import-export.md)
-   [logoff](logoff.md)
-   [lpq](lpq.md)
-   [lpr](lpr.md)

### <a name="BKMK_m"></a>M
-   [macfile](macfile.md)
-   [makecab](makecab.md)
-   [manage-bde](manage-bde.md)
  -   [manage-bde: status](manage-bde-status.md)
  -   [manage-bde: on](manage-bde-on.md)
  -   [manage-bde: off](manage-bde-off.md)
  -   [manage-bde: pause](manage-bde-pause.md)
  -   [manage-bde: resume](manage-bde-resume.md)
  -   [manage-bde: lock](manage-bde-lock.md)
  -   [manage-bde: unlock](manage-bde-unlock.md)
  -   [manage-bde: autounlock](manage-bde-autounlock.md)
  -   [manage-bde: protectors](manage-bde-protectors.md)
  -   [manage-bde: tpm](manage-bde-tpm.md)
  -   [manage-bde: setidentifier](manage-bde-setidentifier.md)
  -   [manage-bde: ForceRecovery](manage-bde-forcerecovery.md)
  -   [manage-bde: changepassword](manage-bde-changepassword.md)
  -   [manage-bde: changepin](manage-bde-changepin.md)
  -   [manage-bde: changekey](manage-bde-changekey.md)
  -   [manage-bde: KeyPackage](manage-bde-keypackage.md)
  -   [manage-bde: upgrade](manage-bde-upgrade.md)
  -   [manage-bde: WipeFreeSpace](manage-bde-wipefreespace.md)
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
  -   [nslookup exit command](nslookup-exit-command.md)
  -   [nslookup finger command](nslookup-finger-command.md)
  -   [nslookup help](nslookup-help.md)
  -   [nslookup ls](nslookup-ls.md)
  -   [nslookup lserver](nslookup-lserver.md)
  -   [nslookup root](nslookup-root.md)
  -   [nslookup server](nslookup-server.md)
  -   [nslookup set](nslookup-set.md)
  -   [nslookup set all](nslookup-set-all.md)
  -   [nslookup set class](nslookup-set-class.md)
  -   [nslookup set d2](nslookup-set-d2.md)
  -   [nslookup set debug](nslookup-set-debug.md)
  -   [nslookup set domain](nslookup-set-domain.md)
  -   [nslookup set port](nslookup-set-port.md)
  -   [nslookup set querytype](nslookup-set-querytype.md)
  -   [nslookup set recurse](nslookup-set-recurse.md)
  -   [nslookup set retry](nslookup-set-retry.md)
  -   [nslookup set root](nslookup-set-root.md)
  -   [nslookup set search](nslookup-set-search.md)
  -   [nslookup set srchlist](nslookup-set-srchlist.md)
  -   [nslookup set timeout](nslookup-set-timeout.md)
  -   [nslookup set type](nslookup-set-type.md)
  -   [nslookup set vc](nslookup-set-vc.md)
  -   [nslookup view](nslookup-view.md)
-   [ntbackup](ntbackup.md)
-   [ntcmdprompt](ntcmdprompt.md)
-   [ntfrsutl](ntfrsutl.md)

### <a name="BKMK_o"></a>O
-   [openfiles](openfiles.md)

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

### <a name="BKMK_q"></a>Q
-   [qappsrv](qappsrv.md)
-   [qprocess](qprocess.md)
-   [query](query.md)
-   [quser](quser.md)
-   [qwinsta](qwinsta.md)

### <a name="BKMK_r"></a>R
-   [rcp](rcp.md)
-   [rd](rd.md)
-   [rdpsign](rdpsign.md)
-   [recover](recover.md)
-   [reg](reg.md)
  -   [reg add](reg-add.md)
  -   [reg compare](reg-compare.md)
  -   [reg copy](reg-copy.md)
  -   [reg delete](reg-delete.md)
  -   [reg export](reg-export.md)
  -   [reg import](reg-import.md)
  -   [reg load](reg-load.md)
  -   [reg query](reg-query.md)
  -   [reg restore](reg-restore.md)
  -   [reg save](reg-save.md)
  -   [reg unload](reg-unload.md)
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

### <a name="BKMK_s"></a>S
-   [schtasks](schtasks.md)
-   [scwcmd](Scwcmd.md)
  -   [scwcmd: analyze](scwcmd-analyze.md)
  -   [scwcmd: configure](scwcmd-configure.md)
  -   [scwcmd: register](scwcmd-register.md) 
  -   [scwcmd: rollback](scwcmd-rollback.md) 
  -   [scwcmd: transform](scwcmd-transform.md) 
  -   [scwcmd: view](scwcmd-view.md) 
-   [secedit](secedit.md)
  -   [secedit:analyze](secedit-analyze.md)
  -   [secedit:configure](secedit-configure.md)
  -   [secedit:export](secedit-export.md)
  -   [secedit:generaterollback](secedit-generaterollback.md)
  -   [secedit:import](secedit-import.md)
  -   [secedit:validate](secedit-validate.md)
-   [serverceipoptin](serverceipoptin.md)
-   [Servermanagercmd](Servermanagercmd.md)
-   [serverweroptin](serverweroptin.md)
-   [set](set_1.md)
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

### <a name="BKMK_t"></a>T
-   [takeown](takeown.md)
-   [tapicfg](tapicfg.md)
-   [taskkill](taskkill.md)
-   [tasklist](tasklist.md)
-   [tcmsetup](tcmsetup.md)
-   [telnet](telnet.md)
-   [tftp](tftp.md)
-   [time](time.md)
-   [timeout](timeout_1.md)
-   [title](title_1.md)
-   [tlntadmn](tlntadmn.md)
-   [tpmvscmgr](tpmvscmgr.md)
-   [tracerpt](tracerpt_1.md)
-   [tracert](tracert.md)
-   [tree](tree.md)
-   [tscon](tscon.md)
-   [tsdiscon](tsdiscon.md)
-   [tsecimp](tsecimp_1.md)
-   [tskill](tskill.md)
-   [tsprof](tsprof.md)
-   [type](type.md)
-   [typeperf](typeperf.md)
-   [tzutil](tzutil.md)

### <a name="bkmk_u"></a>U
-   [unlodctr](unlodctr_1.md)

### <a name="bkmk_v"></a>V
-   [ver](ver.md)
-   [verifier](verifier.md)
-   [verify](verify_1.md)
-   [vol](vol.md)

### <a name="bkmk_w"></a>W
-   [waitfor](waitfor.md)
-   [wbadmin](wbadmin.md)
  -   [wbadmin enable backup](wbadmin-enable-backup.md)
  -   [wbadmin disable backup](wbadmin-disable-backup.md)
  -   [wbadmin start backup](wbadmin-start-backup.md)
  -   [wbadmin stop job](wbadmin-stop-job.md)
  -   [wbadmin get versions](wbadmin-get-versions.md)
  -   [wbadmin get items](wbadmin-get-items.md)
  -   [wbadmin start recovery](wbadmin-start-recovery.md)
  -   [wbadmin get status](wbadmin-get-status.md)
  -   [wbadmin get disks](wbadmin-get-disks.md)
  -   [wbadmin start systemstaterecovery](wbadmin-start-systemstaterecovery.md)
  -   [wbadmin start systemstatebackup](wbadmin-start-systemstatebackup.md)
  -   [wbadmin delete systemstatebackup](wbadmin-delete-systemstatebackup.md)
  -   [wbadmin start sysrecovery](wbadmin-start-sysrecovery.md)
  -   [wbadmin restore catalog](wbadmin-restore-catalog.md)
  -   [wbadmin delete catalog](wbadmin-delete-catalog.md)
-   [wdsutil](wdsutil.md)
-   [wecutil](wecutil.md)
-   [wevtutil](wevtutil.md)
-   [where](where_1.md)
-   [whoami](whoami.md)
-   [winnt](winnt.md)
-   [winnt32](winnt32.md)
-   [winpop](winpop.md)
-   [winrs](winrs.md)
-   [wlbs](wlbs_1.md)
-   [wmic](wmic.md)
-   [wscript](wscript.md)

### <a name="bkmk_x"></a>X
-   [xcopy](xcopy.md)