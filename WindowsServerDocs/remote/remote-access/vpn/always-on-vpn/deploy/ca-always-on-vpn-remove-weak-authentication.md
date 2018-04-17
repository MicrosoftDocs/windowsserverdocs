---
title: Conditional Access for Always On VPN - Remove Weak Authentication Methods
description: If Standard VPN is verified to be working correctly, proceed with removing weak authentication protocols and enforcing Certificate Authentication using Protected Extensible Authentication Protocol (PEAP). 
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.date: 3/13/2018
ms.assetid: 8fe1c810-4599-4493-b4b8-73fa9aa18535
manager: alanth
ms.author: pashort
author: shortpatti
---

## STEP 6: Remove Weak Authentication Methods
If Standard VPN is verified to be working correctly, proceed with removing weak authentication protocols and enforcing Certificate Authentication using Protected Extensible Authentication Protocol (PEAP). 

>[!IMPORTANT]
>IKEv2 gateway enforcement can be configured in NPS to prevent connections from being allowed from anything but certificates that chain to the **AAD Conditional Access** root certificate by adding a Vendor Specific setting to the Network Policy. The attribute is _Allowed-Certificate-OID_, and should contain the AAD Conditional Access OID. Doing this will prevent client certificates that do not have the AAD Conditional Access OID from satisfying the request. Alternatively, customers that happen to be using RRAS as their gateway can implement gateway enforcement against RRAS, if they prefer not to do it in NPS. See Gateway Enforcement in this article. 

**Procedure**

1. In the Routing and Remote Access MMC, expand **Policies\\Network Policies**.

2.  Right-\click the **Connections to Microsoft Routing and Remote Access Server** network policy and select **Properties**.

3.  Click the **Constraints** tab and do the following:

   1. Under EAP Types, select the **Microsoft Encrypted Authentication version 2 (MS-CHAPv2)** check box and click **Remove**.

   2. Under EAP Types, click **Add**, select the **Microsoft: Protected EAP \(PEAP\)** check box, and click **OK**.

   3. Select **Microsoft: Protected EAP \(PEAP\)** and click **Move Up** to place it at the top of the order.

   4. Select **Microsoft: Protected EAP \(PEAP\)** again and click **Edit**.

4. On the Add EAP page, click **Add**.

5. Select **Smart Card or other certificate**, and click **OK**.

6. Select **Smart Card or other certificate** and click **Move Up** to place it at the top of the order.

7. For everything under Less secure authentication methods, clear all the check boxes, and click **OK**.

8. (Optional) If you have implemented [Gateway Enforcement](#gateway-enforcement), do the following:

   1. Under Vendor Specific, click **Add**.

   2. Select the first option of **Allowed-Certificate-OID** and click **Add**.
   
   3. Paste the AAD Conditional Access OID as the attribute value and click **OK** twice.

9. Click **Close** and click **Apply**.