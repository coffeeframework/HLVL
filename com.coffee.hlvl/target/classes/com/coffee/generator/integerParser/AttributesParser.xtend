package com.coffee.generator.integerParser;

import com.coffee.generator.Dialect
import com.coffee.hlvl.Model
import com.coffee.hlvl.ConstantDecl
import com.coffee.hlvl.VariableDecl
import java.util.Map
import com.coffee.hlvl.ElmDeclaration
import java.util.HashMap

class AttributesParser extends ComplexIntegerParser {

	private Map<String, ElmDeclaration> attributes;

	new(String name, Dialect dialect) {
		super(name, dialect)
		setTransformationRules(new ComplexIntegerRules(dialect))
		
		attributes= new HashMap<String,ElmDeclaration>();
		
	}

	/**
	 * This method traverses the collection of elements to produce a block of code containing the 
	 * declaration of the elements represented as variables in the minizinc language
	 *  The code for translating an element declaration and relation is produced by an object called rule containing the
	 * transformation rules.  
	 * @param model
	 */
	override parseElements(Model model) {
		var StringBuilder builder = new StringBuilder();
		var rules = getTransformationRules();

		for (element : model.elements) {
			if (element.att !== null && element.att == "att") {
				attributes.put(element.name, element)
			} else {
				if (element.declaration instanceof ConstantDecl) {
					val value = (element.declaration as ConstantDecl).value
					// una declaracion boolean sin dominio es considerada ConstantDecl
					if (element.dataType == "boolean" && value === null) { // && (value as BoolVal).value===null){
						builder.append(rules.getElement(element))
					} else {
						builder.append(rules.getConstant(element))
					}
				} else if (element.declaration instanceof VariableDecl) {
					builder.append(rules.getElement(element))
				}

			}
		}
		builder.toString()
	}

}
