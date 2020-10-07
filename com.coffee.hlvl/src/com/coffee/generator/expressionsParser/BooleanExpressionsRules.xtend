package com.coffee.generator.expressionsParser;

import com.coffee.hlvl.And
import com.coffee.hlvl.Iff
import com.coffee.hlvl.Implies
import com.coffee.hlvl.Negation
import com.coffee.hlvl.Or
import com.coffee.hlvl.VariableRef
import com.coffee.generator.commons.IMiniZincConstants
import com.coffee.hlvl.Equality

/**
 * Implementation of boolean rules
 * @author Angela Villota
 * @version HLVL V1.4
 *  May 2019
 */
public class BooleanExpressionsRules implements IBooleanExpressionsRules, IMiniZincConstants{
	/**
	 * 
	 */
	private IExpressionsParser parser;
	
	new(IExpressionsParser parser) {
		this.parser = parser
		
	}
	override getAnd(And exp) {
		'''(«parser.parse(exp.left)» «AND» «parser.parse(exp.right)»)'''
	}
	
	override getIff(Iff exp) {
		'''(«parser.parse(exp.left)»  «IFF» «parser.parse(exp.right)»)'''
	}
	
	override getImplies(Implies exp) {
		'''(«parser.parse(exp.left)»  «IMPLIES_LR» «parser.parse(exp.right)»)'''
	}
	
	/**
	 * 
	 */
	override getNegation(Negation exp) {
		'''«NOT»(«parser.parse(exp.expression)»)'''
	}
	
	override getOr(Or exp) {
		'''(«parser.parse(exp.left)» «OR» «parser.parse(exp.right)»)'''
	}
	
	override getVariable(VariableRef exp) {
		return exp.variable.name
	}
	
	override getEquality(Equality exp) {
		var out= ""
		if (exp.op== "!="){
			out= '''(«parser.parse(exp.left)» «NEQUIV» «parser.parse(exp.right)»)'''
		}
		else{
			out= '''(«parser.parse(exp.left)» «EQUIV» «parser.parse(exp.right)»)'''
		}
		out
	}
	
	
}