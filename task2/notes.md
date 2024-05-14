# Creating a tunnel

To create a VPN gateway and tunnel between US and EU regions using Terraform, you need the following resources:

Google Compute Network: This is the virtual network in which your VPN gateway will reside.

Google Compute Subnetwork: This is the subnet within your virtual network.

Google Compute VPN Gateway: This is the VPN gateway that will be used to create the VPN tunnel.

Google Compute Forwarding Rule: This is required to forward ESP (Encapsulating Security Payload) traffic to the VPN gateway.

Google Compute Address: This is the reserved IP address for the forwarding rule.

Google Compute VPN Tunnel: This is the VPN tunnel that connects the VPN gateways in the US and EU regions.