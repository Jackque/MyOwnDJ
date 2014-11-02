scriptId = 'com.myfirstscript'

unlocked=true;
printE=false;
printQ=false;

function onPoseEdge(pose, edge)
    myo.debug("onPoseEdge: " .. pose .. ", " .. edge)
	if edge=="on" and unlocked==true then
		if pose=="fist" then
			myo.keyboard("s", "press")
			unlocked=false
		end
		if pose=="fingersSpread" then
			myo.keyboard("w", "press")
			unlocked=false
		end
		if pose=="thumbToPinky" then
			myo.keyboard("d", "press")
			unlocked=false
		end
	end
	if edge == "off" then
		unlocked=true
	end
	if pose=="waveOut" and edge=="on" then
		printE=true
	end
	if pose=="waveIn" and edge=="on" then
		printQ=true
	end
	if (pose=="waveOut" and edge=="off") or (pose=="waveIn" and edge=="off") then
		printE=false
		printQ=false
	end
end

function onPeriodic()
	if printE == true then
		myo.keyboard("e","press")
	end
	if printQ == true then
		myo.keyboard("q","press")
	end
end

function onForegroundWindowChange(app, title)
    myo.debug("onForegroundWindowChange: " .. app .. ", " .. title)
    return true
end

function activeAppName()
    return "Output Everything"
end

function onActiveChange(isActive)
    myo.debug("onActiveChange")
end