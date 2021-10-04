//
//  BookmarkViewController.swift
//  GSAssignment
//
//  Created by Siddhant Mishra on 04/10/21.
//

import UIKit

class BookmarkViewController: UIViewController {
    
    @IBOutlet weak var bookMarkListView: UITableView!
    var imagesGrid = [ImageModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookMarkListView.register(UINib(nibName: "BookmarkImageCell", bundle: nil), forCellReuseIdentifier: "BookmarkImageCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        imagesGrid = PersistenceMangaer.getFavImages(key: Constants.bookmarkedItems)
        self.bookMarkListView.reloadData()
    }
    
    func navigateToDetailScreenWithDetail(imageDetail:ImageModel){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        detailVC.imageDetail = imageDetail
        self.navigationController?.pushViewController(detailVC, animated: true);
    }
}

extension BookmarkViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return imagesGrid.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkImageCell", for: indexPath) as! BookmarkImageCell
        cell.imageData = imagesGrid[indexPath.section]
        cell.setShadow(applyShadow: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailScreenWithDetail(imageDetail: imagesGrid[indexPath.section])
    }
}
