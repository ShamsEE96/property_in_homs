abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthRefreshUIState extends AuthStates {}

class AuthSuccessState extends AuthStates {}

class AuthErrorState extends AuthStates {}
