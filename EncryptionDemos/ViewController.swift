//
//  ViewController.swift
//  EncryptionDemos
//
//  Created by Deepak P. Patil on 27/06/18.
//  Copyright © 2018 Deepak P. Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var rasExampleObj:RASExample = RASExample()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        testRSAExample()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testRSAExample() {
        self.createRSAKeys()
        let plainText = "My Name is Deepak Patil"
        let encryptedText = self.encryptStringWithRSA(plainText: plainText)
        print(encryptedText)
        
        print("Deceypri Data \n")
        
        self.decryptString(ciperString: encryptedText)
        
    }
    func createRSAKeys() {
        do {
            try  rasExampleObj.createPublicAndPrivateKeys()
//            print("Private Key :: ",String(describing: rasExampleObj.privateKey))
//            print("Public Key :: ",String(describing: rasExampleObj.publicKey))
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    }
    
    func encryptStringWithRSA(plainText:String) -> String{
        var encryptedData:String? = nil
        do {
          encryptedData = try rasExampleObj.encryptData(plainText: plainText)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return encryptedData!
    }
    
    func decryptString(ciperString:String){
        var plainStr:String? = nil
        do {
            plainStr = try rasExampleObj.decryptData(ciperText:ciperString)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        print(plainStr)
        
    }
}

