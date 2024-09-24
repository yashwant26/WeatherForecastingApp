//
//  WeatherTableViewCell.swift
//  WeatherForecastDemo
//
//  Created by Naveen Negi on 14/09/23.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configureCell(weatherDetail: WeatherModel, indexPath: IndexPath){
        dayNameLabel.text = Utility.convertDateFormat(sourceDateString: weatherDetail.list[indexPath.row].dt_txt, sourceDateFormat: "yyyy-MM-dd HH:mm:ss", destinationFormat: "EE, h a")
        minTempLabel.text = "\(Utility.convertKelvinToCelsius(kelvin: weatherDetail.list[indexPath.row].main.temp_min))°"
        maxTempLabel.text = "\(Utility.convertKelvinToCelsius(kelvin: weatherDetail.list[indexPath.row].main.temp_max))°"
        weatherImageView.image = UIImage(named: "\(weatherDetail.list[indexPath.row].weather[0].main)")
    }
}
