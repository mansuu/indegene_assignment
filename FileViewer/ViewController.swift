//
//  ViewController.swift
//  FileViewer
//
//  Created by Himanshu on 28/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var cellId = "fileCellId"
    var dataSource:[File]?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.green
        // Do any additional setup after loading the view.
        self.collectionView.register(FileCell.self, forCellWithReuseIdentifier: cellId)
        if  let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.estimatedItemSize = CGSize.init(width: collectionView.bounds.width, height: 50)
        }
        dataSource = []
        populateCollectionView()
    }
    func populateCollectionView(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.reloadData()

    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        if let count = dataSource?.count{
            return count
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FileCell
        cell.backgroundColor = UIColor.red
        return cell
    }


}

