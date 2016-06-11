---
title: Step 4: Determine Monitoring and Reporting Needs
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d50b73be-d0d5-4e7b-b245-4ebe67df5265
---
# Step 4: Determine Monitoring and Reporting Needs
After you have mapped computers that are using volume activation methods in [Step 3: Determine Activation Method and Product License Requirements](Step-3--Determine-Activation-Method-and-Product-License-Requirements.md), you can complete your volume activation deployment plan by determining your organization’s volume activation monitoring and reporting needs. When you have completed the planning steps in this section, you can deploy your volume activation infrastructure based on this plan.

Organizations that use the Volume Activation Services in  Windows Server 2012 need to track product key usage and the license conditions of activated computers. One tool that is available to volume licensing customers is the [Volume Licensing Service Center](http://go.microsoft.com/fwlink/?LinkId=107544). Volume licensing customers can log on to this website at any time to view their volume licensing key information. Several additional tools are available to help volume licensing customers manage activations and product key usage. This topic describes the available tools and how each assists volume licensing customers. The following sections list some initial considerations to review, in addition to hardware and software requirements for monitoring and reporting on volume activation.

The following table describes the leading management and reporting options for the Volume Activation services in versions starting with  Windows Server 2012 .

|Task|Description|
|--------|---------------|
|4.1 Managing Active Directory\-based Activation objects|Use Active Directory management tools to monitor and manage activation issues.|
|4.2 Managing Activation with System Center Configuration Manager|Use System Center Configuration Manager to monitor and manage activation issues.|
|4.3 Managing Activation by Using Event Logs|Use event logs to monitor and manage activation issues.|
|4.4 Managing Activation by Using the Volume Activation Management Tool \(VAMT\)|Use VAMT to monitor and manage activation issues.|

## 4.1 Managing Active Directory\-based Activation objects
Active Directory\-based Activation objects are held in the configuration partition of Active Directory. You can query the information about Active Directory\-based Activation objects by using ADSIEDIT.msc or the SLMGR.vbs command\-line interface.

ADSIEDIT allows members of the Enterprise Administrators group to change properties on the object or delete the object if they desire. Domain members have Read access. SLMGR allows an administrator to delete the object but not change its attributes.

ADSIEDIT or SLMGR allow administrators to gain other information about the Active Directory objects in their domain.

The following are a list of properties that can be reviewed by using ADSIEDIT:

-   Partial product key

-   KMS ProductID

-   Active Directory object creation date

-   Access control lists \(ACLs\)

SLMGR provides the following information about the Active Directory object:

-   License state information, including activation status

-   Ability to force immediate activation attempt

-   Disable or force Active Directory\-based Activation

-   Install MAK product key \(this disables Active Directory\-based Activation\)

-   List all installed Active Directory objects \(only available for accounts with rights to the Active Directory object container\)

-   Delete an Active Directory object \(only available for accounts with rights to the Active Directory object container\)

## 4.2 Managing Activation with System Center Configuration Manager
Data that is gathered during activation is accessible by using WMI. Several of the tools available use WMI to access volume activation data.

See Appendix 1 of the [Volume Activation 2.0 Operations Guide](http://technet.microsoft.com/library/cc303695.aspx#_Appendix_1:_WMI) for a list all of WMI methods, properties, registry keys, and event IDs for product activation. MAK and KMS can use System Center Configuration Manager to monitor the license conditions of their organization’s computers. For a detailed description of the available license conditions, see Appendix 2: License Conditions in this guide.

## 4.3 Managing Activation by Using Event Logs
The Volume Activation service and KMS service record every action in the application logs of the client and host computers. A client records activation requests, renewals, and responses in the client’s local application log by using Microsoft Windows Security Licensing \(SLC\) event numbers 12288 and 12289. The KMS host and domain controller log a separate entry for each request they receive from a client as SLC event number 12290. These entries are saved to the **Applications and Services Logs** folder. If you have multiple KMS hosts, each host keeps an individual log of activations. There is no replication of logs between KMS hosts.

## 4.4 Managing Activation by Using the Volume Activation Management Tool
Each MAK key has a predetermined number of allowed activations, based on an organization’s volume licensing agreement. Every activation with activation services that are hosted by Microsoft reduces the MAK activation pool by one. MAK implementations should include how your organization plans to monitor the number of MAK activations that are left. MAK Independent and MAK Proxy activations can use VAMT to monitor this.

## <a name="BKMK_Links"></a>See also

-   [Step 3: Determine Activation Method and Product License Requirements](Step-3--Determine-Activation-Method-and-Product-License-Requirements.md)

-   [Plan for Volume Activation](../Plan-for-Volume-Activation.md)

-   [Volume Activation Overview]()

-   [Volume Activation Management Tool \(VAMT\) Overview](http://go.microsoft.com/fwlink/?LinkId=214550)

-   [Test Lab Guide: Demonstrate Volume Activation Services](Test-Lab-Guide--Demonstrate-Volume-Activation-Services.md)


