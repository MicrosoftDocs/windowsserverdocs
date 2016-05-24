---
title: HRA Server Migration: Post-migration Tasks
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ddb3994a-0cf8-4462-8f89-d420cf122766
author: vhorne
---
# HRA Server Migration: Post-migration Tasks
After all migration steps are complete and you have verified the migration of the Health Registration Authority \(HRA\) role service, perform the following post\-migration tasks.  
  
## Deploying final client settings  
To finish deploying the destination server, all NAP clients must be updated to obtain a health certificate from the destination server URL instead of the source server URL \(if different\). These settings are typically configured using Group Policy. If the source and destination URLs are different, each GPO in your NAP deployment that uses the new trusted server group settings must be modified. If your organization uses other methods to push NAP client settings to clients, then you might also need to modify those procedures.  
  
> [!WARNING]  
> If you have configured HRA automatic discovery on your network and the name of your source and destination HRA servers are different, you must modify DNS service \(SRV\) records to deploy the new trusted server group setting to client computers. For more information, see [Configure HRA Automatic Discovery](http://go.microsoft.com/fwlink/?LinkId=164274).  
  
#### To configure final NAP client settings in group policy  
  
1.  On a domain controller or member server with the Group Policy Management feature installed, click **Start**, click **Run**, type **gpmc.msc**, and then press ENTER.  
  
2.  In the Group Policy Management console tree, open **Group Policy Objects**, right\-click the name of the GPO you want to edit, and then click **Edit**. The Group Policy Management Editor opens.  
  
3.  In the console tree, open **Computer Configuration\/Policies\/Windows Settings\/Security Settings\/Network Access Protection\/NAP Client Configuration\/Health Registration Settings\/Trusted Server Groups**.  
  
4.  Delete the secondary trusted server group that was added for testing purposes. To delete this group, right\-click the name of the trusted server group, and click **Delete**.  
  
5.  Double\-click the name of the primary trusted server group you wish to edit.  
  
6.  Click the URL of the source server in the list, and then click **Edit**.  
  
7.  Replace the source server URL with the destination server URL.  
  
8.  Click **OK**.  
  
9. In the console tree, right\-click **NAP Client Configuration**, and then click **Apply**.  
  
10. Close the Group Policy Management Editor window.  
  
11. If you are prompted to apply settings, click **Yes**.  
  
12. Repeat the testing procedure as described in [HRA Server Migration: Verifying the Migration](assetId:///add013b0-170d-46fe-9f1e-4e2d71388e35) to verify that deployment of the destination server is successful.  
  
## Restoring the role in the event of migration failure  
If the destination server is deployed simultaneously with the source server using a different host name, then the configuration prior to migration can be restored by changing the NAP client settings to use the URL of the source HRA server. To restore the previous configuration, perform the steps described in the **Deploying final client settings** section of the [HRA Server Migration: Verifying the Migration](assetId:///add013b0-170d-46fe-9f1e-4e2d71388e35) topic, replacing the destination server URL with the source server URL.  
  
If the destination server replaced the source server using the same host name, then the destination server will need to be renamed, unjoined from the domain, or otherwise decommissioned in order to bring the source server back online.  
  
## Retiring the Source Server  
Once the destination HRA has been configured, tested, and verified, and the URL of the source HRA has been removed from group policy, then the HRA role on the source server may be retired.  
  
-   The source server can be taken offline and physically retired or repurposed. Follow your organization’s policy regarding server decommissioning.  
  
-   To retire only the HRA role on the source server, in the Server Manager console tree, click **Network Policy and Access Services**. In the details pane, click **Remove Role Services**, and then use the Remove Role Services wizard to select and remove the HRA role service.  
  
> [!NOTE]  
> If the source server was configured to use a certification authority on a different machine, consider removing permissions for the source server from the certification authority.  
  
## Troubleshooting migration  
If you encounter problems while verifying the HRA migration, see [Fixing Health Certificate Problems](http://go.microsoft.com/fwlink/?LinkId=164275) in the [NAP Troubleshooting Guide](http://go.microsoft.com/fwlink/?LinkId=164276) for help troubleshooting these problems.  
  
## See Also  
[HRA Migration Guide](assetId:///560d19ff-2d28-4818-b5ef-99799b46e617)  
[HRA Server Migration: Preparing to Migrate](../Topic/HRA-Server-Migration--Preparing-to-Migrate.md)  
[HRA Server Migration: Migrating the HRA Server](assetId:///edea1652-8847-4b0a-823a-1bfd3d726d6c)  
[HRA Server Migration: Verifying the Migration](assetId:///add013b0-170d-46fe-9f1e-4e2d71388e35)  
[Network Access Protection Design Guide](http://go.microsoft.com/fwlink/p/?linkid=229363)  
[Network Access Protection Deployment Guide](http://go.microsoft.com/fwlink/p/?linkid=229364)  
  
