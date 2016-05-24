---
title: Windows Server 2008: Forest-Wide Updates
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8a2a8676-2714-4bf5-b68d-165348c091e0
author: Femila
---
# Windows Server 2008: Forest-Wide Updates
  If all the operations in the following list succeed, the CN\=ActiveDirectoryUpdate,CN\=ForestUpdates,CN\=Configuration,DC\=ForestRootDomain object is created and its revision attribute \(CN\=Revision in the schema, syntax Integer\) is set to 2.  
  
 For more information about how to interpret the access control entry \(ACE\) strings, see ACE strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137238](http://go.microsoft.com/fwlink/?LinkId=137238)\).  
  
 For more information about how to interpret the security ID \(SID\) strings, see SID strings \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=137240](http://go.microsoft.com/fwlink/?LinkId=137240)\).  
  
 44.{4c0672a2\-437c\-4944\-b9\-53\-5d\-b8\-f1\-11\-d6\-65}  
  
1.  Operation: merge a default security descriptor.  
  
2.  Merge a default security descriptor on the SAM\-Domain object with the path of the distinguished name CN\=SAM\-Domain,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
3.  Add \(OA;CIIO;CRRPWP;91e647de\-d96f\-4b70\-9557\-d63ff4f3ccd8;;PS\)  
  
4.  Add \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;BA\)  
  
5.  Add \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;ED\)  
  
 45.{4c022fd1\-adab\-4d84\-a7\-f1\-95\-80\-f0\-3d\-a8\-56}  
  
1.  Operation: merge a default security descriptor.  
  
2.  Merge a default security descriptor on the Domain\-DNS object with the path of the distinguished name CN\=Domain\-DNS,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
3.  Add \(OA;CIIO;CRRPWP;91e647de\-d96f\-4b70\-9557\-d63ff4f3ccd8;;PS\)  
  
4.  Add \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;BA\)  
  
5.  Add \(OA;;CR;1131f6ae\-9c07\-11d1\-f79f\-00c04fc2dcd2;;ED\)  
  
 46.{c03b1f37\-c240\-4910\-93\-c8\-15\-44\-a4\-52\-b4\-b5}  
  
1.  Operation: merge a default security descriptor.  
  
2.  Merge a default security descriptor on the NTFRS\-Replica\-Set object with the path of the distinguished name CN\= NTFRS\-Replica\-Set,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
3.  Add \(OA;;CCDC;2a132586\-9373\-11d1\-aebc\-0000f80367c1;;ED\)  
  
 49.{560cf82d\-9572\-48a3\-90\-24\-6f\-2b\-56\-f1\-f8\-66}  
  
1.  Operation: merge a default security descriptor.  
  
2.  Merge a default security descriptor on the User object with the path of the distinguished name CN\= User,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
3.  Add \(OA;;WPRP;5805bc62\-bdc9\-4428\-a5e2\-856a0f4c185e;;S\-1\-5\-32\-561\)  
  
 50.{abd97102\-88dd\-4013\-a0\-09\-0e\-2c\-2f\-96\-7f\-f6}  
  
1.  Operation: merge a default security descriptor.  
  
2.  Merge a default security descriptor on the inetOrgPerson object with the path of the distinguished name CN\= inetOrgPerson,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
3.  Add \(OA;;WPRP;5805bc62\-bdc9\-4428\-a5e2\-856a0f4c185e;;S\-1\-5\-32\-561\)  
  
 53.{134428a8\-0043\-48a6\-bc\-da\-63\-31\-0d\-9e\-c4\-dd}  
  
1.  Operation: Upgrade display specifier for E\-RODC  
  
 54.{d668ad1f\-cedd\-4565\-ab\-02\-93\-85\-92\-6c\-e4\-f5}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACE to CN\=Partitions  
  
     \(OA;CIIO;WP;3df793df\-9858\-4417\-a701\-735a1ecebf74;bf967a8d\-0de6\-11d0\-a285\-00aa003049e2;BA\)  
  
 55.{8f86b825\-c322\-4101\-ad\-c4\-57\-9f\-12\-d4\-45\-db}  
  
1.  Operation: Add an ACE to the configuration directory partition head.  
  
2.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 56.{9fea28ff\-387f\-4d57\-86\-6d\-38\-93\-c5\-0f\-37\-3f}  
  
1.  Operation: Add two ACEs to the schema directory partition head.  
  
2.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
3.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 57.{782370ce\-3d38\-438d\-8b\-0c\-46\-42\-20\-a3\-03\-9d};  
  
1.  Merge the default security descriptor on the Domain\-DNS object with the path of the distinguished name CN\=Domain\-DNS,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Add \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;; \<ERODC\-SID\>\)  
  
3.  Add \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;ED\)  
  
4.  Add \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;BA\)  
  
 58.{0x002fb291\-0d00\-4b0c\-8c\-00\-fe\-7f\-50\-ce\-6f\-8d};  
  
1.  Merge the default security descriptor on the SAM\-Domain object with the path of the distinguished name CN\=sam\-domain,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Add \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
3.  Add \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;ED\)  
  
