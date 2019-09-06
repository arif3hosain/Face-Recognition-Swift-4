//
//  ViewController.swift
//  FaceRecognition
//
//  Created by Arif Hosain on 5/9/19.
//  Copyright © 2019 mas. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var smile: UILabel!
    
    @IBAction func `import`(_ sender: Any) {
        
        //create image picker to be displayed to select a particular image
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
    
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            myImageView.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        faceInfo();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func faceInfo () {
        let ciImage = CIImage(image: myImageView.image!)
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: ciImage!, options: [CIDetectorSmile:true])
      
        for face in faces as! [CIFaceFeature] {
            if face.hasSmile {
                smile.text = "Yes, this is smiling face"
            }else {
                smile.text = "This is not smiling face"
            }
        }
        
        
    }


}

