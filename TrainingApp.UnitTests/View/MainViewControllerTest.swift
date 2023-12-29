import XCTest

class MainViewControllerTest: XCTestCase {
    func testSetWeather() {
        let controller = MainViewController()

        controller.weatherImageView = UIImageView()
        controller.maxTemperatureView = UILabel()
        controller.minTemperatureView = UILabel()

        controller.setWeather(info: WeatherInfo(
            date: Date.now,
            weather_condition: .sunny,
            max_temperature: 20,
            min_temperature: 10
        ))

        XCTAssertEqual(UIImage(resource: .sunny), controller.weatherImageView.image)
        XCTAssertEqual("20", controller.maxTemperatureView.text)
        XCTAssertEqual("10", controller.minTemperatureView.text)

        controller.setWeather(info: WeatherInfo(
            date: Date.now,
            weather_condition: .cloudy,
            max_temperature: 10,
            min_temperature: -10
        ))

        XCTAssertEqual(UIImage(resource: .cloudy), controller.weatherImageView.image)
        XCTAssertEqual("10", controller.maxTemperatureView.text)
        XCTAssertEqual("-10", controller.minTemperatureView.text)

        controller.setWeather(info: WeatherInfo(
            date: Date.now,
            weather_condition: .rainy,
            max_temperature: -10,
            min_temperature: -20
        ))

        XCTAssertEqual(UIImage(resource: .rainy), controller.weatherImageView.image)
        XCTAssertEqual("-10", controller.maxTemperatureView.text)
        XCTAssertEqual("-20", controller.minTemperatureView.text)
    }
}
