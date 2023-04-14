//
//  ViewController.swift
//  Milestone 25-27
//
//  Created by nikita on 13.04.2023.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    var topText: String?
    var bottomText: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        
        
    }
    
    @objc func importPicture() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func setTopText(_ sender: Any) {
        let alertController = UIAlertController(title: "Top Text", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter top text"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.topText = alertController.textFields?[0].text
            self.renderMeme()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func setBottomText(_ sender: Any) {
        let alertController = UIAlertController(title: "Bottom Text", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter bottom text"
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.bottomText = alertController.textFields?[0].text
            self.renderMeme()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func renderMeme() {
        guard let image = imageView.image else { return }
        
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let memeImage = renderer.image { ctx in
            // Draw original image
            image.draw(at: CGPoint.zero)
            
            // Draw top text
            if let topText = topText {
                let textRect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height / 4)
                let textFont = UIFont(name: "Helvetica Bold", size: 36)!
                let textStyle = NSMutableParagraphStyle()
                textStyle.alignment = .center
                
                let textAttributes: [NSAttributedString.Key: Any] = [
                    .font: textFont,
                    .foregroundColor: UIColor.white,
                    .strokeColor: UIColor.black,
                    .strokeWidth: -3.0,
                    .paragraphStyle: textStyle
                ]
                
                topText.draw(in: textRect, withAttributes: textAttributes)
            }
            
            // Draw bottom text
            if let bottomText = bottomText {
                let textRect = CGRect(x: 0, y: image.size.height - image.size.height / 4, width: image.size.width, height: image.size.height / 4)
                let textFont = UIFont(name: "Helvetica Bold", size: 36)!
                let textStyle = NSMutableParagraphStyle()
                textStyle.alignment = .center
                
                let textAttributes: [NSAttributedString.Key: Any] = [
                    .font: textFont,
                    .foregroundColor: UIColor.white,
                    .strokeColor: UIColor.black,
                    .strokeWidth: -3.0,
                    .paragraphStyle: textStyle
                ]
                
                bottomText.draw(in: textRect, withAttributes: textAttributes)
            }
        }
        
        imageView.image = memeImage
    }
}

