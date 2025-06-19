---
title: Deploy Network Controller using PowerShell on Windows Server
description: Deploy Network Controller using Windows PowerShell to automate SDN management on Windows Server. Follow step-by-step instructions and streamline your setup.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 06/17/2025
#customer intent: As a network admin, I want to deploy Network Controller using Windows PowerShell so that I can automate SDN management on Windows Server.
---

# Deploy Network Controller using Windows PowerShell

Network Controller is a key component in Software Defined Networking (SDN) for Windows Server. This article describes how to deploy Network Controller using Windows PowerShell on one or more virtual machines (VMs) running Windows Server. Learn how to prepare your environment, configure the Network Controller cluster and application, validate your deployment, and manage your Network Controller installation using PowerShell commands.

## Prerequisites

Before you deploy Network Controller, ensure that you have the following prerequisites:

- One or more computers or VMs that are running Windows Server 2016 or later.

  - For a single-node deployment, you can use a single computer or VM.
  - For a clustered deployment, you need at least three computers or VMs. The recommended number of nodes in a Network Controller cluster is three or more. You can add more nodes to the cluster later if needed.

- A domain user account that has membership in the **Administrators** group or equivalent on the computer or VM where you're installing Network Controller. If the computer or VM upon which you installed Network Controller is joined to a domain, your user account must be a member of **Domain Users**.

- The Network Controller server role and is installed on each VM that you want to add to the Network Controller cluster. You can install the Network Controller server role by using Windows PowerShell or Server Manager. To learn more about how to install roles and features, see [Add or remove roles and features in Windows Server](../../../administration/server-manager/add-remove-roles-features.md).

  >[!IMPORTANT]
  >Don't deploy the Network Controller server role on physical hosts. To deploy Network Controller, you must install the Network Controller server role on a Hyper-V VM that is installed on a Hyper-V host. After you have installed Network Controller on VMs on three different Hyper-V hosts, you must enable the Hyper-V hosts for Software Defined Networking (SDN) by adding the hosts to Network Controller using the Windows PowerShell command **New-NetworkControllerServer**. By doing so, you're enabling the SDN Software Load Balancer to function. For more information, see [New-NetworkControllerServer](/powershell/module/networkcontroller/new-networkcontrollerserver).

- (Recommended) A certificate that is used for authentication and encryption of traffic between Network Controller services. The certificate must be provisioned on all of the Network Controller nodes before you run the commands to create the cluster and install the Network Controller application. The certificate must have the following properties:

  - A trusted certification authority (CA) must issue the certificate.

  - The certificate must have the Server Authentication (OID.1.3.6.1.5.5.7.3.1) purpose in Enhanced Key Usage extensions.

  - The certificate subject name must match the DNS name of the node.

  - The certificate must be exported using the Personal Information Exchange (PFX) PKCS #12 format, and must include the private key. Include all certificates in the certificate chain when you export the certificate if possible.

## Create a Network Controller cluster

The Network Controller cluster provides high availability and scalability for the Network Controller application. After you create the cluster, you can configure the Network Controller application, which runs on top of the cluster. You can perform the procedures in the following sections in two ways:

- Directly on the VM where you installed Network Controller.
- From a remote computer using the Remote Server Administration Tools for Windows Server.

To create a Network Controller cluster, you need to create a node object for each VM that is a member of the Network Controller cluster, using the [New-NetworkControllerNodeObject](/powershell/module/networkcontroller/new-networkcontrollernodeobject) command. After you create the node objects, you can configure the cluster using the [Install-NetworkControllerCluster](/powershell/module/networkcontroller/install-networkcontrollercluster) command. Finally, you can install the Network Controller application using the [Install-NetworkController](/powershell/module/networkcontroller/install-networkcontroller) command.

To deploy Network Controller using Windows PowerShell, follow these steps:

1. Open Windows PowerShell as an administrator on the VM where you installed Network Controller or on a remote computer that has the Remote Server Administration Tools installed.

