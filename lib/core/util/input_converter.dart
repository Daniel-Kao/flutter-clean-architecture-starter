import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../error/failures.dart';

@Injectable()
class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      final integer = int.parse(str);
      if (integer < 0) throw FormatException();
      return Right(integer);
    } on FormatException {
      return Left(InvalidInputFailre());
    }
  }
}
