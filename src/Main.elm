module Main exposing (..)

import Html exposing (..)


type alias Model =
    String


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    "Hello from Elm" ! []


view : Model -> Html msg
view model =
    div [] [ text model ]


update : Msg -> Model -> ( Model, Cmd Msg )
update _ model =
    model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
