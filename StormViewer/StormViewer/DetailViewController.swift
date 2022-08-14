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
    
    var viewCount: Int?
    
    lazy var labelViewCount: UILabel = {
        let labelViewCount = UILabel()
        labelViewCount.text = "View count \(viewCount ?? 0)"
        labelViewCount.translatesAutoresizingMaskIntoConstraints = false
        return labelViewCount
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(labelViewCount)
        
        if let selectedImage = selectedImage {
            imageView.image = UIImage(named: selectedImage)
        }
        
        title = "Picture \(selectedImageIndex ?? 0) of \(countImages ?? 0)"
        navigationItem.largeTitleDisplayMode = .never
        
        NSLayoutConstraint.activate([
            labelViewCount.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            labelViewCount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelViewCount.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
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
