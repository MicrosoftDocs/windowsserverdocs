---
title: Step 1: Review and select Activation Methods
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec4bf97d-9e46-4fb7-a81a-8be8d72d86d5
author: jaimeo
---
# Step 1: Review and select Activation Methods
The first step in planning for volume Activation services in Windows starting with  Windows Server 2012  is to evaluate the features and deployment models that are available for activating client computers. When you understand the differences between and advantages of these features and deployment models, move to [Step 2: Evaluate Client Connectivity](step-2-evaluate-client-connectivity.md) and use this information to assess the types of network and clients that you have. Then move to [Step 3: Determine Activation Method and Product License Requirements](step-3-determine-activation-method-product-license-requirements.md) to identify which solution is best for each group of clients.  
  
The volume Activation server role in Windows Server provides three methods for implementing volume activation. You can use one, two, or all three methods of volume activation. The methods you choose will depend on the size, network infrastructure, connectivity, and security requirements of your organization. The following table highlights these methods.  
  
|Task|Description|  
|--------|---------------|  
|1.1. plan for active directory\-based Activation|Identify and resolve key planning issues that are associated with active directory\-based Activation.|  
|1.2. plan for Key management Services \(KMS\) activation|Identify and resolve key planning issues that are associated with KMS activation.|  
|1.3. plan for Multiple Activation Key \(MAK\) activation|Identify and resolve key planning issues that are associated with MAK activation.|  
  
When you understand your volume activation options, you choose the right combination of methods to meet your organization’s needs.  
  
## 1.1 plan for active directory\-based Activation  
active directory\-based Activation is a role service that allows you to use active directory Domain Services \(AD DS\) to store activation objects, which can greatly simplify the task of maintaining volume activation services for a network.  
  
With active directory\-based Activation, any computers running operating systems starting with Windows 8 or  Windows Server 2012  with a KMS client setup key \(GVLK\) that are connected to the domain will activate automatically and transparently during computer startup. These clients stay activated as long as they remain members of the domain and maintain periodic contact with a domain controller.  
  
Activation takes place after the Software Protection service starts. When the Software Protection service starts, the computer contacts AD DS automatically, receives the activation object, and activates without user intervention.  
  
The following are planning considerations when working with active directory\-based Activation:  
  
-   With active directory\-based Activation, you do not need an additional host server; your existing domain controllers can support activation clients, with the following limitations:  
  
    -   active directory\-based Activation cannot be configured on read\-only domain controllers.  
  
    -   active directory\-based Activation cannot be used with non\-Microsoft directory services.  
  
    -   AD DS must be at the  Windows Server 2012  schema level to store activation objects. Domain controllers running earlier versions of Windows Server can activate clients after their schemas have been updated using the  Windows Server 2012  version of Adprep.exe. for more information, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018(v=WS.10).aspx).  
  
        > [!NOTE]  
        > for  Windows Server 2012 R2 , you do not have to run Adprep.exe again; the  Windows Server 2012  schema level is adequate.  
  
-   You only need one activation object forest.  
  
    > [!NOTE]  
    > When the client and server KMS host keys are activated within an environment, two activation objects will exist in the forest. In this case, the activation object on the server activates computers running Windows 8 or  Windows Server 2012  within the forest and the client activation object is not used. There is no harm in keeping the client activation object, but it can also safely be deleted.  
  
-   Unlike using KMS, you do not need to meet any threshold limits before clients or servers can be activated.  
  
The following are additional planning considerations for active directory\-based Activation.  
  
### Using active directory\-based Activation in mixed Windows activation environments  
Many organizations have elaborate volume license infrastructures to support KMS and Office installations. To add active directory\-based Activation to these environments, administrators must assess their current implementations and determine what role active directory\-based Activation will play in the environment.  
  
Some considerations include how to upgrade these operating systems and applications to versions that support active directory\-based Activation.  
  
for environments that will run Windows 8,  Windows Server 2012 , or newer client or server operating systems exclusively, active directory\-based Activation is a suitable option for activating all clients and servers, and you may be able to remove any KMS hosts from your environment.  
  
