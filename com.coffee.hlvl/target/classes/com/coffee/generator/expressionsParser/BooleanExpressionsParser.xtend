package com.coffee.generator.expressionsParser;

import com.coffee.hlvl.Relational
import com.coffee.hlvl.BoolConstant
import com.coffee.hlvl.VariableRef
import com.coffee.hlvl.Negation
import com.coffee.hlvl.Iff
import com.coffee.hlvl.Implies
import com.coffee.hlvl.Or
import com.coffee.hlvl.And
import com.coffee.generator.Dialect
import com.coffee.hlvl.Equality

/**
 * Parser for boolean expressions 
 * @author Angela Villota
 * @version HLVL V1.4
 *  May 2019
 */

class BooleanExpressionsParser implements IExpressionsParser {
	/** 
	 * Tranformation rules
	 */
	private IBooleanExpressionsRules rules;
	
	private Dialect dialect;
	
	new(){
		rules= new BooleanExpressionsRules(this)
	}
	override setDialect(Dialect dialect) {
		this.dialect= dialect;
	}
	
	override parse(Relational exp) {
		
		switch(exp){
			BoolConstant: exp.value
			VariableRef: rules.getVariable(exp)
			Negation: rules.getNegation(exp)
			Iff: rules.getIff(exp)
			Implies: rules.getImplies(exp)
			Or: rules.getOr(exp)
			And: rules.getAnd(exp)
			Equality: rules.getEquality(exp) 
			

		}
	}
}