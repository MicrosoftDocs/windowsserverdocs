---
title: Deploy Network Controller using Windows PowerShell
description: This topic provides instructions on using Windows PowerShell to deploy Network Controller on one or more computers or virtual machines (VMs) that are running Windows Server 2016.
manager: dougkim
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-sdn
ms.tgt_pltfrm: na
ms.topic: get-started-article
ms.assetid: 2448d381-55aa-4c14-997a-202c537c6727
ms.author: lizross
author: eross-msft
ms.date: 08/23/2018
---
# Deploy Network Controller using Windows PowerShell

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic provides instructions on using Windows PowerShell to deploy Network Controller on one or more virtual machines (VMs) that are running Windows Server 2016.

>[!IMPORTANT]
>Do not deploy the Network Controller server role on physical hosts. To deploy Network Controller, you must install the Network Controller server role on a Hyper-V virtual machine \(VM\) that is installed on a Hyper-V host. After you have installed Network Controller on VMs on three different Hyper\-V hosts, you must enable the Hyper\-V hosts for Software Defined Networking \(SDN\) by adding the hosts to Network Controller using the Windows PowerShell command **New-NetworkControllerServer**. By doing so, you are enabling the SDN Software Load Balancer to function. For more information, see [New-NetworkControllerServer](https://technet.microsoft.com/itpro/powershell/windows/network-controller/new-networkcontrollerserver).

This topic contains the following sections.

- [Install the Network Controller server role](#install-the-network-controller-server-role)

- [Configure the Network Controller cluster](#configure-the-network-controller-cluster)

- [Configure the Network Controller application](#configure-the-network-controller-application)

- [Network Controller deployment validation](#network-controller-deployment-validation)

- [Additional Windows PowerShell commands for Network Controller](#additional-windows-powershell-commands-for-network-controller)

- [Sample Network Controller configuration script](#sample-network-controller-configuration-script)

- [Post-Deployment Steps for Non-Kerberos Deployments](#post-deployment-steps-for-non-kerberos-deployments)

## Install the Network Controller server role

You can use this procedure to install the Network Controller server role on a virtual machine \(VM\).

>[!IMPORTANT]
>Do not deploy the Network Controller server role on physical hosts. To deploy Network Controller, you must install the Network Controller server role on a Hyper-V virtual machine \(VM\) that is installed on a Hyper-V host. After you have installed Network Controller on VMs on three different Hyper\-V hosts, you must enable the Hyper\-V hosts for Software Defined Networking \(SDN\) by adding the hosts to Network Controller. By doing so, you are enabling the SDN Software Load Balancer to function.

Membership in **Administrators**, or equivalent, is the minimum required to perform this procedure.  

>[!NOTE]
>If you want to use Server Manager instead of Windows PowerShell to install Network Controller, see [Install the Network Controller server role using Server Manager](https://technet.microsoft.com/library/mt403348.aspx)

To install Network Controller by using Windows PowerShell, type the following commands at a Windows PowerShell prompt, and then press ENTER.

`Install-WindowsFeature -Name NetworkController -IncludeManagementTools`

Installation of Network Controller requires that you restart the computer. To do so, type the following command, and then press ENTER.

`Restart-Computer`

## Configure the Network Controller cluster

The Network Controller cluster provides high availability and scalability to the Network Controller application, which you can configure after creating the cluster, and which is  hosted on top of the cluster.

>[!NOTE]
>You can perform the procedures in the following sections either directly on the VM where you installed Network Controller, or you can use the Remote Server Administration Tools for Windows Server 2016 to perform the procedures from a remote computer that is running either Windows Server 2016 or Windows 10. In addition, membership in **Administrators**, or equivalent, is the minimum required to perform this procedure. If the computer or VM upon which you installed Network Controller is joined to a domain, your user account must be a member of **Domain Users**.

You can create a Network Controller cluster by creating a node object and then configuring the cluster.

### Create a node object

You need to create a node object for each VM that is a member of the Network Controller cluster.

To create a node object,  type the following command at the Windows PowerShell command prompt, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.  

```
New-NetworkControllerNodeObject -Name <string> -Server <String> -FaultDomain <string>-RestInterface <string> [-NodeCertificate <X509Certificate2>]
```

The following table provides descriptions for each parameter of the **New-NetworkControllerNodeObject** command.

|Parameter|Description|
|-------------|---------------|
|Name|The **Name** parameter specifies the friendly name of the server that you want to add to the cluster|
|Server|The **Server** parameter specifies the host name, Fully Qualified Domain Name (FQDN), or IP address of the server that you want to add to the cluster. For domain-joined computers, FQDN is required.|
|FaultDomain|The **FaultDomain** parameter specifies the failure domain for the server that you are adding to the cluster. This parameter defines the servers that might experience failure at the same time as the server that you are adding to the cluster. This failure might be due to shared physical dependencies such as power and networking sources. Fault domains typically represent hierarchies that are related to these shared dependencies, with more servers likely to fail together from a higher point in the fault domain tree. During runtime, Network Controller considers the fault domains in the cluster and attempts to spread out the Network Controller services so that they are in separate fault domains. This process helps ensure, in case of failure of any one fault domain, that the availability of that service and its state is not compromised. Fault domains are specified in a hierarchical format. For example: "Fd:/DC1/Rack1/Host1", where DC1 is the datacenter name, Rack1 is the rack name and Host1 is the name of the host where the node is placed.|
|RestInterface|The **RestInterface** parameter specifies the name of the interface on the node where the  Representational State Transfer (REST) communication is terminated. This Network Controller interface receives Northbound API requests from the network's management layer.|
|NodeCertificate|The **NodeCertificate** parameter specifies the certificate that Network Controller uses for computer authentication. The certificate is required if you use certificate-based authentication for communication within the cluster; the certificate is also used for encryption of traffic between Network Controller services. The certificate subject name must be same as the DNS name of the node.|

### Configure the cluster

To configure the cluster,  type the following command at the Windows PowerShell command prompt, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

```
Install-NetworkControllerCluster -Node <NetworkControllerNode[]> -ClusterAuthentication <ClusterAuthentication> [-ManagementSecurityGroup <string>][-DiagnosticLogLocation <string>][-LogLocationCredential <PSCredential>] [-CredentialEncryptionCertificate <X509Certificate2>][-Credential <PSCredential>][-CertificateThumbprint <String>] [-UseSSL][-ComputerName <string>][-LogSizeLimitInMBs<UInt32>] [-LogTimeLimitInDays<UInt32>]
```

The following table provides descriptions for each parameter of the **Install-NetworkControllerCluster**  command.
  
|Parameter|Description|
|-------------|---------------|
|ClusterAuthentication|The **ClusterAuthentication** parameter specifies the authentication type that is used for securing the communication between nodes and is also used for encryption of traffic between Network Controller services. The supported values are **Kerberos**, **X509** and **None**. Kerberos authentication uses domain accounts and can only be used if the Network Controller nodes are domain joined. If you specify X509-based authentication, you must provide a certificate in the NetworkControllerNode object. In addition, you must manually provision the certificate before you run this command.|
|ManagementSecurityGroup|The **ManagementSecurityGroup** parameter specifies the name of the security group that contains users that are allowed to run the management cmdlets from a remote computer. This is only applicable if ClusterAuthentication is Kerberos. You must specify a domain security group and not a security group on the local computer.|
|Node|The **Node** parameter specifies the list of Network Controller nodes that you  created by using the **New-NetworkControllerNodeObject** command.|
|DiagnosticLogLocation|The **DiagnosticLogLocation** parameter specifies the share location where the diagnostic logs are periodically uploaded. If you do not specify a value for this parameter, the logs are stored locally on each node. Logs are stored locally in the folder %systemdrive%\Windows\tracing\SDNDiagnostics. Cluster logs are stored locally in the folder %systemdrive%\ProgramData\Microsoft\Service Fabric\log\Traces.|
|LogLocationCredential|The **LogLocationCredential** parameter specifies the credentials that are required for accessing the share location where the logs are stored.|
|CredentialEncryptionCertificate|The **CredentialEncryptionCertificate** parameter specifies the certificate that Network Controller uses to encrypt the credentials that are used to access Network Controller binaries and the **LogLocationCredential**, if specified. The certificate must be provisioned on all of the Network Controller nodes before you run this command, and the same certificate must be enrolled on all of the cluster nodes. Using this parameter to protect Network Controller binaries and logs is recommended in production environments. Without this parameter, the credentials are stored in clear text and can be misused by any unauthorized user.|
|Credential|This parameter is required only if you are running this command from a remote computer. The **Credential** parameter specifies a user account that has permission to run this command on the target computer.|
|CertificateThumbprint|This parameter is required only if you are running this command from a remote computer. The **CertificateThumbprint** parameter specifies the digital public key certificate (X509) of a user account that has permission to run this command on the target computer.|
|UseSSL|This parameter is required only if you are running this command from a remote computer. The **UseSSL** parameter specifies the Secure Sockets Layer (SSL) protocol that is used to establish a connection to the remote computer. By default, SSL is not used.|
|ComputerName|The **ComputerName** parameter specifies the Network Controller node on which this command is run. If you do not specify a value for this parameter, the local computer is used by default.|
|LogSizeLimitInMBs|This parameter specifies the maximum log size, in MB, that Network Controller can store. Logs are stored in circular fashion. If DiagnosticLogLocation is provided, the default value of this parameter is 40 GB. If DiagnosticLogLocation is not provided, the logs are stored on the Network Controller nodes and the default value of this parameter is 15 GB.|
|LogTimeLimitInDays|This parameter specifies the duration limit, in days, for which the logs are stored. Logs are stored in circular fashion. The default value of this parameter is 3 days.|

## Configure the Network Controller application
To configure the Network Controller application, type the following command at the Windows PowerShell command prompt, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

```
Install-NetworkController -Node <NetworkControllerNode[]> -ClientAuthentication <ClientAuthentication>  [-ClientCertificateThumbprint <string[]>]  [-ClientSecurityGroup <string>] -ServerCertificate <X509Certificate2> [-RESTIPAddress <String>] [-RESTName <String>] [-Credential <PSCredential>][-CertificateThumbprint <String> ] [-UseSSL]
```

The following table provides descriptions for each parameter of the **Install-NetworkController** command.

|Parameter|Description|
|-------------|---------------|
|ClientAuthentication|The **ClientAuthentication** parameter specifies the authentication type that is used for securing the communication between REST and Network Controller. The supported values are **Kerberos**, **X509** and **None**. Kerberos authentication uses domain accounts and can only be used if the Network Controller nodes are domain joined. If you specify X509-based authentication, you must provide a certificate in the NetworkControllerNode object. In addition, you must manually provision the certificate before you run this command.|
|Node|The **Node** parameter specifies the list of Network Controller nodes that you  created by using the **New-NetworkControllerNodeObject** command.|
|ClientCertificateThumbprint|This parameter is required only when you are using certificate-based authentication for Network Controller clients. The **ClientCertificateThumbprint** parameter specifies the thumbprint of the certificate that is enrolled to clients on the Northbound layer.|
|ServerCertificate|The **ServerCertificate** parameter specifies the certificate that Network Controller uses to prove its identity to clients. The server certificate must include the Server Authentication purpose in Enhanced Key Usage extensions, and must be issued to Network Controller by a CA that is trusted by clients.|
|RESTIPAddress|You do not need to specify a value for **RESTIPAddress** with a single node deployment of Network Controller. For multiple-node deployments, the **RESTIPAddress** parameter specifies the IP address of the REST endpoint in CIDR notation. For example, 192.168.1.10/24. The Subject Name value of **ServerCertificate** must resolve to the value of the **RESTIPAddress** parameter. This parameter must be specified for all multiple-node Network Controller deployments when all of the nodes are on the same subnet. If nodes are on different subnets, you must use the **RestName** parameter instead of using **RESTIPAddress**.|
|RestName|You do not need to specify a value for **RestName** with a single node deployment of Network Controller. The only time you must specify a value for **RestName** is when multiple-node deployments have nodes that are on different subnets. For multiple-node deployments, the **RestName** parameter specifies the FQDN for the Network Controller cluster.|
|ClientSecurityGroup|The **ClientSecurityGroup** parameter specifies the name of the Active Directory security group whose members are Network Controller clients. This parameter is required only if you use Kerberos authentication for **ClientAuthentication**. The security group must contain the accounts from which the REST APIs are accessed, and you must  create the security group and add members before running this command.|
|Credential|This parameter is required only if you are running this command from a remote computer. The **Credential** parameter specifies a user account that has permission to run this command on the target computer.|
|CertificateThumbprint|This parameter is required only if you are running this command from a remote computer. The **CertificateThumbprint** parameter specifies the digital public key certificate (X509) of a user account that has permission to run this command on the target computer.|
|UseSSL|This parameter is required only if you are running this command from a remote computer. The **UseSSL** parameter specifies the Secure Sockets Layer (SSL) protocol that is used to establish a connection to the remote computer. By default, SSL is not used.|

After you complete the configuration of the Network Controller application, your deployment of Network Controller is complete.

## Network Controller deployment validation

To validate your Network Controller deployment, you can add a credential to the Network Controller and then retrieve the credential.

If you are using Kerberos as the ClientAuthentication mechanism, membership in the **ClientSecurityGroup** that you created is the minimum required to perform this procedure.

**Procedure:**

1.  On a client computer, if you are using Kerberos as the ClientAuthentication mechanism, log on with a user account that is a member of your **ClientSecurityGroup**.

2. Open Windows PowerShell, type the following commands to add a credential to Network Controller, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

    ```
    $cred=New-Object Microsoft.Windows.Networkcontroller.credentialproperties
    $cred.type="usernamepassword"
    $cred.username="admin"
    $cred.value="abcd"

    New-NetworkControllerCredential -ConnectionUri https://networkcontroller -Properties $cred -ResourceId cred1
    ```

3. To retrieve the credential that you added to Network Controller, type the following command, and then press ENTER. Ensure that you add values for each parameter that are appropriate for your deployment.

    ```
    Get-NetworkControllerCredential -ConnectionUri https://networkcontroller -ResourceId cred1  
    ```

4. Review the command output, which should be similar to the following example output.

    ```
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

## Additional Windows PowerShell commands for Network Controller

After you deploy Network Controller, you can use Windows PowerShell commands to manage and modify your deployment. Following are some of the changes that you can make to your deployment.

- Modify Network Controller node, cluster,  and application settings

- Remove the Network Controller cluster and application

- Manage Network Controller cluster nodes, including adding, removing, enabling, and disabling nodes.

The following table provides the syntax for Windows PowerShell commands that you can use to accomplish these tasks.

|Task|Command|Syntax|
|--------|-------|----------|
|Modify Network Controller cluster settings|Set-NetworkControllerCluster|`Set-NetworkControllerCluster [-ManagementSecurityGroup <string>][-Credential <PSCredential>] [-computerName <string>][-CertificateThumbprint <String> ] [-UseSSL]`
|Modify Network Controller application settings|Set-NetworkController|`Set-NetworkController [-ClientAuthentication <ClientAuthentication>] [-Credential <PSCredential>] [-ClientCertificateThumbprint <string[]>] [-ClientSecurityGroup <string>] [-ServerCertificate <X509Certificate2>] [-RestIPAddress <String>] [-ComputerName <String>][-CertificateThumbprint <String> ] [-UseSSL]`
|Modify Network Controller node settings|Set-NetworkControllerNode|`Set-NetworkControllerNode -Name <string> > [-RestInterface <string>] [-NodeCertificate <X509Certificate2>] [-Credential <PSCredential>] [-ComputerName <string>][-CertificateThumbprint <String> ] [-UseSSL]`
|Modify Network Controller diagnostic settings|Set-NetworkControllerDiagnostic|`Set-NetworkControllerDiagnostic [-LogScope <string>] [-DiagnosticLogLocation <string>] [-LogLocationCredential <PSCredential>] [-UseLocalLogLocation] >] [-LogLevel <loglevel>][-LogSizeLimitInMBs <uint32>] [-LogTimeLimitInDays <uint32>] [-Credential <PSCredential>] [-ComputerName <string>][-CertificateThumbprint <String> ] [-UseSSL]`
|Remove the Network Controller application|Uninstall-NetworkController|`Uninstall-NetworkController [-Credential <PSCredential>][-ComputerName <string>] [-CertificateThumbprint <String> ] [-UseSSL]`
|Remove the Network Controller cluster|Uninstall-NetworkControllerCluster|`Uninstall-NetworkControllerCluster [-Credential <PSCredential>][-ComputerName <string>][-CertificateThumbprint <String> ] [-UseSSL]`
|Add a node to the Network Controller cluster|Add-NetworkControllerNode|`Add-NetworkControllerNode -FaultDomain <String> -Name <String> -RestInterface <String> -Server <String> [-CertificateThumbprint <String> ] [-ComputerName <String> ] [-Credential <PSCredential> ] [-Force] [-NodeCertificate <X509Certificate2> ] [-PassThru] [-UseSsl]`
|Disable a Network Controller cluster node|Disable-NetworkControllerNode|`Disable-NetworkControllerNode -Name <String> [-CertificateThumbprint <String> ] [-ComputerName <String> ] [-Credential <PSCredential> ] [-PassThru] [-UseSsl]`
|Enable a Network Controller cluster node|Enable-NetworkControllerNode|`Enable-NetworkControllerNode -Name <String> [-CertificateThumbprint <String> ] [-ComputerName <String> ] [-Credential <PSCredential> ] [-PassThru] [-UseSsl]`
|Remove a Network Controller node from a cluster|Remove-NetworkControllerNode|`Remove-NetworkControllerNode [-CertificateThumbprint <String> ] [-ComputerName <String> ] [-Credential <PSCredential> ] [-Force] [-Name <String> ] [-PassThru] [-UseSsl]`

>[!NOTE]
>Windows PowerShell commands for Network Controller are in the TechNet Library at [Network Controller Cmdlets](https://technet.microsoft.com/library/mt576401.aspx).

## Sample Network Controller configuration script

The following sample configuration script shows how to create a multi-node Network Controller cluster and install the Network Controller application. In addition, the $cert variable selects a certificate from the local computer certificates store that matches the subject name string "networkController.contoso.com".

```
$a = New-NetworkControllerNodeObject -Name Node1 -Server NCNode1.contoso.com -FaultDomain fd:/rack1/host1 -RestInterface Internal
$b = New-NetworkControllerNodeObject -Name Node2 -Server NCNode2.contoso.com -FaultDomain fd:/rack1/host2 -RestInterface Internal
$c = New-NetworkControllerNodeObject -Name Node3 -Server NCNode3.contoso.com -FaultDomain fd:/rack1/host3 -RestInterface Internal

$cert= get-item Cert:\LocalMachine\My | get-ChildItem | where {$_.Subject -imatch "networkController.contoso.com" }

Install-NetworkControllerCluster -Node @($a,$b,$c)  -ClusterAuthentication Kerberos -DiagnosticLogLocation \\share\Diagnostics - ManagementSecurityGroup Contoso\NCManagementAdmins -CredentialEncryptionCertificate $cert  
Install-NetworkController -Node @($a,$b,$c) -ClientAuthentication Kerberos -ClientSecurityGroup Contoso\NCRESTClients -ServerCertificate $cert -RestIpAddress 10.0.0.1/24
```

## Post-deployment steps for non-Kerberos deployments

If you are not using Kerberos with your Network Controller deployment, you must deploy certificates.

For more information, see [Post-Deployment Steps for Network Controller](../technologies/network-controller/post-deploy-steps-nc.md).


