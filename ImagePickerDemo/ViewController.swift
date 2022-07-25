//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Shein on 26/07/2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        picker.allowsEditing = false
        picker.delegate = self
    }
    
    @IBAction func btnSelectTouchUpInside(_ sender: Any) {
        present(picker, animated: true)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let qrcodeImg = info[.originalImage] as? UIImage {
            imgView.image = qrcodeImg
            readQr(fromImage: qrcodeImg)
        } else{
            lbl.text = "#Something wrong"
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func readQr(fromImage: UIImage) {
        let detector: CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        
        let ciImage: CIImage = CIImage(image:fromImage)!
        var qrCodeText = ""

        let features=detector.features(in: ciImage)
        for feature in features as! [CIQRCodeFeature] {
            qrCodeText += feature.messageString!
        }
        
        lbl.text = qrCodeText.isEmpty ? "#No data found." : qrCodeText
    }
}

