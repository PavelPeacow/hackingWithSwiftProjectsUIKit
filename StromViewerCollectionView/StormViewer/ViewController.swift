//
//  ViewController.swift
//  StormViewer
//
//  Created by Павел Кай on 03.08.2022.
//

import UIKit

class ViewController: UICollectionViewController {
    
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(loadImages), with: nil)
        collectionView.reloadData()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellImage", for: indexPath) as? CollectionViewCell
        cell?.label.text = pictures[indexPath.row]
        cell?.image.image = UIImage(named: pictures[indexPath.row])
        return cell!
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            vc.countImages = pictures.count
            vc.selectedImageIndex = indexPath.row + 1
            
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

}

