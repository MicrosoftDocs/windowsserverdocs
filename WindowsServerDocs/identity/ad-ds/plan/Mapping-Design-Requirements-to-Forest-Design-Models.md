---
ms.assetid: c0d64566-5530-482e-a332-af029a5fb575
title: Mapping Design Requirements to Forest Design Models
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/07/2018
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---
# Mapping Design Requirements to Forest Design Models

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Most groups in your organization can share a single organizational forest that is managed by a single information technology (IT) group and that contains the user accounts and resources for all of the groups that share the forest. This shared forest, called the initial organizational forest, is the foundation of the forest design model for the organization.  

Because the initial organizational forest can host multiple groups in the organization, the forest owner must establish service level agreements with each group so that all the parties understand what is expected of them. This protects both the individual groups and the forest owner by establishing agreed-on service expectations.  

If not all of the groups in your organization can share a single organizational forest, you must expand your forest design to accommodate the needs of the different groups. This involves identifying the design requirements that apply to the groups based on their needs for autonomy and isolation and whether or not they have a limited-connectivity network, and then identifying the forest model that you can use to accommodate those requirements. The following table lists forest design model scenarios based on the autonomy, isolation, and connectivity factors. After you identify the forest design scenario that best matches your requirements, determine if you need to make any additional decisions to meet your design specifications.  

> [!NOTE]  
> If a factor is listed as N/A, it is not a consideration because other requirements also accommodate that factor.  

