//
//  PetListViewController.swift
//  AsurionCodeExercise
//
//  Created by Goel, Shobit on 02/10/20.
//  Copyright © 2020 Goel, Shobit. All rights reserved.
//

import UIKit

class PetListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let configViewModel = ConfigViewModel()
    private let petViewModel = PetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: ChatCallTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: ChatCallTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: OfficeHoursTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: OfficeHoursTableViewCell.cellIdentifier)
        tableView.register(UINib(nibName: PetInfoTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: PetInfoTableViewCell.cellIdentifier)
        
        // Load config in view model
        configViewModel.loadConfig {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // Load pets in view model
        petViewModel.loadPets {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension PetListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let storyboard = UIStoryboard(name: "PetList", bundle: nil)
            let petDetailsVC = storyboard.instantiateViewController(withIdentifier: "PetDetailsViewController") as! PetDetailsViewController
            petDetailsVC.petContentURL = petViewModel.pets?.list[indexPath.row].contentURL
            self.navigationController?.pushViewController(petDetailsVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension PetListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var nRows = 0
        if section == 0 {
            if configViewModel.isChatEnabled == true || configViewModel.isCallEnabled == true {
                nRows = 1
            }
        } else if section == 1 {
            if configViewModel.workHours != nil {
                nRows = 1
            }
        } else {
            nRows = petViewModel.pets?.list.count ?? 0
        }
        return nRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ChatCallTableViewCell.cellIdentifier) as? ChatCallTableViewCell {
                
                cell.chatButton?.addTarget(self, action: #selector(chatButtonTapped(_:)), for: .touchUpInside)
                cell.callButton?.addTarget(self, action: #selector(callButtonTapped(_:)), for: .touchUpInside)
                
                if configViewModel.isChatEnabled == true && configViewModel.isCallEnabled == true {
                    // Do nothing
                } else if configViewModel.isChatEnabled == true {
                    cell.setPresentationStyle(.chat)
                } else if configViewModel.isCallEnabled == true {
                    cell.setPresentationStyle(.call)
                }
                return cell
            }
        } else if (indexPath.section == 1) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: OfficeHoursTableViewCell.cellIdentifier) as? OfficeHoursTableViewCell {
                cell.officeHoursLabel.text = configViewModel.workHours
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PetInfoTableViewCell.cellIdentifier) as? PetInfoTableViewCell {
                let placeholderImage = UIImage(systemName: "rectangle")!
                cell.petImageView.image = placeholderImage
                cell.petNameLabel.text = petViewModel.pets?.list[indexPath.row].title
                let imageURL = petViewModel.pets?.list[indexPath.row].imageURL
                let url = URL(string: imageURL!)
                if (url != nil) {
                    petViewModel.loadImages(url: url!) { (image) in
                        DispatchQueue.main.async {
                            let petInfoCell = tableView.cellForRow(at: indexPath) as? PetInfoTableViewCell
                            if (petInfoCell != nil) {
                                petInfoCell!.petImageView.image = image
                            }
                        }
                    }
                }
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension PetListViewController {
    
    private func showAlert() {
        let uialert =   UIAlertController(title: nil, message: configViewModel.callChatAlertMessage(), preferredStyle: .alert)
        uialert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(uialert, animated: true, completion: nil)
    }
    
    @objc func chatButtonTapped(_ sender: UIButton) {
        showAlert()
    }
    
    @objc func callButtonTapped(_ sender: UIButton) {
        showAlert()
    }
}
