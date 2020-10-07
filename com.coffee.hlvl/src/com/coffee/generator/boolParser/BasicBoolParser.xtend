package com.coffee.generator.boolParser

import com.coffee.generator.AbstractHLVLParser
import com.coffee.generator.Dialect

class BasicBoolParser extends AbstractHLVLParser  {
		new(String name, Dialect dialect) {
		super(name, dialect)
		setTransformationRules(new BasicBooleanRules(dialect))
	}
	
	/**
	 * 
	 */
	
	def  getCNF(){
		var rules= (getTransformationRules() as BasicBooleanRules)
		var program= rules.getHeader();
		program+= 
		'''
		p cnf «rules.getNumClauses» «rules.getNumVars»
		«rules.getCNF» 
		'''
		program
		
	}   
}