import Foundation

extension JSONEncoder {
    func encodeToString<T>(_ value: T) throws -> String where T : Encodable {
        return String(data: try encode<T>(value), encoding: .utf8)!
    }
}

extension JSONDecoder {
    func decodeFromString<T>(_ type: T.Type, from str: String) throws -> T where T : Decodable {
        return try decode(type, from: str.data(using: .utf8)!)
    }
}
