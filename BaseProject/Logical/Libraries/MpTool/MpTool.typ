
TYPE
	McToolRecordType : 	STRUCT  (*Tool record type. Contains all tool record related information*)
		Identifier : STRING[250]; (*Tool record identifier *)
		GeometryName : STRING[250]; (*Name of tool geometry parameters*)
		GeometryData : McToolGeometryType; (*Tool geometry parameters*)
		DynamicsName : STRING[250]; (*Name of tool dynamics parameters*)
		WireFrameName : STRING[250]; (*Name of tool wireframe parameters*)
	END_STRUCT;
	MpToolDiagType : 	STRUCT  (*MpTool diagnostics type*)
		StatusID : MpToolStatusIDType; (*StatusID information*)
	END_STRUCT;
	MpToolManagerParType : 	STRUCT  (*Parameters structure*)
		ToolTable : STRING[250]; (*Tool table name*)
		Record : McToolRecordType; (*Tool record data*)
		GeometryName : STRING[250]; (*Tool geometry name*)
		GeometryData : McToolGeometryType; (*Tool geoemetry data*)
		CreateMode : McToolManagerCreateModeEnum; (*Mode for Create command*)
		DeleteMode : McToolManagerDeleteModeEnum; (*Mode for Delete command*)
		GetMode : McToolManagerGetModeEnum; (*Mode for Get command*)
		SetMode : McToolManagerSetModeEnum; (*Mode for Set command*)
		DynamicsName : STRING[250]; (*Name of found tool dynamics*)
		DynamicsData : McToolDynamicsType; (*Data of found tool dynamics*)
		WireFrameName : STRING[250]; (*Name of found tool wireframe*)
		WireFrameData : McToolWireFrameType; (*Data of found tool wireframe*)
	END_STRUCT;
	MpToolManagerInfoType : 	STRUCT  (*Info structure of MpToolManagerCore FB. Contains additional information and returns data of commands*)
		Record : McToolRecordType; (*Provides tool record data when Get command is done*)
		GeometryName : STRING[250]; (*Provides stand-alone tool geometry name when Get command is done*)
		GeometryData : McToolGeometryType; (*Provides stand-alone tool geometry data when Get command is done*)
		Diag : MpToolDiagType; (*Diagnostic structure for the function block*)
		DynamicsName : STRING[250]; (*Name of found tool dynamics*)
		DynamicsData : McToolDynamicsType; (*Data of found tool dynamics*)
		WireFrameName : STRING[250]; (*Name of found tool wireframe*)
		WireFrameData : McToolWireFrameType; (*Data of found tool wireframe*)
	END_STRUCT;
	MpToolGetDataInfoType : 	STRUCT  (*Info structure of MpToolGetData FB*)
		NumberOfElements : UDINT; (*Total number of elements found*)
		CurrentElement : UDINT; (*Number of currently shown element*)
		Diag : MpToolDiagType; (*Diagnostic structure for the function block*)
	END_STRUCT;
	MpToolGetDataParType : 	STRUCT  (*Parameters structure*)
		Mode : McToolGetDataEnum; (*Get data mode*)
		ToolTable : STRING[250]; (*Tool table name*)
	END_STRUCT;
	MpToolStatusIDType : 	STRUCT  (*MpTool StatusID type*)
		ID : MpToolErrorEnum; (*Error code for mapp component*)
		Severity : MpComSeveritiesEnum; (*Describes the type of information supplied by the status ID (success, information, warning, error)*)
		Code : UINT; (*Code of occured error*)
	END_STRUCT;
	McToolGetDataEnum : 
		( (*Mode enum for Get command*)
		mcTOOL_GETDATA_TOOLTABLE := 0, (*Get tool tables (.tooltable)*)
		mcTOOL_GETDATA_RECORD_GEO, (*Get tool records inside a tool table*)
		mcTOOL_GETDATA_GEOMETRY, (*Get tool geometry parameters (.tool)*)
		mcTOOL_GETDATA_DYNAMICS, (*Get tool dynamics parameters (.dynpartable)*)
		mcTOOL_GETDATA_WIREFRAME (*Get tool wire frame parameters (.wireframe)*)
		);
	McToolManagerDeleteModeEnum : 
		( (*Mode enum for Delete command*)
		mcTOOL_MANAGER_DELETE_TOOLTABLE := 0, (*Delete a tool table (incl. tool records)*)
		mcTOOL_MANAGER_DELETE_TABLE_GEO, (*Delete a tool table with referenced tool geometries (incl. tool records and referenced tool geometries)*)
		mcTOOL_MANAGER_DELETE_RECORD, (*Delete a tool record*)
		mcTOOL_MANAGER_DELETE_RECORD_GEO, (*Delete a tool record with referenced tool geometry*)
		mcTOOL_MANAGER_DELETE_GEOMETRY, (*Delete a tool geometry*)
		mcTOOL_MANAGER_DELETE_DYNAMICS, (*Delete a tool dynamics*)
		mcTOOL_MANAGER_DELETE_WIREFRAME (*Delete a tool wireframe*)
		);
	McToolManagerCreateModeEnum : 
		( (*Mode enum for Create command*)
		mcTOOL_MANAGER_CREATE_TOOLTABLE := 0, (*Create a tool table*)
		mcTOOL_MANAGER_CREATE_RECORD, (*Create a tool record and reference tool parameters (geometry, dynamics, wireframe) to this record.*)
		mcTOOL_MANAGER_CREATE_RECORD_GEO, (*Create a tool record with tool geometry parameters and reference tool parameters to this record (geometry, dynamics, wireframe)*)
		mcTOOL_MANAGER_CREATE_GEOMETRY, (*Create a tool geometry*)
		mcTOOL_MANAGER_CREATE_DYNAMICS, (*Create a tool dynamics*)
		mcTOOL_MANAGER_CREATE_WIREFRAME (*Create a tool wireframe*)
		);
	McToolManagerGetModeEnum : 
		( (*Mode enum for Get command*)
		mcTOOL_MANAGER_GET_RECORD := 0, (*Get referenced tool parameters (geometry, dynamics, wireframe) of a tool record*)
		mcTOOL_MANAGER_GET_RECORD_GEO, (*Get referenced tool parameters (geometry, dynmaics, wireframe) and the data of the referenced geometry*)
		mcTOOL_MANAGER_GET_GEOMETRY, (*Get tool geometry data*)
		mcTOOL_MANAGER_GET_DYNAMICS, (*Get tool dynamics data*)
		mcTOOL_MANAGER_GET_WIREFRAME (*Get tool wireframe data *)
		);
	McToolManagerSetModeEnum : 
		( (*Mode enum for Set command*)
		mcTOOL_MANAGER_SET_RECORD := 0, (*Set names of tool parameter sets (geometry, dynamics, wireframe) for an existing tool record *)
		mcTOOL_MANAGER_SET_RECORD_GEO, (*Set names of tool parameter sets (geometry, dynamics, wireframe) for an existing tool record and set the data of the referenced geometry*)
		mcTOOL_MANAGER_SET_GEOMETRY, (*Set tool geometry data *)
		mcTOOL_MANAGER_SET_DYNAMICS, (*Set tool dynamics data *)
		mcTOOL_MANAGER_SET_WIREFRAME (*Set tool wireframe data*)
		);
	MpToolGetDataResultType : 	STRUCT  (*Command result structure*)
		ToolTable : STRING[250]; (*Name of found tool table*)
		Record : McToolRecordType; (*Data of found tool record*)
		GeometryName : STRING[250]; (*Name of found tool geometry*)
		DynamicsName : STRING[250]; (*Name of found tool dynamics*)
		WireFrameName : STRING[250]; (*Name of found tool wireframe*)
		GeometryData : McToolGeometryType; (*Data of found tool geometry*)
		DynamicsData : McToolDynamicsType; (*Data of found tool dynamics*)
		WireFrameData : McToolWireFrameType; (*Data of found tool wireframe*)
	END_STRUCT;
END_TYPE