4.  Add \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;BA\)  
  
 59.{0xdcb3c95d\-deb7\-4c51\-ad\-13\-43\-a7\-d5\-d0\-6f\-c7};  
  
1.  Delete the following object from the configuration directory partition head:  
  
2.  CN\=Enterprise Read\-only Domain Controllers,CN\=WellKnown Security Principals  
  
 60.{0xef010a1e\-bd88\-48c8\-a7\-af\-2a\-ff\-d2\-50\-d7\-7d};  
  
1.  Operation: Add two ACEs to the schema directory partition head.  
  
2.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;ED\)  
  
3.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;BA\)  
  
 61.{0xbd3413c0\-9559\-469b\-9f\-3d\-51\-d7\-fa\-ab\-d8\-1a};  
  
1.  Operation: Add two ACEs to the configuration directory partition head.  
  
2.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;ED\)  
  
3.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;BA\)  
  
 63.{0xf814097b\-3e3d\-49ba\-8a\-3a\-09\-2c\-25\-08\-5f\-06};  
  
1.  Operation: Add an ACE to the schema directory partition head.  
  
2.  \(OA;;CR;89e95b76\-444d\-4c62\-991a\-0facbeda640c;;\<ERODC\-SID\>\)  
  
 64.{0x6eb8eaf9\-3403\-4ba5\-8b\-4b\-ce\-34\-9a\-46\-80\-ad};  
  
1.  Operation: Add two ACEs to the following object:  
  
2.  CN\=DirectoryEmailReplication,CN\=Certificate Templates,CN\=Public Key Services,CN\=Services  
  
3.  \(OA;;RPCR;0e10c968\-78fb\-11d2\-90d4\-00c04f79dc55;;\<ERODC\-SID\>\)  
  
4.  \(OA;;RPCR;a05b8cc2\-17bc\-4802\-a710\-e7c15ab866a2;;\<ERODC\-SID\>\)  
  
 65.{0x07e57d28\-ad40\-44fc\-83\-34\-8a\-0d\-c1\-19\-b3\-f4};  
  
1.  Operation: Add two ACEs to the following object:  
  
2.  CN\=DomainControllerAuthentication,CN\=Certificate Templates,CN\=Public Key Services,CN\=Services  
  
3.  \(OA;;RPCR;0e10c968\-78fb\-11d2\-90d4\-00c04f79dc55;;\<ERODC\-SID\>\)  
  
4.  \(OA;;RPCR;a05b8cc2\-17bc\-4802\-a710\-e7c15ab866a2;;\<ERODC\-SID\>\)  
  
 66.{0x6fd48655\-1698\-497a\-ac\-8d\-82\-67\-ce\-01\-c8\-0b};  
  
1.  Operation: Add two ACEs to the following object:  
  
2.  CN\=KerberosAuthentication,CN\=Certificate Templates,CN\=Public Key Services,CN\=Services  
  
3.  \(OA;;RPCR;0e10c968\-78fb\-11d2\-90d4\-00c04f79dc55;;\<ERODC\-SID\>\)  
  
4.  \(OA;;RPCR;a05b8cc2\-17bc\-4802\-a710\-e7c15ab866a2;;\<ERODC\-SID\>\)  
  
 67.{0x10338d31\-2423\-4dff\-b4\-b5\-ef\-02\-51\-44\-b0\-1f};  
  
1.  Operation: Delete four ACEs from the Configuration directory partition head:  
  
2.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
3.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
4.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<E\-RODC SID\>\)  
  
5.  \(OA;;CR;1131f6ad\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<E\-RODC SID\>\)  
  
 68.{0xa96e2ed5\-7a7c\-4d5c\-9d\-5d\-96\-5e\-ca\-00\-51\-da};  
  
1.  Operation: Remove four ACEs from the Schema directory partition head:  
  
2.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
3.  \(OA;;CR;1131f6ad\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
4.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<E\-RODC SID\>\)  
  
5.  \(OA;;CR;1131f6ad\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<E\-RODC SID\>\)  
  
 69.{0x613bd063\-e8e9\-4a62\-8f\-4c\-cd\-a5\-66\-f7\-eb\-6f};  
  
1.  Merge the default security descriptor on the Domain\-DNS object with the path of the distinguished name CN\= Domain\-DNS,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Remove \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
3.  Remove \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<E\-RODC SID\>\)  
  
 70.{0x2a858903\-5696\-4364\-b4\-e5\-4c\-ac\-02\-7c\-a7\-a6};  
  
1.  Merge the default security descriptor on the sam\-domain object with the path of the distinguished name CN\= sam\-domain,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Remove \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;S\-1\-5\-22\)  
  
3.  Remove \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<E\-RODC SID\>\)  
  
 71.{0x0fc5a978\-0059\-4b0a\-9d\-c2\-98\-96\-e8\-e3\-89\-a1};  
  
