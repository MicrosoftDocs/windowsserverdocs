---
title: DirectAccess Offline Domain Join
description: This guide explains the steps to perform an offline domain join with DirectAccess in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 55528736-6c19-40bd-99e8-5668169ef3c7
ms.author: lizross
author: eross-msft
---
# DirectAccess Offline Domain Join

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This guide explains the steps to perform an offline domain join with DirectAccess. During an offline domain join, a computer is configured to join a domain without physical or VPN connection.  
  
This guide includes the following sections:  
  
- Offline domain join overview  
  
- Requirements for offline domain join
  
- Offline domain join process
  
- Steps for performing an offline domain join  
  
## Offline domain join overview  
Introduced in Windows Server 2008 R2, domain controllers include a feature called Offline Domain Join. A command line utility named Djoin.exe lets you join a computer to a domain without physically contacting a domain controller while completing the domain join operation. The general steps for using Djoin.exe are:  
  
1.  Run **djoin /provision** to create the computer account metadata. The output of this command is a .txt file that includes a base-64 encoded blob.  
  
2.  Run **djoin /requestODJ** to insert the computer account metadata from the .txt file into the Windows directory of the destination computer.  
  
3.  Reboot the destination computer, and the computer will be joined to the domain.  
  
### <a name="BKMK_ODJOverview"></a>Offline domain join with DirectAccess policies scenario overview  
DirectAccess offline domain join is a process that computers running  Windows Server 2016, Windows Server 2012, Windows 10 and Windows 8 can use to join a domain without being physically joined to the corporate network, or connected through VPN. This makes it possible to join computers to a domain from locations where there is no connectivity to a corporate network. Offline domain join for DirectAccess provides DirectAccess policies to clients to allow remote provisioning.  
  
A domain join creates a computer account and establishes a trust relationship between a computer running a Windows operating system and an Active Directory domain.  
  
## <a name="BKMK_ODJRequirements"></a>Prepare for offline domain join  
  
1.  Create the machine account.  
  
2.  Inventory the membership of all security groups to which the machine account belongs.  
  
3.  Gather the required computer certificates, group policies, and group policy objects to be applied to the new client(s).  
  
. The following sections explain operating system requirements and credential requirements for performing a DirectAccess offline domain join using Djoin.exe.  
  
### Operating system requirements  
You can run Djoin.exe for DirectAccess only on computers that run  Windows Server 2016,  Windows Server 2012  or Windows 8. The computer on which you run Djoin.exe to provision computer account data into AD DS must be running  Windows Server 2016, Windows 10,  Windows Server 2012  or Windows 8. The computer that you want to join to the domain must also be running  Windows Server 2016, Windows 10,  Windows Server 2012 , or Windows 8.  
  
### Credential requirements  
To perform an offline domain join, you must have the rights that are necessary to join workstations to the domain. Members of the Domain Admins group have these rights by default. If you are not a member of the Domain Admins group, a member of the Domain Admins group must complete one of the following actions to enable you to join workstations to the domain:  
  
-   Use Group Policy to grant the required user rights. This method allows you to create computers in the default Computers container and in any organizational unit (OU) that is created later (if no Deny access control entries (ACEs) are added).  
  
-   Edit the access control list (ACL) of the default Computers container for the domain to delegate the correct permissions to you.  
  
-   Create an OU and edit the ACL on that OU to grant you the **Create child - Allow** permission. Pass the **/machineOU** parameter to the **djoin /provision** command.  
  
The following procedures show how to grant the user rights with Group Policy and how to delegate the correct permissions.  
  
