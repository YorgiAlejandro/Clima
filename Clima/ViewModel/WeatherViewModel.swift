import Foundation

//JSON Url: http://api.openweathermap.org/data/2.5/weather?q=Barcelona&appid=69b4376555355a4b2aeb144680e23ce0&units=metric&lang=es
final class WeatherViewModel : ObservableObject {
    //Al ser un property al cambiar su valor se lo dice a la vista y esta se renderiz con los nuevos datos
    @Published var weatherResponseDataModel : WeatherResponseDataModel?
    func GetWeather (city: String) async{
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=69b4376555355a4b2aeb144680e23ce0&units=metric&lang=es")!
        
        do{
            async let (data, _) = try await URLSession.shared.data(from: url)
            let dataModel = try! await JSONDecoder().decode(WeatherResponseDataModel.self, from: data)
            //TODO: Quitar el print cuando finalice las pruebas
            print(dataModel)
            //Saltamos del hilo de la funcion al principal y le damos el valor de DataModel a el property
            DispatchQueue.main.async {
                self.weatherResponseDataModel = dataModel
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
        
    }
}
