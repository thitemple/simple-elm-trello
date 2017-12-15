module Main exposing (..)

import Html
import Html.Lazy exposing (lazy)
import Navigation exposing (Location)
import Page.Errored as Errored exposing (PageLoadError)
import Page.Home as Home
import Route exposing (Route)
import Types exposing (Board)


-- MODEL --


type Page
    = Blank
    | NotFound
    | Home Home.Model


type PageState
    = Loaded Page
    | TransitioningFrom Page


type alias ElmInitFlagsFromJS =
    { boards : List Board }


type alias Model =
    { pageState : PageState }


init : ElmInitFlagsFromJS -> Location -> ( Model, Cmd Msg )
init { boards } =
    initialModel boards ! []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE --


type Msg
    = SetRoute (Maybe Route)
    | HomeLoaded (Result PageLoadError Home.Model)



-- MAIN


main : Program ElmInitFlagsFromJS Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = lazy view
        , update = update
        , subscriptions = subscriptions
        }
