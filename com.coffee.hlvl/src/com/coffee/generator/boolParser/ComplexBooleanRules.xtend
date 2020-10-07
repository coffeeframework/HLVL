package com.coffee.generator.boolParser


import com.coffee.hlvl.Visibility
import java.util.List
import com.coffee.generator.commons.IMiniZincConstants
import com.coffee.generator.expressionsParser.BooleanExpressionsParser
import com.coffee.generator.Dialect
import com.coffee.generator.ComplexTransformationRules
import com.coffee.hlvl.ComplexImplies
import com.coffee.hlvl.ComplexMutex

/**
 * class implementing the boolean transformation rules for in Benavides2010
 * for obtaining the HLCL representation in the MiniZinc language. 
 * This class implements TransformationRules
 * @author Angela Villota
 * @version HLVL V1.4
 * August 2018
 * updated on May 2019
 * modified on July 2019 to comply with the modifications in the syntax method: getDecomposition
 * fixed a bug in the group with cardinality [1,1]
 */

class ComplexBooleanRules extends BasicBooleanRules implements IMiniZincConstants, ComplexTransformationRules
 {
	/**
	 * integer variable to produce the identifiers for the variables and constraints
	 * in visibility relations
	 */
	private int visibilityIdCounter;
	
	
	private BooleanExpressionsParser expressionsParser;
	
	new(Dialect dialect){	
		super(dialect)
		expressionsParser= new BooleanExpressionsParser();
		expressionsParser.dialect = dialect
		visibilityIdCounter=0;
//		cnfBuilder= new StringBuilder();
//		dimacs = new DIMACSRules();
	}
	

	
	//FIXME fix the visibility for CNF representations
	override getVisibility(Visibility rel, List<CharSequence> relations) {
		var out= 
		'''
			var bool: B«visibilityIdCounter»«SEMICOLON»
			constraint «expressionsParser.parse(rel.condition)» -> B«visibilityIdCounter»«SEMICOLON»
		'''
			for (r: relations){
				out+= 
				'''constraint B«visibilityIdCounter»  <-> «r.subSequence(10, r.length)»
			'''
			}
			visibilityIdCounter++
			out
	}
	
	override getComplexImplies(ComplexImplies rel) {
		var  StringBuilder out= new StringBuilder();
		for (element: rel.elements.values){
			out.append(
			'''
			«CONS_DEF» «expressionsParser.parse(rel.exp)» «IMPLIES_LR» «element.name»«SEMICOLON»
			''')
		}
		out.toString;
	}
	
	override getComplexMutex(ComplexMutex rel) {
		var  StringBuilder out= new StringBuilder();
		for (element: rel.elements.values){
			out.append(
			'''
			«CONS_DEF» «NOT»(«expressionsParser.parse(rel.exp)» «AND» «element.name»)«SEMICOLON»
			''')
		}
		out.toString;
	}
	

	
}
