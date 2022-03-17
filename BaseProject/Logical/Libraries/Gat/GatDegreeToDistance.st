(* This function translates a given degree and radius to the corresponding length on a linear axis 
FUNCTION GatDegreeToDistance
	GatDegreeToDistance := (Degree / 360.0) * 2.0 * CONST_PI * Radius;
END_FUNCTION
