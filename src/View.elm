module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msgs exposing (Msg(..))
import Types exposing (CreateBoardState(..))


view : Model -> Html Msg
view model =
    div [] [ createBoardBox model.createBoard ]


createBoardBox : CreateBoardState -> Html Msg
createBoardBox createBoardState =
    case createBoardState of
        Create ->
            div []
                [ button [ class "button is-primary", onClick Msgs.CreatingBoard ]
                    [ text "create new board" ]
                ]

        Creating ->
            div [] [ text "creating" ]
