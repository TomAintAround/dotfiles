function arduino-eject --description="Compile and upload arduino file into Arduino and open the serial monitor"
	set file $argv[1]
	set usb $argv[2]
	set fqbn $argv[3]

	arduino-cli compile --fqbn $fqbn $file
	and arduino-cli upload -p $usb --fqbn $fqbn $file
	and arduino-cli monitor -p $usb --fqbn $fqbn
end
