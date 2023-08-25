#ifndef __TEST_SUITE_H__
#define __TEST_SUITE_H__

bool RecipeExists(char* recipeName);
bool SelectRecipe(char* wantedRecipe);
testStatusEnum RemoveNonDefaultFiles(USINT categoryIndex, char* selectFile, const char* category);

#endif
