---
title: Installation and Preparation Requirements for Deploying Network Controller
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 7f899e62-6e5b-4fca-9a59-130d4766ee2f
author: vhorne
---
# Installation and Preparation Requirements for Deploying Network Controller
You can use this topic to prepare your datacenter for Network Controller deployment.  
  
> [!NOTE]  
> In addition to this topic, the following Network Controller documentation is available.  
>   
> -   [Network Controller](../../sdn/technologies/network-controller/Network-Controller.md)  
> -   [Deploy Network Controller using Windows PowerShell](../../sdn/deploy/Deploy-Network-Controller-using-Windows-PowerShell.md)  
> -   [Install the Network Controller server role using Server Manager](../../sdn/technologies/network-controller/Install-the-Network-Controller-server-role-using-Server-Manager.md)  
  
## <a name="bkmk_prep"></a>Installation and preparation requirements for deploying Network Controller  
Following are the installation, software, and other requirements and preparation steps you must take before deploying Network Controller.  
  
### Installation requirements  
Following are the installation requirements for Network Controller.  
  
-   For Windows Server 2016 Technical Preview deployments, you can deploy Network Controller on one or more computers, one or more  VMs, or a combination of computers and VMs.  
  
### Software requirements  
Network Controller deployment requires one or more computers or VMs that will serve as the Network Controller, and one computer or VM to serve as a management client for Network Controller. These computers or VMs must run the following operating systems.  
  
-   Any computer or virtual machine \(VM\) upon which you install Network Controller must be running the Datacenter edition of Windows Server 2016 Technical Preview.  
  
-   The management client computer or VM for Network Controller must be running Windows® 8, Windows® 8.1, or Windows 10®.  
  
### Additional requirements  
Following are additional steps you must take before deploying Network Controller.  
  
**Configure security groups**  
  
If the computers or VMs for Network Controller and the management client are domain\-joined, configure the following security groups for Kerberos authentication.  
  
-   Create a security group and add all of the users who have permission to configure Network Controller. For example, create a group named **Network Controller Admins**. All of the users that you add to this group must also be members of the **Domain Users** group in Active Directory Users and Computers.  
  
    > [!NOTE]  
    > For more information on creating a group in Active Directory Users and Computers, see [Create a new group](https://technet.microsoft.com/en-us/library/cc783256(v=ws.10).aspx).  
  
-   Create a security group and add all of the users who have permission to configure and manage the network by using Network Controller.  For example, create a new group named **Network Controller Users**. All of the users that you add to the new group must also be members of the **Domain Users** group in Active Directory Users and Computers. All Network Controller configuration and management is performed using Representational State Transfer \(REST\).  
  
**Configure certificates for non\-Kerberos deployments**  
  
If the computers or VMs for Network Controller and the management client are not domain\-joined, you must configure certificate\-based authentication by completing the following steps.  
  
-   Create a certificate on the Network Controller for Computer authentication. The certificate subject name must be same as the DNS name of the Network Controller computer or VM.  
  
-   Create a certificate on the management client. This certificate must be trusted by the Network Controller.  
  
-   Enroll a certificate on the Network Controller computer or VM. The certificate must meet the following requirements.  
  
    -   The Server Authentication purpose is present in Enhanced Key Usage \(EKU\) extensions.  
  
    -   The certificate subject name should resolve to:  
  
        -   The IP address of the Network Controller computer or VM, if Network Controller is deployed on a single computer or VM.  
  
        -   The REST IP address, if Network Controller is deployed on multiple computers, multiple VMs, or both.  
  
    -   This certificate must be trusted by all the REST clients. The certificate must also be trusted by the Software Load Balancing \(SLB\) Multiplexer \(MUX\) and the southbound host computers that are managed by Network Controller.  
  
    -   The certificate can be enrolled by a Certification Authority \(CA\) or can be a self\-signed certificate. Self\-signed certificates are not recommended for production deployments, but are acceptable for test lab environments.  
  
    -   The same certificate must be provisioned on all the Network Controller nodes. After creating the certificate on one node, you can export the certificate \(with private key\) and import it on the other nodes.  
  
**Configure log file locations if needed**  
  
You can store Network Controller debug logs on the Network Controller computer or VM, or on a remote file share. If you want to store the logs in a remote file share, ensure that the share is accessible from the Network Controller.  
  
**Configure dynamic DNS registration for Network Controller**  
  
You can deploy Network Controller cluster nodes on the same subnet or on different subnets. If Network Controller nodes are on different subnets, you must perform the following additional DNS configuration:  
  
-   Create a DNS name for Network Controller during the deployment process  
  
-   Configure DNS dynamic updates for the Network Controller DNS name  on the DNS server  
  
-   Restrict the DNS dynamic updates to Network Controller nodes only  
  
You can use the following procedures to configure DNS dynamic updates and to restrict dynamic updating of the Network Controller name record.  
  
> [!NOTE]  
> Membership in **Domain Admins**, or equivalent, is the minimum required to perform these procedures.  
  
##### Allow DNS dynamic updates for a zone  
  
1.  Open DNS Manager.  
  
2.  In the console tree, right\-click the applicable zone, and then click **Properties**. The zone's **Properties** dialog box opens.  
  
3.  On the **General** tab, verify that the zone type is either **Primary** or **Active Directory\-integrated**.  
  
4.  In **Dynamic updates**, verify that **Secure only** is selected. If it is not selected, change the value of **Dynamic updates** to **Secure only**, and then click **OK**.  
  
##### Configure DNS zone security permissions for Network Controller nodes  
  
1.  Open DNS Manager.  
  
2.  In the console tree, right\-click the applicable zone, and then click **Properties**. The zone's **Properties** dialog box opens.  
  
3.  Click the **Security** tab, and then click **Advanced**. The **Advanced Security Settings** dialog box opens.  
  
4.  In **Advanced Security Settings**, click **Add**. The **Permission Entry** dialog box opens.  
  
5.  Click **Select a principal**. The **Select User, Computer, Service Account, or Group** dialog box opens.  
  
6.  In the **Select User, Computer, Service Account, or Group** dialog box, click **Object Types**. The **Object Types** dialog box opens.  
  
7.  In **Object Types**, select **Computers**, and then click **OK**.  
  
8.  In the **Select User, Computer, Service Account, or Group** dialog box, type the NetBIOS name of one of the Network Controller nodes in your deployment, and then click **OK**.  
  
9. In **Permission Entry**, ensure that the value of **Type** is **Allow**, and the value of **Applies to** is **This object and all descendant objects**.  
  
10. In Permissions, select **Write all properties** and **Delete**, and then click **OK**.  
  
11. Repeat steps **5** through **10** for all computers and VMs in the Network Controller cluster.  
  

