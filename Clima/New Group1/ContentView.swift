
import SwiftUI

struct ContentView: View {
    
    @StateObject var weatherViewModel = WeatherViewModel()//Instancia de el ViewModel para usar en Task
    
    var body: some View{
        ZStack {
            VStack{
                Text(weatherViewModel.weatherResponseDataModel?.name ?? "No city")
                    .foregroundColor(.white)
                    .font(.system(size: 70, design: .serif))
                Text(weatherViewModel.weatherResponseDataModel?.weather.first?.description ?? "No description")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(.bottom, 8)
                HStack {
                    if let iconURL = weatherViewModel.weatherResponseDataModel?.weather.first?.iconURLString,
                       let url = URL(string: "http://openweathermap.org/img/wn/\(iconURL)@2x.png"){
                        AsyncImage(url: url) { image in
                            image
                        } placeholder: {
                            ProgressView()
                        }

                    }
                    Text(String(format: "%.\(1)f", weatherViewModel.weatherResponseDataModel?.main.currentTemperature ?? 0.0))
                        .foregroundColor(.white)
                        .font(.system(size: 70, design: .serif))
                    Text("℃")
                        .foregroundColor(.white)
                        .font(.system(size: 70, design: .serif))
                }//HStack
                .padding(.top, -10)
                HStack{
                    Label("28 ℃", systemImage: "thermometer.sun.fill")
                    Label("18 ℃", systemImage: "thermometer.snowflake")
                }//HStack
                .symbolRenderingMode(.multicolor)
                .foregroundColor(.white)
                Divider()//Divider
                    .foregroundColor(.white)
                HStack{
                    Label("80 %", systemImage: "humidity.fill")
                    Label("18 ℃", systemImage: "thermometer")
                }//HStack
                .symbolRenderingMode(.multicolor)
                .foregroundColor(.white)
                .padding(20)
                HStack{
                    Label("2km/h", systemImage: "wind")
                    Label("245º", systemImage: "wind.circle")
                }//HStack
                .symbolRenderingMode(.multicolor)
                .foregroundColor(.white)
                .padding(20)
                HStack{
                    Label("6:45am", systemImage: "sunrise.fill")
                    Label("6:45pm", systemImage: "sunset.fill")
                }//HStack
                .symbolRenderingMode(.multicolor)
                .foregroundColor(.white)
                .padding(20)
                Spacer()
            }//VStack
        }//ZStack
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        ).task {
            await weatherViewModel.GetWeather(city: "Cienfuegos")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider{
    static var previews: some View{
        ContentView()
    }
}
