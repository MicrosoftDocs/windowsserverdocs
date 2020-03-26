---
title: Network Controller Security
description: You can use this topic to learn how to configure security for all communication between Network Controller and other software and devices. 
manager: dougkim
ms.prod: windows-server
ms.technology: networking-sdn
ms.topic: article
ms.assetid: bc625de9-ee31-40a4-9ad2-7448bfbfb6e6
ms.author: lizross
author: eross-msft
ms.date: 08/30/2018
---

# Secure the Network Controller

In this topic, you learn how to configure security for all communication between [Network Controller](../technologies/network-controller/network-controller.md) and other software and devices. 

The communication paths that you can secure include Northbound communication on the management plane, cluster communication between Network Controller virtual machines \(VMs\) in a cluster, and Southbound communication on the data plane.

1. **Northbound Communication**. Network Controller communicates on the management plane with SDN\-capable management software like Windows PowerShell and System Center Virtual Machine Manager \(SCVMM\). These management tools provide you with the ability to define network policy and to create a goal state for the network, against which you can compare the actual network configuration to bring the actual configuration into parity with the goal state.

2. **Network Controller Cluster Communication**. When you configure three or more VMs as Network Controller cluster nodes, these nodes communicate with each other. This communication might be related to synchronizing and replication of data across nodes, or specific communication between Network Controller services.

3.  **Southbound Communication**. Network Controller communicates on the data plane with SDN infrastructure and other devices like software load balancers, gateways, and host machines. You can use Network Controller to configure and manage these southbound devices so that they maintain the goal state that you have configured for the network.


## Northbound Communication

Network Controller supports authentication, authorization, and encryption for Northbound communication. The following sections provide information on how to configure these security settings.

### Authentication

When you configure authentication for Network Controller Northbound communication, you allow Network Controller cluster nodes and management clients to verify the identity of the device with which they are communicating.

Network Controller supports the following three modes of authentication between management clients and Network Controller nodes.

>[!Note]
>If you are deploying Network Controller with System Center Virtual Machine Manager, only **Kerberos** mode is supported.

1. **Kerberos**. Use Kerberos authentication when joining both the management client and all Network Controller cluster nodes to an Active Directory domain. The Active Directory domain must have domain accounts used for authentication.

2. **X509**. Use X509 for certificate\-based authentication for management clients not joined to an Active Directory domain. You must enroll certificates to all Network Controller cluster nodes and management clients. Also, all nodes and management clients must trust each others' certificates.

3. **None**. Use None for testing purposes in a test environment and, therefore, not recommended for use in a production environment. When you choose this mode, there is no authentication performed between nodes and management clients.

