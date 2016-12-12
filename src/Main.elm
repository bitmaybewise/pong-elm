module Main exposing (main)

import Html exposing (..)
import Keyboard
import Time exposing (Time, every, inMilliseconds)
import Styles

type Status = Stopped | Running | GameOver

type Msg = KeyPressed Int
         | KeyReleased Int
         | Tick Time

keyLeft : Int
keyLeft = 37

keyRight : Int
keyRight = 39

type alias Ball = 
  { speed: Int
  , x: Int
  , y: Int
  , directionX: Int
  , directionY: Int
  }

type alias Racket =
  { positionX: Int
  , positionY: Int
  , width: Int
  }

type alias Model = 
  { status: Status
  , score: Int
  , ball: Ball
  , racket: Racket
  , keyPressed: Int
  }

initialBall : Ball
initialBall =
  { speed = 5
  , x = 135
  , y = 100
  , directionX = -1
  , directionY = -1
  }

initialRacket : Racket
initialRacket =
  { positionX = 110
  , positionY = 360
  , width = 80
  }

initialModel : Model
initialModel = 
  { status = Stopped
  , score = 0
  , ball = initialBall 
  , racket = initialRacket
  , keyPressed = -1
  }

init : (Model, Cmd Msg)
init = (initialModel, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch 
  [ Keyboard.downs (\n -> KeyPressed n)
  , Keyboard.ups (\n -> KeyReleased n)
  , every (inMilliseconds 16) Tick
  ]

nextPosition : Int -> Int -> Int -> Int
nextPosition currentPos speed direction = currentPos + speed * direction

moveBallDirectionX : Ball -> Ball
moveBallDirectionX ball =
  let positionX = nextPosition ball.x ball.speed ball.directionX
      directionX = if positionX > Styles.playgroundWidth
                   then -1
                   else if positionX < 0
                   then 1
                   else ball.directionX
  in { ball | directionX = directionX }

moveBallDirectionY : Ball -> Ball
moveBallDirectionY ball =
  let positionY = nextPosition ball.y ball.speed ball.directionY
      directionY = if positionY > Styles.playgroundHeight
                   then -1
                   else if positionY < 0
                   then 1
                   else ball.directionY
  in { ball | directionY = directionY }

moveBallPositionX : Ball -> Ball
moveBallPositionX ball = 
  let positionX = ball.x + ball.speed * ball.directionX
  in { ball | x = positionX }

moveBallPositionY : Ball -> Ball
moveBallPositionY ball = 
  let positionY = ball.y + ball.speed * ball.directionY
  in { ball | y = positionY }

moveRacket : Racket -> Int -> Racket
moveRacket racket keyPressed =
  if keyPressed == keyLeft
  then { racket | positionX = racket.positionX - 5 }
  else if keyPressed == keyRight
  then { racket | positionX = racket.positionX + 5 }
  else racket

isRacketHit : Ball -> Racket -> Bool
isRacketHit ball racket =
  ball.x >= racket.positionX
  && ball.x <= (racket.positionX + racket.width)
  && ball.y >= racket.positionY

changeDirectionY : Ball -> Bool -> Ball
changeDirectionY ball hit =
  if hit
  then { ball | directionY = -1 }
  else ball

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    KeyPressed n ->
      let newModel = { model | status = Running, keyPressed = n } 
      in (newModel, Cmd.none)
    KeyReleased _ -> ({ model | keyPressed = 1 }, Cmd.none)
    Tick time ->
      let newBall = model.ball
                  |> moveBallDirectionX
                  >> moveBallDirectionY
                  >> moveBallPositionX
                  >> moveBallPositionY
          newRacket = moveRacket model.racket model.keyPressed
          isHit = isRacketHit newBall newRacket
          newScore = if isHit
                     then model.score + 1
                     else model.score
          ball = changeDirectionY newBall isHit
          newModel = { model 
                     | ball = ball
                     , racket = newRacket
                     , score = newScore
                     }
      in if model.status == Running 
         then (newModel, Cmd.none)
         else (model, Cmd.none) 

beforeStart :  Html Msg
beforeStart =
  div [ Styles.messages ]
  [ text "press any key to start"
  , br [] []
  , text "move left right" 
  ]

gameOver : Html Msg
gameOver =
  div [ Styles.messages ]
    [ text "game over"
    , br [] []
    , text "press F5 to play again"
    ]

info : Model -> Html Msg
info model =
  if model.status == Stopped
  then beforeStart
  else if model.status == GameOver
  then gameOver
  else div [] []
  
view : Model -> Html Msg
view model = 
  body [ Styles.body ] 
  [ header [] [ h1 [] [text "Pong"] ]
  , div [ Styles.score ] 
      [ text "Score: " 
      , span [] [text (toString model.score)]
      ]
  , div [ Styles.playground ]
      [ info model 
      , div [ Styles.ball model.ball.x model.ball.y ] []
      , div [ Styles.racket model.racket.positionX model.racket.positionY model.racket.width ] []
      ]
  ]

main = 
  program 
  { view = view
  , update = update
  , init = init
  , subscriptions = subscriptions 
  }
  