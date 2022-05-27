
TYPE
    MpRecipeXmlAlarmEnum : 
        ( (* Alarms of MpRecipe Xml *)
        mpRECIPE_ALM_SAVE_FAILED := 0, (* Saving of recipe failed. *)
        mpRECIPE_ALM_SAVE_FAILED_PART := 1, (* Saving of recipe failed partially. Parts of the recipe could be saved. *)
        mpRECIPE_ALM_LOAD_FAILED := 2, (* Loading of recipe failed. *)
        mpRECIPE_ALM_LOAD_FAILED_PART := 3 (* Loading of recipe failed partially. Parts of the recipe could be loaded. *)
    );
END_TYPE
