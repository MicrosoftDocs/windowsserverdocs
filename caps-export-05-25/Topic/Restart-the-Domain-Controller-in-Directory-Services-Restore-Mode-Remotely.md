---
title: Restart the Domain Controller in Directory Services Restore Mode Remotely
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 6e14029f-e5ac-4da9-9a3e-927480a34c2c
author: Femila
---
# Restart the Domain Controller in Directory Services Restore Mode Remotely
  If you have remote access to a domain controller, you can restart the domain controller in Directory Services Restore Mode \(DSRM\) remotely. Remote access requires the user right to log on locally to a domain controller. Restarting in DSRM takes the domain controller offline. In this mode, the server is functioning as a member server, not a domain controller.  
  
 During installation of Active Directory Domain Services \(AD DS\), you set the Administrator password for logging on to the server in DSRM. When you start [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in DSRM, you must log on by using this DSRM password for the local Administrator account.  
  
> [!NOTE]  
>  By default, you must start a domain controller in DSRM to log on by using the DSRM Administrator account. However, on domain controllers that are running Windows Server 2008, you can change this behavior by modifying the **DSRMAdminLogonBehavior** registry entry. By changing the value for this entry, you can configure a domain controller so that you can log on to it with the DSRM Administrator account if the domain controller was started normally but the AD DS service is stopped for some reason. For more information about changing this registry entry, see the Windows Server 2008 Restartable AD DS Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=88649](http://go.microsoft.com/fwlink/?LinkId=88649)\).  
  
 On domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], tools are available that replace the Boot.ini file that is used in earlier versions of Windows Server to modify the boot configuration parameters and controls. You can use the Windows graphical user interface \(GUI\) or the command line or to restart the domain controller in DSRM:  
  
-   **Windows GUI:** System Configuration \(Msconfig.msc\) is an administrative tool that you can use to configure boot and startup options, including restarting in DSRM and normal mode.  
  
-   **Command line:** Bcdedit.exe is a command\-line tool that you can use to modify the boot configuration on a server that is running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. You can use Bcdedit with **shutdown** commands to instruct the domain controller to restart in DSRM and to restart normally.  
  
 To restart the domain controller in DSRM remotely, you first use Remote Desktop Connection to connect to the domain controller while it is in normal startup mode. Remote Desktop Connection must be enabled on the target domain controller. After the domain controller has restarted, you can use Remote Desktop Connection to reconnect to the domain controller and then log on as the local Administrator, using the DSRM password.  
  
 You can use this procedure to connect to a domain controller remotely, restart it in DSRM, and then reconnect to it as the DSRM administrator.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete the System Configuration \(Windows GUI\) or Bcdedit \(command\-line\) procedure. The Administrator account and password for DSRM and the user right to log on locally to a domain controller are required to log on to the domain controller in DSRM. Members of Account Operators, Administrators, Enterprise Admins, Domain Admins, Backup Operators, Print Operators, and Server Operators have the user right to log on locally to a domain controller by default. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
