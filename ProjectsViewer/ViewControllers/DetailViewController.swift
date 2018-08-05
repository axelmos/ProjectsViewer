//
//  DetailViewController.swift
//  ProjectsViewer
//
//  Created by Axel Mosiejko on 05/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var project: Project!
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var txtView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let _project = project {
            self.title = _project.name
            
            if let url = URL.init(string: _project.logo ?? "") {
                logoView.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            }
            
            txtView.text = _project.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
