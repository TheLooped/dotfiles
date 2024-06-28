; ADT definitions

(struct_declaration
    name: (type_identifier) @name) @definition.class

(enum_declaration
    name: (type_identifier) @name) @definition.class

; type aliases

(type_alias
    name: (type_identifier) @name) @definition.class

; method definitions

(declaration_list
    (function_declaration
        name: (identifier) @name)) @definition.method

; function definitions

(function_declaration
    name: (identifier) @name) @definition.function

; trait definitions
(trait_declaration
    name: (type_identifier) @name) @definition.interface

; references

(call_expression
    function: (identifier) @name) @reference.call

(call_expression
    function: (field_expression
        field: (field_identifier) @name)) @reference.call

; implementations

(impl_declaration
    trait: (type_identifier) @name) @reference.implementation
