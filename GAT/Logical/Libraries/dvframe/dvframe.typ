                                                                      
TYPE
	XOPENCONFIG : STRUCT
		idle	: UINT ;					(*maximum idle time between characters*)
		delimc	: UINT ;					(*activate the frame delimiters, standard value : 0*)
		delim	: ARRAY[0..1] OF USINT ;	(*frame delimiters, default value: 0,0*)
		tx_cnt	: UINT ;					(*number of send buffers (maximum 8), default value: 2*)
		rx_cnt	: UINT ;					(*number of receive buffers (maximum 8), default value: 2*)
		tx_len	: UINT ;					(*send buffer length, default value: 256 bytes*)
		rx_len	: UINT ;					(*receive buffer length, default value: 256 bytes*)
		argc	: UINT ;					(*number of additional arguments in argv, default value: 0*)
		argv	: UDINT ;					(*address for a UDINT field with additional arguments, default value: 0*)
	END_STRUCT;
END_TYPE
