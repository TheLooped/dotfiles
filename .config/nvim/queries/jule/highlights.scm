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

;;"::" @punctuation.delimiter
":" @punctuation.delimiter
"." @punctuation.delimiter
"," @punctuation.delimiter
";" @punctuation.delimiter

(parameter (identifier) @variable.parameter)

;; Keywords

[
  "break"
  "const"
  ;;"cpp"
  "continue"
  ;;"defer"
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
  ;; "use"
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

(mutable_flag) @keyword
;;(use_list (self) @keyword)

(self) @variable.builtin

(char) @string
(string) @string
(raw_string) @string

(bool) @constant.builtin
(integer) @constant.builtin
(float) @constant.builtin

(escape_sequence) @escape

"*" @operator
"&" @operator
