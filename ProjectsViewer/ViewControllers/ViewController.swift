//
//  ViewController.swift
//  ProjectsViewer
//
//  Created by Axel Mosiejko on 04/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import UIKit
import SVProgressHUD

class ViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addProjectView: UIView!
    @IBOutlet weak var txtDescrip: UITextView!
    @IBOutlet weak var txtProjectName: UITextField!
    @IBOutlet weak var addProjViewCenterY: NSLayoutConstraint!
    
    var client: APIClient = APIClient.sharedInstance
    var projects:[Project]!
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
        
        if Utils.isConnectionAvailable() {
            getProjects ()
        } else {
            Utils.showAlert(title: "Connection Issue", message: "No internet connection", context: self)
        }
        
        // Refresh control
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(ViewController.handleRefresh), for: UIControlEvents.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Obtaining data...", attributes: nil)
        
        // Add shadow
        addProjectView.shadowView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func getProjects () {

        if !self.refreshControl.isRefreshing {
            SVProgressHUD.show(withStatus: "Loading")
        }
        projects = [Project]()
        
        client.getAllProjects(completionHandler: { [weak self] (projects, error)  in
            if self == nil {
                return
            }
            
            if let arr = projects?["projects"] {
                let array = (arr as! NSArray) as Array
                for item in array {
                    if let _item = item as? Dictionary<String, AnyObject> {
                        do {
                            let project = try Project(dict:_item)
                            self?.projects.append(project)
                            print(String(describing: project.name))
                            
                        } catch let error {
                            print("error parsing object: \(error)")
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    SVProgressHUD.dismiss()
                    self?.refreshControl.endRefreshing()
                }
            }
            
        }) { (error:String?) in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.refreshControl.endRefreshing()
            }
            Utils.showAlert(title: "Error", message: error ?? "", context: self)
        }
    }
    
    @objc func handleRefresh() {
        getProjects()
    }
    
    
    @IBAction func addProject(_ sender: AnyObject) {
        
        let project = Project(title: txtProjectName.text ?? "Untitled project", desc: txtDescrip.text)
        client.addProject(project: project, completionHandler: { [weak self] (response, error)  in
            if self == nil {
                return
            }
            if let status = response!["STATUS"] {
                if status as! String == "OK" {
                    self?.addProjectView.isHidden = true
                    self?.addProjViewCenterY.constant = -450
                    self?.getProjects()
                }
            }
            
        }) { (error:String?) in

            Utils.showAlert(title: "Error", message: error ?? "", context: self)
            
            self.addProjectView.isHidden = true
            self.addProjViewCenterY.constant = -450
        }
    }
    
    @IBAction func openAddProject(_ sender: AnyObject) {
        addProjectView.isHidden = false
        self.addProjectView.alpha = 1
        self.addProjViewCenterY.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func closeAddProject(_ sender: AnyObject) {
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.addProjectView.alpha = 0
        }, completion: { (animated) in
            self.addProjectView.isHidden = true
            self.addProjViewCenterY.constant = -450
        })
    }
}

