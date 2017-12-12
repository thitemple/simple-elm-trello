module Main exposing (..)

import Html
import Html.Lazy exposing (lazy)
import Model exposing (Model, initialModel)
import Msgs exposing (Msg)
import Types exposing (Board)
import Update exposing (update)
import View exposing (view)


main : Program ElmInitFlagsFromJS Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = lazy view
        , update = update
        , subscriptions = subscriptions
        }



-- TYPES


type alias ElmInitFlagsFromJS =
    { boards : List Board }



-- PORTS
-- MODEL


init : ElmInitFlagsFromJS -> ( Model, Cmd Msg )
init { boards } =
    initialModel boards ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
