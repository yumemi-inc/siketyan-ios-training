import TrainingApp
import XCTest

class WeatherServiceTest: XCTestCase {
    func testGetWeatherList() {
        let service = WeatherService() { req in
            XCTAssertEqual(req, """
{"date":"2020-04-01T03:00:00Z","areas":["Tokyo"]}
""")

            return """
[
    {
        "area": "Tokyo",
        "info": {
            "max_temperature": 25,
            "date": "2020-04-01T12:00:00+09:00",
            "min_temperature": 7,
            "weather_condition": "cloudy"
        }
    }
]
"""
        }

        let jst = TimeZone(secondsFromGMT: 9 * 3600)
        let weatherList = try! service.getWeatherList(
            GetWeatherListRequest(
                areas: ["Tokyo"],
                date: Calendar(identifier: .gregorian).date(from: DateComponents(timeZone: jst, year: 2020, month: 4, day: 1, hour: 12))!
            )
        )

        XCTAssertEqual(1, weatherList.count)
        XCTAssertEqual("Tokyo", weatherList[0].area)
        XCTAssertEqual(7, weatherList[0].info.min_temperature)
        XCTAssertEqual(25, weatherList[0].info.max_temperature)
        XCTAssertEqual(.cloudy, weatherList[0].info.weather_condition)
        XCTAssertEqual(
            Calendar(identifier: .gregorian).date(from: DateComponents(timeZone: jst, year: 2020, month: 4, day: 1, hour: 12))!,
            weatherList[0].info.date
        )
    }
}
