---
title: Configure the Operations Master Roles
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: da20796d-e059-48b2-a385-0ef1681623bc
author: Femila
---
# Configure the Operations Master Roles
You must configure the forest\-level and domain\-level operations master \(also known as flexible single master operations or FSMO\) roles for the forest root domain. By default, Active Directory Domain Services \(AD DS\) assigns all operations master roles to the first domain controller in the forest root domain:  
  
-   If your design specifies that all domain controllers in the forest root domain are global catalog servers, leave all five operations master roles on the first domain controller and designate the second domain controller to be the standby operations master.  
  
-   If your design specifies a child domain, transfer the infrastructure master role to a domain controller that is not a global catalog.  
  
    > [!NOTE]  
    > In a single\-domain forest, the database content of a domain controller and a global catalog server are the same. Therefore, to load\-balance client lookups across global catalog servers in a single domain forest, ensure that all domain controllers are global catalog servers.  
  
If your Active Directory Domain Services \(AD DS\) design specifies that you designate a standby operations master for the current operations master role holder, configure the current role holder and the standby as direct replication partners by manually creating a connection object between them. Designating a standby operations master can save some time if you must reassign operations master roles to the standby operations master.  
  
Of all the operations master roles, the primary domain controller \(PDC\) emulator operations master role has the highest impact on the performance of the domain controller that hosts that role. In domains with more than 10,000 users, it might be necessary to reduce the number of authentication requests that are performed by the PDC emulator to decrease its workload and allow it to perform other tasks. If CPU utilization is higher than 50 percent or disk queues remain higher than 2 for several hours or days, reduce the number of client authentication requests that the PDC emulator receives.  
  
> [!NOTE]  
> Other factors that can increase the workload on the PDC emulator include pre\-AD DS clients or applications that have been written to contact the PDC emulator.  
  
To reduce the number of client authentication requests that the PDC emulator processes, adjust its weight or its priority in the Domain Name System \(DNS\) environment. If you want to proportionately reduce the number of client authentication requests that the PDC emulator receives, adjust its weight. If you want to ensure that the PDC emulator does not receive any client authentication requests, adjust its priority.  
  
AD DS assigns a default value of 100 for the weight. By creating a new registry entry for the weight and assigning it a decreased value of 50, you can proportionately reduce the number of client authentication requests that AD DS sends to the PDC emulator. This ensures that the PDC emulator authenticates half the number of clients that it would if the weight value remained at 100.  
  
AD DS assigns a default value of zero for the priority. By creating a new registry entry for the priority, and then assigning it an increased value of 200, you can ensure that the PDC emulator never receives client authentication requests unless it is the only accessible domain controller.  
  
Repeat these procedures if you transfer or seize the PDC emulator operations master role is to another domain controller in the forest root domain.  
  
> [!CAUTION]  
> Because Registry Editor bypasses standard safeguards, you can configure settings that can damage your system or require you to reinstall the Windows operating system. If you must edit the registry, back it up first. For more information, see the Windows Server 2003 Resource Kit Registry Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=101705](http://go.microsoft.com/fwlink/?LinkId=101705)\).  
  
Membership in the Enterprise Admins group or the Domain Admins group is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the weight for DNS SRV records by using Registry Editor  
  
1.  In the **Run** dialog box, type **regedit**, and then press **ENTER**.  
  
2.  In Registry Editor, navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**.  
  
3.  Click **Edit**, click **New**, and then click **DWORD value**.  
  
4.  For the new entry name, type **LdapSrvWeight**, and press **ENTER**.  
  
    The value name is not case sensitive.  
  
5.  Double\-click the entry name that you just typed to open the **Edit DWORD Value** dialog box.  
  
6.  Choose **Decimal** as the **Base** option.  
  
7.  Enter a value from 0 through 65535, and then click **OK**.  
  
    The recommended value is 50.  
  
8.  Click **File**, and then click **Exit** to close Registry Editor.  
  
Adjusting the priority of the domain controller reduces the number of client referrals. However, rather than reducing that number proportionally to the other domain controllers, changing the priority causes DNS to stop referring all clients to this domain controller unless all domain controllers with a lower priority setting are unavailable.  
  
> [!NOTE]  
> A lower value for **LdapSrvPriority** indicates a higher priority. A domain controller with an **LdapSrvPriority** setting of 100 has a lower priority than a domain controller with a setting of 10. Therefore, clients attempt to use the domain controller with the setting of 10 first.  
  
Membership in Enterprise Admins group or the Domain Admins group is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the priority for DNS SRV records by using the registry  
  
1.  In the **Run** dialog box, type **regedit**, and then press **ENTER**.  
  
2.  In Registry Editor, navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**  
  
3.  Click **Edit**, click **New**, and then click **DWORD value**.  
  
4.  For the new entry name, type **LdapSrvPriority**, and then press **ENTER**.  
  
5.  Double\-click the entry name that you just typed to open the **Edit DWORD Value** dialog box.  
  
6.  Choose **Decimal** as the **Base** option.  
  
7.  Enter a value from 0 through 65535, and then click **OK**.  
  
    The recommended value is 200.  
  
8.  Click **File**, and then click **Exit** to close Registry Editor.  
  
For information about how to transfer operations master roles, see Transfer Operations Master Roles \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93664](http://go.microsoft.com/fwlink/?LinkId=93664)\).  
  
For more information about operations master role placement, see Planning Operations Master Role Placement \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93665](http://go.microsoft.com/fwlink/?LinkId=93665)\).  
  
