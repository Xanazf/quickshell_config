// helper functions to manipulate colors
pragma Singleton

import QtQuick
import Quickshell

import "../io/"

Singleton {
  // Function to find the third color in a triadic color scheme
  function findTriadicColor(color1, color2) {
    // Convert colors to HSL
    let hsl1 = rgbToHsl(color1);
    let hsl2 = rgbToHsl(color2);

    // Determine the hue value of the third color
    // Triadic colors are 120° apart, so we need to find the missing value
    let hue1 = hsl1[0];
    let hue2 = hsl2[0];

    // Calculate the difference between the hues
    let diff = (hue2 - hue1 + 360) % 360;

    // If the difference is not 120°, then the third hue will be different
    let hue3;

    if (Math.abs(diff - 120) < 0.001) {
      // If the difference is already 120°, the third hue is 120° from the second
      hue3 = (hue2 + 120) % 360;
    } else {
      // Otherwise, find the missing angle in the triad
      hue3 = (hue1 + 240) % 360;

      // Check if this new angle matches the second color's hue
      if (Math.abs(hue3 - hue2) < 0.001) {
        // If so, try the other possibility
        hue3 = (hue1 + 120) % 360;
      }
    }

    // For simplicity, use the average saturation and lightness of the two input colors
    let saturation = (hsl1[1] + hsl2[1]) / 2;
    let lightness = (hsl1[2] + hsl2[2]) / 2;

    // Convert back to RGB
    return hslToRgb([hue3, saturation, lightness]);
  }

  // Helper function to convert QML color to RGB array
  function colorToRgb(color) {
    let r = Qt.colorEqual(color, "transparent") ? 0 : color.r * 255;
    let g = Qt.colorEqual(color, "transparent") ? 0 : color.g * 255;
    let b = Qt.colorEqual(color, "transparent") ? 0 : color.b * 255;
    return [r, g, b];
  }

  // Helper function to convert RGB array back to QML color
  function rgbToColor(rgb) {
    return Qt.rgba(rgb[0] / 255, rgb[1] / 255, rgb[2] / 255, 1.0);
  }

  // Helper function to convert RGB to HSL
  function rgbToHsl(color) {
    let rgb = colorToRgb(color);
    let r = rgb[0] / 255;
    let g = rgb[1] / 255;
    let b = rgb[2] / 255;

    let max = Math.max(r, g, b);
    let min = Math.min(r, g, b);
    let h, s, l = (max + min) / 2;

    if (max === min) {
      h = s = 0; // achromatic
    } else {
      let d = max - min;
      s = l > 0.5 ? d / (2 - max - min) : d / (max + min);

      switch (max) {
      case r:
        h = (g - b) / d + (g < b ? 6 : 0);
        break;
      case g:
        h = (b - r) / d + 2;
        break;
      case b:
        h = (r - g) / d + 4;
        break;
      }

      h = h * 60;
    }

    return [h, s, l];
  }

  // Helper function to convert HSL to RGB
  function hslToRgb(hsl) {
    let h = hsl[0];
    let s = hsl[1];
    let l = hsl[2];
    let r, g, b;

    function hue2rgb(p, q, t) {
      if (t < 0)
        t += 1;
      if (t > 1)
        t -= 1;
      if (t < 1 / 6)
        return p + (q - p) * 6 * t;
      if (t < 1 / 2)
        return q;
      if (t < 2 / 3)
        return p + (q - p) * (2 / 3 - t) * 6;
      return p;
    }

    if (s === 0) {
      r = g = b = l; // achromatic
    } else {
      let q = l < 0.5 ? l * (1 + s) : l + s - l * s;
      let p = 2 * l - q;

      r = hue2rgb(p, q, (h / 360 + 1 / 3) % 1);
      g = hue2rgb(p, q, (h / 360) % 1);
      b = hue2rgb(p, q, (h / 360 - 1 / 3 + 1) % 1);
    }

    return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
  }
}
