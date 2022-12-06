import turtle as t ## Game creation

window = t.Screen() ## Main screen
window.title("Cuadrado") ## Title
window.bgcolor("black") 
window.setup(width=800, height=800)
window.tracer(0) ## Stops window from updating

gameState = True

padA = t.Turtle() ## Create Turtle Item
padA.speed(0) ## Speed of the object
padA.shape("square")
padA.color("red")
padA.shapesize(stretch_wid=2, stretch_len=2) ## Multiple the dimensions to strech
padA.penup() ## Prevent drawing while the object is being moved
padA.goto(0, 0) ## Move the object to this point at the start of the game.

def padA_up():
    y = padA.ycor() ## Getting the y coordinate of turtle object
    if y >= 250: ## The paddle has center of 40 pixels and window size is 300 pixels either direction
        return
    y += 40  ## Add 20 pixels to y
    padA.sety(y) ## Sets the y coordinate to 20 above

def padA_down():
    y = padA.ycor() ## Getting the y coordinate of turtle object
    if y <= -250: ## The paddle has center of 40 pixels and window size is 300 pixels either direction
        return
    y -= 40 ## Removes 20 pixels to y
    padA.sety(y) ## Sets the y coordinate to 20 below

def padA_left():
    x = padA.xcor() ## Getting the y coordinate of turtle object
    if x <= -250: ## The paddle has center of 40 pixels and window size is 300 pixels either direction
        return
    x -= 40 ## Removes 20 pixels to y
    padA.setx(x) ## Sets the y coordinate to 20 below

def padA_right():
    x = padA.xcor() ## Getting the y coordinate of turtle object
    if x >= 250: ## The paddle has center of 40 pixels and window size is 300 pixels either direction
        return
    x += 40 ## Removes 20 pixels to y
    padA.setx(x) ## Sets the y coordinate to 20 below

def exit():
    global gameState ## For the exit loop. Needs to be declared before
    gameState = not gameState ## Change the game state
    return gameState ## Function return

#Keybinding
window.listen()
window.onkeypress(padA_left, "Left") ## Left side Paddle UP
window.onkeypress(padA_right, "Right") ## Left down
window.onkeypress(padA_up, "Up") ## Right Up
window.onkeypress(padA_down, "Down") ## Right down
window.onkeypress(exit, "Escape") ## Exit Menu

while gameState: ## For the exit menu
        window.update()