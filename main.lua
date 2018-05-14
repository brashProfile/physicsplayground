--[[
    Created by: Michael Blanchard 2018
    xyz
]]



function love.load()
    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}

    balls = {}

    paused = false
    fullscreen = true
    love.window.setTitle('Physics Playscape')
    love.window.setFullscreen(true, "desktop")

    world = love.physics.newWorld(0,100,true)  --world contains all relevant bodies/fixtures in physics simulation
   
    floorBody = love.physics.newBody(world, 0, 1440, 'static')          --this will be our floor bound
    floorShape = love.physics.newRectangleShape(2560,50)
    floorFixture = love.physics.newFixture(floorBody, floorShape)

    ballBody = love.physics.newBody(world, 2560/2, 1440/2,'dynamic')      
    ballShape = love.physics.newCircleShape(100)
    ballFixture =love.physics.newFixture(ballBody,ballShape,0.5)
    ballFixture:setRestitution(0.9)                                --give ball some bounce
end

function love.update(dt)
    world:update(dt)

    if love.mouse.wasPressed('l') then
        ballBody = love.physics.newBody(world, love.mouse.getX(), love.mouse.getY(),'dynamic')      
        ballShape = love.physics.newCircleShape(100)
        ballFixture =love.physics.newFixture(ballBody,ballShape,0.5)
        ballFixture:setRestitution(0.9)
        table.insert(balls, ballFixture)
    end

    love.keyboard.keysPressed = {}  
    love.mouse.keysPressed ={}
    love.mouse.keysReleased = {}
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end


function love.mousepressed(x, y, key)   
    love.mouse.keysPressed[key] = true    
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end



function love.draw()
    xa, ya = floorBody:getPosition()
    xb, yb = ballBody:getPosition()
    love.graphics.rectangle('line', xa, ya - 20, 2560,50)
    love.graphics.circle('line',xb,yb,100)

    for k, fixture in pairs(balls) do 
        x, y = fixture:getBody():getPosition()
        love.graphics.circle('line', x, y, 100)
    end
end