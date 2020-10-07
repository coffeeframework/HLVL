package com.coffee.generator.expressionsParser;


import com.coffee.hlvl.BinaryFunction;
import com.coffee.hlvl.Comparison;
import com.coffee.hlvl.Minus;
import com.coffee.hlvl.MulOrDiv;
import com.coffee.hlvl.Plus;
import com.coffee.hlvl.UnaryFunction;

/**
 * Interface for the transformation rules used exclusively in the languages
 * supporting only boolean elements
 * @author Angela Villota
 * @version HLVL V1.4
 * August 2018
 * July 2019
 */
public interface IIntegerExpressionsRules extends IBooleanExpressionsRules{
	public CharSequence getComparison(Comparison exp);
	public CharSequence getPlus(Plus exp);
	public CharSequence getMinus(Minus exp);
	public CharSequence getMulOrDiv(MulOrDiv exp);
	public CharSequence getBinaryFunction(BinaryFunction exp);
	public CharSequence getUnaryFunction(UnaryFunction exp);

}
