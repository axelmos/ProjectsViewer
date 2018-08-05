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
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailSegue"{
            let detailVC = segue.destination as! DetailViewController
            let indexPath = sender as! IndexPath
            detailVC.project = projects[indexPath.row]
        }
    }
}

