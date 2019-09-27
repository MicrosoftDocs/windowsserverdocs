---
ms.assetid: 50bd2566-e03c-4884-b5c4-895c8aab80aa
title: Identifying the Deployment Project Participants
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Identifying the Deployment Project Participants

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The first step in establishing a deployment project for Active Directory Domain Service (AD DS) is to establish the design and deployment project teams that will be responsible for managing the design phase and deployment phase of the Active Directory project cycle. In addition, you must identify the individuals and groups who will be responsible for owning and maintaining the directory after the deployment is completed.  
  
-   [Defining project-specific roles](#BKMK_1)  
  
-   [Establishing owners and administrators](#BKMK_2)  
  
-   [Building project teams](#BKMK_3)  
  
## <a name="BKMK_1"></a>Defining project-specific roles  
An important step in establishing the project teams is to identify the individuals who are to hold project-specific roles. These include the executive sponsor, the project architect, and the project manager. These individuals are responsible for running the Active Directory deployment project.  
  
After you appoint the project architect and project manager, these individuals establish channels of communication throughout the organization, build project schedules, and identify the individuals who will be members of the project teams, beginning with the various owners.  
  
### Executive sponsor  
Deploying an infrastructure such as AD DS can have a wide-ranging impact on an organization. For this reason, it is important to have an executive sponsor who understands the business value of the deployment, supports the project at the executive level, and can help resolve conflicts across the organization.  
  
### Project architect  
Each Active Directory deployment project requires a project architect to manage the Active Directory design and deployment decision-making process. The architect provides technical expertise to assist with the process of designing and deploying AD DS.  
  
> [!NOTE]  
> If no existing personnel in your organization have directory design experience, you might want to hire an outside consultant who is an expert in Active Directory design and deployment.  
  
The responsibilities of the Active Directory project architect include the following:  
  
-   Owning the Active Directory design  
  
-   Understanding and recording the rationale for key design decisions  
  
-   Ensuring that the design meets the business needs of the organization  
  
-   Establishing consensus between design, deployment, and operations teams  
  
-   Understanding the needs of AD DS-integrated applications  
  
The final Active Directory design must reflect a combination of business goals and technical decisions. Therefore, the project architect must review design decisions to ensure that they align with business goals.  
  
### Project manager  
The project manager facilitates cooperation across business units and between technology management groups. Ideally, the Active Directory deployment project manager is someone from within the organization who is familiar with both the operational policies of the IT group and the design requirements for the groups that are preparing to deploy AD DS. The project manager oversees the entire deployment project, beginning with design and continuing through implementation, and makes sure that the project stays on schedule and within budget. The responsibilities of the project manager include the following:  
  
-   Providing basic project planning such as scheduling and budgeting  
  
-   Driving progress on the Active Directory design and deployment project  
  
-   Ensuring that the appropriate individuals are involved in each part of the design process  
  
-   Serving as single point of contact for the Active Directory deployment project  
  
-   Establishing communication between design, deployment, and operations teams  
  
-   Establishing and maintaining communication with the executive sponsor throughout the deployment project  
  
## <a name="BKMK_2"></a>Establishing owners and administrators  
In an Active Directory deployment project, individuals who are owners are held accountable by management to make sure that deployment tasks are completed and that Active Directory design specifications meet the needs of the organization. Owners do not necessarily have access to or manipulate the directory infrastructure directly. Administrators are the individuals responsible for completing the required deployment tasks. Administrators have the network access and permissions necessary to manipulate the directory and its infrastructure.  
  
The role of the owner is strategic and managerial. Owners are responsible for communicating to administrators the tasks required for the implementation of the Active Directory design such as the creation of new domain controllers within the forest. The administrators are responsible for implementing the design on the network according to the design specifications.  
  
In large organizations, different individuals fill owner and administrator roles; however, in some small organizations, the same individual might act as both the owner and the administrator.  
  
### Service and data owners  
Managing AD DS on a daily basis involves two types of owners:  
  
-   Service owners who are responsible for planning and long-term maintenance of the Active Directory infrastructure and for ensuring that the directory continues to function and that the goals established in service level agreements are maintained  
  
-   Data owners who are responsible for the maintenance of the information stored in the directory. This includes user and computer account management and management of local resources such as member servers and workstations.  
  
It is important to identify the Active Directory service and data owners early so that they can participate in as much of the design process as possible. Because the service and data owners are responsible for the long-term maintenance of the directory after the deployment project is finished, it is important for these individuals to provide input regarding organizational needs and to be familiar with how and why certain design decisions are made. Service owners include the forest owner, the Active Directory Domain Naming System (DNS) owner, and the site topology owner. Data owners include organizational unit (OU) owners.  
  
### Service and data administrators  
The operation of AD DS involves two types of administrators: service administrators and data administrators. Service administrators implement policy decisions made by service owners and handle the day-to-day tasks associated with maintaining the directory service and infrastructure. This includes managing the domain controllers that are hosting the directory service, managing other network services such as DNS that are required for AD DS, controlling the configuration of forest-wide settings, and ensuring that the directory is always available.  
  
Service administrators are also responsible for completing ongoing Active Directory deployment tasks that are required after the initial  Windows Server 2008  Active Directory deployment process is complete. For example, as demands on the directory increase, service administrators create additional domain controllers and establish or remove trusts between domains, as needed. For this reason, the Active Directory deployment team needs to include service administrators.  
  
You must be careful to assign service administrator roles only to trusted individuals in the organization. Because these individuals have the ability to modify the system files on domain controllers, they can change the behavior of AD DS. You must ensure that the service administrators in your organization are individuals who are familiar with the operational and security policies that are in place on your network and who understand the need to enforce those policies.  
  
Data administrators are users within a domain who are responsible both for maintaining data that is stored in AD DS such as user and group accounts and for maintaining computers that are members of their domain. Data administrators control subsets of objects within the directory and have no control over the installation or configuration of the directory service.  
  
Data administrator accounts are not provided by default. After the design team determines how resources are to be managed for the organization, domain owners must create data administrator accounts and delegate them the appropriate permissions based on the set of objects for which the administrators are to be responsible.  
  
It is best to limit the number of service administrators in your organization to the minimum number required to ensure that the infrastructure continues to function. The majority of administrative work can be completed by data administrators. Service administrators require a much wider skill set because they are responsible for maintaining the directory and the infrastructure that supports it. Data administrators only require the skills necessary to manage their portion of the directory. Dividing work assignments in this way results in cost savings for the organization because only a small number of administrators need to be trained to operate and maintain the entire directory and its infrastructure.  
  
For example, a service administrator needs to understand how to add a domain to a forest. This includes how to install the software to convert a server into a domain controller and how to manipulate the DNS environment so that the domain controller can be merged seamlessly into the Active Directory environment. A data administrator only needs to know how to manage the specific data that they are responsible for such as the creation of new user accounts for new employees in their department.  
  
Deploying AD DS requires coordination and communication between many different groups involved in the operation of the network infrastructure. These groups should appoint service and data owners who are responsible for representing the various groups during the design and deployment process.  
  
Once the deployment project is complete, these service and data owners continue to be responsible for the portion of the infrastructure managed by their group. In an Active Directory environment, these owners are the forest owner, the DNS for AD DS owner, the site topology owner, and the OU owner. The roles of these service and data owners are explained in the following sections.  
  
#### Forest owner  
The forest owner is typically a senior information technology (IT) manager in the organization who is responsible for the Active Directory deployment process and who is ultimately accountable for maintaining service delivery within the forest after the deployment is complete. The forest owner assigns individuals to fill the other ownership roles by identifying key personnel within the organization who are able to contribute necessary information about network infrastructure and administrative needs. The forest owner is responsible for the following:  
  
-   Deployment of the forest root domain to create the forest  
  
-   Deployment of the first domain controller in each domain to create the domains required for the forest  
  
-   Memberships of the service administrator groups in all domains of the forest  
  
-   Creation of the design of the OU structure for each domain in the forest  
  
-   Delegation of administrative authority to OU owners  
  
-   Changes to the schema  
  
-   Changes to forest-wide configuration settings  
  
-   Implementation of certain Group Policy policy settings, including domain user account policies such as fine-grained password and account lockout policy  
  
-   Business policy settings that apply to domain controllers  
  
-   Any other Group Policy settings that are applied at the domain level  
  
The forest owner has authority over the entire forest. It is the forest owner's responsibility to set Group Policy and business policies and to select the individuals who are service administrators. The forest owner is a service owner.  
  
#### DNS for AD DS owner  
The DNS for AD DS owner is an individual who has a thorough understanding of the existing DNS infrastructure and the existing namespace of the organization.  
  
The DNS for AD DS owner is responsible for the following:  
  
-   Serving as a liaison between the design team and the IT group that currently owns the DNS infrastructure  
  
-   Providing the information about the existing DNS namespace of the organization to assist in the creation of the new Active Directory namespace  
  
-   Working with the deployment team to make sure that the new DNS infrastructure is deployed according to the specifications of the design team and that it is working properly  
  
-   Managing the DNS for AD DS infrastructure, including the DNS Server service and DNS data  
  
The DNS for AD DS owner is a service owner.  
  
#### Site topology owner  
The site topology owner is familiar with the physical structure of the organization network, including mapping of individual subnets, routers, and network areas that are connected by means of slow links. The site topology owner is responsible for the following:  
  
-   Understanding the physical network topology and how it affects AD DS  
  
-   Understanding how the Active Directory deployment will impact the network  
  
-   Determining the Active Directory logical sites that need to be created  
  
-   Updating site objects for domain controllers when a subnet is added, modified, or removed  
  
-   Creating site links, site link bridges, and manual connection objects  
  
The site topology owner is a service owner.  
  
#### OU owner  
The OU owner is responsible for managing data stored in the directory. This individual needs to be familiar with the operational and security policies that are in place on the network. OU owners can perform only those tasks that have been delegated to them by the service administrators, and they can perform only those tasks on the OUs to which they are assigned. Tasks that might be assigned to the OU owner include the following:  
  
-   Performing all account management tasks within their assigned OU  
  
-   Managing workstations and member servers that are members of their assigned OU  
  
-   Delegating authority to local administrators within their assigned OU  
  
The OU owner is a data owner.  
  
## <a name="BKMK_3"></a>Building project teams  
Active Directory project teams are temporary groups that are responsible for completing Active Directory design and deployment tasks. When the Active Directory deployment project is complete, the owners assume responsibility for the directory, and the project teams can disband.  
  
The size of the project teams varies according to the size of the organization. In small organizations, a single person can cover multiple areas of responsibility on a project team and be involved in more than one phase of the deployment. Large organizations might require larger teams with different individuals or even different teams covering the different areas of responsibility. The size of the teams is not important as long as all areas of responsibility are assigned, and the design goals of the organization are met.  
  
### Identifying potential forest owners  
Identify the groups within your organization that own and control the resources necessary to provide directory services to users on the network. These groups are considered potential forest owners.  
  
The separation of service and data administration in AD DS makes it possible for the infrastructure IT group (or groups) of an organization to manage the directory service while local administrators in each group manage the data that belongs to their own groups. Potential forest owners have the required authority over the network infrastructure to deploy and support AD DS.  
  
For organizations that have one centralized infrastructure IT group, the IT group is generally the forest owner and, therefore, the potential forest owner for any future deployments. Organizations that include a number of independent infrastructure IT groups have a number of potential forest owners. If your organization already has an Active Directory infrastructure in place, any current forest owners are also potential forest owners for new deployments.  
  
Select one of the potential forest owners to act as the forest owner for each forest that you are considering for deployment. These potential forest owners are responsible for working with the design team to determine whether or not their forest will actually be deployed or if an alternate course of action (such as joining another existing forest) is a better use of the available resources and still meets their needs. The forest owner (or owners) in your organization are members of the Active Directory design team.  
  
### Establishing a design team  
The Active Directory design team is responsible for gathering all the information needed to make decisions about the Active Directory logical structure design.  
  
The responsibilities of the design team include the following:  
  
-   Determining how many forests and domains are required and what the relationships are between the forests and domains  
  
-   Working with data owners to ensure that the design meets their security and administrative requirements  
  
-   Working with the current network administrators to ensure that the current network infrastructure supports the design and that the design will not adversely affect existing applications deployed on the network  
  
-   Working with representatives of the security group of the organization to ensure that the design meets established security policies  
  
-   Designing OU structures that permit appropriate levels of protection and the proper delegation of authority to the data owners  
  
-   Working with the deployment team to test the design in a lab environment to ensure that it functions as planned and modifying the design as needed to address any problems that occur  
  
-   Creating a site topology design that meets the replication requirements of the forest while preventing overload of available bandwidth. For more information about designing the site topology, see [Designing the Site Topology for Windows Server 2008 AD DS](https://technet.microsoft.com/library/cc772013.aspx).  
  
-   Working with the deployment team to ensure that the design is implemented correctly  
  
The design team includes the following members:  
  
-   Potential forest owners  
  
-   Project architect  
  
-   Project manager  
  
-   Individuals who are responsible for establishing and maintaining security policies on the network  
  
During the logical structure design process, the design team identifies the other owners. These individuals must start participating in the design process as soon as they are identified. After the deployment project is handed off to the deployment team, the design team is responsible for overseeing the deployment process to ensure that the design is implemented correctly. The design team also makes changes to the design based on feedback from testing.  
  
### Establishing a deployment team  
The Active Directory deployment team is responsible for testing and implementing the Active Directory logical structure design. This involves the following tasks:  
  
-   Establishing a test environment that sufficiently emulates the production environment  
  
-   Testing the design by implementing the proposed forest and domain structure in a lab environment to verify that it meets the goals of each role owner  
  
-   Developing and testing any migration scenarios proposed by the design in a lab environment  
  
-   Making sure that each owner signs off on the testing process to ensure that the correct design features are being tested  
  
-   Testing the deployment operation in a pilot environment  
  
When the design and testing tasks are complete, the deployment team performs the following tasks:  
  
-   Creates the forests and domains according to the Active Directory logical structure design  
  
-   Creates the sites and site link objects as needed based on the site topology design  
  
-   Ensures that the DNS infrastructure is configured to support AD DS and that any new namespaces are integrated into the existing namespace of the organization  
  
The Active Directory deployment team includes the following members:  
  
-   Forest owner  
  
-   DNS for AD DS owner  
  
-   Site topology owner  
  
-   OU owners  
  
The deployment team works with the service and data administrators during the deployment phase to ensure that members of the operations team are familiar with the new design. This helps to ensure a smooth transition of ownership when the deployment operation is completed. At the completion of the deployment process, the responsibility for maintaining the new Active Directory environment passes to the operations team.  
  
### Documenting the design and deployment teams  
Document the names and contact information for the people who will participate in the design and deployment of AD DS. Identify who will be responsible for each role on the design and deployment teams. Initially, this list includes the potential forest owners, the project manager, and the project architect. When you determine the number of forests that you will deploy, you might need to create new design teams for additional forests. Note that you will need to update your documentation as team memberships change and as you identify the various Active Directory owners during the design process. For a worksheet to assist you in documenting the design and deployment teams for each forest, download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip from Job Aids for Windows Server 2003 Deployment Kit ([https://go.microsoft.com/fwlink/?LinkID=102558](https://go.microsoft.com/fwlink/?LinkID=102558)) and open "Design and Deployment Team Information" (DSSLOGI_1.doc).  
  


