---
title: Event ID 2537 — SCP Creation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 3445d493-b538-4418-85c3-45cc34573e89
---
# Event ID 2537 — SCP Creation
When Active Directory Lightweight Directory Services \(AD LDS\) is running on a computer that is joined to a domain, the AD LDS instance attempts to create a serviceConnectionPoint \(SCP\) object in the domain so that other computers in the domain can locate the AD LDS instance. As an option, an administrator can specify the container in which to create this object. The container must exist in the domain before it can be used as an SCP.  
  
## Event Details  
The event details are shown in the following table.  
  
|||  
|-|-|  
|Product|Windows Operating System|  
|ID:|2537|  
|Source:|Microsoft\-Windows\-ActiveDirectory\_DomainService|  
|Version:|6.0|  
|Symbolic Name:|DIRLOG\_ADAM\_SCP\_CREATE\_FAILURE|  
|Message:|The directory server has failed to create the AD LDS serviceConnectionPoint object in Active Directory Lightweight Directory Services \(AD LDS\). This operation will be retried.<br /><br />Additional Data<br /><br />SCP object DN:<br /><br />%1<br /><br />Error value:<br /><br />%2 %3<br /><br />Server error:<br /><br />%4<br /><br />Internal ID:<br /><br />%5<br /><br />AD LDS instance service account:<br /><br />%6<br /><br />User Action<br /><br />If AD LDS is running under a local service account, it will be unable to update the data in Active Directory Lightweight Directory Services \(AD LDS\). Consider changing the AD LDS service account to either NetworkService or a domain account.<br /><br />If AD LDS is running under a domain user account, make sure this account has sufficient rights to create the serviceConnectionPoint object.<br /><br />ServiceConnectionPoint object publication can be disabled for this instance by setting msDS\-DisableForInstances attribute on the SCP publication configuration object.|  
  
## Resolve Configure access or disable SCP creation  
You have two options for resolving this situation, depending on your environment and goals:  
  
1.  If you do not want other computers in the domain to be able to locate the Active Directory Lightweight Directory Services \(AD LDS\) instances, you can disable the creation of the serviceConnectionPoint \(SCP\) objects in the domain \(see [Disabling SCP Creation](../Topic/Event-ID-2537-%E2%80%94-SCP-Creation.md#BKMK_disable)\).  
  
2.  If you want other computers to be able to locate the AD LDS instance, ensure that the service account type is correct and that it has the appropriate permissions to create the SCP \(see [Configuring permissions to allow SCP creation](../Topic/Event-ID-2537-%E2%80%94-SCP-Creation.md#BKMK_allowscp)\).  
  
Perform the following procedures using a domain member computer that has domain administrative tools installed.  
  
To perform these procedures, you must have membership in **Domain Admins**, or you must have been delegated the appropriate authority.  
  
### <a name="BKMK_disable"></a>Disabling SCP Creation  
To disable the creation of SCP for all AD LDS instances in a configuration set complete the following procedure.  
  
##### To disable SCP creation  
  
1.  NEED TO FINISH THE STEPS HERE  
  
### <a name="BKMK_allowscp"></a>Configuring permissions to allow SCP creation  
NEED TO FINISH THE STEPS HERE  
  
## Verify  
When an Active Directory Lightweight Directory Services \(AD LDS\) instance successfully creates a serviceConnectionPoint \(SCP\), Event ID 2535 is logged in Event Viewer. Check for the existence of this event in the ADAM\_instanceName log of Event Viewer, where instanceName is the name of the AD LDS instance.  
  
To learn more about AD LDS, formerly known as Active Directory Application Mode \(ADAM\), see [Active Directory Application Mode \(ADAM\)](http://go.microsoft.com/fwlink/?LinkID=92820)\(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=92820\).  
  
