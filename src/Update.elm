module Update exposing (update)

import Model exposing (Model)
import Msgs exposing (Msg(..))
import Types exposing (CreateBoardState(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        CreatingBoard ->
            { model | createBoard = Creating } ! []
