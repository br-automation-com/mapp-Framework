	(*********************************************************************************
	* Copyright: B&R
	* Author:    B&R
	* Created:   30. Sep 2020/08:00 
	* Description: Tasks FOR user control. The User Management handling is done in this task.
	*********************************************************************************)




PROGRAM _INIT
	(* Insert code here *)
	gUser.CMD.ListRefresh	:= TRUE;								// Refresh user data on boot
END_PROGRAM

PROGRAM _CYCLIC
	(* Insert code here *)
    

	

	
    IF ArUserInitList_0.ElementName = 'Administrators' THEN
        gUser.CMD.ErrorReset    := TRUE;
        gUser.CMD.ListRefresh	:= TRUE;
    END_IF
	

    CASE UserManagementState OF
		
        //*****************Wait For Command************************************************************************************
        IdleUser:
            // Some general UI tasks
            FOR idy:=0 TO (SIZEOF(gUser.VIS) / SIZEOF(gUser.VIS[0])) - 1 DO
                // --------------------------------------------------------------------------------------------------------------------
                // Create role list for current user
                idx := 0;
                brsmemset(ADR(gUser.VIS[idy].ListUserRole), 0, SIZEOF(gUser.VIS[idy].ListUserRole));			
                WHILE brsstrcmp(ADR(gUser.DAT.Users[gUser.VIS[idy].ListUserIndex].Roles[idx]), ADR('')) <> 0 DO
                    String2DataProvider(ADR(gUser.DAT.Users[gUser.VIS[idy].ListUserIndex].Roles[idx]), ADR(gUser.VIS[idy].ListUserRole[idx]));
                    idx := idx + 1;
                END_WHILE;
                // Make sure we dont delete last user role
                IF(idx > 1) THEN
                    gUser.VIS[idy].RoleDeleteEnabled := TRUE;
                ELSE
                    gUser.VIS[idy].RoleDeleteEnabled := FALSE;
                END_IF
                // Make sure we dont delete last user
                IF(UserCounterTotal[idy] > 0) THEN				
                    gUser.VIS[idy].UserDeleteEnabled := TRUE;
                ELSE
                    gUser.VIS[idy].UserDeleteEnabled := FALSE;
                END_IF	 
            END_FOR;	
            // Create new user
            IF  gUser.CMD.UserCreate THEN
                // Make sure passwords match before user is created
                IF((gUser.PAR.Password <> '' OR gUser.PAR.PasswordRepeat <> '') AND gUser.PAR.Password <> gUser.PAR.PasswordRepeat) THEN
                    gUser.ERR.No                       := ERR_PASSWORD_MISMATCH;
                    gUser.ERR.State                    := UserManagementState;
                    UserManagementState                := ErrorUser;
                ELSE					
                    tmpUser                            := gUser.PAR.UserName;
                    ArUserCreate_0.Execute             := FALSE;
                    UserManagementState                := CreateUser;
                END_IF
            ELSIF (gUser.CMD.UserDelete) THEN
                IF(brsstrcmp(ADR(gUser.DAT.UserActive[gUser.PAR.VisuSlotID]), ADR(gUser.PAR.UserName)) = 0) THEN
                    gUser.ERR.No                       := ERR_DELETE_CURRENT_USER;
                    gUser.ERR.State                    := UserManagementState;
                    UserManagementState                := ErrorUser;
                ELSE
                    tmpUser                            := gUser.PAR.UserName;
                    ArUserDelete_0.Execute             := FALSE;;
                    UserManagementState                := DeleteUser;
                END_IF
            ELSIF (gUser.CMD.RoleAssign) THEN
                tmpUser                                := gUser.PAR.UserName;
                ArUserAssignRole_0.Execute             := FALSE;;
                gUser.PAR.UserRole                     := gUser.DAT.Roles[gUser.VIS[gUser.PAR.VisuSlotID].ListRoleIndex];
                UserManagementState                    := AssignRole;
                // Remove role from user
            ELSIF (gUser.CMD.RoleRemove) THEN	
                tmpUser                                := gUser.PAR.UserName;
                ArUserReleaseRole_0.Execute            := FALSE;;
                gUser.PAR.UserRole                     := gUser.DAT.Users[gUser.VIS[gUser.PAR.VisuSlotID].ListUserIndex].Roles[gUser.VIS[gUser.PAR.VisuSlotID].ListUserRoleIndex];
                UserManagementState                    := ReleaseRole;
                // Delete user
            ELSIF (gUser.CMD.ListRefresh) THEN
                tmpUser                                := '';
                UserManagementState                    := CreateUserListGetFirst;
            ELSIF (gUser.CMD.PasswordChange) THEN
                tmpUser                                := gUser.PAR.UserName;
                ArUserSetPassword_0.Execute            := FALSE;;	
                UserManagementState                    := ComparePassword;				
            ELSIF (gUser.CMD.UserRename) THEN
                // Make sure we dont delete user that is logged in
                IF(brsstrcmp(ADR(gUser.DAT.UserActive[gUser.PAR.VisuSlotID]), ADR(gUser.PAR.UserName)) = 0) THEN
                    gUser.ERR.No                       := ERR_RENAME_CURRENT_USER;
                    gUser.ERR.State                    := UserManagementState;
                    UserManagementState                := ErrorUser;
                ELSE
                    tmpUserOld                         := gUser.PAR.UserName;
                    tmpUser                            := gUser.PAR.UserNameNew;
                    ArUserGetProperty_0.Execute        := FALSE;;	
                    ArUserSetProperty_0.Execute        := FALSE;;	
                    ArUserAssignRole_0.Execute         := FALSE;;
                    ArUserDelete_0.Execute             := FALSE;;
                    UserManagementState                := RenameUser;
                END_IF
            END_IF;
			
            //*****************User Delete************************************************************************************

        DeleteUser:
			
		

            ArUserDelete_0.Execute               := TRUE ;
            ArUserDelete_0.UserName              := tmpUser ;
		
	
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserDelete_0.Done AND NOT ArUserDelete_0.Busy THEN
                // User delete command
                IF gUser.CMD.UserDelete THEN
                    gUser.DAT.Status             := 'User >';
                    brsstrcat(ADR(gUser.DAT.Status), ADR(tmpUser));
                    brsstrcat(ADR(gUser.DAT.Status), ADR('< deleted'));					
                    // User rename command
                ELSE			
                    gUser.DAT.Status             := 'User ';
                    brsstrcat(ADR(gUser.DAT.Status), ADR(tmpUserOld));
                    brsstrcat(ADR(gUser.DAT.Status), ADR(' renamed to >'));					
                    brsstrcat(ADR(gUser.DAT.Status), ADR(gUser.PAR.UserNameNew));
                    brsstrcat(ADR(gUser.DAT.Status), ADR('<'));					
                END_IF
                gUser.PAR.UserName                := '';
                tmpUser                           := '';
                UserManagementState               := CreateUserListGetFirst;
                // Error
            ELSIF ArUserDelete_0.Error THEN
                gUser.ERR.No                      := ArUserDelete_0.ErrorID;
                gUser.ERR.State                   := UserManagementState;
                UserManagementState               := ErrorUser;			
            END_IF;
        CreateUser:
            ArUserCreate_0.Execute                := TRUE;
            ArUserCreate_0.UserName               := tmpUser;

			
	
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserCreate_0.Done AND NOT ArUserCreate_0.Busy THEN
                // Create new user 
                IF gUser.CMD.UserCreate THEN
                    gUser.DAT.Status             := 'User ';				
                    brsstrcat(ADR(gUser.DAT.Status), ADR(tmpUser));
                    brsstrcat(ADR(gUser.DAT.Status), ADR(' created'));					
                    // Set password when it exists
                    IF gUser.PAR.Password <> '' THEN
                        UserManagementState      := ComparePassword;
                    ELSE
                        gUser.PAR.UserName       := '';
                        UserManagementState      := CreateUserListGetFirst;
                    END_IF;
                    RETURN;
                    // Rename existing user
                ELSE
                    PropertyName                 := 'UserID';
                    UserManagementState          := PropertyRead;				
                END_IF
                // Error
            ELSIF ArUserCreate_0.Error THEN
                gUser.ERR.No                     := ArUserCreate_0.ErrorID;
                gUser.ERR.State                  := UserManagementState;
                UserManagementState              := ErrorUser;	
            END_IF;
        ComparePassword:
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF brsstrcmp(ADR(gUser.PAR.Password), ADR(gUser.PAR.PasswordRepeat)) = 0 THEN				
                UserManagementState              := ChangePassword;				
                // Error
            ELSE				
                gUser.ERR.No                     := ERR_PASSWORD_MISMATCH;
                gUser.ERR.State                  := UserManagementState;
                UserManagementState              := ErrorUser;
            END_IF;
        ChangePassword:		
            ArUserSetPassword_0.Execute          := TRUE;
            ArUserSetPassword_0.UserName         := tmpUser;
            ArUserSetPassword_0.Password         := gUser.PAR.Password;
				
	
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserSetPassword_0.Done AND NOT ArUserSetPassword_0.Busy THEN
                IF gUser.CMD.PasswordChange THEN
                    gUser.DAT.Status            := 'Password for user >';
                    brsstrcat(ADR(gUser.DAT.Status), ADR(tmpUser));
                    brsstrcat(ADR(gUser.DAT.Status), ADR('< changed'));
                    gUser.PAR.Password          := '';
                    gUser.PAR.PasswordRepeat    := '';
                    gUser.CMD.PasswordChange    := FALSE;
                    gUser.VIS[gUser.PAR.VisuSlotID].ShowMessageBoxOK := TRUE;
                    UserManagementState         := IdleUser;
                    RETURN;
                ELSE
                    UserManagementState         := CreateUserListGetFirst;					
                END_IF;
                // Error
            ELSIF ArUserSetPassword_0.Error THEN
                gUser.ERR.No                    := ArUserSetPassword_0.ErrorID;
                gUser.ERR.State                 := UserManagementState;
                UserManagementState             := ErrorUser;
            END_IF;
        CreateUserListGetFirst:
            // Initialize user list
            ArUserInitList_0.Execute            := TRUE;
            ArUserInitList_0.ListType           := USER_LISTTYPE;
            ArUserInitList_0.ElementName        :='';
			

			
            // --------------------------------------------------------------------------------------------------------------------	
            // Get first user name
            IF ArUserInitList_0.Done AND NOT ArUserInitList_0.Busy THEN
			
                ArUserGetFirst_0(Execute := TRUE, List := ArUserInitList_0.List);
					
                // --------------------------------------------------------------------------------------------------------------------	
                // Success
                IF ArUserGetFirst_0.Done THEN
                    // Clear data, store user name and generate data provider for vis
                    brsmemset(ADR(gUser.DAT.Users), 0, SIZEOF(gUser.DAT.Users));
                    brsmemset(ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListUsers), 0, SIZEOF(gUser.VIS[gUser.PAR.VisuSlotID].ListUsers));
                    brsmemset(ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListRoles), 0, SIZEOF(gUser.VIS[gUser.PAR.VisuSlotID].ListRoles));
                    UserCounter := 0;																
	
                    // Make sure user name fits
                    IF(brsstrlen(ADR(ArUserGetFirst_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        // Ignore use an anonymous
                        IF ArUserGetFirst_0.ElementName <> 'Anonymous' THEN 
                            gUser.DAT.Users[UserCounter].Name := ArUserGetFirst_0.ElementName;
                            String2DataProvider(ADR(ArUserGetFirst_0.ElementName), ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListUsers[UserCounter]));	
                            UserCounter                       := 1;
                        ELSE
                            UserCounter                       := 0;														
                        END_IF
                        // Reset function block and init counters
                        ArUserGetFirst_0.Execute              := FALSE;;
                        RoleCounter                           := 0;															
                        UserManagementState                   := CreateUserListGetNext;
                        // User name is too long
                    ELSE
                        gUser.ERR.No                          := ERR_USER_ROLE_NAME_SIZE;
                        gUser.ERR.State                       := UserManagementState;
                        UserManagementState                   := ErrorUser;					
                    END_IF;
                    // Error
                ELSIF ArUserGetFirst_0.Error THEN
                    gUser.ERR.No                              := ArUserGetFirst_0.ErrorID;
                    gUser.ERR.State                           := UserManagementState;
                    UserManagementState                       := ErrorUser;					
                END_IF;
                // Error
            ELSIF ArUserInitList_0.Error THEN
                gUser.ERR.No                                  := ArUserInitList_0.ErrorID;
                gUser.ERR.State                               := UserManagementState;
                UserManagementState                           := ErrorUser;					
            END_IF;
        CreateUserListGetNext:
            // Make sure we have space left
            IF UserCounter < SIZEOF(gUser.DAT.Users)/SIZEOF(gUser.DAT.Users[0]) THEN
                // Get next user
				
                ArUserGetNext_0(Execute:= TRUE,  List := ArUserInitList_0.List);
					
                // --------------------------------------------------------------------------------------------------------------------	
                // Success
                IF ArUserGetNext_0.Done THEN
                    // Make sure user name fits
                    IF(brsstrlen(ADR(ArUserGetNext_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        // Ignore use an anonymous
                        IF(ArUserGetNext_0.ElementName <> 'Anonymous') THEN 
                            // Store user name and generate data provider for vis
                            gUser.DAT.Users[UserCounter].Name := ArUserGetNext_0.ElementName;
                            String2DataProvider(ADR(ArUserGetNext_0.ElementName), ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListUsers[UserCounter]));	
                            // Reset function block and get next name
                            UserCounter                       := UserCounter + 1;
                        END_IF
                        ArUserGetNext_0.Execute               := FALSE;;
                        // User name is too long
                    ELSE
                        gUser.ERR.No                          := ERR_USER_ROLE_NAME_SIZE;
                        gUser.ERR.State                       := UserManagementState;
                        UserManagementState                   := ErrorUser;					
                    END_IF;
                    // Error
                ELSIF ArUserGetNext_0.Error AND NOT (ArUserGetNext_0.ErrorID = END_OF_LIST) THEN
                    gUser.ERR.No                              := ArUserGetNext_0.ErrorID;
                    gUser.ERR.State                           := UserManagementState;
                    UserManagementState                       := ErrorUser;		
                    // List is complete
                ELSIF ArUserGetNext_0.ErrorID = END_OF_LIST THEN
                    // Free up memory
                    ArUserIdent                               := ArUserInitList_0.List;
				
                    ArUserDestroyList_0(Execute:= TRUE,  List := ArUserIdent);

                    ArUserDestroyList_0(Execute:= FALSE,  List := ArUserIdent);

                    // Reset function blocks and counters
                    ArUserGetNext_0.Execute                   := FALSE;;
                    ArUserGetFirst_0.Execute                  := FALSE;;
                    ArUserInitList_0.Execute                  := FALSE;;
                    UserCounterTotal[gUser.PAR.VisuSlotID]    := UserCounter;
                    UserCounter                               := 0;																
                    RoleCounter                               := 0;
                    UserManagementState                       := RoleListInitList;
                END_IF;			
                // User list is too short
            ELSE
                gUser.ERR.No                                  := ERR_USER_LIST_TOO_SHORT;
                gUser.ERR.State                               := UserManagementState;
                UserManagementState                           := ErrorUser;						
            END_IF;					
        RenameUser:
            tmpUserIdx                                        := 0;
            // Find user name in list
            WHILE (brsstrcmp(ADR(gUser.DAT.Users[tmpUserIdx].Name), ADR(tmpUserOld)) <> 0) AND (tmpUserIdx < MAX_USER_NAMES) DO
                tmpUserIdx                                    := tmpUserIdx + 1;
            END_WHILE;
				
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF tmpUserIdx < MAX_USER_NAMES THEN
                ArUserCreate_0.Execute                        := FALSE;;
                UserManagementState                           := CreateUser;
                // Error when user was not found
            ELSE
                gUser.ERR.No                                  := arUSER_ERR_DOES_NOT_EXIST;
                gUser.ERR.State                               := UserManagementState;
                UserManagementState                           := ErrorUser;
            END_IF
	
        RoleListInitList:			
            IF gUser.DAT.Users[UserCounter].Name <> '' THEN	

                ArUserInitList_0(Execute := TRUE ,ListType := USERROLE_LISTTYPE , ElementName := gUser.DAT.Users[UserCounter].Name);				
	
                // --------------------------------------------------------------------------------------------------------------------	
                // Success
                IF ArUserInitList_0.Done  AND NOT ArUserInitList_0.Busy THEN
				
                    ArUserGetFirst_0(Execute:= TRUE,  List := ArUserInitList_0.List);
                    // --------------------------------------------------------------------------------------------------------------------	
                    // Success
                    IF ArUserGetFirst_0.Done THEN
                        // Make sure role name fits
                        IF(brsstrlen(ADR(ArUserInitList_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                            gUser.DAT.Users[UserCounter].Roles[0] := ArUserGetFirst_0.ElementName;
							
                            ArUserGetFirst_0(Execute:= FALSE,  List := ArUserInitList_0.List);									
                            RoleCounter                           := 1;
                            UserManagementState                   := RoleListGetNext;
                            // User role is too long
                        ELSE
                            gUser.ERR.No                          := ERR_USER_ROLE_NAME_SIZE;
                            gUser.ERR.State                       := UserManagementState;
                            UserManagementState                   := ErrorUser;					
                        END_IF;
                        // Error
                    ELSIF ArUserGetFirst_0.Error THEN						
                        gUser.ERR.No                              := ArUserGetFirst_0.ErrorID;
                        gUser.ERR.State                           := UserManagementState;
                        UserManagementState                       := ErrorUser;
                    END_IF;
                    // Error
                ELSIF ArUserInitList_0.Error THEN						
                    gUser.ERR.No                                  := ArUserInitList_0.ErrorID;
                    gUser.ERR.State                               := UserManagementState;
                    UserManagementState                           := ErrorUser;
                END_IF;
                // Finish when user roles are complete
            ELSE
                // Reset function blocks
                ArUserInitList_0.Execute                          := FALSE;;
                ArUserGetFirst_0.Execute                          := FALSE;;
                UserCounter                                       := 1;
                RoleCounter                                       := 0;	
                UserManagementState                               := CreateRoleListGetFirst;	 					
            END_IF;
				
        RoleListGetNext: 
			
            ArUserGetNext_0(Execute:= TRUE,  List := ArUserInitList_0.List);
				
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserGetNext_0.Done THEN
                // Make sure user name fits
                IF(brsstrlen(ADR(ArUserGetNext_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                    gUser.DAT.Users[UserCounter].Roles[RoleCounter] := ArUserGetNext_0.ElementName;
                    RoleCounter                                     := RoleCounter + 1;
					
                    ArUserGetNext_0(Execute:= FALSE,  List := ArUserInitList_0.List);
                    // User role is too long
                ELSE
                    gUser.ERR.No                                    := ERR_USER_ROLE_NAME_SIZE;
                    gUser.ERR.State                                 := UserManagementState;
                    UserManagementState                             := ErrorUser;					
                END_IF;
                // List is complete
            ELSIF ArUserGetNext_0.ErrorID = END_OF_LIST THEN					
                UserCounter                                         := UserCounter + 1;
                // Free up memory
                ArUserIdent                                         := ArUserInitList_0.List;
				
                ArUserDestroyList_0(Execute:= TRUE,  List := ArUserIdent);

                ArUserDestroyList_0(Execute:= FALSE,  List := ArUserIdent);
                // Reset function blocks
                ArUserGetNext_0.Execute                             := FALSE;;				
                ArUserInitList_0.Execute                            := FALSE;;
                UserManagementState                                 := RoleListInitList;	
                // Error				
            ELSIF ArUserGetNext_0.Error THEN				
                gUser.ERR.No                                        := ArUserGetNext_0.ErrorID;
                gUser.ERR.State                                     := UserManagementState;
                UserManagementState                                 := ErrorUser;					 
            END_IF;
					
            // --------------------------------------------------------------------------------------------------------------------
            // Create table of roles
            // --------------------------------------------------------------------------------------------------------------------	
        CreateRoleListGetFirst:	
	
            ArUserInitList_0(Execute := TRUE ,ListType := ROLE_LISTTYPE , ElementName :='' );	 
	
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserInitList_0.Done AND NOT ArUserInitList_0.Busy THEN
		
                ArUserGetFirst_0(Execute:= TRUE,  List := ArUserInitList_0.List );						
	
                // --------------------------------------------------------------------------------------------------------------------	
                // Store role names and generate data provider for vis
                IF ArUserGetFirst_0.Done THEN
                    // Make sure role name fits
                    IF(brsstrlen(ADR(ArUserGetFirst_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        gUser.DAT.Roles[RoleCounter]                := ArUserGetFirst_0.ElementName;
                        String2DataProvider(ADR(ArUserGetFirst_0.ElementName), ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListRoles[RoleCounter]));	
                        // Reset function block and init counters
                        ArUserGetFirst_0.Execute                    := FALSE;;
                        RoleCounter                                 := 1;
                        UserManagementState                         := CreateRoleListGetNext;
                        // Role name is too long
                    ELSE
                        gUser.ERR.No                                := ERR_USER_ROLE_NAME_SIZE;
                        gUser.ERR.State                             := UserManagementState;
                        UserManagementState                         := ErrorUser;					
                    END_IF;
                    // Error				
                ELSIF ArUserGetFirst_0.Error THEN
                    gUser.ERR.No                                    := ArUserGetFirst_0.ErrorID;
                    gUser.ERR.State                                 := UserManagementState;
                    UserManagementState                             := ErrorUser;					
                END_IF;
                // Error				
            ELSIF ArUserInitList_0.Error THEN
                gUser.ERR.No                                        := ArUserInitList_0.ErrorID;
                gUser.ERR.State                                     := UserManagementState;
                UserManagementState                                 := ErrorUser;					
            END_IF;
				
        CreateRoleListGetNext:						
            IF UserCounter < SIZEOF(gUser.DAT.Roles)/SIZEOF(gUser.DAT.Roles[0]) THEN

                ArUserGetNext_0(Execute:= TRUE,  List := ArUserInitList_0.List);
	
                // --------------------------------------------------------------------------------------------------------------------	
                // Store user name and generate data provider for vis
                IF ArUserGetNext_0.Done THEN
                    // Make sure user name fits
                    IF(brsstrlen(ADR(ArUserGetNext_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        gUser.DAT.Roles[RoleCounter]                := ArUserGetNext_0.ElementName;
                        String2DataProvider(ADR(ArUserGetNext_0.ElementName), ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListRoles[RoleCounter]));	
                        // Reset function block and get next name
                        RoleCounter                                 := RoleCounter + 1;
                        ArUserGetNext_0.Execute                     := FALSE;;
                        // Role name is too long
                    ELSE
                        gUser.ERR.No                                := ERR_USER_ROLE_NAME_SIZE;
                        gUser.ERR.State                             := UserManagementState;
                        UserManagementState                         := ErrorUser;					
                    END_IF;
                    // Error				
                ELSIF ArUserGetNext_0.Error AND NOT (ArUserGetNext_0.ErrorID = END_OF_LIST) THEN
                    gUser.ERR.No                                    := ArUserGetNext_0.ErrorID;
                    gUser.ERR.State                                 := UserManagementState;
                    UserManagementState                             := ErrorUser;		
                    // End of list reached				
                ELSIF ArUserGetNext_0.ErrorID = END_OF_LIST THEN
                    // Show message box after succesful command except refresh
                    IF(NOT gUser.CMD.ListRefresh) THEN
                        gUser.VIS[gUser.PAR.VisuSlotID].ShowMessageBoxOK := TRUE;
                    END_IF
                    // Reset function blocks
                    ArUserGetNext_0.Execute                         := FALSE;;				
                    ArUserInitList_0.Execute                        := FALSE;;
                    // Reset function blocks
                    ArUserGetNext_0.Execute                         := FALSE;;
                    ArUserGetFirst_0.Execute                        := FALSE;;
                    ArUserInitList_0.Execute                        := FALSE;;
                    RoleCounter := 0;
                    // Reset command
                    brsmemset(ADR(gUser.CMD), 0, SIZEOF(gUser.CMD));
                    // Select last user if possible
                    IF tmpUser <> '' THEN
                        gUser.VIS[gUser.PAR.VisuSlotID].ListUserValue := tmpUser;
                    ELSIF(tmpUserNew <> '') THEN
                        gUser.VIS[gUser.PAR.VisuSlotID].ListUserValue := tmpUserNew;
                    ELSE
                        gUser.PAR.UserName := gUser.DAT.Users[0].Name;
                    END_IF
                    // Copy user data into all slots on first boot
                    FOR idy:=0 TO SIZEOF(gUser.VIS)/SIZEOF(gUser.VIS[0])-1 DO
                        IF(idy <> gUser.PAR.VisuSlotID) THEN
                            brsmemcpy(ADR(gUser.VIS[idy].ListUsers), ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListUsers), SIZEOF(gUser.VIS[gUser.PAR.VisuSlotID].ListUsers));
                            brsmemcpy(ADR(gUser.VIS[idy].ListRoles), ADR(gUser.VIS[gUser.PAR.VisuSlotID].ListRoles), SIZEOF(gUser.VIS[gUser.PAR.VisuSlotID].ListRoles));
                            UserCounterTotal[idy]                    := UserCounterTotal[gUser.PAR.VisuSlotID];
                        END_IF
                    END_FOR
                    UserManagementState                              := IdleUser;
                    RETURN;
                END_IF;			
                // Role list is too short				
            ELSE
                gUser.ERR.No                                         := ERR_ROLE_LIST_TOO_SHORT;
                gUser.ERR.State                                      := UserManagementState;
                UserManagementState                                  := ErrorUser;	
            END_IF;	
        PropertyRead:	

            ArUserGetProperty_0(Execute:= TRUE,  ElementType := arUSER_USER_PROPERTIES, ElementName := tmpUserOld, PropertyName := PropertyName);			
	
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserGetProperty_0.Done AND NOT ArUserGetProperty_0.Busy THEN
                ArUserSetProperty_0.Execute                         := FALSE;;	
                UserManagementState                                 := PropertyWrite;
                // Error
            ELSIF ArUserGetProperty_0.Error THEN
                gUser.ERR.No                                        := ArUserGetProperty_0.ErrorID;
                gUser.ERR.State                                     := UserManagementState;
                UserManagementState                                 := ErrorUser;			
            END_IF;
            // --------------------------------------------------------------------------------------------------------------------
            // Write user property
            // --------------------------------------------------------------------------------------------------------------------					
        PropertyWrite:	

			
            ArUserSetProperty_0(Execute:= TRUE,  ElementType := arUSER_USER_PROPERTIES, ElementName := tmpUser, PropertyName := PropertyName, PropertyValue := ArUserGetProperty_0.PropertyValue);
	
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserSetProperty_0.Done AND NOT ArUserSetProperty_0.Busy THEN
                // Read password after user ID
                IF PropertyName = 'UserID' THEN
                    PropertyName                                   := 'Password';
                    ArUserGetProperty_0.Execute                    := FALSE;;	
                    UserManagementState                            := PropertyRead;
                    // Assign roles after password
                ELSIF PropertyName = 'Password' THEN
                    idx := 0;
                    gUser.PAR.UserRole                             := gUser.DAT.Users[tmpUserIdx].Roles[idx];
                    UserManagementState                            := AssignRole;
                END_IF
                // Error
            ELSIF ArUserSetProperty_0.Error THEN
                gUser.ERR.No                                       := ArUserSetProperty_0.ErrorID;
                gUser.ERR.State                                    := UserManagementState;
                UserManagementState                                := ErrorUser;			
            END_IF;
				
            // --------------------------------------------------------------------------------------------------------------------
        AssignRole:	
		
            ArUserAssignRole_0(Execute:= TRUE,  UserName := tmpUser, RoleName := gUser.PAR.UserRole);
				
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF gUser.CMD.RoleAssign AND ArUserAssignRole_0.Done AND NOT ArUserAssignRole_0.Busy THEN
                gUser.DAT.Status                                   := 'Role >';
                brsstrcat(ADR(gUser.DAT.Status), ADR(gUser.PAR.UserRole));
                brsstrcat(ADR(gUser.DAT.Status), ADR('< assigned to user '));
                brsstrcat(ADR(gUser.DAT.Status), ADR(tmpUser));
                gUser.PAR.UserName                                 := '';
                UserManagementState                                := CreateUserListGetFirst;
            ELSIF gUser.CMD.UserRename AND ((ArUserAssignRole_0.Done AND NOT ArUserAssignRole_0.Busy) OR (ArUserAssignRole_0.ErrorID = arUSER_ERR_ALREADY_EXISTS)) THEN
                idx := idx +1;
                // Assign next role if it exists
                IF gUser.DAT.Users[tmpUserIdx].Roles[idx] <> '' AND idx < MAX_USER_ROLES THEN
                    ArUserAssignRole_0.Execute                     := FALSE;;
                    gUser.PAR.UserRole                             := gUser.DAT.Users[tmpUserIdx].Roles[idx];
                    // Delete old user
                ELSE
                    // Move user names around
                    tmpUserNew 	                                 := tmpUser;
                    tmpUser                                   	 := tmpUserOld;
                    UserManagementState                          := DeleteUser;	
                END_IF
                // Error
            ELSIF ArUserAssignRole_0.Error THEN
                gUser.ERR.No                                     := ArUserAssignRole_0.ErrorID;
                gUser.ERR.State                                  := UserManagementState;
                UserManagementState                              := ErrorUser;
            END_IF;	 
						 
            // --------------------------------------------------------------------------------------------------------------------
            // Release user role
            // --------------------------------------------------------------------------------------------------------------------								
        ReleaseRole:
		
            ArUserReleaseRole_0(Execute:= TRUE,  UserName := tmpUser, RoleName := gUser.PAR.UserRole);
	
            // --------------------------------------------------------------------------------------------------------------------	
            // Success
            IF ArUserReleaseRole_0.Done AND NOT ArUserReleaseRole_0.Busy THEN	
                gUser.DAT.Status                               := 'Role >';
                brsstrcat(ADR(gUser.DAT.Status), ADR(gUser.PAR.UserRole));
                brsstrcat(ADR(gUser.DAT.Status), ADR('< removed from user '));
                brsstrcat(ADR(gUser.DAT.Status), ADR(tmpUser));
                gUser.PAR.UserName                               := '';
                UserManagementState                              := CreateUserListGetFirst;	
                // Error
            ELSIF ArUserReleaseRole_0.Error THEN
                gUser.ERR.No                                     := ArUserReleaseRole_0.ErrorID;
                gUser.ERR.State                                  := UserManagementState;
                UserManagementState                              := ErrorUser;
            END_IF;
		
        ErrorUser:
            // --------------------------------------------------------------------------------------------------------------------					
            // Reset function blocks

            ArUserInitList_0(Execute := FALSE);
            ArUserGetFirst_0(Execute := FALSE);
            ArUserGetNext_0(Execute := FALSE);
            ArUserCreate_0(Execute := FALSE);
		
            ArUserDelete_0(Execute := FALSE);
            //		
		
		
            // --------------------------------------------------------------------------------------------------------------------					
            // Generate text for most common errors
            IF(gUser.ERR.No = arUSER_ERR_ALREADY_EXISTS) THEN
                gUser.ERR.Text                                  := 'ERR: User/Role already exists or is already assigned';
            ELSIF(gUser.ERR.No = arUSER_ERR_PARAMETER) THEN
                gUser.ERR.Text                                  := 'ERR: User/Role is empty';
            ELSIF(gUser.ERR.No = arUSER_ERR_DOES_NOT_EXIST) THEN
                gUser.ERR.Text                                  := 'ERR: User/Role does not exist';
            ELSIF(gUser.ERR.No = ERR_PASSWORD_MISMATCH) THEN
                gUser.ERR.Text                                  := 'ERR: Passwords do not match';
            ELSIF(gUser.ERR.No = ERR_USER_LIST_TOO_SHORT) THEN
                gUser.ERR.Text                                  := 'ERR: User list is too short';
            ELSIF(gUser.ERR.No = ERR_ROLE_LIST_TOO_SHORT) THEN
                gUser.ERR.Text                                  := 'ERR: Role list is too short';
            ELSIF(gUser.ERR.No = ERR_DELETE_CURRENT_USER) THEN
                gUser.ERR.Text                                  := 'ERR: Can not delete user that is logged in';
            ELSIF(gUser.ERR.No = ERR_USER_ROLE_NAME_SIZE) THEN
                gUser.ERR.Text                                  := 'ERR: User name or role exceeds maximum size of ITEM_LENGTH';
            ELSIF(gUser.ERR.No = ERR_RENAME_CURRENT_USER) THEN
                gUser.ERR.Text                                  := 'ERR: Can not rename user that is logged in';
            ELSE
                gUser.ERR.Text                                  := 'Error executing command';
            END_IF							
            // Make sure we dont exceed maximum number of web clients
            IF(gUser.PAR.VisuSlotID < SIZEOF(gUser.VIS)/SIZEOF(gUser.VIS[0])) THEN
                gUser.VIS[gUser.PAR.VisuSlotID].ShowMessageBoxError := TRUE;
            END_IF
            // --------------------------------------------------------------------------------------------------------------------	
            // Return to idle state
            IF gUser.CMD.ErrorReset THEN
                UserCounter                                     := 1;	
                RoleCounter                                     := 0;	
				
                brsmemset(ADR(gUser.ERR), 0, SIZEOF(gUser.ERR));
                gUser.CMD.ErrorReset                            := FALSE;
                gUser.VIS[gUser.PAR.VisuSlotID].ShowMessageBoxError := FALSE;
                UserManagementState                            := IdleUser;
            END_IF;	
            brsmemset(ADR(gUser.CMD), 0, SIZEOF(gUser.CMD));
            RETURN;		
        // --------------------------------------------------------------------------------------------------------------------
    END_CASE
    ArUserSetPassword_0();
    ArUserGetNext_0();
    ArUserInitList_0();
    ArUserCreate_0();
    ArUserDelete_0();
	
	

    ArUserSetProperty_0();
    ArUserGetProperty_0();
    ArUserAssignRole_0();
    ArUserReleaseRole_0();
    //****(*This instruction Enables the ArUser-Based User Management Page*)

    gVisuCtrl.cmd.bEnableArUser := TRUE ;
    gVisuCtrl.cmd.bEnableMpUserX := FALSE ;
	
	
    IF X = 1 THEN
        sTempStr := "Med is logged in";
        MpAuditCustomEvent(gAuditTrailMpLink, TypeVar, "$$Custom/LoggedIn_ID", sTempStr);
    END_IF
	
END_PROGRAM

PROGRAM _EXIT
	(* Insert code here *)
	 
END_PROGRAM

