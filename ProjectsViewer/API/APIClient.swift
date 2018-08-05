//
//  APIClient.swift
//  ProjectsViewer
//
//  Created by Axel Mosiejko on 04/08/2018.
//  Copyright © 2018 Axel Mosiejko. All rights reserved.
//

import Foundation
import Alamofire

typealias DictionaryErrorResponse = ([String: AnyObject]?, Error?) -> Void
typealias StringResponse = (String?) -> Void

class APIClient: NSObject {
    static let sharedInstance = APIClient()
    private let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func getAllProjects( completionHandler:@escaping DictionaryErrorResponse, errorHandler:@escaping StringResponse) {
        
        var requestURLString = "https://yat.teamwork.com/"
        requestURLString.append("projects.json")
        
        Alamofire.request(requestURLString, method: .get)
            .authenticate(user: "twp_k9ejP88LcuojHjmFkUFuYIUNYalg", password: "x")
            .responseJSON {  [weak self ] response in
            if let dataOK = response.data {
                do {
                    guard let dictionary = try JSONSerialization.jsonObject(with: dataOK, options: .mutableContainers) as? [String: AnyObject] else {
                        errorHandler("An error occurrred parsing the response.")
                        return
                    }
                    completionHandler(dictionary, response.result.error)
                    
                } catch {
                    errorHandler("An error occurrred parsing the response.")
                }
            }
            else{
                errorHandler(self?.getMessageError(response: response.response, data: nil))
            }
        }
    }
    
    
    func getMessageError(response: URLResponse?, data:Data?) -> String {
        
        guard let _ = response else {
            return("Check your internet connection")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return("Invalid data")
        }
        
        let statusCode = httpResponse.statusCode
        
        guard statusCode == 200 else {
            return("Invalid Response: \(statusCode)")
        }
        
        guard data != nil else {
            return("Error obtaining data")
        }
        
        return "Unexpected error"
    }
    
    
}
