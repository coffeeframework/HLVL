package com.coffee.generator.integerParser

import com.coffee.generator.AbstractHLVLParser
import com.coffee.generator.Dialect
import com.coffee.hlvl.Relation
import com.coffee.hlvl.Common
import com.coffee.hlvl.Decomposition
import com.coffee.hlvl.Group
import com.coffee.hlvl.Pair
import com.coffee.hlvl.VarList
import com.coffee.hlvl.Constraint
import com.coffee.hlvl.Visibility
import java.util.ArrayList
import com.coffee.hlvl.ComplexImplies
import com.coffee.hlvl.ComplexMutex
import com.coffee.hlvl.ElmDeclaration
import com.coffee.hlvl.RelDeclaration

class ComplexIntegerParser extends AbstractHLVLParser  {
		new(String name, Dialect dialect) {
		super(name, dialect)
		setTransformationRules(new ComplexIntegerRules(dialect))
	}
	
	/**
	 * 
	 */

	/**
	 * This method parses a variability relation individually.
	 * First, the type of variability relation is determined, then a call to the transfromationRules object
	 * is performed to transform each variability relation into a set of constraints considering the type of problem.   
	 * @param rel is a variability relation
	 */
	override parseRelation(Relation rel) {
		var rules = getTransformationRules() as ComplexIntegerRules;
		switch (rel){
			Common: rules.getCore(rel)
			Decomposition: rules.getDecomposition(rel, parents)
			Group: rules.getGroup(rel, parents)
			Pair: {
				val pair= rel as Pair
				if (pair.operator=="implies"){
					rules.getImpliesPair(rel.var1, rel.var2)
				}
				else{
					rules.getMutexPair(rel.var1, rel.var2)
				}
			}
			VarList:{
				val pair= rel as VarList
				if (pair.operator=="implies"){
					rules.getImpliesList(rel)
				}
				else{
					rules.getMutexList(rel)
				}
			}
			Constraint: rules.getExpression(rel.exp)
			Visibility: {
				var ArrayList<CharSequence> relations= new ArrayList<CharSequence>();
				for(r: rel.list.ids){
					switch(r){
						ElmDeclaration: relations.add('''% a visibility rule n.y.i.''')
						RelDeclaration: relations.add(parseRelation(r.exp))
					}
					//relations.add(parseRelation(r.exp))
				}
				rules.getVisibility(rel, relations)
			}
			ComplexImplies: rules.getComplexImplies(rel)
			ComplexMutex: rules.getComplexMutex(rel)
			
		}
	}   
}
