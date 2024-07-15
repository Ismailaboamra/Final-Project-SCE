class Mentor {
  String userName;
  String email;
  Mentor(this.email, this.userName);
  String getDetails() {
    return 'Email: $email, Username: $userName';
  }

  @override
  String toString() {
    return 'Mentor(email: $email, username: $userName,)';
  }
}
