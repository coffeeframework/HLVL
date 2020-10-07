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
import com.coffee.hlvl.IntConstant
import com.coffee.hlvl.SymbolConstant
import java.util.Map
import com.coffee.hlvl.Equality
import com.coffee.hlvl.Comparison
import com.coffee.hlvl.Plus
import com.coffee.hlvl.Minus
import com.coffee.hlvl.MulOrDiv
import com.coffee.hlvl.UnaryFunction
import com.coffee.hlvl.BinaryFunction

/**
 * Parser for boolean expressions 
 * @author Angela Villota
 * @version HLVL V1.4
 *  July 2019
 */

class IntegerExpressionsParser extends BooleanExpressionsParser implements IExpressionsParser {
	/** 
	 * Tranformation rules
	 */
	private IntegerExpressionsRules rules;
	
	private Dialect dialect;
	
	/**
	 * 
	 */
	private Map<String, Integer> symbolsMap
	
	new( Map<String, Integer> map, Dialect dialect ){
		symbolsMap= map
		this.dialect= dialect;
		rules= new IntegerExpressionsRules(this, dialect)
	}
	
	override setDialect(Dialect dialect) {
		this.dialect= dialect;
	}
	
	override parse(Relational exp) {
		
		switch(exp){
			BoolConstant: exp.value
			IntConstant: exp.value.toString
			SymbolConstant: {
				symbolsMap.get(exp.value).toString
			}
			// Boolean operations
			VariableRef: rules.getVariable(exp)
			Negation: rules.getNegation(exp)
			Iff: rules.getIff(exp)
			Implies: rules.getImplies(exp)
			Or: rules.getOr(exp)
			And: rules.getAnd(exp)
			Equality: rules.getEquality(exp) 
			
			// Integer operations
			Comparison: rules.getComparison(exp)
			Plus: rules.getPlus(exp)
			Minus: rules.getMinus(exp)
			MulOrDiv: rules.getMulOrDiv(exp)
			UnaryFunction: rules.getUnaryFunction(exp)
			BinaryFunction: rules.getBinaryFunction(exp)
		}
	}
}

