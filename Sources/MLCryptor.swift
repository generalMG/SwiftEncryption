import Foundation
import CryptoKit
// RNCryptor is not used here. Due to the package version mismatch, I dropped the RNCryptor support.
@available(macOS 10.15, *) // Required to run the code. Raises issue when removed.
public enum MLCryptor {
    case cryptoKit

    public func encrypt(data: Data, withPassword password: String) throws -> Data? {
        switch self {
        case .cryptoKit:
            let encryptionKey = SymmetricKey(string: password)
            return try encryptByCryptoKit(data, withKey: encryptionKey)
        }
    }

    public func decrypt(data: Data, withPassword password: String) throws -> Data? {
        switch self {
        case .cryptoKit:
            let decryptionKey = SymmetricKey(string: password)
            return try decryptByCryptoKit(data, withKey: decryptionKey)
        }
    }

    private func encryptByCryptoKit(_ data: Data, withKey key: SymmetricKey) throws -> Data? {
        let sealedBox = try AES.GCM.seal(data, using: key)
        return sealedBox.combined
    }

    private func decryptByCryptoKit(_ data: Data, withKey key: SymmetricKey) throws -> Data? {
        let sealedBox = try AES.GCM.SealedBox(combined: data)
        return try AES.GCM.open(sealedBox, using: key)
    }
}

@available(macOS 10.15, *)
extension SymmetricKey {
    init(string keyString: String) {
        let keyData = SHA256.hash(data: keyString.data(using: .utf8)!)
        self.init(data: keyData)
    }
}
