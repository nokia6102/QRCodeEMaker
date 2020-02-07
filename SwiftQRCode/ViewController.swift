//
//  ViewController.swift
//  SwiftQRCode
//
//  Created by mac on 2020/2/7.
//  Copyright © 2020 comcom.firebaseChat0205. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{

    
    @IBOutlet weak var imageQRCODE: UIImageView!
    @IBOutlet weak var txtInputCode: UITextField!
    var QRstring = "123456789"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        txtInputCode.delegate = self

    }

    @IBAction func tapMakeIt(_ sender: UIButton) {
        imageQRCODE.image = generateQRCode(from: txtInputCode.text ?? "", imageView: imageQRCODE)
       
         txtInputCode.resignFirstResponder()
        
    }
    
}




func generateQRCode(from string: String, imageView: UIImageView) -> UIImage? {
    let data = string.data(using: String.Encoding.ascii)
    
    if let filter = CIFilter(name: "CIQRCodeGenerator") {
        filter.setValue(data, forKey: "inputMessage")
        // L: 7%, M: 15%, Q: 25%, H: 30%
        filter.setValue("M", forKey: "inputCorrectionLevel")
        
        if let qrImage = filter.outputImage {
            let scaleX = imageView.frame.size.width / qrImage.extent.size.width
            let scaleY = imageView.frame.size.height / qrImage.extent.size.height
            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            let output = qrImage.transformed(by: transform)
            return UIImage(ciImage: output)
        }
    }
    
    return nil
}
