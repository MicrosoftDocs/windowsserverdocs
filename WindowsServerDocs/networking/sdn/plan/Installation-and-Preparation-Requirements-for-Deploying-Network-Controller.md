---
title: Installation and Preparation Requirements for Deploying Network Controller
description: You can use this topic to prepare your datacenter for Network Controller deployment.
manager: brianlic
ms.prod: windows-server-threshold
ms.technology: networking-sdn
ms.topic: get-started-article
ms.assetid: 7f899e62-6e5b-4fca-9a59-130d4766ee2f
ms.author: pashort
author: shortpatti
---
# Installation and Preparation Requirements for Deploying Network Controller

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to prepare your datacenter for Network Controller deployment.  
  
> [!NOTE]  
> In addition to this topic, the following Network Controller documentation is available.  
> 
> - [Network Controller](../technologies/network-controller/Network-Controller.md)
> - [Network Controller High Availability](../technologies/network-controller/network-controller-high-availability.md)
> - [Deploy Network Controller using Windows PowerShell](../deploy/Deploy-Network-Controller-using-Windows-PowerShell.md)  
> - [Install the Network Controller server role using Server Manager](../technologies/network-controller/Install-the-Network-Controller-server-role-using-Server-Manager.md)  

Following are the installation, software, and other requirements and preparation steps you must take before deploying Network Controller.

## Installation requirements

Following are the installation requirements for Network Controller.

- For  Windows Server 2016 deployments, you can deploy Network Controller on one or more computers, one or more  VMs, or a combination of computers and VMs. All VMs and computers planned as Network Controller nodes must be running Windows Server 2016 Datacenter edition.

## Software requirements

Network Controller deployment requires one or more computers or VMs that will serve as the Network Controller, and one computer or VM to serve as a management client for Network Controller. These computers or VMs must run the following operating systems.  

- Any computer or virtual machine (VM) upon which you install Network Controller must be running the Datacenter edition of  Windows Server 2016.  
  
- The management client computer or VM for Network Controller must be running Windows 8, Windows 8.1, or Windows 10.  
  
## Additional requirements

Following are additional steps you must take before deploying Network Controller.
  
### Configure security groups
  
If the computers or VMs for Network Controller and the management client are domain-joined, configure the following security groups for Kerberos authentication.

- Create a security group and add all of the users who have permission to configure Network Controller. For example, create a group named **Network Controller Admins**. All of the users that you add to this group must also be members of the **Domain Users** group in Active Directory Users and Computers.  
  
    > [!NOTE]  
    > For more information on creating a group in Active Directory Users and Computers, see [Create a new group](https://technet.microsoft.com/en-us/library/cc783256(v=ws.10).aspx).  

- Create a security group and add all of the users who have permission to configure and manage the network by using Network Controller.  For example, create a new group named **Network Controller Users**. All of the users that you add to the new group must also be members of the **Domain Users** group in Active Directory Users and Computers. All Network Controller configuration and management is performed using Representational State Transfer \(REST\).

### Configure log file locations if needed

You can store Network Controller debug logs on the Network Controller computer or VM, or on a remote file share. If you want to store the logs in a remote file share, ensure that the share is accessible from the Network Controller.

### Configure dynamic DNS registration for Network Controller
  
You can deploy Network Controller cluster nodes on the same subnet or on different subnets. 

>[!NOTE]
>If the Network Controller nodes are on the same subnet, you must provide the Network Controller REST IP address when you configure dynamic DNS registration for Network Controller. If the nodes are on different subnets, you must provide the Network Controller REST DNS name when you configure dynamic DNS registration.

If Network Controller nodes are on different subnets, you must perform the following additional DNS configuration:

- Create a DNS name for Network Controller during the deployment process

- Configure DNS dynamic updates for the Network Controller DNS name on the DNS server

- Restrict the DNS dynamic updates to Network Controller nodes only

You can use the following procedures to configure DNS dynamic updates and to restrict dynamic updating of the Network Controller name record.

> [!NOTE]
> Membership in **Domain Admins**, or equivalent, is the minimum required to perform these procedures.
  
#### To allow DNS dynamic updates for a zone

1. Open DNS Manager.

2. In the console tree, right-click the applicable zone, and then click **Properties**. The zone's **Properties** dialog box opens.

3. On the **General** tab, verify that the zone type is either **Primary** or **Active Directory-integrated**.

4. In **Dynamic updates**, verify that **Secure only** is selected. If it is not selected, change the value of **Dynamic updates** to **Secure only**, and then click **OK**.

#### To configure DNS zone security permissions for Network Controller nodes

1.  Open DNS Manager.

2.  In the console tree, right-click the applicable zone, and then click **Properties**. The zone's **Properties** dialog box opens.

3.  Click the **Security** tab, and then click **Advanced**. The **Advanced Security Settings** dialog box opens.

4. In **Advanced Security Settings**, click **Add**. The **Permission Entry** dialog box opens.
  
5. Click **Select a principal**. The **Select User, Computer, Service Account, or Group** dialog box opens.

6. In the **Select User, Computer, Service Account, or Group** dialog box, click **Object Types**. The **Object Types** dialog box opens. 

7. In **Object Types**, select **Computers**, and then click **OK**.

8. In the **Select User, Computer, Service Account, or Group** dialog box, type the NetBIOS name of one of the Network Controller nodes in your deployment, and then click **OK**.

9. In **Permission Entry**, ensure that the value of **Type** is **Allow**, and the value of **Applies to** is **This object and all descendant objects**.
  
10. In Permissions, select **Write all properties** and **Delete**, and then click **OK**.

11. Repeat steps **5** through **10** for all computers and VMs in the Network Controller cluster.

For more information, see [Plan a Software Defined Network Infrastructure](https://technet.microsoft.com/windows-server-docs/networking/sdn/plan/plan-a-software-defined-network-infrastructure).
