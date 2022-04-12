                                                                      
 TYPE
	cfgLease_typ : STRUCT				(*lease structure*)
		name			: STRING[8];	(*name of lease (max 8)*)
		startAdr		: STRING[16];	(*start address of lease*)
		stopAdr			: STRING[16];	(*stop address of lease*)
		subnetMask		: STRING[16];	(*subnet mask of lease*)
		defaultGateway	: STRING[16];	(*default gateway of lease*)
		leaseTimeout	: DINT;			(*-1 for infinite timeout*)
	END_STRUCT;
END_TYPE
