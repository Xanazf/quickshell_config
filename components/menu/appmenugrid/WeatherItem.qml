import QtQuick
import QtQuick.VectorImage

import qs.config
import qs.helpers.io

Rectangle {
  id: root
  color: Qt.alpha("hotpink", 0.1)
  radius: Config.sizes.mainRadius
  property var weather: WeatherIO.weather || null
  property var currentWeather: WeatherIO.weather?.current_weather || null
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
      if (root.currentWeather) {
        let link;
        switch (root.currentWeather.weathercode) {
        case 0:
          {
            link = "root:/assets/svg/weather/weather-sunny.svg";
            break;
          }
        case 1:
          {
            link = "root:/assets/svg/weather/weather-sunny-alert.svg";
            break;
          }
        case 2:
          {
            link = "root:/assets/svg/weather/weather-partly-cloudy.svg";
            break;
          }
        case 3:
          {
            link = "root:/assets/svg/weather/weather-partly-cloudy.svg";
            break;
          }
        case 45:
          {
            link = "root:/assets/svg/weather/weather-fog.svg";
            break;
          }
        case (51):
          {
            link = "root:/assets/svg/weather/weather-partly-rainy.svg";
            break;
          }
        case (53):
          {
            link = "root:/assets/svg/weather/weather-partly-snowy-rainy.svg";
            break;
          }
        case (55):
          {
            link = "root:/assets/svg/weather/weather-partly-snowy-rainy.svg";
            break;
          }
        case (56):
          {
            link = "root:/assets/svg/weather/weather-partly-snowy.svg";
            break;
          }
        case (57):
          {
            link = "root:/assets/svg/weather/weather-snowy.svg";
            break;
          }
        case 61:
          {
            link = "root:/assets/svg/weather/weather-rainy.svg";
            break;
          }
        case (66):
          {
            link = "root:/assets/svg/weather/weather-rainy.svg";
            break;
          }
        case (67):
          {
            link = "root:/assets/svg/weather/weather-snowy-rainy.svg";
            break;
          }
        case 71:
          {
            link = "root:/assets/svg/weather/weather-snowy.svg";
            break;
          }
        case 73:
          {
            link = "root:/assets/svg/weather/weather-snowy.svg";
            break;
          }
        case 75:
          {
            link = "root:/assets/svg/weather/weather-snowy.svg";
            break;
          }
        case (77):
          {
            link = "root:/assets/svg/weather/weather-hail.svg";
            break;
          }
        case (80):
          {
            link = "root:/assets/svg/weather/weather-pouring.svg";
            break;
          }
        case (81):
          {
            link = "root:/assets/svg/weather/weather-pouring.svg";
            break;
          }
        case (82):
          {
            link = "root:/assets/svg/weather/weather-lightning-rainy.svg";
            break;
          }
        case (85):
          {
            link = "root:/assets/svg/weather/weather-snowy-heavy.svg";
            break;
          }
        case (86):
          {
            link = "root:/assets/svg/weather/weather-snowy-heavy.svg";
            break;
          }
        case (95):
          {
            link = "root:/assets/svg/weather/weather-lightning.svg";
            break;
          }
        case (96):
          {
            link = "root:/assets/svg/weather/weather-lightning-rainy.svg";
            break;
          }
        case (99):
          {
            link = "root:/assets/svg/weather/weather-hurricane.svg";
            break;
          }
        }
        return link;
      }
      return "root:/assets/svg/weather/weather-sunny.svg";
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
      property string temperature: root.weather?.current_weather.temperature || "0"
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
        if (root.currentWeather) {
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
          case (45):
            link = root.wmo_45_48;
            break;
          case (48):
            link = root.wmo_45_48;
            break;
          case (51):
            link = root.wmo_51_53_55;
            break;
          case (53):
            link = root.wmo_51_53_55;
            break;
          case (55):
            link = root.wmo_51_53_55;
            break;
          case (56):
            link = root.wmo_56_57;
            break;
          case (57):
            link = root.wmo_56_57;
            break;
          case (61):
            link = root.wmo_61_63_65;
            break;
          case (63):
            link = root.wmo_61_63_65;
            break;
          case (65):
            link = root.wmo_61_63_65;
            break;
          case (66):
            link = root.wmo_66_67;
            break;
          case (67):
            link = root.wmo_66_67;
            break;
          case (71):
            link = root.wmo_71_73_75;
            break;
          case (73):
            link = root.wmo_71_73_75;
            break;
          case (75):
            link = root.wmo_71_73_75;
            break;
          case (77):
            link = root.wmo_77;
            break;
          case (80):
            link = root.wmo_80_81_82;
            break;
          case (81):
            link = root.wmo_80_81_82;
            break;
          case (82):
            link = root.wmo_80_81_82;
            break;
          case (85):
            link = root.wmo_85_86;
            break;
          case (86):
            link = root.wmo_85_86;
            break;
          case (95):
            link = root.wmo_95;
            break;
          case (96):
            link = root.wmo_96_99;
            break;
          case (99):
            link = root.wmo_96_99;
            break;
          default:
            link = "it's raining men";
            break;
          }
          return link;
        }
        return "it's raining men";
      }
    }
    Row {
      Text {
        visible: false
        antialiasing: true
        color: Config.colors.fontcolor
        text: root.weather?.current_weather.winddirection || ""
      }
      Text {
        visible: false
        antialiasing: true
        color: Config.colors.fontcolor
        text: root.weather?.current_weather.windspeed || ""
      }
    }
  }
}
