package com.coffee.generator;


import java.util.Map;

import com.coffee.hlvl.ElmDeclaration;
import com.coffee.hlvl.Common;
import com.coffee.hlvl.Decomposition;
import com.coffee.hlvl.Group;
import com.coffee.hlvl.VarList;
import com.coffee.hlvl.Relational;

/**
 * Abstract class to define the methods a class implementing the transformation rules
 * for obtaining the HLCL representation in the MiniZinc language of a variability model. 
 * This class is extended by the classes BooleanRules
 * @author Angela Villota
 * @version HLVL V1.4
 * August 2018
 * updated on May 2019
 */
public abstract class TransformationRules {
	

	// Variables related methods
	public abstract CharSequence getConstant(ElmDeclaration element);
	public  abstract CharSequence getElement(ElmDeclaration element);
	
	
	
	
	public CharSequence getCore(Common core) {
		StringBuilder out= new StringBuilder();
		for(ElmDeclaration element: core.getElements().getValues()){
			out.append(getCoreSingle(element));	
		}
		return out.toString();
	}
	
	public CharSequence getImpliesList(VarList rel) {
		StringBuilder out= new StringBuilder();
		for( ElmDeclaration element: rel.getList().getValues()){
			out.append(getImpliesPair(rel.getVar1(), element));
		}
		return out.toString();
	}
	
	public CharSequence getMutexList(VarList rel) {
		StringBuilder out= new StringBuilder();
		for(ElmDeclaration element: rel.getList().getValues()){
			out.append(getMutexPair(rel.getVar1(), element));
		}	
		return out.toString();
	}
	public abstract CharSequence getCoreSingle(ElmDeclaration element);
	public abstract CharSequence getDecomposition(Decomposition rel, Map<String,ElmDeclaration> parents);
	public abstract CharSequence getGroup(Group rel, Map<String,ElmDeclaration> parents);
	public abstract CharSequence getImpliesPair(ElmDeclaration left, ElmDeclaration right);
	public abstract CharSequence getMutexPair(ElmDeclaration left, ElmDeclaration right);
	public abstract CharSequence getExpression(Relational rel);
	//public abstract CharSequence getVisibility(Visibility rel, List<CharSequence> relations);
	

	

	
}