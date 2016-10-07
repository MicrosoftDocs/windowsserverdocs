---
title: Working with Domains, Forests, and Sites Using GPMC
description: "Group Policy"
ms.prod: windows-server-threshold
ms.technology: manage-group-policy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5e443c0d-c7e9-4425-b603-5cc6e019605e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---


# Working with Domains, Forests, and Sites Using GPMC

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic contains procedures for managing domains, forests and sites as a Group Policy administrator using the Group Policy Management Console.

## About domains, forests and sites
Group Policy Management Console (GPMC) allows you to manage Group Policy for existing domains, forests and sites from within the GPMC. You can point the GPMC to anyone of these entities to create and maintain GPOs. GPOs for domains that are associated with an external trust relationship can be managed this way if the forest is identified, however, GPOs cannot be linked outside of the forest.

## How to add a domain
After performing this procedure, you can view and manage an existing Active Directory domain using Group Policy Management Console (GPMC). Adding a domain to GPMC does not actually create a new domain in Active Directory but allows you to view and manage that domain from the GPMC. In the GPMC, domains are always shown as peers of each other, regardless of their actual relationship. Also, you can use the **Add Forest** function to add externally trusted domains.

#### To add a domain in GPMC

1.  In the GPMC console tree, double-click the forest to which you want to add a domain, right-click **Domains**, and then click **Show Domains**.

2.  In the **Show Domains** dialog box, select the check box next to each domain to be added to GPMC, and then click **OK**.

## How to specify a domain controller
All operations performed in a domain on Group Policy Objects, security groups, and organizational units use the domain controller that you specify for the domain. All operations performed on links to sites use the domain controller that you specify for the sites.

#### To specify a domain controller

1.  In the Group Policy Management Console (GPMC) console tree, perform one of the following actions:

    -   If you want to specify the domain controller for a domain, double-click the forest containing the domain of interest, double-click **Domains**, right-click the domain of interest, and then click **Change Domain Controller**.

    -   If you want to specify the domain controller for a site, double-click the forest that contains the sites of interest, right-click **Sites**, and then click **Change Domain Controller**. In the **Look in this domain** drop-down list of the **Change Domain Controller** dialog box, select the domain in which the domain controller resides.

2.  Select the domain controller option from the **Change Domain Controller** dialog box and click **OK**.

## How to add a forest
Adding a forest to GPMC does not create a new forest in Active Directory but allows you to view and manage that forest from the GPMC. Group Policy Objects cannot be linked outside a forest.

GPMC supports management of multiple forests from within the console, when there is trust between the target forest and the forest of your user object. You can use the **Add Forest** function to add externally trusted domains, even if you do not have forest trust with the entire forest. However, you must have trust between the domain you want to add and the domain of your user object.

#### To add a forest

1.  In the Group Policy Management Console (GPMC) console tree, right-click **Group Policy Management**, and then click **Add Forest**.

2.  In the **Add Forest** dialog box, type the DNS or NetBIOS name of any domain in the forest, and then click **OK**.

You can specify either the DNS name or the NetBIOS name of any domain in the forest. If you specify a NetBIOS name, you must confirm that the NetBIOS name corresponds to the DNS name of the domain.

## How to add a site
Sites do not appear in the console tree unless you explicitly add them. Adding a site to the GPMC does not create a new site but allows you to view and manage that site from the GPMC.

#### To add a site

1.  In the Group Policy Management Console (GPMC) console tree, double-click the forest in which you want to add a site, right-click **Sites**, and then click **Show Sites**.

2.  In the **Show Sites** dialog box, select the check box next to each site you wish to display in the console tree, and then click **OK**.


