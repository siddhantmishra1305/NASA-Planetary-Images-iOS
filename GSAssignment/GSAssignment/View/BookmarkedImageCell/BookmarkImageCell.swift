//
//  BookmarkImageCell.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 04/10/21.
//

import UIKit

class BookmarkImageCell: UITableViewCell {
    @IBOutlet weak var bookmarkedImageView: UIImageView!
    @IBOutlet weak var imageTitle_lbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var imageData:ImageModel?{
        didSet{
            activityIndicator.startAnimating()
            imageTitle_lbl.text = imageData?.title
            bookmarkedImageView.imageFromServerURL(urlString: imageData?.hdurl ?? imageData?.url ?? "", placeHolder: nil) {[weak self] result in
                self?.activityIndicator.stopAnimating()
                if !result{
                    self?.bookmarkedImageView.image = UIImage(named: "exclamationmark.triangle")
                }
            }
        }
    }
}
