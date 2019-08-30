//
//  FileCollectionViewController.swift
//  FileViewer
//
//  Created by Himanshu on 28/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import UIKit



class FileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let reuseIdentifier = "fileCell"
    var fileCollectionModel = FileCollectionModel()
    var fileSelectionDelegate:FileSelectionListener?
    override func viewDidLoad() {
        super.viewDidLoad()
        fileCollectionModel.createDataSource()
        
        // Register cell classes
        collectionView.alwaysBounceVertical = true
        collectionView.clipsToBounds = true
        collectionView.showsHorizontalScrollIndicator = false
        self.collectionView!.register(FileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fileCollectionModel.getDataSourceCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? FileCell
        // Configure the cell
        cell?.contentView.backgroundColor = UIColor.darkGray
        cell?.file = fileCollectionModel.getItem(at: indexPath)
        cell?.configureCell()
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        fileSelectionDelegate?.fileSelected(file: fileCollectionModel.getItem(at: indexPath))
        
        
        if let detailViewController = fileSelectionDelegate as? DetailsViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }

    }
}
