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
  


Following are the installation, software, and other requirements and preparation steps you must take before deploying Network Controller.

## Network Controller requirements

Network Controller deployment requires one or more computers or VMs that serve as the Network Controller, and one computer or VM to serve as a management client for Network Controller. 

- All VMs and computers planned as Network Controller nodes must be running Windows Server 2016 Datacenter edition.
- Any computer or virtual machine (VM) upon which you install Network Controller must be running the Datacenter edition of Windows Server 2016. 
- The management client computer or VM for Network Controller must be running Windows 8, Windows 8.1, or Windows 10. 

  
## Configuration requirements

Before deploying Network Controller, you must configure the security groups, log file locations (if needed), and dynamic DNS registration.
  
### Step 1. Configure your security groups
  
If the computers or VMs for Network Controller and the management client are domain-joined, configure the following security groups for Kerberos authentication.  

- Create a security group and add all of the users who have permission to configure Network Controller. For example, create a group named **Network Controller Admins**. All of the users that you add to this group must also be members of the **Domain Users** group in Active Directory Users and Computers.  
  
    > [!NOTE]  
    > For more information on creating a group in Active Directory Users and Computers, see [Create a new group](https://technet.microsoft.com/en-us/library/cc783256(v=ws.10).aspx).  

- Create a security group and add all of the users who have permission to configure and manage the network by using Network Controller.  For example, create a new group named **Network Controller Users**. All of the users that you add to the new group must also be members of the **Domain Users** group in Active Directory Users and Computers. All Network Controller configuration and management is performed using Representational State Transfer \(REST\).

### Step 2. Configure log file locations if needed

Store Network Controller debug logs on the Network Controller computer or VM, or on a remote file share. 

>[!NOTE]
>If you store the logs in a remote file share, ensure that the share is accessible from the Network Controller.


### Step 3. Configure dynamic DNS registration for Network Controller
  
Deploy Network Controller cluster nodes on the same subnet or different subnets. 

For Network Controllers on the same subnet, you must provide the Network Controller REST IP address. 

For Network Controllers on different subnets, you must provide the Network Controller REST DNS.  You must also: 
- Create a DNS name for Network Controller during the deployment process.
- Configure DNS dynamic updates for the Network Controller DNS name on the DNS server.
- Restrict the DNS dynamic updates to Network Controller nodes only.

> [!NOTE]
> Membership in **Domain Admins**, or equivalent, is the minimum required to perform these procedures.
  
1. Allow DNS dynamic updates for a zone.

   a. Open DNS Manager, and in the console tree, right-click the applicable zone, and then click **Properties**. 
      
   b. On the **General** tab, verify that the zone type is either **Primary** or **Active Directory-integrated**.

   c. In **Dynamic updates**, verify that **Secure only** is selected, and then click **OK**.

2. Configure DNS zone security permissions for Network Controller nodes

   a.  Click the **Security** tab, and then click **Advanced**. 

   b. In **Advanced Security Settings**, click **Add**. 
  
   c. Click **Select a principal**. 

   d. In the **Select User, Computer, Service Account, or Group** dialog box, click **Object Types**. 

   e. In **Object Types**, select **Computers**, and then click **OK**.

   f. In the **Select User, Computer, Service Account, or Group** dialog box, type the NetBIOS name of one of the Network Controller nodes in your deployment, and then click **OK**.

   g. In **Permission Entry**, verify the following values:

      - **Type** = Allow
      - **Applies to** = This object and all descendant objects
  
   h. In Permissions, select **Write all properties** and **Delete**, and then click **OK**.

3. Repeat for all computers and VMs in the Network Controller cluster.


## Next steps
For more information, see [Plan a Software Defined Network Infrastructure](https://technet.microsoft.com/windows-server-docs/networking/sdn/plan/plan-a-software-defined-network-infrastructure).

## Related topics
- [Network Controller](../technologies/network-controller/Network-Controller.md) 
- [Network Controller High Availability](../technologies/network-controller/network-controller-high-availability.md) 
- [Deploy Network Controller using Windows PowerShell](../deploy/Deploy-Network-Controller-using-Windows-PowerShell.md)   
- [Install the Network Controller server role using Server Manager](../technologies/network-controller/Install-the-Network-Controller-server-role-using-Server-Manager.md)   
