---
title: Active Directory Domain Services: Last Interactive Logon
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 88a1e4e0-21ca-44d0-8a16-c8c02e3ec335
author: Femila
---
# Active Directory Domain Services: Last Interactive Logon
  Active Directory Domain Services \(AD DS\) in the [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)] operating system introduces a new feature: last interactive logon. Last interactive logon information is available in domains that operate at the Windows Server 2008 domain functional level. It is also available in domain\-joined Windows Server 2008 server computers and [!INCLUDE[firstref_vista](../Token/firstref_vista_md.md)] client computers.  
  
## What does last interactive logon do?  
 Last interactive logon helps you record four key components of user logon information:  
  
-   The total number of failed logon attempts at a domain\-joined Windows Server 2008 server or a Windows Vista workstation  
  
-   The total number of failed logon attempts after a successful logon to a Windows Server 2008 server or a Windows Vista workstation  
  
-   The time of the last failed logon attempt at a Windows Server 2008 or a Windows Vista workstation  
  
-   The time of the last successful logon attempt at a Windows Server 2008 server or a Windows Vista workstation  
  
## Why use last interactive logon?  
 Last interactive logon is useful if you want to see if someone is trying to perform a brute\-force attack on the directory by trying to access an account and guessing the password.  
  
 In addition, you can use last interactive logon for compliance and auditing purposes by determining who is trying to access a user account and when these access attempts occur.  
  
##  <a name="where_is_lst_inter_log_inf_stored"></a> Where last interactive logon information is stored  
 Last interactive logon information is stored in four attributes of the user objects that are added to the schema when a domain operates at a Windows Server 2008 functional level:  
  
-   **msDS\-FailedInteractiveLogonCount**—The number of failed logon attempts at a Windows Server 2008 server or a Windows Vista workstation since the last interactive logon feature was enabled  
  
-   **msDS\-FailedInteractiveLogonCountAtLastSuccessfulLogon**—The total number of failed interactive logons up until the last successful Ctrl\-Alt\-Del logon  
  
-   **msDS\-LastFailedInteractiveLogonTime**—A time stamp of the last failed logon attempt  
  
-   **msDS\-LastSuccessfulInteractiveLogonTime**—A time stamp of the last successful logon attempt at a Windows Server 2008 server or a Windows Vista workstation  
  
## Replication  
 Last interactive login information is updated on the domain controller that authenticates the user’s logon. The information is then replicated to every domain controller in the domain. In addition, as mentioned in the previous section, the information is stored in attributes that are assigned to user objects.  
  
 If a user account is authenticated by a read\-only domain controller \(RODC\), the information is written to the user account that resides on the RODC. The information is also written to the nearest writeable domain controller. At the next scheduled replication, the information is then replicated from the writeable domain controller back to the RODC. This happens because the high\-water mark and update sequence number are not updated on the RODC. Instead, they are updated on the writeable domain controller.  
  
## How last interactive logon information is reported  
 There are two ways to report last interactive logon information:  
  
-   Write the information to the directory in AD DS  
  
     If last interactive logon information is enabled in a Group Policy object \(GPO\) with domain controllers in its scope of management, the last interactive logon information is written to the attributes that are listed in the previous [Where last interactive logon information is stored](#where_is_lst_inter_log_inf_stored) section for all user accounts that are logging on to any domain controller in the domain.  
  
-   Write the information to the AD DS directory, and display last interactive logon information to the user  
  
     If last interactive logon information is enabled in a GPO with domain controllers in its scope of management and in a GPO with server and client computers in its scope of management, last interactive logon information is written to the AD DS directory as previously described as well as displayed to the user after he or she logs on to the workstation.  
  
## Information that appears at the server and workstation  
 When a user logs on to a computer for the first time after the last interactive logon feature is turned on—in a GPO with domain controllers in its scope of management and with Windows Server 2008 servers or Windows Vista client computers in its scope of management—the following message appears after the user logs on:  
  
 “*\<User Account\>*”  
  
 “This is the first time you have interactively logged on to this account.”  
  
 On subsequent logons, the user receives the following message:  
  
 “*\<User Account\>*”  
  
 **Successful Logon**  
  
 “The last time you interactively logged on to this account was: *\<time\>*”  
  
 **Unsuccessful Logon**  
  
 “The last unsuccessful interactive logon attempt on this account was: *\<time\>*”  
  
 “The number of unsuccessful interactive logon attempts since your last interactive logon: *\<number\>*”  
  
## How to configure last interactive logon  
 You configure last interactive logon through a GPO. You must configure the following setting for the GPO with domain controllers in its scope of management if you want to report last interactive logon information to the directory service:  
  
 **Computer Configuration| Policies | Administrative Templates | Windows Components | Windows Logon Options | Display information about previous logons during user logon \= Enabled**  
  
 If you want to display last interactive logon information to the user, you must configure this setting for both the GPO with domain controllers in its scope of management as well as any GPO with Windows Server 2008 and Windows Vista client computers in its scope of management.  
  
## Configuration notes  
 Note the following considerations for configuration of last interactive logon:  
  
-   For last interactive logon to operate correctly, the domain functional level must be set to Windows Server 2008. If this is not the case, users will not be able to log on to their computers and they will receive the following message:  
  
     “Security policies on this computer are set to display information about the last interactive logon. Windows could not retrieve this information. Please contact your network administrator for assistance.”  
  
-   If you enable last interactive logon on domain\-joined computers that run Windows Server 2008 and Windows Vista or later and you do not enable this feature in a GPO with domain controllers in its scope, users will not able to log on to the system.  
  
-   Only computers that run Windows Server 2008 and Windows Vista or later display last interactive logon information to users. All other operating systems ignore this feature.  
  
-   Last interactive logon does not report from which computer the logon attempts occurred because last interactive logon information is stored in the user account properties. To determine from where the logon attempts occurred, you must check the security logs of the domain controllers.  
  
-   The logon attempts for service and scheduled job users are tracked in the same way when this feature is activated. The feature assumes interactive users are only used for interactive logon access.  
  
     **Result:** If an account is used for multiple purposes, the last interactive logon reporting would also report the last service or scheduled job logon.  
  
  