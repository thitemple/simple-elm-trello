module Model exposing (Model, initialModel)

import Types exposing (Board)


type alias Model =
    { boards : List Board }


initialModel : Model
initialModel =
    { boards = [] }
