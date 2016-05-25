---
title: Restart Member Computers
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 2dfdb57d-36bb-4a1b-bcbb-370cecdfee7a
author: Femila
---
# Restart Member Computers
  You can use this procedure to restart member computers after a domain rename operation. After the domains are renamed, you have to create a process by which all member computers in the renamed domains in your forest recognize and propagate the domain name changes to all applications and services that are running on member computers. You can do this by notifying all users to restart their computers \(the member computers\) to cause those computers to pick up the domain name changes.  
  
> [!IMPORTANT]  
>  When the member computers are restarted, their Domain Name System \(DNS\) host names will also change after the restart as a result of the fact that their primary DNS suffix changes as a result of the name change of the domain of which they are members. The primary DNS suffix of a member computer in an Active Directory domain is, by default, configured to change automatically when domain membership of the computer changes. If you have very large domains whose DNS name was changed by the domain rename operation and these domains have a large number of member computers, you might observe a large replication storm and a surge in network traffic as a result of the member computer restarts. For information about how to avoid excess replication under these conditions, see [Configure Member Computers for Host Name Changes](../Topic/Configure-Member-Computers-for-Host-Name-Changes.md).  
  
 Perform the following tasks after the domain rename operation:  
  
-   **Restart all member computers twice.**  
  
     Restart twice all member workstations, member servers, and standalone servers \(excluding domain controllers\) that are running Windows 2000, Windows XP, Windows Server 2003, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] in the renamed domains in your forest. When you restart these computers twice, this ensures that each member computer learns of the domain name changes and propagates the changes to all applications and services that are running on the member computer.  
  
    > [!NOTE]  
    >  Each computer must be restarted by logging into the computer and by using the Shutdown\/Restart administrative option. Computers must not be restarted by turning off the computer’s power and then turning it back on.  
  
    > [!NOTE]  
    >  Member computers on a wired local area network \(LAN\) can simply be restarted twice. Member computers on a wireless LAN should be connected to a wired network while you perform the two required restarts. If that is not possible, eject the wireless network card and then reinsert it after logon before each restart.  
  
-   **Unjoin and then join any remote computers that connect to the renamed domain through a remote connection, such as dial\-up and virtual private network \(VPN\).**  
  
     If there are any remote computers that are members of a renamed domain that connect to the domain through remote connection mechanisms such dial\-up lines or VPNs, you will have to unjoin each member computer from the old domain name and then rejoin it to the new domain name.  
  
  