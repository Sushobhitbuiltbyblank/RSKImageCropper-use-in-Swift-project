//
//  ViewController.swift
//  RSkImageSwift
//
//  Created by Sushobhit_BuiltByBlank on 5/31/17.
//  Copyright © 2017 builtbyblank. All rights reserved.
//

import UIKit
import RSKImageCropper
import MobileCoreServices

class ViewController: UIViewController,RSKImageCropViewControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var selectImageBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker:UIImagePickerController!
    var image: UIImage!
    var captureMediaActionSheet : UIAlertController!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActionSheet()
        imageView.layer.cornerRadius = imageView.bounds.height/2
        imageView.layer.masksToBounds = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func selectImageAction(_ sender: UIButton) {
        self.present(captureMediaActionSheet, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imagePicker.dismiss(animated: false, completion: {})
        let imageCropVC = RSKImageCropViewController.init(image: self.image, cropMode: RSKImageCropMode.circle)
        imageCropVC.delegate = self;
        self.present(imageCropVC, animated: true, completion: nil)
    }

    func setUpActionSheet() {
        captureMediaActionSheet = UIAlertController(title: "Choose Media", message: "", preferredStyle: .actionSheet)
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
        }
        captureMediaActionSheet.addAction(cancelAction)
        let cameraAction: UIAlertAction = UIAlertAction(title: "Capture from Camera", style: .default) { action -> Void in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            self.imagePicker.allowsEditing = false
            self.imagePicker.mediaTypes = [kUTTypeImage as String]
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        captureMediaActionSheet.addAction(cameraAction)
        let galleryAction: UIAlertAction = UIAlertAction(title: "Select from Gallery", style: .default) { action -> Void in
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            self.imagePicker.allowsEditing = false
            self.imagePicker.mediaTypes = [kUTTypeImage as String]
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        captureMediaActionSheet.addAction(galleryAction)
    }
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect, rotationAngle: CGFloat) {
        imageView.image = croppedImage
        dismiss(animated: true, completion: nil)
    }
    @IBAction func retryAction(_ sender: Any) {
        let imageCropVC = RSKImageCropViewController.init(image: self.image, cropMode: RSKImageCropMode.circle)
        imageCropVC.delegate = self;
        self.present(imageCropVC, animated: true, completion: nil)
    }
}

