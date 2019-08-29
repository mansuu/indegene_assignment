//
//  File.swift
//  FileViewer
//
//  Created by Himanshu on 28/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import Foundation
class File{
    var fileType:FileType?
    var filePath:String?
    init(fileType:FileType, filePath:String) {
        self.fileType = fileType
        self.filePath = filePath
    }
}
enum FileType{
    case image
    case video
    case doc
    case pdf
}
