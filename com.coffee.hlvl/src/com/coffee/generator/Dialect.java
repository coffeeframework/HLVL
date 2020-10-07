package com.coffee.generator;


/**
 * type of problem can be 
 * BASIC_BOOL, for models with the basic constructs and translated into boolean problems
 * BASIC_INT, for models with the basic constructs and translated into integer problems
 * ATTRIBUTE, for models with attributes
 * MULTIPLICITY for models with multiplicities
 * Modified on july 2019 
*/
public enum Dialect {
	BASIC_BOOL,
	BASIC_INT,
	COMPLEX_BOOL,
	COMPLEX_INT,
	ATTRIBUTE,
	MULTIPLICITY

}
