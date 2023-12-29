//
//  ViewController.swift
//  TrainingApp
//
//  Created by Naoki Ikeguchi on 2023/11/04.
//

import OSLog
import UIKit
import YumemiWeather

class ViewController: UIViewController {
    @IBOutlet private var weatherImageView: UIImageView!
    
    private func setWeather(weather: String) {
        switch weather {
        case "sunny":
            weatherImageView.image = UIImage(resource: .sunny)
            weatherImageView.tintColor = .red
        case "cloudy":
            weatherImageView.image = UIImage(resource: .cloudy)
            weatherImageView.tintColor = .gray
        case "rainy":
            weatherImageView.image = UIImage(resource: .rainy)
            weatherImageView.tintColor = .blue
        default:
            Logger().error("Unknown weather condition.")
        }
    }
    
    private func reload() {
        switch (Result { try YumemiWeather.fetchWeatherCondition(at: "tokyo") }) {
        case .success(let weather):
            Logger().debug("\(weather)")
            setWeather(weather: weather)

        case .failure(let error):
            Logger().error("\(error)")

            let alert = UIAlertController(
                title: "Error",
                message: "An error occurred while fetching the weather condition.",
                preferredStyle: .alert
            )

            alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in self.reload() })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            present(alert, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onReloadButtonClick() {
        reload()
    }
}
