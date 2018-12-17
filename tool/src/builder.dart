import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:code_builder/code_builder.dart';
import 'package:dart_style/dart_style.dart';
import 'package:hyper/src/dom_elements.dart';

final _dartfmt = DartFormatter();

// Creates a `<a>` element.
// Element a({Map<String, Object> attrs, List<Element> children}) =>
//     Element("a", attrs: attrs, children: children);

class HyperElementGenerator extends Generator {
  @override
  String generate(LibraryReader library, _) {
    final methods = domElements.map((tag) {
      final parameters = [
        Parameter((b) => b
          ..type = TypeReference((b) => b
            ..symbol = 'Map'
            ..types.addAll([
              refer('String'),
              refer('String'),
            ]))
          ..name = 'attrs'
          ..named = true),
      ];
      final arguments = {'attrs': refer('attrs')};

      if (!voidElements.contains(tag)) {
        parameters.add(Parameter((b) => b
          ..type = TypeReference((b) => b
            ..symbol = 'List'
            ..types.addAll([
              refer('Element', 'package:hyper/hyper.dart'),
            ]))
          ..name = 'children'
          ..named = true));
        arguments['children'] = refer('children');
      }

      return Method((b) => b
        ..docs.addAll(
          ['/// Create a `<$tag>` element.'],
        )
        ..returns = refer('Element', 'package:hyper/hyper.dart')
        ..name = tag == 'var' ? 'var_' : tag // var is a reserved word
        ..optionalParameters.addAll(parameters)
        ..lambda = true
        ..body = refer('Element', 'package:hyper/hyper.dart').call(
          [literal(tag)],
          arguments,
        ).statement);
    });
    return _dartfmt
        .format(methods.map((m) => m.accept(DartEmitter())).join('\n'));
  }
}

Builder hyperElementBuilder(BuilderOptions _) {
  return SharedPartBuilder([
    HyperElementGenerator(),
  ], 'hyper');
}
