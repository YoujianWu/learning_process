```
首先按照队内文档配再save actions
```

> 然后在src下要配置对应的.clang-format和.clang-tidy，即可生效

```
# The ANYbotics style guide is based on google: https://anybotics.github.io/styleguide/cppguide.html
BasedOnStyle: Google
# Maximum line with is 140 characters (default: 80)
ColumnLimit: 140
# Indent of two spaces, no tabs.
IndentWidth: 2
# Always attach braces to surrounding context.
BreakBeforeBraces: Attach
# Force pointer alignment with the type (left).
DerivePointerAlignment: false
PointerAlignment: Left
# Only merge functions defined inside a class.
AllowShortFunctionsOnASingleLine: Inline
# Sort each include block separately.
IncludeBlocks: Preserve
```

```
---
Checks: '
boost-use-to-string,
bugprone-argument-comment,
bugprone-assert-side-effect,
bugprone-bad-signal-to-kill-thread,
bugprone-bool-pointer-implicit-conversion,
bugprone-branch-clone,
bugprone-copy-constructor-init,
bugprone-dangling-handle,
bugprone-dynamic-static-initializers,
bugprone-exception-escape,
bugprone-fold-init-type,
bugprone-forward-declaration-namespace,
bugprone-forwarding-reference-overload,
bugprone-inaccurate-erase,
bugprone-incorrect-roundings,
bugprone-infinite-loop,
bugprone-integer-division,
bugprone-lambda-function-name,
bugprone-macro-parentheses,
bugprone-macro-repeated-side-effects,
bugprone-misplaced-operator-in-strlen-in-alloc,
bugprone-misplaced-widening-cast,
bugprone-move-forwarding-reference,
bugprone-multiple-statement-macro,
bugprone-not-null-terminated-result,
bugprone-parent-virtual-call,
bugprone-posix-return,
bugprone-signed-char-misuse,
bugprone-sizeof-container,
bugprone-sizeof-expression,
bugprone-string-constructor,
bugprone-string-integer-assignment,
bugprone-string-literal-with-embedded-nul,
bugprone-suspicious-enum-usage,
bugprone-suspicious-memset-usage,
bugprone-suspicious-missing-comma,
bugprone-suspicious-semicolon,
bugprone-suspicious-string-compare,
bugprone-swapped-arguments,
bugprone-terminating-continue,
bugprone-throw-keyword-missing,
bugprone-too-small-loop-variable,
bugprone-undefined-memory-manipulation,
bugprone-undelegated-constructor,
bugprone-unhandled-self-assignment,
bugprone-unused-raii,
bugprone-unused-return-value,
bugprone-use-after-move,
cppcoreguidelines-avoid-goto,
cppcoreguidelines-init-variables,
cppcoreguidelines-interfaces-global-init,
cppcoreguidelines-narrowing-conversions,
cppcoreguidelines-no-malloc,
cppcoreguidelines-pro-bounds-pointer-arithmetic,
cppcoreguidelines-pro-type-const-cast,
cppcoreguidelines-pro-type-cstyle-cast,
cppcoreguidelines-pro-type-member-init,
cppcoreguidelines-pro-type-static-cast-downcast,
cppcoreguidelines-pro-type-union-access,
cppcoreguidelines-slicing,
cppcoreguidelines-special-member-functions,
google-build-explicit-make-pair,
google-build-namespaces,
google-build-using-namespace,
google-default-arguments,
google-explicit-constructor,
google-global-names-in-headers,
google-readability-avoid-underscore-in-googletest-name,
google-readability-namespace-comments,
google-readability-todo,
google-runtime-operator,
google-upgrade-googletest-case,
misc-definitions-in-headers,
misc-redundant-expression,
misc-static-assert,
misc-unconventional-assign-operator,
misc-uniqueptr-reset-release,
misc-unused-parameters,
misc-unused-using-decls,
modernize-avoid-bind,
modernize-avoid-c-arrays,
modernize-deprecated-ios-base-aliases,
modernize-deprecated-headers,
modernize-loop-convert,
modernize-make-shared,
modernize-make-unique,
modernize-pass-by-value,
modernize-raw-string-literal,
modernize-redundant-void-arg,
modernize-replace-auto-ptr,
modernize-shrink-to-fit,
modernize-use-auto,
modernize-use-bool-literals,
modernize-use-emplace,
modernize-use-equals-default,
modernize-use-equals-delete,
modernize-use-noexcept,
modernize-use-nullptr,
modernize-use-override,
modernize-use-transparent-functors,
modernize-use-using,
readability-avoid-const-params-in-decls,
readability-braces-around-statements,
readability-const-return-type,
readability-container-size-empty,
readability-convert-member-functions-to-static,
readability-delete-null-pointer,
readability-deleted-default,
readability-identifier-naming,
readability-implicit-bool-conversion,
readability-inconsistent-declaration-parameter-name,
readability-make-member-function-const,
readability-misleading-indentation,
readability-misplaced-array-index,
readability-named-parameter,
readability-non-const-parameter,
readability-qualified-auto,
readability-redundant-control-flow,
readability-redundant-declaration,
readability-redundant-function-ptr-dereference,
readability-redundant-preprocessor,
readability-redundant-smartptr-get,
readability-redundant-string-cstr,
readability-redundant-string-init,
readability-simplify-boolean-expr,
readability-simplify-subscript-expr,
readability-static-accessed-through-instance,
readability-static-definition-in-anonymous-namespace,
readability-string-compare,
readability-uniqueptr-delete-release
'

# Add all checks that should be treated as errors.
# WarningsAsErrors: ''

# Option for the checks.
CheckOptions:
  - key: cppcoreguidelines-init-variables.IncludeStyle
    value: google
  - key: misc-non-private-member-variables-in-classes.IgnoreClassesWithAllMemberVariablesBeingPublic
    value: 1
  - key: readability-identifier-naming.ClassCase
    value: CamelCase
  - key: readability-identifier-naming.EnumCase
    value: CamelCase
  - key: readability-identifier-naming.FunctionCase
    value: camelBack
  - key: readability-identifier-naming.MemberCase
    value: camelBack
  - key: readability-identifier-naming.ProtectedMemberSuffix
    value: _
  - key: readability-identifier-naming.PrivateMemberSuffix
    value: _
  - key: readability-identifier-naming.MethodCase
    value: camelBack
  - key: readability-identifier-naming.NamespaceCase
    value: lower_case
  - key: readability-identifier-naming.StructCase
    value: aNy_CasE
  #  - key: readability-identifier-naming.MemberSuffix
  #    value: _
  - key: cppcoreguidelines-narrowing-conversions.WarnOnIntegerNarrowingConversion
    value: 0
#  - key: cppcoreguidelines-narrowing-conversions.IgnoreConversionFromTypes
#    value: size_t
```

