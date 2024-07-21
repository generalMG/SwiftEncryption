import Foundation

@available(macOS 10.15, *)
public struct MLEncoderTool {
    // The first argument is the file name
    // The second argument is key
    private let arguments: [String]
    
    private let cryptor: MLCryptor
    
    public init(
        arguments: [String] = CommandLine.arguments,
        cryptor: MLCryptor = MLCryptor.cryptoKit
    ) {
        self.arguments = arguments
        self.cryptor = cryptor
    }
    
    public func run() throws {
        if arguments.count == 1 {
            throw Error.missingAllArguments
        }
        
        if arguments.count == 2 {
            throw Error.missingKey
        }
        
        try encryptFile()
    }
    
    func encryptFile() throws {
        let fileName = arguments[1]
        let key = arguments[2]
        
        let fullPath = fileName.starts(with: "/") ? fileName : FileManager.default.currentDirectoryPath + "/" + fileName
        
        print("Full path to the file:", fullPath)
        
        guard FileManager.default.fileExists(atPath: fullPath) else {
            print("File does not exist at path:", fullPath)
            throw Error.noFile
        }
        
        guard let data = FileManager.default.contents(atPath: fullPath) else { // debugging
            throw Error.noFile
        }
        print("File read successfully. Data size: \(data.count) bytes")
        do {
            print("Starting encryption process...")
            guard let encryptedData = try cryptor.encrypt(data: data, withPassword: key) else {
                throw Error.undefinedError
            }
            print("Encryption completed successfully.")
            
            let destinationPath = fullPath + ".enc"
            let destinationURL = URL(fileURLWithPath: destinationPath)
            
            try encryptedData.write(to: destinationURL)
            
            print("The file was encrypted successfully.")
        } catch {
            print("Encryption failed: \(error)")
            throw error
        }
    }

    
    func decryptFile() throws {
        let fileName = arguments[1]
        let key = arguments[2]
        
        let currentPath = FileManager.default.currentDirectoryPath
        let fullPath = currentPath + "/" + fileName
        
        guard let data = FileManager.default.contents(atPath: fullPath) else {
            throw Error.noFile
        }
        
        guard let encryptedData = try cryptor.decrypt(data: data, withPassword: key) else {
            throw Error.undefinedError
        }
        
        let destinationPath = currentPath + "/" + (fileName as NSString).deletingPathExtension
        let destinationURL = URL(fileURLWithPath: destinationPath)
        
        try encryptedData.write(to: destinationURL)
        
        print("The file was decrypted successfully.")
    }
}

@available(macOS 10.15, *)
public extension MLEncoderTool {
    enum Error: Swift.Error {
        case missingAllArguments
        case missingKey
        case noFile
        case undefinedError
    }
}




