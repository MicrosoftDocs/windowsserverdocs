---
title: Monitor Resource Attribute Definitions
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 878bd145-cad5-410c-98fd-d6bcea9b8eb2
---
# Monitor Resource Attribute Definitions
This topic for the IT professional describes how to monitor changes to resource attribute definitions when you are using Advanced Security Auditing options to monitor dynamic access control objects.

Resource attribute definitions define the basic properties of resource attributes, such as what it means for a resource to be defined as “high business value.” Resource attribute definitions are stored in AD DS under the Resource Properties container. Changes to these definitions could significantly change the protections that govern a resource, even if the resource attributes that apply to the resource remain unchanged. Changes can be monitored like any other AD DS object.

For information about monitoring changes to the resource attributes that apply to files, see [Monitor the Resource Attributes on Files and Folders](Monitor-the-Resource-Attributes-on-Files-and-Folders.md).

> [!NOTE]
> The contents of this topic apply to the list of supported Windows operating systems designated in the **Applies To** list at the beginning of this topic.

Use the following procedures to configure settings to monitor changes to resource attribute definitions in AD DS and to verify the changes. These procedures assume that you have configured and deployed Dynamic Access Control, including central access policies, claims, and other components, in your network. If you have not yet deployed Dynamic Access Control in your network, see [Deploy a Central Access Policy \(Demonstration Steps\)](http://technet.microsoft.com/library/hh846167.aspx).

> [!NOTE]
> Your server might function differently based on the version and edition of the operating system that is installed, your account permissions, and your menu settings.

#### To configure settings to monitor changes to resource attributes

1.  Sign in to your domain controller by using domain administrator credentials.

2.  In Server Manager, point to **Tools**, and then click **Group Policy Management**.

3.  In the console tree, right\-click the Group Policy Object for the default domain controller, and then click **Edit**.

4.  Double\-click **Computer Configuration**, click **Security Settings**, expand **Advanced Audit Policy Configuration**, expand **System Audit Policies**, click **DS Access**, and then double\-click **Audit directory service changes**.

5.  Select the **Configure the following audit events** check box, select the **Success** check box \(and the **Failure** check box, if desired\), and then click **OK**.

6.  Close the Group Policy Management Editor.

7.  Open the Active Directory Administrative Center.

8.  Under **Dynamic Access Control**, right\-click **Resource Properties**, and then click **Properties**.

9. Click the **Security** tab, click **Advanced** to open the **Advanced Security Settings** dialog box, and then click the **Auditing** tab.

10. Click **Add**, add a security auditing setting for the container, and then close all Security properties dialog boxes.

After you configure settings to monitor changes to resource attributes in AD DS,  verify that the changes are being monitored.

##### To verify that changes to resource definitions are monitored

1.  Sign in to your domain controller by using domain administrator credentials.

2.  Open the Active Directory Administrative Center.

3.  Under **Dynamic Access Control**, click **Resource Properties**, and then double\-click a resource attribute.

4.  Make changes to this resource attribute.

5.  Click **OK**, and then close the Active Directory Administrative Center.

6.  In Server Manager, click **Tools**, and then click **Event Viewer**.

7.  Expand **Windows Logs**, and then click **Security**. Verify that event 5137 appears in the security log.

### Related resource
[Using Advanced Security Auditing Options to Monitor Dynamic Access Control Objects](../Using-Advanced-Security-Auditing-Options-to-Monitor-Dynamic-Access-Control-Objects.md)


