import Foundation
import OSLog
import YumemiWeather

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

protocol IWeatherService {
    func getWeatherList(_ req: GetWeatherListRequest) throws -> GetWeatherListResponse
}

class WeatherService: IWeatherService {
    private var fetchWeatherList: ((String) throws -> String)
    private var encoder: JSONEncoder = JSONEncoder()
    private var decoder: JSONDecoder = JSONDecoder()

    init(_fetchWeatherList: @escaping ((String) throws -> String) = YumemiWeather.fetchWeatherList) {
        fetchWeatherList = _fetchWeatherList
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601
    }

    func getWeatherList(_ req: GetWeatherListRequest) throws -> GetWeatherListResponse {
        return try decoder.decodeFromString(
            GetWeatherListResponse.self,
            from: try fetchWeatherList(try encoder.encodeToString(req))
        )
    }
}
