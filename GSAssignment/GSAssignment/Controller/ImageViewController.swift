//
//  ViewController.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 02/10/21.
//

import UIKit
import CoreData

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageGrid: UICollectionView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let imageVM = ImageViewModel()
    var currentSelectedDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageGrid.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")
        datePicker.maximumDate = Date()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getImageForDay(date: Date())
    }
    
    func getImageForDay(date:Date){
        
        guard let startDate = date.startOfWeek?.toString(format: "yyyy-MM-dd") else{
            return
        }
        
        guard var endDate = date.endOfWeek?.toString(format: "yyyy-MM-dd") else{
            return
        }
        
        if date.endOfWeek! > Date(){
            endDate = Date().toString(format: "yyyy-MM-dd")!
        }
        
        imageVM.getImages(startDate: startDate, endDate: endDate) {[weak self] result, messsage in
            DispatchQueue.main.async {
                if result{
                    self?.imageGrid.reloadData()
                }
            }
        }
    }
    
    @IBAction func selectedDateAction(_ sender: Any) {
        let selectedDate = datePicker.date
        getImageForDay(date: selectedDate)
    }
    
}

extension ImageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageVM.galleryImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryCell
        cell.cellData  = self.imageVM.galleryImages[indexPath.row]
        cell.setShadow(applyShadow: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width - 30) / 2
        return CGSize(width: size, height: size + 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToDetailScreenWithDetail(imageDetail: self.imageVM.galleryImages[indexPath.row])
    }
    
    func navigateToDetailScreenWithDetail(imageDetail:ImageModel){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        detailVC.imageDetail = imageDetail
        self.navigationController?.pushViewController(detailVC, animated: true);
    }
}
