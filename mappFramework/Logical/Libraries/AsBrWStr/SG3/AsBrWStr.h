/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASBRWSTR_
#define _ASBRWSTR_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _IEC_CONST
#define _IEC_CONST _WEAK const
#endif

/* Constants */
#ifdef _REPLACE_CONST
 #define brwUCtoU8 1U
 #define brwU8toUC 0U
#else
 _IEC_CONST unsigned char brwUCtoU8 = 1U;
 _IEC_CONST unsigned char brwU8toUC = 0U;
#endif







/* Prototyping of functions and function blocks */
unsigned long brwcsconv(unsigned char* pDestination, unsigned char* pSource, unsigned char level);
unsigned long brwcsncpy(unsigned short* pDestination, unsigned short* pSource, unsigned long n);
unsigned long brwcsncat(unsigned short* pDestination, unsigned short* pSource, unsigned long n);
unsigned long brwcscat(unsigned short* pDestination, unsigned short* pSource);
signed long brwcscmp(unsigned short* pUcstr1, unsigned short* pUcstr2);
unsigned long brwcslen(unsigned short* pwcString);
unsigned long brwcsset(unsigned short* pDestination, unsigned long len, unsigned short symbol);
signed long brwcsncmp(unsigned short* pwcString1, unsigned short* pwcString2, unsigned long n);
unsigned long brwcscpy(unsigned short* pDestination, unsigned short* pSource);
unsigned long brwcsrchr(unsigned short* pDestination, unsigned short symbol);
unsigned long brwcschr(unsigned short* pDestination, unsigned short symbol);


#ifdef __cplusplus
};
#endif
#endif /* _ASBRWSTR_ */

