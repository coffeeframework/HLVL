package com.coffee.generator.commons;


/**
 * Interface containing the MiniZinc constants 
 * @author Angela Villota
 * @version HLVL V1.4
 * August 2018
 * updated on May 2019
 */

public interface IMiniZincConstants {
	
	public static  final String SEMICOLON=";";
	public static  final String COMMA=",";
	public static  final String COLON=":";
	public static  final String OPEN_CALL="(";
	public static  final String CLOSE_CALL=")";
	
	//
	public static  final String VAR_DEF="var";
	public static  final String BOOL_DOMAIN="bool";
	public static  final String ASSIGN="=";
	
	// Integer declarations
	public static  final String INT_DOMAIN="int";
	public static  final String INT_TRUE="1";

	//Constraints
	public static final String CONS_DEF ="constraint"; 

	//Relational operators

	public static final String EQUIV ="==" ;
	public static final String NEQUIV ="!=" ;
	public static final String LT ="<";
	public static final String GT =">";
	public static final String LEQ ="<=";
	public static final String GEQ=">=";

	//Logic
	public static final String IFF="<->";
	public static final String IMPLIES_LR="->";
	public static final String IMPLIES_R_="<-";
	public static final String OR="\\/";
	public static final String AND="/\\";
	public static final String NOT="not";


	//Atoms
	public static final String TRUE_ATOM ="true"; 
	public static final String FALSE_ATOM ="false"; 
	
	// Arithmetic operators
	public static final String PLUS="+";
	public static final String MINUS="-";
	public static final String TIMES="*";
	public static final String DIV="/";
	public static final String MOD="mod";
	
	//UNARY FUNCTIONS
	public static final String ABSOLUTE_VALUE="abs";
	public static final String SQUARE_ROOT="sqrt";
	
	//BINARY FUNCTIONS
	
	public static  final String MIN="min";
	public static  final String MAX="max";
	public static  final String POWER="pow";
	

}
