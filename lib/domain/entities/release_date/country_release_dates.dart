import 'package:equatable/equatable.dart';
import 'package:next_movie/domain/entities/release_date/release_date.dart';
import 'package:meta/meta.dart';

abstract class CountryReleaseDates extends Equatable {
  final String countryCode;
  final List<ReleaseDate> releaseDates;

  const CountryReleaseDates({
    @required this.countryCode,
    this.releaseDates,
  }) : assert(countryCode != null);

  String get getCountryEmoji {
    const flagOffset = 0x1F1E6;
    const asciiOffset = 0x41;

    final firstChar = countryCode.codeUnitAt(0) - asciiOffset + flagOffset;
    final secondChar = countryCode.codeUnitAt(1) - asciiOffset + flagOffset;

    final flag = String.fromCharCode(firstChar) + String.fromCharCode(secondChar);

    return flag;
  }

  @override
  List<Object> get props => [
        countryCode,
        releaseDates,
      ];
}