if an environment will continue to contain earlier volume\-licensed operating systems and applications, administrators need a KMS host to maintain activation status for earlier volume\-licensed editions of Windows and Office in addition to enabling active directory\-based Activation for Windows 8 and  Windows Server 2012  \(or newer\) clients.  
  
### Using active directory\-based Activation failover capability  
There can also be advantages to maintaining more than one activation method for your environment. To understand why, consider what happens when clients need to be reactivated. The activation status of clients that are joined to the domain and activated with active directory\-based Activation lasts for 180 days. When a reactivation event occurs on an installation, the client queries AD DS for the activation object. Client systems examine the activation object and compare it to the local edition as defined by the GVLK. if the object and GVLK match, reactivation occurs.  
  
if the AD DS object is not reachable, clients attempt to use activation methods in the following order:  
  
1.  active directory\-based Activation  
  
2.  KMS activation  
  
3.  MAK activation  
  
if an installation was previously activated, a successful activation event will reset the activation period to 180 days. if an activation attempt fails, activation will be attempted every seven days by default until reactivation is successful. if the full 180\-day activation period expires, the activation fails, a notification is displayed to the user, and an event is logged in the Windows Application Event Log.  
  
if active directory\-based Activation is not available, computers that were originally activated by using active directory\-based Activation attempt to use KMS activation, and they continue to do so until the activation is successful. The next time the computer attempts to reactivate, the client first attempts to use active directory\-based Activation. if that attempt is successful, the client is again based on active directory\-based Activation.  
  
computers that are no longer members of a domain will fail activation when the computer or Software Protection service are restarted.  
  
## 1.2 plan for Key management Services activation  
The following information outlines initial planning considerations that you need to review for Key management Services \(KMS\) activation.  
  
KMS uses a client\-server model to active clients. KMS clients connect to a KMS server, called the KMS host, for activation. The KMS host must reside on your local network.  
  
KMS hosts do not need to be dedicated servers, and KMS can be cohosted with other services. You can run a KMS host on any physical or virtual system that is running Windows 10,  Windows Server 2012 , Windows 8, Windows Server 2008 R2, Windows Server 2008, Windows 7, or Windows Vista SP1 or SP2.  
  
A KMS host running on Windows 8, Windows 7, or Windows Vista can only activate computers running client operating systems.  
  
The following table summarizes KMS host and client requirements for networks that include  Windows Server 2012  and Windows 8 \(or newer\) clients.  
  
|Product key group|KMS can be hosted on **Note:** Updates might be required on the KMS server to support activation of any of these newer clients. if you receive activation errors, check that you have the appropriate updates listed below this table.|Windows editions activated by this KMS host|  
|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|  
|volume license for Windows 10|Windows 7<br /><br />Windows 8<br /><br />Windows 8.1<br /><br />Windows 10|Windows 10 Professional<br /><br />Windows 10 Professional N<br /><br />Windows 10 Enterprise<br /><br />Windows 10 Enterprise N<br /><br />Windows 10 Education<br /><br />Windows 10 Education N<br /><br />Windows 10 Enterprise LTSB<br /><br />Windows 10 Enterprise LTSB N<br /><br />Windows 8.1 Professional<br /><br />Windows 8.1 Enterprise<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|  
|volume license for "Windows Server 2012 R2 for Windows 10"|Windows Server 2008 R2<br /><br /> Windows Server 2012  Standard<br /><br /> Windows Server 2012  Datacenter<br /><br />Windows Server 2012 R2 Standard<br /><br />Windows Server 2012 R2 Datacenter|Windows 10 Professional<br /><br />Windows 10 Enterprise<br /><br />Windows Server 2012 R2 \(all editions\)<br /><br />Windows 8.1 Professional<br /><br />Windows 8.1 Enterprise<br /><br />Windows Server 2012 \(all editions\)<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 2008 R2 \(all editions\)<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows 2008 \(all editions\)<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|  
|volume license for Windows 8.1|Windows Vista<br /><br />Windows 7<br /><br />Windows 8<br /><br />Windows 8.1|Windows 8.1 Enterprise<br /><br />Windows 8.1 Pro<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|  
|volume license for  Windows Server 2012 R2 |Windows Server 2008<br /><br />Windows Server 2008 R2<br /><br /> Windows Server 2012  Standard<br /><br /> Windows Server 2012  Datacenter<br /><br />Windows Server 2012 R2 Standard<br /><br />Windows Server 2012 R2 Datacenter| Windows Server 2012 R2  \(all editions\)<br /><br />Windows 8.1 Enterprise<br /><br />Windows 8.1 Pro<br /><br /> Windows Server 2012  \(all editions\)<br /><br />Windows 8 Professional<br /><br />Windows 8 Enterprise<br /><br />Windows 2008 \(all editions\)<br /><br />Windows 2008 R2 \(all editions\)<br /><br />Windows 7 Professional<br /><br />Windows 7 Enterprise<br /><br />Windows Vista Business<br /><br />Windows Vista Enterprise|  
  
