---
title: Configuring Operations Master Roles
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 7a585c8a-95af-43aa-bb96-d0e620118a16
author: Femila
---
# Configuring Operations Master Roles
You configure operations master roles \(also known as flexible single master operations or FSMO\) to ensure the availability and performance of your domain controllers. Follow these guidelines when you configure operations master roles:  
  
-   Leave the operations master roles on the first domain controller in the regional domain.  
  
-   Monitor the regional domain controller closely to ensure that it is not a global catalog server.  
  
-   Deploy an additional domain controller to the domain to which you deployed the first domain controller. The additional domain controller acts as the standby operations master.  
  
-   Host the primary domain controller \(PDC\) emulator operations master role on a powerful and reliable domain controller to ensure that it is available and capable of handling the workload.  
  
Of all the operations master roles, the PDC emulator operations master role has the highest impact on the performance of the domain controller that hosts that role. In domains with more than 10,000 users, it might be necessary to reduce the number of authentication requests that are performed by the PDC emulator to decrease its workload and allow it to perform other tasks. If CPU utilization is higher than 50 percent or disk queues remain higher than 2 for several hours or days, reduce the number of client authentication requests that the PDC emulator receives.  
  
> [!NOTE]  
> Other factors that can increase the PDC emulator's workload include running pre\-Active Directory Domain Services \(AD DS\) clients or applications that contact the PDC emulator.  
  
To reduce the number of client authentication requests that the PDC emulator receives, adjust the weight or priority of the PDC emulator in the DNS environment. To proportionately reduce the number of client authentication requests that the PDC emulator receives, you adjust its weight. To ensure that the PDC emulator does not receive any client authentication requests, you adjust its priority.  
  
AD DS assigns a default value of 100 for the weight. If you create a new registry entry for the weight, and then assign it a decreased value of 50, you proportionately reduce the number of client authentication requests that AD DS sends to the PDC emulator. This ensures that the PDC emulator authenticates half of the number of clients that it would if the weight value remained at 100.  
  
AD DS assigns a default value of zero for the priority. If you create a new registry entry for the priority, and then assign it an increased value of 200, you ensure that the PDC emulator receives client authentication requests only if it is the only accessible domain controller.  
  
Repeat these procedures if you transfer or seize the PDC emulator operations master role to another domain controller in the regional domain.  
  
> [!CAUTION]  
> Because Registry Editor bypasses standard safeguards, you can configure settings that can damage your system or require you to reinstall the Windows operating system. If you must edit the registry, back it up first. For more information, see Windows Server 2003 Resource Kit Registry Reference \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=101705](http://go.microsoft.com/fwlink/?LinkId=101705)\).  
  
Membership in **Enterprise Admins** or **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the weight for DNS SRV records by using Registry Editor  
  
1.  In the **Run** dialog box, type **regedit**, and then press **ENTER**.  
  
2.  In Registry Editor, navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**  
  
3.  Click **Edit**, click **New**, and then click **DWORD value**.  
  
4.  For the new entry name, type **LdapSrvWeight**, and then press **ENTER**.  
  
    The value name is not case sensitive.  
  
5.  Double\-click the entry name that you just typed to open the **Edit DWORD Value** dialog box.  
  
6.  In **Base**, select **Decimal**.  
  
7.  Enter a value from 0 through 65535, and then click **OK**.  
  
    The recommended value is 50.  
  
8.  Click **File**, and then click **Exit** to close Registry Editor.  
  
Adjusting the priority of the domain controller also reduces the number of client referrals. However, rather than reducing that number proportionally to the other domain controllers, changing the priority causes DNS to stop referring all clients to this domain controller unless all domain controllers with a lower priority setting are unavailable.  
  
> [!NOTE]  
> A lower value entered for **LdapSrvPriority** indicates a higher priority. A domain controller with an **LdapSrvPriority** setting of 100 has a lower priority than a domain controller with a setting of 10. Therefore, clients attempt to use the domain controller with the setting of 10 first.  
  
Membership in **Enterprise Admins** or **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To change the priority for DNS SRV records by using the registry  
  
1.  In the **Run** dialog box, type **regedit**, and then press **ENTER**.  
  
2.  In Registry Editor, navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Netlogon\\Parameters**  
  
3.  Click **Edit**, click **New**, and then click **DWORD value**.  
  
4.  For the new entry name, type **LdapSrvPriority**, and then press **ENTER**.  
  
5.  Double\-click the entry name that you just typed to open the **Edit DWORD Value** dialog box.  
  
6.  Choose **Decimal** as the **Base** option.  
  
7.  Enter a value from 0 through 65535, and then click **OK**.  
  
    The recommended value is 200.  
  
8.  Click **File**, and then click **Exit** to close Registry Editor.  
  
For a procedure to help you transfer operations master roles, see Transfer Operations Master Roles \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93664](http://go.microsoft.com/fwlink/?LinkId=93664)\).  
  
For more information about Operations Master Role placement, see Planning Operations Master Role Placement \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93665](http://go.microsoft.com/fwlink/?LinkId=93665)\).  
  
