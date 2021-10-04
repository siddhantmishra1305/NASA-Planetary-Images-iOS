//
//  GalleryCell.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 03/10/21.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImageView: UIImageView!
    @IBOutlet weak var date_lbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var cellData:ImageModel!{
        didSet{
            activityIndicator.startAnimating()
            date_lbl.text = cellData.date
            galleryImageView.imageFromServerURL(urlString: cellData.hdurl ?? cellData.url ?? "", placeHolder: nil) {[weak self] result in
                self?.activityIndicator.stopAnimating()
                if !result{
                    self?.galleryImageView.image = UIImage(named: "exclamationmark.triangle")
                }
            }
        }
    }
}
