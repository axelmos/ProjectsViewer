//
//  ProjectTableViewCell.swift
//  ProjectsViewer
//
//  Created by Axel Mosiejko on 05/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import UIKit
import SDWebImage

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var project: Project? {
        didSet {
            if let project = project {
                
                titleLabel.text = project.name
                
                if let url = URL.init(string: project.logo ?? "") {
                    logoView.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
