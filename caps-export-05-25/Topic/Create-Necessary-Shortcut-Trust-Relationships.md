---
title: Create Necessary Shortcut Trust Relationships
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d3c09bdb-79da-461c-88b2-957b437dd512
author: Femila
---
# Create Necessary Shortcut Trust Relationships
  You can use this procedure to create the necessary shortcut trust relationships for a domain rename operation. You can reposition any domain within the domain tree hierarchy of a forest, with the exception of the forest\-root domain. In other words, although the forest root domain can be renamed \(its Domain Name System \(DNS\) and NetBIOS names can change\), it cannot be repositioned in such a way that you designate a different domain to become the new forest root domain. If your domain rename operation involves restructuring the forest by repositioning the domains in the domain tree hierarchy, as opposed to simply changing the names of the domains in\-place, first create the necessary shortcut trust relationships between domains so that the new forest structure has two\-way, transitive trust paths between every pair of domains in the target forest, just as your current forest does.  
  
## Types of trust relationships  
 A hierarchy of Active Directory domains is implemented by trust relationships between domains. The following types of trust relationships are established between domains within an Active Directory forest:  
  
-   Parent\-child: The trust that is established when you create a new domain in an existing tree in the forest. The Active Directory Domain Services \(AD DS\) installation process creates a transitive, two\-way trust relationship automatically between the new domain \(the child domain\) and the domain that immediately precedes it in the namespace hierarchy \(the parent domain\).  
  
-   Tree\-root: The trust that is established when you add a new domain tree to the forest. The installation process for AD DS creates a transitive, two\-way trust relationship automatically between the domain that you are creating \(the new tree\-root domain\) and the forest root domain.  
  
-   Shortcut: A manually created, one\-way, transitive trust relationship between any two domains in the forest, created to shorten the trust path. To establish two\-way, shortcut trust relationships between two domains, you set up a shortcut trust relationship manually in each direction.  
  
 The effect of the transitive, two\-way trust relationships that are created automatically by the installation process for AD DS is that there is complete trust between all domains in an Active Directory forest—every domain has a transitive trust relationship with its parent domain, and every tree\-root domain has a transitive trust relationship with the forest root domain. If you use the domain rename operation to restructure an existing Active Directory forest by altering the domain tree hierarchy, automatic creation of the necessary trust relationships does not occur. For this reason, as part of the preparation phase of domain rename, the trust relationships that are required to preserve complete trust between all domains in your new forest \(after restructuring\) must be precreated manually.  
  
## Precreating parent\-child trust relationships for a restructured forest  
 If you plan to use the domain rename operation to reposition one or more domains in the domain tree hierarchy, for each domain that you plan to reposition, the necessary shortcut trust relationships must be created between the domain that you want to reposition and its new parent domain \(or the forest root domain, if the repositioned domain becomes a tree root\). These precreated trust relationships substitute for the required tree\-root or parent\-child trust relationships that will be missing in the restructured forest.  
  
### Precreating a parent\-child trust relationship  
 For example, suppose that you want to restructure the cohowinery.com forest, shown in the following illustration, so that the products.sales.cohowinery.com domain becomes a child of the cohowinery.com domain. Before you perform the domain rename operation to carry out this restructure, you must first create a two\-way, transitive shortcut trust relationship between products.sales.cohowinery.com and cohowinery.com. This trust relationship precreates the two\-way, parent\-child trust relationship that will be required for the targeted parent and child domains.  
  
 The following illustration shows the “before” and “after” domain structures and the shortcut trust relationships you have to create that will serve as parent\-child trust relationships in the target forest.  
  
 ![](../Image/6f45ec60-1ea8-43de-9214-2c7205913564.gif)  
  
### Pre\-creating multiple parent\-child trust relationships  
 For scenarios in which you have to restructure a domain that is both a child domain and a parent domain, you might have to create shortcut trust relationships in two places. For example, suppose that you want to restructure the cohowinery.com forest, shown in the following illustration, to move the hr.sales.cohowinery.com domain so that it becomes a child of the eu.cohowinery.com domain. At the same time, you want to make its child domain, payroll.hr.sales.cohowinery.com, become a direct child of its current parent domain, sales.cohowinery.com. To perform this restructure operation, you first have to create two shortcut trust relationships that will become the parent\-child trust relationships for the new forest that follows the restructuring, as shown:  
  
-   A two\-way, transitive shortcut trust relationship between the eu.cohowinery.com and hr.sales.cohowinery.com domains, which will create a two\-way, transitive parent\-child trust relationship between eu.cohowinery.com and hr.eu.cohowinery.com after restructuring  
  
-   A two\-way, transitive shortcut trust relationship between the sales.cohowinery.com and payroll.hr.sales.cohowinery.com domains, which will create a two\-way, transitive parent\-child trust relationship between sales.cohowinery.com and payroll.sales.cohowinery.com after restructuring  
  
 ![](../Image/2f9c72ff-820a-4404-8186-bbbbc6117c55.gif)  
  
 These shortcut trusts are responsible for maintaining the two\-way, transitive trust relationships that are required between the newly renamed domains when the domain rename operation is complete.  
  
### Precreating a tree\-root trust relationship with the forest root domain  
 When a domain is renamed to become a new tree root, the new tree\-root domain must have a two\-way, transitive trust relationship with the forest root domain. For this scenario, you create a two\-way shortcut trust relationship between the domain that you want to rename to become a new tree\-root domain and the forest root domain.  
  
 For example, suppose that you have a deep tree and you want to create a new tree by moving the lowest\-level domain to become a tree\-root domain. The following illustration shows the two\-way shortcut trust relationship that you create, and the tree\-root trust relationship it provides after the restructure, when you rename the eu.sales.cohowinery.com domain to create the tree\-root domain cohoeurope.com.  
  
 ![](../Image/73497fbc-1760-45d4-bf6e-7222b33b91f4.gif)  
  
### Creating shortcut trust relationships  
 Analyze the target forest structure that you intend to achieve. Consider the requirement of a two\-way, transitive trust relationship between each pair of domains in the forest, and create a list of shortcut trust relationships that are necessary to preserve full trust relationships between all the domains in the target forest. Create the shortcut trust relationships so that they are in place when you begin the domain rename procedure. You can use "Worksheet 2: Trust Information" in [Appendix D: Worksheets for the Domain Rename Operation](../Topic/Appendix-D--Worksheets-for-the-Domain-Rename-Operation.md) to document all trust relationships that are necessary to preserve full trust relationships between all the domains in the target forest.  
  
 For information about how to create shortcut trust relationships, see Create a Shortcut Trust \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=124112](http://go.microsoft.com/fwlink/?LinkId=124112)\).  
  
  