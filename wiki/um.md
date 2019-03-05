# Generate a GPG Key
gpg --full-generate-key
gpg --list-secret-keys --keyid-format LONG
gpg --armor --export [KEY]

# List GPG Keys
gpg --list-secret-keys --keyid-format LONG