> [!IMPORTANT]  
>  If you are logging on to a read\-only domain controller \(RODC\) locally or remotely, do not use a domain administrative account. Use only the delegated RODC administrator account. Using a domain administrative account to log on to an RODC can compromise the server. For more information about access to RODCs, see the Step\-by\-Step Guide for Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=92728](http://go.microsoft.com/fwlink/?LinkId=92728)\).  
  
### To restart a domain controller in DSRM remotely by using the Windows GUI  
  
1.  Connect to the remote domain controller that is running in normal mode:  
  
    1.  On the **Start** menu, click **All Programs**, click **Accessories**, and then click **Remote Desktop Connection**.  
  
    2.  In **Computer**, type the name of the domain controller that you want to restart, and then click **Connect**.  
  
    3.  In the **Windows Security** dialog box, provide credentials for a domain administrator, and then click **OK**.  
  
    4.  When you are connected, log on to the domain controller as a domain administrator.  
  
2.  On the **Start** menu, point to **Administrative Tools**, and then click **System Configuration**.  
  
3.  On the **Boot** tab, in **Boot options**, select **Safe boot**, click **Active Directory repair**, and then click **OK**.  
  
4.  In the **System Configuration** dialog box, click **Restart**. The domain controller restarts in DSRM. When the domain controller restarts, your Remote Desktop Connection is dropped.  
  
5.  Wait for a period of time that is adequate for the remote domain controller to restart, and then open Remote Desktop Connection.  
  
6.  The domain controller name should still be showing in **Computer**. If it is not, select it from the list, and then click **Connect**.  
  
7.  In the **Windows Security** dialog box, click **Use another account**.  
  
8.  In **User name**, type the following:  
  
     *MachineName* **\\Administrator**  
  
     Where *MachineName* is the name of the domain controller.  
  
9. In **Password**, type the DSRM password, and then click **OK**.  
  
10. At the logon screen of the remote domain controller, click **Switch User**, and then click **Other User**.  
  
11. Type *MachineName***\\Administrator**, and then press ENTER.  
  
12. Perform procedures in DSRM.  
  
13. When you have finished performing procedures in DSRM, restart the domain controller normally:  
  
    1.  On the **Start** menu, point to **Administrative Tools**, and then click **System Configuration**.  
  
    2.  On the **General** tab, in **Startup selection**, click **Normal startup**, and then click **OK**.  
  
         The domain controller restarts normally. This procedure will disconnect your remote session.  
  
### To restart a domain controller in DSRM remotely by using the command line  
  
1.  Connect to the remote domain controller that is running in normal mode:  
  
    1.  On the Start menu, click **All Programs**, click **Accessories**, and then click **Remote Desktop Connection**.  
  
    2.  In **Computer**, type the name of the domain controller that you want to restart, and then click **Connect**.  
  
    3.  In the **Windows Security** dialog box, provide credentials for a domain administrator, and then click **OK**.  
  
    4.  When you are connected, log on to the domain controller as a domain administrator.  
  
2.  Open a command prompt. At the command prompt, type the following command, and then press ENTER:  
  
     `bcdedit /set safeboot dsrepair`  
  
3.  At the command prompt, type the following command, and then press ENTER:  
  
     `shutdown -t 0 -r`  
  
     The domain controller restarts in DSRM. When the domain controller restarts, your Remote Desktop Connection is dropped.  
  
4.  Wait for a period of time that is adequate for the remote domain controller to restart, and then open Remote Desktop Connection.  
  
5.  The domain controller name should still be showing in **Computer**. If it is not, select it in the list, and then click **Connect**.  
  
6.  In the **Windows Security** dialog box, click **Use another account**.  
  
7.  In **User name**, type the following:  
  
     *MachineName* **\\Administrator**  
  
     Where *MachineName* is the name of the domain controller.  
  
8.  In **Password**, type the DSRM password, and then click **OK**.  
  
9. At the logon screen of the remote domain controller, click **Switch User**, and then click **Other User**.  
  
10. Type *MachineName***\\Administrator**, and then press ENTER.  
  
11. Perform procedures in DSRM.  
  
12. When you have finished performing procedures in DSRM, restart the domain controller normally:  
  
    1.  In DSRM, open a command prompt, type the following command, and then press ENTER:  
  
         `bcdedit /deletevalue safeboot`  
  
    2.  At the command prompt, type the following command, and then press ENTER:  
  
         `shutdown -t 0 –r`  
  
         The domain controller restarts normally. This procedure will disconnect your remote session.  
  
|Value|Description|  
|-----------|-----------------|  
|bcdedit \/set safeboot dsrepair|Configures the boot process to start in DSRM.|  
|shutdown –t 0 \-r|Shuts down the server and restarts it.|  
|bcdedit \/deletevalue safeboot|Returns the boot process to the previous setting.|  
  
## See Also  
 [Enable Remote Desktop](../Topic/Enable-Remote-Desktop.md)   
 [Create a Remote Desktop Connection](../Topic/Create-a-Remote-Desktop-Connection.md)   
 [Restart the Domain Controller in Directory Services Restore Mode Locally](../Topic/Restart-the-Domain-Controller-in-Directory-Services-Restore-Mode-Locally.md)  
  
  