1. To define the Network Controller nodes, create a node object for each VM that is a member of the Network Controller cluster using the [New-NetworkControllerNodeObject](/powershell/module/networkcontroller/new-networkcontrollernodeobject) command. For example, to create a node object for each VM, you can use the following commands:

  ```powershell
  $node1 = New-NetworkControllerNodeObject -Name "Node1" -Server "NCNode1.contoso.com" -FaultDomain "fd:/rack1/host1" -RestInterface "Internal"
  $node2 = New-NetworkControllerNodeObject -Name "Node2" -Server "NCNode2.contoso.com" -FaultDomain "fd:/rack1/host2" -RestInterface "Internal"
  $node3 = New-NetworkControllerNodeObject -Name "Node3" -Server "NCNode3.contoso.com" -FaultDomain "fd:/rack1/host3" -RestInterface "Internal"
  ```

  The example creates three node objects, specifying the name, fully qualified domain name (FQDN) for when using Kerberos authentication, fault domain, and REST interface. The fault domain is specified in a hierarchical format, which helps Network Controller to spread out services across different fault domains for high availability.

  <details>
  <summary>Expand for more information about the parameters</summary>
  The following table provides descriptions for each parameter of the **New-NetworkControllerNodeObject** command. To learn more about the **New-NetworkControllerNodeObject** command, see [New-NetworkControllerNodeObject](/powershell/module/networkcontroller/new-networkcontrollernodeobject).
  
  |Parameter|Description|
  |-------------|---------------|
  |Name|The **Name** parameter specifies the friendly name of the server that you want to add to the cluster|
  |Server|The **Server** parameter specifies the host name, Fully Qualified Domain Name (FQDN), or IP address of the server that you want to add to the cluster. For domain-joined computers, FQDN is required.|
  |FaultDomain|The **FaultDomain** parameter specifies the failure domain for the server that you're adding to the cluster. This parameter defines the servers that might experience failure at the same time as the server that you're adding to the cluster. This failure might be due to shared physical dependencies such as power and networking sources. Fault domains typically represent hierarchies that are related to these shared dependencies, with more servers likely to fail together from a higher point in the fault domain tree. During runtime, Network Controller considers the fault domains in the cluster and attempts to spread out the Network Controller services so that they are in separate fault domains. This process helps ensure, if there's failure of any one fault domain, that the availability of that service and its state isn't compromised. Fault domains are specified in a hierarchical format. For example: `Fd:/DC1/Rack1/Host1`, where DC1 is the datacenter name, Rack1 is the rack name and Host1 is the name of the host where the node is placed.|
  |RestInterface|The **RestInterface** parameter specifies the name of the interface on the node where the  Representational State Transfer (REST) communication is terminated. This Network Controller interface receives Northbound API requests from the network's management layer.|
  |NodeCertificate|The **NodeCertificate** parameter specifies the certificate that Network Controller uses for computer authentication. The certificate is required if you use certificate-based authentication for communication within the cluster; the certificate is also used for encryption of traffic between Network Controller services. The certificate subject name must be same as the DNS name of the node.|
  </details>

1. Capture the certificate that you want to use for authentication and encryption of traffic between Network Controller services. You can use the following command to retrieve the certificate from the local computer certificate store:

  ```powershell
  $cert = Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.Subject -imatch <FQQN> }
  ```

  Ensure that you replace `<FQDN>` with the actual subject name of your certificate.

