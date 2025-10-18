

String fromErrorCode(int errorCode){
  switch (errorCode){
    case 400001:
      return "Email já cadastrado. Código: $errorCode'";
    case 403001:
      return "Você não tem os privilégios necessários para realizar essa operação. Código: $errorCode'";
    default:
      return 'Ocorreu um erro inesperado. Código: $errorCode';
  }
}
