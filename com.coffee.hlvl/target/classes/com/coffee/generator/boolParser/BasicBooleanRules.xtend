package com.coffee.generator.boolParser

import com.coffee.hlvl.ElmDeclaration
import com.coffee.hlvl.Decomposition
import java.util.Map
import com.coffee.hlvl.Relational
import com.coffee.hlvl.Group
import com.coffee.hlvl.ConstantDecl
import com.coffee.generator.commons.IMiniZincConstants
import com.coffee.generator.TransformationRules
import com.coffee.generator.expressionsParser.BooleanExpressionsParser
import com.coffee.generator.Dialect
import com.coffee.hlvl.BoolConstant
import java.util.List

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

class BasicBooleanRules extends TransformationRules implements IMiniZincConstants
 {
	/**
	 * integer variable to produce the identifiers for the variables and constraints
	 * in visibility relations
	 */
	private int visibilityIdCounter;
	
	private DIMACSRules dimacs;
	
	private BooleanExpressionsParser expressionsParser;
	
	private StringBuilder cnfBuilder;
		
	new(Dialect dialect){	
		expressionsParser= new BooleanExpressionsParser();
		expressionsParser.dialect = dialect
		visibilityIdCounter=0;
		cnfBuilder= new StringBuilder();
		dimacs = new DIMACSRules();
	}
	
	def String getCNF(){
		return cnfBuilder.toString();
	}
	override getConstant(ElmDeclaration element) {
		val value= (element.declaration as ConstantDecl).value
		cnfBuilder.append(dimacs.getElement(element))
		'''«BOOL_DOMAIN» «COLON» «element.name» «ASSIGN» «(value as BoolConstant).value»  «SEMICOLON»
		'''
	}
	
	override getElement(ElmDeclaration element) {
		//var String out=""
		//val declaration= element.declaration as VariableDecl
		cnfBuilder.append(dimacs.getElement(element))
		'''«VAR_DEF» «BOOL_DOMAIN» «COLON» «element.name» «SEMICOLON»
		'''
		
	}
	

	
	override getCoreSingle(ElmDeclaration element){
		cnfBuilder.append(dimacs.getCoreSingle(element))
		
		'''«CONS_DEF» «element.name» «EQUIV» «TRUE_ATOM» «SEMICOLON»
		'''
	}
	
	override getDecomposition(Decomposition rel, Map<String, ElmDeclaration> parents) {
		var out=""
		for(element: rel.children.values){
			parents.put(element.name, rel.parent)
			//TODO modified by avillota to comply with the syntax changes
			if(rel.min==1 && rel.max==1){
				out+= '''«CONS_DEF» «rel.parent.name» «IFF» «element.name» «SEMICOLON»
				'''
				cnfBuilder.append(dimacs.getMandatory(rel.parent.name, element.name));
			}
			else{
				out+= '''«CONS_DEF» «element.name» «IMPLIES_LR» «rel.parent.name» «SEMICOLON»
				'''
				cnfBuilder.append(dimacs.getOptional(rel.parent.name, element.name));
			}
		}
		out
	}
	
	/**
	 * 
	 */
	override getGroup(Group rel, Map<String, ElmDeclaration> parents) {
		// groups [1, 1] alternative
		if (rel.min == 1 && rel.max.value == "1") {
			cnfBuilder.append(dimacs.getXor(rel))
			getXor(rel, parents)
		} // TODO include the [n, m] rule from literature
		// groups [1, *] OR groups
		else {
			cnfBuilder.append(dimacs.getOR(rel))
			getOR(rel, parents)
		}
	}
	
	def getXor(Group rel, Map<String, ElmDeclaration> parents){
		var out=""
		for(element: rel.children.values){
			parents.put(element.name, rel.parent)
			out+= '''«CONS_DEF» «element.name» «IFF» «OPEN_CALL»'''
			for(inElement: rel.children.values){
				if(element.name!= inElement.name){
					out+='''«NOT»«OPEN_CALL»«inElement.name»«CLOSE_CALL» «AND» '''
				}
			}
			out += '''«rel.parent.name»«CLOSE_CALL» «SEMICOLON»
			'''
		}
		out
	}
	
	def getOR(Group rel, Map<String, ElmDeclaration> parents){
		var out='''«CONS_DEF» «rel.parent.name» «IFF» «OPEN_CALL»'''
		for(element: rel.children.values){
			parents.put(element.name, rel.parent)
			out+= ''' «element.name» «OR»'''
		}
		out= out.subSequence(0, out.length-2) +'''«CLOSE_CALL» «SEMICOLON»
		'''
		out
	}
	
	override getImpliesPair(ElmDeclaration left, ElmDeclaration right) {
		cnfBuilder.append(dimacs.getImpliesPair(left, right));
		'''«CONS_DEF» «left.name» «IMPLIES_LR» «right.name» «SEMICOLON»
		'''
	}
	
	override getMutexPair(ElmDeclaration left, ElmDeclaration right) {
		cnfBuilder.append(dimacs.getMutexPair(left, right));
		'''«CONS_DEF» «NOT» «OPEN_CALL»«left.name» «AND» «right.name»«CLOSE_CALL»«SEMICOLON»
		'''
	}
	
	
	//FIXME fix the 
	override getExpression(Relational exp) {
		'''«CONS_DEF» «expressionsParser.parse(exp)»«SEMICOLON»
		'''
	}
	

	
	/*===================================================================
	 *===================================================================
	 * Methods for DIMACS notation
	 * */
	 
	 def getHeader(){
	 	return dimacs.getHeader();
	 }
	 
	 def getNumClauses(){
	 	return dimacs.getNumClauses();
	 }
	 
	 def getNumVars(){
	 	return dimacs.getNumVars();
	 }
	
	
}