1. To create the Network Controller cluster, use the [Install-NetworkControllerCluster](/powershell/module/networkcontroller/install-networkcontrollercluster) command. For example, to configure the cluster with the node objects you created, you can use the following command:

  ```powershell
  Install-NetworkControllerCluster -Node @($node1, $node2) -ClusterAuthentication Kerberos -ManagementSecurityGroup "Contoso\NCManagementAdmins" -DiagnosticLogLocation "\\share\Diagnostics" -CredentialEncryptionCertificate $cert
  ```

  The example installs the Network Controller cluster with Kerberos authentication, specifies a management security group for administrative access, and sets a diagnostic log location.

  <details>
  <summary>Expand for more information about the parameters</summary>
  The following table provides descriptions for each parameter of the **Install-NetworkControllerCluster** command. To learn more about the **Install-NetworkControllerCluster** command, see [Install-NetworkControllerCluster](/powershell/module/networkcontroller/install-networkcontrollercluster).
  
  |Parameter|Description|
  |-------------|---------------|
  |Node|The **Node** parameter specifies the list of Network Controller nodes that you created by using the **New-NetworkControllerNodeObject** command.|
  |ClusterAuthentication|The **ClusterAuthentication** parameter specifies the authentication type that is used for securing the communication between nodes and is also used for encryption of traffic between Network Controller services. The supported values are **Kerberos**, **X509**, and **None**. Kerberos authentication uses domain accounts and can only be used if the Network Controller nodes are domain joined. If you specify X509-based authentication, you must provide a certificate in the NetworkControllerNode object. In addition, you must manually create the certificate before you run this command.|
  |ManagementSecurityGroup|The **ManagementSecurityGroup** parameter specifies the name of the security group that contains users that are allowed to run the management cmdlets from a remote computer. This is only applicable if ClusterAuthentication is Kerberos. You must specify a domain security group and not a security group on the local computer.|
  |DiagnosticLogLocation|The **DiagnosticLogLocation** parameter specifies the share location where the diagnostic logs are periodically uploaded. If you don't specify a value for this parameter, the logs are stored locally on each node. Logs are stored locally in the folder %systemdrive%\Windows\tracing\SDNDiagnostics. Cluster logs are stored locally in the folder %system

1. To install the Network Controller application, use the [Install-NetworkController](/powershell/module/networkcontroller/install-networkcontroller) command. For example, to install the Network Controller application with the node objects you created, you can use the following command:

  ```powershell
  Install-NetworkController -Node @($node1, $node2) -ClientAuthentication Kerberos -ClientSecurityGroup "Contoso\NCRESTClients" -ServerCertificate $cert -RESTIPAddress "10.0.0.1/24"
  ```

  The example installs the Network Controller application with Kerberos authentication, specifies a client security group for REST API access, and sets the REST IP address.

  <details>
  <summary>Expand for more information about the parameters</summary>
  The following table provides descriptions for each parameter of the **Install-NetworkController** command. To learn more about the **Install-NetworkController** command, see [Install-NetworkController](/powershell/module/networkcontroller/install-networkcontroller).

  |Parameter|Description|
  |-------------|---------------|
  |ClientAuthentication|The **ClientAuthentication** parameter specifies the authentication type that is used for securing the communication between REST and Network Controller. The supported values are **Kerberos**, **X509**, and **None**. Kerberos authentication uses domain accounts and can only be used if the Network Controller nodes are domain joined. If you specify X509-based authentication, you must provide a certificate in the NetworkControllerNode object. In addition, you must manually create the certificate before you run this command.|
  |Node|The **Node** parameter specifies the list of Network Controller nodes that you  created by using the **New-NetworkControllerNodeObject** command.|
  |ClientCertificateThumbprint|This parameter is required only when you're using certificate-based authentication for Network Controller clients. The **ClientCertificateThumbprint** parameter specifies the thumbprint of the certificate that is enrolled to clients on the Northbound layer.|
  |ServerCertificate|The **ServerCertificate** parameter specifies the certificate that Network Controller uses to prove its identity to clients. The server certificate must include the Server Authentication purpose in Enhanced Key Usage extensions, and must be issued to Network Controller by a CA that is trusted by clients.|
  |RESTIPAddress|You don't need to specify a value for **RESTIPAddress** with a single node deployment of Network Controller. For multiple-node deployments, the **RESTIPAddress** parameter specifies the IP address of the REST endpoint in CIDR notation. For example, 192.168.1.10/24. The Subject Name value of **ServerCertificate** must resolve to the value of the **RESTIPAddress** parameter. This parameter must be specified for all multiple-node Network Controller deployments when all of the nodes are on the same subnet. If nodes are on different subnets, you must use the **RestName** parameter instead of using **RESTIPAddress**.|
  |RestName|You don't need to specify a value for **RestName** with a single node deployment of Network Controller. The only time you must specify a value for **RestName** is when multiple-node deployments have nodes that are on different subnets. For multiple-node deployments, the **RestName** parameter specifies the FQDN for the Network Controller cluster.|
  |ClientSecurityGroup|The **ClientSecurityGroup** parameter specifies the name of the Active Directory security group whose members are Network Controller clients. This parameter is required only if you use Kerberos authentication for **ClientAuthentication**. The security group must contain the accounts from which the REST APIs are accessed, and you must  create the security group and add members before running this command.|
  |Credential|This parameter is required only if you're running this command from a remote computer. The **Credential** parameter specifies a user account that has permission to run this command on the target computer.|
  |CertificateThumbprint|This parameter is required only if you're running this command from a remote computer. The **CertificateThumbprint** parameter specifies the digital public key certificate (X509) of a user account that has permission to run this command on the target computer.|
  |UseSSL|This parameter is required only if you're running this command from a remote computer. The **UseSSL** parameter specifies the Secure Sockets Layer (SSL) protocol that is used to establish a connection to the remote computer. By default, SSL isn't used.|
  </details>

