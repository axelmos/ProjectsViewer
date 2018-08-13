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
    
    var client: APIClient = APIClient.sharedInstance
    var projects = [Project]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectCell")
        
        if Utils.isConnectionAvailable() {
            getProjects ()
        } else {
            let alert = UIAlertController(title: "Connection Issue", message: "No internet connection", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func getProjects () {

        SVProgressHUD.show(withStatus: "Loading")
        
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
                            
                        } catch let error {
                            print("error parsing object: \(error)")
                        }
                    }
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
            }
            
        }) { (versionString:String?) in
            print(versionString!)
        }
    }
    
    
    @IBAction func addProject(_ sender: AnyObject) {
        
        let project = Project(title: txtProjectName.text ?? "Untitled project", desc: txtDescrip.text)
        client.addProject(project: project, completionHandler: { [weak self] (projects, error)  in
            if self == nil {
                return
            }
            // TODO: Handle response
            
            self?.addProjectView.isHidden = true
            self?.getProjects()
            
        }) { (versionString:String?) in
            print(versionString!)
            let alert = UIAlertController(title: "Error", message: "API Request error", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            self.addProjectView.isHidden = true
        }
    }
    
    @IBAction func openAddProject(_ sender: AnyObject) {
        addProjectView.isHidden = false
    }
    
    @IBAction func closeAddProject(_ sender: AnyObject) {
        addProjectView.isHidden = true
    }
}

