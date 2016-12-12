module Styles exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)

body : Attribute msg
body = style
  [ ("font-family", "sans-serif")
  , ("overflow-y", "hidden") 
  ]

score : Attribute msg
score = style
  [ ("font-size", "1.5em")
  , ("margin-bottom", "1%") 
  ]

playgroundWidth : Int
playgroundWidth = 300

playgroundHeight : Int
playgroundHeight = 400

playground : Attribute msg
playground = style
  [ ("background", "black")
  , ("width", (toString playgroundWidth) ++ "px")
  , ("height", (toString playgroundHeight) ++ "px")
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

ball : Int -> Int -> Attribute msg
ball left top = style
  [ ("background", "yellow")
  , ("position", "absolute")
  , ("width", "30px")
  , ("height", "30px")
  , ("left", (toString left) ++ "px")
  , ("top", (toString top) ++ "px")
  , ("border-radius", "15px")
  ]

racket : Int -> Int -> Int -> Attribute msg
racket left top width = style
  [ ("background", "yellow")
  , ("left", (toString left) ++ "px")
  , ("top", (toString top) ++ "px")
  , ("position", "absolute")
  , ("width", (toString width) ++ "px")
  , ("height", "20px")
  ]
