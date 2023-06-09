FUNCTION PackMLBaseModel

			BaseLayout := '';
			brsstrcat(ADR(BaseLayout),ADR('['));
			
			IF StateEnabled.Clearing THEN
				stringPart := '{"select":"#Clearing","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Clearing","style":"fill:0;fill-opacity:0.5"}';
			END_IF
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			stringPart := '{"select":"#Stopped","style":"fill:2;fill-opacity:1"}';
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
			
			IF StateEnabled.Starting THEN
				stringPart := '{"select":"#Starting","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Starting","style":"fill:0;fill-opacity:0.5"}';
			END_IF	
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			stringPart := '{"select":"#Idle","style":"fill:2;fill-opacity:1"}';
	
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
			
			IF StateEnabled.Suspended THEN
				stringPart := '{"select":"#Suspended","style":"fill:2;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Suspended","style":"fill:0;fill-opacity:0.5"}';
			END_IF	
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
				
			stringPart := '{"select":"#Execute","style":"fill:4;fill-opacity:1"}';	
							
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			IF StateEnabled.Stopping THEN
				stringPart := '{"select":"#Stopping","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Stopping","style":"fill:0;fill-opacity:0.5"}';
			END_IF		
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			IF StateEnabled.Aborting THEN
				stringPart := '{"select":"#Aborting","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Aborting","style":"fill:0;fill-opacity:0.5"}';
			END_IF			
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
		
			stringPart := '{"select":"#Aborted","style":"fill:2;fill-opacity:1"}';
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			IF StateEnabled.Holding THEN
				stringPart := '{"select":"#Holding","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Holding","style":"fill:0;fill-opacity:0.5"}';
			END_IF	
				
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
			
			IF StateEnabled.Held THEN
				stringPart := '{"select":"#Held","style":"fill:2;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Held","style":"fill:0;fill-opacity:0.5"}';
			END_IF	
					
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			IF StateEnabled.Unholding THEN
				stringPart := '{"select":"#Unholding","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Unholding","style":"fill:0;fill-opacity:0.5"}';
			END_IF		
				
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
				
			IF StateEnabled.Suspending THEN
				stringPart := '{"select":"#Suspending","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Suspending","style":"fill:0;fill-opacity:0.5"}';
			END_IF		
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
				
			IF StateEnabled.Unsuspending THEN
				stringPart := '{"select":"#Unsuspending","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Unsuspending","style":"fill:0;fill-opacity:0.5"}';
			END_IF	
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));
				
			IF StateEnabled.Resetting THEN
				stringPart := '{"select":"#Resetting","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Resetting","style":"fill:0;fill-opacity:0.5"}';
			END_IF		
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			IF StateEnabled.Completing THEN
				stringPart := '{"select":"#Completing","style":"fill:1;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Completing","style":"fill:0;fill-opacity:0.5"}';
			END_IF
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(','));	
			
			IF StateEnabled.Complete THEN
				stringPart := '{"select":"#Complete","style":"fill:2;fill-opacity:1"}';
			ELSE
				stringPart := '{"select":"#Complete","style":"fill:0;fill-opacity:0.5"}';
			END_IF
			
			brsstrcat(ADR(BaseLayout),ADR(stringPart));
			brsstrcat(ADR(BaseLayout),ADR(']'));
	
			PackMLBaseModel := TRUE;


END_FUNCTION
