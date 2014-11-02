scriptId = 'com.myfirstscript'

unlocked=true;
printE=false;
printQ=false;
fistBumpActivate=false;

function wait(seconds)
  local start = myo.getTimeMilliseconds()
  repeat until myo.getTimeMilliseconds() > start + seconds
end

function onPoseEdge(pose, edge)
    myo.debug("onPoseEdge: " .. pose .. ", " .. edge)
	if edge=="on" and unlocked==true then
		if pose=="fist" and math.abs(myo.getPitch()) < 0.4 then
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
	if pose=="fist" and edge=="on" and fistBumpActivate==false and math.abs(myo.getPitch()) > 1 then
		fistBumpActivate=true
	end
	if pose=="rest" and fistBumpActivate==true and math.abs(myo.getPitch()) < 0.5 then
		fistBumpActivate=false
	end
end

function onPeriodic()
	if printE == true then
		myo.keyboard("e","press")
	end
	if printQ == true then
		myo.keyboard("q","press")
	end
	if fistBumpActivate==true then
		if math.abs(myo.getPitch()) > 0.6 and math.abs(myo.getPitch()) < 0.8 then
			myo.keyboard("f","press")
			wait(500)
		end
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
