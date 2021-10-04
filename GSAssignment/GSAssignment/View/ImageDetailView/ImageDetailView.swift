//
//  ImageDetailView.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 04/10/21.
//

import UIKit

class ImageDetailView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var explanation_tv: UITextView!
    @IBOutlet weak var markAsFavBtn: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageData:ImageModel!{
        didSet{
            self.layer.cornerRadius = 10.0
            self.layer.masksToBounds = true
            
            title_lbl.text = imageData.title
            explanation_tv.text = imageData.explanation
            
            imageView.imageFromServerURL(urlString: imageData.hdurl ?? imageData.url ?? "", placeHolder: nil) {[weak self] result in
                self?.activityIndicator.stopAnimating()
                if !result{
                    self?.imageView.image = UIImage(named: "exclamationmark.triangle")
                }
            }
        }
    }
}