> [!NOTE]  
> Depending on which operating system your KMS server is running and which operating systems you want to activate, you might need to install one or more of these updates:  
>   
> -   Installations of KMS on Windows Vista, Windows 7, Windows Server 2008, or Windows Server 2008 R2 must be updated in order to support activation of clients running Windows 8,  Windows Server 2012 , or newer client or server operating systems. for more information, see [Update adds support for Windows 8 and Windows Server 2012 to Windows Server 2008, Windows 7, and Windows Server 2008 R2 KMS hosts](http://support.microsoft.com/kb/2757817).  
> -   Installations of KMS on Windows Vista, Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows 8, and Windows Server 2012 must be updated to enable enterprise licensing of Windows 8.1 and Windows Server 2012 R2. Install this update: [Update adds support for Windows 8.1 and Windows Server 2012 R2 clients to Windows Server 2008, Windows 7, Windows Server 2008 R2, Windows 8, and Windows Server 2012 KMS hosts](https://support.microsoft.com/kb/2885698) .  
> -   Installations of KMS on Windows Server 2012, Windows 8, or Windows 8.1 must be updated to support activation of clients running Windows 10 with this update:  Update that enables [Windows 8.1 and Windows 8 KMS hosts to activate Windows 10](https://support.microsoft.com/en-us/kb/3058168).  
> -   Windows Server 2003 cannot be updated to support activation of clients running Windows 8,  Windows Server 2012 , or newer operating systems.  
  
A single KMS host can support an unlimited number of KMS clients. if you have more than 25 clients, we recommend that you have at least two KMS hosts in case one of your KMS hosts becomes unavailable. Most organizations can operate with as few as two KMS hosts for their entire infrastructure.  
  
### addressing KMS operational requirements  
KMS can activate physical and virtual computers, but to qualify for KMS activation, a network must have a minimum number of computers \(called the activation threshold\). KMS clients activate only after this threshold is met. To ensure that the activation threshold is met, a KMS host counts the number of computers that are requesting activation on the network.  
  
KMS hosts count the most recent connections. When a client or server contacts the KMS host, the host adds the machine ID to its count and then returns the current count value in its response. The client or server will activate if the count is high enough. Clients will activate if the count is 25 or higher. Servers and volume editions of Microsoft Office products will activate if the count is five or greater. The KMS only counts unique connections from the past 30 days, and only stores the 50 most recent contacts.  
  
KMS activations are valid for 180 days, a period known as the activation validity interval. KMS clients must renew their activation by connecting to the KMS host at least once every 180 days to stay activated. By default, KMS client computers attempt to renew their activation every seven days. After a client’s activation is renewed, the activation validity interval begins again.  
  
### addressing KMS functional requirements  
KMS activation requires TCP\/IP connectivity. KMS hosts and clients are configured by default to use Domain Name System \(DNS\). By default, KMS hosts use DNS dynamic update  to automatically publish the information that KMS clients need to find and connect to them. You can accept these default settings, or if you have special network and security configuration requirements, you can manually configure KMS hosts and clients.  
  
After the first KMS host is activated, the KMS key that is used on the first host can be used to activate up to five more KMS hosts on your network. After a KMS host is activated, administrators can reactivate the same host up to nine times with the same key.  
  
if your organization needs more than six KMS hosts, you should request additional activations for your organization’s KMS key—for example, if you have ten physical locations under one volume licensing agreement and you want each location to have a local KMS host.  
  
> [!NOTE]  
> To request this exception, contact your Activation call Center. for more information, see [Microsoft volume Licensing](http://go.microsoft.com/fwlink/?LinkID=73076).  
  
computers that are running volume licensing editions of Windows 8.1,  Windows Server 2012 R2 , Windows 8,  Windows Server 2012 , Windows 7, Windows Server 2008 R2, Windows Vista, and Windows Server 2008 are, by default, KMS clients with no additional configuration needed.  
  
if you are converting a computer from a KMS host, MAK, or retail edition of Windows to a KMS client, install the applicable KMS Client Setup Key. for more information, see [appendix A: KMS Client Setup Keys](appendix-kms-client-setup-keys.md).  
  
KMS clients can locate a KMS host automatically by querying DNS for SRV records that publish the KMS service. if your network environment uses a nonstandard DNS configuration or complex DNS zoning, an administrator must manually configure a KMS client to use a specific KMS host. for more information, see [Configuring KMS Clients](http://technet.microsoft.com/library/ff793406.aspx).  
  
## 1.3 plan for Multiple Activation Key activation  
The following information outlines initial considerations that you need to review for Multiple Activation Key \(MAK\) activation.  
  
MAK is used for a one\-time activation with activation services that are hosted by Microsoft. Each MAK key has a predetermined number of allowed activations. This number is based on your volume licensing agreements, and it does not match your organization’s exact license count. Each activation that uses a MAK with activation services that are hosted by Microsoft counts towards the activation limit.  
  
A MAK activation is recommended for computers that rarely or never connect to the corporate network and for environments where the number of physical computers that need activation does not meet the KMS activation threshold.  
  
> [!NOTE]  
> computers running Windows 8 or  Windows Server 2012  or newer operating systems can be converted from active directory\-based Activation or KMS activation to MAK activation at any time. for information, see [converting KMS Clients to MAK Activation](http://technet.microsoft.com/library/ff793408.aspx).  
  
There are two ways to activate computers by using MAK:  
  
-   **MAK Independent**: MAK Independent activation requires that each computer independently connect and activate with Microsoft over the Internet or by telephone. MAK Independent activation is best suited for computers within an organization that do not maintain a connection to the corporate network.  
  
-   **MAK Proxy**: MAK Proxy activation enables a centralized activation request on behalf of multiple computers with one connection to Microsoft. MAK Proxy activation is configured by using the volume Activation management Tool \(VAMT\). MAK Proxy activation is appropriate for environments where security concerns can restrict direct access to the Internet or the corporate network. It is also suited for development and test labs that lack this connectivity.  
  
    > [!NOTE]  
    > VAMT is a standalone application that collects activation requests from several systems then sends them, in bulk, to Microsoft. for more information, see [volume Activation management Tool \(VAMT\) Overview](http://go.microsoft.com/fwlink/?LinkId=214550).  
  
MAK can be used for individual computers or with an image that can be duplicated or provided for download by using Microsoft deployment solutions. MAK can also be used on a computer that was originally configured to use KMS activation, if that computer’s activation is about to or has reached the end of its activation validity interval.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 2: Evaluate Client Connectivity](step-2-evaluate-client-connectivity.md)  
  
-   [plan for volume Activation]()  
  
-   [volume Activation Overview]()  
  
-   [Test Lab Guide: Demonstrate volume Activation Services](test-lab-guide-demonstrate-volume-activation-services.md)  
  

