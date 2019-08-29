//
//  FileCell.swift
//  FileViewer
//
//  Created by Himanshu on 28/08/19.
//  Copyright © 2019 Himanshu. All rights reserved.
//

import UIKit

class FileCell: UICollectionViewCell {
    var file:File?
    
    var thumbnailView:UIImageView = {
        let imageView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.clipsToBounds = true
        return imageView
    }()
    
    var playVideoIcon : UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "play_icon")
        return image
    }()
    
    var indicator:UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        //indicator.color = UIColor.darkGray
        return indicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("This method has not been implemented")
    }
    
    func setupViews(){
        self.contentView.addSubview(thumbnailView)
        thumbnailView.frame = self.contentView.frame
        thumbnailView.contentMode = ContentMode.scaleAspectFit
        thumbnailView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        thumbnailView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        thumbnailView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        thumbnailView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        //self.autoresizesSubviews = true
        self.contentView.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalToConstant: 32).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 32).isActive = true
        removePlayIcon()
    }
    
    func configureCell(){
        guard let file = self.file else {
            return
        }
        indicator.startAnimating()
        DispatchQueue.global().async {
            //Do some Back ground task
            var thumbnailImage : UIImage?
            switch file.fileType!{
            case .image :
                if let imageUrl = URL(string: file.filePath ?? ""){
                do{
                    let imageData = try Data.init(contentsOf: imageUrl)
                    if let image = UIImage.init(data: imageData){
                        thumbnailImage = image
                    }
                }
                catch{
                    print(error.localizedDescription)
                }
            }
            case .video:
                if let videoUrl = URL(string: file.filePath!){
                    if let videoThumImage = Util.getVideoThumnail(fromUrl: videoUrl){
                        thumbnailImage = videoThumImage
                        DispatchQueue.main.async {
                            self.addPlayIcon()
                        }
                    }
                }
                break
            case .doc:
                if let docThumb = Util.getDocThumbnail(){
                    thumbnailImage = docThumb
                }
                
            case .pdf:
                if let pdfUrl = URL(string: file.filePath!){
                    if let pdfThumb = Util.pdfThumbnail(url: pdfUrl){
                        thumbnailImage = pdfThumb
                    }
                }
                
            }
            DispatchQueue.main.async {
                //Update your cell here
                if let thmbImg = thumbnailImage{
                    self.thumbnailView.image = thmbImg
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    
    func addPlayIcon(){
        contentView.addSubview(playVideoIcon)
        playVideoIcon.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        playVideoIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        playVideoIcon.widthAnchor.constraint(equalToConstant: 32).isActive = true
        playVideoIcon.heightAnchor.constraint(equalToConstant: 32).isActive = true
        playVideoIcon.bringSubviewToFront(thumbnailView)
    }
    
    func removePlayIcon(){
        if playVideoIcon.isDescendant(of: self.contentView){
            playVideoIcon.removeFromSuperview()
        }
    }
    override func prepareForReuse() {
        thumbnailView.image = nil
        removePlayIcon()
    }
}
