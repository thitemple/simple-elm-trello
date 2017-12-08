module Model exposing (Model, initialModel)

import Types
    exposing
        ( Board
        , CreateBoardState(..)
        )


type alias Model =
    { boards : List Board
    , createBoard : CreateBoardState
    }


initialModel : Model
initialModel =
    { boards = [], createBoard = Create }
