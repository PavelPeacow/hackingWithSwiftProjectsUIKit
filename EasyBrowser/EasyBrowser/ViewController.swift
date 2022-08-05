//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Павел Кай on 05.08.2022.
//

import UIKit
import WebKit

class ViewController: UITableViewController, WKNavigationDelegate {


    var websites = ["apple.com", "hackingwithswift.com"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
                        
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Site", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? SiteViewContoller {
            vc.selectedSiteURL = URL(string: "https://" + websites[indexPath.row])!
            vc.websites = websites
            
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
   
    
}

