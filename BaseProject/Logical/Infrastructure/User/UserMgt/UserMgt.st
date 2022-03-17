//*********************************************************************************
//* Copyright: B&R
//* Author:    B&R
//* Created:   30. Sep 2020/08:00
//* Description: Tasks FOR user control. The User Management handling is done in this task.
//********************************************************************************

PROGRAM _INIT
    // Refresh user data on boot
    User.Command.ListRefresh := TRUE;
END_PROGRAM

PROGRAM _CYCLIC
    
    IF ArUserInitList_0.ElementName = 'Administrators' THEN
        User.Command.ErrorReset := TRUE;
        User.Command.ListRefresh := TRUE;
    END_IF
	
    CASE UserManagementState OF
	
        //*****************Wait For Command************************************************************************************
        IdleUser:
            // Some general UI tasks
            FOR idy := 0 TO (SIZEOF(User.Visualization) / SIZEOF(User.Visualization[0])) - 1 DO
                // --------------------------------------------------------------------------------------------------------------------
                // Create role list for current user
                idx := 0;
                brsmemset(ADR(User.Visualization[idy].ListUserRole), 0, SIZEOF(User.Visualization[idy].ListUserRole));
                WHILE brsstrcmp(ADR(User.Data.Users[User.Visualization[idy].ListUserIndex].Roles[idx]), ADR('')) <> 0 DO
                    String2DataProvider(ADR(User.Data.Users[User.Visualization[idy].ListUserIndex].Roles[idx]), ADR(User.Visualization[idy].ListUserRole[idx]));
                    idx := idx + 1;
                END_WHILE
                // Make sure we dont delete last user role
                IF(idx > 1) THEN
                    User.Visualization[idy].RoleDeleteEnabled := TRUE;
                ELSE
                    User.Visualization[idy].RoleDeleteEnabled := FALSE;
                END_IF
                // Make sure we dont delete last user
                IF(UserCounterTotal[idy] > 0) THEN
                    User.Visualization[idy].UserDeleteEnabled := TRUE;
                ELSE
                    User.Visualization[idy].UserDeleteEnabled := FALSE;
                END_IF
            END_FOR
            // Create new user
            IF  User.Command.UserCreate THEN
                // Make sure passwords match before user is created
                IF((User.Parameter.Password <> '' OR User.Parameter.PasswordRepeat <> '') AND User.Parameter.Password <> User.Parameter.PasswordRepeat) THEN
                    User.Error.No := ERR_PASSWORD_MISMATCH;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                ELSE
                    tmpUser := User.Parameter.UserName;
                    ArUserCreate_0.Execute := FALSE;
                    UserManagementState := CreateUser;
                END_IF
            ELSIF (User.Command.UserDelete) THEN
                IF(brsstrcmp(ADR(User.Data.UserActive[User.Parameter.VisuSlotID]), ADR(User.Parameter.UserName)) = 0) THEN
                    User.Error.No := ERR_DELETE_CURRENT_USER;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                ELSE
                    tmpUser := User.Parameter.UserName;
                    ArUserDelete_0.Execute := FALSE;
                    UserManagementState := DeleteUser;
                END_IF
            ELSIF (User.Command.RoleAssign) THEN
                tmpUser := User.Parameter.UserName;
                ArUserAssignRole_0.Execute := FALSE;
                User.Parameter.UserRole := User.Data.Roles[User.Visualization[User.Parameter.VisuSlotID].ListRoleIndex];
                UserManagementState := AssignRole;
                // Remove role from user
            ELSIF (User.Command.RoleRemove) THEN
                tmpUser := User.Parameter.UserName;
                ArUserReleaseRole_0.Execute := FALSE;
                User.Parameter.UserRole := User.Data.Users[User.Visualization[User.Parameter.VisuSlotID].ListUserIndex].Roles[User.Visualization[User.Parameter.VisuSlotID].ListUserRoleIndex];
                UserManagementState := ReleaseRole;
                // Delete user
            ELSIF (User.Command.ListRefresh) THEN
                tmpUser := '';
                UserManagementState := CreateUserListGetFirst;
            ELSIF (User.Command.PasswordChange) THEN
                tmpUser := User.Parameter.UserName;
                ArUserSetPassword_0.Execute := FALSE;
                UserManagementState := ComparePassword;
            ELSIF (User.Command.UserRename) THEN
                // Make sure we dont delete user that is logged in
                IF(brsstrcmp(ADR(User.Data.UserActive[User.Parameter.VisuSlotID]), ADR(User.Parameter.UserName)) = 0) THEN
                    User.Error.No := ERR_RENAME_CURRENT_USER;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                ELSE
                    tmpUserOld := User.Parameter.UserName;
                    tmpUser := User.Parameter.UserNameNew;
                    ArUserGetProperty_0.Execute := FALSE;
                    ArUserSetProperty_0.Execute := FALSE;
                    ArUserAssignRole_0.Execute := FALSE;
                    ArUserDelete_0.Execute := FALSE;
                    UserManagementState := RenameUser;
                END_IF
            END_IF
	
            //*****************User Delete************************************************************************************

        DeleteUser:
            ArUserDelete_0.Execute := TRUE;
            ArUserDelete_0.UserName := tmpUser;
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserDelete_0.Done AND NOT ArUserDelete_0.Busy THEN
                // User delete command
                IF User.Command.UserDelete THEN
                    User.Data.Status := 'User >';
                    brsstrcat(ADR(User.Data.Status), ADR(tmpUser));
                    brsstrcat(ADR(User.Data.Status), ADR('< deleted'));
                    // User rename command
                ELSE
                    User.Data.Status := 'User ';
                    brsstrcat(ADR(User.Data.Status), ADR(tmpUserOld));
                    brsstrcat(ADR(User.Data.Status), ADR(' renamed to >'));
                    brsstrcat(ADR(User.Data.Status), ADR(User.Parameter.UserNameNew));
                    brsstrcat(ADR(User.Data.Status), ADR('<'));
                END_IF
                User.Parameter.UserName := '';
                tmpUser := '';
                UserManagementState := CreateUserListGetFirst;
                // Error
            ELSIF ArUserDelete_0.Error THEN
                User.Error.No := ArUserDelete_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
        CreateUser:
            ArUserCreate_0.Execute := TRUE;
            ArUserCreate_0.UserName := tmpUser;

	
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserCreate_0.Done AND NOT ArUserCreate_0.Busy THEN
                // Create new user
                IF User.Command.UserCreate THEN
                    User.Data.Status := 'User ';
                    brsstrcat(ADR(User.Data.Status), ADR(tmpUser));
                    brsstrcat(ADR(User.Data.Status), ADR(' created'));
                    // Set password when it exists
                    IF User.Parameter.Password <> '' THEN
                        UserManagementState := ComparePassword;
                    ELSE
                        User.Parameter.UserName := '';
                        UserManagementState := CreateUserListGetFirst;
                    END_IF
                    RETURN;
                    // Rename existing user
                ELSE
                    PropertyName := 'UserID';
                    UserManagementState := PropertyRead;
                END_IF
                // Error
            ELSIF ArUserCreate_0.Error THEN
                User.Error.No := ArUserCreate_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
        ComparePassword:
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF brsstrcmp(ADR(User.Parameter.Password), ADR(User.Parameter.PasswordRepeat)) = 0 THEN
                UserManagementState := ChangePassword;
                // Error
            ELSE
                User.Error.No := ERR_PASSWORD_MISMATCH;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
        ChangePassword:
            ArUserSetPassword_0.Execute := TRUE;
            ArUserSetPassword_0.UserName := tmpUser;
            ArUserSetPassword_0.Password := User.Parameter.Password;
	
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserSetPassword_0.Done AND NOT ArUserSetPassword_0.Busy THEN
                IF User.Command.PasswordChange THEN
                    User.Data.Status := 'Password for user >';
                    brsstrcat(ADR(User.Data.Status), ADR(tmpUser));
                    brsstrcat(ADR(User.Data.Status), ADR('< changed'));
                    User.Parameter.Password := '';
                    User.Parameter.PasswordRepeat := '';
                    User.Command.PasswordChange := FALSE;
                    User.Visualization[User.Parameter.VisuSlotID].ShowMessageBoxOK := TRUE;
                    UserManagementState := IdleUser;
                    RETURN;
                ELSE
                    UserManagementState := CreateUserListGetFirst;
                END_IF
                // Error
            ELSIF ArUserSetPassword_0.Error THEN
                User.Error.No := ArUserSetPassword_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
        CreateUserListGetFirst:
            // Initialize user list
            ArUserInitList_0.Execute := TRUE;
            ArUserInitList_0.ListType := USER_LISTTYPE;
            ArUserInitList_0.ElementName := '';
	

	
            // --------------------------------------------------------------------------------------------------------------------
            // Get first user name
            IF ArUserInitList_0.Done AND NOT ArUserInitList_0.Busy THEN
	
                ArUserGetFirst_0(Execute := TRUE, List := ArUserInitList_0.List);
	
                // --------------------------------------------------------------------------------------------------------------------
                // Success
                IF ArUserGetFirst_0.Done THEN
                    // Clear data, store user name and generate data provider for vis
                    brsmemset(ADR(User.Data.Users), 0, SIZEOF(User.Data.Users));
                    brsmemset(ADR(User.Visualization[User.Parameter.VisuSlotID].ListUsers), 0, SIZEOF(User.Visualization[User.Parameter.VisuSlotID].ListUsers));
                    brsmemset(ADR(User.Visualization[User.Parameter.VisuSlotID].ListRoles), 0, SIZEOF(User.Visualization[User.Parameter.VisuSlotID].ListRoles));
                    UserCounter := 0;
	
                    // Make sure user name fits
                    IF(brsstrlen(ADR(ArUserGetFirst_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        // Ignore use an anonymous
                        IF ArUserGetFirst_0.ElementName <> 'Anonymous' THEN
                            User.Data.Users[UserCounter].Name := ArUserGetFirst_0.ElementName;
                            String2DataProvider(ADR(ArUserGetFirst_0.ElementName), ADR(User.Visualization[User.Parameter.VisuSlotID].ListUsers[UserCounter]));
                            UserCounter := 1;
                        ELSE
                            UserCounter := 0;
                        END_IF
                        // Reset function block and init counters
                        ArUserGetFirst_0.Execute := FALSE;
                        RoleCounter := 0;
                        UserManagementState := CreateUserListGetNext;
                        // User name is too long
                    ELSE
                        User.Error.No := ERR_USER_ROLE_NAME_SIZE;
                        User.Error.State := UserManagementState;
                        UserManagementState := ErrorUser;
                    END_IF
                    // Error
                ELSIF ArUserGetFirst_0.Error THEN
                    User.Error.No := ArUserGetFirst_0.ErrorID;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                END_IF
                // Error
            ELSIF ArUserInitList_0.Error THEN
                User.Error.No := ArUserInitList_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
        CreateUserListGetNext:
            // Make sure we have space left
            IF UserCounter < SIZEOF(User.Data.Users)/SIZEOF(User.Data.Users[0]) THEN
                // Get next user
	
                ArUserGetNext_0(Execute := TRUE,  List := ArUserInitList_0.List);
	
                // --------------------------------------------------------------------------------------------------------------------
                // Success
                IF ArUserGetNext_0.Done THEN
                    // Make sure user name fits
                    IF(brsstrlen(ADR(ArUserGetNext_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        // Ignore use an anonymous
                        IF(ArUserGetNext_0.ElementName <> 'Anonymous') THEN
                            // Store user name and generate data provider for vis
                            User.Data.Users[UserCounter].Name := ArUserGetNext_0.ElementName;
                            String2DataProvider(ADR(ArUserGetNext_0.ElementName), ADR(User.Visualization[User.Parameter.VisuSlotID].ListUsers[UserCounter]));
                            // Reset function block and get next name
                            UserCounter := UserCounter + 1;
                        END_IF
                        ArUserGetNext_0.Execute := FALSE;
                        // User name is too long
                    ELSE
                        User.Error.No := ERR_USER_ROLE_NAME_SIZE;
                        User.Error.State := UserManagementState;
                        UserManagementState := ErrorUser;
                    END_IF
                    // Error
                ELSIF ArUserGetNext_0.Error AND NOT (ArUserGetNext_0.ErrorID = END_OF_LIST) THEN
                    User.Error.No := ArUserGetNext_0.ErrorID;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                    // List is complete
                ELSIF ArUserGetNext_0.ErrorID = END_OF_LIST THEN
                    // Free up memory
                    ArUserIdent := ArUserInitList_0.List;
	
                    ArUserDestroyList_0(Execute := TRUE,  List := ArUserIdent);

                    ArUserDestroyList_0(Execute := FALSE,  List := ArUserIdent);

                    // Reset function blocks and counters
                    ArUserGetNext_0.Execute := FALSE;
                    ArUserGetFirst_0.Execute := FALSE;
                    ArUserInitList_0.Execute := FALSE;
                    UserCounterTotal[User.Parameter.VisuSlotID] := UserCounter;
                    UserCounter := 0;
                    RoleCounter := 0;
                    UserManagementState := RoleListInitList;
                END_IF
                // User list is too short
            ELSE
                User.Error.No := ERR_USER_LIST_TOO_SHORT;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
        RenameUser:
            tmpUserIdx := 0;
            // Find user name in list
            WHILE (brsstrcmp(ADR(User.Data.Users[tmpUserIdx].Name), ADR(tmpUserOld)) <> 0) AND (tmpUserIdx < MAX_USER_NAMES) DO
                tmpUserIdx := tmpUserIdx + 1;
            END_WHILE
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF tmpUserIdx < MAX_USER_NAMES THEN
                ArUserCreate_0.Execute := FALSE;
                UserManagementState := CreateUser;
                // Error when user was not found
            ELSE
                User.Error.No := arUSER_ERR_DOES_NOT_EXIST;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
	
        RoleListInitList:
            IF User.Data.Users[UserCounter].Name <> '' THEN

                ArUserInitList_0(Execute := TRUE ,ListType := USERROLE_LISTTYPE , ElementName := User.Data.Users[UserCounter].Name);
	
                // --------------------------------------------------------------------------------------------------------------------
                // Success
                IF ArUserInitList_0.Done  AND NOT ArUserInitList_0.Busy THEN
	
                    ArUserGetFirst_0(Execute := TRUE,  List := ArUserInitList_0.List);
                    // --------------------------------------------------------------------------------------------------------------------
                    // Success
                    IF ArUserGetFirst_0.Done THEN
                        // Make sure role name fits
                        IF(brsstrlen(ADR(ArUserInitList_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                            User.Data.Users[UserCounter].Roles[0] := ArUserGetFirst_0.ElementName;
	
                            ArUserGetFirst_0(Execute := FALSE,  List := ArUserInitList_0.List);
                            RoleCounter := 1;
                            UserManagementState := RoleListGetNext;
                            // User role is too long
                        ELSE
                            User.Error.No := ERR_USER_ROLE_NAME_SIZE;
                            User.Error.State := UserManagementState;
                            UserManagementState := ErrorUser;
                        END_IF
                        // Error
                    ELSIF ArUserGetFirst_0.Error THEN
                        User.Error.No := ArUserGetFirst_0.ErrorID;
                        User.Error.State := UserManagementState;
                        UserManagementState := ErrorUser;
                    END_IF
                    // Error
                ELSIF ArUserInitList_0.Error THEN
                    User.Error.No := ArUserInitList_0.ErrorID;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                END_IF
                // Finish when user roles are complete
            ELSE
                // Reset function blocks
                ArUserInitList_0.Execute := FALSE;
                ArUserGetFirst_0.Execute := FALSE;
                UserCounter := 1;
                RoleCounter := 0;
                UserManagementState := CreateRoleListGetFirst;
            END_IF
	
        RoleListGetNext:
	
            ArUserGetNext_0(Execute := TRUE,  List := ArUserInitList_0.List);
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserGetNext_0.Done THEN
                // Make sure user name fits
                IF(brsstrlen(ADR(ArUserGetNext_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                    User.Data.Users[UserCounter].Roles[RoleCounter] := ArUserGetNext_0.ElementName;
                    RoleCounter := RoleCounter + 1;
	
                    ArUserGetNext_0(Execute := FALSE,  List := ArUserInitList_0.List);
                    // User role is too long
                ELSE
                    User.Error.No := ERR_USER_ROLE_NAME_SIZE;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                END_IF
                // List is complete
            ELSIF ArUserGetNext_0.ErrorID = END_OF_LIST THEN
                UserCounter := UserCounter + 1;
                // Free up memory
                ArUserIdent := ArUserInitList_0.List;
	
                ArUserDestroyList_0(Execute := TRUE,  List := ArUserIdent);

                ArUserDestroyList_0(Execute := FALSE,  List := ArUserIdent);
                // Reset function blocks
                ArUserGetNext_0.Execute := FALSE;
                ArUserInitList_0.Execute := FALSE;
                UserManagementState := RoleListInitList;
                // Error
            ELSIF ArUserGetNext_0.Error THEN
                User.Error.No := ArUserGetNext_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
	
            // --------------------------------------------------------------------------------------------------------------------
            // Create table of roles
            // --------------------------------------------------------------------------------------------------------------------
        CreateRoleListGetFirst:
	
            ArUserInitList_0(Execute := TRUE ,ListType := ROLE_LISTTYPE , ElementName := '' );
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserInitList_0.Done AND NOT ArUserInitList_0.Busy THEN
	
                ArUserGetFirst_0(Execute := TRUE,  List := ArUserInitList_0.List );
	
                // --------------------------------------------------------------------------------------------------------------------
                // Store role names and generate data provider for vis
                IF ArUserGetFirst_0.Done THEN
                    // Make sure role name fits
                    IF(brsstrlen(ADR(ArUserGetFirst_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        User.Data.Roles[RoleCounter] := ArUserGetFirst_0.ElementName;
                        String2DataProvider(ADR(ArUserGetFirst_0.ElementName), ADR(User.Visualization[User.Parameter.VisuSlotID].ListRoles[RoleCounter]));
                        // Reset function block and init counters
                        ArUserGetFirst_0.Execute := FALSE;
                        RoleCounter := 1;
                        UserManagementState := CreateRoleListGetNext;
                        // Role name is too long
                    ELSE
                        User.Error.No := ERR_USER_ROLE_NAME_SIZE;
                        User.Error.State := UserManagementState;
                        UserManagementState := ErrorUser;
                    END_IF
                    // Error
                ELSIF ArUserGetFirst_0.Error THEN
                    User.Error.No := ArUserGetFirst_0.ErrorID;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                END_IF
                // Error
            ELSIF ArUserInitList_0.Error THEN
                User.Error.No := ArUserInitList_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
	
        CreateRoleListGetNext:
            IF UserCounter < SIZEOF(User.Data.Roles)/SIZEOF(User.Data.Roles[0]) THEN

                ArUserGetNext_0(Execute := TRUE,  List := ArUserInitList_0.List);
	
                // --------------------------------------------------------------------------------------------------------------------
                // Store user name and generate data provider for vis
                IF ArUserGetNext_0.Done THEN
                    // Make sure user name fits
                    IF(brsstrlen(ADR(ArUserGetNext_0.ElementName)) < MAX_USER_ITEM_LEN) THEN
                        User.Data.Roles[RoleCounter] := ArUserGetNext_0.ElementName;
                        String2DataProvider(ADR(ArUserGetNext_0.ElementName), ADR(User.Visualization[User.Parameter.VisuSlotID].ListRoles[RoleCounter]));
                        // Reset function block and get next name
                        RoleCounter := RoleCounter + 1;
                        ArUserGetNext_0.Execute := FALSE;
                        // Role name is too long
                    ELSE
                        User.Error.No := ERR_USER_ROLE_NAME_SIZE;
                        User.Error.State := UserManagementState;
                        UserManagementState := ErrorUser;
                    END_IF
                    // Error
                ELSIF ArUserGetNext_0.Error AND NOT (ArUserGetNext_0.ErrorID = END_OF_LIST) THEN
                    User.Error.No := ArUserGetNext_0.ErrorID;
                    User.Error.State := UserManagementState;
                    UserManagementState := ErrorUser;
                    // End of list reached
                ELSIF ArUserGetNext_0.ErrorID = END_OF_LIST THEN
                    // Show message box after succesful command except refresh
                    IF(NOT User.Command.ListRefresh) THEN
                        User.Visualization[User.Parameter.VisuSlotID].ShowMessageBoxOK := TRUE;
                    END_IF
                    // Reset function blocks
                    ArUserGetNext_0.Execute := FALSE;
                    ArUserInitList_0.Execute := FALSE;
                    // Reset function blocks
                    ArUserGetNext_0.Execute := FALSE;
                    ArUserGetFirst_0.Execute := FALSE;
                    ArUserInitList_0.Execute := FALSE;
                    RoleCounter := 0;
                    // Reset command
                    brsmemset(ADR(User.Command), 0, SIZEOF(User.Command));
                    // Select last user if possible
                    IF tmpUser <> '' THEN
                        User.Visualization[User.Parameter.VisuSlotID].ListUserValue := tmpUser;
                    ELSIF(tmpUserNew <> '') THEN
                        User.Visualization[User.Parameter.VisuSlotID].ListUserValue := tmpUserNew;
                    ELSE
                        User.Parameter.UserName := User.Data.Users[0].Name;
                    END_IF
                    // Copy user data into all slots on first boot
                    FOR idy := 0 TO SIZEOF(User.Visualization)/SIZEOF(User.Visualization[0])-1 DO
                        IF(idy <> User.Parameter.VisuSlotID) THEN
                            brsmemcpy(ADR(User.Visualization[idy].ListUsers), ADR(User.Visualization[User.Parameter.VisuSlotID].ListUsers), SIZEOF(User.Visualization[User.Parameter.VisuSlotID].ListUsers));
                            brsmemcpy(ADR(User.Visualization[idy].ListRoles), ADR(User.Visualization[User.Parameter.VisuSlotID].ListRoles), SIZEOF(User.Visualization[User.Parameter.VisuSlotID].ListRoles));
                            UserCounterTotal[idy] := UserCounterTotal[User.Parameter.VisuSlotID];
                        END_IF
                    END_FOR
                    UserManagementState := IdleUser;
                    RETURN;
                END_IF
                // Role list is too short
            ELSE
                User.Error.No := ERR_ROLE_LIST_TOO_SHORT;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
        PropertyRead:
            ArUserGetProperty_0(Execute := TRUE,  ElementType := arUSER_USER_PROPERTIES, ElementName := tmpUserOld, PropertyName := PropertyName);
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserGetProperty_0.Done AND NOT ArUserGetProperty_0.Busy THEN
                ArUserSetProperty_0.Execute := FALSE;
                UserManagementState := PropertyWrite;
                // Error
            ELSIF ArUserGetProperty_0.Error THEN
                User.Error.No := ArUserGetProperty_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
            // --------------------------------------------------------------------------------------------------------------------
            // Write user property
            // --------------------------------------------------------------------------------------------------------------------
        PropertyWrite:
            ArUserSetProperty_0(Execute := TRUE,  ElementType := arUSER_USER_PROPERTIES, ElementName := tmpUser, PropertyName := PropertyName, PropertyValue := ArUserGetProperty_0.PropertyValue);
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserSetProperty_0.Done AND NOT ArUserSetProperty_0.Busy THEN
                // Read password after user ID
                IF PropertyName = 'UserID' THEN
                    PropertyName := 'Password';
                    ArUserGetProperty_0.Execute := FALSE;
                    UserManagementState := PropertyRead;
                    // Assign roles after password
                ELSIF PropertyName = 'Password' THEN
                    idx := 0;
                    User.Parameter.UserRole := User.Data.Users[tmpUserIdx].Roles[idx];
                    UserManagementState := AssignRole;
                END_IF
                // Error
            ELSIF ArUserSetProperty_0.Error THEN
                User.Error.No := ArUserSetProperty_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
	
            // --------------------------------------------------------------------------------------------------------------------
        AssignRole:
            ArUserAssignRole_0(Execute := TRUE,  UserName := tmpUser, RoleName := User.Parameter.UserRole);
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF User.Command.RoleAssign AND ArUserAssignRole_0.Done AND NOT ArUserAssignRole_0.Busy THEN
                User.Data.Status := 'Role >';
                brsstrcat(ADR(User.Data.Status), ADR(User.Parameter.UserRole));
                brsstrcat(ADR(User.Data.Status), ADR('< assigned to user '));
                brsstrcat(ADR(User.Data.Status), ADR(tmpUser));
                User.Parameter.UserName := '';
                UserManagementState := CreateUserListGetFirst;
            ELSIF User.Command.UserRename AND ((ArUserAssignRole_0.Done AND NOT ArUserAssignRole_0.Busy) OR (ArUserAssignRole_0.ErrorID = arUSER_ERR_ALREADY_EXISTS)) THEN
                idx := idx +1;
                // Assign next role if it exists
                IF User.Data.Users[tmpUserIdx].Roles[idx] <> '' AND idx < MAX_USER_ROLES THEN
                    ArUserAssignRole_0.Execute := FALSE;
                    User.Parameter.UserRole := User.Data.Users[tmpUserIdx].Roles[idx];
                    // Delete old user
                ELSE
                    // Move user names around
                    tmpUserNew := tmpUser;
                    tmpUser := tmpUserOld;
                    UserManagementState := DeleteUser;
                END_IF
                // Error
            ELSIF ArUserAssignRole_0.Error THEN
                User.Error.No := ArUserAssignRole_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
	
            // --------------------------------------------------------------------------------------------------------------------
            // Release user role
            // --------------------------------------------------------------------------------------------------------------------
        ReleaseRole:
            ArUserReleaseRole_0(Execute := TRUE,  UserName := tmpUser, RoleName := User.Parameter.UserRole);
	
            // --------------------------------------------------------------------------------------------------------------------
            // Success
            IF ArUserReleaseRole_0.Done AND NOT ArUserReleaseRole_0.Busy THEN
                User.Data.Status := 'Role >';
                brsstrcat(ADR(User.Data.Status), ADR(User.Parameter.UserRole));
                brsstrcat(ADR(User.Data.Status), ADR('< removed from user '));
                brsstrcat(ADR(User.Data.Status), ADR(tmpUser));
                User.Parameter.UserName := '';
                UserManagementState := CreateUserListGetFirst;
                // Error
            ELSIF ArUserReleaseRole_0.Error THEN
                User.Error.No := ArUserReleaseRole_0.ErrorID;
                User.Error.State := UserManagementState;
                UserManagementState := ErrorUser;
            END_IF
	
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
            IF(User.Error.No = arUSER_ERR_ALREADY_EXISTS) THEN
                User.Error.Text := 'ERR: User/Role already exists or is already assigned';
            ELSIF(User.Error.No = arUSER_ERR_PARAMETER) THEN
                User.Error.Text := 'ERR: User/Role is empty';
            ELSIF(User.Error.No = arUSER_ERR_DOES_NOT_EXIST) THEN
                User.Error.Text := 'ERR: User/Role does not exist';
            ELSIF(User.Error.No = ERR_PASSWORD_MISMATCH) THEN
                User.Error.Text := 'ERR: Passwords do not match';
            ELSIF(User.Error.No = ERR_USER_LIST_TOO_SHORT) THEN
                User.Error.Text := 'ERR: User list is too short';
            ELSIF(User.Error.No = ERR_ROLE_LIST_TOO_SHORT) THEN
                User.Error.Text := 'ERR: Role list is too short';
            ELSIF(User.Error.No = ERR_DELETE_CURRENT_USER) THEN
                User.Error.Text := 'ERR: Can not delete user that is logged in';
            ELSIF(User.Error.No = ERR_USER_ROLE_NAME_SIZE) THEN
                User.Error.Text := 'ERR: User name or role exceeds maximum size of ITEM_LENGTH';
            ELSIF(User.Error.No = ERR_RENAME_CURRENT_USER) THEN
                User.Error.Text := 'ERR: Can not rename user that is logged in';
            ELSE
                User.Error.Text := 'Error executing command';
            END_IF
            // Make sure we dont exceed maximum number of web clients
            IF(User.Parameter.VisuSlotID < SIZEOF(User.Visualization)/SIZEOF(User.Visualization[0])) THEN
                User.Visualization[User.Parameter.VisuSlotID].ShowMessageBoxError := TRUE;
            END_IF
            // --------------------------------------------------------------------------------------------------------------------
            // Return to idle state
            IF User.Command.ErrorReset THEN
                UserCounter := 1;
                RoleCounter := 0;
	
                brsmemset(ADR(User.Error), 0, SIZEOF(User.Error));
                User.Command.ErrorReset := FALSE;
                User.Visualization[User.Parameter.VisuSlotID].ShowMessageBoxError := FALSE;
                UserManagementState := IdleUser;
            END_IF
            brsmemset(ADR(User.Command), 0, SIZEOF(User.Command));
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
    //This instruction Enables the ArUser-Based User Management Page

    gVisuCtrl.cmd.bEnableArUser := TRUE;
    gVisuCtrl.cmd.bEnableMpUserX := FALSE;
	
    IF X = 1 THEN
        TempStr := "Med is logged in";
        MpAuditCustomEvent(gAuditTrailMpLink, TypeVar, "$$Custom/LoggedIn_ID", TempStr);
    END_IF
	
END_PROGRAM

PROGRAM _EXIT
	// Insert code here 
	
END_PROGRAM