|Scenario|Limited connectivity|Data isolation|Data autonomy|Service isolation|Service autonomy|  
|------------|------------------------|------------------|-----------------|---------------------|--------------------|  
|[Scenario 1: Join an existing forest for data autonomy](#BKMK_1)|No|No|Yes|No|No|  
|[Scenario 2: Use an organizational forest or domain for service autonomy](#BKMK_2)|No|No|N/A|No|Yes|  
|[Scenario 3: Use an organizational forest or resource forest for service isolation](#BKMK_3)|No|No|N/A|Yes|N/A|  
|[Scenario 4: Use an organizational forest or restricted access forest for data isolation](#BKMK_4)|N/A|Yes|N/A|N/A|N/A|  
|[Scenario 5: Use an organizational forest, or reconfigure the firewall for limited connectivity](#BKMK_5)|Yes|No|N/A|No|No|  
|[Scenario 6: Use an organizational forest or domain, and reconfigure the firewall for service autonomy with limited connectivity](#BKMK_6)|Yes|No|N/A|No|Yes|  
|[Scenario 7: Use a resource forest, and reconfigure the firewall for service isolation with limited connectivity](#BKMK_7)|Yes|No|N/A|Yes|N/A|  

## <a name="BKMK_1"></a>Scenario 1: Join an existing forest for data autonomy  

You can meet a requirement for data autonomy simply by hosting the group in organizational units (OUs) in an existing organizational forest. Delegate control over the OUs to data administrators from that group to achieve data autonomy. For more information about delegating control by using OUs, see [Creating an Organizational Unit Design](../../ad-ds/plan/Creating-an-Organizational-Unit-Design.md).  
  
## <a name="BKMK_2"></a>Scenario 2: Use an organizational forest or domain for service autonomy  

If a group in your organization identifies service autonomy as a requirement, we recommend that you first reconsider this requirement. Achieving service autonomy creates more management overhead and additional costs for the organization. Ensure that the requirement for service autonomy is not simply for convenience and that you can justify the costs involved in meeting this requirement.  
  
You can meet a requirement for service autonomy by doing one of the following:  

- Creating an organizational forest. Place the users, groups, and computers for the group that requires service autonomy into a separate organizational forest. Assign an individual from that group to be the forest owner. If the group needs to access or share resources with other forests in the organization, they can establish a trust between their organizational forest and the other forests.  

- Using organizational domains. Place the users, groups, and computers in a separate domain in an existing organizational forest. This model provides for domain-level service autonomy only and not for full service autonomy, service isolation, or data isolation.  

For more information about using organizational domains, see [Using the Organizational Domain Forest Model](../../ad-ds/plan/../../ad-ds/plan/Using-the-Organizational-Domain-Forest-Model.md).  

## <a name="BKMK_3"></a>Scenario 3: Use an organizational forest or resource forest for service isolation  

You can meet a requirement for service isolation by doing one of the following:  

- Using an organizational forest. Place the users, groups, and computers for the group that requires service isolation into a separate organizational forest. Assign an individual from that group to be the forest owner. If the group needs to access or share resources with other forests in the organization, they can establish a trust between their organizational forest and the other forests. However, we do not recommend this approach because resource access through universal groups is heavily restricted in forest trust scenarios.  

- Using a resource forest. Place resources and service accounts into a separate resource forest, keeping user accounts in an existing organizational forest. If necessary, alternate accounts can be created in the resource forest to access resources in the resource forest if the organizational forest becomes unavailable. The alternate accounts must have the authority required to log on to the resource forest and maintain control of the resources until the organizational forest is back online.  

   Establish a trust between the resource and organizational forests, so that the users can access the resources in the forest while using their regular user accounts. This configuration enables centralized management of user accounts while allowing users to fall back to alternate accounts in the resource forest if the organizational forest becomes unavailable.  

Considerations for service isolation include the following:

- Forests created for service isolation can trust domains from other forests but must not include users from other forests in their service administrators groups. If users from other forests are included in administrative groups in the isolated forest, the security of the isolated forest potentially can be compromised because the service administrators in the forest do not have exclusive control.  

- As long as domain controllers are accessible on a network, they are subject to attacks (such as denial-of-service attacks) from malicious software on that network. You can do the following to protect against the possibility of an attack:  

   - Host domain controllers only on networks that are considered secure.  

   - Limit access to the network or networks hosting the domain controllers.  

- Service isolation requires the creation of an additional forest. Evaluate whether the cost of maintaining the infrastructure to support the additional forest outweighs the costs associated with loss of access to resources due to an organizational forest being unavailable.  

## <a name="BKMK_4"></a>Scenario 4: Use an organizational forest or restricted access forest for data isolation  

You can achieve data isolation by doing one of the following:  

- Using an organizational forest. Place the users, groups, and computers for the group that requires data isolation into a separate organizational forest. Assign an individual from that group to be the forest owner. If the group needs to access or share resources with other forests in the organization, establish a trust between the organizational forest and the other forests. Only the users who require access to the classified information exist in the new organizational forest. Users have one account that they use to access both classified data in their own forest and unclassified data in other forests by means of trust relationships.  

- Using a restricted access forest. This is a separate forest that contains the restricted data and the user accounts that are used to access that data. Separate user accounts are maintained in the existing organizational forests that are used to access the unrestricted resources on the network. No trusts are created between the restricted access forest and other forests in the enterprise. You can further restrict the forest by deploying the forest on a separate physical network, so that it cannot connect to other forests. If you deploy the forest on a separate network, users must have two workstations: one for accessing the restricted forest and one for accessing the nonrestricted areas of the network.  

Considerations for creating forests for data isolation include the following:  

- Organizational forests created for data isolation can trust domains from other forests, but users from other forests must not be included in any of the following:  

  - Groups responsible for service management or groups that can manage the membership of service administrator groups  

  - Groups that have administrative control over computers that store protected data  

  - Groups that have access to protected data or groups that are responsible for the management of user objects or group objects that have access to protected data  

    If users from another forest are included in any of these groups, a compromise of the other forest might lead to a compromise of the isolated forest and to disclosure of protected data.  

- Other forests can be configured to trust the organizational forest created for data isolation so that users in the isolated forest can access resources in other forests. However, users from the isolated forest must never interactively log on to workstations in the trusting forest. The computer in the trusting forest can potentially be compromised by malicious software and can be used to capture the logon credentials of the user.  

   > [!NOTE]
   > To prevent servers in a trusting forest from impersonating users from the isolated forest, and then accessing resources in the isolated forest, the forest owner can disable delegated authentication or use the constrained delegation feature. For more information about delegated authentication and constrained delegation, see [Delegating authentication](https://go.microsoft.com/fwlink/?LinkId=106614).  

- You might need to establish a firewall between the organizational forest and the other forests in the organization to limit user access to information outside of their forest.  

- Although creating a separate forest enables data isolation, as long as the domain controllers in the isolated forest and computers that host protected information are accessible on a network, they are subject to attacks launched from computers on that network. Organizations that decide that the risk of attack is too high or that the consequence of an attack or security violation is too great need to limit access to the network or networks that are hosting the domain controllers and the computers that are hosting protected data. Limiting access can be done by using technologies such as firewalls and Internet Protocol security (IPsec). In extreme cases, organizations might choose to maintain the protected data on an independent network that has no physical connection to any other network in the organization.  

   > [!NOTE]  
   > If any network connectivity exists between a restricted access forest and another network, the possibility exists for data in the restricted area to be transmitted to the other network.  

## <a name="BKMK_5"></a>Scenario 5: Use an organizational forest, or reconfigure the firewall for limited connectivity  

To meet a limited connectivity requirement, you can do one of the following:  

- Place users into an existing organizational forest, and then open the firewall enough to allow Active Directory traffic to pass through.  

- Use an organizational forest. Place the users, groups, and computers for the group for which connectivity is limited into a separate organizational forest. Assign an individual from that group to be the forest owner. The organizational forest provides a separate environment on the other side of the firewall. The forest includes user accounts and resources that are managed within the forest, so that users do not need to go through the firewall to accomplish their daily tasks. Specific users or applications might have special needs that require the capability to pass through the firewall to contact other forests. You can address these needs individually by opening the appropriate interfaces in the firewall, including those necessary for any trusts to function.  

For more information about configuring firewalls for use with Active Directory Domain Services (AD DS), see [Active Directory in Networks Segmented by Firewalls](https://go.microsoft.com/fwlink/?LinkId=37928).  

## <a name="BKMK_6"></a>Scenario 6: Use an organizational forest or domain, and reconfigure the firewall for service autonomy with limited connectivity  

If a group in your organization identifies service autonomy as a requirement, we recommend that you first reconsider this requirement. Achieving service autonomy creates more management overhead and additional costs for the organization. Ensure that the requirement for service autonomy is not simply for convenience and that you can justify the costs involved in meeting this requirement.  

If limited connectivity is an issue, and you have a requirement for service autonomy, you can do one of the following:  

- Use an organizational forest. Place the users, groups, and computers for the group that requires service autonomy into a separate organizational forest. Assign an individual from that group to be the forest owner. The organizational forest provides a separate environment on the other side of the firewall. The forest includes user accounts and resources that are managed within the forest, so that users do not need to go through the firewall to accomplish their daily tasks. Specific users or applications might have special needs that require the capability to pass through the firewall to contact other forests. You can address these needs individually by opening the appropriate interfaces in the firewall, including those necessary for any trusts to function.  

- Place the users, groups, and computers in a separate domain in an existing organizational forest. This model provides for domain-level service autonomy only and not for full service autonomy, service isolation, or data isolation. Other groups in the forest must trust the service administrators of the new domain to the same degree that they trust the forest owner. For this reason, we do not recommend this approach. For more information about using organizational domains, see [Using the Organizational Domain Forest Model](../../ad-ds/plan/../../ad-ds/plan/Using-the-Organizational-Domain-Forest-Model.md).  

You also need to open the firewall enough to allow Active Directory traffic to pass through. For more information about configuring firewalls for use with AD DS, see [Active Directory in Networks Segmented by Firewalls](https://go.microsoft.com/fwlink/?LinkId=37928).  

## <a name="BKMK_7"></a>Scenario 7: Use a resource forest, and reconfigure the firewall for service isolation with limited connectivity  

If limited connectivity is an issue, and you have a requirement for service isolation, you can do one of the following:  

- Use an organizational forest. Place the users, groups, and computers for the group that requires service isolation into a separate organizational forest. Assign an individual from that group to be the forest owner. The organizational forest provides a separate environment on the other side of the firewall. The forest includes user accounts and resources that are managed within the forest, so that users do not need to go through the firewall to accomplish their daily tasks. Specific users or applications might have special needs that require the capability to pass through the firewall to contact other forests. You can address these needs individually by opening the appropriate interfaces in the firewall, including those necessary for any trusts to function.  

- Use a resource forest. Place resources and service accounts into a separate resource forest, keeping user accounts in an existing organizational forest. It might be necessary to create some alternate user accounts in the resource forest to maintain access to the resource forest if the organizational forest becomes unavailable. The alternate accounts must have the authority required to log on to the resource forest and maintain control of the resources until the organizational forest is back online.  

   Establish a trust between the resource and organizational forests, so that the users can access the resources in the forest while using their regular user accounts. This configuration enables centralized management of user accounts while allowing users to fall back to alternate accounts in the resource forest if the organizational forest becomes unavailable.  

Considerations for service isolation include the following:  

- Forests created for service isolation can trust domains from other forests but must not include users from other forests in their service administrators groups. If users from other forests are included in administrative groups in the isolated forest, the security of the isolated forest potentially can be compromised because the service administrators in the forest do not have exclusive control.  

- As long as domain controllers are accessible on a network, they are subject to attacks (such as denial-of-service attacks) from computers on that network. You can do the following to protect against the possibility of an attack:  

   - Host domain controllers only on networks that are considered secure.  

   - Limit access to the network or networks hosting the domain controllers.  

- Service isolation requires the creation of an additional forest. Evaluate whether the cost of maintaining the infrastructure to support the additional forest outweighs the costs associated with loss of access to resources due to an organizational forest being unavailable.  

   Specific users or applications might have special needs that require the capability to pass through the firewall to contact other forests. You can address these needs individually by opening the appropriate interfaces in the firewall, including those necessary for any trusts to function.  

For more information about configuring firewalls for use with AD DS, see [Active Directory in Networks Segmented by Firewalls](https://go.microsoft.com/fwlink/?LinkId=37928).  
