/*****************************************************************************
 * COPYRIGHT (C) BERNECKER + RAINER
 *****************************************************************************
 * Library:  UnitTest
 * File:     Asserts.hpp
 * Author:   B+R
 ******************************************************************************/

#include <bur/plctypes.h>

#ifdef __cplusplus

#ifndef	__ASSERTIMPL_CPP_H__
#define	__ASSERTIMPL_CPP_H__


#include <string>


#define TEST_ASSERT_THROW(expression, type  ) \
		do { bool succeeded = false; std::string message( "Expected exception: " #type " not thrown."); \
		try {  expression;  }\
		catch ( const type & ) { succeeded = true;}\
		catch ( const std::exception &e ) { if(!succeeded) { message = "Unexpected exception caught: "; message += e.what();  message += ". Expected: "  #type;  }  }\
		catch ( ... ) { if(!succeeded) { message = "Unexpected exception caught. Expected: "   #type;  }  } \
		if ( succeeded  )  { addPassed("", __LINE__, __FILE__); } \
		else {   addFailure(message.c_str(), __LINE__, __FILE__ ); } \
		} while ( false )

#define TEST_ASSERT_NO_THROW(expression  ) \
		do { bool succeeded = false; 	std::string message(""); \
		try {  expression; succeeded = true;  } \
		catch ( const std::exception &e ) {message += ("Unexpected exception caught: " );  message +=  e.what(); }  \
		catch ( ... ) { message +=  "Unexpected exception caught."; }\
		if ( succeeded  )  { addPassed("", __LINE__, __FILE__); } \
		else { addFailure(message.c_str(), __LINE__, __FILE__ );}  \
		} while ( false )

#define TEST_ASSERT_EQUAL_OBJ(expected,actual)		 assertEquals((expected), (actual),  (UDINT)__LINE__, (const char*) __FILE__);



template <class T>
struct assertion__toString_typ 
{  
	static std::string toString( const T& x )
	{
		return x.c_str();
	}
};

template <class T>
bool assertEquals( const T& expected, const T& actual, unsigned long line, const char *file )
{
	if ( (expected == actual) )
	{
		addPassed("", line, file);
		return true;
	}
	else
	{
		std::string tmp("Objects are not equal. Expected \""); 
		tmp += expected.toString()+ "\" was: \""  + actual.toString() + "\""; 
		addFailure(tmp.c_str(), line, file);
		return false;
	}
}

#endif /* __ASSERTIMPL_CPP_H__*/

#endif
