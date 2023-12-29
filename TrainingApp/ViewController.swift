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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onReloadButtonClick() {
        let weather = YumemiWeather.fetchWeatherCondition()

        Logger().info("\(weather)")

        switch weather {
        case "sunny":
            weatherImageView.image = #imageLiteral(resourceName: "Sunny")
            weatherImageView.tintColor = .red
        case "cloudy":
            weatherImageView.image = #imageLiteral(resourceName: "Cloudy")
            weatherImageView.tintColor = .gray
        case "rainy":
            weatherImageView.image = #imageLiteral(resourceName: "Rainy")
            weatherImageView.tintColor = .blue
        default:
            Logger().error("Unknown weather condition.")
        }
    }
}
