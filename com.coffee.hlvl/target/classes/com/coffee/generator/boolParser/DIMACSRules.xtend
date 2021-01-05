package com.coffee.generator.boolParser

import java.util.Map
import java.util.HashMap
import com.coffee.generator.TransformationRules
import com.coffee.hlvl.ElmDeclaration
import com.coffee.hlvl.Decomposition
import com.coffee.hlvl.Relational
import com.coffee.hlvl.Group

/**
 * class implementing the boolean transformation rules for obtaining a DIMACS (cnf) representation
 * This class implements TransformationRules
 * @author Angela Villota
 * @version HLVL V1.4
 * July 2019
 */
class DIMACSRules extends TransformationRules {

	/**
	 * Strings in the Textual DIMACS format
	 */
	private static final String HEADER = '''
		c
		c DIMACS code generated using the Coffee framework
		c
	'''
	/**
	 * number of clauses in the problem
	 */
	protected int numClauses

	/**
	 * Map of variables to obtain the numeric Id using the name of 
	 * the variable as key
	 */
	protected Map<String, Integer> variables

	/**
	 * Constructor 
	 */
	new() {
		numClauses = 0
		variables = new HashMap<String, Integer>()
	}

	/**
	 * @returns returns the code generated for the 
	 * header of a CNF file in the DIMACS format
	 */
	def getHeader() {
		return HEADER
	}

	override getCoreSingle(ElmDeclaration element) {
		addNumClauses(1)
		'''«variables.get(element.name)»
		'''
	}

	/**
	 * 
	 */
	override getDecomposition(Decomposition rel, Map<String, ElmDeclaration> parents) {
		var out = ""
		for (child : rel.children.values) {
			parents.put(child.name, rel.parent)
			// TODO modified by avillota to comply with the syntax changes
			if (rel.min == 1 && rel.max == 1) { // mandatory
				addNumClauses(2)
				out += '''
					«variables.get(rel.parent.name)» -«variables.get(child.name)»
					-«variables.get(rel.parent.name)» «variables.get(child.name)»
				'''
			} else { // optional
				addNumClauses(1)
				out += '''
					-«variables.get(child.name)» «variables.get(rel.parent.name)»
				'''
			}
		}
		out
	}

	/**
	 * Method to obtain a CNF representation of a mandatory relation 
	 */
	def getMandatory(String parent, String child) {
		addNumClauses(2)
		'''
			«variables.get(parent)» -«variables.get(child)»
			-«variables.get(parent)» «variables.get(child)»
		'''
	}

	/**
	 * Method to obtain a CNF representation of an optional relation 
	 */
	def getOptional(String parent, String child) {
		addNumClauses(1)
		'''
			-«variables.get(child)» «variables.get(parent)»
		'''
	}

	/**
	 * This method includes the variable name in a variables map to obtain an
	 * integer for the DIMACS transformation
	 * @param element is a ElmDeclaration
	 * @return the empty String, variables are not translated in the DIMCAS code
	 */
	override getElement(ElmDeclaration element) {
		if (!variables.containsKey(element.name)) {
			val id = variables.keySet.size + 1
			variables.put(element.name, id)
		}
		''''''
	}

	// FIXME arreglar la asignacion
	override getConstant(ElmDeclaration element) {
		val id = variables.keySet.size + 1
		variables.put(element.name, id)
		''''''
	}

	override getExpression(Relational rel) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getGroup(Group rel, Map<String, ElmDeclaration> parents) {
		// groups [1, 1] alternative
		if (rel.min == 1 && rel.max.value == "1") {
			getXor(rel)
		} // TODO include the [n, m] rule from literature
		// groups [1, *] OR groups
		else {
			getOR(rel)
		}
	}

	def getXor(Group rel) {
		var out = ""
		// There are n+1 clauses for each child
		for (child : rel.children.values) {
			addNumClauses(rel.children.values.size + 1)
			var singleClause = '''-«variables.get(rel.parent.name)» «variables.get(child.name)»'''
			var clauses = '''
				-«variables.get(child.name)» «variables.get(rel.parent.name)»
			'''
			for (inChild : rel.children.values) {
				if (!(child.name == inChild.name)) {
					singleClause += ''' «variables.get(inChild.name)»'''
					clauses += '''
						-«variables.get(child.name)» -«variables.get(inChild.name)»
					'''
				}
			}
			out += '''
				«singleClause»
				«clauses»
			'''
		}
		out
	}

	def getOR(Group rel) {
		var output = ""
		// in total are |children| +1 clauses
		addNumClauses(rel.children.values.size + 1)
		var singleClause = '''-«variables.get(rel.parent.name)»'''
		var clauses = ""
		for (child : rel.children.values) {
			singleClause += ''' «variables.get(child.name)»'''
			clauses += '''«variables.get(rel.parent.name)» -«variables.get(child.name)»
			'''
		}
		output = '''
			«singleClause»
			«clauses»
		'''
		return output;
	}

	override getImpliesPair(ElmDeclaration left, ElmDeclaration right) {
		addNumClauses(1)
		'''
			-«variables.get(left.name)» «variables.get(right.name)»
		'''
	}

	override getMutexPair(ElmDeclaration left, ElmDeclaration right) {
		addNumClauses(1)
		'''
			-«variables.get(left.name)» -«variables.get(right.name)»
		'''
	}

	/*===================================================================
	 * ===================================================================
	 * Methods used just in this notation
	 * */
	/** 
	 * Increased the count of clauses by the number in amount
	 * @param number of clauses to add
	 */
	def void addNumClauses(int amount) {
		numClauses += amount
	}

	/**
	 * @return returns the number of variables in the problem
	 */
	def getNumVars() {
		return variables.keySet.size
	}

	/**
	 * @return returns the number of generated clauses
	 */
	def getNumClauses() {
		return numClauses
	}

}