#### Granting user rights to join workstations to the domain  
You can use the Group Policy Management Console (GPMC) to modify the domain policy or create a new policy that has settings that grant the user rights to add workstations to a domain.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to grant user rights.  Review details about using the appropriate accounts and group memberships at [Local and Domain Default Groups](https://go.microsoft.com/fwlink/?LinkId=83477) (https://go.microsoft.com/fwlink/?LinkId=83477).   
  
###### To grant rights to join workstations to a domain  
  
1.  Click **Start**, click **Administrative Tools**, and then click **Group Policy Management**.  
  
2.  Double-click the name of the forest, double-click **Domains**, double-click the name of the domain in which you want to join a computer, right-click **Default Domain Policy**, and then click **Edit**.  
  
3.  In the console tree, double-click **Computer Configuration**, double-click **Policies**, double-click **Windows Settings**, double-click **Security Settings**, double-click **Local Policies**, and then double-click **User Rights Assignment**.  
  
4.  In the details pane, double-click **Add workstations to domain**.  
  
5.  Select the **Define these policy settings** check box, and then click **Add User or Group**.  
  
6.  Type the name of the account that you want to grant the user rights to, and then click **OK** twice.  
  
## <a name="BKMK_ODKSxS"></a>Offline domain join process  
Run Djoin.exe at an elevated command prompt to provision the computer account metadata. When you run the provisioning command, the computer account metadata is created in a binary file that you specify as part of the command.  
  
For more information about the NetProvisionComputerAccount function that is used to provision the computer account during an offline domain join, see [NetProvisionComputerAccount Function](https://go.microsoft.com/fwlink/?LinkId=162426) (https://go.microsoft.com/fwlink/?LinkId=162426). For more information about the NetRequestOfflineDomainJoin function that runs locally on the destination computer, see [NetRequestOfflineDomainJoin Function](https://go.microsoft.com/fwlink/?LinkId=162427) (https://go.microsoft.com/fwlink/?LinkId=162427).  
  
## <a name="BKMK_ODJSteps"></a>Steps for performing a DirectAccess offline domain join  
The offline domain join process includes the following steps:  
  
1.  Create a new computer account for each of the remote clients and generate a provisioning package using the Djoin.exe command from an already domain joined computer in the corporate network.  
  
2.  Add the client computer to the DirectAccessClients security group  
  
3.  Transfer the provisioning package securely to the remote computers(s) that will be joining the domain.  
  
4.  Apply the provisioning package and join the client to the domain.  
  
5.  Reboot the client to complete the domain join and establish connectivity.  
  
There are two options to consider when creating the provisioning packet for the client. If you used the Getting Started Wizard to install DirectAccess without PKI, then you should use option 1 below. If you used the Advanced Setup Wizard to install DirectAccess with PKI, then you should use option 2 below.  
  
Complete the following steps to perform the offline domain join:  
  
##### Option1: Create a provisioning package for the client without PKI  
  
1.  At a command prompt of your Remote Access server, type the following command to provision the computer account:  
  
    ```  
    Djoin /provision /domain <your domain name> /machine <remote machine name> /policynames DA Client GPO name /rootcacerts /savefile c:\files\provision.txt /reuse  
    ```  
  
##### Option2: Create a provisioning package for the client with PKI  
  
1.  At a command prompt of your Remote Access server, type the following command to provision the computer account:  
  
    ```  
    Djoin /provision /machine <remote machine name> /domain <Your Domain name> /policynames <DA Client GPO name> /certtemplate <Name of client computer cert template> /savefile c:\files\provision.txt /reuse  
    ```  
  
##### Add the client computer to the DirectAccessClients security group  
  
1.  On your Domain Controller, from **Start** screen, type **Active** and select **Active Directory Users and Computers** from **Apps** screen.  
  
2.  Expand the tree under your domain, and select the **Users** container.  
  
3.  In the details pane, right-click **DirectAccessClients**, and click **Properties**.  
  
4.  On the **Members** tab, click **Add**.  
  
5.  Click **Object Types**, select **Computers**, and then click **OK**.  
  
6.  Type the client name to add, and then click **OK**.  
  
7.  Click **OK** to close the **DirectAccessClients** Properties dialog, and then close **Active Directory Users and Computers**.  
  
##### Copy and then apply the provisioning package to the client computer  
  
1.  Copy the provisioning package from c:\files\provision.txt on the Remote Access Server, where it was saved, to c:\provision\provision.txt on the client computer.  
  
2.  On the client computer, open an elevated command prompt, and then type the following command to request the domain join:  
  
    ```  
    Djoin /requestodj /loadfile C:\provision\provision.txt /windowspath %windir% /localos  
    ```  
  
3.  Reboot the client computer. The computer will be joined to the domain. Following the reboot, the client will be joined to the domain and have connectivity to the corporate network with DirectAccess.  
  
## See Also  
[NetProvisionComputerAccount Function](https://go.microsoft.com/fwlink/?LinkId=162426)  
[NetRequestOfflineDomainJoin Function](https://go.microsoft.com/fwlink/?LinkId=162427)  
  


