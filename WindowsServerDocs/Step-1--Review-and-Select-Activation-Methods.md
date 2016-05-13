---
title: Step 1: Review and Select Activation Methods
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec4bf97d-9e46-4fb7-a81a-8be8d72d86d5
---
# Step 1: Review and Select Activation Methods
The first step in planning for Volume Activation services in Windows starting with [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] is to evaluate the features and deployment models that are available for activating client computers. When you understand the differences between and advantages of these features and deployment models, move to [Step 2: Evaluate Client Connectivity](Step-2--Evaluate-Client-Connectivity.md) and use this information to assess the types of network and clients that you have. Then move to [Step 3: Determine Activation Method and Product License Requirements](Step-3--Determine-Activation-Method-and-Product-License-Requirements.md) to identify which solution is best for each group of clients.

The Volume Activation server role in Windows Server provides three methods for implementing volume activation. You can use one, two, or all three methods of volume activation. The methods you choose will depend on the size, network infrastructure, connectivity, and security requirements of your organization. The following table highlights these methods.

|Task|Description|
|--------|---------------|
|1.1. Plan for Active Directory\-based Activation|Identify and resolve key planning issues that are associated with Active Directory\-based Activation.|
|1.2. Plan for Key Management Services \(KMS\) activation|Identify and resolve key planning issues that are associated with KMS activation.|
|1.3. Plan for Multiple Activation Key \(MAK\) activation|Identify and resolve key planning issues that are associated with MAK activation.|

When you understand your volume activation options, you choose the right combination of methods to meet your organization’s needs.

## 1.1 Plan for Active Directory\-based Activation
Active Directory\-based Activation is a role service that allows you to use Active Directory Domain Services \(AD DS\) to store activation objects, which can greatly simplify the task of maintaining volume activation services for a network.

With Active Directory\-based Activation, any computers running operating systems starting with [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] with a KMS client setup key \(GVLK\) that are connected to the domain will activate automatically and transparently during computer startup. These clients stay activated as long as they remain members of the domain and maintain periodic contact with a domain controller.

Activation takes place after the Software Protection service starts. When the Software Protection service starts, the computer contacts AD DS automatically, receives the activation object, and activates without user intervention.

The following are planning considerations when working with Active Directory\-based Activation:

-   With Active Directory\-based Activation, you do not need an additional host server; your existing domain controllers can support activation clients, with the following limitations:

    -   Active Directory\-based Activation cannot be configured on read\-only domain controllers.

    -   Active Directory\-based Activation cannot be used with non\-Microsoft directory services.

    -   AD DS must be at the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] schema level to store activation objects. Domain controllers running earlier versions of Windows Server can activate clients after their schemas have been updated using the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] version of Adprep.exe. For more information, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=WS.10).aspx).

        > [!NOTE]
        > For [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], you do not have to run Adprep.exe again; the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] schema level is adequate.

-   You only need one activation object forest.

    > [!NOTE]
    > When the client and server KMS host keys are activated within an environment, two activation objects will exist in the forest. In this case, the activation object on the server activates computers running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] within the forest and the client activation object is not used. There is no harm in keeping the client activation object, but it can also safely be deleted.

-   Unlike using KMS, you do not need to meet any threshold limits before clients or servers can be activated.

The following are additional planning considerations for Active Directory\-based Activation.

### Using Active Directory\-based Activation in mixed Windows activation environments
Many organizations have elaborate volume license infrastructures to support KMS and Office installations. To add Active Directory\-based Activation to these environments, administrators must assess their current implementations and determine what role Active Directory\-based Activation will play in the environment.

Some considerations include how to upgrade these operating systems and applications to versions that support Active Directory\-based Activation.

For environments that will run [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], or newer client or server operating systems exclusively, Active Directory\-based Activation is a suitable option for activating all clients and servers, and you may be able to remove any KMS hosts from your environment.

