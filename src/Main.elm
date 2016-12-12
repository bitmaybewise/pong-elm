module Main exposing (main)

import Html exposing (..)
import Keyboard
import Styles

type Status = Stoped | Running | GameOver

type Msg = KeyPressed Int

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
  }

initialModel : Model
initialModel = 
  { status = Stoped
  , score = 0
  , ball = 
    { speed = 5
    , x = 135
    , y = 100
    , directionX = -1
    , directionY = -1
    }
  , key = 0
  }

init : (Model, Cmd Msg)
init = (initialModel, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model = Keyboard.downs (\n -> KeyPressed n)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of
    KeyPressed n ->  ({ model | key = n }, Cmd.none) 

view : Model -> Html Msg
view model = 
  body [ Styles.body ] 
  [ header [] [ h1 [] [text "Pong"] ]
  , div [ Styles.score ] 
    [ text "Score: " 
    , span [] [text (toString model.score)]
    , br [] []
    , text (toString model.key) 
    ]
  , div [ Styles.playground ]
    [ div [ Styles.messages ]
      [ text "press any key to start"
      , br [] []
      , text "move left right" 
      ]
    -- , div [ Styles.messages, Styles.gameOver ]
    --   [ text "game over"
    --   , br [] []
    --   , text "press F5 to play again"
    --   ]
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
  