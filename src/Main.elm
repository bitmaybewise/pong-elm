module Main exposing (main)

import Html exposing (..)
import Styles

type Status = Stoped | Running | GameOver

type Msg = Change Status

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
  }

model : Model
model = 
  { status = Stoped
  , score = 0
  , ball = 
    { speed = 5
    , x = 135
    , y = 100
    , directionX = -1
    , directionY = -1
    }
  }

update msg model = 
  case msg of
    Change newStatus ->  { model | status = newStatus } 

view model = 
  body [ Styles.body ] 
  [ header [] [ h1 [] [text "Pong"] ]
  , div [ Styles.score ] 
    [ text "Score: " 
    , span [] [text "0"] 
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
  beginnerProgram 
  { model = model
  , view = view
  , update = update 
  }
  