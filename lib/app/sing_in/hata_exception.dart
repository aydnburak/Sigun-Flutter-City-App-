class Hatalar {
  static String goster(String hataKodu) {
    switch (hataKodu) {
      case 'email-already-in-use':
        return "Bu mail adresi zaten kullanımda, lütfen farklı bir mail kullanınız";

      case 'user-not-found':
        return "Bu kullanıcı sistemde bulunmamaktadır. Lütfen önce kullanıcı oluşturunuz";

      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return "Facebook hesabınızdaki mail adresi daha önce gmail veya email yöntemi ile sisteme kaydedilmiştir. Lütfen bu mail adresi ile giriş yapın";

      default:
        return "Bir hata olustu";
    }
  }
}