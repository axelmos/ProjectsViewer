//
//  DetailView.swift
//  ProjectsViewer
//
//  Created by Axel Mosiejko on 12/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import UIKit

class DetailView: UIView {

    var contentView: UIView!
    var bottomView: UIView!
    var topView: UIView!
    var dataView: UIView!
    var dataSubView: UIView!
    var lblCreatedDateTitle: UILabel!
    var lblModifiedDateTitle: UILabel!
    var lblCreatedDate: UILabel!
    var lblModifiedDate: UILabel!
    var imageView: UIImageView!
    var txtView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView = UIView()
        topView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 384))
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 240))
        dataView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 72))
        dataSubView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 72))
        lblCreatedDateTitle = UILabel(frame: CGRect(x: 0, y: 13, width: 105, height: 21))
        lblCreatedDate = UILabel(frame: CGRect(x: 0, y: 0, width: 105, height: 21))
        lblModifiedDateTitle = UILabel(frame: CGRect(x: 115, y: 13, width: 105, height: 21))
        lblModifiedDate = UILabel(frame: CGRect(x: 0, y: 0, width: 105, height: 21))
        
        bottomView = UIView(frame: CGRect(x: 20, y: 332, width: 375, height: 384))
        txtView = UITextView(frame: CGRect(x: 0, y: 0, width: 335, height: 251))
        
        self.addSubview(contentView)
        contentView.addSubview(topView)
        topView.addSubview(imageView)
        topView.addSubview(dataView)
        dataView.addSubview(dataSubView)
        dataSubView.addSubview(lblCreatedDateTitle)
        dataSubView.addSubview(lblCreatedDate)
        dataSubView.addSubview(lblModifiedDateTitle)
        dataSubView.addSubview(lblModifiedDate)
        contentView.addSubview(bottomView)
        bottomView.addSubview(txtView)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = UIColor.lightGray
        
        contentView.backgroundColor = UIColor.lightGray
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.backgroundColor = UIColor.lightGray
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        dataView.backgroundColor = UIColor.darkGray
        dataView.translatesAutoresizingMaskIntoConstraints = false
        
        dataSubView.backgroundColor = UIColor.darkGray
        dataSubView.translatesAutoresizingMaskIntoConstraints = false
        
        lblCreatedDateTitle.text = NSLocalizedString("CREATED", comment: "")
        lblCreatedDateTitle.textColor = UIColor.lightGray
        lblCreatedDateTitle.textAlignment = .center
        lblCreatedDateTitle.font = UIFont.systemFont(ofSize: 14)
        lblCreatedDateTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblCreatedDate.textColor = UIColor.white
        lblCreatedDate.textAlignment = .center
        lblCreatedDate.font = UIFont.boldSystemFont(ofSize: 17)
        lblCreatedDate.translatesAutoresizingMaskIntoConstraints = false
        
        lblModifiedDateTitle.text = NSLocalizedString("MODIFIED", comment: "")
        lblModifiedDateTitle.textColor = UIColor.lightGray
        lblModifiedDateTitle.textAlignment = .center
        lblModifiedDateTitle.font = UIFont.systemFont(ofSize: 14)
        lblModifiedDateTitle.translatesAutoresizingMaskIntoConstraints = false
        
        lblModifiedDate.textColor = UIColor.white
        lblModifiedDate.textAlignment = .center
        lblModifiedDate.font = UIFont.boldSystemFont(ofSize: 17)
        lblModifiedDate.translatesAutoresizingMaskIntoConstraints = false
        
        bottomView.backgroundColor = UIColor.white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.clipsToBounds = true
        txtView.clipsToBounds = true
        
    }
    
    func setupConstraints(navBarHeight: CGFloat) {
        
        // CONTENT VIEW
        
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: navBarHeight).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        // TOP VIEW (container for image and dark gray bar)
        
        topView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        
        if UIDevice.current.orientation == .portrait {
            // Portrait
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        } else {
            // Landscape
            topView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(self.frame.size.width/2)).isActive = true
        }
        
        // IMAGE VIEW
        
        imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        
        // DARK GRAY VIEW
        
        dataView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        dataView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        dataView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        if UIDevice.current.orientation == .portrait {
            // Portrait
            dataView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 240).isActive = true
        } else {
            // Landscape
            dataView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: dataView.topAnchor).isActive = true
        }
        
        // TOP VIEW HEIGHT
        if UIDevice.current.orientation == .portrait {
            // Portrait
            topView.heightAnchor.constraint(equalToConstant: (dataView.frame.size.height + imageView.frame.size.height)).isActive = true
        } else {
            // Landscape
            topView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: 0).isActive = true
        }
        
        // DARK GRAY INSIDE VIEW
        
        dataSubView.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        dataSubView.topAnchor.constraint(equalTo: dataView.topAnchor).isActive = true
        dataSubView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        dataSubView.leadingAnchor.constraint(equalTo: dataView.leadingAnchor).isActive = true
        dataSubView.trailingAnchor.constraint(equalTo: dataView.trailingAnchor).isActive = true
        
        // CREATED DATE LABELS
        
        lblCreatedDateTitle.leadingAnchor.constraint(equalTo: dataSubView.leadingAnchor).isActive = true
        lblCreatedDateTitle.topAnchor.constraint(equalTo: dataSubView.topAnchor, constant: 13).isActive = true
        lblCreatedDateTitle.widthAnchor.constraint(equalToConstant: (dataView.frame.size.width / 2)).isActive = true
        lblCreatedDateTitle.heightAnchor.constraint(equalToConstant: 21).isActive = true
        lblCreatedDate.leadingAnchor.constraint(equalTo: dataSubView.leadingAnchor).isActive = true
        lblCreatedDate.topAnchor.constraint(equalTo: lblCreatedDateTitle.bottomAnchor, constant: 4).isActive = true
        lblCreatedDate.widthAnchor.constraint(equalToConstant: (dataView.frame.size.width / 2)).isActive = true
        lblCreatedDate.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        // MODIFIED DATE LABELS
        
        lblModifiedDateTitle.leadingAnchor.constraint(equalTo: lblCreatedDateTitle.trailingAnchor).isActive = true
        lblModifiedDateTitle.topAnchor.constraint(equalTo: dataSubView.topAnchor, constant: 13).isActive = true
        lblModifiedDateTitle.widthAnchor.constraint(equalToConstant: (dataView.frame.size.width / 2)).isActive = true
        lblModifiedDateTitle.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        lblModifiedDate.leadingAnchor.constraint(equalTo: lblModifiedDateTitle.leadingAnchor).isActive = true
        lblModifiedDate.topAnchor.constraint(equalTo: lblModifiedDateTitle.bottomAnchor, constant: 4).isActive = true
        lblModifiedDate.widthAnchor.constraint(equalToConstant: (dataView.frame.size.width / 2)).isActive = true
        lblModifiedDate.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
       
        
        // BOTTOM VIEW WITH TEXTVIEW
        
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        if UIDevice.current.orientation == .portrait {
            // Portrait
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        } else {
            // Landscape
            bottomView.leadingAnchor.constraint(equalTo: topView.trailingAnchor, constant: 20).isActive = true
            bottomView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        }
        
        // TEXTVIEW
        
        txtView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        txtView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        txtView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        txtView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        
        DispatchQueue.main.async {
            self.setNeedsLayout()
        }
    }
}
