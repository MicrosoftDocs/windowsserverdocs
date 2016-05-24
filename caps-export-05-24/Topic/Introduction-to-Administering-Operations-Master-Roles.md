---
title: Introduction to Administering Operations Master Roles
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 12890238-ea7d-4b95-8952-ef2d5027dc09
author: Femila
---
# Introduction to Administering Operations Master Roles
  Domain controllers that hold operations master \(also known as flexible single master operations or FSMO\) roles keep the directory functioning properly by performing specific tasks that no other domain controllers are permitted to perform.  
  
 Three operations master roles exist in each domain:  
  
-   **The primary domain controller \(PDC\) emulator operations master**. The PDC emulator receives preferential replication of password changes that are performed by other domain controllers in the domain, and it is the source for the latest password information whenever a logon attempt fails as a result of a bad password. It is a preferred point of administration for services \(examples are Group Policy and Distributed File System, DFS\). For this reason, of all operations master roles, the PDC emulator operations master role has the highest impact on the performance of the domain controller that hosts that role. The PDC emulator in the forest root domain is also the default Windows Time service \(W32time\) time source for the forest.  
  
     The PDC emulator operations master also processes all replication requests from Windows NT Server 4.0 backup domain controllers \(BDCs\). It processes all password updates for clients not running Active Directory–enabled client software, plus any other directory write operations.  
  
-   **The relative ID \(RID\) operations master**. The RID master allocates RID pools to all domain controllers to ensure that new security principals can be created with a unique identifier.  
  
-   **The infrastructure operations master**. The infrastructure master manages references from objects in its domain to objects in other domains. It also updates group\-to\-user references when the members of groups are renamed or changed.  
  
 In addition to the three domain\-level operations master roles, two operations master roles exist in each forest:  
  
-   **The schema operations master**. The schema master governs all changes to the schema.  
  
-   **The domain naming operations master**. The domain naming master adds and removes domain directory partitions and application directory partitions to and from the forest.  
  
 To perform their respective operations, the domain controllers that host operations master roles must be consistently available and they must be located in areas where network reliability is high. Careful placement of your operations masters becomes more important as you add more domains and sites as you build your forest.  
  
## Guidelines for role placement  
 Improper placement of operations master role holders can prevent clients from changing their passwords or being able to add domains and new objects, such as Users and Groups. Schema changes might not be possible. In addition, name changes might appear improperly within group memberships that are displayed in the user interface \(UI\).  
  
> [!NOTE]  
>  Operations master roles cannot be placed on a read\-only domain controller \(RODC\).  
  
 As your environment changes, you must avoid the problems that are associated with improper operations master role placement. Eventually, you might have to reassign the roles to other domain controllers.  
  
 Although you can assign the forest\-level and domain\-level operations master roles to any domain controller in the forest and domain, respectively, improper infrastructure master role placement can cause the infrastructure master to perform incorrectly. Other improper operations master configurations can increase administrative overhead. Following these guidelines will help to minimize administrative overhead and ensure the proper performance of Active Directory Domain Services \(AD DS\). Following these guidelines will simplify the recovery process if a domain controller that is hosting an operations master role fails.  
  
 Follow these guidelines for operations master role placement:  
  
-   Configure an additional domain controller as the standby operations master for the forest\-level roles. Configure an additional domain controller as the standby operations master for the domain\-level roles.  
  
-   Place the domain\-level roles on a high\-performance domain controller.  
  
-   Do not place domain\-level roles on a global catalog server.  
  
-   Leave the two forest\-level roles on a domain controller in the forest root domain.  
  
-   In the forest root domain, transfer the three domain\-level roles from the first domain controller that you installed in the forest root domain to an additional domain controller that has a high performance level.  
  
-   In all other domains, leave the domain\-level roles on the first domain controller.  
  
