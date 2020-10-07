package com.coffee.generator;



import java.util.List;
import com.coffee.hlvl.ComplexImplies;
import com.coffee.hlvl.ComplexMutex;
import com.coffee.hlvl.Visibility;

/**
 * Abstract class to define the methods a class implementing the transformation rules
 * for obtaining the HLCL representation in the MiniZinc language of a variability model. 
 * @author Angela Villota
 * @version HLVL V1.4
 * JULY 2019
 */
public interface ComplexTransformationRules {
	

	public abstract CharSequence getVisibility(Visibility rel, List<CharSequence> relations);
	public abstract CharSequence getComplexImplies(ComplexImplies rel);
	public abstract CharSequence getComplexMutex(ComplexMutex rel);
	

	

	
}