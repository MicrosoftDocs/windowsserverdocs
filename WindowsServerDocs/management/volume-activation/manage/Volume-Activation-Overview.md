---
title: Volume Activation Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 86ca2bc5-fa91-4a97-b7c9-443a6d30a126
author: jaimeo
---
# Volume Activation Overview
This technical overview for the IT professional describes the volume activation technologies in Windows operating systems and how your organization can benefit from using these technologies to deploy and manage volume licenses for a medium to large number of computers.  
  
**Did you mean…**  
  
-   [Volume Activation for Windows 7 and Windows Server 2008 R2](http://go.microsoft.com/fwlink/?LinkId=242232)  
  
-   [Microsoft Product Activation](http://go.microsoft.com/fwlink/?LinkId=242233) \(Information about end\-user licensing and how to license individual copies of Windows that are purchased at retail locations\)  
  
-   [Remote Desktop Licensing Manager](http://go.microsoft.com/fwlink/?LinkId=242235)  
  
## Volume activation description  
A number of technologies are available in Windows client and server operating systems to simplify the task of configuring the distribution and management of an organization’s volume software licenses. These technologies include:  
  
-   **The Volume Activation Services server role** Volume Activation Services is a server role Windows Server starting with [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] that enables you to automate and simplify the issuance and management of Microsoft software volume licenses for a variety of scenarios and environments. With Volume Activation Services, you can install and configure the Key Management Service \(KMS\) and enable Active Directory\-based Activation.  
  
-   **Key Management Service \(KMS\)** KMS is a role service that allows organizations to activate systems within their network from a server where a KMS host has been installed. With KMS, IT pros can complete activations on their local network, eliminating the need for individual computers to connect to Microsoft for product activation. KMS does not require a dedicated system, and it can be cohosted on a system that provides other services. By default, volume editions of Windows client and server operating systems connect to a system that hosts the KMS service to request activation. No action is required from the user.  
  
-   **Active Directory\-based Activation** Active Directory\-based Activation is a role service that allows you to use Active Directory Domain Services \(AD DS\) to store activation objects, which can further simplify the task of maintaining volume activation services for a network. With Active Directory\-based Activation, no additional host server is needed, and activation requests are processed during computer startup.  
  
    Any computers running a client or server operating system with a Generic Volume License Key \(GVLK\) that are connected to the domain will activate automatically and transparently. They will stay activated as long as they remain members of the domain and maintain periodic contact with a domain controller. Activation takes place after the licensing service starts. When this service starts, the computer running a Windows client or server operating system contacts AD DS automatically, receives the activation object, and activates without user intervention.  
  
    > [!NOTE]  
    > AD DS must be at the schema level of [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or newer to store activation objects. Domain controllers running earlier versions of Windows Server can activate clients after their schemas have been updated using the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] version of Adprep.exe. For more information, see [Running Adprep.exe](http://technet.microsoft.com/library/dd464018.aspx).  
  
-   **Volume Activation Tools console** The Volume Activation Tools snap\-in is installed with KMS and Active\-Directory–based Activation. You can use the Volume Activation Tools console to install, activate, and manage one or more volume activation license keys in AD DS or on a KMS host.  
  
Other Microsoft volume activation technologies that can be used in conjunction with Windows server operating systems include:  
  
-   **Volume Activation Management Tool \(VAMT\)** The VAMT is a free downloadable MMC snap\-in that is included in the Windows Assessment and Deployment Kit \(ADK\) that enables network administrators and other IT professionals to automate and centrally manage the Windows and Microsoft Office volume and retail activation process. VAMT can manage volume activation by using Multiple Activation Keys \(MAKs\) or the Windows Key Management Service \(KMS\).  
  
    VAMT 3.0 includes all the major functionality of the previously released versions of VAMT, and it includes an improved interface, data storage in a SQL Server database for greater scalability and speed, new reporting options, the ability to use Windows PowerShell cmdlets, and new context\-sensitive Help. In addition, VAMT 3.0 supports Active Directory\-based Activation in addition to KMS and MAK activation. VAMT version 3.1 is included in the Windows ADK. For more information about VAMT, see [Volume Activation Management Tool \(VAMT\) Technical Reference](http://technet.microsoft.com/library/hh824825.aspx), and [VAMT How\-To Topics](http://technet.microsoft.com/library/hh824887.aspx)  
  
-   **Multiple Activation Key \(MAK\)** A MAK is a volume license key that is used for one\-time activation with activation services that are hosted by Microsoft. There are two ways to use MAK to activate computers:  
  
    -   **MAK independent activation** Each computer must independently connect and be activated by Microsoft over the Internet or by telephone.  
  
    -   **MAK proxy activation** A computer that is acting as a MAK proxy gathers activation information from multiple computers on the network, and then sends a centralized activation request to Microsoft on their behalf. MAK proxy activation is configured by using the Volume Activation Management Tool \(VAMT\).  
  
-   **Automatic Virtual Machine Activation** AVMA lets you install virtual machines on a properly activated Windows server without having to manage product keys for each individual virtual machine, even in disconnected environments. There are no product keys to manage and no stickers on the servers to read. The virtual machine is activated and continues to work even when it is migrated across an array of virtualization servers. AVMA only requires a virtualization server running Windows Server 2012 R2 Datacenter. The guest virtual machine operating system must be Windows Server 2012 R2 Datacenter, Windows Server 2012 R2 Standard, or Windows Server 2012 R2 Essentials. For more details about AVMA, see [Automatic Virtual Machine Activation](Automatic-Virtual-Machine-Activation.md).  
  
### How does volume activation work?  
Before you configure and use volume activation technologies, it may be helpful to understand how volume activation works.  
  
In an environment that is using a KMS host, the volume activation process is as follows:  
  
1.  KMS is installed on a server.  
  
2.  The KMS host key is installed on the KMS host, and then activated by contacting the hosted activation services at Microsoft.  
  
3.  After the KMS is enabled, it registers an SRV record in Domain Name System \(DNS\) each time KMS is started or once per day.  
  
4.  A KMS client computer discovers the KMS host from a configured registry entry or through the KMS SRV record in DNS.  
  
5.  The client sends an RPC request to the KMS host on 1688\/TCP \(the default setting\). This request includes an encrypted client computer ID. If the computer has never been activated and there is no response from the KMS host, the client sends a new request after two hours. If the computer has been activated, the client sends a new reactivation request after seven days.  
  
6.  The KMS host adds the client computer ID to a table and returns the activation count to the client.  
  
7.  The client evaluates the activation count against the license policy and activates if the activation threshold is met.  
  
    > [!NOTE]  
    > KMS maintains an activation threshold, which requires that the organization activate at least five computers \(physical or virtual machines\) running a server operating system with [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or later and at least 25 client computers running [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or later. The computers running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] must connect within a 30\-day period to active KMS client computers.  
  
In an environment that is using Active Directory\-based Activation, the volume activation process is as follows:  
  
1.  A user with Enterprise Administrator permissions installs the Active Directory\-based Activation role service on a domain controller, including the KMS host key, and then activates the KMS host key with the activation services that are hosted by Microsoft.  
  
    > [!NOTE]  
    > This installation can be completed from any computer where the Volume Activation Tools console is installed.  
  
2.  When a domain\-joined computer running Windows with a GVLK starts, the licensing service on the client automatically queries the domain controller for licensing information.  
  
    > [!NOTE]  
    > Active Directory\-based Activation cannot be used to license computers that are not members of the domain.  
  
3.  If a valid activation object is found, activation proceeds silently without user intervention. The same renewal guidelines apply to Active Directory\-based Activation as to KMS activation.  
  
    > [!NOTE]  
    > If volume license information is not found in AD DS, clients running Windows look for a KMS host, and then attempt activation by following the KMS activation process.  
  
If Active Directory\-based Activation or KMS activation are not options \(such as to license computers in remote locations\), MAK keys can be distributed as part of an operating system image. This is done through WMI script and the change product key wizard, or by using VAMT. After a MAK is installed, each client needs to connect to Microsoft individually over the Internet or by telephone to complete activation.  
  
A second MAK validation option is available for client computers that are not connected to the Internet, such as in remote or highly secured environments. In MAK Proxy activation, VAMT installs a MAK product key on a client computer, obtains the installation ID \(IID\) from the target computer, sends the IID to Microsoft on behalf of the client, and obtains a confirmation ID \(CID\). The tool then activates the client computer by installing the CID.  
  
## Practical applications  
Validating the licenses and activating tens, hundreds, or thousands of computers in multiple locations is an important network administration task. By doing so, you verify that operating systems and applications are genuine, have not been compromised, and will be supported. Volume Activation Services in can help you accomplish these tasks.  
  
The following are common licensing and activation\-related questions.  
  
### What is activation?  
Product activation is the process of validating software with the manufacturer. Activation confirms the genuine status of a product and that the product key has not been compromised. It establishes a relationship between the software’s product key and a particular installation of that software on a device. In earlier versions of the Windows operating system, activation and validation \(using the Windows Genuine tool\) occurred separately. This caused confusion for users who thought the terms were interchangeable. In Windows operating systems starting with [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], activation and validation occur at the same time.  
  
### What are my activation options?  
For released versions of Windows client and server operating systems, licenses can be obtained through the following channels:  
  
-   **Retail** Microsoft software products that are acquired through a retail store are individually licensed and come with one unique product key \(printed on the product packaging\), which the user enters during product installation. The computer uses this product key to complete activation after the software installation is complete. This final activation step can be accomplished online or by telephone.  
  
-   **Original equipment manufacturer \(OEM\)** Most OEMs sell systems that include a standard build of Windows and other software. OEM activation is performed by associating the operating system to the firmware of the computer. This process occurs before the computer is sent to the customer so that the software is already activated and no additional actions are required by the user. OEM activation remains valid as long as the customer uses the OEM\-provided image on the computer. If customers want to create customized images, they can use the image provided by the OEM as the basis for creating custom images.  
  
-   **Volume licensing** A volume license is a product key that allows an organization to activate a specific number of clients to use a particular piece of software. Microsoft Volume Licensing offers customized programs that are tailored to the size and purchasing preference of a variety of organizations. To become a volume licensing customer, the organization needs to set up a volume license agreement with Microsoft.  
  
### What happens if systems are not activated?  
Activation is designed to be relatively transparent to users. However, the operating system must be activated immediately upon installation. Failure to activate the Windows operating systems will prevent users from completing customization.  
  
### When should I use volume activation?  
Customers can use one or all three of the volume activation scenarios described earlier \(KMS, Active Directory\-based activation, or MAK\) to activate systems in their environments.  
  
-   **When to use the Key Management Service \(KMS\)**: KMS is the default key for volume activation clients, regardless of the Windows version they are running. If you have a network where multiple versions of Windows client and server operating systems are deployed, you will probably want to use KMS to activate them.  
  
    > [!IMPORTANT]  
    > Installations of KMS on Windows 7 SP1 or Windows Server 2008 R2 SP1 must be updated in order to support activation of clients running operating systems starting with [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. For more information, see [An update that adds support for Windows 8 and for Windows Server 2012 to Windows Vista, Windows Server 2008, Windows 7, and Windows Server 2008 R2 KMS hosts is available](http://support.microsoft.com/kb/2757817).  
  
    KMS enables organizations to activate systems within their network, eliminating the need for individual computers to connect to Microsoft for product activation.  
  
    To use KMS activation, the computer must have the qualifying operating system license \(often obtained through OEMs as part of a new computer purchase\), and they must contain a Windows marker in the BIOS.  
  
-   **When to use Active Directory\-based Activation**: Active Directory\-based Activation simplifies the process of activating clients that are running an operating system starting with [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. In addition, it requires the AD DS schema of [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or later.  
  
    Activation objects themselves are not editable. However, an administrator with proper permissions can use advanced AD DS tools to view each activation object and to configure security access control lists \(ACLs\) for the activation objects to restrict access as needed. Administrators can delete activation objects, if necessary. On a local client, a user can use the command line to perform these functions if they have Write access to the activation object.  
  
-   **When to use Multiple Activation Key \(MAK\)**: Not all of an organization’s computers are conveniently located on the organization’s networks. Computers may be laptops that are in the possession of employees who travel frequently, may be located in branch offices that do not have good connectivity to the host network, or may be part of extremely secure networks that are disconnected from the main network. You can use MAK to activate these clients.  
  
    > [!NOTE]  
    > For more information about configuring and using MAK activation, see the [Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=150083)  
  
## System requirements  
Volume activation services can be installed and used on any computer running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or later operating system.  
  
Active Directory\-based Activation requires that AD DS be at the schema level of [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or later in order to store activation objects. Domain controllers that are running earlier versions of Windows Server can activate clients after their schemas have been updated using the [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] version of Adprep.exe.  
  
KMS can be installed by using the Server Manager on any computer running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or later operating system. It can also be installed from the command line and used on computers running earlier versions of Windows Server.  
  
KMS can be used to activate computers running any version of Windows that can be a member of a domain.  
  
## Additional information  
  
|Resource|Windows Server 2008 R2 and Windows 7|[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)]|  
|------------|----------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|  
|Product evaluation||[Test Lab Guide: Demonstrate Volume Activation Services](Test-Lab-Guide--Demonstrate-Volume-Activation-Services.md)|  
|Procedures|[Volume Activation Operations Guide](http://go.microsoft.com/fwlink/?LinkId=150084)||  
|Technical content|[Volume Activation Technical Reference Guide](http://go.microsoft.com/fwlink/?LinkId=152550)||  
|Design, planning and deployment|[Volume Activation Planning Guide](http://go.microsoft.com/fwlink/?LinkId=155926)<br /><br />[Volume Activation Deployment Guide](http://go.microsoft.com/fwlink/?LinkId=150083)|[Plan for Volume Activation](Plan-for-Volume-Activation.md)|  
|Troubleshooting|[Solutions to Common Volume Activation Errors](http://go.microsoft.com/fwlink/?LinkId=242312)||  
|General information and additional resources|[Volume Activation Management Tool \(VAMT\) Overview](http://go.microsoft.com/fwlink/?LinkId=214550)|[Plan volume activation of Office 2013 Preview](http://technet.microsoft.com/library/ee624358(v=office.15))<br /><br />[Volume activation methods in Office 2013 Preview](http://technet.microsoft.com/library/jj219430(v=office.15))|  
  

