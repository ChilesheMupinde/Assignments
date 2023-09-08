class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = "an unkown error occured"]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'User-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'This User has been Disabled');

      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