-   Adjust the workload of the PDC emulator, if necessary.  
  
 **Prepare additional domain controllers as standby operations masters**  
  
 Because the operations master roles are critical to proper forest and domain function, it is important to be prepared in the event that an operations master role holder becomes inoperable or unreachable. You can prepare an additional domain controller for the forest roles in the forest root domain and an additional domain controller for the domain roles in each domain by configuring them to be optimally connected to the respective current role holder so that role transfer occurs as quickly as possible.  
  
 **Place domain\-level roles on a high\-performance domain controller**  
  
 The PDC emulator role requires a powerful and reliable domain controller to ensure that the domain controller is available and capable of handling the workload. Of all the operations master roles, the PDC emulator role creates the most overhead on the server that is hosting the role. It has the most intensive daily interaction with other systems on the network. The PDC emulator has the greatest potential to affect daily operations of the directory.  
  
 Domain controllers can become overloaded while attempting to service client requests on the network, manage their own resources, and handle any specialized tasks, such as performing the various operations master roles. This is especially true of the domain controller that holds the PDC emulator role. Again, clients running operating systems earlier than Windows 2000 Server and domain controllers running Windows NT Server 4.0 rely more heavily on the PDC emulator than AD DS clients and domain controllers. If your networking environment has clients and domain controllers running operating systems earlier than Windows 2000 Server, you might need to reduce the workload of the PDC emulator.  
  
 If a domain controller begins to indicate that it is overloaded and its performance is affected, you can reconfigure the environment so that some tasks are performed by other, less\-used domain controllers. By adjusting the domain controller’s weight in the Domain Name System \(DNS\) environment, you can configure the domain controller to receive fewer client requests than other domain controllers on your network. As an option, you can adjust the domain controller’s priority in the DNS environment so that it processes client requests only if other DNS servers are unavailable. With fewer DNS client requests to process, the domain controller can use more resources to perform operations master services for the domain.  
  
 **Do not place domain\-level roles on a global catalog server**  
  
 The infrastructure master is incompatible with the global catalog, and it must not be placed on a global catalog server. Because it is best to keep the three domain\-level roles together for ease of administration, avoid putting any of them on a global catalog server.  
  
 The infrastructure master updates objects for any attribute values with distinguished name \(**dn**\) syntax that reference objects outside the current domain. These updates are particularly important for security principal objects \(users, computers, and groups\). For example, suppose a user from one domain is a member of a group in a second domain and the user’s surname \(the **sn** attribute on the user object\) is changed in the first domain. This change usually also changes the **dn** attribute value of the user object, which is the value that is used in the **member** attribute of group objects. Because domain controllers in one domain do not replicate security principals to domain controllers in another domain, the second domain never receives the change. An out\-of\-date value on the **member** attribute of a group in another domain could result in the user whose name has changed being denied privileges. To ensure consistency between domains, the infrastructure master constantly monitors group memberships, looking for **member** attribute values that identify security principals from other domains. If it finds one, it compares its distinguished name with the distinguished name in the domain of the security principal to determine if the information has changed. If the information on the infrastructure master is out of date, the infrastructure master performs an update and then replicates the change to the other domain controllers in its domain.  
  
 Two exceptions apply to this rule:  
  
1.  If all the domain controllers are global catalog servers, the domain controller that hosts the infrastructure master role is insignificant because global catalog servers replicate updated security principal information to all other global catalog servers.  
  
2.  If the forest has only one domain, the infrastructure master role is not needed because security principals from other domains do not exist.  
  
 **Leave forest\-level roles on the original domain controller in the forest root domain**  
  
 The first domain controller that is installed in the forest automatically receives the schema master and domain naming master roles. It also hosts the global catalog. To ease administration and backup and restore procedures, leave these roles on the original forest root domain controller. The roles are compatible with the global catalog, and moving the roles to other domain controllers does not improve performance. Separating the roles creates additional administrative overhead when you must identify the standby operations masters and when you implement a backup and restore policy.  
  
 Unlike the PDC emulator role, forest\-level roles rarely place a significant burden on the domain controller. Keep these roles together to provide easy, predictable management.  
  
 **In the forest root domain, transfer domain\-level roles from the first domain controller**  
  
 The three domain\-level roles are assigned to the first domain controller that is created in a new domain. In the case of the forest root domain, the first domain controller that is created in the domain hosts both forest\-level roles and all three domain\-level roles, as well as the global catalog. The infrastructure master role is incompatible with the global catalog. For this reason, when you install the second domain controller in the forest root domain, the Active Directory Domain Services Installation Wizard prompts you to allow the wizard to transfer the role during installation of AD DS. Following installation of the second domain controller, consider transferring the PDC emulator and RID master roles to the second domain controller, as well, to keep the three roles together for easy administration.  
  
 **In all other domains, leave domain\-level roles on the first domain controller**  
  
 Except for the forest root domain, leave the domain\-level roles on the first domain controller that you install in the domain and do not configure that domain controller as a global catalog server. Keep the roles together unless the workload on your operations master justifies the additional management burden of separating the roles.  
  
 Because all clients running non\-Windows operating systems or Windows operating systems earlier than Windows 2000 Server submit updates to the PDC emulator, the domain controller holding that role uses a higher number of RIDs when the network hosts many of these clients. Place the PDC emulator and RID master roles on the same domain controller so that these two roles interact more efficiently.  
  
 If you must separate the roles, you can still use a single standby operations master for all three roles. However, you must ensure that the standby is a replication partner of all three of the role holders.  
  
 Backup and restore procedures also become more complex if you separate the roles. Special care must be taken to restore a domain controller that hosted an operations master role. By hosting the roles on a single computer, you minimize the steps that are required to restore a role holder.  
  
 **Adjust the workload of the PDC emulator operations master role holder**  
  
 Depending on the size of the forest or domain, you might want to configure DNS so that client requests favor domain controllers other than the PDC emulator. The PDC emulator role has the highest load demands of all the operations master roles.  
  
