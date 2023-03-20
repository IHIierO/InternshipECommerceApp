//
//  ProfileViewViewModel.swift
//  InternshipECommerceApp
//
//  Created by Artem Vorobev on 17.03.2023.
//

import UIKit

protocol ProfileViewViewModelDelegate: AnyObject {
    func logOut()
}

final class ProfileViewViewModel: NSObject {
    
    private let profileMenuItems = ProfileMenuItems.allCases
    
    public weak var delegate: ProfileViewViewModelDelegate?
    
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ProfileViewViewModel: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileMenuTableViewCell.reuseID, for: indexPath) as? ProfileMenuTableViewCell else {
            fatalError()
        }
        cell.configure(with: profileMenuItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(profileMenuItems.count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if profileMenuItems[indexPath.row] == .logOut {
            self.delegate?.logOut()
        }
    }
}
