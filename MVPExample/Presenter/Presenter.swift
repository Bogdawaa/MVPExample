//
//  Presenter.swift
//  MVPExample
//
//  Created by Bogdan Fartdinov on 04.08.2022.
//

import Foundation
import UIKit

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

class UserPresenter {
    
    weak var delegate: PresenterDelegate?
    
    public func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let usersResponse = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(users: usersResponse)
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTapUser(user: User) {
        delegate?.presentAlert(title: user.name, message: "\(user.name) email: \(user.email), username: \(user.email)")
        
    }
}
