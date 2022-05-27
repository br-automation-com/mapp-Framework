/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASBRSTR_
#define _ASBRSTR_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif




/* Prototyping of functions and function blocks */
unsigned short brsftoa(float value, unsigned long pString);
float brsatof(unsigned long pString);
unsigned short brsitoa(signed long value, unsigned long pString);
signed long brsatoi(unsigned long pString);
unsigned long brsmemset(unsigned long pDest, unsigned char value, unsigned long length);
unsigned long brsmemcpy(unsigned long pDest, unsigned long pSrc, unsigned long length);
unsigned long brsmemmove(unsigned long pDest, unsigned long pSrc, unsigned long length);
signed long brsmemcmp(unsigned long pMem1, unsigned long pMem2, unsigned long length);
unsigned long brsstrcat(unsigned long pDest, unsigned long pSrc);
unsigned long brsstrlen(unsigned long pString);
unsigned long brsstrcpy(unsigned long pDest, unsigned long pSrc);
signed long brsstrcmp(unsigned long pString1, unsigned long pString2);


#ifdef __cplusplus
};
#endif
#endif /* _ASBRSTR_ */

