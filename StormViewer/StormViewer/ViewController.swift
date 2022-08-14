//
//  ViewController.swift
//  StormViewer
//
//  Created by Павел Кай on 03.08.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()

    var count = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(loadImages), with: nil)
        tableView.reloadData()
        
        if let savedcount = UserDefaults.standard.object(forKey: "loh") as? [Int] {
            count = savedcount
        }
        
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            saveCountView(index: indexPath)
            
            vc.selectedImage = pictures[indexPath.row]
            vc.countImages = pictures.count
            vc.selectedImageIndex = indexPath.row + 1
            vc.viewCount = count[indexPath.item]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func loadImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        pictures.sort()
    }
    
    func saveCountView(index: IndexPath) {
        count[index.item] += 1
        UserDefaults.standard.set(count, forKey: "loh")
        let savedCount = UserDefaults.standard.object(forKey: "loh") as? [Int]
        print(savedCount!)
        
    }

}

