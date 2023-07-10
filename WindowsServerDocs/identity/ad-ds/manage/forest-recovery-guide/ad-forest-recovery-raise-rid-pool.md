---
description: "Learn more about: AD Forest Recovery - Raising the value of available RID pools"
title: AD Forest Recovery - Raising RID pools
ms.author: daveba
author: iainfoulds
manager: daveba
ms.date: 06/21/2023
ms.topic: article
ms.custom: c37bc129-a5e0-4219-9ba7-b4cf3a9fc9a4, inhenkel
---

# Active Directory Forest Recovery - Raise the value of available RID pools

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Use the following procedure to raise the value of the relative ID (RID) pools that the RID operations master will allocate after that DC is restored. By raising the value of the available RID pools, you can ensure that no DC allocates a RID for a security principal that was created after the backup that was used to restore the domain.

## Active Directory RID Pools and rIDAvailablePool

Each domain has an object **CN=RID Manager$,CN=System,DC**=<*domain_name*>. This object has an attribute named **rIDAvailablePool**. This attribute value maintains the global RID space for an entire domain. The value is a large integer with upper and lower parts. The upper part defines the number of security principals that can be allocated for each domain (0x3FFFFFFF or just over 1 billion). The lower part is the number of RIDs that have been allocated in the domain.

> [!NOTE]
> In Windows Server 2016 and 2012, the number of security principals that can be allocated is increased to just over 2 billion. For more information, see [Managing RID issuance](../Managing-RID-Issuance.md).

- Sample Value: 4611686014132422708
- Low Part: 2100 (beginning of the next RID pool to be allocated)
- Upper Part: 1073741823 (total number of RIDs that can be created in a domain)

When you increase the value of the large integer, you increase the value of the low part. For example, if you add 100,000 to the sample value of 4611686014132422708 for a sum of 4611686014132522708, the new low part is 102100. This indicates that the next RID pool that will be allocated by the RID master will begin with 102100 instead of 2100.

### Raise the value of available RID pools using adsiedit and the calculator

1. Open Server Manager, select **Tools** and select **ADSI Edit**.
1. Right-click, select **Connect to** and connect do the Default Naming Context and select **OK**.
    :::image type="content" source="media/adsi1.png" alt-text="Screenshot that shows how to connect to the Default Naming Context":::
1. Browse to the following distinguished name path: **CN=RID Manager$,CN=System,DC=\<domain name>**.
    :::image type="content" source="media/adsi2.png" alt-text="Screenshot that shows how to browse to the distinguished name path.":::
1. Right-click and select the properties of **CN=RID Manager$**.
1. Select the attribute **rIDAvailablePool**, select **Edit**, and then copy the large integer value to the clipboard.
    :::image type="content" source="media/adsi3.png" alt-text="Screenshot that shows the selected rIDAvailablePool attribute.":::
1. Start calculator, and from the **View** menu, select **Scientific Mode**.
1. Add 100,000 to the current value.
    :::image type="content" source="media/adsi4.png" alt-text="Screenshot that shows where to add 100,000 to the current value.":::
1. Using ctrl-c, or the **Copy** command from the **Edit** menu, copy the value to the clipboard.
1. In the edit dialog of adsiedit, paste this new value.
    :::image type="content" source="media/adsi5.png" alt-text="ADSI Edit":::
1. Select **OK** in the dialog, and **Apply** in the property sheet to update the **rIDAvailablePool** attribute.

### Raise the value of available RID pools using LDP

1. At the command prompt, type the following command, and then press ENTER:
   **ldp**
1. Select **Connection**, select **Connect**, type the name of RID manager, and then select **OK**.
   :::image type="content" source="media/ldp1.png" alt-text="Screenshot that shows where to type the name of the RID manager.":::
1. Select **Connection**, select **Bind**, select **Bind with credentials** and type your administrative credentials, and then select **OK**.
   :::image type="content" source="media/ldp2.png" alt-text="Screenshot that shows the Bind with credentials option.":::
1. Select **View**, select **Tree** and then type the following distinguished name path:  CN=RID Manager$,CN=System,DC=*domain name*
   :::image type="content" source="media/ldp3.png" alt-text="Screenshot that shows where you type the distinguished name path.":::
1. Select **Browse**, and then select **Modify**.
1. Add 100,000 to the current **rIDAvailablePool** value, and then type the sum into **Values**.
1. In **Dn**, type `cn=RID Manager$,cn=System,dc=`*<domain name\>*.
1. In **Edit Entry Attribute**, type `rIDAvailablePool`.
1. Select **Replace** as the operation, and then select **Enter**.
   :::image type="content" source="media/ldp4.png" alt-text="Screenshot that shows the Replace option.":::
1. Select **Run** to run the operation. Select **Close**.
1. To validate the change, select **View**, select **Tree**, and then type the following distinguished name path:   CN=RID Manager$,CN=System,DC=*domain name*.   Check the **rIDAvailablePool** attribute.
   :::image type="content" source="media/ldp5.png" alt-text="LDP":::

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]