module Main exposing (main)

import Html exposing (..)
import Keyboard
import Time exposing (Time, every, inMilliseconds)
import Styles

type Status = Stopped | Running | GameOver

type Msg = KeyPressed Int
         | Tick Time

type alias Ball = 
  { speed: Int
  , x: Int
  , y: Int
  , directionX: Int
  , directionY: Int
  }

type alias Model = 
  { status: Status
  , score: Int
  , ball: Ball
  , key: Int
  , time: Time
  }

initialModel : Model
initialModel = 
  { status = Stopped
  , score = 0
  , ball = 
    { speed = 5
    , x = 135
    , y = 100
    , directionX = -1
    , directionY = -1
    }
  , key = 0
  , time = 0
  }

init : (Model, Cmd Msg)
init = (initialModel, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Sub.batch 
  [ Keyboard.downs (\n -> KeyPressed n)
  , every (inMilliseconds 60) Tick
  ]

-- function moveBallDirectionX(playgroundHTML, ball) {
--   var width = playgroundHTML.offsetWidth, directionX = ball.directionX;
--   var positionX = nextPosition(ball.x, ball.speed, ball.directionX);
--   if(positionX > width) { directionX = -1; }
--   if(positionX < 0) { directionX = 1; }
--   return directionX;
-- }

nextPosition : Int -> Int -> Int -> Int
nextPosition currentPos speed direction = currentPos + speed * direction

moveBallDirectionX : Ball -> Ball
moveBallDirectionX ball =
  let positionX = nextPosition ball.x ball.speed ball.directionX
  in ball

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    KeyPressed n ->
      let newModel = { model
                     | status = Running
                     , key = n
                     } 
      in (newModel, Cmd.none)
    Tick time ->
      let newBall = moveBallDirectionX model.ball
          newModel = { model 
                     | time = time
                     , ball = newBall
                     }
      in (newModel, Cmd.none) 

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
  beforeStart
  
view : Model -> Html Msg
view model = 
  body [ Styles.body ] 
  [ header [] [ h1 [] [text "Pong"] ]
  , div [ Styles.score ] 
      [ text "Score: " 
      , span [] [text (toString model.score)]
      , br [] []
      , text (toString model) 
      ]
  , div [ Styles.playground ]
      [ info model 
      , div [ Styles.ball ] []
      , div [ Styles.racket ] []
      ]
  ]

main = 
  program 
  { view = view
  , update = update
  , init = init
  , subscriptions = subscriptions 
  }
  