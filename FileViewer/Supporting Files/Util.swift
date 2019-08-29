//
//  Util.swift
//  FileViewer
//
//  Created by Himanshu on 28/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import PDFKit
class Util{
    static func getVideoThumnail(fromUrl : URL)->UIImage?{
        let asset: AVAsset = AVAsset(url: fromUrl)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try imageGenerator.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
        return nil
    }
    
    static func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
        guard let data = try? Data(contentsOf: url),
            let page = PDFDocument(data: data)?.page(at: 0) else {
                return nil
        }
        
        let pageSize = page.bounds(for: .mediaBox)
        let pdfScale = width / pageSize.width
        
        // Apply if you're displaying the thumbnail on screen
        let scale = UIScreen.main.scale * pdfScale
        let screenSize = CGSize(width: pageSize.width * scale,
                                height: pageSize.height * scale)
        
        return page.thumbnail(of: screenSize, for: .mediaBox)
    }
    static func getDocThumbnail()->UIImage?{
        if let docImage = Bundle.main.url(forResource: "doc_thumbnmail", withExtension: "jpg", subdirectory: nil, localization: nil){
            do{
                let imgData = try Data.init(contentsOf: docImage)
                if let img = UIImage.init(data: imgData){
                    return img
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
    return nil
    }
}
