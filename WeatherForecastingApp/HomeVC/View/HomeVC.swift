//
//  HomeVC.swift
//  WeatherForecastDemo
//
//  Created by Naveen Negi on 14/09/23.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var searchbar : UISearchBar!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabel : UILabel!
    @IBOutlet weak var temperatureLabel : UILabel!
    @IBOutlet weak var weatherTypeLabel : UILabel!
    @IBOutlet weak var minMaxTempLabel : UILabel!
    
    var searchbarWorkItem: DispatchWorkItem?
    private var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DependencyProvider.homeViewModel
        searchbar.delegate = self
        viewModel?.delegate = self
    }
    
    func resetUIData(){
        cityNameLabel.text = ""
        temperatureLabel.text = ""
        weatherTypeLabel.text = ""
        minMaxTempLabel.text = ""
        tableView.isHidden = true
    }
}


//MARK:- WeatherForecastDelegate method........
extension HomeVC: WeatherForecastDelegate, ShowsAlert{
    func didReceiveWeatherForecastDetails(weatherDetail: WeatherModel?,error:Error?) {
        self.activityIndicator.stopAnimating()
        if weatherDetail != nil && error == nil {
            cityNameLabel.text = weatherDetail?.city.name
            temperatureLabel.text = "\(Utility.convertKelvinToCelsius(kelvin: weatherDetail?.list[0].main.temp ?? 0.0))°"
            weatherTypeLabel.text = weatherDetail?.list[0].weather[0].main
            minMaxTempLabel.text = "High: \(Utility.convertKelvinToCelsius(kelvin: weatherDetail?.list[0].main.temp_min ?? 0.0))°   Low: \(Utility.convertKelvinToCelsius(kelvin: weatherDetail?.list[0].main.temp_max ?? 0.0))°   Humidity: \(weatherDetail?.list[0].main.humidity ?? 0)%"
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
            tableView.isHidden = false
        } else {
            resetUIData()
            self.showAlert(title: "Alert", message: "\(error?.localizedDescription ?? "Location not found")")
        }
    }
}

//MARK:- TableView Delegate and DataSource methods....
extension HomeVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.weatherModel?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(weatherDetail: (viewModel?.weatherModel)!,indexPath:indexPath)
        return cell
    }
}


//MARK:- UISearchBarDelegate method.....
extension HomeVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        searchbarWorkItem?.cancel()
        
        let newString = NSString(string: searchBar.text!).replacingCharacters(in: range, with: text)
        let workItem: DispatchWorkItem = DispatchWorkItem {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
            self.viewModel?.getWeatherforecastDetails(cityName: newString)
        }
        searchbarWorkItem = workItem
        DispatchQueue.global().asyncAfter(deadline: .now()+0.5, execute: workItem)
        return true
    }
}
