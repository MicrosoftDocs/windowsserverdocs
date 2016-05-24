---
title: Planning Deployment of AD DS in the Perimeter Network
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: c87d59ee-8165-4b9a-a678-f6a3da3d3d55
author: Femila
---
# Planning Deployment of AD DS in the Perimeter Network
  This topic provides details to consider when you plan the deployment of Active Directory Domain Services \(AD DS\) in a perimeter network. These details include planning concerns and costs, different deployment models, and considerations for choosing an appropriate Active Directory deployment model.  
  
## AD DS models for the perimeter network  
 After you evaluate the considerations for deploying AD DS in your perimeter network, you can choose one or more of the following AD DS models.  
  
 After you read this guide, you may find that there is no benefit in including AD DS in your perimeter network or that other software or tools can provide all the benefits. If this is the case, it is possible that the best option is to not include AD DS in your perimeter network.  
  
 ![](../Image/Model1_NoAD.gif)  
  
 **Figure 1  Perimeter model with no AD DS**  
  
### No AD DS  
 One solution that you can implement in the perimeter network does not use AD DS. It uses the local server's Security Accounts Manager \(SAM\) database to authenticate corporate\-network\-owned identities. This solution, as shown in Figure 1, has the disadvantage of becoming very difficult to manage—even when there is a low number of users that are granted access to the server’s resources—because you must manage the appropriate identities on several local SAMs. Another disadvantage is that more modern authentication methods, such as the Kerberos protocol or certificates, are not available for local SAM authentication.  
  
 In addition, this solution has the limitation of not being able to share identities between the servers. It also has a limitation on the number of users that can be stored locally. Duplication of identities across different databases increases the solution’s total cost of ownership \(TCO\) and decreases the customer experience as a result of a lack of single\-sign\-on \(SSO\) functionality.  
  
