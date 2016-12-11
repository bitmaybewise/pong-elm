module Styles exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)

body : Attribute msg
body = style
  [ ("font-family", "sans-serif") ]

score : Attribute msg
score = style
  [ ("font-size", "1.5em")
  , ("margin-bottom", "1%") 
  ]

playground : Attribute msg
playground = style
  [ ("background", "black")
  , ("width", "300px")
  , ("height", "400px")
  , ("position", "relative")
  , ("overflow", "hidden")
  ]

messages : Attribute msg
messages = style
  [ ("color", "yellow")
  , ("position", "absolute")
  , ("top", "50%")
  , ("left", "23%")
  , ("text-align", "center")
  , ("font-weight", "bold") 
  ]

gameOver : Attribute msg
gameOver = style
  [ ("display", "none") ]

ball : Attribute msg
ball = style
  [ ("background", "yellow")
  , ("position", "absolute")
  , ("width", "30px")
  , ("height", "30px")
  , ("left", "135px")
  , ("top", "100px")
  , ("border-radius", "15px")
  ]

racket : Attribute msg
racket = style
  [ ("background", "yellow")
  , ("left", "110px")
  , ("top", "360px")
  , ("position", "absolute")
  , ("width", "80px")
  , ("height", "20px")
  ]
