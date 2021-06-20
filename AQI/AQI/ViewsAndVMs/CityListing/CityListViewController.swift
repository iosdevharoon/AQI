//
//  CityListViewController.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import UIKit

class CityListViewController: UIViewController {
    
    
    @IBOutlet weak var tblViewCities: UITableView! {
        didSet{
            self.tblViewCities.register(UINib(nibName: CityTableCell.identitfier, bundle: nil),
                                        forCellReuseIdentifier: CityTableCell.identitfier)
            self.tblViewCities.delegate = self
            self.tblViewCities.dataSource = self
            
        }
    }
    
    let viewModel = CityListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "City List"
        self.bindUIElements()
    }
    
    private func bindUIElements() {
        self.viewModel.hasCityDataFetched.bind { [weak self] (success) in
            
            guard let hasDataFetched = success else { return }
            
            if hasDataFetched {
                self?.tblViewCities.reloadData()
            }
        }
        
    }
    
    @IBAction func btnSeeAllinChartTapped(_ sender: UIButton) {
        let vc = UIStoryboard.getChartViewController(forCity: nil, existingCities: self.viewModel.getAllCities())
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnHistoryTapped(_ sender: UIButton) {
        let vc = UIStoryboard.getHistroyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension CityListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getNumberOfCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let city = self.viewModel.getCityAtIndex(index: indexPath.row) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identitfier, for: indexPath) as? CityTableCell{
                cell.configure(with: city)
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let city = self.viewModel.getCityAtIndex(index: indexPath.row) {
            let vc = UIStoryboard.getChartViewController(forCity: city.name, existingCities: self.viewModel.getAllCities())
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