### Isolated forest model  
 The isolated forest model provides the perimeter network with a dedicated deployment of AD DS. In this model, the forest in the perimeter network does not formally communicate with any forests in the internal network. The identities that are stored in this forest have meaning only inside the perimeter network solution, as shown in Figure 2.  
  
 ![](../Image/Model2_IsolatedForests.gif)  
  
 **Figure 2  Isolated forest model**  
  
 Consider this solution if your organization wants the manageability and security benefits that AD DS provides, but autonomy and isolation from any internal forests are also required. The Windows Server 2008 forest planning documentation explains the benefits of isolated forests. For more information, see Creating a Forest Design \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135966](http://go.microsoft.com/fwlink/?LinkId=135966)\).  
  
 Consider the use of an isolated forest in the perimeter in the following scenarios:  
  
-   A perimeter network in which SSO through Windows Integrated authentication between intranet\-owned identities and extranet resources is not required. However, because of the number of computers in the perimeter network, the centralized management capabilities that AD DS provides are desired.  
  
-   An application that provides services in the perimeter network requires AD DS. Microsoft Exchange Server is an example of an application that requires AD DS to function, regardless of whether the forest has trust relationships with other domains or forests.  
  
###  <a name="ext_corp_for_mod"></a> Extended corporate forest model  
 The solution that has an extended corporate forest in the perimeter places domain controllers—ideally, read\-only domain controllers \(RODCs\)—that belong to the corporate forest in the perimeter network. As shown in Figure 3, this model takes advantage of the benefits of a single forest while enabling the use of corporate identities in the perimeter network.  
  
 ![](../Image/Model3_ExtendCorpForest.gif)  
  
 **Figure 3  Extended corporate forest model**  
  
 This model allows corporate identities to access resources in the perimeter network from both the Internet and the corporate network—if there is connectivity between the two networks—without requiring multiple identity stores \(duplicating identities\) or having to set up trust relationships between internal forest and perimeter forest for authentication.  
  
 Most of the directory information that is stored in the corporate Active Directory infrastructure is accessible to domain\-joined computers or domain users in the perimeter network, as if they were accessing the directory on the internal network. This depends on the users being given appropriate permissions through access control lists \(ACLs\).  
  
 There are two variations of this model: One is to deploy writeable domain controllers from the corporate forest into the perimeter network. The second is to use RODCs. Because of the security and manageability benefits that are available with the RODC solution, this is the recommended model. However, if your current integrated application writes information to the directory, you might be blocked from using the new RODC role in the perimeter network. RODCs might also have application compatibility issues that require more planning and changes to your perimeter. More information about RODCs in the perimeter is provided later in this guide.  
  
### Forest trust model  
 The forest trust model is based on a forest that is deployed in the perimeter, like the isolated forest model. However, the forest trust model establishes Active Directory trusts with one or more forests in the internal network. In this design, a forest trust is established between the two forests to enable SSO scenarios for resource access and administration.  
  
 Figure 4 illustrates two forests—one forest in the internal network and the other forest in the perimeter network—with a trust between the two forests.  
  
 ![](../Image/Model4_ForestTrust.gif)  
  
 **Figure 4  Forest trust model**  
  
 This model helps reduce the exposure of corporate information in the perimeter network because directory information that is stored in one forest does not physically reside in the other forest. In addition, forest trusts can be unidirectional so that the perimeter network forest trusts the internal forest but not the other way around.  
  
 A drawback of this model is the increased administration costs of maintaining an extra forest and the added complexity of managing firewall rules for domain controllers and client computers crossing trust boundaries.  
  
 As a variation of this model, you can also use Active Directory Federation Services \(ADFS\) to create a federation with the perimeter forest. For more information, see the ADFS Deployment Guide. \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135967](http://go.microsoft.com/fwlink/?LinkId=135967)\).  
  
## Choosing the proper deployment scenario in the perimeter network  
 This section provides information to help you choose the correct AD DS deployment model for your perimeter network. The following table is a decision matrix that summarizes the advantages and disadvantages of all the domain models to help you determine which model is best for your environment.  
  
|Consideration|No AD DS|Isolated forest perimeter network|Extended corporate forest in the perimeter network|Forest trust in the perimeter network|  
|-------------------|--------------|---------------------------------------|--------------------------------------------------------|-------------------------------------------|  
|What are my identity management requirements?|There is no need for large\-scale identity management.|Identities in the perimeter have meaning only in the perimeter network, or another identity discovery solution.|The environment requires shared identities for the corporate network and the perimeter network to provide access to resources in the perimeter network.|The environment requires shared identities for the corporate network and the perimeter network to provide access to resources in the perimeter network.|  
||||||  
|What are my centralized management needs?|No centralized management solution is needed because of the small number of computers.|The centralized management benefits of AD DS are needed in the perimeter network. The greater the number of computers in the environment, the more benefit AD DS provides for actions such as defining Group Policy.<br /><br /> However, models with separate corporate and perimeter networks result in administration of two or more separate Active Directory environments.|The centralized management benefits of Active Directory are needed in the perimeter network. The greater the number of computers in the environment, the more benefit AD DS provides for actions such as defining Group Policy.|The centralized management benefits of AD DS are needed in the perimeter network. The greater the number of computers in the environment, the more benefit AD DS provides for actions such as defining Group Policy.<br /><br /> However, models with separate corporate and perimeter networks result in administration of two or more separate Active Directory environments.|  
|What are my SSO requirements?|No SSO is required. Identity discovery is not needed or resides in a single computer in this model.|SSO between the corporate network and the perimeter network is not desired. However, SSO is desired in perimeter network.<br /><br /> Windows Integrated Authentication based on security protocol features such as Kerberos delegation can provide SSO functionality. SSO can also maintain the levels of authentication and authorization.|SSO between the corporate network and the perimeter network is desired. Windows Integrated Authentication based on security protocol features such as Kerberos delegation can provide SSO functionality. SSO can also maintain the levels of authentication and authorization.|SSO between the corporate network and the perimeter network is desired. Windows Integrated Authentication based on security protocol features such as Kerberos delegation can provide SSO functionality. SSO can also maintain the levels of authentication and authorization.|  
|What type of access to and exposure control of personally identifiable information \(PII\) and high business impact \(HBI\) information do I want in my perimeter solution?|The corporate environment cannot afford any exposure of intranet data to perimeter network.|The corporate environment cannot afford any exposure of intranet data to perimeter network.|No PII or HBI is held by the corporate AD DS, or an appropriate Password Replication Policy \(PRP\) and filtered attribute set \(FAS\) to control the attributes that are replicated to the RODCs can help avoid exposure of the information.<br /><br /> For more information about the FAS, see RODC Filtered Attribute Set, Credential Caching, and the Authentication Process with an RODC \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133355](http://go.microsoft.com/fwlink/?LinkId=133355)\).|The corporate environment cannot afford any exposure of intranet data to the perimeter network.|  
|Do my perimeter applications store information in AD DS, and what are their compatibility requirements?|Perimeter applications do not store information in AD DS.|Perimeter applications store information in AD DS. Applications can write information to the directory or have compatibility issues that prevent the use of new RODC technology in the extended corporate forest model.|Perimeter applications store information in AD DS. Applications do not write information to the directory, without the need of opening extra ports in the firewall, and new RODC technology can be used.|Perimeter applications store information in AD DS. Applications can write information to the directory or have compatibility issues that prevent the use of new RODC technology in the extended corporate forest model.|  
  
## Planning for RODCs in the perimeter network  
 Because RODCs are a new feature in Windows Server 2008, the rest of this document describes the AD DS perimeter network models that use RODCs. To gain the full benefits of using RODCs and to mitigate any negative impacts to the perimeter network, an understanding of the features and constraints of RODCs is necessary.  
  
 From a security perspective, RODCs should be thought about as one piece of a larger IT strategy to reduce the attack surface of a perimeter network. Compared to writeable domain controllers, RODCs provide the direct security benefit of having a smaller attack surface. The specific security boundaries of RODCs are described in the Read\-Only Domain Controller Planning and Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135993](http://go.microsoft.com/fwlink/?LinkID=135993)\).  
  
 An indirect benefit of RODCs is apparent when an IT architect or engineer examines the perimeter network as a part of the entire network. For example, consider an organization that provides a service that it sells to consumers and that it hosts in the perimeter network. This organization uses an application\-specific account store and authentication mechanism \(for example, Microsoft SQL Server® or Active Directory Lightweight Directory Services \(AD LDS\)\). The organization decides to make the service available to its internal employees who register accounts with the service. The security engineer decides to audit the passwords of the employee accounts that are registered with the service and discovers that some employees used the same password for the service as they used to log on to the corporate network.  
  
 From a top\-down security perspective, there is no actual trust relationship between the corporate logon accounts and the service accounts. However, in practical terms, if a sophisticated attacker takes over the service and has unfettered access to the account store that the service uses, that attacker can then use those passwords to gain access to the corporate network through remote access technologies or by gaining access to the physical corporate network. RODCs can help reduce the probability of this type of attack by ensuring that any employee that uses the service is using his or her corporate identity and authenticating through Windows Integrated Authentication. This eliminates the need to store any employee identities in the service for the purpose of authentication.  
  
 After security, the next biggest consideration for RODCs is application compatibility. An RODC is not a full, drop\-in replacement for a writeable domain controller. This is for the most part intentional, to preserve the security boundaries discussed previously.  
  
 Application compatibility is a bigger consideration for an RODC in a perimeter network than for any other type of RODC deployment. This is because an RODC does not perform all the operations that a client computer or application may need from a domain controller. For example, an RODC does not process Lightweight Directory Access Protocol \(LDAP\) writes. Instead, it returns a referral for a writeable domain controller to the application. Depending on the network topology, the client computer may or may not be able to refer or forward the application to a writeable domain controller. Therefore, an RODC deployment in a perimeter network where client computers and applications can contact only an RODC must not be a scenario in which generic LDAP write operations are required.  
  
 IT architects and engineers must understand exactly how the client computers and applications interact with AD DS in the perimeter network. Group management and user provisioning are common scenarios that fail if they occur in the perimeter network and the application or client can contact only an RODC. RODCs can chain a limited number of scoped write operations, such as password updates, Service Principal Name \(SPN\) registration, and a few others. For a comprehensive list of the write operations that an RODC can perform see, the Read\-Only Domain Controller Planning and Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135993](http://go.microsoft.com/fwlink/?LinkID=135993)\).  
  
 The following sections contain information about:  
  
-   [Application compatibility](../Topic/Planning-Deployment-of-AD-DS-in-the-Perimeter-Network.md#app_comp)  
  
-   [Replacing a writeable domain controller with an RODC](../Topic/Planning-Deployment-of-AD-DS-in-the-Perimeter-Network.md#mov_frm_write_dc_rodc)  
  
-   [Client computer updates](../Topic/Planning-Deployment-of-AD-DS-in-the-Perimeter-Network.md#cleint_comp_updates)  
  
-   [Impact of data that is stored on RODCs in a perimeter network](../Topic/Planning-Deployment-of-AD-DS-in-the-Perimeter-Network.md#BKMK_ImpactofData)  
  
###  <a name="app_comp"></a> Application compatibility  
 If you want to block communication between the perimeter network and the internal corporate network, which contains writeable domain controllers, carefully consider the effect that placing RODCs in the perimeter network will have on your applications. For example, custom Active Directory Service Interfaces \(ADSI\) applications target writeable domain controllers by default because they pass a writeable\-only flag. These applications must be modified to use a read\-only flag. Otherwise, they will ignore the RODCs, which are read\-only by design.  
  
 If you have an application in your perimeter network that requires LDAP writes or requests that must have communication to writeable domain controllers in the domain, in many instances the required communication ports for these applications are not opened through the firewall, and the application may fail. RODCs are best suited for an extranet environment in which Active Directory access is primarily read\-only. There are some cases in which RODCs forward write requests to a writeable domain controller.  
  
 For more information about write requests that are forwarded to writeable domain controllers, see Application Compatibility with RODCs \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135711](http://go.microsoft.com/fwlink/?LinkId=135711)\).  
  
#### Applications that require AD DS  
 In one possible scenario in a perimeter network, a certain product or solution requires AD DS, but because of other security constraints, extending the corporate Active Directory forest in the perimeter network is judged to be not desirable. In this scenario, you can take advantage of Windows Server 2008 technology and work around these constraints, providing an acceptable solution that places AD DS in the perimeter network. Figure 5 illustrates this scenario.  
  
 ![](../Image/Scenario5_RODC_DirectoryEnabledServices.gif)  
  
 **Figure 5  RODCs in perimeter deployments that require AD DS**  
  
 We recommend that you check with the application vendor or independent software vendor \(ISV\) to determine whether the Active Directory–integrated application is compatible with RODCs.  
  
###  <a name="mov_frm_write_dc_rodc"></a> Replacing a writeable domain controller with an RODC  
 The process for replacing a writeable domain controller with an RODC is the same regardless of whether or not it is deployed in a perimeter network. It is not possible to migrate a writeable domain controller to a RODC. The best practices for replacing a writeable domain controller with an RODC are described in the Read\-Only Domain Controller Planning and Deployment Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135993](http://go.microsoft.com/fwlink/?LinkID=135993)\).  
  
 Because deployments of AD DS in perimeter networks have existed long before RODCs, it is assumed that some organizations that are interested in deploying RODCs already have an existing AD DS deployment. For example, the organization in Figure 6 has an existing perimeter network.  
  
 ![](../Image/Scenario3a_MigrationConsiderations_before.gif)  
  
 **Figure 6  An organization with an existing perimeter network**  
  
 The perimeter network has an application server that hosts a custom ADSI application, client computers, and a domain controller that runs Windows Server 2003. The organization is planning to replace the existing domain controller with an RODC to gain the advantages of RODCs. The new solution, after RODCs are deployed, is shown in Figure 7.  
  
 ![](../Image/Scenario3a_MigrationConsiderations_after.gif)  
  
 **Figure 7  A writable domain controller replaced by an RODC in the perimeter network**  
  
###  <a name="cleint_comp_updates"></a> Client computer updates  
 For member servers and client computers in the perimeter network that use an RODC, an update is available called the RODC compatibility pack. This update mitigates any issues that may occur when client computers interact with RODCs in their site.  
  
 For more information about client computer updates, see Known Issues for Deploying RODCs \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=135499](http://go.microsoft.com/fwlink/?LinkID=135499)\).  
  
 For more information about the RODC compatibility, see Application Compatibility with RODCs \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=135711](http://go.microsoft.com/fwlink/?LinkId=135711)\).To obtain the RODC compatibility pack, see article 944043 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122974](http://go.microsoft.com/fwlink/?LinkID=122974)\).  
  
##  <a name="BKMK_ImpactofData"></a> Impact of data that is stored on RODCs in a perimeter network  
 RODCs replicate most of the information in the directory. Therefore, organizations may be concerned about this data being replicated to the perimeter network. Figure 8 illustrates this concern.  
  
 ![](../Image/Scenario4_DataAccess_ExposureControl.gif)  
  
 **Figure 8  Data replication in an RODC**  
  
 In some cases, the placement of a server in the perimeter network with information about your corporate network may not be a good idea. You have to decide how much information on a domain controller can be considered PII and HBI and how to avoid exposing this information.  
  
 There are some domain models that avoid placing sensitive information on a domain controller in the perimeter. However, Windows Server 2008 RODC technology adds extra features that reduce the exposure of sensitive information.  
  
 After taking security into account and evaluating the new features that Windows Server 2008 offers, you may come to the conclusion that placing domain controllers in the perimeter network is not your best option. Application constraints and the risk of the exposure of sensitive information not being reduced enough to meet corporate compliance standards may prevent your organization from taking advantage of the new technology. For example, if you have an application in the perimeter network that must read the Social Security number \(SSN\) of an employee that is stored in AD DS and exposing that identification number is too sensitive, you can add the SSN attribute to the FAS, which ensures that this attribute will not be exposed on the RODC.  
  
  