---
title: Topology File Example
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1868c024-6391-469a-8184-1e37e8f06b96
---
# Topology File Example
You can use this topic to learn about topology files and how to import them into Network Controller. This topic includes an example topology file that you can modify and import into Network Controller.  
  
The example topology file below includes a single switch and two servers. Two interfaces of the first server are connected to the switch.   
  
You must provide the mandatory properties for all fabric objects before importing the example topology file into Network Controller.  
  
>[!IMPORTANT]  
>Before you import this topology file into Network Controller, you must provision Network Controller with the credentials that are used in the file for the host machines \(HostDummyCred\) and the switch \(DeviceDummyCred\).  
>  
>For network switches, only the generic properties \(OS, Model, Connections, SwitchType, RoleType, RackSlot, Vendor, Firmware, Serial, SwitchDesiredManagementState\) can be provided by using a file. In the file, you can also specify switch ports and port channels.  
  
## Example Topology File  
Following is the topology file example that you can modify and import into Network Controller.  
```  
<NetworkTopology xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">  
	<Switches>  
		<Switch>  
			<Name>Switch501</Name>  
			<SwitchDesiredManagementState>Unmanaged</SwitchDesiredManagementState>  
			<SwitchType>Access</SwitchType>  
			<RoleType>MultiLayerSwitch</RoleType>  
			<Connections>  
				<Connection>  
					<CredentialType>SnmpCommunityString</CredentialType>  
					<CredentialId>DeviceDummyCred</CredentialId>  
					<ManagementAddresses>  
						<ManagementAddress>20.1.1.1</ManagementAddress>  
					</ManagementAddresses>  
				</Connection>  
			</Connections>  
			<SwitchPorts>  
				<SwitchPort>  
					<Name>1</Name>  
					<InterfaceName>Port1</InterfaceName>  
					<PortMode>L3</PortMode>  
					<PortNumber>1</PortNumber>  
					<IpAddresses>  
						<IpAddress>  
							<Address>20.1.1.2</Address>  
							<PrefixLength>16</PrefixLength>  
							<AddressFamily>IPv4</AddressFamily>  
						</IpAddress>  
					</IpAddresses>  
				</SwitchPort>  
				<SwitchPort>  
					<Name>2</Name>  
					<InterfaceName>Port2</InterfaceName>  
					<PortMode>L3</PortMode>  
					<PortNumber>2</PortNumber>  
					<IpAddresses>  
						<IpAddress>  
							<Address>20.1.1.3</Address>  
							<PrefixLength>16</PrefixLength>  
							<AddressFamily>IPv4</AddressFamily>  
						</IpAddress>  
					</IpAddresses>  
				</SwitchPort>  
			</SwitchPorts>			  
		</Switch>  
	</Switches>  
	<Servers>  
		<Server>  
			<Name>Server501</Name>  
			<Model>Minitower</Model>  
			<RackSlot>1</RackSlot>  
			<Serial>101010</Serial>  
			<Vendor>Dell</Vendor>  
			<OS>Windows</OS>  
			<Connections>  
				<Connection>  
					<CredentialType>UsernamePassword</CredentialType>  
					<CredentialId>HostDummyCred</CredentialId>  
					<ManagementAddresses>  
						<ManagementAddress>10.1.1.1</ManagementAddress>  
					</ManagementAddresses>  
				</Connection>  
			</Connections>  
			<NetworkInterfaces>  
				<NetworkInterface>  
					<InterfaceName>NetworkInterface501</InterfaceName>  
					<InterfaceIndex>1</InterfaceIndex>  
					<Mac>18-03-73-B3-C2-4B</Mac>  
					<AdminStatus>1</AdminStatus>  
					<OperationalStatus>1</OperationalStatus>  
					<InterfaceSpeed>300</InterfaceSpeed>  
					<isBMC>false</isBMC>  
					<VlanIds>  
						<VlanId>1</VlanId>  
						<VlanId>2</VlanId>  
					</VlanIds>  
					<IPConfigurations>  
						<IPConfiguration>  
							<IpAddress>1.1.1.1</IpAddress>  
							<NetworkPrefix>23</NetworkPrefix>  
							<IsDhcpEnabled>true</IsDhcpEnabled>  
						</IPConfiguration>  
						<IPConfiguration>  
							<IpAddress>2.2.2.2</IpAddress>  
							<NetworkPrefix>24</NetworkPrefix>  
							<IsDhcpEnabled>false</IsDhcpEnabled>  
						</IPConfiguration>  
					</IPConfigurations>  
				</NetworkInterface>  
				<NetworkInterface>  
					<InterfaceName>NetworkInterface502</InterfaceName>  
					<InterfaceIndex>1</InterfaceIndex>  
					<Mac>18-03-73-B3-C2-5B</Mac>  
					<AdminStatus>1</AdminStatus>  
					<OperationalStatus>1</OperationalStatus>  
					<InterfaceSpeed>300</InterfaceSpeed>  
					<isBMC>false</isBMC>  
					<VlanIds>  
						<VlanId>1</VlanId>  
						<VlanId>2</VlanId>  
					</VlanIds>  
					<IPConfigurations>  
						<IPConfiguration>  
							<IpAddress>3.3.3.3</IpAddress>  
							<NetworkPrefix>23</NetworkPrefix>  
							<IsDhcpEnabled>true</IsDhcpEnabled>  
						</IPConfiguration>  
						<IPConfiguration>  
							<IpAddress>4.4.4.4</IpAddress>  
							<NetworkPrefix>24</NetworkPrefix>  
							<IsDhcpEnabled>false</IsDhcpEnabled>  
						</IPConfiguration>  
					</IPConfigurations>  
				</NetworkInterface>  
			</NetworkInterfaces>  
		</Server>  
		<Server>  
			<Name>Server502</Name>  
			<Model>Minitower</Model>  
			<RackSlot>1</RackSlot>  
			<Serial>101010</Serial>  
			<Vendor>Dell</Vendor>  
			<OS>Windows</OS>  
			<Connections>  
				<Connection>  
					<CredentialType>UsernamePassword</CredentialType>  
					<CredentialId>HostDummyCred</CredentialId>  
					<ManagementAddresses>  
						<ManagementAddress>10.1.1.1</ManagementAddress>  
					</ManagementAddresses>  
				</Connection>  
			</Connections>  
			<NetworkInterfaces>  
				<NetworkInterface>  
					<InterfaceName>NetworkInterface501</InterfaceName>  
					<InterfaceIndex>1</InterfaceIndex>  
					<Mac>18-03-73-B3-C2-4B</Mac>  
					<AdminStatus>1</AdminStatus>  
					<OperationalStatus>1</OperationalStatus>  
					<InterfaceSpeed>300</InterfaceSpeed>  
					<isBMC>false</isBMC>  
					<VlanIds>  
						<VlanId>1</VlanId>  
						<VlanId>2</VlanId>  
					</VlanIds>  
					<IPConfigurations>  
						<IPConfiguration>  
							<IpAddress>1.1.1.1</IpAddress>  
							<NetworkPrefix>23</NetworkPrefix>  
							<IsDhcpEnabled>true</IsDhcpEnabled>  
						</IPConfiguration>  
						<IPConfiguration>  
							<IpAddress>2.2.2.2</IpAddress>  
							<NetworkPrefix>24</NetworkPrefix>  
							<IsDhcpEnabled>false</IsDhcpEnabled>  
						</IPConfiguration>  
					</IPConfigurations>  
				</NetworkInterface>  
				<NetworkInterface>  
					<InterfaceName>NetworkInterface502</InterfaceName>  
					<InterfaceIndex>1</InterfaceIndex>  
					<Mac>18-03-73-B3-C2-5B</Mac>  
					<AdminStatus>1</AdminStatus>  
					<OperationalStatus>1</OperationalStatus>  
					<InterfaceSpeed>300</InterfaceSpeed>  
					<isBMC>false</isBMC>  
					<VlanIds>  
						<VlanId>1</VlanId>  
						<VlanId>2</VlanId>  
					</VlanIds>  
					<IPConfigurations>  
						<IPConfiguration>  
							<IpAddress>3.3.3.3</IpAddress>  
							<NetworkPrefix>23</NetworkPrefix>  
							<IsDhcpEnabled>true</IsDhcpEnabled>  
						</IPConfiguration>  
						<IPConfiguration>  
							<IpAddress>4.4.4.4</IpAddress>  
							<NetworkPrefix>24</NetworkPrefix>  
							<IsDhcpEnabled>false</IsDhcpEnabled>  
						</IPConfiguration>  
					</IPConfigurations>  
				</NetworkInterface>  
			</NetworkInterfaces>  
		</Server>  
	</Servers>  
	<TopologyLinks>  
		<TopologyLink  
			Label="Link 1 between Server501 and Switch501">  
			<Type>Regular</Type>  
			<TerminationPoint1  
				ElementName="Server501"  
				InterfaceName="NetworkInterface501" />  
			<TerminationPoint2  
				ElementName="Switch501"  
				InterfaceName="1" />  
		</TopologyLink>  
		<TopologyLink  
			Label="Link 2 between Server501 and Switch501">  
			<Type>Regular</Type>  
			<TerminationPoint1  
				ElementName="Server501"  
				InterfaceName="NetworkInterface502" />  
			<TerminationPoint2  
				ElementName="Switch501"  
				InterfaceName="2" />  
		</TopologyLink>  
	</TopologyLinks>  
</NetworkTopology>  
  
```