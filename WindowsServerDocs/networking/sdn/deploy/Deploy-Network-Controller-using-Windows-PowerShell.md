---
title: Deploy Network Controller using PowerShell on Windows Server
description: Deploy Network Controller using Windows PowerShell to automate SDN management on Windows Server. Follow step-by-step instructions and streamline your setup.
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 06/19/2025
#customer intent: As a network admin, I want to deploy Network Controller using Windows PowerShell so that I can automate SDN management on Windows Server.
---

# Deploy Network Controller using Windows PowerShell

Network Controller is a key component in Software Defined Networking (SDN) for Windows Server. Learn how to prepare your environment, configure the Network Controller cluster and application, validate your deployment, and manage your Network Controller installation using PowerShell commands. This article configures an example deployment of Network Controller on three VMs using Windows PowerShell. You can adapt the steps to your specific environment.

## Prerequisites

Before you deploy Network Controller, ensure that you have the following prerequisites:

- One or more computers or VMs that are running Windows Server 2016 or later.

  - For a single-node deployment, you can use a single computer or VM.
  - For a clustered deployment, you need at least three computers or VMs. The recommended number of nodes in a Network Controller cluster is three or more. You can add more nodes to the cluster later if needed.
  - Don't deploy the Network Controller server role on physical hosts. You must install the Network Controller server role on a Hyper-V VM that is installed on a Hyper-V host.

- A domain user account that has membership in the **Administrators** group or equivalent on the computer or VM where you're installing Network Controller. If the computer or VM upon which you installed Network Controller is joined to a domain, your user account must be a member of **Domain Users**.

- The Network Controller server role and is installed on each VM that you want to add to the Network Controller cluster. You can install the Network Controller server role by using Windows PowerShell or Server Manager. To learn more about how to install roles and features, see [Add or remove roles and features in Windows Server](../../../administration/server-manager/add-remove-roles-features.md).

- A DNS record for the Network Controller REST API. The DNS record must resolve to the IP address you assign to the Network Controller REST API. This DNS record is used by clients to connect to the Network Controller REST API.

- (Recommended) A certificate that is used for authentication and encryption of traffic between Network Controller services. Certificate based authentication is required for non-domain joined deployments. The certificate must have the following properties:

  - A trusted certification authority (CA) must issue the certificate.

  - The certificate must have the Server Authentication (OID.1.3.6.1.5.5.7.3.1) purpose in Enhanced Key Usage extensions.

  - The certificate subject name must match:

    - The DNS of the Network Controller VM, if Network Controller is deployed on a single VM.

    - The REST name, if Network Controller is deployed on multiple computers, multiple VMs, or both.

  - The certificate must be exported using the Personal Information Exchange (PFX) PKCS #12 format, and must include the private key. Include all certificates in the certificate chain when you export the certificate if possible.
  
  - This certificate must be trusted by all the REST clients. The certificate must also be trusted by the Software Load Balancing (SLB) Multiplexer (MUX) and the southbound host computers that are managed by Network Controller.

  - The certificate and private key must be provisioned on all of the Network Controller nodes before you run the commands to create the cluster and install the Network Controller application.

## Create a Network Controller cluster

The Network Controller cluster provides high availability and scalability for the Network Controller application. After you create the cluster, you can configure the Network Controller application, which runs on top of the cluster. You can perform the procedures in the following sections in two ways:

- Directly on the VM where you installed Network Controller.
- From a remote computer using the Remote Server Administration Tools for Windows Server.

To create a Network Controller cluster, you need to create a node object for each VM that is a member of the Network Controller cluster, using the [New-NetworkControllerNodeObject](/powershell/module/networkcontroller/new-networkcontrollernodeobject) command. After you create the node objects, you can configure the cluster using the [Install-NetworkControllerCluster](/powershell/module/networkcontroller/install-networkcontrollercluster) command. Finally, you can install the Network Controller application using the [Install-NetworkController](/powershell/module/networkcontroller/install-networkcontroller) command.

To deploy Network Controller using Windows PowerShell, follow these steps:

1. Open Windows PowerShell as an administrator on the VM where you installed Network Controller or on a remote computer that has the Remote Server Administration Tools installed.

1. To define the Network Controller nodes, create a node object for each VM that is a member of the Network Controller cluster using the [New-NetworkControllerNodeObject](/powershell/module/networkcontroller/new-networkcontrollernodeobject) command. For example, to create a node object for each VM, you can use the following commands:

   ```powershell
   $nodes = @(
     @{ Name = "Node1"; Server = "NCNode1.contoso.com"; FaultDomain = "fd:/rack1/host1"; RestInterface = "Internal" },
     @{ Name = "Node2"; Server = "NCNode2.contoso.com"; FaultDomain = "fd:/rack1/host2"; RestInterface = "Internal" },
     @{ Name = "Node3"; Server = "NCNode3.contoso.com"; FaultDomain = "fd:/rack1/host3"; RestInterface = "Internal" }
   )

   $nodeObjects = @()
   foreach ($node in $nodes) {
     $nodeParams = @{
       Name         = $node.Name
       Server       = $node.Server
       FaultDomain  = $node.FaultDomain
       RestInterface= $node.RestInterface
     }
     $nodeObject = New-NetworkControllerNodeObject @nodeParams
     $nodeObjects += $nodeObject
   }
   ```

   The example creates three node objects, specifying the name, fully qualified domain name (FQDN) for when using Kerberos authentication, fault domain, and REST interface. The fault domain is specified in a hierarchical format, which helps Network Controller to spread out services across different fault domains for high availability.

