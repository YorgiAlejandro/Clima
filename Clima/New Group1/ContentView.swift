
import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationViewModel = LocationViewModel() //ubicacion
    @StateObject var weatherModel = WeatherViewModel()//Instancia de el ViewModel para usar en Task
    @State var city = "Cienfuegos"
    var body: some View{
        ZStack {
            ScrollView {
                VStack{
                    HStack {
                        Button {
                            if locationViewModel.userHasLocation {
                                let location = CLLocation(latitude: locationViewModel.userLocation.center.latitude, longitude: locationViewModel.userLocation.center.longitude)
                                locationViewModel.getCityName(from: location) { cityName in
                                    if let cityName = cityName {
                                        Task {
                                            await weatherModel.GetWeather(city: cityName)
                                            city = cityName
                                        }
                                    }
                                }
                            }
                        } label: {
                                Image(systemName: "location.square.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .opacity(locationViewModel.userHasLocation ? 1.0 : 0.3)
                        }
                        TextField(text: $city) {
                            Text("Inserte su ubicación")
                        }.textFieldStyle(.roundedBorder).background(Color.gray).frame(width: 250, height: 80)
                        Button {
                            Task {
                                await weatherModel.GetWeather(city: city)
                            }
                        } label: {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }//Finder
                    .padding(.bottom, 0)
                    Text(weatherModel.weatherModel.city)
                        .foregroundColor(.white)
                        .font(.system(size: 70, design: .serif))
                    Text(weatherModel.weatherModel.description)
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.bottom, 8)
                        
                    HStack {
                        AsyncImage(url: weatherModel.weatherModel.iconURL)
                        Text(weatherModel.weatherModel.currentTemperature)
                            .foregroundColor(.white)
                            .font(.system(size: 70, design: .serif))
                    }//HStack
                    .padding(.top, -10)
                    HStack{
                        Label(weatherModel.weatherModel.maxTemperature, systemImage: "thermometer.sun.fill")
                        Label(weatherModel.weatherModel.minTemperature, systemImage: "thermometer.snowflake")
                    }//HStack
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                    .padding(25)
                    .font(.title2)
                    Divider()//Divider
                        .foregroundColor(.white)
                    HStack{
                        Label(weatherModel.weatherModel.humidity, systemImage: "humidity.fill").padding(.trailing, 20)
                        Label(weatherModel.weatherModel.feels_like, systemImage: "thermometer").padding(.leading, 20)
                    }//HStack
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                    .padding(25)
                    .font(.title2)
                    HStack{
                        Label(weatherModel.weatherModel.speed, systemImage: "wind")
                        Label(weatherModel.weatherModel.deg, systemImage: "wind.circle")
                    }//HStack
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                    .padding(25)
                    .font(.title2)
                    HStack{
                        Label("\(weatherModel.weatherModel.sunrise, style: .time)", systemImage: "sunrise.fill")
                        Label("\(weatherModel.weatherModel.sunset, style: .time)", systemImage: "sunset.fill")
                    }//HStack
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(.white)
                    .padding(25)
                    .font(.title2)
                    Spacer()
                    
                }
                
                Text("Created with ♥️ by Yorgi'Soft")
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.top, 70)
            }//VStack
        }//ZStack
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        ).task {
            await weatherModel.GetWeather(city: city)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
