---
title: AD DS: Owner Rights
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b0392dd9-d02e-4e73-aa5b-77f32776e845
author: Femila
---
# AD DS: Owner Rights
  In Windows operating systems, the owner of an object, by default, has the following permissions:  
  
-   WRITE\_DAC permission. This permission gives security principals the ability to change permissions on an object.  
  
-   READ\_CONTROL permission. This permission gives security principals the ability to read the permissions that are assigned to an object.  
  
 In many cases, these two permissions are greater than the intended permissions for the owners of objects.  
  
 In Windows Server® 2008 and Windows Vista®, it is possible to curtail the default permissions \(WRITE\_DAC and READ\_CONTROL\) that owners of objects are given by adding the Owner Rights security principal to an object’s discretionary access control list \(DACL\).  
  
## What is Owner Rights?  
 Owner Rights is a well\-known security principal that you can add to the DACL of an object to specify the permissions that are assigned to owners of objects in the directory service. This added security feature overrides the default behavior of owners of objects in the system. Because owners of objects \(as specified in the security descriptor of the object\) have WRITE\_DAC permission, they can give rights to themselves and to other security principals as they see fit.  
  
 The Owner Rights security principal is specified using the well\-known security identifier \(SID\) S\-1\-3\-4. For example, if the Owner Rights security principal is located in the fabrikam.com domain, its distinguished name \(also known as DN\) can be expressed this way: CN\=Owner Rights,CN\=WellKnown Security Principals,CN\=Configuration,DC\=fabrikam,DC\=com.  
  
 By default, Owner Rights are not defined on objects. This means that the pre–Windows Server 2008 behavior of owners having WRITE\_DAC permissions to the objects that they own still applies.  
  
 When you add the Owner Rights security principal to objects, you can specify what permissions are given to the owner of an object. For example you can specify in the access control entry \(ACE\) of an object that the owner of a particular object is given Read permissions or you can specify NULL permissions to an object, which grants the owner of the object no permissions.  
  
## Scenarios  
 This section contains two scenarios that show the implementation and the benefits of using the Owner Rights security principal.  
  
 The first scenario demonstrates the use of Owner Rights for organizational unit \(OU\) delegation. The second scenario demonstrates the use of Owner Rights to limit who can give access to an object.  
  
### Scenario 1  
 In many organizations, senior\-level administrators delegate the management of OUs to junior\-level administrators. There are often times when these senior\-level administrators want to delegate only the creation of certain objects within the OU and not additional operations, such as deleting objects from the OU.  
  
 In Windows Server 2008, using the Owner Rights security principal simplifies the task of delegation. Now, all the senior\-level administrator has to do is create an ACE with the Owner SID, ensure that the ACE is an inheritable ACE, and adjust the permissions to the desired level of control. The permissions that are assigned by the senior\-level administrator are still in effect, but with the addition of the Owner Rights security principal to the object, the junior\-level administrators cannot grant themselves more permissions than the senior\-level administrator intended. In this case, the junior\-level administrators are restricted to just creating objects in the OU and not deleting them.  
  
### Scenario 2  
 You can use Owner Rights to control the behavior of stale owners of objects in Active Directory Domain Services \(AD DS\).  
  
 For example, you may have permissions established on an OU that allow members of a security group—let’s say security group X—to create objects in that OU. If members of security group X are removed from group X as a result of an organizational change, they will still have WRITE\_DAC permissions on the objects that they created because the SIDs of the Creator Owner are listed as the owners of the object. With WRITE\_DAC permissions still in place, the owners of the object—in this case, the users that have been removed from security group X—can still modify and delete the objects that they created.  
  
 By creating an inheritable ACE at the OU with restricted permissions, you can prevent the owners of the objects in the OU that have been removed from security group X from making any changes to the objects. This is possible because the presence of the inherited Owner ACE in the newly created objects causes the default Owner permissions to be overridden, which prevents the stale owners of objects in the OU from modifying these objects.  
  
##  <a name="how_to_implement_owners_rights"></a> How to implement Owner Rights  
 This section describes how to implement the Owner Rights security principal on objects in AD DS. To enforce Owner Rights on objects, all domain controllers in the organization must be running Windows Server 2008. If you have domain controllers in your environment that are pre–Windows Server 2008, these domain controllers ignore the Owner Rights security principal. Therefore, to securely enforce Owner Rights on objects, all domain controllers in the organization must be running Windows Server 2008.  
  
 You can use the following procedure to add the Owner Rights security principal to an OU object in AD DS. We recommend that you try this procedure in a test environment to ensure the desired results before you try it in a production environment.  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To implement Owner Rights  
  
1.  In your testing environment, click **Start**, point to **All Programs**, and then click **Administrative Tools Administrative Tools**. Under **Administrator Tools**, click **Active Directory Users and Computers**. Open the Active Directory Users and Computers snap\-in.  
  
2.  Right\-click the OU on which you want to implement Owner Rights, and then click **Properties**.  
  
3.  In the **Properties** box of the OU, click the **Security** tab.  
  
     If you do not see the **Security** tab, in the main **Active Directory and Users and Computers** window, click **View**, and ensure that you have **Advanced Features** selected.  
  
4.  Under **Group or user names**, click **Add**.  
  
5.  In the input box, type **Owner Rights**, and then click **OK**.  
  
     You can fine\-tune the permissions that are assigned to the Owner Rights security principal by clicking **Advanced** and then adjusting the permissions to meet the needs of your organization.  
  
6.  To complete the task of adding the Owner Rights security principal to the OU, click **OK**.  
  
## Configuration note  
 Note the following consideration for adding the Owner Rights security principal to objects:  
  
-   All the domain controllers in your organization should have the Windows Server 2008 operating system installed. If you have any domain controllers in your organization that have pre–Windows Server 2008 operating systems, those operating systems ignore the Owner Rights security principal, and the same permission that applied to owners of objects—the WRITE\_DAC permission—will apply.  
  
## More information  
 For more information about Owner Rights, see Security Identifiers \(SIDs\) New for Windows Vista \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=129376](http://go.microsoft.com/fwlink/?LinkId=129376)\).  
  
  