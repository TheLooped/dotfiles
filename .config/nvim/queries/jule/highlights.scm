; Identifiers
(identifier) @variable
(type_identifier) @type
(primitive_type) @type.builtin
(field_identifier) @property


((identifier) @constructor
 (#match? @constructor "^[A-Z]"))

(struct_declaration (type_identifier) @constructor)

; Function calls

(call_expression
  function: (identifier) @function)
(call_expression
  function: (field_expression
    field: (field_identifier) @function.method))

; Function definitions

(function_declaration (identifier) @function)


(line_comment) @comment
(block_comment) @comment

;; Delimeters

"(" @punctuation.bracket
")" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket

"::" @punctuation.delimiter
":" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter
";" @punctuation.delimiter

(parameter (identifier) @variable.parameter)

;; Keywords

[
  "break"
  "const"
  "cpp"
  "continue"
  "defer"
  "enum"
  "else"
  "false"
  ;;"fall"
  "for"
  "let"
  "match"
  "if"
  "impl"
  "ret"
  "struct"
  "trait"
  "true"
  "use"
] @keyword

"fn" @keyword.function

[
   "break"
   "continue"
   "else"
   "if"
   "match"
] @conditional

[
  "for"
] @repeat

(mutability_modifier) @keyword
(use_list (self) @keyword)

(self) @variable.builtin

(char_literal) @string
(string_literal) @string
(raw_string_literal) @string

(bool_literal) @constant.builtin
(integer_literal) @constant.builtin
(float_literal) @constant.builtin

(escape_sequence) @escape

"*" @operator
"&" @operator
