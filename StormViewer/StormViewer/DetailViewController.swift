//
//  DetailViewController.swift
//  StormViewer
//
//  Created by Павел Кай on 03.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var countImages: Int?
    var selectedImageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedImage = selectedImage {
            imageView.image = UIImage(named: selectedImage)
        }
        
        title = "Picture \(selectedImageIndex ?? 0) of \(countImages ?? 0)"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }

}
