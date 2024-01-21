import Foundation

//Struct principal
struct WeatherResponseDataModel: Decodable {
    let name : String
    let weather: [WeatherDataModel]
    let main: TemperatureDataModel
    let timezone: Int
    let wind : Wind
    let sys: SunSystem
    
    enum Codingkeys: String, CodingKey{
        case name
        case main
        case weather
        case timezone
        case wind
        case sys
    }
}

//Struct de Weather (Clima cielo)
struct WeatherDataModel: Decodable {
    let main: String
    let description: String
    let iconURLString: String
    
    enum CodingKeys: String, CodingKey {
        case main
        case description
        case iconURLString = "icon"
    }
}

//Struct de main (temperatura)
struct TemperatureDataModel: Decodable {
    let currentTemperature: Double
    let minTemperature: Double
    let maxTemperature: Double
    let feelTemperature: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case feelTemperature = "feels_like"
        case humidity
    }
}

//Wind
struct Wind : Decodable{
    let speed: Double
    let deg: Int
    
    enum CodingKeys: String, CodingKey{
        case speed
        case deg
    }
}

//Sun time up and down
struct SunSystem : Decodable {
    let sunrise: Int
    let sunset: Int
}



//JSON Response
/*
 {"coord":{
    "lon":2.159,
    "lat":41.3888
    },
    "weather":[
        {
            "id":801,
            "main":"Clouds",
            "description":"algo de nubes",
            "icon":"02d"
        }
    ],
    "base":"stations",
    "main":{
        "temp":13.42,
        "feels_like":12.51,
        "temp_min":11.42,
        "temp_max":14.91,
        "pressure":1032,
        "humidity":65
    },
    "visibility":10000,
    "wind":{
        "speed":4.12,
        "deg":240
    },
    "clouds":{
        "all":20
    },
    "dt":1705850575,
    "sys":{
        "type":2,
        "id":18549,
        "country":"ES",
        "sunrise":1705821137,
        "sunset":1705855938
    },
    "timezone":3600,
    "id":3128760,
    "name":"Barcelona",
    "cod":200
 }
*/


