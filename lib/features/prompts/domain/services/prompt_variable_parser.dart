class PromptVariableParser {
  const PromptVariableParser();

  static final RegExp _variablePattern = RegExp(
    r'\[([A-Za-z0-9_ÇĞİÖŞÜçğıöşü]+)\]',
  );

  List<String> parse(String promptText) {
    final variables = <String>[];
    final seenVariables = <String>{};

    for (final match in _variablePattern.allMatches(promptText)) {
      final variableName = match.group(1);

      if (variableName == null) {
        continue;
      }

      if (seenVariables.add(variableName)) {
        variables.add(variableName);
      }
    }

    return variables;
  }
}