You can configure the Authentication mode for Northbound communication by using the Windows PowerShell command **[Install-NetworkController](https://docs.microsoft.com/powershell/module/networkcontroller/install-networkcontroller)** with the _ClientAuthentication_ parameter. 


### Authorization

When you configure authorization for Network Controller Northbound communication, you allow Network Controller cluster nodes and management clients to verify that the device with which they are communicating is trusted and has permission to participate in the communication.

Use the following authorization methods for each of the authentication modes supported by Network Controller.

1.  **Kerberos**. When you are using the Kerberos authentication method, you define the users and computers authorized to communicate with Network Controller by creating a security group in Active Directory, and then adding the authorized users and computers to the group. You can configure Network Controller to use the security group for authorization by using the _ClientSecurityGroup_ parameter of the **[Install-NetworkController](https://docs.microsoft.com/powershell/module/networkcontroller/install-networkcontroller)** Windows PowerShell command. After installing the Network Controller, you can change the security group by using the **[Set-NetworkController](https://docs.microsoft.com/powershell/module/networkcontroller/Set-NetworkController)** command with the parameter _-ClientSecurityGroup_. If using SCVMM, you must provide the security group as a parameter during deployment.

2.  **X509**. When you are using the X509 authentication method, Network Controller only accepts requests from management clients whose certificate thumbprints are known to Network Controller. You can configure these thumbprints by using the _ClientCertificateThumbprint_ parameter of the **[Install-NetworkController](https://docs.microsoft.com/powershell/module/networkcontroller/install-networkcontroller)** Windows PowerShell command. You can add other client thumbprints at any time by using the **[Set-NetworkController](https://docs.microsoft.com/powershell/module/networkcontroller/Set-NetworkController)** command.

3.  **None**. When you choose this mode, there is no authentication performed between nodes and management clients. Use None for testing purposes in a test environment and, therefore, not recommended for use in a production environment. 


### Encryption

Northbound communication uses Secure Sockets Layer \(SSL\) to create an encrypted channel between management clients and Network Controller nodes. SSL encryption for Northbound communication includes the following requirements:

- All Network Controller nodes must have an identical certificate that includes the Server Authentication and Client Authentication purposes in Enhanced Key Usage \(EKU\) extensions. 

- The URI used by management clients to communicate with Network Controller must be the certificate subject name. The certificate subject name must contain either the Fully Qualified Domain Name (FQDN) or the IP address of the Network Controller REST Endpoint.

- If Network Controller nodes are on different subnets, the subject name of their certificates must be the same as the value used for the _RestName_ parameter in the **Install-NetworkController** Windows PowerShell command. 

- All of the management clients must trust the SSL certificate.


### SSL Certificate Enrollment and Configuration

You must manually enroll the SSL certificate on Network Controller nodes.

After the certificate is enrolled, you can configure Network Controller to use the certificate with the **-ServerCertificate** parameter of the **Install-NetworkController** Windows PowerShell command. If you have already installed Network Controller, you can update the configuration at any time by using the **Set-NetworkController** command.

>[!NOTE]
>If you are using SCVMM, you must add the certificate as a library resource. For more information, see [Set up an SDN network controller in the VMM fabric](https://docs.microsoft.com/system-center/vmm/sdn-controller).

## Network Controller Cluster Communication

Network Controller supports authentication, authorization, and encryption for communication between Network Controller nodes. The communication is over [Windows Communication Foundation](https://docs.microsoft.com/dotnet/framework/wcf/whats-wcf) \(WCF\) and TCP.

You can configure this mode with the **ClusterAuthentication** parameter of the **Install-NetworkControllerCluster** Windows PowerShell command. 

For more information, see [Install-NetworkControllerCluster](https://docs.microsoft.com/powershell/module/networkcontroller/install-networkcontrollercluster).

### Authentication

When you configure authentication for Network Controller Cluster communication, you allow Network Controller cluster nodes to verify the identity of the other nodes with which they are communicating.

Network Controller supports the following three modes of authentication between Network Controller nodes.

>[!NOTE]
>If you deploy Network Controller by using SCVMM, only **Kerberos** mode is supported.

1. **Kerberos**. You can use Kerberos authentication when all Network Controller cluster nodes are joined to an Active Directory domain, with domain accounts used for authentication.

2. **X509**. X509 is certificate\-based authentication. You can use X509 authentication when Network Controller cluster nodes are not joined to an Active Directory domain. To use X509, you must enroll certificates to all Network Controller cluster nodes, and all nodes must trust the certificates. In addition, the subject name of the certificate that is enrolled on each node must be the same as the DNS name of the node.

3. **None**. When you choose this mode, there is no authentication performed between Network Controller nodes. This mode is provided only for testing purposes, and is not recommended for use in a production environment.

### Authorization

When you configure authorization for Network Controller Cluster communication, you allow Network Controller cluster nodes to verify that the nodes with which they are communicating are trusted and have permission to participate in the communication.

For each of the authentication modes supported by Network Controller, the following authorization methods are used.

1. **Kerberos**. Network Controller nodes accept communication requests only from other Network Controller machine accounts. You can configure these accounts when you deploy Network Controller by using the **Name** parameter of the [New-NetworkControllerNodeObject](https://docs.microsoft.com/powershell/module/networkcontroller/new-networkcontrollernodeobject) Windows PowerShell command.

2. **X509**. Network Controller nodes accept communication requests only from other Network Controller machine accounts. You can configure these accounts when you deploy Network Controller by using the **Name** parameter of the [New-NetworkControllerNodeObject](https://docs.microsoft.com/powershell/module/networkcontroller/new-networkcontrollernodeobject) Windows PowerShell command.

3. **None**. When you choose this mode, there is no authorization performed between Network Controller nodes. This mode is provided only for testing purposes, and is not recommended for use in a production environment.

### Encryption

Communication between Network Controller nodes is encrypted using WCF Transport level encryption. This form of encryption is used when the authentication and authorization methods are either Kerberos or X509 certificates. For more information, see the following topics.

- [How to: Secure a Service with Windows Credentials](https://docs.microsoft.com/dotnet/framework/wcf/how-to-secure-a-service-with-windows-credentials)
- [How to: Secure a Service with X.509 Certificates](https://docs.microsoft.com/dotnet/framework/wcf/feature-details/how-to-secure-a-service-with-an-x-509-certificate).

## Southbound Communication

Network Controller interacts with different types of devices for Southbound communication. These interactions use different protocols. Because of this, there are different requirements for authentication, authorization, and
encryption depending on the type of device and protocol used by Network Controller to communicate with the device.

The following table provides information about Network Controller interaction with different southbound devices.

| Southbound device/service | Protocol              | Authentication used    |
|---------------------------|-----------------------|------------------------|
| Software Load Balancer    | WCF (MUX), TCP (Host) | Certificates           |
| Firewall                  | OVSDB                 | Certificates           |
| Gateway                   | WinRM                 | Kerberos, Certificates |
| Virtual Networking        | OVSDB, WCF            | Certificates           |
| User defined routing      | OVSDB                 | Certificates           |

For each of these protocols, the communication mechanism is described in the following section.

### Authentication

For Southbound communication, the following protocols and authentication methods are used.

1. **WCF/TCP/OVSDB**. For these protocols, authentication is performed by using X509 certificates. Both Network Controller and the peer Software Load Balancing \(SLB\) Multiplexer \(MUX\)/host machines present their certificates to each other for mutual authentication. Each certificate must be trusted by the remote peer.

	For southbound authentication, you can use the same SSL certificate that is configured for encrypting the communication with the Northbound clients. You must also configure a certificate on the SLB MUX and host devices. The certificate subject name must be same as the DNS name of the device.

2. **WinRM**. For this protocol, authentication is performed by using Kerberos \(for domain joined machines\) and
by using certificates \(for non-domain joined machines\).

### Authorization

For Southbound communication, the following protocols and authorization methods are used.

1. **WCF/TCP**. For these protocols, authorization is based on the subject name of the peer entity. Network Controller stores the peer device DNS name, and uses it for authorization. This DNS name must match the subject name of the device in the certificate. Likewise, Network Controller certificate must match the Network
Controller DNS name stored on the peer device.

2. **WinRM**. If Kerberos is being used, the WinRM client account must be present in a predefined group in Active Directory or in the Local Administrators group on the server. If certificates are being used, the client presents a certificate to the server that the server authorizes using the subject name/issuer, and the server uses a mapped user account to perform authentication.

3.  **OVSDB**. There is no authorization provided for this protocol.

### Encryption

For Southbound communication, the following encryption methods are used for protocols.

1. **WCF/TCP/OVSDB**. For these protocols, encryption is performed using the certificate that is enrolled on the client or server.

2. **WinRM**. WinRM traffic is encrypted by default using Kerberos security support provider \(SSP\). You can configure Additional encryption, in the form of SSL, on the WinRM server.
