bool isValidEmail(String email) {
  final regex = RegExp(r'^[\w\-.]+@lus\.ac\.bd$');
  return regex.hasMatch(email.trim());
}


bool isValidPassword(String password) {
  // min 6 chars, at least 1 letter & number
  final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
  return regex.hasMatch(password);
}

bool isValidTitle(String title) {
  return title.trim().length >= 3;
}

bool isValidPriceText(String priceText) {
  final regex = RegExp(r'^\d+(\.\d{1,2})?$');
  return regex.hasMatch(priceText.trim());
}

bool isValidUrl(String url) {
  if (url.trim().isEmpty) return false;
  final regex = RegExp(r'^(https?:\/\/)[\w\-]+(\.[\w\-]+)+([\/?#].*)?$');
  return regex.hasMatch(url.trim());
}
