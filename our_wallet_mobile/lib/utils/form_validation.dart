String? validationString(String? value) {
  if (value!.length == 0) {
    return "Field tidak boleh kosong";
  }
  return null;
}

String? validationPhoneNumber(String? value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value!.length == 0) {
    return "Nomor Telpon harus diisi";
  } else if (value.length < 10) {
    return "Nomor Telpon minimal 10 digit";
  } else if (!regExp.hasMatch(value)) {
    return "Nomor Telpon harus angka";
  }
  return null;
}

String? validationPassword(String? value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  if (value!.length == 0) {
    return "Password harus diisi";
  } else if (!regExp.hasMatch(value)) {
    return "Minimal password 9 karakter dan harus memiliki minimal 1 huruf kecil, 1 huruf besar,1 angka dan 1 spesial character ( ! @ # \$ & * ~ ) ";
  }
  return null;
}

String? validationEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value!.length == 0) {
    return "Email harus diisi";
  } else if (!regExp.hasMatch(value)) {
    return "Email tidak valid";
  } else {
    return null;
  }
}

String? validationNumber(String? value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value!.length == 0) {
    return "Field ini harus diisi";
  } else if (!regExp.hasMatch(value)) {
    return "Field ini harus angka";
  }
  return null;
}
