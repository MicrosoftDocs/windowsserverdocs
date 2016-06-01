---
title: Step 3: Determine Activation Method and Product License Requirements
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e5ff1ace-ea88-4f3e-a382-a3ab3decebea
---
# Step 3: Determine Activation Method and Product License Requirements
After selecting the activation methods that are appropriate for your organization in [Step 2: Evaluate Client Connectivity](Step-2--Evaluate-Client-Connectivity.md), the next step is mapping computers that are using volume activation to activation methods. After you complete this step, you can complete your volume activation deployment plan by completing the steps in [Step 4: Determine Monitoring and Reporting Needs](Step-4--Determine-Monitoring-and-Reporting-Needs.md).

You can use the following planning table to ensure that all computers are associated with an activation option.

|Criteria|Activation Method|Number of Computers|
|------------|---------------------|-----------------------|
|Number of computers running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or newer that will connect to the network at least once every 180 days \(directly or through a VPN\)|Active Directory\-based Activation||
|Number of computers not running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or newer that will connect to the network at least once every 180 days \(directly or through a VPN\), and where the KMS activation threshold is met|KMS||
|Number of computers that do not connect to network at least once every 180 days|MAK||
|Number of computers running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or newer in isolated networks that connect at least once every 180 days to the core network|Active Directory\-based Activation or KMS||
|Number of computers not running [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] or newer in isolated networks that can contact a KMS host|KMS||
|Number of computers in isolated networks where the KMS activation threshold is not met|MAK||
|Number of computers in test and development labs that will not be activated|None||

## <a name="BKMK_Links"></a>See also

-   [Step 4: Determine Monitoring and Reporting Needs](Step-4--Determine-Monitoring-and-Reporting-Needs.md)

-   [Step 2: Evaluate Client Connectivity](Step-2--Evaluate-Client-Connectivity.md)

-   [Plan for Volume Activation](Plan-for-Volume-Activation.md)

-   [Test Lab Guide: Demonstrate Volume Activation Services](Test-Lab-Guide--Demonstrate-Volume-Activation-Services.md)


