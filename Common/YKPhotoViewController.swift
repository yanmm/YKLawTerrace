//
//  YKPhotoViewController.swift
//  YKProject
//
//  Created by Yuki on 16/9/6.
//  Copyright © 2016年 Yuki. All rights reserved.
//

import UIKit

class YKPhotoViewController: YKBaseViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var imagePicker: UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imagePicker = UIImagePickerController()
        imagePicker.view.backgroundColor = UIColor.white
        imagePicker.navigationBar.barTintColor = UIColor(hex6: kBackgroundColor, alpha: 0.95)
        imagePicker.navigationBar.tintColor = UIColor.white
        imagePicker.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        //UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        imagePicker.navigationBar.isTranslucent = false
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        self.imagePicker = imagePicker
    }
    
    func showSheetView() {
        let view = YKAlertView.initView(NSLocalizedString("title.PhotoVC.SelectOperation", comment: ""), message: nil, style: YKAlertViewStyle.actionSheet)
        view.addButton(NSLocalizedString("title.PhotoVC.PhotoAlbum", comment: ""), style: YKButtonStyle.normal, color: YKButtonColor.normal) {
            self.presentPhotoLibrary()
        }
        view.addButton(NSLocalizedString("title.PhotoVC.TakingPictures", comment: ""), style: YKButtonStyle.normal, color: YKButtonColor.normal) {
            self.presentCamera()
        }
        view.addButton(NSLocalizedString("alert.cancel", comment: ""), style: YKButtonStyle.cancel, color: YKButtonColor.normal, handler: nil)
        view.showView()
    }
    
    func presentPhotoLibrary() {
        // 检测设备是否支持图库
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
        } else if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum) {
            // 检测设备是否支持照片库
            imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary
        } else {
            showAlert(msg: NSLocalizedString("title.PhotoVC.DeviceDoesNotSupport", comment: ""))
            return;
        }
        
        if imagePicker != nil {
            self.present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    func presentCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker?.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            showAlert(msg: NSLocalizedString("title.PhotoVC.NoSupportForCamera", comment: ""))
            return
        }
        
        if imagePicker != nil {
            self.present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
