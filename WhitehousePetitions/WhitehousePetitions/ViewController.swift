//
//  ViewController.swift
//  WhitehousePetitions
//
//  Created by Павел Кай on 07.08.2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    
    var filterPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString: String
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(credits))
        
        let filterBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(filteredCases))
        
        let undoBtn = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(undo))
        
        navigationItem.leftBarButtonItems = [filterBtn, undoBtn]
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parce(json: data)
                filterPetitions = petitions
                return
            }
        }
        
        showError()
        
        
        title = "Petitions"
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterPetitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = filterPetitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func parce(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "Oppsy", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(ac, animated: true)
    }
    
    @objc func credits() {
        let ac = UIAlertController(title: "The data comes from the We The People API of the Whitehouse.", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc func filteredCases() {
        let ac = UIAlertController(title: "Enter filter for petitions", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else { return }
            submit(answer.lowercased())
            self?.tableView.reloadData()
        }
        ac.addAction(submitAction)
        
        present(ac, animated: true)
        
        func submit(_ answer: String) {
            filterPetitions.removeAll()
            for petition in petitions {
                if petition.title.lowercased().contains(answer) || petition.body.lowercased().contains(answer) {
                    filterPetitions.append(petition)
                }
            }
            tableView.reloadData()
            
        }
    }
    
    @objc func undo() {
        filterPetitions = petitions
        tableView.reloadData()
    }
    
    
}

