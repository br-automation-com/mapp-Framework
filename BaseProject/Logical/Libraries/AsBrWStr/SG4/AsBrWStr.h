/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ASBRWSTR_
#define _ASBRWSTR_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define brwU8toUC 0U
 #define brwUCtoU8 1U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned char brwU8toUC;
 _GLOBAL_CONST unsigned char brwUCtoU8;
#endif







/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned long brwcsconv(unsigned char* pDestination, unsigned char* pSource, unsigned char level);
_BUR_PUBLIC unsigned long brwcsncpy(unsigned short* pDestination, unsigned short* pSource, unsigned long n);
_BUR_PUBLIC unsigned long brwcsncat(unsigned short* pDestination, unsigned short* pSource, unsigned long n);
_BUR_PUBLIC unsigned long brwcscat(unsigned short* pDestination, unsigned short* pSource);
_BUR_PUBLIC signed long brwcscmp(unsigned short* pUcstr1, unsigned short* pUcstr2);
_BUR_PUBLIC unsigned long brwcslen(unsigned short* pwcString);
_BUR_PUBLIC unsigned long brwcsset(unsigned short* pDestination, unsigned long len, unsigned short symbol);
_BUR_PUBLIC signed long brwcsncmp(unsigned short* pwcString1, unsigned short* pwcString2, unsigned long n);
_BUR_PUBLIC unsigned long brwcscpy(unsigned short* pDestination, unsigned short* pSource);
_BUR_PUBLIC unsigned long brwcsrchr(unsigned short* pDestination, unsigned short symbol);
_BUR_PUBLIC unsigned long brwcschr(unsigned short* pDestination, unsigned short symbol);


#ifdef __cplusplus
};
#endif
#endif /* _ASBRWSTR_ */

