//
//  RASExample.swift
//  EncryptionDemos
//
//  Created by Deepak P. Patil on 27/06/18.
//  Copyright © 2018 Deepak P. Patil. All rights reserved.
//

import Foundation
enum AloError:Error{
    case AlorithmNotSupported
}

class RASExample {
    var publicKey:SecKey? = nil
    var privateKey:SecKey? = nil
    let alhorithm:SecKeyAlgorithm = .rsaEncryptionOAEPSHA512
    func createPublicAndPrivateKeys() throws {
        let secAttribute : [String:Any] = [
            kSecAttrKeyType as String : kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String : 2048,
            kSecPrivateKeyAttrs as String :[
                kSecAttrIsPermanent : true,
                kSecAttrApplicationTag as String : "com.deepak.com.keys.mykey"
                ]
        ]
        
        var error:Unmanaged<CFError>?
        
     
        guard let privateKey = SecKeyCreateRandomKey(secAttribute as CFDictionary,&error) else {
            throw error!.takeRetainedValue() as Error
        }
        
        self.publicKey = SecKeyCopyPublicKey(privateKey)
        self.privateKey = privateKey
    }
    
    
    func encryptData(plainText:String)throws -> String {

        // check is algrothm Suported
     
        guard SecKeyIsAlgorithmSupported(publicKey!, .encrypt, alhorithm)  else {
            throw AloError.AlorithmNotSupported
        }
        
        let plainData = plainText.data(using:String.Encoding.utf8)
        
        var encryptError: Unmanaged<CFError>?
        guard let ciperText = SecKeyCreateEncryptedData(publicKey!,alhorithm,plainData! as CFData,&encryptError) else {
            throw encryptError!.takeRetainedValue() as Error
        }

        return (ciperText as Data).base64EncodedString()
    }
    
    
    func decryptData(ciperText:String)throws -> String{
        let cipherData = Data(base64Encoded: ciperText)
        
        var decryptError: Unmanaged<CFError>?
        guard let plainText = SecKeyCreateDecryptedData(privateKey!,alhorithm,cipherData! as CFData,&decryptError) else {
            throw decryptError!.takeRetainedValue() as Error
        }
        
        return String(data: plainText as Data, encoding:String.Encoding.ascii)!
        
    }
}
