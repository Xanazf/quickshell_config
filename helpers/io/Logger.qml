// Logger helper
pragma Singleton

import QtQuick
import Quickshell

import "root:/components/datetime/"
import "root:/state"

Singleton {
  id: root

  property string date: {
    let datestring = Time.date;
    let timestring = Time.syshours + ":" + Time.sysminutes + ":" + Time.sysseconds;
    let datetimestring = "[" + timestring + "|" + datestring + "]";
    return datetimestring;
  }
  property string host: {
    let user = StateMachine.username;
    let host = StateMachine.hostname;
    let userathost = user + "@" + host;
    return userathost;
  }

  property var log: message => {
    if (!StateMachine.dev)
      return;
    if (message) {
      console.info(date + " " + host + ": " + message);
    }
    return;
  }
  property var biglog: lines => {
    if (!StateMachine.dev) {
      return;
    }
    console.warn("====== " + date + " " + host + " ======");
    lines.map((line, index) => {
      console.info("[" + index + "] " + line);
    });
    console.warn("====== " + "BIGLOG ENDED" + " ======");
    return;
  }
  property var i_w: (status, s_message, f_message) => {
    if (!StateMachine.dev)
      return;
    if (status === 0) {
      console.info(date + " " + host + ": " + s_message);
    } else {
      console.warn(date + " " + host + ": " + f_message);
    }
    return;
  }
  property var i_e: (status, s_message, f_message) => {
    if (!StateMachine.dev)
      return;
    if (status === 0) {
      console.info(date + " " + host + ": " + s_message);
    } else {
      console.error(date + " " + host + ": " + f_message);
    }
    return;
  }
  property var d_w: (status, s_message, f_message) => {
    if (!StateMachine.dev)
      return;
    if (status === 0) {
      console.log(date + " " + host + ": " + s_message);
    } else {
      console.warn(date + " " + host + ": " + f_message);
    }
    return;
  }
  property var d_e: (status, s_message, f_message) => {
    if (!StateMachine.dev)
      return;
    if (status === 0) {
      console.log(date + " " + host + ": " + s_message);
    } else {
      console.error(date + " " + host + ": " + f_message);
    }
    return;
  }
}
