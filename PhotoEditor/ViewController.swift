//
//  ViewController.swift
//  PhotoEditor
//
//  Created by Xinwen Liu on 10/22/19.
//  Copyright © 2019 Xinwen Liu. All rights reserved.
//

import UIKit
import PhotoEditorSDK

class ViewController: UIViewController, PhotoEditViewControllerDelegate {
  func photoEditViewController(_ photoEditViewController: PhotoEditViewController, didSave image: UIImage, and data: Data) {
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil)
    return
  }
  
  func photoEditViewControllerDidFailToGeneratePhoto(_ photoEditViewController: PhotoEditViewController) {
    return
  }
  
  func photoEditViewControllerDidCancel(_ photoEditViewController: PhotoEditViewController) {
    return
  }
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  @IBAction func startPhotoEditor(_ sender: Any) {
    let cameraViewController = CameraViewController()
    cameraViewController.dataCompletionBlock = { [unowned cameraViewController] data in
      guard let data = data else {
        return
      }

      let photo = Photo(data: data)
      let photoEditViewController = PhotoEditViewController(photoAsset: photo)
      photoEditViewController.delegate = self as! PhotoEditViewControllerDelegate

      cameraViewController.present(photoEditViewController, animated: true, completion: nil)
    }

    cameraViewController.completionBlock = { image, _ in
      guard let image = image else {
        return
      }

      let photo = Photo(image: image)
      let photoEditViewController = PhotoEditViewController(photoAsset: photo)
      photoEditViewController.delegate = self as! PhotoEditViewControllerDelegate

      cameraViewController.present(photoEditViewController, animated: true, completion: nil)
    }

    present(cameraViewController, animated: true, completion: nil)
  }


}

