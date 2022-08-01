//
//  HomeCollectionViewCell.swift
//  EmpApp
//
//  Created by Rahul Dubey on 7/30/22.
//

import UIKit
import Combine

final class HomeTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet var empName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var biography: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - Properties
    private var cancellable: AnyCancellable?

    // MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpCell()
    }

    // MARK: - View Configuration
    func configureListCell(with model: EmployeeElement) {
         setFullName(from: model)
         setTeam(from: model)
         setBiography(from: model)
         setEmailAddress(from: model)
         setImage(from: model)
     }
    
    // MARK: - Private Functions
    private func setUpCell() {
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 60
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = true
        iconImageView.layer.borderWidth = 3.0
        iconImageView.layer.shadowColor = UIColor.gray.cgColor
        iconImageView.layer.shadowRadius = 2.0
        iconImageView.layer.borderColor = UIColor.lightText.cgColor
    }
    
    private func setBiography(from model: EmployeeElement) {
        guard let biotext = model.biography else {
            return
        }
        let prefix: String = "Bio:"
        // Display Strings should be localized
        biography.text = "\(prefix) \(biotext)"
        
        biography.accessibilityLabel = "\(prefix)\(biotext)"
        biography.accessibilityIdentifier = "\(prefix)\(model.uuid)"
    }
    
    private func setTeam(from model: EmployeeElement) {
        guard let teamtext = model.team else {
            return
        }
        // Strings should be localized
        let prefix: String = "Team:"
        // Display Strings should be localized
        team.text = "\(prefix) \(teamtext)"
        
        team.accessibilityLabel = "\(prefix) \(teamtext)"
        team.accessibilityIdentifier = "\(prefix)\(model.uuid)"
    }
    
    private func setEmailAddress(from model: EmployeeElement) {
        let prefix: String = "Email:"
        // Display Strings should be localized
        email.text = "\(prefix) \(model.emailAddress)"
        
        email.accessibilityLabel = "\(prefix) \(model.emailAddress)"
        email.accessibilityIdentifier = "\(prefix)\(model.uuid)"
    }
    
    private func setFullName(from model: EmployeeElement) {
        let prefix: String = "Name:"
        // Display Strings should be localized
        empName.text = "\(model.fullName)"
        
        empName.accessibilityLabel = "\(prefix)\(model.fullName)"
        empName.accessibilityIdentifier = "\(prefix)\(model.uuid)"
    }
    
    private func setImage(from model: EmployeeElement) {
        guard let imageURL = model.photoURLSmall,
              let urlString = URL(string: imageURL) else {
            return
        }
        self.iconImageView.showLoading()
        let imageLoaderImage = ImageDownloadManager.shared.loadImage(from: urlString)
        let prefixImage: String = "Image:"
        cancellable = imageLoaderImage
                        .receive(on: DispatchQueue.main)
                        .sink { image in
                            self.iconImageView.image = image
                            self.iconImageView.stopLoading()
                            self.iconImageView.accessibilityIdentifier = "\(prefixImage)\(model.uuid)"
                        }
    }
}
