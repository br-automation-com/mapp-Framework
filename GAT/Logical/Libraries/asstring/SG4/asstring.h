/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASSTRING_
#define _ASSTRING_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned short ftoa(float value, unsigned long pString);
_BUR_PUBLIC float atof(unsigned long pString);
_BUR_PUBLIC unsigned short itoa(signed long value, unsigned long pString);
_BUR_PUBLIC signed long atoi(unsigned long pString);


#ifdef __cplusplus
};
#endif
#endif /* _ASSTRING_ */

