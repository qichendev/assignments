Switch#show vlan brief

VLAN Name Status Ports

---

1 default active  
64 Sixtyfour active Fa0/1, Fa0/2, Fa0/3, Fa0/4
Fa0/5, Fa0/6, Fa0/7, Fa0/8
Fa0/9
128 onetwentyeight active Fa0/10, Fa0/11, Fa0/12, Fa0/13
Fa0/14, Fa0/15, Fa0/16, Fa0/17
Fa0/18, Fa0/19
192 oneninetytwo active Fa0/20, Fa0/21, Fa0/22, Fa0/23
Fa0/24
1002 fddi-default active  
1003 token-ring-default active  
1004 fddinet-default active  
1005 trnet-default active  
Switch#
%CDP-4-NATIVE_VLAN_MISMATCH: Native VLAN mismatch discovered on GigabitEthernet0/2 (99), with Switch GigabitEthernet0/2 (1).

Switch#show interfaces trunk
Port Mode Encapsulation Status Native vlan
Gig0/1 on 802.1q trunking 99
Gig0/2 on 802.1q trunking 99

Port Vlans allowed on trunk
Gig0/1 64,99,128,192
Gig0/2 64,99,128,192

Port Vlans allowed and active in management domain
Gig0/1 64,128,192
Gig0/2 64,128,192

Port Vlans in spanning tree forwarding state and not pruned
Gig0/1 64,128,192
Gig0/2 64,128,192

Switch#
