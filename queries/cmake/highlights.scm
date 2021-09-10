[
 (quoted_argument)
 (bracket_argument)
] @string

(variable_ref) @none
(variable) @variable

[
 (bracket_comment)
 (line_comment)
] @comment

(normal_command (identifier) @function)

["ENV" "CACHE"] @symbol
["$" "{" "}" "<" ">"] @punctuation.special
["(" ")"] @punctuation.bracket

[
 (function)
 (endfunction)
 (macro)
 (endmacro)
] @keyword.function

[
 (if)
 (elseif)
 (else)
 (endif)
] @conditional

[
 (foreach)
 (endforeach)
 (while)
 (endwhile)
] @repeat

(function_command
  (function)
  . (argument) @function
  (argument)* @parameter
)

(macro_command
  (macro)
  . (argument) @function.macro
  (argument)* @parameter
)

(normal_command
 (identifier) @function.builtin
 . (argument) @variable
 (#match? @function.builtin "\\c^(set)$"))

(normal_command
 (identifier) @function.builtin
 . (argument)
 . (argument)
 (argument) @constant
 (#any-of? @constant "PARENT_SCOPE" "CACHE" "FORCE")
 (#match? @function.builtin "\\c^(set)$")
)

(if_command
  (if)
  (argument) @keyword.operator
  (#any-of? @keyword.operator "NOT" "AND" "OR"
                              "COMMAND" "POLICY" "TARGET" "TEST" "DEFINED" "IN_LIST"
                              "EXISTS" "IS_NEWER_THAN" "IS_DIRECTORY" "IS_SYMLINK" "IS_ABSOLUTE"
                              "MATCHES"
                              "LESS" "GREATER" "EQUAL" "LESS_EQUAL" "GREATER_EQUAL"
                              "STRLESS" "STRGREATER" "STREQUAL" "STRLESS_EQUAL" "STRGREATER_EQUAL"
                              "VERSION_LESS" "VERSION_GREATER" "VERSION_EQUAL" "VERSION_LESS_EQUAL" "VERSION_GREATER_EQUAL"
  )
)
