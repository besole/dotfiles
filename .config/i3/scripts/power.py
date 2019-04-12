#!/usr/bin/python3

import dbus
import fontawesome
import re

def main():
  text = ""
  devices = getDevices()
  for device in devices:
    if not re.match('/org/freedesktop/UPower/devices/line_power_*', device):
      text += getDeviceString(device)
  print(text)

def getDevices():
  proxy = dbus.SystemBus().get_object('org.freedesktop.UPower', '/org/freedesktop/UPower')
  upower = dbus.Interface(proxy, 'org.freedesktop.UPower')
  return upower.EnumerateDevices()

def getDeviceString(device):
  proxy = dbus.SystemBus().get_object('org.freedesktop.UPower', device)
  propManager = dbus.Interface(proxy, 'org.freedesktop.DBus.Properties')
  percentage = propManager.Get('org.freedesktop.UPower.Device', 'Percentage')
  if percentage < 20:
      style = '<span color="#FF0000">%s</span>'
  else:
      style= '%s'
  return style % (getDeviceIcon(device) + getBatteryIcon(percentage) + ("  %i%%" % percentage))

def getBatteryIcon(percentage):
  if percentage > 75:
    icon = 'battery-full'
  elif percentage > 55:
    icon = 'battery-three-quarters'
  elif percentage > 35:
    icon = 'battery-half'
  elif percentage > 15:
    icon = 'battery-quarter'
  else:
    icon = 'battery-empty'
  return fontawesome.icons[icon]

def getDeviceIcon(device):
  prefix = '/org/freedesktop/UPower/devices/'
  icon = ""
  if re.match(prefix + "mouse", device):
    icon = fontawesome.icons['mouse-pointer']
  if re.match(prefix + "headphone", device):
    icon = fontawesome.icons['headphones']
  return icon

if __name__ == "__main__":
  main()