1. Capture the certificate that you want to use for authentication and encryption of traffic between Network Controller services. You can use the following command to retrieve the certificate from the local computer certificate store:

   ```powershell
   $cert = Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.Subject -imatch <FQQN> }
   ```

   Ensure that you replace `<FQDN>` with the actual subject name of your certificate.

1. To create the Network Controller cluster, use the [Install-NetworkControllerCluster](/powershell/module/networkcontroller/install-networkcontrollercluster) command. For example, to configure the cluster with the node objects you created, you can use the following command:

   ```powershell
   $clusterParams = @{
     Node                        = @($nodeObjects)
     ClusterAuthentication       = "Kerberos"
     ManagementSecurityGroup     = "Contoso\NCManagementAdmins"
     DiagnosticLogLocation       = "\\share\Diagnostics"
     CredentialEncryptionCertificate = $cert
   }

   Install-NetworkControllerCluster @clusterParams
   ```

   The example installs the Network Controller cluster with Kerberos authentication, specifies a management security group for administrative access, and sets a diagnostic log location.

1. To install the Network Controller application, use the [Install-NetworkController](/powershell/module/networkcontroller/install-networkcontroller) command. For example, to install the Network Controller application with the node objects you created, you can use the following command:

   ```powershell
   $ncParams = @{
     Node                 = @($nodeObjects)
     ClientAuthentication = "Kerberos"
     ClientSecurityGroup  = "Contoso\NCRESTClients"
     ServerCertificate    = $cert
     RESTIPAddress        = "10.0.0.1/24"
     RESTName             = "networkcontroller.contoso.com"
   }

   Install-NetworkController @ncParams
   ```

   The example installs the Network Controller application with Kerberos authentication, specifies a client security group for REST API access, and sets the REST IP address.

## Add a node to the Network Controller cluster

If you need to add a new node to the Network Controller cluster after the initial deployment, you can do so by creating a new node object and then using the [Add-NetworkControllerNode](/powershell/module/networkcontroller/add-networkcontrollernode) command.

To add a node to the Network Controller cluster, follow these steps:

1. Complete the [prerequisites](#prerequisites) for the new node.

1. Open Windows PowerShell as an administrator on an existing Network Controller node or on a remote computer that has the Remote Server Administration Tools installed.

1. To create a new node object for the new VM, use the [New-NetworkControllerNodeObject](/powershell/module/networkcontroller/new-networkcontrollernodeobject) command. For example:

   ```powershell
   $newNodeParams = @{
     Name         = "Node4"
     Server       = "NCNode4.contoso.com"
     FaultDomain  = "fd:/rack1/host4"
     RestInterface= "Internal"
   }
   $newNode = New-NetworkControllerNodeObject @newNodeParams
   ```

## Network Controller validation

Once, you have deployed Network Controller, it's important to validate that the deployment was successful and that the Network Controller services are functioning as expected. You can do this by adding a credential to Network Controller and then retrieving that credential.

If you're using Kerberos as the ClientAuthentication mechanism, membership in the `ClientSecurityGroup` that you created is the minimum required to perform this procedure.

To validate your Network Controller deployment, follow these steps:

1. On a client computer, if you're using Kerberos as the ClientAuthentication mechanism, sign in with a user account that is a member of your `ClientSecurityGroup`.

1. Open Windows PowerShell, type the following commands to add a credential to Network Controller, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

   ```powershell
   $cred = New-Object Microsoft.Windows.NetworkController.CredentialProperties
   $cred.Type = "UsernamePassword"
   $cred.UserName = Read-Host "Enter username"
   $cred.Value = Read-Host "Enter password" -AsSecureString

  $credParams = @{
    ConnectionUri = "https://networkcontroller.contoso.com"
    Properties    = $cred
    ResourceId    = "credentialResource01"
  }
  New-NetworkControllerCredential @credParams
   ```

1. To retrieve the credential that you added to Network Controller, type the following command, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

   ```powershell
   Get-NetworkControllerCredential -ConnectionUri https://networkcontroller.contoso.com -ResourceId "credentialResource01"
   ```

1. Review the command output, which should be similar to the following example output.

   ```powershell
   Tags                   :
   ResourceRef     : /credentials/credentialResource01
   CreatedTime    : 1/1/0001 12:00:00 AM
   InstanceId        : aaaaaaaa-0000-1111-2222-bbbbbbbbbbbb
   Etag                  : W/"bbbbbbbb-1111-2222-3333-cccccccccccc"
   ResourceMetadata :
   ResourceId       : credentialResource01
   Properties       : Microsoft.Windows.NetworkController.CredentialProperties
   ```

   > [!NOTE]
   > When you run the **Get-NetworkControllerCredential** command, you can assign the output of the command to a variable by using the dot operator to list the properties of the credentials. For example, $cred.Properties.

## Next steps

After you have installed Network Controller on VMs on three different Hyper-V hosts, you must add the hosts to Network Controller to enable the SDN Software Load Balancer using the Windows PowerShell command **New-NetworkControllerServer**. To learn more about the Software Load Balancer and how it works with Network Controller, see the following resources:

- [New-NetworkControllerServer](/powershell/module/networkcontroller/new-networkcontrollerserver).
- [Configure the Software Load Balancer for Load Balancing and Network Address Translation (NAT)](../manage/Configure-SLB-and-NAT.md)