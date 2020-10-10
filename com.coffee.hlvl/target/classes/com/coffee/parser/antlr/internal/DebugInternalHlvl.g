/*
 * generated by Xtext 2.22.0
 */
grammar DebugInternalHlvl;

// Rule Model
ruleModel:
	'model'
	RULE_ID
	(
		'extends'
		ruleListOfModelRef
	)?
	'elements:'
	ruleElmDeclaration
	*
	'relations:'
	ruleRelDeclaration
	*
	(
		'operations:'
		ruleOperations
	)?
;

// Rule ListOfModelRef
ruleListOfModelRef:
	ruleModelRef
	(
		','+
		ruleModelRef
	)*
;

// Rule ModelRef
ruleModelRef:
	RULE_STRING
;

// Rule ElmDeclaration
ruleElmDeclaration:
	'att'
	?
	(
		'boolean'
		    |
		'integer'
		    |
		'symbolic'
	)
	RULE_ID
	ruleDeclaration
	(
		'comment:'
		'{'
		RULE_STRING
		'}'
	)?
;

// Rule Declaration
ruleDeclaration:
	(
		ruleConstantDecl
		    |
		ruleVariableDecl
	)
;

// Rule ConstantDecl
ruleConstantDecl:
	(
		'is'
		ruleRelational
	)?
;

// Rule VariableDecl
ruleVariableDecl:
	'variants:'
	ruleOptionsDeclaration
;

// Rule OptionsDeclaration
ruleOptionsDeclaration:
	(
		ruleInterval
		    |
		ruleEnumeration
	)
;

// Rule Interval
ruleInterval:
	RULE_INT
	'..'
	RULE_INT
;

// Rule Enumeration
ruleEnumeration:
	'['
	ruleListOfValues
	']'
;

// Rule RelDeclaration
ruleRelDeclaration:
	RULE_ID
	':'
	ruleRelation
;

// Rule Relation
ruleRelation:
	(
		ruleCommon
		    |
		rulePair
		    |
		ruleVarList
		    |
		ruleOrder
		    |
		ruleDecomposition
		    |
		ruleGroup
		    |
		ruleConstraint
		    |
		ruleVisibility
		    |
		ruleComplexImplies
		    |
		ruleComplexMutex
	)
;

// Rule Common
ruleCommon:
	'common'
	'('
	ruleListOfIDs
	')'
;

// Rule Pair
rulePair:
	(
		'implies'
		    |
		'mutex'
	)
	'('
	ruleGeneralQualifiedName
	','
	ruleGeneralQualifiedName
	')'
;

// Rule ComplexImplies
ruleComplexImplies:
	'implies'
	'('
	'('
	ruleRelational
	')'
	','
	'['
	ruleMixedListOfIDs
	']'
	')'
;

// Rule ComplexMutex
ruleComplexMutex:
	'mutex'
	'('
	'('
	ruleRelational
	')'
	','
	'['
	ruleMixedListOfIDs
	']'
	')'
;

// Rule VarList
ruleVarList:
	(
		'implies'
		    |
		'mutex'
	)
	'('
	ruleGeneralQualifiedName
	','
	'['
	ruleMixedListOfIDs
	']'
	')'
;

// Rule Decomposition
ruleDecomposition:
	'decomposition'
	'('
	RULE_ID
	','
	'['
	ruleListOfIDs
	']'
	','
	'['
	RULE_INT
	','
	RULE_INT
	']'
	')'
;

// Rule Group
ruleGroup:
	'group'
	'('
	RULE_ID
	','
	'['
	ruleListOfIDs
	']'
	','
	'['
	RULE_INT
	','
	ruleRange
	']'
	')'
;

// Rule Range
ruleRange:
	ruleWildcard
;

// Rule Wildcard
ruleWildcard:
	(
		RULE_INT
		    |
		'*'
	)
;

// Rule Visibility
ruleVisibility:
	'visibility'
	'('
	ruleRelational
	','
	'['
	ruleMixedList
	']'
	')'
;

// Rule Order
ruleOrder:
	(
		'before'
		    |
		'after'
		RULE_ID
		','
		'['
		ruleListOfIDs
		']'
	)
;

// Rule Constraint
ruleConstraint:
	'expression'
	'('
	ruleRelational
	')'
;

// Rule Relational
ruleRelational:
	ruleIff
;

// Rule Iff
ruleIff:
	ruleImplies
	(
		'<=>'
		ruleImplies
	)*
