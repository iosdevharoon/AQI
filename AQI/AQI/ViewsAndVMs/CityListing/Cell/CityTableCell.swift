//
//  CityTableCell.swift
//  AQI
//
//  Created by Mohammad Haroon on 19/06/21.
//

import UIKit

class CityTableCell: UITableViewCell {
    static let identitfier = "CityTableCell"
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var imgViewStatus: UIImageView!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblLastUpdateStatus: UILabel!
    @IBOutlet weak var lblLatestAQIValue: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    
    
    func configure(with city : City){
        self.lblCityName.text = city.name
        if let latestValue = city.aqi.last{
            let  valueStr = String(format: "%.2f", latestValue)
            self.lblLatestAQIValue.text = valueStr
            self.lblLatestAQIValue.textColor = latestValue.getTextColourForAQI()
            self.viewStatus.backgroundColor = latestValue.getColourForAQI()
            self.lblStatus.text = latestValue.getDesriptionOfAQI()
            self.imgViewStatus.image = latestValue.getImageForAQI()
            self.lblLastUpdateStatus.text = "Last updated : \(city.lastModificationTime.last?.getTimeDestription() ?? "Unknown")"
        } else{
            self.lblLatestAQIValue.text = "---.--"
            self.lblStatus.text = "Unknown"
            self.imgViewStatus.image = nil
            self.viewStatus.backgroundColor = UIColor.white
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
