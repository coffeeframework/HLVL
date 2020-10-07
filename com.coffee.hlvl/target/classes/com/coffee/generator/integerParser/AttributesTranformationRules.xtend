package com.coffee.generator.integerParser;

import com.coffee.hlvl.ElmDeclaration

import com.coffee.generator.Dialect

class AttributesTranformationRules extends BasicIntegerRules implements IAttributesRules {
	
	new(Dialect dialect) {
		super(dialect)
	}
	
	override getDecompositionAtt(ElmDeclaration parent, ElmDeclaration attribute) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	

	
}