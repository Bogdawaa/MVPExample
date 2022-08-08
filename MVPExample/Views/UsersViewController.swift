//
//  ViewController.swift
//  MVPExample
//
//  Created by Bogdan Fartdinov on 04.08.2022.
//

import UIKit

class UsersViewController: UIViewController {

    private let tableview: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private let presenter = UserPresenter()
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        
        view.addSubview(tableview)
        tableview.delegate = self
        tableview.dataSource = self
        
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }

    
    override func viewDidLayoutSubviews() {
        tableview.frame = view.bounds
    }

}


extension UsersViewController: UITableViewDelegate, UITableViewDataSource, UserPresenterDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapUser(user: users[indexPath.row])
    }
    
    func presentUsers(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}
