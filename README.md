# SwiftEncryptor

SwiftEncryptor is a Swift-based command-line tool for encrypting files using the CryptoKit framework.

## Features

	•	Encrypt files with a specified password
	•	Decrypt files with the corresponding password
	•	Command-line interface for easy integration into workflows

## Requirements

	•	macOS 10.15 or later
	•	Swift 5.10 or later

## Installation

1. Clone the repository:

```
git clone https://github.com/generalMG/SwiftEncryptor.git
cd SwiftEncryptor
```

2. Build the project using Swift Package Manager:

```
swift build
```

## Usage

### Encrypting a File

To encrypt a file, use the following command:

```
swift run Encryptor <file_path> <password>
```

### Example

Encrypting a file named example.txt with the password mySecret:

```
swift run Encryptor example.txt mySecret
```

## Project Structure

- Package.swift: Defines the Swift package and its dependencies.
- Sources/: Contains the source code for the project.
  - main.swift: The entry point of the command-line tool.
  - MLCryptor.swift: Contains the encryption and decryption logic using CryptoKit.
  - MLEncoderTool.swift: Defines the command-line interface and integrates with MLCryptor.
