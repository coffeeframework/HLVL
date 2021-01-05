package com.coffee.generator.integerParser

import com.coffee.generator.AbstractHLVLParser
import com.coffee.generator.Dialect

class BasicIntegerParser extends AbstractHLVLParser  {
	
		new(String name, Dialect dialect) {
		super(name, dialect)
		setTransformationRules(new BasicIntegerRules(dialect))
	}
	
}