#/bin/bash
echo "Compress extract borders..."
time pbzip2 -f temp/*.geojson

echo "Upload extract..."
rclone --config="rclone.conf" copy extracts/ r2:extracts/

echo "Upload addresses..."
rclone --config="rclone.conf" copy addresses/      r2:addresses/
