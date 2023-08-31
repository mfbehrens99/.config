#!/bin/bash

# Source the configuration file
source ~/.config/scripts/hass_secrets.conf

APICall() {
  local command="$1"
  local entity="$2"
  curl -k -X POST -H "Authorization: Bearer $TOKEN" -d "{\"entity_id\": \"$entity\"}" "$API/$command" &>/dev/null
}

# Check for command-line arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <command> <entity>"
  exit 1
fi

command="$1"
entity="$2"

APICall "$command" "$entity"

# Usage examples
# APICall "services/light/toggle" "light.boxen"
# APICall "services/scene/turn_on" "scene.licht_aus"