1.  Merge the default security descriptor on the Domain\-DNS object with the path of the distinguished name CN\= Domain\-DNS,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Remove: \(AU;CISAFA;CCDCSWWPDTCRSDWDWO;;;S\-1\-1\-0\)  
  
3.  Add \(AU;SA;WDWOWP;;;S\-1\-1\-0\)  
  
4.  Add \(AU;SA;CR;;;BA\)  
  
5.  Add \(AU;SA;CR;;;DU\)  
  
6.  Add \(OU;CISA;WP;f30e3bbe\-9ff0\-11d1\-b603\-0000f80367c1;bf967aa5\-0de6\-11d0\-a285\-00aa003049e2;S\-1\-1\-0\)  
  
7.  Add \(OU;CISA;WP;f30e3bbf\-9ff0\-11d1\-b603\-0000f80367c1;bf967aa5\-0de6\-11d0\-a285\-00aa003049e2;S\-1\-1\-0\)  
  
 72.{0x4d753a29\-26ac\-4d1a\-bc\-80\-31\-1f\-94\-7e\-4f\-0a};  
  
1.  Merge the default security descriptor on the rid\-manager object with the path of the distinguished name CN\= rid\-manager,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Add \(AU;SA;CRWP;;;S\-1\-1\-0\)  
  
 73.{0x3b3adbdb\-4485\-4559\-ae\-d8\-98\-11\-c4\-bf\-90\-e4}  
  
1.  Merge the default security descriptor on the sam\-domain object with the path of the distinguished name CN\= sam\-domain,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Remove \(AU;CISAFA;CCDCSWWPDTCRSDWDWO;;;S\-1\-1\-0\)  
  
3.  Add \(AU;SA;WDWOWP;;;S\-1\-1\-0\)  
  
 74.{0x56040c71\-fe93\-4037\-8f\-e9\-1a\-4d\-1a\-28\-30\-09}  
  
1.  Merge the default security descriptor on the site object with the path of the distinguished name CN\=site,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
2.  Add \(A;;LCRPLORC;;;ED\)  
  
 75.{caa2bfad\-0cca\-483b\-8d\-00\-34\-7f\-94\-32\-92\-a8};  
  
1.  Operation: Add an ACE to the Configuration directory partition head  
  
2.  Add \(A;;RPLCLO;;;\<ERODC\-SID\>\)  
  
 76.{2b9e0609\-6d75\-498a\-97\-27\-c9\-fc\-c9\-3f\-0e\-42};  
  
1.  Operation: Add an ACE to the Schema directory partition head  
  
2.  Add \(A;;RPLCLO;;;\<ERODC\-SID\>\)  
  
 77.{96541a16\-910a\-4b66\-ac\-de\-72\-0a\-0d\-ff\-03\-c7};  
  
1.  Operation: Add an ACE to the object CN\=Partitions  
  
2.  Add \(A;CI;RPLCLO;;;\<ERODC\-SID\>\)  
  
 78.{429a6334\-1a00\-4515\-bf\-48\-67\-6d\-eb\-55\-95\-4a};  
  
1.  Operation: Add an ACE to the object CN\=Sites  
  
2.  Add \(A;CI;RPLCLO;;;\<ERODC\-SID\>\)  
  
## Previous forest upgrade changes to Adprep that are now removed  
 The following forest upgrade operations were present in Beta versions of Adprep for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] and then removed \(44, 45, 51, and 52\):  
  
 44.{f0bc5c3f\-4185\-49f3\-95\-d1\-db\-bd\-7d\-86\-55\-89}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACEs to Schema directory partition  
  
3.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
4.  \(OA;;CR;1131f6ad\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 45.{745738c0\-8303\-4be9\-af\-3d\-b6\-4a\-e4\-90\-0a\-27}  
  
1.  Operation: Add a set of ACEs to a specific object by using the object's distinguished name.  
  
2.  Add ACEs to Configuration directory partition  
  
3.  \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
4.  \(OA;;CR;1131f6ad\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 51.{40d4593d\-92e1\-4279\-97\-33\-d2\-b6\-f1\-8b\-77\-3f}  
  
1.  Operation: merge a default security descriptor.  
  
2.  Merge a default security descriptor on the Domain\-DNS object with the path of the distinguished name CN\=Domain\-DNS,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
3.  Add \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
 52.{42ccb194\-50cd\-452d\-a9\-54\-df\-13\-c6\-93\-d0\-3f}  
  
1.  Operation: merge a default security descriptor.  
  
2.  Merge a default security descriptor on the SAM\-Domain object with the path of the distinguished name CN\=SAM\-Domain,CN\=Schema,CN\=Configuration,DC\=ForestRootDomain  
  
3.  Add \(OA;;CR;1131f6aa\-9c07\-11d1\-f79f\-00c04fc2dcd2;;\<ERODC\-SID\>\)  
  
## See Also  
 [Windows Server 2008: Appendix of Changes to Adprep.exe to Support AD DS](../Topic/Windows-Server-2008--Appendix-of-Changes-to-Adprep.exe-to-Support-AD-DS.md)  
  
  