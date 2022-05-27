
FUNCTION_BLOCK MpRecipeRegParSync (*Declare a PV as a recipe parameter and perform synchronisation*) (* $GROUP=mapp Services,$CAT=XML Recipe,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpRecipe.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block *) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		PVName : REFERENCE TO STRING[100]; (*Name of the PV that should be saved to the recipe*) (* *) (*#PAR#;*)
		Category : REFERENCE TO STRING[50]; (*Name of the category used to organize the parameters*) (* *) (*#PAR#OPT#;*)
		ConfirmSave : BOOL; (*Confirms that the current data of the registered PV can be saved to the recipe. This is used in connection with "SaveNotification"*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		UpdateNotification : BOOL; (*TRUE if a new recipe has been loaded and the registered PV contains new values. This is automatically reset after one cycle*) (* *) (*#CMD#OPT#;*)
		SaveNotification : BOOL; (*TRUE if a recipe is saved and new data should be copied to the recipe, but before the data is actually transferred to the recipe. This is used in connection with "ConfirmSave"*) (* *) (*#CMD#;*)
		Info : MpRecipeInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpRecipeRegPar (*Declare a PV as a recipe parameter*) (* $GROUP=mapp Services,$CAT=XML Recipe,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpRecipe.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (* Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		PVName : REFERENCE TO STRING[100]; (*Name of the PV that should be saved to the recipe*) (* *) (*#PAR#;*)
		Category : REFERENCE TO STRING[50]; (*Name of the category used to organize the parameters*) (* *) (*#PAR#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		UpdateNotification : BOOL; (*TRUE if a new recipe has been loaded and the registered PV contains new values. This is automatically reset after one cycle*) (* *) (*#CMD#OPT#;*)
		Info : MpRecipeInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpRecipeXml (*Load/save parameters from/to an XML file*) (* $GROUP=mapp Services,$CAT=XML Recipe,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpRecipe.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		DeviceName : REFERENCE TO STRING[50]; (*File device (data storage medium) where the files are stored*) (* *) (*#CMD#;*)
		FileName : REFERENCE TO STRING[255]; (*Name of the file that contains the recipe*) (* *) (*#CMD#;*)
		Header : REFERENCE TO MpRecipeXmlHeaderType; (*Header information that is either written or read*) (* *) (*#CMD#OPT#;*)
		Category : REFERENCE TO STRING[50]; (*Name of the category used to organize the parameters*) (* *) (*#CMD#OPT#;*)
		LoadType : MpRecipeXmlLoadEnum; (*Defines how the recipe is loaded. By default, the entire recipe is loaded*) (* *) (*#CMD#OPT#;*)
		Load : BOOL; (*Loads the recipe parameters from the specified file ("FileName")*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the current recipe parameters to a defined file*) (* *) (*#CMD#;*)
		UpdateNotification : BOOL; (*A rising edge on this input induces all MpRecipeRegPar and MpRecipeRegParSync instances to provide information about new recipe values on their "UpdateNotification" output for one cycle*) (* *) (*#CMD#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpRecipeXmlInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpRecipeUI (*UI connection to a VC4 recipe page*) (* $GROUP=mapp Services,$CAT=XML Recipe,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpRecipe.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		UISetup : {REDUND_UNREPLICABLE} MpRecipeUISetupType; (*Used to configure the elements connected to the HMI application*) (* *) (*#PAR#;*)
		UIConnect : REFERENCE TO MpRecipeUIConnectType; (*This structure contains the parameters needed for the connection to the HMI application*) (* *) (*#CMD#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#;*)
		Info : MpRecipeInfoType; (*Additional information about the component*) (* *) (*#CMD;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MpRecipeCsv (*Load/save parameters from/to an CSV file*) (* $GROUP=mapp Services,$CAT=CSV Recipe,$GROUPICON=Icon_mapp.png,$CATICON=Icon_MpRecipe.png *)
	VAR_INPUT
		MpLink : REFERENCE TO MpComIdentType; (*Connection to mapp*) (* *) (*#PAR#;*)
		Enable : BOOL; (*Enables/Disables the function block*) (* *) (*#PAR#;*)
		ErrorReset : BOOL; (*Resets function block errors*) (* *) (*#PAR#;*)
		DeviceName : REFERENCE TO STRING[50]; (*File device (data storage medium) where the files are stored*) (* *) (*#CMD#;*)
		FileName : REFERENCE TO STRING[255]; (*Name of the file that contains the recipe*) (* *) (*#CMD#;*)
		Header : REFERENCE TO MpRecipeCsvHeaderType; (*Header information that is either written or read*) (* *) (*#CMD#OPT#;*)
		Category : REFERENCE TO STRING[50]; (*Name of the category used to organize the parameters*) (* *) (*#CMD#OPT#;*)
		LoadType : MpRecipeCsvLoadEnum; (*Defines how the recipe is loaded. By default, the entire recipe is loaded*) (* *) (*#CMD#OPT#;*)
		Load : BOOL; (*Loads the recipe parameters from the specified file ("FileName")*) (* *) (*#CMD#;*)
		Save : BOOL; (*Saves the current recipe parameters to a defined file*) (* *) (*#CMD#;*)
		UpdateNotification : BOOL; (*A rising edge on this input induces all MpRecipeRegPar and MpRecipeRegParSync instances to provide information about new recipe values on their "UpdateNotification" output for one cycle*) (* *) (*#CMD#OPT#;*)
	END_VAR
	VAR_OUTPUT
		Active : BOOL; (*Indicates whether the function block is active*) (* *) (*#PAR#;*)
		Error : BOOL; (*Indicates that the function block is in an error state or a command was not executed correctly*) (* *) (*#PAR#;*)
		StatusID : DINT; (*Status information about the function block*) (* *) (*#PAR#; *)
		CommandBusy : BOOL; (*Function block currently executing command*) (* *) (*#CMD#OPT#;*)
		CommandDone : BOOL; (*Command successfully executed by function block*) (* *) (*#CMD#;*)
		Info : MpRecipeCsvInfoType; (*Additional information about the component*) (* *) (*#CMD#;*)
	END_VAR
	VAR
		Internal : {REDUND_UNREPLICABLE} MpComInternalDataType; (*Internal stucture*) (* *) (*#OMIT#;*)
	END_VAR
END_FUNCTION_BLOCK
