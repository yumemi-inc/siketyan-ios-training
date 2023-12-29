import Foundation
import OSLog
import YumemiWeather

class WeatherService {
    private var encoder: JSONEncoder = JSONEncoder()
    private var decoder: JSONDecoder = JSONDecoder()

    init() {
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }

    enum WeatherCondition: String, Decodable {
        case sunny = "sunny"
        case cloudy = "cloudy"
        case rainy = "rainy"
    }

    struct WeatherInfo: Decodable {
        var date: Date
        var weather_condition: WeatherCondition
        var max_temperature: Int
        var min_temperature: Int
    }

    struct Weather: Decodable {
        var area: String
        var info: WeatherInfo
    }

    typealias WeatherList = [Weather]

    struct GetWeatherListRequest: Encodable {
        var areas: [String]
        var date: Date
    }

    typealias GetWeatherListResponse = WeatherList

    func getWeatherList(req: GetWeatherListRequest) throws -> GetWeatherListResponse {
        let req = String(data: try encoder.encode(req), encoding: .utf8)!
        let res = try YumemiWeather.fetchWeatherList(req)
        return try decoder.decode(GetWeatherListResponse.self, from: res.data(using: .utf8)!)
    }
}
