//
//  ImageDetailViewController.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 04/10/21.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var masterView: UIView!
    
    var imageDetail : ImageModel!
    let imageViewModel = ImageViewModel()
    let imageDetailView = ImageDetailView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        imageDetailView.imageData = imageDetail
        imageDetailView.markAsFavBtn.addTarget(self, action: #selector(markAsFav(_:)), for: .touchUpInside)

        masterView.addSubview(imageDetailView)
        self.masterView.setShadow(applyShadow: true)
    }
   
    @objc func markAsFav(_ sender: UIButton?) {
        if imageViewModel.checkIfFav(imageDetail: imageDetail){
            imageDetailView.markAsFavBtn.setImage(UIImage(named: "heart"), for: .normal)
            imageViewModel.unMarkAsFav(imageDetail: imageDetail)
        }else{
            imageDetailView.markAsFavBtn.setImage(UIImage(named: "heart.fill"), for: .normal)
            imageViewModel.markFav(imageDetail: imageDetail)
        }
    }
}
