class PasswordCheckEntity {
  final bool upperText;
  final bool lowerText;
  final bool number;
  final bool char;
  final bool length;

  const PasswordCheckEntity({
    this.upperText = false,
    this.lowerText = false,
    this.number = false,
    this.char = false,
    this.length = false,
  });

  PasswordCheckEntity copyWith({
    bool? upperText,
    bool? lowerText,
    bool? number,
    bool? char,
    bool? length,
  }) =>
      PasswordCheckEntity(
        upperText: upperText ?? this.upperText,
        lowerText: lowerText ?? this.lowerText,
        number: number ?? this.number,
        char: char ?? this.char,
        length: length ?? this.length,
      );
}
