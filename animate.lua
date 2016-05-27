-- animate.lua
-- a module for animating stuff with optional quadratic easing

local module = {}

module.easing = {}

function module.easing.none(x)
	return x
end

function module.easing.easeIn(x)
	-- quadratic easing in
	return x^2/1
end

function module.easing.easeOut(x)
	-- quadratic easing out
	return 1-((1-x)^2/1)
end

function module.easing.easeInOut(x)
	-- quadratic easing in and out
	return x<0.5 and x^2/0.5 or 1-((1-x)^2/0.5)
end

local animation = {}

function animation:at(t)
	-- gets the value of the animation at the current time (t) of the animation's duration.
	if t < 0 then return self.from elseif t > self.duration then return self.to end
	return self.from + self.method(t / self.duration) * (self.to - self.from)
end

function animation:now()
	-- gets the current value of the animation using the system clock
	return self:at(os.clock() - self.start)
end

function animation:done()
	-- checks whether the animation is done or not
	return os.clock() - self.start >= self.duration
end

function module.new(from, to, method, duration)
	-- creates a new animation
	local anim = {}
	anim.from = from
	anim.to = to
	anim.method = method
	anim.duration = duration
	anim.start = os.clock()
	return setmetatable(anim, {__index = animation, __call = animation.now})
end

return module
