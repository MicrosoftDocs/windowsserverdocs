---
title: Event ID 1925: Attempt to establish a replication link failed due to connectivity problem
H1: na
ms.custom: 
  - x
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: ebf1d707-ec04-43a2-83ed-a61b70d57627
---
# Event ID 1925: Attempt to establish a replication link failed due to connectivity problem
The description text in event ID 1925 reports that the attempt to establish a replication link for the following writable directory partition failed, and the description text provides the distinguished name of the directory partition that the destination is attempting to replicate from the source. The error code in the event gives more specific information about the cause of the problem.  
  
 The following is an example of the event text:  
  
```  
Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Date: 3/12/2008  8:14:13 AM  
Event ID: 1925  
Task Category: Knowledge Consistency Checker   
Level: Warning  
Keywords: Classic  
User: ANONYMOUS LOGON  
Computer: DC3.contoso.com  
Description:  
The attempt to establish a replication link for the following   
writable directory partition failed.   
  
Directory partition:   
CN=Configuration,DC=contoso,DC=com   
Source domain controller:   
CN=NTDS Settings,CN=DC1,CN=Servers,CN=Default-First-Site-Name,CN=Sites,CN=Configuration,DC=contoso,DC=com   
Source domain controller address:   
f8786828-ecf5-4b7d-ad12-8ab60178f7cd._msdcs.contoso.com   
Intersite transport (if any):   
CN=IP,CN=Inter-Site Transports,CN=Sites,CN=Configuration,DC=contoso,DC=com  
This domain controller will be unable to replicate with the source   
domain controller until this problem is corrected.  
  
User Action   
Verify if the source domain controller is accessible or network   
connectivity is available.   
  
Additional Data   
Error value:   
1908 Could not find the domain controller for this domain.  
```  
  
## Diagnosis  
 When Event ID 1925 contains error 1908, "Could not find the domain controller for this domain," Active Directory replication has failed as a result of a connectivity problem between the domain controller that reported the error and the source domain controller that is named in the event text.  
  
## Resolution  
 Use the following tests to solve this problem:  
  
-   [Verify WAN connectivity](#BKMK_verifyWAN)  
  
-   [Determine maximum packet size](#BKMK_MaxPacket), and change it if necessary.  
  
###  <a name="BKMK_verifyWAN"></a> Verify WAN connectivity  
 Verify that there are no basic connectivity problems with the underlying network between the domain controllers, especially if they are separated by a wide area network \(WAN\) link or firewalls. For information about testing this type of problem, see article 310099 \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=69995](http://go.microsoft.com/fwlink/?LinkId=69995)\) and article 159211 \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=69996](http://go.microsoft.com/fwlink/?LinkId=69996)\) in the Microsoft Knowledge Base\).  
  
###  <a name="BKMK_MaxPacket"></a> Determine maximum packet size  
 By default, the Kerberos authentication protocol in Windows 2000, Windows XP, Windows Server 2003, Windows Server 2003 R2, Windows Vista, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] uses the User Datagram Protocol \(UDP\) when the data can be fit into packets of less than 2,000 bytes. Any data larger than this value uses TCP to carry the packets. Packets of more than 1,500 bytes are often dropped by a device, such as a firewall on the network.  
  
 To avoid this problem, you can determine the size of packet that your network can accommodate. Then, you can edit the registry so that the maximum number of bytes for using UDP is set to the lowest value that you receive, less 8 bytes to account for header size.  
  
 You can use the **ping** command to test the size of packets that the network can accommodate.  
  
 Membership in **Domain Users**, or equivalent, and the **Log on locally** right on the domain controller are the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To determine the lowest common packet size  
  
1.  From the destination domain controller, ping the source domain controller by its IP address. At a command prompt, type the following command, and then press ENTER:  
  
     `ping <IP_address> -f -l 1472`  
  
2.  From the source domain controller, use the command in step 1 to ping the destination domain controller by its IP address.  
  
3.  If the `ping` command completes in both directions, no additional modification is required.  
  
4.  If the `ping` command fails in either direction, monotonically lower the number that you use in the `-l` parameter until you find the lowest common packet size that works between the source and destination domain controllers.  
  
> [!NOTE]  
>  Dcdiag.exe provides the following method to perform this test:  
>   
>  `dcdiag /test:CheckSecurityError /s:<SourceDomainControllerName>`  
  
 You can edit the registry to set the maximum size of packets to the value that you determined by the PING method, minus 8 bytes to account for header size. As an alternative, you can edit the registry so that the maximum number of bytes for using UDP is always exceeded and therefore Kerberos always uses TCP.  
  
 You can change the default value of 2,000 bytes by modifying the registry entry **MaxPacketSize** in **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\Kerberos\\Parameters**. Use the following procedure to change this registry setting.  
  
> [!CAUTION]  
>  It is recommended that you do not directly edit the registry unless there is no other alternative. Modifications to the registry are not validated by the registry editor or by Windows before they are applied, and as a result, incorrect values can be stored. This can result in unrecoverable errors in the system. When possible, use Group Policy or other Windows tools, such as Microsoft Management Console \(MMC\), to accomplish tasks rather than editing the registry directly. If you must edit the registry, use extreme caution.  
  
 **Requirements**  
  
-   Credentials: Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure.  
  
-   Tool: Regedit.exe  
  
##### To change the maximum packet size  
  
1.  Click **Start**, click **Run**, type **regedit**, and then click **OK**.  
  
2.  Navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Lsa\\Kerberos\\Parameters**.  
  
3.  Edit—or, if it does not exist in the details pane, create—the entry **MaxPacketSize** as follows:  
  
    1.  To edit the entry if it exists in the details pane:  
  
         Right\-click **MaxPacketSize**, click **Modify**, and then, in the **Value data** box, type **1** to force Kerberos to use TCP, or type the value that you established to lower the value to the appropriate maximum size.  
  
    2.  To create the entry if it does not exist in the details pane:  
  
         Right\-click **Parameters**, click **New DWORD Value**, type the name **MaxPacketSize**, and then go to step 3a to edit the entry.  
  
4.  Click **OK**.  
  
5.  You must restart the domain controller for this change to take effect.  
  
## See Also  
 [Monitoring and Troubleshooting Active Directory Replication Using Repadmin](http://go.microsoft.com/fwlink/?LinkId=122830)