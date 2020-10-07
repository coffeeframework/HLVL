package com.coffee.generator.expressionsParser;


import com.coffee.hlvl.VariableRef
import com.coffee.generator.commons.IMiniZincConstants
import com.coffee.hlvl.BinaryFunction
import com.coffee.hlvl.Comparison
import com.coffee.hlvl.Minus
import com.coffee.hlvl.MulOrDiv
import com.coffee.hlvl.Plus
import com.coffee.hlvl.UnaryFunction
import com.coffee.generator.Dialect
import com.coffee.hlvl.Equality

/**
 * Implementation of boolean rules
 * @author Angela Villota
 * @version HLVL V1.4
 *  May 2019
 */
public class IntegerExpressionsRules extends BooleanExpressionsRules implements IIntegerExpressionsRules, IMiniZincConstants{
	/**
	 * 
	 */
	private IExpressionsParser parser;
	private Dialect dialect;

	new(IExpressionsParser parser, Dialect dialect) {
		super(parser)
		this.parser = parser
		this.dialect = dialect
	}
	
	override getVariable(VariableRef exp) {
		if (exp.variable.dataType =="boolean" && 
			(dialect==Dialect.BASIC_INT || 
				dialect==Dialect.ATTRIBUTE ||
				dialect==Dialect.MULTIPLICITY)){
					return '''«exp.variable.name» > 0''' 
				}else{
					return exp.variable.name 
				}
	}
	
	
	override getComparison(Comparison exp) {
		if (exp.op == ">=") {
			'''(«parser.parse(exp.left)» «GEQ» «parser.parse(exp.right)»)'''
		} else if (exp.op == "<=") {
			'''(«parser.parse(exp.left)» «LEQ» «parser.parse(exp.right)»)'''
		} else if (exp.op == ">") {
			'''(«parser.parse(exp.left)» «GT» «parser.parse(exp.right)»)'''
		} else if (exp.op == "<") {
			'''(«parser.parse(exp.left)» «LT» «parser.parse(exp.right)»)'''
		}
	}
	
	override getMinus(Minus exp) {
		'''(«parser.parse(exp.left)» «MINUS» «parser.parse(exp.right)»)'''
	}
	
	override getMulOrDiv(MulOrDiv exp) {
		if (exp.op == "*") {
			'''( «parser.parse(exp.left)» «TIMES» «parser.parse(exp.right)»)'''
		} else if (exp.op == "/") {
			'''( «parser.parse(exp.left)» «DIV» «parser.parse(exp.right)»)'''
		} else {
			'''( «parser.parse(exp.left)» «MOD» «parser.parse(exp.right)»)'''
		}
	}
	
	override getPlus(Plus exp) {
		'''(«parser.parse(exp.left)» «PLUS» «parser.parse(exp.right)»)'''
	}
	
	override getUnaryFunction(UnaryFunction exp) {
		if (exp.op == "abs" ){
			'''«ABSOLUTE_VALUE»(«parser.parse(exp.expression)»)'''
		}else if (exp.op == "sqrt") {
			'''«SQUARE_ROOT»(«parser.parse(exp.expression)»)'''
		}
	}
	
	override getBinaryFunction(BinaryFunction exp) {
		if (exp.op == "pow" ){
			'''«MIN»(«parser.parse(exp.left)» «COMMA» «parser.parse(exp.right)»)'''
		}else if (exp.op == "min") {
			'''«MAX»(«parser.parse(exp.left)» «COMMA» «parser.parse(exp.right)»)'''
		}else if (exp.op == "max") {
			'''«POWER»(«parser.parse(exp.left)» «COMMA» «parser.parse(exp.right)»)'''
		}
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