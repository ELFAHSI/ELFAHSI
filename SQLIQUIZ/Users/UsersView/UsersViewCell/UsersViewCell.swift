//
//  UsersViewCell.swift
//  SQLIQUIZ
//
//  Created by OUSSAMA BENNOUR EL FAHSI on 02/1/2023.
//

import UIKit

class UsersViewCell: UITableViewCell {

    static var identifier: String {
        get {
            "UsersViewCell"
        }
    }
    
    static func register() -> UINib {
        UINib(nibName: "UsersViewCell", bundle: nil)
    }
    
    //IBoutlets:
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var loaderindicator: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            // Set corner radius
            self.userView.layer.cornerRadius = 10
            self.userView.clipsToBounds = true

            self.profileImageView.backgroundColor = .red
            self.profileImageView.layer.cornerRadius = profileImageView.bounds.width / 2
            self.profileImageView.clipsToBounds = true
        }
    
    func setupCell(viewModel: UsersCellViewModel) {
        userView.isHidden = false
        loaderindicator.isHidden = true
        self.nameLabel.text = viewModel.fullName
        self.emailLable.text = viewModel.email
        self.profileImageView.loadFrom(URLAddress: viewModel.profilLink,indicator: indicator)
    }
    
    func showLoader(){
        userView.isHidden = true
        loaderindicator.isHidden = false
    }
}