## Add a node to the Network Controller cluster

If you need to add a new node to the Network Controller cluster after the initial deployment, you can do so by creating a new node object and then using the [Add-NetworkControllerNode](/powershell/module/networkcontroller/add-networkcontrollernode) command.

To add a node to the Network Controller cluster, follow these steps:

1. Complete the [prerequisites](#prerequisites) for the new node.

1. Open Windows PowerShell as an administrator on an existing Network Controller node or on a remote computer that has the Remote Server Administration Tools installed.

1. To create a new node object for the new VM, use the [New-NetworkControllerNodeObject](/powershell/module/networkcontroller/new-networkcontrollernodeobject) command. For example:

  ```powershell
  $newNode = New-NetworkControllerNodeObject -Name "Node4" -Server "NCNode4.contoso.com" -FaultDomain "fd:/rack1/host4" -RestInterface "Internal"
  ```

## Network Controller deployment validation

Once, you have deployed Network Controller, it's important to validate that the deployment was successful and that the Network Controller services are functioning as expected. You can do this by adding a credential to Network Controller and then retrieving that credential.

If you're using Kerberos as the ClientAuthentication mechanism, membership in the **ClientSecurityGroup** that you created is the minimum required to perform this procedure.

To validate your Network Controller deployment, follow these steps:

1. On a client computer, if you're using Kerberos as the ClientAuthentication mechanism, sign in with a user account that is a member of your **ClientSecurityGroup**.

1. Open Windows PowerShell, type the following commands to add a credential to Network Controller, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

  ```powershell
  $cred=New-Object Microsoft.Windows.Networkcontroller.credentialproperties
  $cred.type="usernamepassword"
  $cred.username="admin"
  $cred.value="abcd"

  New-NetworkControllerCredential -ConnectionUri https://networkcontroller -Properties $cred -ResourceId cred1
  ```

1. To retrieve the credential that you added to Network Controller, type the following command, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

  ```powershell
  Get-NetworkControllerCredential -ConnectionUri https://networkcontroller -ResourceId cred1
  ```

1. Review the command output, which should be similar to the following example output.

  ```powershell
  Tags                   :
  ResourceRef     : /credentials/cred1
  CreatedTime    : 1/1/0001 12:00:00 AM
  InstanceId        : e16ffe62-a701-4d31-915e-7234d4bc5a18
  Etag                  : W/"1ec59631-607f-4d3e-ac78-94b0822f3a9d"
  ResourceMetadata :
  ResourceId       : cred1
  Properties       : Microsoft.Windows.NetworkController.CredentialProperties
  ```

  > [!NOTE]
  > When you run the **Get-NetworkControllerCredential** command, you can assign the output of the command to a variable by using the dot operator to list the properties of the credentials. For example, $cred.Properties.

## Post-deployment steps for non-Kerberos deployments

If you aren't using Kerberos with your Network Controller deployment, you must deploy certificates.

For more information, see [Post-Deployment Steps for Network Controller](../technologies/network-controller/post-deploy-steps-nc.md).
