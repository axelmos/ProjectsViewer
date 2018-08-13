//
//  ViewControllerDataSource.swift
//  ProjectsViewer
//
//  Created by Axel Mosiejko on 05/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell") as! ProjectTableViewCell
        cell.project = projects[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailVC = DetailViewController()
        detailVC.project = projects[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