If an environment will continue to contain earlier volume\-licensed operating systems and applications, administrators need a KMS host to maintain activation status for earlier volume\-licensed editions of Windows and Office in addition to enabling Active Directory\-based Activation for [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] \(or newer\) clients.

### Using Active Directory\-based Activation failover capability
There can also be advantages to maintaining more than one activation method for your environment. To understand why, consider what happens when clients need to be reactivated. The activation status of clients that are joined to the domain and activated with Active Directory\-based Activation lasts for 180 days. When a reactivation event occurs on an installation, the client queries AD DS for the activation object. Client systems examine the activation object and compare it to the local edition as defined by the GVLK. If the object and GVLK match, reactivation occurs.

If the AD DS object is not reachable, clients attempt to use activation methods in the following order:

1.  Active Directory\-based Activation

2.  KMS activation

3.  MAK activation

If an installation was previously activated, a successful activation event will reset the activation period to 180 days. If an activation attempt fails, activation will be attempted every seven days by default until reactivation is successful. If the full 180\-day activation period expires, the activation fails, a notification is displayed to the user, and an event is logged in the Windows Application Event Log.

If Active Directory\-based Activation is not available, computers that were originally activated by using Active Directory\-based Activation attempt to use KMS activation, and they continue to do so until the activation is successful. The next time the computer attempts to reactivate, the client first attempts to use Active Directory\-based Activation. If that attempt is successful, the client is again based on Active Directory\-based Activation.

Computers that are no longer members of a domain will fail activation when the computer or Software Protection service are restarted.

## 1.2 Plan for Key Management Services activation
The following information outlines initial planning considerations that you need to review for Key Management Services \(KMS\) activation.

KMS uses a client\-server model to active clients. KMS clients connect to a KMS server, called the KMS host, for activation. The KMS host must reside on your local network.

KMS hosts do not need to be dedicated servers, and KMS can be cohosted with other services. You can run a KMS host on any physical or virtual system that is running [!INCLUDE[winthreshold_client_2](includes/winthreshold_client_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], Windows Server 2008 R2, Windows Server 2008, Windows 7, or Windows Vista SP1 or SP2.

A KMS host running on [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], Windows 7, or Windows Vista can only activate computers running client operating systems.

The following table summarizes KMS host and client requirements for networks that include [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] \(or newer\) clients.

|Product key group|KMS can be hosted on **Note:** Updates might be required on the KMS server to support activation of any of these newer clients. If you receive activation errors, check that you have the appropriate updates listed below this table.|Windows editions activated by this KMS host|
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
|Volume license for [!INCLUDE[winthreshold_client_2](includes/winthreshold_client_2_md.md)]|Windows 7<br /><br />[!INCLUDE[win8_client_2](includes/win8_client_2_md.md)]<br /><br />[!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)]<br /><br />[!INCLUDE[winthreshold_client_2](includes/winthreshold_client_2_md.md)]|Windows 10 Professional<br /><br />Windows 10 Professional N<br /><br />Windows 10 Enterprise<br /><br />Windows 10 Enterprise N<br /><br />Windows 10 Education<br /><br />Windows 10 Education N<br /><br />Windows 10 Enterprise LTSB<br /><br />Windows 10 Enterprise LTSB N<br /><br />Windows 8.1 Professional<br /><br />Windows 8.1 Enterprise<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|
|Volume license for "Windows Server 2012 R2 for Windows 10"|Windows Server 2008 R2<br /><br />[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] Standard<br /><br />[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] Datacenter<br /><br />[!INCLUDE[winblue_server_standard_2](includes/winblue_server_standard_2_md.md)]<br /><br />[!INCLUDE[winblue_server_datacenter_2](includes/winblue_server_datacenter_2_md.md)]|Windows 10 Professional<br /><br />Windows 10 Enterprise<br /><br />Windows Server 2012 R2 \(all editions\)<br /><br />Windows 8.1 Professional<br /><br />Windows 8.1 Enterprise<br /><br />Windows Server 2012 \(all editions\)<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 2008 R2 \(all editions\)<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows 2008 \(all editions\)<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|
|Volume license for [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)]|Windows Vista<br /><br />Windows 7<br /><br />[!INCLUDE[win8_client_2](includes/win8_client_2_md.md)]<br /><br />[!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)]|[!INCLUDE[winblue_client_ent_2](includes/winblue_client_ent_2_md.md)]<br /><br />[!INCLUDE[winblue_client_pro_2](includes/winblue_client_pro_2_md.md)]<br /><br />[!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] Professional<br /><br />[!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] Enterprise<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|
|Volume license for [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]|Windows Server 2008<br /><br />Windows Server 2008 R2<br /><br />[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] Standard<br /><br />[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] Datacenter<br /><br />[!INCLUDE[winblue_server_standard_2](includes/winblue_server_standard_2_md.md)]<br /><br />[!INCLUDE[winblue_server_datacenter_2](includes/winblue_server_datacenter_2_md.md)]|[!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] \(all editions\)<br /><br />[!INCLUDE[winblue_client_ent_2](includes/winblue_client_ent_2_md.md)]<br /><br />[!INCLUDE[winblue_client_pro_2](includes/winblue_client_pro_2_md.md)]<br /><br />[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] \(all editions\)<br /><br />[!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] Professional<br /><br />[!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] Enterprise<br /><br />Windows 2008 \(all editions\)<br /><br />Windows 2008 R2 \(all editions\)<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|

