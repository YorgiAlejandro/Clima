import Foundation

struct WeatherModel {
    var city: String
    var weather: String
    var description: String
    var iconURL: URL?
    var currentTemperature: String
    var minTemperature: String
    var maxTemperature: String
    var humidity: String
    var feels_like: String
    var speed: String
    var deg: String
    var sunrise: Date
    var sunset: Date
    var timezone: Double
    
    //Modelo vacio para evitar opcionales
    static let empty: WeatherModel = .init(city: "Paris", weather: "No weather", description: "No description",
                                           iconURL: nil, currentTemperature: "0", minTemperature: "0", maxTemperature: "0", humidity: "0", feels_like: "0", speed: "0", deg: "0", sunrise: .now, sunset: .now, timezone: 0.0)
}
