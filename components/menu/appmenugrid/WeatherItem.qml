import QtQuick
import QtQuick.VectorImage

import "root:/"
import "root:/io"

Rectangle {
  id: root
  color: Qt.alpha("hotpink", 0.1)
  radius: Config.sizes.mainRadius
  property var weather: WeatherIO.weather
  property var currentWeather: WeatherIO.weather.current_weather
  property string wmo_0: "Clear"
  property string wmo_1_2_3: "Mainly Clear"
  property string wmo_45_48: "Fog"
  property string wmo_51_53_55: "Drizzle"
  property string wmo_56_57: "Freezing Drizzle"
  property string wmo_61_63_65: "Rain"
  property string wmo_66_67: "Freezing Rain"
  property string wmo_71_73_75: "Snowing"
  property string wmo_77: "Snow Grains"
  property string wmo_80_81_82: "Rain Shower"
  property string wmo_85_86: "Snow Shower"
  property string wmo_95: "Thunderstorm"
  property string wmo_96_99: "Superthunderstorm"
  VectorImage {
    id: weatherIcon
    height: parent.height - 15
    width: parent.height - 15
    anchors.verticalCenter: parent.verticalCenter
    preferredRendererType: VectorImage.CurveRenderer

    source: {
      let link;
      switch (currentWeather.weathercode) {
      case 0:
        {
          link = "root:/svg/weather/weather-sunny.svg";
          break;
        }
      case 1:
        {
          link = "root:/svg/weather/weather-partly-cloudy.svg";
          break;
        }
      case 2:
        {
          link = "root:/svg/weather/weather-partly-cloudy.svg";
          break;
        }
      case 3:
        {
          link = "root:/svg/weather/weather-partly-cloudy.svg";
          break;
        }
      case 45:
        {
          link = "root:/svg/weather/weather-fog.svg";
          break;
        }
      case (51 || 53 || 55):
        {
          link = "root:/svg/weather/weather-hazy.svg";
          break;
        }
      case (56 || 57):
        {
          link = "root:/svg/weather/weather-hazy.svg";
          break;
        }
      case 61:
        {
          link = "root:/svg/weather/weather-rain.svg";
          break;
        }
      case (66 || 67):
        {
          link = "root:/svg/weather/weather-rain.svg";
          break;
        }
      case 71:
        {
          link = "root:/svg/weather/weather-snowy.svg";
          break;
        }
      case 73:
        {
          link = "root:/svg/weather/weather-snowy-rainy.svg";
          break;
        }
      case 75:
        {
          link = "root:/svg/weather/weather-snowy-heavy.svg";
          break;
        }
      case (77):
        {
          link = "root:/svg/weather/weather-rain.svg";
          break;
        }
      case (80 || 81 || 82):
        {
          link = "root:/svg/weather/weather-rain.svg";
          break;
        }
      case (85 || 86):
        {
          link = "root:/svg/weather/weather-rain.svg";
          break;
        }
      case (95):
        {
          link = "root:/svg/weather/weather-rain.svg";
          break;
        }
      case (96 || 99):
        {
          link = "root:/svg/weather/weather-rain.svg";
          break;
        }
      }
      return link;
    }
  }
  Rectangle {
    id: weatherData
    width: root.width - weatherIcon.width - 15
    height: root.height - 15
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    color: "transparent"
    Text {
      antialiasing: true
      font.pixelSize: weatherData.height / 3
      topPadding: 5
      font.letterSpacing: 3
      property string temperature: root.weather.current_weather.temperature
      color: Number(temperature) > 15 ? Config.colors.yellow900 : "darkturquoise"
      text: `${Number(temperature) > 0 ? "+" : ""}${temperature}°C`
    }
    Text {
      id: cityText
      antialiasing: true
      font.pixelSize: weatherData.height / 5
      topPadding: weatherData.height / 3 + 10
      font.letterSpacing: 1
      color: Qt.lighter("dodgerblue", 1.2)
      text: "Kyiv"
    }
    Text {
      antialiasing: true
      font.pixelSize: 18
      anchors.top: cityText.bottom
      font.letterSpacing: 1
      color: Qt.alpha(Config.colors.fontcolor, 0.6)
      text: {
        let link;
        switch (root.currentWeather.weathercode) {
        case 0:
          link = root.wmo_0;
          break;
        case 1:
          link = root.wmo_1_2_3;
          break;
        case 2:
          link = root.wmo_1_2_3;
          break;
        case 3:
          link = root.wmo_1_2_3;
          break;
        case (45 || 48):
          link = root.wmo_45_48;
          break;
        case (51 || 53 || 55):
          link = root.wmo_51_53_55;
          break;
        case (56 || 57):
          link = root.wmo_56_57;
          break;
        case (61 || 63 || 65):
          link = root.wmo_61_63_65;
          break;
        case (66 || 67):
          link = root.wmo_66_67;
          break;
        case (71 || 73 || 75):
          link = root.wmo_71_73_75;
          break;
        case (77):
          link = root.wmo_77;
          break;
        case (80 || 81 || 82):
          link = root.wmo_80_81_82;
          break;
        case (85 || 86):
          link = root.wmo_85_86;
          break;
        case (95):
          link = root.wmo_95;
          break;
        case (96 || 99):
          link = root.wmo_96_99;
          break;
        default:
          link = "it's raining men";
          break;
        }
        return link;
      }
    }
    Row {
      Text {
        visible: false
        antialiasing: true
        color: Config.colors.fontcolor
        text: root.weather.current_weather.winddirection
      }
      Text {
        visible: false
        antialiasing: true
        color: Config.colors.fontcolor
        text: root.weather.current_weather.windspeed
      }
    }
  }
}
