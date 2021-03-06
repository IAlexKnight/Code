struct CRB_Interpreter_tag {
    MEM_Storage		interpreter_storage;
    MEM_Storage		execute_storage;
    Variable		*variable;
    FunctionDefinition	*function_list;
    StatementList	*statement_list;
    int			current_line_number;
};


typedef struct Variable_tag {
    char    *name;
    CRB_Value	value;
    struct Variable_tag *next;
} Variable;

typedef enum {
    CROWBAR_FUNTION_DEFINITION = 1,
    NATIVE_FUNCTION_DEFINITION
} FunctionDefinitionType;

typedef struct FunctionDefinition_tag {
    char     *name;
    FunctionDefinitionType  type;
    union {
	struct {
	    ParameterList   *parameter;
	    Block	    *block;
	} crowbar_f;
	struct {
	    CRB_NativeFunctionProc  *proc;
	} native_f;
    } u;
    struct FunctionDefinition_tag   *next;
} FunctionDefinition;

typedef struct ParameterList_tag {
    char    *name;
    struct ParameterList_tag *next;
} ParameterList;

typedef struct {
    StatementList   *statement_list;
} Block;


















