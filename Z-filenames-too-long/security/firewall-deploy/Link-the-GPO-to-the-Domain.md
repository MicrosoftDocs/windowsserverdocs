---
title: Link the GPO to the Domain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8b9d6673-be68-459b-ba37-fcf07cae5573
---
# Link the GPO to the Domain
After you create the GPO and configure it with security group filters and WMI filters, you must link the GPO to the container in Active Directory that contains all of the target computers.

If the filters comprehensively control the application of the GPO to only the correct computers, then you can link the GPO to the domain container. Alternatively, you can link the GPO to a site container or organizational unit if you want to limit application of the GPO to that subset of computers.

**Administrative credentials**

To complete this procedure, you must be a member of the Domain Admins group, or otherwise be delegated permissions to modify the GPOs.

### To link the GPO to the domain container in Active Directory

1.  On a computer that has the Group Policy Management feature installed, click the **Start** charm, and then click the **Group Policy Management** tile.

2.  In the navigation pane, expand **Forest:** *YourForestName*, expand **Domains**, and then expand *YourDomainName*.

3.  Right\-click *YourDomainName*, and then click **Link an Existing GPO**.

4.  In the **Select GPO** dialog box, select the GPO that you want to deploy, and then click **OK**.

5.  The GPO appears in the **Linked Group Policy Objects** tab in the details pane and as a linked item under the domain container in the navigation pane.

6.  You can adjust the order of the linked GPOs to ensure that the higher priority GPOs are processed last. Select a GPO and click the up or down arrows to move it. The GPOs are processed by the client computer from the highest link order number to the lowest.


