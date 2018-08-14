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
    var navBarH: CGFloat!
    var mainView: DetailView! { return self.view as! DetailView }
    
    override func loadView() {
        navBarH = (self.navigationController?.navigationBar.intrinsicContentSize.height)! + UIApplication.shared.statusBarFrame.height
        
        view = DetailView(frame: UIScreen.main.bounds)
        mainView.setupConstraints(navBarHeight: navBarH)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContent()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.
            
            if UIApplication.shared.statusBarOrientation == .portrait {
                // Portrait
                self.view = DetailView(frame: UIScreen.main.bounds)
                
                self.mainView.setupConstraints(navBarHeight: self.navBarH)
            } else {
                // Landscape
                self.view = DetailView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height - 30))
                
                self.mainView.setupConstraints(navBarHeight: self.navBarH - 30)
            }

            self.setContent()
        })
        
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    func setContent() {
        if let _project = project {
            self.title = _project.name
            
            if let url = URL.init(string: _project.logo ?? "") {
                mainView.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: ""))
            }
            
            if let createdDate = _project.startDate?.split(separator: "T") {
                mainView.lblCreatedDate.text = String(createdDate[0])
            }
            if let endDate = _project.endDate?.split(separator: "T") {
                mainView.lblModifiedDate.text = String(endDate[0])
            }
            
            mainView.txtView.text = _project.description
        }
    }
}
