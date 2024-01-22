import Foundation

struct WeatherModelMapper {
    func MapDataModelToModel (dataModel: WeatherResponseDataModel) ->WeatherModel {
        //Aqui comprobaremos que Weather tiene algun valor dentro del array sino devolvemos el modelo Empty
        guard let weather = dataModel.weather.first else {
            return .empty
        }
        let temperature = dataModel.main
        let wind = dataModel.wind
        let city = dataModel.name
        let timeZone = dataModel.timezone
        let sunsetWithTimeZone = Date(timeIntervalSince1970: dataModel.sys.sunset + dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        let sunriseWithTimeZone = Date(timeIntervalSince1970: dataModel.sys.sunrise + dataModel.timezone - Double(TimeZone.current.secondsFromGMT()))
        
        return WeatherModel(city: city, weather: weather.main, description: "(\(weather.description))", iconURL: URL(string: "https://openweathermap.org/img/wn/\(weather.iconURLString)@2x.png"), currentTemperature: "\(temperature.currentTemperature) ℃", minTemperature: "\(temperature.minTemperature) ℃ Min", maxTemperature: "\(temperature.maxTemperature) ℃ Max", humidity: "\(temperature.humidity) %", feels_like: "\(temperature.feelTemperature) ℃", speed: "\(wind.speed) km/h", deg: "\(wind.deg) grados", sunrise: sunriseWithTimeZone, sunset: sunsetWithTimeZone, timezone: timeZone)
    }
}
