package com.coffee.generator.expressionsParser;


import com.coffee.hlvl.And;
import com.coffee.hlvl.Equality;
import com.coffee.hlvl.Iff;
import com.coffee.hlvl.Implies;
import com.coffee.hlvl.Negation;
import com.coffee.hlvl.Or;
import com.coffee.hlvl.VariableRef;

/**
 * Interface for the transformation rules used exclusively in the languages
 * supporting only boolean elements
 * @author Angela Villota
 * @version HLVL V1.4
 * August 2018
 * updated on May 2019
 */
public interface IBooleanExpressionsRules {
	
	public CharSequence getVariable(VariableRef exp);
	public CharSequence getNegation(Negation exp);
	public CharSequence getIff(Iff exp);
	public CharSequence getImplies(Implies exp);
	public CharSequence getAnd(And exp);
	public CharSequence getOr(Or exp);
	public CharSequence getEquality(Equality exp);

}
