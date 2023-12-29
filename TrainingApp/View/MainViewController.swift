import OSLog
import UIKit
import YumemiWeather

class MainViewController: UIViewController {
    @IBOutlet private var weatherImageView: UIImageView!
    @IBOutlet private var minTemeratureView: UILabel!
    @IBOutlet private var maxTemeratureView: UILabel!

    private func setWeather(info: WeatherService.WeatherInfo) {
        minTemeratureView.text = "\(info.min_temperature)"
        maxTemeratureView.text = "\(info.max_temperature)"

        switch info.weather_condition {
        case .sunny:
            weatherImageView.image = UIImage(resource: .sunny)
            weatherImageView.tintColor = .red
        case .cloudy:
            weatherImageView.image = UIImage(resource: .cloudy)
            weatherImageView.tintColor = .gray
        case .rainy:
            weatherImageView.image = UIImage(resource: .rainy)
            weatherImageView.tintColor = .blue
        }
    }

    private func reload() {
        let req = WeatherService.GetWeatherListRequest(areas: ["Tokyo"], date: Date.now)
        switch (Result { try WeatherService().getWeatherList(req: req) }) {
        case .success(let weatherList):
            let weather = weatherList.first!
            Logger().debug("Area: \(weather.area), Date: \(weather.info.date), Condition: \(weather.info.weather_condition.rawValue), Temperature: \(weather.info.min_temperature) C - \(weather.info.max_temperature) C")
            setWeather(info: weather.info)

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

    @IBAction func onReloadButtonClick() {
        reload()
    }
}
