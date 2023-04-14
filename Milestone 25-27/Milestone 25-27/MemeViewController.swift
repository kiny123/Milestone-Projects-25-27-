//
//  MemeViewController.swift
//  Milestone 25-27
//
//  Created by nikita on 14.04.2023.
//

import UIKit

class MemeViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: UIImage?
    var picture: UIImage?
    var topText: String = ""
    var bottomText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        if let imageToLoad = selectedImage {
            imageView.image  = imageToLoad
            
            picture = imageToLoad
            
        }
        createMemeFirst()
    }
    
    func createMemeFirst() {
        let ac = UIAlertController(title: "Type the text?", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: createMeme))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func createMemeSecond() {
        let ac = UIAlertController(title: "Write a text for the bottom of the image", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Ok", style: .default) { [self]_ in
            self.bottomText = ac.textFields?[0].text ?? ""
            createBottomMeme(text: bottomText)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func createMeme(action: UIAlertAction) {
        
        let ac = UIAlertController(title: "Write a text for the top of the image", message: nil, preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Ok", style: .default) { [self]_ in
            self.topText = ac.textFields?[0].text ?? ""
            createTopMeme(text: topText)
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    
    func createTopMeme(text: String) {
        let width = imageView.image?.size.width ?? 400
        let height = imageView.image?.size.height ?? 400
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 40), .backgroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
            
            let mouse = imageView.image
            mouse?.draw(at: CGPoint(x: 0, y: 0))
            
            let string = text
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: width * 0.01, y: height * 0.01, width: width, height: height), options: .usesLineFragmentOrigin, context: nil)
        }
        imageView.image = img
        
        createMemeSecond()
    }
    
    func createBottomMeme(text: String) {
        let width = imageView.image?.size.width ?? 512
        let height = imageView.image?.size.height ?? 512
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        
        let img = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 40), .backgroundColor: UIColor.white,
                .paragraphStyle: paragraphStyle
            ]
            
            let mouse = imageView.image
            mouse?.draw(at: CGPoint(x: 0, y: 0))
            
            let string = text
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            
            attributedString.draw(with: CGRect(x: width * 0.1, y: height * 0.8, width: width, height: height), options: .usesLineFragmentOrigin, context: nil)
        }
        imageView.image = img
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        var imageArray: [Any] = [image]
        if let imageText = selectedImage {
            imageArray.append(imageText)
        }
        
        let vc = UIActivityViewController(activityItems: imageArray, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
