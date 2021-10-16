import 'package:normalize/utils.dart';
import 'package:gql/ast.dart';
// ignore: implementation_imports
import 'package:gql/src/language/parser.dart';

class AddNestedTypenameVisitor extends AddTypenameVisitor {
  @override
  visitOperationDefinitionNode(node) => node;
}

DocumentNode gql(String document) => transform(
      parseString(document),
      [AddNestedTypenameVisitor()],
    );
