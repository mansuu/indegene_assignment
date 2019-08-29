//
//  FileCollectionModel.swift
//  FileViewer
//
//  Created by Himanshu on 28/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import Foundation
class FileCollectionModel {
    var dataSource = [File]()
    func createDataSource(){
        dataSource.append(File(fileType: FileType.image, filePath: "https://homepages.cae.wisc.edu/~ece533/images/airplane.png"))
        dataSource.append(File(fileType: FileType.video, filePath: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"))
        if let pdf = Bundle.main.url(forResource: "dummy", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let pdfPath = "\(pdf)"
            dataSource.append(File(fileType: FileType.pdf, filePath: pdfPath))
        }
        if let doc = Bundle.main.url(forResource: "file-sample", withExtension: "doc", subdirectory: nil, localization: nil)  {
            let docPath = "\(doc)"
            dataSource.append(File(fileType: FileType.doc, filePath: docPath))
        }        
    }
    func getDataSource()->[File]{
        return dataSource
    }
    func getDataSourceCount()->Int{
        return dataSource.count
    }
    
    func getItem(at indexpath: IndexPath) -> File {
        return dataSource[indexpath.row]
    }
}
