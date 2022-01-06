(*Visu-----------------------------------------------------*)

TYPE
	VisuCtl_typ : 	STRUCT  (*Structure Type for Visualization Control*)
		cmd : Visu_cmd_typ; (*Command of the Visualization *)
	END_STRUCT;
	Visu_cmd_typ : 	STRUCT  (*Structure Type for Visualization Commands*)
		bEnableArUser : BOOL; (*Diables/Enables The Display of User Management Page that usesAr User for User Management*)
		bEnableMpUserX : BOOL; (*Diables/Enables The Display of User Management Page that usesAr User for User Management*)
	END_STRUCT;
END_TYPE
