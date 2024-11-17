String formatPhoneNumber(String phoneNumber) {
  phoneNumber = phoneNumber.replaceAll(" ", "");
  if (phoneNumber.length >= 8) {
    return '${phoneNumber.substring(0, 4)} ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
  }
  return phoneNumber; // Return unformatted if length is not 10
}
