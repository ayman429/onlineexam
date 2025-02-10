class AuthError {
  static const String invalidEmailEn =
      "[firebase_auth/invalid-email] The email address is badly formatted.";
  static const String invalidEmailAr = "البريد الالكتروني غير صحيح";
  static const String weakPasswordEn =
      "[firebase_auth/weak-password] Password should be at least 6 characters";
  static const String weakPasswordAr =
      "يجب أن تكون كلمة المرور مكونة من 6 أحرف على الأقل";
  static const String emailAlreadyInUseEn =
      "[firebase_auth/email-already-in-use] The email address is already in use by another account.";
  static const String emailAlreadyInUseAr = "الاميل مستخدم من قبل";
  static const String emailInvalidCredentialEn =
      "[firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.";
  static const String emailInvalidCredentialAr =
      "لم يتم العثور على مستخدم لهذا البريد الإلكتروني او كلمة المرور غير صحيحة";
  static const String connectionErrorEn =
      "[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
  static const String connectionErrorAR = "غير متصل بالانترنت";
  static String authErrorFunc(String error) {
    print("xxxxxxxxxxxxxxx==>$error");
    switch (error) {
      case invalidEmailEn:
        return invalidEmailAr;
      case weakPasswordEn:
        return weakPasswordAr;
      case emailAlreadyInUseEn:
        return emailAlreadyInUseAr;
      case emailInvalidCredentialEn:
        return emailInvalidCredentialAr;
      case connectionErrorEn:
        return connectionErrorAR;
      default:
        return "حدث خطأ ما حاول مرة أخرى";
    }
  }
}
