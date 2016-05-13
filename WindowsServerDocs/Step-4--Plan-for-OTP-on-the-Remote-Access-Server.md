---
title: Step 4: Plan for OTP on the Remote Access Server
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4b97b2fd-767a-45c1-a64e-5b3edd0c8a47
---
# Step 4: Plan for OTP on the Remote Access Server
After planning for the one\-time password \(OTP\) RADIUS server and certificate settings, the final step in planning a Remote Access OTP deployment is to plan for client OTP settings on the Remote Access server.

|Task|Description|
|--------|---------------|
|[4.1 Plan for OTP client exemptions](assetId:///0beff91b-3815-4438-9b0e-420704cc5510#bkmk_4_1_Examptions)|Plan for exemptions for users that you do not require to authentication using OTP.|
|[4.2 Plan for Windows 7 clients](assetId:///0beff91b-3815-4438-9b0e-420704cc5510#bkmk_4_2_Win7)|Plan to deploy the DirectAccess Connectivity Assistant \(DCA\) 2.0 to [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] client computers.|
|[4.3 Plan for smart cards](assetId:///0beff91b-3815-4438-9b0e-420704cc5510#BKMK_smartcard)|Plan for the use of smart cards for additional authorization.|

## <a name="bkmk_4_1_Examptions"></a>4.1 Plan for OTP client exemptions
When OTP authentication is enabled, by default all users are required to authenticate using a combination of user name and password, and OTP credentials. However, you can allow selected users to authenticate using a user name and password only, without OTP. To do this, create a security group and add any users that you want to exempt from OTP authentication.

> [!NOTE]
> Only client computers from a single forest may be exempted due to the fact that only one security group can be selected for client exemptions.

## <a name="bkmk_4_2_Win7"></a>4.2 Plan for Windows 7 clients
By default, [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] client computers cannot authenticate using OTP. [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] client computers require DCA 2.0 to authenticate using OTP in a [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] Remote Access deployment. For more information about DCA 2.0, see [DirectAccess Connectivity Assistant 2.0](http://go.microsoft.com/fwlink/?LinkId=253699) on the Microsoft Download Center.

## <a name="BKMK_smartcard"></a>4.3 Plan for smart cards
When OTP authentication is enabled, the option to enable the use of smart cards for additional authorization is available. Create a security group to allow temporary access in the event that a user’s smart card is not functional.

## <a name="BKMK_Links"></a>See also

-   [Configure DirectAccess with OTP authentication](assetId:///bde70218-fcef-4ff5-ac78-31319cc2ea16)