;

// Rule Implies
ruleImplies:
	ruleOr
	(
		'=>'
		ruleOr
	)*
;

// Rule Or
ruleOr:
	ruleAnd
	(
		'OR'
		ruleAnd
	)*
;

// Rule And
ruleAnd:
	ruleEquality
	(
		'AND'
		ruleEquality
	)*
;

// Rule Equality
ruleEquality:
	ruleComparison
	(
		(
			'='
			    |
			'!='
		)
		ruleComparison
	)*
;

// Rule Comparison
ruleComparison:
	rulePlusOrMinus
	(
		(
			'>='
			    |
			'<='
			    |
			'>'
			    |
			'<'
		)
		rulePlusOrMinus
	)*
;

// Rule PlusOrMinus
rulePlusOrMinus:
	ruleMulOrDiv
	(
		(
			'+'
			    |
			'-'
		)
		ruleMulOrDiv
	)*
;

// Rule MulOrDiv
ruleMulOrDiv:
	rulePrimary
	(
		(
			'*'
			    |
			'/'
			    |
			'mod'
		)
		rulePrimary
	)*
;

// Rule Primary
rulePrimary:
	(
		'('
		ruleRelational
		')'
		    |
		'~'
		rulePrimary
		    |
		(
			'abs'
			    |
			'sqrt'
		)
		rulePrimary
		    |
		'instances'
		'('
		RULE_ID
		','
		RULE_INT
		')'
		    |
		'entailed'
		'('
		RULE_ID
		')'
		    |
		'selected'
		'('
		RULE_ID
		')'
		    |
		(
			'pow'
			    |
			'dist'
			    |
			'min'
			    |
			'max'
			    |
			'if'
		)
		'('
		rulePrimary
		','
		rulePrimary
		')'
		    |
		ruleAtomic
	)
;

// Rule Atomic
ruleAtomic:
	(
		(
			'true'
			    |
			'false'
		)
		    |
		RULE_ID
		    |
		ruleQualifiedName
		    |
		RULE_STRING
		    |
		RULE_INT
	)
;

// Rule QualifiedName
ruleQualifiedName:
	RULE_ID
	'.'
	RULE_ID
;

// Rule GeneralQualifiedName
ruleGeneralQualifiedName:
	RULE_ID
	(
		'.'
		RULE_ID
	)*
;

// Rule Operations
ruleOperations:
	ruleOperation
	(
		','+
		ruleOperation
	)*
;

// Rule Operation
ruleOperation:
	ruleSample
;

// Rule Sample
ruleSample:
	(
		ruleOperationName
		    |
		'validConfiguration'
		'('
		ruleListOfValuation
		')'
	)
;

// Rule OperationName
ruleOperationName:
	(
		'validModel'
		    |
		'numberOfConfigurations'
		    |
		'findConfiguration'
		    |
		'findAllConfigurations'
	)
;

// Rule ListOfValues
ruleListOfValues:
	ruleRelational
	(
		','+
		ruleRelational
	)*
;

// Rule ListOfIDs
ruleListOfIDs:
	RULE_ID
	(
		','+
		RULE_ID
	)*
;

// Rule MixedListOfIDs
ruleMixedListOfIDs:
	ruleGeneralQualifiedName
	(
		','+
		ruleGeneralQualifiedName
	)*
;

// Rule MixedList
ruleMixedList:
	RULE_ID
	(
		','+
		RULE_ID
	)*
;

// Rule Valuation
ruleValuation:
	'('
	RULE_ID
	','
	ruleRelational
	')'
;

// Rule ListOfValuation
ruleListOfValuation:
	ruleValuation
	(
		','+
		ruleValuation
	)*
;

RULE_ID : '^'? ('a'..'z'|'A'..'Z'|'_') ('a'..'z'|'A'..'Z'|'_'|'0'..'9')*;

RULE_INT : ('0'..'9')+;

RULE_STRING : ('"' ('\\' .|~(('\\'|'"')))* '"'|'\'' ('\\' .|~(('\\'|'\'')))* '\'');

RULE_ML_COMMENT : '/*' ( options {greedy=false;} : . )*'*/' {skip();};

RULE_SL_COMMENT : '//' ~(('\n'|'\r'))* ('\r'? '\n')? {skip();};

RULE_WS : (' '|'\t'|'\r'|'\n')+ {skip();};

RULE_ANY_OTHER : .;