> [!NOTE]
> Depending on which operating system your KMS server is running and which operating systems you want to activate, you might need to install one or more of these updates:
> 
> -   Installations of KMS on Windows Vista, Windows 7, Windows Server 2008, or Windows Server 2008 R2 must be updated in order to support activation of clients running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], or newer client or server operating systems. For more information, see [Update adds support for Windows 8 and Windows Server 2012 to Windows Server 2008, Windows 7, and Windows Server 2008 R2 KMS hosts](http://support.microsoft.com/kb/2757817).
> -   Installations of KMS on Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows 8, and Windows Server 2012 must be updated to enable enterprise licensing of Windows 8.1 and Windows Server 2012 R2. Install this update: [Update adds support for Windows 8.1 and Windows Server 2012 R2 clients to Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows 8, and Windows Server 2012 KMS hosts](https://support.microsoft.com/kb/2885698) .
> -   Installations of KMS on Windows Server 2012, Windows 8, or Windows 8.1 must be updated to support activation of clients running Windows 10 with this update:  Update that enables [Windows 8.1 and Windows 8 KMS hosts to activate Windows 10](https://support.microsoft.com/en-us/kb/3058168).
> -   Windows Server 2003 cannot be updated to support activation of clients running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], or newer operating systems.

A single KMS host can support an unlimited number of KMS clients. If you have more than 25 clients, we recommend that you have at least two KMS hosts in case one of your KMS hosts becomes unavailable. Most organizations can operate with as few as two KMS hosts for their entire infrastructure.

### Addressing KMS operational requirements
KMS can activate physical and virtual computers, but to qualify for KMS activation, a network must have a minimum number of computers \(called the activation threshold\). KMS clients activate only after this threshold is met. To ensure that the activation threshold is met, a KMS host counts the number of computers that are requesting activation on the network.

KMS hosts count the most recent connections. When a client or server contacts the KMS host, the host adds the machine ID to its count and then returns the current count value in its response. The client or server will activate if the count is high enough. Clients will activate if the count is 25 or higher. Servers and volume editions of Microsoft Office products will activate if the count is five or greater. The KMS only counts unique connections from the past 30 days, and only stores the 50 most recent contacts.

KMS activations are valid for 180 days, a period known as the activation validity interval. KMS clients must renew their activation by connecting to the KMS host at least once every 180 days to stay activated. By default, KMS client computers attempt to renew their activation every seven days. After a client’s activation is renewed, the activation validity interval begins again.

### Addressing KMS functional requirements
KMS activation requires TCP\/IP connectivity. KMS hosts and clients are configured by default to use Domain Name System \(DNS\). By default, KMS hosts use DNS dynamic update  to automatically publish the information that KMS clients need to find and connect to them. You can accept these default settings, or if you have special network and security configuration requirements, you can manually configure KMS hosts and clients.

After the first KMS host is activated, the KMS key that is used on the first host can be used to activate up to five more KMS hosts on your network. After a KMS host is activated, administrators can reactivate the same host up to nine times with the same key.

If your organization needs more than six KMS hosts, you should request additional activations for your organization’s KMS key—for example, if you have ten physical locations under one volume licensing agreement and you want each location to have a local KMS host.

> [!NOTE]
> To request this exception, contact your Activation Call Center. For more information, see [Microsoft Volume Licensing](http://go.microsoft.com/fwlink/?LinkID=73076).

Computers that are running volume licensing editions of [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], Windows 7, Windows Server 2008 R2, Windows Vista, and Windows Server 2008 are, by default, KMS clients with no additional configuration needed.

If you are converting a computer from a KMS host, MAK, or retail edition of Windows to a KMS client, install the applicable KMS Client Setup Key. For more information, see [Appendix A: KMS Client Setup Keys](Appendix-A--KMS-Client-Setup-Keys.md).

KMS clients can locate a KMS host automatically by querying DNS for SRV records that publish the KMS service. If your network environment uses a nonstandard DNS configuration or complex DNS zoning, an administrator must manually configure a KMS client to use a specific KMS host. For more information, see [Configuring KMS Clients](http://technet.microsoft.com/library/ff793406.aspx).

## 1.3 Plan for Multiple Activation Key activation
The following information outlines initial considerations that you need to review for Multiple Activation Key \(MAK\) activation.

MAK is used for a one\-time activation with activation services that are hosted by Microsoft. Each MAK key has a predetermined number of allowed activations. This number is based on your volume licensing agreements, and it does not match your organization’s exact license count. Each activation that uses a MAK with activation services that are hosted by Microsoft counts towards the activation limit.

A MAK activation is recommended for computers that rarely or never connect to the corporate network and for environments where the number of physical computers that need activation does not meet the KMS activation threshold.

> [!NOTE]
> Computers running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or newer operating systems can be converted from Active Directory\-based Activation or KMS activation to MAK activation at any time. For information, see [Converting KMS Clients to MAK Activation](http://technet.microsoft.com/library/ff793408.aspx).

There are two ways to activate computers by using MAK:

-   **MAK Independent**: MAK Independent activation requires that each computer independently connect and activate with Microsoft over the Internet or by telephone. MAK Independent activation is best suited for computers within an organization that do not maintain a connection to the corporate network.

-   **MAK Proxy**: MAK Proxy activation enables a centralized activation request on behalf of multiple computers with one connection to Microsoft. MAK Proxy activation is configured by using the Volume Activation Management Tool \(VAMT\). MAK Proxy activation is appropriate for environments where security concerns can restrict direct access to the Internet or the corporate network. It is also suited for development and test labs that lack this connectivity.

    > [!NOTE]
    > VAMT is a standalone application that collects activation requests from several systems then sends them, in bulk, to Microsoft. For more information, see [Volume Activation Management Tool \(VAMT\) Overview](http://go.microsoft.com/fwlink/?LinkId=214550).

MAK can be used for individual computers or with an image that can be duplicated or provided for download by using Microsoft deployment solutions. MAK can also be used on a computer that was originally configured to use KMS activation, if that computer’s activation is about to or has reached the end of its activation validity interval.

## <a name="BKMK_Links"></a>See also

-   [Step 2: Evaluate Client Connectivity](Step-2--Evaluate-Client-Connectivity.md)

-   [Plan for Volume Activation](Plan-for-Volume-Activation.md)

-   [Volume Activation Overview](Volume-Activation-Overview.md)

-   [Test Lab Guide: Demonstrate Volume Activation Services](Test-Lab-Guide--Demonstrate-Volume-Activation-Services.md)