## Guidelines for role transfer  
 Role transfer is the preferred method to move an operations master role from one domain controller to another. During a role transfer, the two domain controllers replicate to ensure that no information is lost. After the transfer is complete, the previous role holder no longer attempts to perform as the operations master, which eliminates the possibility of duplicate operations masters existing on the network.  
  
 Consider moving the operations master role or roles when any of the following conditions exist:  
  
-   Inadequate service performance  
  
-   Failure of a domain controller that hosts an operations master role  
  
-   Decommissioning of a domain controller that hosts an operations master role  
  
-   Administrative configuration changes that affect operations master role placement  
  
 **Inadequate service performance**  
  
 The PDC emulator is the operations master role that most affects the performance of a domain controller. For clients that do not run Active Directory client software, the PDC emulator processes requests for password changes, replication, and user authentication. While it provides support for these clients, the domain controller continues to perform its normal services, such as authenticating Active Directory–enabled clients. As the network grows, the volume of client requests can increase the workload for the domain controller that hosts the PDC emulator role and its performance can suffer. To solve this problem, you can transfer all or some of the operations master roles to another, more powerful domain controller. As an alternative, you may choose to transfer the role to another domain controller, upgrade the hardware on the original domain controller, and then transfer the role back again.  
  
 **Operations master failure**  
  
 In the event of a failure of an operations role holder, you must decide if you need to relocate the operations master roles to another domain controller or wait for the domain controller to be returned to service. Base that determination on the role that the domain controller hosts and the expected downtime.  
  
 **Decommissioning of the domain controller**  
  
 Before you take a domain controller offline permanently, transfer any operations master roles that the domain controller holds to another domain controller.  
  
 When you use the Active Directory Installation Wizard to decommission a domain controller that currently hosts one or more operations master roles, the wizard reassigns the roles to a different domain controller. When the wizard is run, it determines whether the domain controller currently hosts any operations master roles. If it detects any operations master roles, it queries the directory for other eligible domain controllers and transfers the roles to a new domain controller. A domain controller is eligible to host the domain\-level roles if it is a member of the same domain. A domain controller is eligible to host a forest\-level role if it is a member of the same forest.  
  
 **Configuration changes**  
  
 Configuration changes to domain controllers or the network topology can result in the need to transfer operations master roles. Except for the infrastructure master, you can assign operations master roles to any domain controller regardless of any other tasks that the domain controller performs. Do not host the infrastructure master role on a domain controller that is also acting as a global catalog server unless all the domain controllers in the domain are global catalog servers or unless the forest has only one domain. If the domain controller that hosts the infrastructure master role is configured to be a global catalog server, you must transfer the infrastructure master role to another domain controller. Changes to the network topology can result in the need to transfer operations master roles to keep them in a particular site.  
  
> [!NOTE]  
>  Do not change the global catalog configuration on the domain controller that you intend to assume an operations master role unless your information technology \(IT\) management authorizes that change. Changing the global catalog configuration can cause changes that can take days to complete, and the domain controller might not be available during that period. Instead, transfer the operations master roles to a different domain controller that is already configured properly.  
  
 You can reassign an operations master role by transfer or, as a last resort, by seizure.  
  
> [!IMPORTANT]  
>  If you must seize an operations master role, never reattach the previous role holder to the network without following the procedures in this guide. Reattaching the previous role holder to the network incorrectly can result in invalid data and corruption of data in the directory.  
  
  